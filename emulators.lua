return{
    ["snes"]={
        name="Retroarch (SNES)",
        command="flatpak run org.libretro.RetroArch",
        args={
            "-L","snes9x_libretro.so",
            "{rom}"
        }
    }
}