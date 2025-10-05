
ArrayList<Agent> agents = new ArrayList<Agent>();

float TARGET_X = 550;
float TARGET_Y = 200;

float START_X = 30;
float START_Y = 200;

int NUMBER_OF_AGENTS = 10;
int DEAD_COUNT = 0;
int GENERATION = 0;

int STEPS = 300;

ArrayList<PVector> best_path = new ArrayList<PVector>(STEPS);

void setup() {
  size(600, 400);
  frameRate(30);
  
  // order is important.
  // Path should be initialize before initialize agents.
  setup_initial_best_path();
  setup_agents();
}

void draw() {
  background(255);
  
  fill(0);
  rect(300, 140, 15, 100);
  
  // generation count text display
  textSize(30);
  fill(0, 408, 612);
  text("generation: "+ GENERATION, 400, 50);
  
  startLine();
  
  stroke(0);
  fill(255, 0, 0);
  circle(TARGET_X, TARGET_Y, 15);
  
  for (int i = 0; i < agents.size(); i++){
    Agent agent = agents.get(i);
    if (!agent.is_dead_status()){
      agent.update();
    }
  }
  
  if (DEAD_COUNT == NUMBER_OF_AGENTS){
      // add 1 to dead count
      DEAD_COUNT = 0;
      GENERATION += 1;
      // reset the dead status for all agents
      for (int j = 0; j < agents.size(); j++){
        Agent agentObj = agents.get(j);
        agentObj.switch_status();
      }
      set_best_agents_path();
    }
}

void set_best_agents_path(){
  int min_score = 1000;
  // initialize to be default first agent
  Agent selected_agent_for_breed = agents.get(0);
  for (int i = 0; i < agents.size(); i++){
    Agent agent = agents.get(i);
    if (agent.score < min_score){
      min_score = agent.score;
      selected_agent_for_breed = agent;
    }
  }
  // remove old content from best-path
  best_path.clear();
  for (PVector v: selected_agent_for_breed.path){
    best_path.add(v.copy());
  }
  for (int i = 0; i < agents.size(); i++){
    Agent agent = agents.get(i);
    agent.mutate();
  }
}

void mutation(){
  for (int i = STEPS-50; i < STEPS; i++){
    best_path.get(i).x += random(-5, 5);
    best_path.get(i).y += random(-5, 5);
  } 
}

void setup_initial_best_path(){
  PVector starting_point = new PVector(30, 200);
  float x, y;
  best_path.add(starting_point);
  
  for(int i = 1; i < STEPS; i++){
    x = best_path.get(i-1).x;
    y = best_path.get(i-1).y;
    
    best_path.add(new PVector(x + random(-5, 5), y + random(-5, 5)));
  }
}

void setup_agents(){
  for (int i = 0; i < NUMBER_OF_AGENTS; i++){
    Agent agent = new Agent(START_X, START_Y);
    agent.mutate();
    agents.add(new Agent(START_X, START_Y));
  }
}

class DrawLine{
  float x_pos, y_pos, lineWidthV, lineHeightV;
  String lineColorV;
  
  DrawLine(float x, float y, float lineWidth, float lineHeight, String lineColor){
    x_pos = x;
    y_pos = y;
    lineWidthV = lineWidth;
    lineHeightV = lineHeight;
    lineColorV = lineColor;
  }
  
  void update(){
    if(lineColorV == "green"){
      stroke(255);
      fill(0, 255, 0);
      rect(x_pos, y_pos, lineWidthV, lineHeightV);
    }else{
      stroke(255);
      fill(0);
      rect(x_pos, y_pos, lineWidthV, lineHeightV);
    }
  }
}

void startLine(){
  float lineWidth = 10;
  float lineHeight = 50;
  float x_pos = 30;
  float y_pos = 0;
  
  for(int i = 0; i < floor(height/lineHeight); i++){
    if (i % 2 == 0){
      new DrawLine(x_pos, y_pos + i*lineHeight, lineWidth, lineHeight, "green").update();
    }else{
      new DrawLine(x_pos, y_pos + i*lineHeight, lineWidth, lineHeight, "black").update();
    }
  }
}


class Agent{
  float x_pos, y_pos;
  Boolean is_dead = false;
  int no_of_steps = 0;
  int score;
  
  ArrayList<PVector> path;
  
  Agent(float x, float y){
    x_pos = x;
    y_pos = y;
    path = new ArrayList<PVector>();
    for(PVector v: best_path){
      path.add(v.copy());
    }
  }
  
  void update(){
    //x_pos = x_pos + random(1, 5);
    //y_pos = y_pos + random(-5, 5);
    
    if (no_of_steps >= STEPS){
      dead();
      return;
    }
    
    // setup best path for new generation
    x_pos = path.get(no_of_steps).x;
    y_pos = path.get(no_of_steps).y;
    
    // increate the step
    no_of_steps += 1;
    
    if (x_pos > width || x_pos < 0 || y_pos > height || y_pos < 0){
      dead();
    }
    
    if ((x_pos >= 300 && x_pos <= 315) && (y_pos >=  140 && y_pos <= 240)){
      dead();
    }
    
    fill(255, 255, 0);
    circle(x_pos, y_pos, 5);
    //path.add(new PVector(x_pos, y_pos));
  }
  
  void dead(){
    is_dead = true;
    // update dead count
    //DEAD_COUNT = (DEAD_COUNT + 1) % (NUMBER_OF_AGENTS + 1);
    DEAD_COUNT++;
    // set score
    score = calculateDistance();
    print(score);
    print("\n");    
  }
  
  void switch_status(){
    is_dead = !is_dead;
    no_of_steps = 0;
    x_pos = START_X;
    y_pos = START_Y;
    
    // update path
    path.clear();
    for(PVector v: best_path){
      path.add(v.copy());
    }
  }
  
  Boolean is_dead_status(){
    return is_dead;
  }
  
  void mutate(){
    for (int i = 0; i < STEPS; i++){
      path.get(i).x += random(-5, 5);
      path.get(i).y += random(-5, 5);
    } 
  }
  
  int calculateDistance(){
    // Euclidean distance calculation
    float value = dist(x_pos, y_pos, TARGET_X, TARGET_Y);
    return int(value);
  }
}
