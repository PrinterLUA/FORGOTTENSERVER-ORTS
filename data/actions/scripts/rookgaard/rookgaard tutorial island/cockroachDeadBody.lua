function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	local owner = Item(item.uid):getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER)
	if owner ~= nil and Player(owner) and player:getId() ~= owner then
		return
	end

	if player:getStorageValue(Storage.RookgaardTutorialIsland.cockroachBodyMsgStorage) ~= 1 then
		player:sendTutorial(9)
		player:setStorageValue(Storage.RookgaardTutorialIsland.cockroachBodyMsgStorage, 1)
	end
end	