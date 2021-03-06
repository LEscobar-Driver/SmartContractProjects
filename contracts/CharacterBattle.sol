// pragma solidity ^0.4.18;
pragma experimental ABIEncoderV2;

import "./BattleTimeLock.sol";

/// @title CharacterAttack
/// @author LD2045
/// @dev 
contract CharacterBattle is BattleTimeLock {

    /// @dev Some WoW battle formulas 
    /// damage = att * att / (att + def)
    /// ATTACK POWER: Atk*(1+.01(Pow))+(1+.10(Str))+(.10*RandBetween(0,Lck))
    /// DEFENSE POWER: Def+(1+.10(End))+(.10*RandBetween(0,Lck))
    /// (Weapon Damage + Attack Power / 3.5 *  Weapon Speed) * Coefficient * Damage Multiplier
    /// DPS = ( AvgBaseWdmg + Agility * BaseWspeed / 3.5 ) * Haste / BaseWspeed

    /// @notice Events.
    event NewBattle(uint _charactersIdOne, uint _charactersIdTwo);

    modifier notEngaged(uint _charactersId) {
        require(characters[_charactersId].engaged == false);
        _;
    }

    modifier isEngaged(uint _charactersId) {
        require(characters[_charactersId].engaged == true);
        _;
    }

    /// @dev This function prevents the same character fighting itself. Also locks in the character into battle - either to awaite another opponent or to begin the battle.
    function enterBattleLock(uint _characterid) public onlyOwnerOf(_characterid) notEngaged(_characterid) {
        /// @dev Character becomes engaged. Character can no longer join another battle until resolution. 
        characters[_characterid].engaged = true;

        /// @dev Lock that character into lockedBattles. characterIdsModIndex % 2 can only settle on 0 or 1.  
        lockedBattles[activeBattleCount].characterIds[characterIdsModIndex%2] = _characterid;

        /// @dev characterIdsModIndex only ever had a range in the program of 0-1. 
        if (characterIdsModIndex == 1) {
            /// @dev Resetting the mod index to 0 meaning that 2 players have been locked in battle.
            characterIdsModIndex = characterIdsModIndex.sub(1);
            /// @dev A battle is loaded with 2 players.
            activeBattleCount = activeBattleCount.add(1);
            totalBattles = totalBattles.add(1);

            NewBattle(lockedBattles[activeBattleCount-1].characterIds[0], lockedBattles[activeBattleCount-1].characterIds[1]);

            _battle();
        } else {
            /// @dev First player has been locked - waiting for a second.
            characterIdsModIndex = characterIdsModIndex.add(1);
        }
    }

    /// @dev This will be left empty - another dev can implement this. 
    function _battle() private {

    }







    // /// @dev Code to test on remix
    // function ReturnLockedBattles(uint index, uint charIndex) public view returns(uint) {
    //     return lockedBattles[index].characterIds[charIndex];
    // }

    // function GetCharacterModIndex() public view returns(uint) {
    //     return characterIdsModIndex;
    // }

    // function GetActiveBattleCount() public view returns(uint) {
    //     return activeBattleCount;
    // }

    // function GetIsEngaged(uint characterId) public view returns(bool) {
    //     return characters[characterId].engaged;
    // }


    // function getWeaponAt(uint characterId, uint arr) public view returns(Weapon) {
    //     require(characters[characterId].weaponCounter > arr);
    //     return characters[characterId].weapons[arr].weapon;
    // }

    // function getTotalWeapons(uint characterId) public view returns(uint) {
    //     return characters[characterId].weaponCounter;
    // }

    // function getArmourAt(uint characterId, uint arr) public view returns(Armour) {
    //     require(characters[characterId].armourCounter > arr);
    //     return characters[characterId].armour[arr].armour;
    // }

    // function getTotalArmour(uint characterId) public view returns(uint) {
    //     return characters[characterId].armourCounter;
    // }

    // /// @notice Will always be two in current form.
    // function getLockedArrCount() public view returns(uint) {
    //     return lockedBattles[activeBattleCount-1].characterIds.length;
    // }

}