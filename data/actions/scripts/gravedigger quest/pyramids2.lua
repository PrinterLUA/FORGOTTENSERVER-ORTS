function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if itemEx.actionid == 4663 or itemEx.actionid == 4664 or itemEx.actionid == 4665 or itemEx.actionid == 4666 or itemEx.actionid == 4667 then
		if player:getStorageValue(Storage.GravediggerOfDrefia.Mission61) == 1 and player:getStorageValue(Storage.GravediggerOfDrefia.Mission62) < 1 then
			player:setStorageValue(Storage.GravediggerOfDrefia.Mission62, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '<screeeech> <squeak> <squeaaaaal>')
		elseif player:getStorageValue(Storage.GravediggerOfDrefia.Mission62) == 1 and player:getStorageValue(Storage.GravediggerOfDrefia.Mission63) < 1 then
			player:setStorageValue(Storage.GravediggerOfDrefia.Mission63, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '<screeeech> <squeak> <squeaaaaal>')
		elseif player:getStorageValue(Storage.GravediggerOfDrefia.Mission63) == 1 and player:getStorageValue(Storage.GravediggerOfDrefia.Mission64) < 1 then
			player:setStorageValue(Storage.GravediggerOfDrefia.Mission64, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '<screeeech> <squeak> <squeaaaaal>')
		elseif player:getStorageValue(Storage.GravediggerOfDrefia.Mission64) == 1 and player:getStorageValue(Storage.GravediggerOfDrefia.Mission65) < 1 then
			player:setStorageValue(Storage.GravediggerOfDrefia.Mission65, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '<screeeech> <squeak> <squeaaaaal>')
		elseif player:getStorageValue(Storage.GravediggerOfDrefia.Mission65) == 1 and player:getStorageValue(Storage.GravediggerOfDrefia.Mission66) < 1 then
			player:setStorageValue(Storage.GravediggerOfDrefia.Mission66, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '<screeeech> <squeak> <squeaaaaal>')
		end
	end
	return true
end