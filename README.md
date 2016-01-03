#Add Primitives

###Features
**Primitives**:
  * Box
  * Capsule
  * Circle
  * Cone
  * Cylinder
  * Plane
  * Solid
  * Sphere
  * Torus
  * Tube
  * Wedge
  * Stair(Linear, Curved, Spiral)
  * C Box
  * Disc
  * Ellipse
  * Ellipsoid
  * L Box
  * Pyramid
  * Torus Knot

**Modifier System**:
  * Twist
  * Shear
  * Taper
  * Array
  * Offset
  * Random
  * UV Transform

###Install

#####Using install.py (Linux and OSX)
```
git clone https://github.com/TheHX/add_primitives.git
cd add_primitives
python install.py
```

#####Manual Install
Just copy and paste the 'Add Primitives' folder into godot plugins folder:

* Windows: **%APPDATA%\Godot\plugins**
* Linux/OSX: **~/.godot/plugins/**

###Usage
Open Godot, and in editor go to Settings->Editor Settings, and select "Plugins" tab, and enable the plugin. 

If you don't see the plugin, click on reload button. If it don't appear, check if the plugin is in the 
right folder. Else you can open a issue to see what's is wrong.

After enabling the plugin:

1. Add, or select, a ```Spatial``` or any ```CollisionObject``` node
3. A menu will appear on 3D editor toolbar
4. Select a primitive, and it'll be added to the selected Spatial node
5. A window will appear, where you can edit the primitive parameters

###License
This plugin is licensed under the [MIT license](https://github.com/TheHX/add_primitives/blob/master/LICENSE.md).

###Contributing
If you want contribute to this plugin, read [CONTRIBUTING.md](https://github.com/TheHX/add_primitives/blob/master/CONTRIBUTING.md).

