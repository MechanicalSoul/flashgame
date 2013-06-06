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

	public class Game extends MovieClip
	{
		var enemy:Enemy;
		var hero:Hero;
		var launcher:Launcher;
		var rockethero:Rockethero;
		var rocketenemy:Rocketenemy;
		var key:KeyObject;
		var score:Score;
		var backgroundpic:Background;
		var shootTimer:Timer = new Timer(1000,1);
		var shootEnemy:Timer = new Timer(3000);
		var canshoot:Boolean = true;
		var enemyArray:Array = new Array  ;
		var enemyRocketsArray:Array = new Array  ;
		var heroRocketsArray:Array = new Array  ;
		var enemiesCount:Number = 3;

		//таймер, оружие, анимация бега, хиттест, меню паузы

		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);


		}
		public function init(e:Event = null)
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);


			gamebuilder();
			addEventListener(Event.ENTER_FRAME, navig_hero);



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

			

			addEnemies();

			shootTimer.addEventListener(TimerEvent.TIMER_COMPLETE, canShoot);
			shootEnemy.addEventListener(TimerEvent.TIMER, enemyShoot);
			shootEnemy.start();
		}

		public function addEnemies():void
		{
			for (var i:int = 0; i<enemiesCount; i++)
			{
				enemyArray[i] = new Enemy();
				enemyArray[i].name = "enemy" + i;
				addChild(enemyArray[i]);
				enemyArray[i].x = Math.random() * 900;
				enemyArray[i].y = Math.random() * 700;
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
				hero.gotoAndPlay(2);
			}
			else if (key.isDown(Keyboard.RIGHT))
			{
				//hero.rotation += 5;
				hero.x +=  10;
				launcher.x = hero.x + 9;
				hero.gotoAndPlay(2);
			}
			// trace(hero.x, hero.y);
			if (key.isDown(Keyboard.SPACE))
			{
				shooting();
			}
			sceneCutter();

		}



		/*движение врагов, в энеми траектории. хиттесты в гейм. скор счетчик. меню для игрового процесса*/





		public function shooting():void
		{
			if (canshoot == true)
			{
				canshoot = false;
				shootTimer.start();
				trace("shoot");
				addEventListener(Event.ENTER_FRAME, hittesting);
				var k = enemyRocketsArray.length;
				heroRocketsArray[k] = new Rocketenemy();
			    heroRocketsArray.push(heroRocketsArray[k]);
				addChild(heroRocketsArray[k]);
				heroRocketsArray[k].x = launcher.x;
				heroRocketsArray[k].y = launcher.y;
				heroRocketsArray[k].rotation = launcher.rotation;

			}

		}

		private function enemyShoot(e:TimerEvent):void
		{
			var j = Math.round(enemyArray.length * Math.random());
			trace(j);
			var k = enemyRocketsArray.length;
			trace(k);
			enemyRocketsArray[k] = new Rocketenemy();
			enemyRocketsArray.push(enemyRocketsArray[k]);

			addChild(enemyRocketsArray[k]);
			enemyRocketsArray[k].x = enemyArray[j].x;
			enemyRocketsArray[k].y = enemyArray[j].y;
			var dxe:Number = hero.x - enemyRocketsArray[k].x;
			var dye:Number = hero.y - enemyRocketsArray[k].y;
			var cursorAngleEnemy:Number = Math.atan2(dye,dxe);
			var cursorDegreesEnemy:Number = 360 * (cursorAngleEnemy / (2 * Math.PI));

			enemyRocketsArray[k].rotation = cursorDegreesEnemy;
			trace("enemyShoot");
		}

		public function hittesting(e:Event):void
		{
			for (var i:int = 0; i<enemyArray.length - 1; i++)
			{
				for (var j:int = 0; j<heroRocketsArray.length - 1; j++)
			{
				if (enemyArray[i].hitTestObject(heroRocketsArray[j]))
				{
					removeEventListener(Event.ENTER_FRAME, hittesting);
					removeChild(heroRocketsArray[j]);
					heroRocketsArray.splice(j, 1);
					removeChild(enemyArray[i]);
					enemyArray.splice(i, 1);
					trace("hit");
					if (enemyArray.length == 0)
					{
						enemiesCount = enemiesCount + 2;
						addEnemies();
					}
				}
			}
			}

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

			/*for (var k:int = 0; k<enemyRocketsArray.length; k++)
			{
				if (enemyRocketsArray[k].x > stage.stageWidth)
				{
					removeChild(enemyRocketsArray[k]);
					enemyRocketsArray.splice(k, 1);
				}
				else if (enemyRocketsArray[k].x < 25)
				{
					removeChild(enemyRocketsArray[k]);
					enemyRocketsArray.splice(k, 1);
				}
				if (enemyRocketsArray[k].y > stage.stageHeight)
				{
					removeChild(enemyRocketsArray[k]);
					enemyRocketsArray.splice(k, 1);
				}
				else if (enemyRocketsArray[k] < 25)
				{
					removeChild(enemyRocketsArray[k]);
					enemyRocketsArray.splice(k, 1);
				}
			}*/
		}

	}
}