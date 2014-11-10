package com.selim.abidin
{
	import com.greensock.TweenMax;
	import com.selim.abidin.controller.ClassicController;
	import com.selim.abidin.display.BackGround;
	import com.selim.abidin.display.EnemyProvider;
	import com.selim.abidin.display.GameInfoLayer;
	import com.selim.abidin.display.Hero;
	import com.selim.abidin.display.IMatchable;
	import com.selim.abidin.display.IUpdatable;
	import com.selim.abidin.display.Menu;
	import com.selim.abidin.display.ParticleProvider;
	import com.selim.abidin.events.HeroEvent;
	import com.selim.abidin.events.MenuEvents;
	import com.selim.abidin.utils.Config;
	import com.selim.abidin.utils.Matcher;
	
	import flash.display.Stage;
	import flash.display3D.Context3DProfile;
	import flash.geom.Rectangle;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.SpotlightFilter;
	import starling.textures.Texture;

	
	public class Geometrika extends Sprite
	{
		
		
		private var background:BackGround;
		private var menu:Menu;
		private var hero:Hero;
		public static var st:Stage;
		private var enemyLayer:EnemyProvider;
		private var matcher:Matcher;
		private var infoLayer:GameInfoLayer;
		private var controller:ClassicController;
		private var updatables:Vector.<IUpdatable> = new Vector.<IUpdatable>();
		public static var enemies:Vector.<IMatchable> = new Vector.<IMatchable>();
		
		
		private var particleLayer:ParticleProvider;
		
		public function Geometrika()
		{
			super();
			this.name = "Geometrika";
			TweenMax.to(this, 0.001,{});
		}
		
		private var image:Image;
		public function init():void
		{
		
		
			createBackground();
			createMenu();
			createMatcher();
			
			hero = new Hero();
			//hero.filter = godRaysFilter;
			
			//hero.clipRect = new Rectangle(-800,-800, 1600, 1600);
			
			particleLayer = new ParticleProvider(hero);
			particleLayer.prepareSome(100);
			
			createEnemyLayer();
			
			this.addChild(particleLayer);
			updatables.push(particleLayer);
			
			infoLayer = new GameInfoLayer();
			this.addChild(infoLayer);
			this.addEventListener(Event.ENTER_FRAME, update);			
			this.addChild(hero);
			
		}

		
		
		private function createMatcher():void
		{
			matcher = new Matcher();
			updatables.push(matcher);
		}
		
		private function createEnemyLayer():void
		{
			enemyLayer = new EnemyProvider(hero,particleLayer,enemyExplodedCallBack);
			this.addChild(enemyLayer);
			updatables.push(enemyLayer);
			matcher.addBadSide(enemyLayer.totalEnemies);
		}
		
		private function createMenu():void
		{
			menu = new Menu();
			menu.addEventListener(MenuEvents.DISAPPEAR_ANIMATION_COMPLATE, onStartGame);
			this.addChild(menu);
		}		
		
		private function onStartGame(evt:Event):void
		{
			this.removeChild(menu)
			menu.dispose();
			
			infoLayer.init();
			
			
			updatables.push(hero);
			
			controller = new ClassicController(hero,this );
			this.addChild(controller);
			
			hero.addEventListener(HeroEvent.CONTROLABLE, onControlable);
			hero.addEventListener(HeroEvent.UNCONTROLABLE, onUnControlable);
			hero.addEventListener(HeroEvent.HERO_DIED, onHeroDied);
			
			hero.init();
			
			var matchables:Array = hero.getMatchables();
			
			for (var i:int = 0; i < matchables.length; i++) 
			{
				matcher.addGoodSide(matchables[i]);	
			}
		}		
		
		private function onHeroDied(evt:HeroEvent):void
		{
			enemyLayer.isEnemyCreateEnabled = false;
			controller.disable(true);
			Config.GLOBAL_SPEED = 0;
			
			
			TweenMax.delayedCall(.4, function():void{
				
				Config.GLOBAL_SPEED = -1;
				
				TweenMax.delayedCall(.2, function():void{
				
					Config.GLOBAL_SPEED = 3;
				
					particleLayer.createParticles(80,  hero.x, hero.y, 0);
					
					
					var nextEnemy:int = enemyLayer.nextEnemy - 2;
					enemyLayer.nextEnemy = nextEnemy;
					
					
					
					hero.y = Config.stageHeight + 30;
					
					
					setTimeout(enemyLayer.explodeAllEnemies, 700);
					
					setTimeout(bringHeroAfterDeath, 4000);
				
				});
				
				
				
				
			
			
			});
			
			
			
			
			//
		}
		
		private function bringHeroAfterDeath():void
		{
			hero.init();
			hero.makeImmoralForAWhile(5000);
		//	enemyLayer.isEnemyCreateEnabled = true;
			
			
		}
		
		private function onUnControlable():void
		{
			controller.disable(true);
		}
		
		private function onControlable():void
		{
			controller.disable(false);
			hero.startFire();
			enemyLayer.start();
			enemyLayer.isEnemyCreateEnabled = true;
		}
		
		private function createBackground():void
		{
			background = new BackGround();
			this.addChildAt(background, 0);
			updatables.push(background);
		}
		
		
		private function update(evt:Event):void
		{
			for (var i:int = 0; i < updatables.length; i++) 
			{
				updatables[i].update();
			}
			
			
			if(hero)
			{
				if(hero.isValid)
				{
					matcher.searchInEnemies(hero, true);
				}
				
		
			}
			
			
		
			
			
		}
		
		
		
		
		
		private function enemyExplodedCallBack():void
		{
			infoLayer.setScore(Config.score.toString());
		}
		
		
		
		
		
	}
}