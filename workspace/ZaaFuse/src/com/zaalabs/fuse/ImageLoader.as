package com.zaalabs.fuse
{
	import cmodule.zaail.CLibInit;
	
	import com.zaalabs.zaail.ZaaILInterface;
	
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	public class ImageLoader
	{
		public static const IMAGE_FILTER:FileFilter = new FileFilter("Images", "*.mp3;*.bmp;*.gif;*.tga;*.jpg;*.jpeg;*.png;");
		
		private static const _instance:ImageLoader = new ImageLoader( SingletonLock );
		
		public static function get instance():ImageLoader
		{
			return _instance;
		}
		
		public function ImageLoader( lock:Class )
		{
			if ( lock != SingletonLock )
			{
				throw new Error( "Invalid Singleton access.  Use ImageLoader.instance." );
			}
			
			loader = new CLibInit();
			lib = loader.init();
		}
		
		// ==============================================================================
		
		private var lib:Object;
		private var loader:CLibInit;
		
		private var _width:int;
		private var _height:int;
		
		public function loadImage(file:File):BitmapData
		{
			var fs:FileStream = new FileStream();
			var fileContents:ByteArray = new ByteArray();
			
			fs.open(file, FileMode.READ);
			fs.readBytes(fileContents);
			
			fs.close();
			
			var output:ByteArray = new ByteArray();
			loader.supplyFile(file.name, fileContents);
			
			lib.ilInit();
			lib.ilOriginFunc(ZaaILInterface.IL_ORIGIN_UPPER_LEFT);
			lib.ilEnable(ZaaILInterface.IL_ORIGIN_SET);
			
			// Load the image
			var result:int;
			result = lib.ilLoadImage(file.name);	
			if(result != 1)	// 1 success || 0 fail
			{
				trace("errorcode: "+lib.ilGetError());
			}
			
			_width = lib.ilGetInteger(ZaaILInterface.IL_IMAGE_WIDTH);
			_height = lib.ilGetInteger(ZaaILInterface.IL_IMAGE_HEIGHT);
			var depth:int = lib.ilGetInteger(ZaaILInterface.IL_IMAGE_DEPTH);
			lib.ilGetPixels(0, 0, 0, _width, _height, depth, output);
			output.position = 0;
			
			var bmd:BitmapData = new BitmapData(_width, _height);
			bmd.setPixels(new Rectangle(0, 0, _width, _height), output);
			
			return bmd;
		}

		public function get currentWidth():int
		{
			return _width;
		}

		public function get currentHeight():int
		{
			return _height;
		}

	}
}

class SingletonLock
{
}