package com.zaalabs.fuse 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import spark.primitives.BitmapImage;
	
	public class PreviewImage extends BitmapImage
	{
		private var _loader:Loader;
		private var _filename:String;
		private var _context:LoaderContext;
		
		public function PreviewImage()
		{
			super();
			_loader = new Loader();
			_context = new LoaderContext();
			_context.checkPolicyFile = true;
		}
		
		public function clear():void
		{
			_filename = null;
			source = null;
		}
		
		private function loadBMP():void
		{
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onBMPloaded );
			_loader.load( new URLRequest( filename ), _context );
		}
		
		private function onBMPloaded( e:Event ):void
		{
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onBMPloaded );
			source = _loader.content;
		}
		
		public function set filename(value:String):void
		{
			if( value == _filename ) {
				return;
			}
			_filename = value;
			loadBMP();
		} 
		
		public function get filename():String
		{
			return _filename;
		}
	}
}