function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)

	if player:getStorageValue(item.actionid) ~= 1 then
		player:addItem(9971, 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a golden ingot.")
		player:setStorageValue(item.actionid, 1)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "The skeleton is empty.")
	end
	return true
end
