package com.selim.abidin.display
{
	import com.selim.abidin.GeometrikaBase;
	import com.selim.abidin.display.enemies.Enemy;
	import com.selim.abidin.display.object.Particle;
	import com.selim.abidin.display.object.particles.BasicParticle;
	import com.selim.abidin.display.object.particles.HeroParticle;
	import com.selim.abidin.display.object.particles.SinusParticles;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class ParticleProvider extends QuadBatch implements IUpdatable
	{
		
		private var _aliveparticles:Vector.<Particle> = new Vector.<Particle>();
		private var _deadparticles:Dictionary = new Dictionary();
		
		private var texture:Texture;
		private var particleTypes:Array = [HeroParticle, BasicParticle,SinusParticles];
		private var mainTarget:Sprite;
		public function ParticleProvider(mainTarget:Sprite)
		{
			super();
			
			this.mainTarget = mainTarget;
			texture = GeometrikaBase.assetsManager.getTexture("particle");
			
		}
		
		
		public function createParticles(adet:int,xCord:Number,yCord:Number, type:int):void
		{
			//var vecTemp:Vector.<Particle> = new Vector.<Particle>();
			var pTemp:Particle;
			for (var i:int = 0; i < adet; i++) 
			{
				pTemp = createParticle(particleTypes[type]);
				pTemp.x = xCord;
				pTemp.y = yCord;
			}
			
		}
		
		
		
		
		public function createParticle(cls:Class, onlyCreate:Boolean=false):Particle
		{
			var pTemp:Particle;
			if(_deadparticles[cls])
			{
				var v:Vector.<Particle> = _deadparticles[cls] as Vector.<Particle>;
				
				if(v.length && !onlyCreate)
				{
					pTemp = v.splice(0,1)[0] as Particle;
					pTemp.reset();
					_aliveparticles.push(pTemp);
					return pTemp;
				}
				
			}
			else
			{
				_deadparticles[cls] = new Vector.<Particle>();
			}
			
			
			pTemp = new cls(texture);
			pTemp.initialize();
			pTemp.reset();
			
			if(!onlyCreate)
			{
				_aliveparticles.push(pTemp);
			}
			else
			{
				_deadparticles[cls].push(pTemp);
			}
			
			
			return pTemp;
		}
		
		
		
		public function update():void
		{
			this.reset();
			for (var i:int = 0; i < _aliveparticles.length; i++) 
			{
				_aliveparticles[i].update();
				this.addImage(_aliveparticles[i]);
			
			}
			
			
			for ( i = 0; i < _aliveparticles.length; i++) 
			{
				if(!_aliveparticles[i].isValid)
				{
					var obj:* = _aliveparticles.splice(i, 1)[0];
					i--;
					_deadparticles[getClass(obj)].push(obj);
				}
			}
		
		}
		
		
		
		public function prepareSome(adet:int):void
		{
			
			for (var j:int = 0; j < particleTypes.length; j++) 
			{
				for (var i:int = 0; i < adet; i++) 
				{
					createParticle(particleTypes[j], true);
				}
			}
			
			
			
			
			
		}
		
		
		
		
		
		private function getClass(obj:Object):Class {
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}
		
		
		
		
	}
}