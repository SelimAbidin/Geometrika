package com.selim.abidin.display
{
	import com.selim.abidin.GeometrikaBase;
	import com.selim.abidin.display.object.FlameQuad;
	import com.selim.abidin.display.object.MeteorQuad;
	import com.selim.abidin.display.object.SQuad;
	import com.selim.abidin.utils.Config;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	
	public class Flame extends QuadBatch implements IUpdatable
	{
		private var image:Image;
		private var aliveBodies:Vector.<FlameQuad> = new Vector.<FlameQuad>();
		private var deadBodies:Vector.<FlameQuad> = new Vector.<FlameQuad>();
		
		private var isEnabled:Boolean = true;
		private var _parent:Hero;
		public function Flame(prnt:Hero)
		{
			super();
			
			_parent = prnt;
			image = new Image(GeometrikaBase.assetsManager.getTexture("flame"));
			
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			for (var i:int = 0; i < 22; i++) 
			{
				var quad:SQuad = createQuad();
				quad.y  =Config.stageHeight * Math.random();
				image.x = quad.x;
				image.y = quad.y;
				image.alpha = image.scaleY = image.scaleX = quad.scale;
				image.rotation = quad.rotation;
				this.addImage(image);
			}
			
		}
		
		
		private function createQuad():SQuad
		{
			var squad:FlameQuad;
			if(deadBodies.length > 0)
			{
				squad = deadBodies.splice(0,1)[0];
			}
			else
			{
				squad = new FlameQuad();
			}
			aliveBodies.push(squad);
			resetSQuad(squad);
			return squad;
		}	
		
		
		private function resetSQuad(squad:FlameQuad):void
		{
			squad.x = 0;
			squad.y = 5;
			squad.scale = .25;
			squad.alpha = .7;
			squad.rotation = Math.random() * 360;
			squad.isValid = true;
		}
		
		
		public function update():void
		{
			
			var prntAlpha:Number = _parent.alpha * 1;
			this.reset();
			var squad:FlameQuad;
			for (var i:uint = 0; i < aliveBodies.length; i++) 
			{
				squad = aliveBodies[i];
				squad.update();
				image.y = squad.y;
				image.x = squad.x;
				image.scaleX = image.scaleY = squad.scale;
				image.rotation = squad.rotation;
				image.alpha = squad.alpha * prntAlpha;
				this.addImage(image);
				
				
			}
			
			for (i = 0; i < aliveBodies.length; i++) 
			{
				squad = aliveBodies[i];
				if(!squad.isValid)
				{
					deadBodies.push(aliveBodies.splice(i,1)[0]);					
				}
			}
			
			
			if(isEnabled)
			{
				var say:int = Math.round(Math.random() * 5);
				for (i = 0; i < say; i++) 
				{
					createQuad();
				}
			}
			
		}
		
		
		
		public function clear():void
		{
			this.reset();
			
			for (var i:int = 0; i < aliveBodies.length; i++) 
			{
				aliveBodies[i].isValid = false;
			}
			
			
		}
		
		
		
		public function stop():void
		{
			isEnabled = false;
		}
	}
}