function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)

	if itemEx.itemid == 18307 then
		if player:getStorageValue(932) == 5 or player:getStorageValue(930) ~= 1 then
			return false
		end

		player:setStorageValue(932, player:getStorageValue(932) + 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have repaired a damaged crystal.')
		Item(itemEx.uid):transform(18311)
		toPosition:sendMagicEffect(CONST_ME_ENERGYAREA)
	elseif isInArray({18308, 18309, 18310, 18311}, itemEx.itemid) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'This is not the crystal you\'re looking for!')
	end
	return true
end
