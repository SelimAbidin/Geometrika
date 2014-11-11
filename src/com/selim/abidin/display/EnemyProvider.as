package com.selim.abidin.display
{
	import com.selim.abidin.GeometrikaBase;
	import com.selim.abidin.data.Level;
	import com.selim.abidin.display.enemies.BasicEnemyFire;
	import com.selim.abidin.display.enemies.DeltaWing;
	import com.selim.abidin.display.enemies.DeltaWingWithCannon;
	import com.selim.abidin.display.enemies.Enemy;
	import com.selim.abidin.display.enemies.IEnemy;
	import com.selim.abidin.display.enemies.SinusManeuverWing;
	import com.selim.abidin.utils.Config;
	
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.getDefinitionByName;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import avmplus.getQualifiedClassName;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.filters.GodRaysFilter;
	import starling.textures.Texture;
	
	public class EnemyProvider extends QuadBatch implements IUpdatable
	{
		private var image:Image;
		private var texture:Texture;
		private var queque:Array = [];
		private var enemies:Array = [DeltaWingWithCannon,DeltaWing, SinusManeuverWing, BasicEnemyFire];
		private var _deadBodies:Dictionary = new Dictionary();
		public var totalEnemies:Vector.<IEnemy> = new Vector.<IEnemy>();
		
		public var isEnemyCreateEnabled:Boolean = true;
		private var particleLayer:ParticleProvider;
		private var enemyExplodedCallBack:Function;
		public function EnemyProvider(mainTarget:Sprite,particleLayer:ParticleProvider, enemyExplodedCallBack:Function)
		{
			super();
			
			this.mainTarget = mainTarget;
			this.enemyExplodedCallBack = enemyExplodedCallBack;
			this.particleLayer = particleLayer;
			texture = GeometrikaBase.assetsManager.getTexture("enemy");
			
		}
		
		
		private var timer:Number = 0;
		public var nextEnemy:Number = 0;
		public var interval:int;
		public var mainTarget:Sprite;
		public function start():void
		{
			
			clearInterval(interval);
			
			interval = setInterval(createEnemy, 100);
		}
		
		private function createEnemy():void
		{
			
			if(!Level.levelMobs[0][nextEnemy])
			{
				nextEnemy = 0;
				timer = 0;
			}
			
			if(isEnemyCreateEnabled)
			{
			
				var enemyTemp:Number = nextEnemy;	
				var isRelased:Boolean = false;
				
				while(Level.levelMobs[0][enemyTemp])
				{
					isRelased = false;
					
					if(timer > Level.levelMobs[0][enemyTemp].time)
					{
						var cls:Class = enemies[Level.levelMobs[0][enemyTemp].enemy];
						var tween:int = Level.levelMobs[0][enemyTemp].tween;
						
						for (var i:int = 0; i < Level.levelMobs[0][enemyTemp].count; i++) 
						{
							var m:* = createMob(cls, Level.levelMobs[0][enemyTemp].param);
							m.x = Level.levelMobs[0][enemyTemp].x;
							queque.push({time:(i * tween)  + timer, obj:m});							
						}
						isRelased = true;
						enemyTemp++;
					}
					
					if(!isRelased)break;
				}
				nextEnemy = enemyTemp;
			}
			timer +=100;
			
			
			if(queque.length > 0)
			{
				for (var j:int = 0; j < queque.length; j++) 
				{
					if(timer > queque[j].time)
					{
						totalEnemies.push(queque[j].obj);
						queque.splice(j,1);
						j--;
						
					}
				}
				
				
			}
			
			
			
		}
		
		private function createMob(cls:Class, param:Object):Object
		{
			var m:*;
			if(!_deadBodies[cls])
			{
				_deadBodies[cls] = new Vector.<Enemy>();
			}
			
			if(_deadBodies[cls].length >  0)
			{
				m = _deadBodies[cls].splice(0,1)[0];
			}
			else
			{
				m = new cls(this,texture,explodeCallBack, particleLayer);
			}
			
			m.reset(param);
			
			return m;
		}
		
		
		private function explodeCallBack(enemy:Enemy):void
		{
			Config.score += enemy.scorePoint;
			this.enemyExplodedCallBack();
		}
		
		
		
		public function update():void
		{
			
			this.reset();
			if(totalEnemies.length > 0)
			{
			
				for (var i:int = 0; i < totalEnemies.length; i++) 
				{
					totalEnemies[i].update();
					
					this.addImage(totalEnemies[i] as Image);
				}

				
				for ( i = 0; i < totalEnemies.length; i++) 
				{
					if(!totalEnemies[i].isValid)
					{
						var obj:* = totalEnemies.splice(i, 1)[0];
						i--;
						
						_deadBodies[getClass(obj)].push(obj);
					}
				}
				
			}
			
		}
		
		
	
		
		public function explodeAllEnemies():void
		{
			for (var i:int = 0; i < totalEnemies.length; i++) 
			{
				totalEnemies[i].explode();
			}
			
			queque.length = 0;
			
			
			
		}
		
		
		
		private function getClass(obj:Object):Class {
			   return Class(getDefinitionByName(getQualifiedClassName(obj)));
		 }
		
		public function fireOnce(type:int, param:Object=null):IEnemy
		{
			var tempEn:IEnemy = createMob(enemies[type],param) as IEnemy;
			totalEnemies.push(tempEn);
			return tempEn;
		}
	}
}