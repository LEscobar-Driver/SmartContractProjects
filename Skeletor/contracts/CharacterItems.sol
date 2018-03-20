pragma solidity ^0.4.18;

import "./CharacterFactory.sol";

contract CharacterItems is CharacterFactory {
    /// @dev enums are explicitly convertible to and from all integer types but implicit conversion is not allowed.
    enum Armour {Chest, Helm, Boots, Leggings, Gloves, Shield} // 0,1,2,3,4,5
    enum Weapon {Sword, Axe, Wand, Gun, Hammer, Fist} // 0,1,2,3,4,5
    /// @notice <Left to right> <Common to rare>
    enum Rarity {Grey, Blue, DarkBlue, Purple} // 0,1,2,3

    /// @dev Returns the rarity of the weapon dropped. 
    function _calcWeaponRarity() internal returns(Rarity) {
        /// @dev Will return the last 2 numbers (00-99) of a rand num.
        uint8 rarityNumber = uint8(_generateRandomness(100));
        if (rarityNumber == 0) { // 1% chance.
            return Rarity.Purple;
        } else if (rarityNumber > 0 && rarityNumber <= 7) { // 7% chance.
            return Rarity.DarkBlue; 
        } else if (rarityNumber > 7 && rarityNumber <= 45) { // 38% chance.
            return Rarity.Blue; 
        } else {    // 54% chance.
            return Rarity.Grey;
        }
    }

    /// @dev Returns the weapon type that is dropped.
    function _calcWeaponDrop() internal returns(Weapon) {
        /// @dev Will return the last 2 numbers (00-99) of a rand num.
        uint8 weaponNumber = uint8(_generateRandomness(100));
        if (weaponNumber < 15) { // 14% chance.
            return Weapon.Sword;
        } else if (weaponNumber > 15 && weaponNumber <= 30) { // 15% chance.
            return Weapon.Axe;
        } else if (weaponNumber > 30 && weaponNumber <= 45) { // 15% chance.
            return Weapon.Wand;
        } else if (weaponNumber > 45 && weaponNumber <= 60) { // 15% chance.
            return Weapon.Gun;
        } else if (weaponNumber > 60 && weaponNumber <= 75) { // 15% chance.
            return Weapon.Hammer;
        } else { // 26% chance.
            return Weapon.Fist;
        }
    }

    /// @dev Returns the armour type that is dropped.
    function _calcArmourDrop() internal returns(Armour) {
        /// @dev Will return the last 2 numbers (00-99) of a rand num.
        uint8 armourNumber = uint8(_generateRandomness(100));
        if (armourNumber < 15) { // 14% chance.
            return Armour.Chest;
        } else if (armourNumber > 15 && armourNumber <= 30) { // 15% chance.
            return Armour.Helm;
        } else if (armourNumber > 30 && armourNumber <= 45) { // 15% chance.
            return Armour.Boots;
        } else if (armourNumber > 45 && armourNumber <= 60) { // 15% chance.
            return Armour.Leggings;
        } else if (armourNumber > 60 && armourNumber <= 75) { // 15% chance.
            return Armour.Gloves;
        } else { // 26% chance.
            return Armour.Shield;
        }
    }
}