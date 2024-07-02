return {
    setup = function()
        ps.sub("cd", function()
            local dir = tostring(cx.active.current.cwd)
            if string.find(dir, "Downloads") then
                ya.manager_emit("sort", { "created", reverse = true, dir_first = true })
            else
                ya.manager_emit("sort", { "alphabetical", reverse = false, dir_first = true })
            end
        end)
    end,
}