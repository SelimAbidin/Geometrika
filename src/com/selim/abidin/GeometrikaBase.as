package com.selim.abidin
{
	import com.selim.abidin.display.Menu;
	import com.selim.abidin.utils.Config;
	
	import flash.display.Sprite;
	import flash.display3D.Context3DProfile;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.AssetManager;
	

	
	public class GeometrikaBase extends Sprite
	{
		public static var assetsManager:AssetManager;
		protected var _starling:Starling;
		private var menu:Menu;
		public function GeometrikaBase()
		{
			super();
			
			Geometrika.st = stage;
			Starling.multitouchEnabled = true;
			
			var viewport:Rectangle  =new Rectangle(0,0, stage.fullScreenWidth, stage.fullScreenHeight);
			_starling = new Starling(Geometrika,stage,viewport, null, "auto", Context3DProfile.BASELINE);
			
			//_starling.stage.color = 0xc7c7c7;
			
			
			_starling.stage.stageWidth = Config.stageWidth;
			_starling.stage.stageHeight = Config.stageHeight;
			_starling.enableErrorChecking = true;
			//_starling.showStats = true;
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, onStarlingCreated);
			
		}
		
		private function onStarlingCreated(evt:Event):void
		{
			_starling.start();
			requestAssets("menu");
		}
		
		
		
		public function start():void
		{
			
			(_starling.root as Geometrika).init();
			
		}
		
		
		
		protected function requestAssets(assetType:String):void
		{
			throw new Error('"requestAssets" function must be overrided');
		}
		
		
		
		
	}
}