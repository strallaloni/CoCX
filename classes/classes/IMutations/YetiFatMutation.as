/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
import classes.Player;

public class YetiFatMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.YetiFatIM);
            if (pTier >= 1){
                descS += "Gain damage reduction against attacks, increase strength of yeti ice breath by 50%";
            }
            if (pTier >= 2){
                descS += ", potency of Big Hand and Feet by 50%";
            }
            if (pTier >= 3){
                descS += ", duration of yeti breath stun by 1 round and reduce cooldown by 3 rounds.";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.YetiFatIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Yeti Fat" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.YetiFatIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.YetiFatIM.requireFatTissueMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.yetiScore() >= 14;
                    }, "Yeti race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.YetiFatIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Perk Max Level
        public static var _perkLvl:int = 3;

        //Mutations Buffs
        public static function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            return pBuffs;
        }

        public function YetiFatMutation() {
            super("Yeti Fat IM", "Yeti Fat", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}