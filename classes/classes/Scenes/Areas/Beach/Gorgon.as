/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Beach 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Areas.Desert.NagaScene;
	
	
	public class Gorgon extends Monster
	{
		public var nagaScene:NagaScene = new NagaScene();
		
		override public function defeated(hpVictory:Boolean):void
		{
			flags[kFLAGS.NAGA_OR_GORGON] = 2;
			nagaScene.nagaRapeChoice();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe gorgon's eyes go wide and she turns to leave, no longer interested in you.", false);
				player.orgasm();
				doNext(game.cleanupAfterCombat);
			} else {
				flags[kFLAGS.NAGA_OR_GORGON] = 2;
				nagaScene.nagaFUCKSJOOOOOO();
			}
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(5);
			if (choice == 0) eAttack();
			if (choice == 1) gorgonPoisonBiteAttack();
			if (choice == 2) {
				if (player.hasStatusAffect(StatusAffects.NagaBind) || player.hasStatusAffect(StatusAffects.Stunned)) TailWhip();
				else gorgonConstrict();
			}
			if (choice == 3) {
				if (player.hasStatusAffect(StatusAffects.Stunned)) eAttack();
				else if (player.hasStatusAffect(StatusAffects.NagaBind)) gorgonPoisonBiteAttack();
				else TailWhip();
			}
			if (choice == 4) {
				if (player.hasStatusAffect(StatusAffects.Stunned)) eAttack();
				else if (player.hasStatusAffect(StatusAffects.NagaBind)) {
					if (rand(2) == 0) gorgonPoisonBiteAttack();
					else TailWhip();
				}
				else {
					if (hasStatusAffect(StatusAffects.AbilityCooldown1)) {
						if (rand(2) == 0) gorgonPoisonBiteAttack();
						else TailWhip();
					}
					else {
						if (hasStatusAffect(StatusAffects.Blind)) eAttack();
						else petrify();
					}
				}
			}
		}
		
		public function gorgonPoisonBiteAttack():void {
			//(Deals damage over 4-5 turns, invariably reducing 
			//your speed. It wears off once combat is over.)
			outputText("The " + this.short + " strikes with the speed of a cobra, sinking her fangs into your flesh!  ", false);
			if(!player.hasStatusAffect(StatusAffects.NagaVenom)) {
				outputText("The venom's effects are almost instantaneous; your vision begins to blur and it becomes increasingly harder to stand.", false);
				if(player.spe > 6) {
					//stats(0,0,-3,0,0,0,0,0);
					player.spe -= 5;
					showStatDown( 'spe' );
					// speUp.visible = false;
					// speDown.visible = true;
					player.createStatusAffect(StatusAffects.NagaVenom,5,0,0,0);
				}
				else {
					player.createStatusAffect(StatusAffects.NagaVenom,0,0,0,0);
					player.takeDamage(15+rand(15));
				}
				player.takeDamage(15+rand(15));
			}
			else {
				outputText("The venom's effects intensify as your vision begins to blur and it becomes increasingly harder to stand.", false);
				if(player.spe > 5) {
					//stats(0,0,-2,0,0,0,0,0);
					player.spe -= 4;
					showStatDown( 'spe' );
					// speUp.visible = false;
					// speDown.visible = true;
					player.addStatusValue(StatusAffects.NagaVenom,1,4);
				}
				else player.takeDamage(15+rand(15));
				player.takeDamage(15+rand(15));
			}
			combatRoundOver();
		}
		
		public function gorgonConstrict():void {
			outputText("The " + this.short + " draws close and suddenly wraps herself around you, binding you in place! You can't help but feel strangely aroused by the sensation of her scales rubbing against your body. All you can do is struggle as she begins to squeeze tighter!", false);
			player.createStatusAffect(StatusAffects.NagaBind,0,0,0,0); 
			if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {
				player.takeDamage(4+rand(8));
			}
			combatRoundOver();
		}
		
		public function TailWhip():void {
			outputText("The gorgon tenses and twists herself forcefully.  ", false);
			//[if evaded]
			if((player.findPerk(PerkLib.Evade) && rand(6) == 0)) {
				outputText("You see her tail whipping toward you and evade it at the last second. You quickly roll back onto your feet.", false);
			}
			else if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s tail-whip.", false);
			}
			else if(player.spe > rand(300)) {
				outputText("You see her tail whipping toward you and jump out of the way at the last second. You quickly roll back onto your feet.", false);
			}
			else {
				outputText("Before you can even think, you feel a sharp pain at your side as the gorgon's tail slams into you and shoves you into the sands. You pick yourself up, wincing at the pain in your side. ", false);
				var damage:Number = str;
				if(player.armorDef < 50) damage += 50 - player.armorDef;
				damage += rand(25);
				damage = player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
		
		public function petrify():void {
			outputText("With a moment of concentration she awakens normaly dormant snake hair that starts to hiss and then casual glance at you. Much to your suprise you noticing your fingers then hands starting to pertify... ", false);
			player.createStatusAffect(StatusAffects.Stunned, 1, 0, 0, 0);
			createStatusAffect(StatusAffects.AbilityCooldown1, 3, 0, 0, 0);
			if (player.hasStatusAffect(StatusAffects.NagaBind)) player.removeStatusAffect(StatusAffects.NagaBind);
			combatRoundOver();
		}
		
		public function Gorgon() 
		{
			this.a = "the ";
			this.short = "gorgon";
			this.imageName = "gorgon";
			this.long = "You are fighting a gorgon. She resembles a slender woman from the waist up, with green scale covered hair hanging down to her neck. Her whole body is covered with shiny green scales, striped in a pattern reminiscent of the dunes around you. Instead of bifurcating into legs, her hips elongate into a snake's body which stretches far out behind her, leaving a long and curving trail in the sand.  She's completely naked, with her round D-cup breasts showing in plain sight. In her mouth you can see a pair of sharp, venomous fangs and a long forked tongue moving rapidly as she hisses at you.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_NORMAL);
			this.createStatusAffect(StatusAffects.BonusVCapacity, 60, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusAffect(StatusAffects.BonusACapacity,10,0,0,0);
			this.tallness = 6*12+2;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.lowerBody = LOWER_BODY_TYPE_NAGA;
			this.skin.growCoat(SKIN_COAT_SCALES,{color:"green"});
			this.hairColor = "green";
			this.hairLength = 16;
			initStrTouSpeInte(91, 125, 110, 75);
			initLibSensCor(72, 55, 40);
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 31 + (7 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "scales";
			this.armorDef = 31 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 500;
			this.bonusLust = 10;
			this.lust = 30;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 24;
			this.gems = rand(16) + 30;
			this.drop = new WeightedDrop().
					add(null,1).
					add(consumables.REPTLUM,5).
					add(consumables.GORGOIL,4);
			this.faceType = FACE_SNAKE_FANGS;
			this.str += 18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 25 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 22 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 15 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 14 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 2820;
			checkMonster();
		}
		
	}

}