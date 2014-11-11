package com.selim.abidin.display.enemies
{
	import com.selim.abidin.display.EnemyProvider;
	import com.selim.abidin.display.IMatchable;
	import com.selim.abidin.display.IUpdatable;
	import com.selim.abidin.display.ParticleProvider;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class Enemy extends Image implements IUpdatable, IMatchable, IEnemy
	{
		public var scorePoint:int = 0;
		protected var particleLayer:ParticleProvider;
		protected var _isValid:Boolean;
		protected var _effectRange:Number;
		protected var _isShotable:Boolean = true;
		protected var param:Object;
		protected var enemyProvider:EnemyProvider;
		protected var explodeCallBack:Function;
		public function Enemy(enemyProvider:EnemyProvider,particleLayer:ParticleProvider,texture:Texture, explodeCallBack:Function, param:Object)
		{
			this.enemyProvider = enemyProvider;
			this.particleLayer = particleLayer;
			this.explodeCallBack = explodeCallBack;
			this.param = param;
			super(texture);
		}
		
		
		public function update():void
		{
			
		}
		
		
		public function reset(param:Object):void
		{
			this.isValid = true;
		}
		
		public function explode():void
		{
			this.isValid = false;
		}
		
		public function get effectRange():Number
		{
			return _effectRange;
		}
		
		public function set isShotable(b:Boolean):void{
			_isShotable = b;
		}
		
		public function get isShotable():Boolean{
			return _isShotable;
		}
		
		public function set isValid(b:Boolean):void{
			_isValid = b;
		}
		
		public function get isValid():Boolean{
			return _isValid;
		}
		
		
		
		
	}
}