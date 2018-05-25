module SeekerBarrier

placements = Dict{String, Main.EntityPlacement}(
    "Seeker Barrier" => Main.EntityPlacement(
        Main.Maple.BlockField,
        "rectangle"
    )
)

function minimumSize(entity::Main.Maple.Entity)
    if entity.name == "blockField"
        return true, 8, 8
    end
end

function nodeLimits(entity::Main.Maple.Entity)
    if entity.name == "blockField"
        return true, 0, 1
    end
end

function resizable(entity::Main.Maple.Entity)
    if entity.name == "blockField"
        return true, true, true
    end
end

function selection(entity::Main.Maple.Entity)
    if entity.name == "blockField"
        x, y = Main.entityTranslation(entity)

        width = Int(get(entity.data, "width", 8))
        height = Int(get(entity.data, "height", 8))

        nodes = get(entity.data, "nodes", ())
        if isempty(nodes)
            return true, Main.Rectangle(x, y, width, height)

        else
            nx, ny = Int.(nodes[1])
            return true, [Main.Rectangle(x, y, width, height), Main.Rectangle(nx, ny, width, height)]
        end
    end
end

function renderBlockField(ctx::Main.Cairo.CairoContext, x::Number, y::Number, width::Number, height::Number)
    Main.Cairo.save(ctx)

    Main.set_antialias(ctx, 1)
    Main.set_line_width(ctx, 1);

    Main.drawRectangle(ctx, x, y, width, height, (0.0, 0.0, 0.0, 0.4), (1.0, 1.0, 1.0, 1.0))

    Main.restore(ctx)
end

function renderSelectedAbs(ctx::Main.Cairo.CairoContext, entity::Main.Maple.Entity)
    if entity.name == "blockField"
        x, y = Main.entityTranslation(entity)
        nodes = get(entity.data, "nodes", ())

        width = Int(get(entity.data, "width", 8))
        height = Int(get(entity.data, "height", 8))
        
        if !isempty(nodes)
            nx, ny = Int.(nodes[1])

            cox, cyx = floor(Int, width / 2), floor(Int, height / 2)

            renderBlockField(ctx, nx, ny, width, height)
            Main.drawArrow(ctx, x + cox, y + cyx, nx + cox, ny + cyx, Main.colors.selection_selected_fc, headLength=6)
        end
    end
end

function render(ctx::Main.Cairo.CairoContext, entity::Main.Maple.Entity, room::Main.Maple.Room)
    if entity.name == "blockField"
        x = Int(get(entity.data, "x", 0))
        y = Int(get(entity.data, "y", 0))

        width = Int(get(entity.data, "width", 32))
        height = Int(get(entity.data, "height", 32))

        renderBlockField(ctx, 0, 0, width, height)

        return true
    end

    return false
end

end
