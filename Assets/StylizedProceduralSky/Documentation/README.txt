EmacEArt Stylized Skybox - Godot 4
==================================

A stylized procedural sky for Godot 4: gradients, sun disc, haze, animated cel-shaded
clouds and a built-in color grading pass, all in one sky shader. Open
Scenes/SkyboxDemo.tscn and the finished picture is already there - nothing has to be run
and nothing is generated at startup.

Godot 4.7, Forward+ (it also runs on Mobile; Compatibility has not been tested).


WHAT IS IN THE BOX
------------------
Shaders/EA_Skybox.gdshader          the shader
Materials/EA_Skybox_Default.tres    preset: clear daylight sky
Materials/EA_Skybox_WarmDusk.tres   preset: warm low sun, muted blue zenith, banded clouds
Scenes/SkyboxDemo.tscn              demo scene: sky, sun, ground and three props
Scripts/DemoCamera.gd               demo camera
Scripts/SkyPresets.gd               runtime preset switch for the demo
Scenes/UI_ParameterPanel.tscn       the sliders you see in the demo
Scripts/UI_ParameterPanel.gd        makes those sliders work
Documentation/                      manual (PDF), contents list, licence


THE SLIDERS IN THE DEMO
-----------------------
Run the demo scene and you get a panel of sliders over the picture. Move one
and the sky changes straight away, so you can try things out and see the result
before you set anything up in your own scene. Press H to hide the panel when you
want a clean screenshot.

Moving the sliders does not change the two preset files that came with the
package. Close the demo, open it again, and the sky is back where it started.
When you find a look you like, write the numbers down and set them on your own
material - the demo will not do it for you.


USING IT IN YOUR OWN SCENE
--------------------------
1. Add a WorldEnvironment node.
2. Environment -> Background -> Mode: Sky.
3. Environment -> Sky -> New Sky, then Sky -> Sky Material -> load one of the .tres files
   from Materials/ (or New ShaderMaterial and assign Shaders/EA_Skybox.gdshader).
4. Environment -> Ambient Light -> Source: Sky, and Reflected Light -> Source: Sky, so the
   scene picks up the colors of the sky.
5. Add a DirectionalLight3D for the sun. Leave its Sky Mode at "Light and Sky".

Every parameter lives on the material, grouped in the inspector: Zenith and Horizon, Sun,
Sky Gradient, Atmosphere, Color Grading, Clouds.


THE SUN
-------
sun_follows_light ON  - the sun is drawn where the DirectionalLight3D points from, so the
                        sky, the shadows and the lighting agree without any extra work.
                        This is the recommended setting.
sun_follows_light OFF - the sun is drawn along sun_direction_manual and ignores the light.
                        Both shipped presets use this, and the demo scene rotates its
                        light to match.


CLOUDS
------
clouds_enabled turns them on. cloud_style picks the pattern:

  0  Standard   puffy patches of mixed sizes, lightly torn at the edges
  1  Feathered  thin fibrous streaks, high cirrus
  2  Round      separate rounded puffs with a gap between neighbours
  3  Diagonal   the standard pattern rotated 45 degrees, slanted bands
  4  Cotton     puffs grown together into larger lobed masses

cloud_bands above 1 breaks the cloud into that many flat steps - the cel-shaded look, with
the darkest step taking cloud_shadow_color and the brightest cloud_color. cloud_stretch
pulls the clouds into long streaks and cloud_swirl twists them; the last third of the
cloud_stretch slider is where the change becomes dramatic, below that it moves slowly
on purpose.


PERFORMANCE
-----------
Moving clouds also keep the scene lighting up to date, and that update is the part which
costs frames. If the sky is costing you frames, set Sky -> Process Mode to Incremental or
lower Sky -> Radiance Size - the clouds keep moving on screen either way. Turning clouds
off with clouds_enabled is the cheapest sky of all.


LICENSE
-------
EmacEArt Asset License. Use the shader, the presets, the scenes and the documentation
in your own projects, personal and commercial alike. No credit is required, though it
is always welcome. You may not sell or redistribute the assets themselves, on their
own, modified, or as part of another pack or template.
Full text: LICENSE.txt in this folder and in Documentation/.


SUPPORT
-------
Discord: https://discord.com/invite/ctXaf5Ftqw
If something does not work, say so there - a fix is faster than a refund.
