package com.selim.abidin.display
{
	import com.selim.abidin.GeometrikaBase;
	import com.selim.abidin.display.object.MeteorQuad;
	import com.selim.abidin.display.object.SQuad;
	import com.selim.abidin.utils.Config;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	
	public class BackGround extends QuadBatch implements IUpdatable
	{
		private var image:Image;
		private var aliveBodies:Vector.<MeteorQuad> = new Vector.<MeteorQuad>();
		private var deadBodies:Vector.<MeteorQuad> = new Vector.<MeteorQuad>();
		public function BackGround()
		{
			image = new Image(GeometrikaBase.assetsManager.getTexture("kaya"));
			
			//image2 = new Image(GeometrikaBase.assetsManager.getTexture("kaya"));
		
			
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
			var squad:MeteorQuad;
			if(deadBodies.length > 0)
			{
				squad = deadBodies.splice(0,1)[0];
			}
			else
			{
				squad = new MeteorQuad();
			}
			aliveBodies.push(squad);
			resetSQuad(squad);
			return squad;
		}		
		
		private function resetSQuad(squad:MeteorQuad):void
		{
			squad.x = Config.stageWidth * Math.random();
			squad.y = -20;
			image.alpha = squad.scale =  (Math.random() * .3) + .3;
			squad.rotation = Math.random() * 360;
			squad.isValid = true;
		}
		
		
		public function update():void
		{
			this.reset();
			var squad:MeteorQuad;
			for (var i:uint = 0; i < aliveBodies.length; i++) 
			{
				squad = aliveBodies[i];
				squad.update();
				image.y = squad.y;
				image.x = squad.x;
				image.scaleX = image.scaleY = squad.scale;
				image.rotation = squad.rotation;
				image.alpha = squad.alpha;
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
			
			if(Math.random() < .07)
			{
				for (i = 0; i < 2; i++) 
				{
					createQuad();
				}
			}
			
			
		}
		
		
	}
}