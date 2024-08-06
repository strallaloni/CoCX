package classes.Scenes 
{
	/**
	 * ...
	 * @author ...
	 */
	import classes.*;
	import classes.BodyParts.*;
	
	import classes.BaseContent;
	import classes.lists.BreastCup;
	import classes.GlobalFlags.kFLAGS;
	import classes.Player;
	import classes.Stats.GoddessStats;
	
	use namespace Coc;
	
	public class Goddess extends BaseContent {	
		
		public var goddess_stats:GoddessStats;
		
		public function Goddess(stats:GoddessStats):void {
			
			goddess_stats = stats;
			
			mainViewManager.showPlayerDoll(false);
			clearOutput();
			
			outputText("Your features are adorned by " + player.faceDescArticle() + "\n");
			outputText(Hair.getAppearanceDescription(player) + "\n");
			outputText(Eyes.getAppearanceDescription(player) + "\n\n");
			outputText("You are " + Measurement(player.tallness) + " tall.\n");
			outputText("You currently have a " + player.bodyType() + ".\n");
			outputText("You have " + player.hipDescript() + "and a " + player.buttDescript() + ".\n");
			if (player.breastRows.length == 1)
				outputText("You have " + player.breastRows[0].breastRating >= 1 ? " " + player.breastCup(0) : "") + "breasts.\n");
			else {
				
				var boobs:String = "";
				boobs += "You have " + num2Text(player.breastRows.length) + " rows of breasts."
				var temp:Number = 0;
				while (temp < player.breastRows.length) {
					
					if (temp == 0) boobs += "Your uppermost rack houses ";
					if (temp == 1) boobs += "The second row holds ";
					if (temp == 2) boobs += "Your third row contains ";
					if (temp == 3) boobs += "Your fourth set cradles ";
					if (temp == 4) boobs += "Your final grouping swells with ";
					boobs += (player.breastRows[temp].breastRating >= 1 ? " " + player.breastCup(temp) : "")
					boobs += " breasts.\n";
					temp++;
				}
				outputText(boobs);
			}
			if (player.breastCup(0) > goddess_stats.real_breast_size)
				outputText("You're currently showing off enlargened breasts. Your breasts are actually just " + player.breastRows[0].breastRating >= 1 ? " " + goddess_stats.real_breast_size : "") + " breasts.\n");
			else if (player.breastCup(0) < goddess_stats.real_breast_size) 
		outputText("You're currently hiding the true size of your rack. In reality you have "player.breastRows[0].breastRating >= 1 ? " " + goddess_stats.real_breast_size : "") + "breasts.\n");
			outputText("You have a " + vaginaDescript(0) + "\n");
			outputText("You have a " + Measurement(player.cocks[0].cockLength) + " long and " + Measurement(player.cocks[0].cockThickness) + "thick " + player.cockDescript() + "\n");
			if (player.cocks[0].cockLength != goddess_stats.real_cock_length)
				outputText("You're currently hiding the true size of your dick. It is actually " + Measurement(goddess_stats.real_cock_length) + " long and " + Measurement(goddess_stats.real_cock_thickness) + " thick.");
				
			menu();
			addButton(0, "Toggle Features", ToggleFeatures);
		}
		
		public function Measurement(inch:Number, scale:int=0):String {
			
			var value:String = "";
			var metres:Number = 0;
			var km:Number = 0;
			var cm:Number = 0;
			metres = Math.round(inch * 2.54) / Math.pow(10, 2)
			km = metres / 1000;
			cm = Math.round(metres * 100);
			if (scale == 0) {
				
				value += metres.toFixed(2) + " metres/";
				value += km.toFixed(3) + " km";
			}
			if (scale == 1) {
				
				value += cm.toString() + " cm/";
				value += metres.toFixed(2) + " metres";
			}
			return value;
		}
		
		public function ToggleFeatures():void {
			
			mainViewManager.showPlayerDoll(false);
			clearOutput();
			if (vagina_hidden)
				outputText("Your're hiding your vagina at the moment.\n");
			else
				outputText("Your vagina is currently visible.\n");
			if (cock_hidden)
				outputText("Your cock is currently hidden.\n");
			else {
				outputText("You're not hiding your cock at the moment. ");
				if (player.cocks[0].cockLength == goddess_stats.real_cock_length)
					outputText("Your dick is at its full length: " + Measurement(goddess_stats.real_cock_length)+ ".");
			}
			if (!player.isLactating())
				outputText("You're not lactating.\n");
			else {
				outputText("You're lactating " + player.lactationQ() + " ml of milk\n");
				if (player.lactationQ() != goddess_stats.real_lactation_Vol) {
					outputText("Your real lactation volume is " + goddess_stats.real_lactation_vol + " ml.\n");
				}
			}
			
			menu();
			if (vagina_hidden)
				addButton(0, "Show Vagina", ToggleVagina);
			else
				addButton(0, "Hide Vagina", ToggleVagina);
			if (cock_hidden)
				addButton(1, "Show Cock", ToggleCock);
			else
				addButton(1, "Hide Cock", ToggleCock);
			if (player.cocks[0].cockLength != goddess_stats.real_cock_length)
				addButton(2, "Show true cock", ToggleTrueCock);
			else
				addButton(2, "Shrink cock down", ToggleTrueCock);
			if (player.breastRows[0].breastRating != goddess_stats.real_breast_size)
				addButton(3, "Show true breasts", ToggleTrueBreasts);
			else
				addButton(3, "Hide true breasts", ToggleTrueBreasts);
			if (player.tallness != goddess_stats.real_body_size)
				addButton(4, "Show true size", ToggleTrueSize);
			else
				addButton(4, "Hide true size", ToggleTrueSize);
			
			if (player.isLactating())
				addButton(5, "Stop Lactation", ToggleLactation);
			else
				addButton(5, "Start Lactation", ToggleLactation);
			if (player.lactationQ() != goddess_stats.real_lactation_vol)
				addButton(6, "True Milk Volume", ToggleTrueLactation);
			else
				addButton(6, "Normal Milk Volume", ToggleTrueLactation);
			if (player.hasCock() && player.cumQ() != goddess_stats.real_cum_vol)
				addButton(7, "True Cum Volume", ToggleTrueCum);
			else if (player.hasCock())
				addButton(7, "Normal Cum Volume", ToggleTrueCum);
			addButton(8, "Toggle masculinity", ToggleMasculinity);	
			
		}
		
		public function ToggleVagina():void {
			
			if (player.hasVagina())
				player.removeVagina();
			else
				player.createVagina();
			
			ToggleFeatures();
		}
		
		public function ToggleCock():void {
			
			if (player.hasCock()) 			
				player.removeCock(0, player.cocks.length);
			else
				player.createCock(4.0, 1.0);
				
			ToggleFeatures();
		}
		
		public function ToggleTrueCock():void {
			
			if (player.cocks.length > 1)
				player.removeCock(1, player.cocks.length - 1);
			if (player.cocks[0].cockLength != real_cock_length) 				
				player.createCock(real_cock_length, real_cock_thickness);
			else 
				player.createCock(4.0, 1.0);
			
			ToggleFeatures();
		}
		
		public function ToggleTrueBreasts():void {
			
			if (player.breastRows.length > 1)
				player.removeBreastRow(0, player.breastRows.length);
			if (player.breastRows[0].breastRating != real_breast_size) 
				player.breastRows[0].breastRating = real_breast_size;
			else 
				player.breastRows[0].breastRating = BreastCup.FLAT;		
				
			ToggleFeatures();
		}
		
		public function ToggleTrueSize():void {
			
			if (player.tallness != real_body_size)
				player.tallness = real_body_size;
			else
				player.tallness = 70;
				
			ToggleFeatures();
		}
		
		public function ToggleMasculinity():void {
			
			if (masculine_face)
				masculine_face = false;
			else
				masculine_face = true;
				
			ToggleFeatures();
		}
	}
}