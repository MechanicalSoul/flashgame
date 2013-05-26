package  com.mysite{
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	
	import flash.text.TextField;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.filters.*;
	import fl.motion.AdjustColor;
	import flash.system.fscommand;
	import flash.sensors.Accelerometer;
	
	
	public class Menu extends MovieClip{
		/////////////t/a/s/k/l/i/s/t///////////
		/*поменять цвет текущего элемента, отформатировать текст, прицеплять 
		эффекты(прицеплять цыплят с цыпками к прицепам геотрансформ, размер сцены, 
		отдельный класс, централизация программы?*/ 
		
		
		var menuItems:Array = new Array;
		var MenuButton1:MenuButton = new MenuButton();
		var txt:Array = ["new game", "options", "navigation", "rrt"];
		var txtField:TextField = new TextField;
		var txtItem:Array = new Array;
		var currentIndex:int = 0;
		var txtLength:int = txt.length;
		var nav_help:Nav_help;
		var options:Options;
		var game:Game;
		
		
		//Настройки эффектов
		var timeEffect:Number=3;
		var defaultSize:Number=1;
		var customSize:Number=2;
		var myShadow:DropShadowFilter = new DropShadowFilter();
		var myColor:AdjustColor = new AdjustColor();
		var mColorMatrix: ColorMatrixFilter;
		var mMatrix:Array;
		
			
			
		public function Menu(){//конструктор
			if(stage) init()//проверяем, добавлен ли этот объект (Menu) на сцену
            else addEventListener(Event.ADDED_TO_STAGE, init); //если нет - добавь слушатель событий, срабатывающий при добавлении объекта на сцену
		}
		
		private function init(e:Event = null){ //Основной обработчик класса, заменяет конструктор
			removeEventListener(Event.ADDED_TO_STAGE, init); //удали слушатель событий
			//далее выполняй
			trace("mm");
			menubuilder();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, navigation);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, esc);
		}
		
		public function menubuilder():void{
			//trace("bb");
			for(var i:int = 0; i<txtLength; i++){
				menuItems[i] = new MenuButton();
				menuItems[i].name = "menuButton" + i;
				menuItems[i].x = 350;
				menuItems[i].y = 200 + 200 * i;
				//menuItems[i].addEventListener(MouseEvent.CLICK, clicker);
				addChild(menuItems[i]);
				
				txtItem[i] = new TextField;
				txtItem[i].text = txt[i];
				menuItems[i].addChild(txtItem[i]);
				
				menuItems[currentIndex];
				effect();
			}
		}
		
		public function navigation(e:KeyboardEvent):void{
			if(e.keyCode == 38 && currentIndex > 0){
					updatecurrent(currentIndex-1);
			}
			if(e.keyCode == 40 && currentIndex < txtLength-1){
					updatecurrent(currentIndex+1);
			}
			if(e.keyCode == 13){ 
				switch(currentIndex){
					case 0: 
						trace(currentIndex + ': ' + txt[currentIndex]);
						eraser();
						game = new Game();
						addChild(game);
						break;
					case 1: 
						trace(currentIndex + ': ' + txt[currentIndex]);
						eraser();
						options = new Options();
						addChild(options);
						options.x = 500;
						options.y = 500;
						break;
					case 2: 
						trace(currentIndex + ': ' + txt[currentIndex]);
						eraser();
						nav_help = new Nav_help();
						addChild(nav_help);
						nav_help.x = 500;
						nav_help.y = 500;
						break;	
					case 3: 
						trace(currentIndex + ': ' + txt[currentIndex]);
						eraser();
						fscommand("quit");
						break;	
						
					/*default:
						trace(currentIndex + ': ' + txt[currentIndex]);*/ 
						}
			}
			

		}
		public function eraser():void {
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, navigation);
			
			for(var i:int = 0; i<txtLength; i++) {
				removeChild (menuItems[i]); 
				} 
		}
		
		public function esc(e:KeyboardEvent):void{
			
			if((e.keyCode == 27 )&&!(stage.contains(menuItems[currentIndex]))){
				
					trace("esc");
					menubuilder();
					
					stage.addEventListener(KeyboardEvent.KEY_DOWN, navigation);
					
					if(currentIndex == 2){
						removeChild(nav_help);
					} else
					if(currentIndex == 1){
						removeChild(options);
					}else
					if(currentIndex == 0){
						removeChild(game);
					}
					/*if(stage.contains(nav_help)){
						removeChild(nav_help);
					}
					else if(stage.contains(options)){
						removeChild(options);
					}*/
			}
		}
		
		public function effect():void{
			var xScale:Tween = new Tween(menuItems[currentIndex], "scaleX", Elastic.easeOut, defaultSize, customSize, timeEffect, true);
			var yScale:Tween = new Tween(menuItems[currentIndex], "scaleY", Elastic.easeOut, defaultSize, customSize, timeEffect, true);
			myShadow.distance =10;
			myShadow.color = 0xFF0000;
			myShadow.blurX = 10;
			myShadow.blurY = 10;
			myShadow.quality = 3;
			menuItems[currentIndex].filters = [myShadow];
			
			myColor.hue = -22;
			myColor.saturation = 0;
			myColor.brightness = 50;
			myColor.contrast = 0;
			mMatrix = myColor.CalculateFinalFlatArray();
			mColorMatrix = new ColorMatrixFilter(mMatrix);
			
			menuItems[currentIndex].filters = [mColorMatrix];
			
			
		}
		public function noeffect():void{
			var xScale:Tween = new Tween(menuItems[currentIndex], "scaleX", Elastic.easeOut, defaultSize, defaultSize, timeEffect, true);
			var yScale:Tween = new Tween(menuItems[currentIndex], "scaleY", Elastic.easeOut, defaultSize, defaultSize, timeEffect, true);
			
		}
		
		public function updatecurrent(newIndex):void{
			noeffect();
			currentIndex = newIndex;
			effect();
		}
		/*public function clicker(e:MouseEvent):void{
			
			trace("111");
			var xScale:Tween = new Tween(e.currentTarget, "scaleX", Elastic.easeOut, 1, 2, 5, true);
			var yScale:Tween = new Tween(e.currentTarget, "scaleY", Elastic.easeOut, 1, 2, 5, true);
		}*/
	}
}
