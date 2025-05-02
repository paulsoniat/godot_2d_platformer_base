# 🕹️ Godot 2D Platformer Base Template

A modular, component-driven 2D platformer base built in **Godot 4.4**, designed for quick prototyping and learning best practices in game development.

> 🎯 **Goal**: Provide a clean, extensible foundation for building feature-rich platformer games.

---

## ✨ Features

- ✅ **Component-Based Player** (Input, Movement, Jump, Dash, Wall Grab, Health, Audio, Animation)
- 🌄 **Parallax Background System**
- 🗺️ **Room Manager** with dynamic level loading
- 🔁 **Checkpoint System** for respawn logic
- 🎬 Modular `GameRoot` setup for global scene management
- 🎮 Plug-and-play **Player Scene** with configurable abilities
- 📦 Organized folder structure and ready-to-use assets

---

## 📁 Project Structure

```
platformerbase/
├── assets/                # Pixel art sprites (player, tileset, parallax)
├── scenes/                # Game scenes (levels, camera, player, world)
├── scripts/               # Modular ECS-style components
├── autoloads/             # Global autoload aspects
├── project.godot          # Godot project file
├── .gitignore             # Git version control settings
```

---

## 🚀 Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/godot-2d-platformer-base.git
   cd godot-2d-platformer-base
   ```

2. **Open in Godot 4.4+**

3. Press **Play ▶️** to test `GameRoot` as the main scene.

---

## 🧩 Components Included

Each component is a self-contained scene + script:

- `InputComponent`
- `MovementComponent`
- `JumpComponent`
- `WallComponent` (WIP)
- `DashComponent`
- `GravityComponent`
- `AnimationComponent`
- `AudioComponent` (WIP)
- `AttackComponent` (WIP)
- `CheckpointComponent`
- `DeathComponent`

> Easily extend by duplicating and modifying existing components.

---

## 🎨 Art Assets

Included:
- Simple player animations
- Tileset
- Single Background with foundation for parralax (currently WIP)
All assets are placeholder-friendly and can be replaced with your own.

---

## 🧪 Ideal For

- Solo devs prototyping 2D platformers
- Learning Godot 4’s scripting and node system
- Teaching modular game architecture

---

## 📄 License

MIT – free to use, modify, and share.

> Attribution is appreciated but not required.
