local config = {
	[50058] = {markPos = Position(32000, 32278, 7), markId = MAPMARK_REDEAST, markDesc = "To the Village",tutorialId = 2, storageValue = 1},
	[50059] = {effPos = Position(32007, 32276, 7), text = "To look at objects such as this sign, right-click on them and select 'Look'. Sometimes you have to walk a bit closer to signs. Messages like this can be reviewed at a later time by using the 'Server Log' window, located at the bottom of the screen.", storageValue = 2},
	[50060] = {markPos = Position(32023, 32273, 7), markId = MAPMARK_GREENNORTH, markDesc = "Santiago's Hut", text = "Now continue to the next mark on your automap to the east. You can point your mouse cursor on a mark to read its name.", storageValue = 3},
	[50061] = {tutorialId = 21, effPos = Position(32023, 32273, 7), text = "To go up stairs or ramps like this one, simply walk on them.", storageValue = 4},
	[50062] = {markPos = Position(32034, 32275, 6), markId = MAPMARK_REDSOUTH, markDesc = "Santiago's Hut", text = "This is Santiago, a Non-Player-Character. You can chat with NPCs by typing 'Hi' or 'Hello'. Walk to Santiago and try it!", storageValue = 5},
	[50063] = {tutorialId = 22, storageValue = 6},
	[50064] = {tutorialId = 4, storageValue = 7},
	[50065] = {effPos = Position(32033, 32278, 8), text = "You can't see any cockroaches here. 'Open' this chest and see if you can find something to light the room better.", storageValue = 8},
	[50066] = {effPos = Position(32033, 32278, 8), text = "You can't see so well here. 'Open' this chest and see if you can find something to light the room.", storageValue = 9},
	[50067] = {effPos = Position(32035, 32285, 8), text = "Look at the metallic object on the floor - this is a sewer grate. Right-click on it and select 'Use' to climb down.", storageValue = 10},
	[50068] = {tutorialId = 7, text = "You smell stinky cockroaches around here. When you see one, walk to it and attack it by left-clicking it in your battle list!", storageValue = 11},
	[50069] = {tutorialId = 23, effPos = Position(32035, 32285, 9), text = "Right-click on the lower right end of the ladder - anywhere in the red frame - and select 'Use' to climb up.", storageValue = 12},
}

function onStepIn(cid, item, position, fromPosition)
	local player = Player(cid)
	if not player then 
		return
	end

	local targetTableAid = config[item.actionid]
	if not targetTableAid then
		return
	end

	if item.actionid == 50069 and player:getStorageValue(Storage.RookgaardTutorialIsland.cockroachLegsMsgStorage) < 1 then
		return
	end
		

	if player:getStorageValue(Storage.RookgaardTutorialIsland.tutorialHintsStorage) < targetTableAid.storageValue then
		player:setStorageValue(Storage.RookgaardTutorialIsland.tutorialHintsStorage, targetTableAid.storageValue)

		if targetTableAid.tutorialId then
			player:sendTutorial(targetTableAid.tutorialId)
		end

		if targetTableAid.text then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, targetTableAid.text)
		end

		if targetTableAid.effPos then
			targetTableAid.effPos:sendMagicEffect(CONST_ME_TUTORIALARROW)
			targetTableAid.effPos:sendMagicEffect(CONST_ME_TUTORIALSQUARE)
		end

		if targetTableAid.markPos then
			player:addMapMark(targetTableAid.markPos, targetTableAid.markId, targetTableAid.markDesc)
		end
	end
	return true
end