local modRoot = "__crushing-industry-realistic-ores-compatibility__"

local function updateCrushedOreItem(oreName)
    local item = data.raw.item["crushed-" .. oreName .. "-ore"]
    if item then
        item.icon = modRoot .. "/graphics/icons/crushed-" .. oreName .. "-ore.png"
        item.icon_size = 64
        
        if item.pictures then
            for i = 1, math.min(#item.pictures, 3) do
                item.pictures[i].filename = modRoot .. "/graphics/icons/crushed-" .. oreName .. "-ore" .. (i == 1 and "" or ("-" .. (i - 1))) .. ".png"
                item.pictures[i].size = 64
                if oreName == "tungsten" and item.pictures[i].mipmap_count then
                    item.pictures[i].mipmap_count = nil
                end
            end
            while #item.pictures > 3 do
                table.remove(item.pictures)
            end
        else
            item.pictures = {
                {size=64, filename=modRoot .. "/graphics/icons/crushed-" .. oreName .. "-ore.png", scale=0.5},
                {size=64, filename=modRoot .. "/graphics/icons/crushed-" .. oreName .. "-ore-1.png", scale=0.5},
                {size=64, filename=modRoot .. "/graphics/icons/crushed-" .. oreName .. "-ore-2.png", scale=0.5}
            }
        end
    end
end

local function updateRecipeIcon(recipeName, oreName)
    local recipe = data.raw.recipe[recipeName]
    if recipe then
        if not recipe.icons then
            recipe.icons = {}
        end
        if recipe.icons[1] then
            recipe.icons[1].icon = modRoot .. "/graphics/icons/crushed-" .. oreName .. "-ore.png"
            recipe.icons[1].icon_size = 64
            if not recipe.icons[1].shift then recipe.icons[1].shift = {0, -3} end
            if not recipe.icons[1].scale then recipe.icons[1].scale = 0.4 end
        else
            recipe.icons[1] = {
                icon = modRoot .. "/graphics/icons/crushed-" .. oreName .. "-ore.png",
                icon_size = 64,
                shift = {0, -3},
                scale = 0.4
            }
        end
    end
end

updateCrushedOreItem("iron")
updateCrushedOreItem("copper")

updateRecipeIcon("crushed-iron-smelting", "iron")
updateRecipeIcon("crushed-copper-smelting", "copper")
updateRecipeIcon("crushed-iron-ore", "iron")
updateRecipeIcon("crushed-copper-ore", "copper")

if mods["RealisticOresForSpaceAge"] then
    updateCrushedOreItem("tungsten")
end
