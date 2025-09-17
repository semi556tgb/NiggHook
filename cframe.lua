return function(library)
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")

    local LocalPlayer = Players.LocalPlayer
    local moving = {
        W = false,
        A = false,
        S = false,
        D = false
    }

    -- Key input handling
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.W then moving.W = true end
        if input.KeyCode == Enum.KeyCode.A then moving.A = true end
        if input.KeyCode == Enum.KeyCode.S then moving.S = true end
        if input.KeyCode == Enum.KeyCode.D then moving.D = true end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.W then moving.W = false end
        if input.KeyCode == Enum.KeyCode.A then moving.A = false end
        if input.KeyCode == Enum.KeyCode.S then moving.S = false end
        if input.KeyCode == Enum.KeyCode.D then moving.D = false end
    end)

    -- Movement loop
    RunService.Heartbeat:Connect(function()
        if library.flags.cframe_enabled then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local hrp = character.HumanoidRootPart
                local power = (library.flags.cframe_value or 10) / 10

                -- Build movement vector from WASD
                local direction = Vector3.zero
                if moving.W then direction = direction + hrp.CFrame.LookVector end
                if moving.S then direction = direction - hrp.CFrame.LookVector end
                if moving.A then direction = direction - hrp.CFrame.RightVector end
                if moving.D then direction = direction + hrp.CFrame.RightVector end

                if direction.Magnitude > 0 then
                    hrp.CFrame = hrp.CFrame + (direction.Unit * power)
                end
            end
        end
    end)
end
