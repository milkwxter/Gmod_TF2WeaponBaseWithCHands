if CLIENT then
    -- zoom fraction (0 = unzoomed, 1 = fully zoomed)
    local zoomFrac = 0
    local zoomTime = 0.15
	
    -- my helper
    local function UsingMyBase(ply)
        if not IsValid(ply) then return false end
        local wep = ply:GetActiveWeapon()
        return IsValid(wep) and wep.Base == "weapon_tf2milkbase"
    end

    hook.Add("CalcView", "mb_1p_calcview", function(ply, pos, ang, fov)
        if ply ~= LocalPlayer() then return end
        if not UsingMyBase(ply) then return end
		
        -- zoom logic: continuous fraction, no brittle state machine
        local wep = ply:GetActiveWeapon()
        local zooming = false
        local zoomFOV = 20
        local baseFOV = ply:GetInfoNum("fov_desired", 90)

        if IsValid(wep) then
            if wep.GetZoomed then
                zooming = wep:GetZoomed()
            elseif wep.IsZoomed then
                zooming = wep:IsZoomed()
            end
            if wep.ZoomFOV then
                zoomFOV = wep.ZoomFOV
            end
        end

        -- move zoomFrac towards 1 when zooming, 0 when not
        local targetFrac = zooming and 1 or 0
        local step = FrameTime() / zoomTime
        zoomFrac = math.Approach(zoomFrac, targetFrac, step)

        -- final FOV
        local outFOV = Lerp(zoomFrac, baseFOV, zoomFOV)
		
        return {
            origin = origin,
            angles = angles,
            fov = outFOV,
            drawviewer = false
        }
    end)
end
