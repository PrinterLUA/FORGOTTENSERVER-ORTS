function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if(item.itemid == 9733 and isInArray({1786, 1787, 1788, 1789, 1790, 1791, 1792, 1793, 9911}, itemEx.itemid)) then
		Item(item.uid):remove(1)
		toPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:say("You burned the alchemist formula.", TALKTYPE_MONSTER_SAY)
	end
	return true
end
