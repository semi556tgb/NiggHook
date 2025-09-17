return function(library)
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    RunService.Heartbeat:Connect(function()
        if library.flags.cframe_enabled then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local hrp = character.HumanoidRootPart
                local power = library.flags.cframe_value or 10
                hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * (power / 10))
            end
        end
    end)
end
