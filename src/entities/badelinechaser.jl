module BadelineChaser

placements = Dict{String, Main.EntityPlacement}(
    "Badeline Chaser" => Main.EntityPlacement(
        Main.Maple.DarkChaser
    ),
)

function selection(entity::Main.Maple.Entity)
    if entity.name == "darkChaser"
        x, y = Main.entityTranslation(entity)

        return true, Main.Rectangle(x - 2, y - 16, 12, 16)
    end
end

function render(ctx::Main.Cairo.CairoContext, entity::Main.Maple.Entity)
    if entity.name == "darkChaser"
        Main.drawSprite(ctx, "characters/badeline/idle00", 4, -16)

        return true
    end
end

end