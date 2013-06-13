package com.mysite
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import com.senocular.KeyObject;
	import flash.display.Stage;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flashx.textLayout.formats.BackgroundColor;
	import flash.display.*;
	import flash.events.*;
	import flash.events.MouseEvent; 
	import flash.display.Sprite;

	public class Game extends MovieClip
	{
		var enemy:Enemy;
		var hero:Hero;
		var launcher:Launcher;
		//var rockethero:Rockethero;
		var rocketenemy:Rocketenemy;
		var key:KeyObject;
		var score:Score;
		var backgroundpic:Background;
		var shootTimer:Timer = new Timer(1000,1);
		var shootEnemy:Timer = new Timer(3000);
		var timeTimer:Timer = new Timer(1000);
		var bossRound:Boolean = false;
		var win:Boolean = false;
		
		var canshoot:Boolean = true;
		var enemyArray:Array = new Array  ;
		var enemyRocketsArray:Array = new Array  ;
		var heroRocketsArray:Array = new Array  ;
		var enemiesCount:Number = 3;
		var rounds:Number = 3;
		var boss:Boss;
		var bosslives:Number = 3;
		var boom:Array = new Array;
		var myScore:Number = 0;
		var roundsCount:Number = 1;
		

		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);


		}
		public function init(e:Event = null)
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);


			gamebuilder();
			addEventListener(Event.ENTER_FRAME, navig_hero);
			addEventListener(Event.ENTER_FRAME, hittesting);
			addEventListener(MouseEvent.CLICK, shooting); 
			
			

			key = new KeyObject(this.stage);

		}
		public function gamebuilder():void
		{
			backgroundpic = new Background();
			addChild(backgroundpic);
			backgroundpic.x = 0;
			backgroundpic.y = 870;

			score = new Score();
			addChild(score);
			score.x = 0;
			score.y = 0;

			hero = new Hero(x,y);
			addChild(hero);
			hero.gotoAndStop(1);
			hero.x = 500;
			hero.y = 800;


			launcher = new Launcher();
			addChild(launcher);
			launcher.x = hero.x + 9;
			launcher.y = hero.y - 52;

			//rockethero = new Rockethero();
			boss = new Boss();
			
			
			boom.length = 0;
			heroRocketsArray.length = 0;
			enemyRocketsArray.length = 0;

			addEnemies();

			shootTimer.addEventListener(TimerEvent.TIMER_COMPLETE, canShoot);
			shootEnemy.addEventListener(TimerEvent.TIMER, enemyShoot);
			timeTimer.addEventListener(TimerEvent.TIMER, updTime);
			timeTimer.start();
			shootEnemy.start();
			score.scoreUpdate(0);
		}
		
		public function updScore():void
		{
			myScore = myScore + 10;
			score.scoreUpdate(myScore);
		}
		
		public function updTime(e:TimerEvent):void
		{
			score.timeUpdate();
		}

		public function addEnemies():void
		{
			if(enemiesCount<=rounds)
				{
					score.roundUpdate(bossRound);
			for (var i:int = 0; i<enemiesCount; i++)
			{
				
				enemyArray[i] = new Enemy();
				enemyArray[i].name = "enemy" + i;
				addChild(enemyArray[i]);
				enemyArray[i].x = Math.random() * 900;
				enemyArray[i].y = Math.random() * 700;
				}
				}
				else
				{
					bossRound = true;
					score.roundUpdate(bossRound);
					addChild(boss);
					boss.x = Math.random() * 900;
					boss.y = Math.random() * 700;
					enemyRocketsArray.length = 0;
					shootEnemy.stop();
					shootEnemy.removeEventListener(TimerEvent.TIMER, enemyShoot);
					removeEventListener(Event.ENTER_FRAME, hittesting);
					shootEnemy.addEventListener(TimerEvent.TIMER, bossShoot);
					shootEnemy.start();
					
					addEventListener(Event.ENTER_FRAME, bossFight);
				
			}
		}
		
		
		
		

		public function canShoot(e:TimerEvent):void
		{
			trace("canshoot");
			canshoot = true;
		}

		public function navig_hero(e:Event):void
		{
			//trace("go");
			if (key.isDown(Keyboard.LEFT))
			{
				//hero.rotation -= 5;
				hero.x -=  10;
				launcher.x = hero.x + 9;
				hero.nextFrame();
				if(hero.currentFrame == 15)
				{
					hero.gotoAndStop(1);
				}
			}
			else if (key.isDown(Keyboard.RIGHT))
			{
				//hero.rotation += 5;
				hero.x +=  10;
				launcher.x = hero.x + 9;
				hero.nextFrame();
				if(hero.currentFrame == 15)
				{
					hero.gotoAndStop(1);
				}
			}
			// trace(hero.x, hero.y);
			/*if (key.isDown(Keyboard.SPACE))
			{
				shooting();
			}*/
			sceneCutter();

		}



	





		public function shooting(e:MouseEvent):void
		{
			if (canshoot == true)
			//if (canshoot == true && !contains(rockethero))
			{
				canshoot = false;
				shootTimer.start();
				trace("shoot");
				
				/*addChild(rockethero);
				rockethero.x = launcher.x;
				rockethero.y = launcher.y;
				rockethero.rotation = launcher.rotation - 90;
				*/
				var k = heroRocketsArray.length;
				heroRocketsArray[k] = new Rockethero();
			
				addChild(heroRocketsArray[k]);
				heroRocketsArray[k].x = launcher.x;
				heroRocketsArray[k].y = launcher.y;
				heroRocketsArray[k].rotation = launcher.rotation - 90;

			}

		}

		private function enemyShoot(e:TimerEvent):void
		{
			var j = Math.round(enemyArray.length * Math.random()) - 1;
			if(j<0)
			{
				j=0;
			}
			trace("eArr j " + j);
			var k = enemyRocketsArray.length;
			
			trace("enemyRocketsArray " + enemyRocketsArray.length);
			enemyRocketsArray[k] = new Rocketenemy();
			
			addChild(enemyRocketsArray[k]);
			enemyRocketsArray[k].x = enemyArray[j].x;
			enemyRocketsArray[k].y = enemyArray[j].y;
			var dxe:Number = hero.x - enemyRocketsArray[k].x;
			var dye:Number = hero.y - enemyRocketsArray[k].y;
			var cursorAngleEnemy:Number = Math.atan2(dye,dxe);
			var cursorDegreesEnemy:Number = 360 * (cursorAngleEnemy / (2 * Math.PI));
			enemyRocketsArray[k].rotation = cursorDegreesEnemy - 90;
			trace("enemyShoot");
		}

		public function hittesting(e:Event):void
		{
			for (var i:int = 0; i<enemyArray.length; i++)
			{
				for (var h:int = 0; h<heroRocketsArray.length; h++)
			{
			
				if (enemyArray[i].hitTestObject(heroRocketsArray[h]))
				{
					explosions(heroRocketsArray[h].x, heroRocketsArray[h].y);
					if(contains(heroRocketsArray[h])) 
					{
					removeChild(heroRocketsArray[h]);
					heroRocketsArray.splice(h, 1);
					}
					if(contains(enemyArray[i])) 
					{
					removeChild(enemyArray[i]);
					enemyArray.splice(i, 1);
					}
					trace("hit");
					updScore();
					if (enemyArray.length == 0)
					{
						enemiesCount++;
						addEnemies();
					}
				}
			}
			}
			
			for (var j:int = 0; j<enemyRocketsArray.length; j++)
			{
				
			
				if (enemyRocketsArray[j].hitTestObject(hero))
				{
					explosions(enemyRocketsArray[j].x, enemyRocketsArray[j].y);
					if(contains(enemyRocketsArray[j])) removeChild(enemyRocketsArray[j]);
					//enemyRocketsArray[j].splice(j, 1);
					win = false;
					gameOver();
					
				}
			
			}

		}
		
		
		
		
		public function bossFight(e:Event):void
		{
			for (var j:int = 0; j<heroRocketsArray.length; j++)
			{
				
				if (boss.hitTestObject(heroRocketsArray[j]))
				{
					
					explosions(heroRocketsArray[j].x, heroRocketsArray[j].y);
					if(contains(heroRocketsArray[j]))
					{
					removeChild(heroRocketsArray[j]);
					heroRocketsArray.splice(j, 1);
					}
						
					
						
						bosslives--;
						trace("bl" + bosslives);
						updScore();
						if(bosslives < 0){
					if(contains(boss)) removeChild(boss);
					shootEnemy.removeEventListener(TimerEvent.TIMER, bossShoot);
					removeEventListener(Event.ENTER_FRAME, bossFight);
					win = true;
					gameOver();
						}
						
				}
			}
			
			for (var p:int = 0; p<enemyRocketsArray.length; p++)
			{
				
			
				if (enemyRocketsArray[p].hitTestObject(hero))
				{
					explosions(enemyRocketsArray[p].x, enemyRocketsArray[p].y);
					if(contains(enemyRocketsArray[p])) removeChild(enemyRocketsArray[p]);
					//enemyRocketsArray[j].splice(j, 1);
					gameOver();
					
				}
			
			}
			
			bossSceneCutter();
			
			
		}
		
		
		
		private function bossShoot(e:TimerEvent):void
		{
			var angle:Number = 0;
			for (var j:int = 0; j<3; j++)
			{
			
			enemyRocketsArray[j] = new Rocketenemy();

			addChild(enemyRocketsArray[j]);
			enemyRocketsArray[j].x = boss.x+30;
			enemyRocketsArray[j].y = boss.y+15;
			var dxe:Number = hero.x - enemyRocketsArray[j].x;
			var dye:Number = hero.y - enemyRocketsArray[j].y;
			var cursorAngleEnemy:Number = Math.atan2(dye,dxe);
			var cursorDegreesEnemy:Number = 360 * (cursorAngleEnemy / (2 * Math.PI));

			enemyRocketsArray[j].rotation = cursorDegreesEnemy + angle - 90;
			angle = angle + 20;
			
			}
		}
		
		public function explosions(ex, ey):void
		{
			var bl:Number = boom.length;
			boom[bl] = new Boom;
			boom.push(boom[bl]);
			addChild(boom[bl]);
			boom[bl].x = ex;
			boom[bl].y = ey;
		}
		
		public function gameOver():void	
		{
			removeEventListener(Event.ENTER_FRAME, navig_hero);
					removeEventListener(Event.ENTER_FRAME, hittesting);
					removeEventListener(MouseEvent.CLICK, shooting); 
					shootTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, canShoot);
					shootEnemy.removeEventListener(TimerEvent.TIMER, enemyShoot);
					timeTimer.removeEventListener(TimerEvent.TIMER, updTime);
					timeTimer.stop();
					shootTimer.stop();
					shootEnemy.stop();
					
					
					
			
			for (var j:int = 0; j<heroRocketsArray.length; j++)
			{
				if(heroRocketsArray[j] != null){
			
				if(contains(heroRocketsArray[j])) removeChild(heroRocketsArray[j]);
				heroRocketsArray.splice(j, 1);
			}
			
			}
			

			for (var k:int = 0; k<enemyRocketsArray.length; k++)
			{
				if(enemyRocketsArray[k] != null){
				
					if(contains(enemyRocketsArray[k])) removeChild(enemyRocketsArray[k]);
					enemyRocketsArray.splice(k, 1);
				}
			}
					
					
					
					
					if(contains(hero)) removeChild(hero);
					if(contains(launcher)) removeChild(launcher);
					score.winLose(win);
					
		}
		
		public function bossSceneCutter():void	
		{
			if (boss.x > stage.stageWidth - 500)	
			boss.x = stage.stageWidth - 500;

			else if (boss.x < 0) 
			boss.x = 0;

			if (boss.y > stage.stageHeight - 450)	
			boss.y = stage.stageHeight - 450;

			else if (boss.y < 200) 
			boss.y = 200;
		}
		
		public function enemySceneCutter():void	
		{
			
		}
		
		public function sceneCutter():void	
		{
			
			
			if (hero.x > stage.stageWidth)
			{
				hero.x = stage.stageWidth;
			}
			else if (hero.x < 25)
			{
				hero.x = 25;
			}
			if (hero.y > stage.stageHeight)
			{
				hero.y = stage.stageHeight;
			}
			else if (hero.y < 25)
			{
				hero.y = 25;
			}
			
			
			
			
			
			for (var p:int = 0; p<enemyArray.length; p++)
			{
				if(enemyArray[p] != null){
			if (enemyArray[p].x > stage.stageWidth)	
			enemyArray[p].x = 0;

			else if (enemyArray[p].x < 0) 
			enemyArray[p].x = stage.stageWidth;

			if (enemyArray[p].y > stage.stageHeight - 450)	
			enemyArray[p].y = stage.stageHeight - 450;

			else if (enemyArray[p].y < 200) 
			enemyArray[p].y = 200;
			}
			}
			
			
			for (var j:int = 0; j<heroRocketsArray.length; j++)
			{
				if(heroRocketsArray[j] != null){
			if (heroRocketsArray[j].x > stage.stageWidth + 100)
			{
				if(contains(heroRocketsArray[j])) removeChild(heroRocketsArray[j]);
				heroRocketsArray.splice(j, 1);
			}
			else if (heroRocketsArray[j].x < -70)
			{
				if(contains(heroRocketsArray[j])) removeChild(heroRocketsArray[j]);
				heroRocketsArray.splice(j, 1);
			}
			if (heroRocketsArray[j].y > stage.stageHeight - 80)
			{
				explosions(heroRocketsArray[j].x, heroRocketsArray[j].y);
				
				if(contains(heroRocketsArray[j])) removeChild(heroRocketsArray[j]);
				heroRocketsArray.splice(j, 1);
				
			}
			else if (heroRocketsArray[j].y < 180)
			{
				
				if(contains(heroRocketsArray[j])) removeChild(heroRocketsArray[j]);
				heroRocketsArray.splice(j, 1);
			}
				}
			}
			

			for (var k:int = 0; k<enemyRocketsArray.length; k++)
			{
				if(enemyRocketsArray[k] != null){
				if (enemyRocketsArray[k].x > stage.stageWidth + 100)
				{
					if(contains(enemyRocketsArray[k])) removeChild(enemyRocketsArray[k]);
					enemyRocketsArray.splice(k, 1);
				}
				else if (enemyRocketsArray[k].x < -70)
				{
					if(contains(enemyRocketsArray[k])) removeChild(enemyRocketsArray[k]);
					enemyRocketsArray.splice(k, 1);
				}
				if (enemyRocketsArray[k].y > stage.stageHeight - 80)
				{
					explosions(enemyRocketsArray[k].x, enemyRocketsArray[k].y);
					if(contains(enemyRocketsArray[k])) removeChild(enemyRocketsArray[k]);
					enemyRocketsArray.splice(k, 1);
				}
				else if (enemyRocketsArray[k].y < 180)
				{
					if(contains(enemyRocketsArray[k])) removeChild(enemyRocketsArray[k]);
					enemyRocketsArray.splice(k, 1);
				}
			}
			}
		}

	}
}