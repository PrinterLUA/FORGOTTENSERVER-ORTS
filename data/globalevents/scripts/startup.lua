local config = {
	[1] = { -- ankrahmun
		itemsToRemove = {
			{Position(33096, 32882, 6), 4978},
			{Position(33096, 32883, 6), 4978},
			{Position(33096, 32883, 6), 4922},
			{Position(33096, 32884, 6), 4922},
			{Position(33096, 32885, 6), 4922}	
		},
		mapName = 'yasirAnkrahmun',
		yasirPosition = Position(33102, 32884, 6)
	},
	[2] = { -- carlin
		itemsToRemove = {
			{Position(32393, 31814, 6), 10408},
			{Position(32393, 31815, 6), 10408},
			{Position(32393, 31816, 6), 10408}	
		},
		mapName = 'yasirCarlin',
		yasirPosition = Position(32400, 31815, 6)
	},
	[3] = { -- liberty bay
		itemsToRemove = {
			{Position(32311, 32891, 7), 3878},
			{Position(32311, 32897, 7), 3878},
			{Position(32311, 32892, 7), 3879},
			{Position(32311, 32898, 7), 3879},
			{Position(32311, 32893, 7), 3880},
			{Position(32311, 32899, 7), 3880}
		},
		mapName = 'yasirLB',
		yasirPosition = Position(32314, 32895, 6)
	}
}

local yasirEnabled = false
local yasirChance = 20

function onStartup()
	print(">> Loaded "..Game.getNpcCount().." npcs, spawned "..Game.getMonsterCount().." monsters.")

	db.query("TRUNCATE TABLE `players_online`")
	db.query("DELETE FROM `guild_wars` WHERE `status` = 0")
	db.query("DELETE FROM `players` WHERE `deletion` != 0 AND `deletion` < " .. os.time())
	db.query("DELETE FROM `ip_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())
	db.query("DELETE FROM `market_history` WHERE `inserted` <= " .. (os.time() - configManager.getNumber(configKeys.MARKET_OFFER_DURATION)))
	
	-- Yasir (World Change)
	if yasirEnabled then
		local rand = math.random(100)
		if rand <= yasirChance then
			local randTown = config[math.random(#config)]
			if randTown['itemsToRemove'] then
				for i = 1, #randTown['itemsToRemove'] do
					local tile = randTown['itemsToRemove'][i][1]:getTile():getItemById(randTown['itemsToRemove'][i][2])
					if tile then
						tile:remove()
					end
				end
			end
			Game.loadMap('data/world/yasir/' .. randTown['mapName'] .. '.otbm')
			addEvent(function() local npc = Game.createNpc('Yasir', randTown['yasirPosition']) if npc then npc:setMasterPos(randTown['yasirPosition'], 3) end end, 3000)
		end
	end

	-- Move expired bans to ban history
	local resultId = db.storeQuery("SELECT * FROM `account_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())
	if resultId ~= false then
		repeat
			local accountId = result.getDataInt(resultId, "account_id")
			db.query("INSERT INTO `account_ban_history` (`account_id`, `reason`, `banned_at`, `expired_at`, `banned_by`) VALUES (" .. accountId .. ", " .. db.escapeString(result.getDataString(resultId, "reason")) .. ", " .. result.getDataLong(resultId, "banned_at") .. ", " .. result.getDataLong(resultId, "expires_at") .. ", " .. result.getDataInt(resultId, "banned_by") .. ")")
			db.query("DELETE FROM `account_bans` WHERE `account_id` = " .. accountId)
		until not result.next(resultId)
		result.free(resultId)
	end

	-- Check house auctions
	local resultId = db.storeQuery("SELECT `id`, `highest_bidder`, `last_bid`, (SELECT `balance` FROM `players` WHERE `players`.`id` = `highest_bidder`) AS `balance` FROM `houses` WHERE `owner` = 0 AND `bid_end` != 0 AND `bid_end` < " .. os.time())
	if resultId ~= false then
		repeat
			local house = House(result.getDataInt(resultId, "id"))
			if house ~= nil then
				local highestBidder = result.getDataInt(resultId, "highest_bidder")
				local balance = result.getDataLong(resultId, "balance")
				local lastBid = result.getDataInt(resultId, "last_bid")
				if balance >= lastBid then
					db.query("UPDATE `players` SET `balance` = " .. (balance - lastBid) .. " WHERE `id` = " .. highestBidder)
					house:setOwnerGuid(highestBidder)
				end
				db.query("UPDATE `houses` SET `last_bid` = 0, `bid_end` = 0, `highest_bidder` = 0, `bid` = 0 WHERE `id` = " .. house:getId())
			end
		until not result.next(resultId)
		result.free(resultId)
	end
end
