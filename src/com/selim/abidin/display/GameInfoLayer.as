package com.selim.abidin.display
{
	import com.greensock.TweenMax;
	import com.selim.abidin.GeometrikaBase;
	import com.selim.abidin.utils.Config;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	
	public class GameInfoLayer extends Sprite
	{
		private var bar:Image;
		private var scoreLabel:TextField;
		private var bar_cont:Sprite;
		public function GameInfoLayer()
		{
			super();
			
			bar_cont = new Sprite();
			this.addChild(bar_cont);
			bar = new Image(GeometrikaBase.assetsManager.getTexture("scoreLayer"));
			bar_cont.addChild(bar);
			bar_cont.width = Config.stageWidth;
			bar_cont.scaleY = bar_cont.scaleX;
			bar_cont.y = -bar_cont.height;
			
			
			scoreLabel = new TextField(100, 25,"0000000", "Verdana",20);
			bar_cont.addChild(scoreLabel);
			scoreLabel.autoSize = TextFieldAutoSize.VERTICAL;
			//scoreLabel.border = true;
			
			this.touchGroup = true;
			this.touchable = false;
		}
		
		
		public function init():void
		{
			TweenMax.to(bar_cont,.8, {y:0});
		}
		
		
		private const numZero:Array = ["", "0", "00","000","0000","00000","000000","0000000"]; // faster
		public function setScore(score:String):void
		{
			scoreLabel.text = numZero[7 - score.length] + score;
		}
		
		
	}
}