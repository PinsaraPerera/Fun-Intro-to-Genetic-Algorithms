# Fun Intro to Genetic Algorithms 🧬

A fascinating pathfinding simulation where little agents teach themselves to navigate around obstacles using the power of evolution!

![Genetic Algorithm Demo](GA.gif)

## 🎯 What is this?

While Genetic Algorithms (GAs) are a foundational concept in machine learning, I've always been fascinated by their elegant simplicity. To get my hands dirty again, I recently built this fun pathfinding simulation where little agents teach themselves how to navigate a maze.

It got me thinking: **What if you could solve complex problems by mimicking nature's oldest and most powerful trick: evolution?**

That's the core idea behind Genetic Algorithms. This project demonstrates what a GA is, breaks down its core components, and shows how I used one to teach agents to find the best path through a simple maze.

## 🔬 How It Works

### The Setup
- **Agents**: 10 yellow circular agents start at the left side of the screen
- **Target**: Red circle on the right side that agents need to reach
- **Obstacle**: Black barrier that agents must navigate around
- **Goal**: Find the optimal path from start to target while avoiding obstacles

### The Evolution Process

1. **Initialization**: Each agent gets a random path (sequence of movement vectors)
2. **Simulation**: Agents follow their paths simultaneously, with the best agent highlighted in red
3. **Fitness Evaluation**: Agents are scored based on distance to target
4. **Selection**: Agents are sorted by fitness, with the best performers selected as parents
5. **Crossover**: Child agents inherit path segments from two parent agents
6. **Mutation**: Random variations are added to the last part of each agent's path
7. **Elitism**: The best agent from each generation survives unchanged
8. **Success Detection**: Simulation stops when an agent successfully reaches the target!

![Generation 1](GA1.png) ![Generation Later](GA2.png)

### Key Genetic Algorithm Components

- **Population**: 10 agents per generation with color-coded visualization
- **Genome**: Each agent's path (120 movement steps)
- **Fitness Function**: Euclidean distance to target (lower = better)
- **Selection**: Tournament selection from top 50% of population
- **Mutation**: Targeted mutations on the final 40 steps of the path
- **Crossover**: Single-point crossover between two parent agents
- **Elitism**: Best agent automatically survives to next generation

## 🚀 Getting Started

### Prerequisites
- [Processing IDE](https://processing.org/download/) (version 3.0 or higher)

### Running the Simulation
1. Clone this repository:
   ```bash
   git clone https://github.com/PinsaraPerera/Fun-Intro-to-Genetic-Algorithms.git
   ```
2. Open `agents.pde` in Processing IDE
3. Click the "Run" button or press `Ctrl+R`
4. Watch the magic happen! 🎭

### What You'll See
- Colorful agents moving from left to right (red = best performer, others in rainbow colors)
- A generation counter showing evolutionary progress
- Agents getting progressively better at avoiding the obstacle
- **Success message** when an agent finally reaches the target!
- The simulation stops automatically upon success, showing which agent and generation achieved it

## 🎛️ Customization

You can tweak various parameters to experiment:

```processing
int NUMBER_OF_AGENTS = 10;     // Population size
int STEPS = 120;               // Path length (genome size)
float TARGET_X = 550;          // Target position
float TARGET_Y = 200;
int frameRate = 60;            // Simulation speed
```

### Try These Experiments:
- **Increase population size**: More diversity but slower evolution
- **Adjust mutation rate**: Change the random range in the `mutate()` function
- **Move the obstacle**: Modify the barrier position in `draw()`
- **Add more obstacles**: Create a more complex maze
- **Change crossover point**: Modify where parent paths are combined
- **Adjust mutation scope**: Change which steps get mutated (currently last 40)

## 🧠 Learning Outcomes

This simulation demonstrates key concepts:

- **Emergent Behavior**: Complex pathfinding emerges from simple rules
- **Natural Selection**: Better solutions naturally dominate through sorting
- **Genetic Recombination**: Crossover combines successful strategies from multiple parents
- **Targeted Mutation**: Strategic mutations focus on the end of paths for fine-tuning
- **Elitist Strategy**: Preserving the best solution while exploring variations
- **Success Convergence**: Evolution naturally leads to problem-solving success

## 🔧 Technical Details

### Core Classes
- **Agent**: Represents individual organisms with position, path, fitness, and color-coded rendering
- **DrawLine**: Handles the visual starting line indicator

### Key Functions
- `next_generation()`: Implements elitist selection with crossover and mutation
- `crossover()`: Creates child agents by combining parent paths at random cut points
- `mutate()`: Introduces targeted random variations in the final path segments
- `calculateDistance()`: Fitness evaluation using Euclidean distance

### Evolution Strategy
This implementation uses an **Elitist Genetic Algorithm** with:
- **Fitness-proportionate selection** from top 50% of population
- **Single-point crossover** between two randomly selected parents
- **Targeted mutation** on the last 40 movement steps
- **Elitism** ensuring the best agent always survives
- **Success detection** to automatically stop when target is reached

## 🎯 Future Enhancements

- [ ] Implement different crossover strategies (multi-point, uniform)
- [ ] Add dynamic obstacles that move between generations
- [ ] Implement tournament selection with different tournament sizes
- [ ] Add real-time parameter adjustment with keyboard controls
- [ ] 3D environment navigation
- [ ] Multi-objective optimization (speed + efficiency + path smoothness)
- [ ] Population diversity metrics and visualization
- [ ] Different mutation strategies (Gaussian, adaptive)

## 🤝 Contributing

Feel free to experiment and improve! Some ideas:
- Add new obstacle types
- Implement different mutation strategies
- Create more complex fitness functions
- Add visualization of the evolutionary process

## 📚 Learn More

Want to dive deeper into Genetic Algorithms?
- [Introduction to Genetic Algorithms](https://en.wikipedia.org/wiki/Genetic_algorithm)
- [Processing Documentation](https://processing.org/reference/)
- [Evoluation of Code (The coding train)](https://youtu.be/9zfeTw-uFCw?si=WmWqwNFC_gPlAIS1)

## 📄 License

This project is open source and available under the [MIT License]().

---

**Happy Evolving!** 🧬✨

*Built with ❤️ using Processing*