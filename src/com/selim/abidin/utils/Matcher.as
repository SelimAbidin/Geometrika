package com.selim.abidin.utils
{
	import com.selim.abidin.Geometrika;
	import com.selim.abidin.display.IMatchable;
	import com.selim.abidin.display.IUpdatable;
	import com.selim.abidin.display.enemies.Enemy;
	import com.selim.abidin.display.enemies.IEnemy;
	import com.selim.abidin.display.fires.types.Fire;
	
	import flash.display.Sprite;

	public class Matcher implements IUpdatable
	{
		private var goodSide:Vector.<Vector.<Fire>> = new Vector.<Vector.<Fire>>();
		private var badSide:Vector.<Vector.<IEnemy>> = new Vector.<Vector.<IEnemy>>();
		public function Matcher()
		{
			//Geometrika.st.addChild(sp);
		}
		
		
		public function addGoodSide(v:Vector.<Fire>):void
		{
			goodSide.push(v);
		}
		
		
		
		private var temp:Vector.<Fire>;
		private var btemp:Vector.<IEnemy>;
		public function update():void
		{
			for (var i:int = 0; i < goodSide.length; i++) 
			{
				temp = goodSide[i];
				
				for (var j:int = 0; j < temp.length; j++) 
				{
					if(temp[j].isValid)
					{
						searchInEnemies(temp[j], false);

					}
										
				}
			}
			
		//	trace("Matcher->update");
			
		}
		
		public function searchInEnemies(fire:IMatchable, isHero:Boolean):Boolean
		{
			fireSearchEnemies : for (var k:int = 0; k < badSide.length; k++) 
			{
				btemp = badSide[k];
				
				fireSearchOneEnemy : for (var l:int = 0; l < btemp.length; l++) 
				{
					if(btemp[l].isShotable || isHero)
					{
						if(match(fire, btemp[l]))
						{
							return true;
						}
					}
				}
			}
			
			return false;
		}
		
		
		
		
		final public function match(good:IMatchable, bad:IEnemy):Boolean
		{
			var dx:Number = good.x - bad.x;
			var dy:Number = good.y - bad.y;
			var dist:Number = Math.sqrt((dx * dx)+(dy * dy));
			
			if(dist < bad.effectRange + good.effectRange)
			{
				bad.explode();
				good.explode();
				return true;
			}
			
			return false;
		}
		
		
		
		
		
		
		
		
		public function addBadSide(v:Vector.<IEnemy>):void
		{
			badSide.push(v);
		}
	}
}