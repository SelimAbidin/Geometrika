package com.selim.abidin.display.enemies
{
	public interface IEnemy
	{
		function update():void;
		function explode():void;
		function get effectRange():Number;
		function get y():Number;
		function get x():Number;
		
		function get isShotable():Boolean;
		function set isShotable(b:Boolean):void;
		
		function get isValid():Boolean;
		function set isValid(b:Boolean):void;
		
	}
}