local room = {}

room.empty = function(surface, cell_left_top, direction)
	
end

room.single_worm = function(surface, cell_left_top, direction)	
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	surface.create_entity({name = get_worm(), position = {x = left_top.x + grid_size * 0.5, y = left_top.y + grid_size * 0.5}, force = "enemy"})
end

room.single_nest = function(surface, cell_left_top, direction)	
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	if math.random(1,4) == 1 then
		surface.create_entity({name = "spitter-spawner", position = {x = left_top.x + grid_size * 0.5, y = left_top.y + grid_size * 0.5}, force = "enemy"})
	else
		surface.create_entity({name = "biter-spawner", position = {x = left_top.x + grid_size * 0.5, y = left_top.y + grid_size * 0.5}, force = "enemy"})
	end
end

room.biters = function(surface, cell_left_top, direction)
	local amount = math.random(1, math.floor(1 + (global.maze_depth * 0.3)))
	local tile_positions = {}
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	for x = 0.5, grid_size - 0.5, 1 do
		for y = 0.5, grid_size - 0.5, 1 do
			local pos = {left_top.x + x, left_top.y + y}
			tile_positions[#tile_positions + 1] = pos
		end
	end
	
	table.shuffle_table(tile_positions)
	
	for _, pos in pairs(tile_positions) do
		surface.create_entity({name = get_biter(), position = pos, force = "enemy"})
		amount = amount - 1
		if amount < 1 then break end
	end		
end

room.spitters = function(surface, cell_left_top, direction)
	local amount = math.random(1, math.floor(1 + (global.maze_depth * 0.3)))
	local tile_positions = {}
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	for x = 0.5, grid_size - 0.5, 1 do
		for y = 0.5, grid_size - 0.5, 1 do
			local pos = {left_top.x + x, left_top.y + y}
			tile_positions[#tile_positions + 1] = pos
		end
	end
	
	table.shuffle_table(tile_positions)
	
	for _, pos in pairs(tile_positions) do
		surface.create_entity({name = get_spitter(), position = pos, force = "enemy"})
		amount = amount - 1
		if amount < 1 then break end
	end		
end

room.checkerboard_ore = function(surface, cell_left_top, direction)
	local ores = {"coal", "iron-ore", "copper-ore", "stone"}
	table.shuffle_table(ores)
	
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	for x = 1, grid_size - 2, 1 do
		for y = 1, grid_size - 2, 1 do
			local pos = {left_top.x + x, left_top.y + y}
			if x % 2 == y % 2 then
				surface.create_entity({name = ores[1], position = pos, force = "neutral", amount = 256 + global.maze_depth * 4})
			else
				surface.create_entity({name = ores[2], position = pos, force = "neutral", amount = 256 + global.maze_depth * 4})
			end
			surface.set_tiles({{name = "grass-2", position = pos}}, true)
		end
	end
end

room.tons_of_trees = function(surface, cell_left_top, direction)
	local tree = tree_raffle[math.random(1, #tree_raffle)]
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	for x = 0.5, grid_size - 0.5, 1 do
		for y = 0.5, grid_size - 0.5, 1 do
			local pos = {left_top.x + x, left_top.y + y}
			if math.random(1,2) ~= 1 then
				surface.create_entity({name = tree, position = pos, force = "neutral"})
			end
		end
	end
end

room.single_rock = function(surface, cell_left_top, direction)
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	surface.create_entity({name = rock_raffle[math.random(1, #rock_raffle)], position = {left_top.x + grid_size * 0.5, left_top.y + grid_size * 0.5}, force = "neutral"})	
end

room.three_rocks = function(surface, cell_left_top, direction)
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	surface.create_entity({name = rock_raffle[math.random(1, #rock_raffle)], position = {left_top.x + grid_size * 0.2, left_top.y + grid_size * 0.8}, force = "neutral"})
	surface.create_entity({name = rock_raffle[math.random(1, #rock_raffle)], position = {left_top.x + grid_size * 0.8, left_top.y + grid_size * 0.8}, force = "neutral"})
	surface.create_entity({name = rock_raffle[math.random(1, #rock_raffle)], position = {left_top.x + grid_size * 0.5, left_top.y + grid_size * 0.2}, force = "neutral"})
end

room.quad_rocks = function(surface, cell_left_top, direction)
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	surface.create_entity({name = rock_raffle[math.random(1, #rock_raffle)], position = {left_top.x + grid_size * 0.15, left_top.y + grid_size * 0.15}, force = "neutral"})
	surface.create_entity({name = rock_raffle[math.random(1, #rock_raffle)], position = {left_top.x + grid_size * 0.15, left_top.y + grid_size * 0.85}, force = "neutral"})
	surface.create_entity({name = rock_raffle[math.random(1, #rock_raffle)], position = {left_top.x + grid_size * 0.85, left_top.y + grid_size * 0.15}, force = "neutral"})
	surface.create_entity({name = rock_raffle[math.random(1, #rock_raffle)], position = {left_top.x + grid_size * 0.85, left_top.y + grid_size * 0.85}, force = "neutral"})
end

room.tons_of_rocks = function(surface, cell_left_top, direction)
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	for x = 0.5, grid_size - 0.5, 1 do
		for y = 0.5, grid_size - 0.5, 1 do
			local pos = {left_top.x + x, left_top.y + y}
			if math.random(1,4) ~= 1 then
				surface.create_entity({name = rock_raffle[math.random(1, #rock_raffle)], position = pos, force = "neutral"})
			end
		end
	end
end

room.lots_of_rocks = function(surface, cell_left_top, direction)
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	for x = 0.5, grid_size - 0.5, 1 do
		for y = 0.5, grid_size - 0.5, 1 do
			local pos = {left_top.x + x, left_top.y + y}
			if math.random(1,2) ~= 1 then
				surface.create_entity({name = rock_raffle[math.random(1, #rock_raffle)], position = pos, force = "neutral"})
			end
		end
	end
end

room.some_scrap = function(surface, cell_left_top, direction)
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	for x = math.floor(grid_size * 0.15), math.floor(grid_size * 0.85) - 1, 1 do
		for y = math.floor(grid_size * 0.15), math.floor(grid_size * 0.85) - 1, 1 do
			local pos = {left_top.x + x, left_top.y + y}
			if math.random(1,16) == 1 then
				surface.create_entity({name = "mineable-wreckage", position = pos, force = "neutral"})
			end
		end
	end
end

room.lots_of_scrap = function(surface, cell_left_top, direction)
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	for x = 0.5, grid_size - 0.5, 1 do
		for y = 0.5, grid_size - 0.5, 1 do
			local pos = {left_top.x + x, left_top.y + y}
			if math.random(1,8) == 1 then
				surface.create_entity({name = "mineable-wreckage", position = pos, force = "neutral"})
			end
		end
	end
end

room.tons_of_scrap = function(surface, cell_left_top, direction)
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	for x = 0.5, grid_size - 0.5, 1 do
		for y = 0.5, grid_size - 0.5, 1 do
			local pos = {left_top.x + x, left_top.y + y}
			if math.random(1,2) == 1 then
				surface.create_entity({name = "mineable-wreckage", position = pos, force = "neutral"})
			end
		end
	end
end

room.pond = function(surface, cell_left_top, direction)
	local left_top = {x = cell_left_top.x * grid_size, y = cell_left_top.y * grid_size}
	for x = math.floor(grid_size * 0.25), math.floor(grid_size * 0.75) - 1, 1 do
		for y = math.floor(grid_size * 0.25), math.floor(grid_size * 0.75) - 1, 1 do
			local pos = {left_top.x + x, left_top.y + y}
			surface.set_tiles({{name = "water", position = pos}}, true)
		end
	end
end

local room_weights = {		
	{func = room.biters, weight = 25},
	{func = room.spitters, weight = 15},
	{func = room.single_worm, weight = 15},
	{func = room.single_nest, weight = 8},
	
	{func = room.tons_of_trees, weight = 15},	
	
	{func = room.lots_of_rocks, weight = 25},
	{func = room.tons_of_rocks, weight = 15},	
	{func = room.quad_rocks, weight = 10},
	{func = room.three_rocks, weight = 3},
	{func = room.single_rock, weight = 10},
	
	{func = room.checkerboard_ore, weight = 5},
	--{func = room.some_scrap, weight = 10},
	{func = room.lots_of_scrap, weight = 5},
	--{func = room.tons_of_scrap, weight = 2},
	{func = room.empty, weight = 1},
	
	{func = room.pond, weight = 10}
}

local room_shuffle = {}
for _, r in pairs(room_weights) do
	for c = 1, r.weight, 1 do
		room_shuffle[#room_shuffle + 1] = r.func
	end
end


return room_shuffle