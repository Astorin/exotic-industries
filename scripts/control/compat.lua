local model = {}

--====================================================================================================
--MOD COMPATIBILITY
--====================================================================================================

function model.check_init()

    if game.tick ~= 1 then return end 

    -- K2
    ---------------------------------------------------------------------------
    if game.active_mods["Krastorio2"] then
        remote.call("kr-intergalactic-transceiver", "set_no_victory", true)
    end
    
end


function model.nth_tick(e)

    -- K2
    ---------------------------------------------------------------------------
    if game.active_mods["Krastorio2"] then

        local forces = game.forces

        -- check if the K2 logo tech is not hidden anymore
        for _, force in pairs(forces) do
            if force.technologies["kr-logo"].enabled then
                if not global.k2_win then
                    global.k2_win = true
                    game.print({"exotic-industries.k2-win"})
                    ei_planet_exploration.discover_new_space_destination(force, "deep-space")
                end
            end
        end
    
    end

end

--====================================================================================================
--Mod Interfaces
--====================================================================================================

-- add more surface that accept gaia buildings
remote.add_interface("exotic-industries", {
    add_gaia_surface = function(surface_name)
        if not global.gaia_surfaces then global.gaia_surfaces = {} end
        global.gaia_surfaces[surface_name] = true
    end,
    clear_gaia_surfaces = function()
        global.gaia_surfaces = nil
    end
})

return model