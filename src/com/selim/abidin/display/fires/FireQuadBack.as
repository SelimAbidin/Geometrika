package com.selim.abidin.display.fires
{
	import com.selim.abidin.Geometrika;
	import com.selim.abidin.GeometrikaBase;
	import com.selim.abidin.display.Hero;
	import com.selim.abidin.display.IUpdatable;
	import com.selim.abidin.display.fires.types.ClassicFire;
	import com.selim.abidin.display.fires.types.Fire;
	import com.selim.abidin.display.object.SQuad;
	
	import flash.events.KeyboardEvent;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	
	public class FireQuadBack extends QuadBatch implements IUpdatable
	{
		private var image:Image;
		public var aliveBodies:Vector.<Fire> = new Vector.<Fire>();
		private var deadBodies:Vector.<Fire> = new Vector.<Fire>();
		private var hero:Hero;
		public function FireQuadBack(hero:Hero, scaleRatio:Number)
		{
			super();
			this.hero = hero;
			image = new Image(GeometrikaBase.assetsManager.getTexture("Classic"));
			
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			image.scaleX = image.scaleY = scaleRatio;
			
			
			//Geometrika.st.addEventListener(KeyboardEvent.KEY_DOWN, onK);
		}
		
		protected function onK(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			if(event.keyCode == 32)createQuad();
		}		
		
		private function createQuad():SQuad
		{
			var squad:Fire;
			if(deadBodies.length > 0)
			{
				squad = deadBodies.splice(0,1)[0];
			}
			else
			{
				squad = new ClassicFire();
			}
			aliveBodies.push(squad);
			resetSQuad(squad);
			return squad;
		}	
		
		
		private function resetSQuad(squad:Fire):void
		{
			squad.x = this.hero.x;
			squad.y = this.hero.y;
			squad.alpha = 1;
			squad.isValid = true;
		}
		
		
		private var fireCounter:uint = 0;
		private var isEnable:Boolean = true;
		public function update():void
		{
			this.reset();
			var squad:Fire;
			for (var i:uint = 0; i < aliveBodies.length; i++) 
			{
				squad = aliveBodies[i];
				squad.update();
				image.y = squad.y;
				image.x = squad.x;
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
			
			
			
			if(isEnable)
			{
				fireCounter++;
				if(fireCounter > 10)
				{
					createQuad();
					fireCounter = 0;
				}
			}
			
			
			
		}
		
		
		
		public function stop():void
		{
			isEnable = false;
		}
		
		
		public function play():void
		{
			isEnable = true;
		}
		
		
		
		
	}
}