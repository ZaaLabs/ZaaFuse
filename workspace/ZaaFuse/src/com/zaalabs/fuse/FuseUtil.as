package com.zaalabs.fuse
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.Endian;
	
	import mx.collections.ArrayList;
	
	import spark.primitives.Rect;

	public class FuseUtil
	{	
		public static function removeDuplicates(ary:ArrayList, field:String):void
		{
			for (var i:int=0; i < ary.length - 1; i++)
			{
				for (var j:int=i+1; j < ary.length; j++)
				{
					if (ary.getItemAt(i)[field] == ary.getItemAt(j)[field])
						ary.removeItemAt(j);
				}
			}
		}
		
		public static function keyOutColor(source:BitmapData, color:uint=0xFF00FF00):BitmapData
		{
			color |= 0xFF000000;  // Force the color to use 32-bit color
			
			// treshold will change the threshold color data to a new
		    // bitmapData color and returns the amount of pixels changed
			var rcSourceRect:Rectangle = new Rectangle(0, 0, source.width, source.height);
			var pDestPoint:Point = new Point();// default destination = 0,0
			var sOperation:String = "==";// comparison with threshold
			var iColor:uint = 0x00000000;// replacementcolor
			var iMask:uint = 0xFFFFFFFF;// maskamount
			var bCopySource:Boolean = true;
			
			var output:BitmapData = new BitmapData(source.width, source.height, true, 0xFFFF0000);
			output.copyPixels(source, new Rectangle(0, 0, source.width, source.height), new Point(0,0));
			
			var countColor:int = output.threshold
			(
					output,
					rcSourceRect,
					pDestPoint,
					sOperation,
					color,
					iColor,
					iMask,
					bCopySource
			);
			return output;
		}
	}
}