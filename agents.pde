import java.util.Collections;
import java.util.Comparator;

ArrayList<Agent> agents = new ArrayList<Agent>();
float TARGET_X = 550;
float TARGET_Y = 200;
float START_X = 30;
float START_Y = 200;
int NUMBER_OF_AGENTS = 10;
int DEAD_COUNT = 0;
int GENERATION = 0;
int STEPS = 120;
boolean showSuccess = false;
int successAgent = -1, successGeneration = -1;
ArrayList<PVector> best_path = new ArrayList<PVector>(STEPS);

void setup() {
  size(600, 400);
  frameRate(60);
  setup_initial_best_path();
  setup_agents();
}

void draw() {
  background(255);
  fill(0);
  rect(300, 140, 15, 100);

  textSize(30);
  fill(0, 408, 612);
  text("generation: "+GENERATION, 400, 50);

  startLine();
  stroke(0);
  fill(255, 0, 0);
  circle(TARGET_X, TARGET_Y, 15);

  for (int i = 0; i < agents.size(); i++) {
    Agent agent = agents.get(i);
    if (!agent.is_dead_status()) {
      agent.update(i);
      agent.render(i);
    }
  }

  if (showSuccess) {
    textSize(40);
    fill(0, 200, 0);
    text("Success!", width/2-90, height/2);
    textSize(18);
    fill(0);
    text("Agent " + successAgent + " reached target at Gen " + successGeneration, width/2-120, height/2+30);
    noLoop();
  }

  if (DEAD_COUNT == NUMBER_OF_AGENTS && !showSuccess) {
    DEAD_COUNT = 0;
    GENERATION++;
    next_generation();
  }
}

void next_generation() {
  Collections.sort(agents, new Comparator<Agent>() {
    public int compare(Agent a, Agent b) {
      return a.score - b.score;
    }
  });
  best_path.clear();
  for (PVector v : agents.get(0).path)
    best_path.add(v.copy());
  ArrayList<Agent> new_agents = new ArrayList<Agent>();
  Agent elite = new Agent(START_X, START_Y);
  for (int i = 0; i < STEPS; i++)
    elite.path.set(i, best_path.get(i).copy());
  new_agents.add(elite);
  for (int i = 1; i < NUMBER_OF_AGENTS; i++) {
    int parentA = int(random(NUMBER_OF_AGENTS/2));
    int parentB = int(random(NUMBER_OF_AGENTS/2));
    Agent child = crossover(agents.get(parentA), agents.get(parentB));
    child.mutate();
    new_agents.add(child);
  }
  agents = new_agents;
  for (Agent a : agents)
    a.switch_status();
}

Agent crossover(Agent p1, Agent p2) {
  Agent child = new Agent(START_X, START_Y);
  int cut = int(random(STEPS));
  for (int i = 0; i < STEPS; i++)
    child.path.set(i, (i < cut ? p1.path.get(i).copy() : p2.path.get(i).copy()));
  return child;
}

void setup_initial_best_path() {
  PVector starting_point = new PVector(START_X, START_Y);
  best_path.add(starting_point);
  for (int i = 1; i < STEPS; i++) {
    float x = best_path.get(i-1).x, y = best_path.get(i-1).y;
    best_path.add(new PVector(x + random(-5, 5), y + random(-5, 5)));
  }
}

void setup_agents() {
  for (int i = 0; i < NUMBER_OF_AGENTS; i++) {
    Agent agent = new Agent(START_X, START_Y);
    agent.mutate();
    agents.add(agent);
  }
}

class DrawLine {
  float x_pos, y_pos, lineWidthV, lineHeightV;
  String lineColorV;
  DrawLine(float x, float y, float lineWidth, float lineHeight, String lineColor){
    x_pos = x; y_pos = y;
    lineWidthV = lineWidth; lineHeightV = lineHeight;
    lineColorV = lineColor;
  }
  void update(){
    if(lineColorV == "green"){
      stroke(255); fill(0,255,0);
      rect(x_pos, y_pos, lineWidthV, lineHeightV);
    }else{
      stroke(255); fill(0);
      rect(x_pos, y_pos, lineWidthV, lineHeightV);
    }
  }
}

void startLine(){
  float lineWidth = 10, lineHeight = 50, x_pos = 30, y_pos = 0;
  for (int i = 0; i < floor(height/lineHeight); i++) {
    if (i % 2 == 0)
      new DrawLine(x_pos, y_pos + i*lineHeight, lineWidth, lineHeight, "green").update();
    else
      new DrawLine(x_pos, y_pos + i*lineHeight, lineWidth, lineHeight, "black").update();
  }
}

class Agent {
  float x_pos, y_pos;
  Boolean is_dead = false;
  int no_of_steps = 0, score;
  ArrayList<PVector> path;
  Agent(float x, float y){
    x_pos = x; y_pos = y;
    path = new ArrayList<PVector>();
    for(PVector v: best_path)
      path.add(v.copy());
  }
  void update(int idx){
    if (no_of_steps >= STEPS){
      dead(); return;
    }
    x_pos = path.get(no_of_steps).x;
    y_pos = path.get(no_of_steps).y;
    no_of_steps++;
    if (x_pos > width || x_pos < 0 || y_pos > height || y_pos < 0)
      dead();
    if ((x_pos >= 300 && x_pos <= 315) && (y_pos >= 140 && y_pos <= 240))
      dead();
    if (!showSuccess && dist(x_pos, y_pos, TARGET_X, TARGET_Y) < 10) {
      showSuccess = true; 
      successAgent = idx;
      successGeneration = GENERATION;
    }
  }
  void render(int idx) {
    if (idx == 0) { fill(255,0,0); ellipse(x_pos, y_pos,14,14); }
    else {
      colorMode(HSB,360,255,255);
      fill(idx*(360/NUMBER_OF_AGENTS),200,220);
      ellipse(x_pos,y_pos,9,9);
      colorMode(RGB);
    }
  }
  void dead(){ is_dead = true; DEAD_COUNT++; score = calculateDistance(); }
  void switch_status(){ is_dead = false; no_of_steps = 0; x_pos = START_X; y_pos = START_Y; }
  Boolean is_dead_status(){ return is_dead; }
  void mutate(){
    for (int i = STEPS-40; i < STEPS; i++) {
      path.get(i).x += random(-5, 5);
      path.get(i).y += random(-5, 5);
    }
  }
  int calculateDistance(){ return int(dist(x_pos, y_pos, TARGET_X, TARGET_Y)); }
}
