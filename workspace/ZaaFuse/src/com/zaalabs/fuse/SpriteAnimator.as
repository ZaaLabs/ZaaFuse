package com.zaalabs.fuse
{
	import mx.collections.ArrayList;

	public class SpriteAnimator
	{
		protected var _fileList:ArrayList;
		
		public function SpriteAnimator()
		{
		}

		public function get fileList():ArrayList
		{
			return _fileList;
		}

		public function set fileList(value:ArrayList):void
		{
			_fileList = value;
		}

	}
}