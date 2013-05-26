package  com.mysite{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import com.senocular.KeyObject;
	import flash.display.Stage;
	import flash.utils.Timer;
	import flashx.textLayout.formats.BackgroundColor;
	import flash.display.*;
	import flash.events.*;
	
	public class Game extends MovieClip{
		var enemy:Enemy;
		var hero:Hero;
		var launcher:Launcher;
		var rockethero:Rockethero;
		var key:KeyObject;
		var score:Score;
		var backgroundpic:Background;
		var shootTimer:Timer = new Timer(5000);
		var canshoot:Boolean = true;
		var enemyArray:Array = new Array;
		var enemiesCount:Number = 3;
		
//таймер, оружие, анимация бега, хиттест, меню паузы

		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			
		}
		public function init(e:Event = null){
			removeEventListener(Event.ADDED_TO_STAGE, init); 
			
			
			gamebuilder();
			addEventListener(Event.ENTER_FRAME, navig_hero);
			
			shootTimer.addEventListener(TimerEvent.TIMER_COMPLETE, canShoot);
			
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
			
			hero = new Hero();
			addChild(hero);
			hero.gotoAndStop(1);
			hero.x = 500;
			hero.y = 800;
			
			launcher = new Launcher();
			addChild(launcher);
			launcher.x = hero.x + 9;
			launcher.y = hero.y - 52;
			
			rockethero = new Rockethero();
			
			for(var i:int = 0; i<enemiesCount; i++)
			{
			enemyArray[i] = new Enemy();
			enemyArray[i].name = "enemy" + i;
			addChild(enemyArray[i]);
			enemyArray[i].x = Math.random()*900;
			enemyArray[i].y = Math.random()*700;
			}
			
			
			
		}
		
		public function canShoot(e:TimerEvent):void{
			trace("canshoot");
			canshoot = true;
		}
		
		public function navig_hero(e:Event):void{
			//trace("go");
			if(key.isDown(Keyboard.LEFT)){
			   //hero.rotation -= 5;
			   hero.x -= 10;
			   launcher.x = hero.x + 9;
				hero.gotoAndPlay(2);
			   }
			   else
			   if(key.isDown(Keyboard.RIGHT)){
			   //hero.rotation += 5;
			   hero.x += 10;
			     launcher.x = hero.x + 9;
				 hero.gotoAndPlay(2);
			   }
			 
			   if(key.isDown(Keyboard.SPACE)){
			   shooting();
			   }
			  sceneCutter();
			
	}
	
	
	
	/*движение врагов, в энеми траектории. хиттесты в гейм. скор счетчик. меню для игрового процесса*/
	
	

	
	
	public function shooting():void
	{
		if(canshoot == true)
		{
		canshoot = false;
		shootTimer.start();
		trace("shoot");
		addEventListener(Event.ENTER_FRAME, hittesting);
		addChild(rockethero);
			rockethero.x = launcher.x;
			rockethero.y = launcher.y;
			rockethero.rotation = launcher.rotation;
		}
			
	}
	
	public function hittesting(e:Event):void
	{	
		for(var i:int = 0; i<enemiesCount; i++)
			{
		if(enemyArray[i].hitTestObject(rockethero)){
			removeEventListener(Event.ENTER_FRAME, hittesting);
			rockethero.hit();
			trace("hit");
		}
	}
		
	}
	public function sceneCutter():void{
		if(hero.x> stage.stageWidth){
			hero.x=stage.stageWidth;
		} else if(hero.x < 25){
			hero.x = 25;
		} 
		if(hero.y> stage.stageHeight){
			hero.y=stage.stageHeight;
		} else if(hero.y < 25){
			hero.y = 25;
		} 
	}
	
}
}
