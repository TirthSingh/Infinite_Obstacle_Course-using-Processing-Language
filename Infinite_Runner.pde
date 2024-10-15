// Game variables
float playerX = 200;
float playerY = 400;
float playerSpeed = 5;
float playerJump = -10;
float gravity = 0.5;
float playerVelY = 0;
float obstacleSpeed = 5;
float obstacleGap = 500;
float obstacleWidth = 30;
float Score = 0;

// Obstacle variables
float obstacleX = 800;
float obstacleY = 450;
float obstacleHeight = 50;

// Game states
boolean isJumping = false;
boolean isGameOver = false;

void setup() {
  size(800, 500);
  rectMode(CORNER);
  noStroke();
}

void draw() {
  background(135, 206, 235); // Sky blue

  // Draw player
  fill(255, 0, 0); // Red
  rect(playerX, playerY, 30, 30);

  // Update player position
  playerY += playerVelY;
  playerVelY += gravity;

  // Collision detection
  if (playerY > height - 30) {
    playerY = height - 30;
    playerVelY = 0;
    isJumping = false;
  }

  // Draw obstacle
  fill(0, 255, 0); // Green
  rect(obstacleX, obstacleY, obstacleWidth, obstacleHeight);

  // Update obstacle position
  obstacleX -= obstacleSpeed;

  // Obstacle reset
  if (obstacleX < -obstacleWidth) {
    obstacleX = width;
    obstacleY = (height - obstacleHeight);
    Score++;
  }
  if (Score%10==0){
  obstacleSpeed+=0.02;
  }
  

  // Collision detection
  if (dist(playerX, playerY, obstacleX, obstacleY) < 30) {
    isGameOver = true;
  }

  // Display score
  fill(0); // Black
  textSize(32);
  text("Score: " + int(Score), 20, 40);

  // Game over screen
  if (isGameOver) {
    background(255, 0, 0); // Red
    fill(255); // White
    textSize(64);
    text("Game Over!", width/2 - 150, height/2);
    fill(0);
    text("Press R to restart!", width/2 - 150, height/1.5);
    noLoop();
  }
}

void keyPressed() {
  if (key == ' ' && !isJumping) {
    playerVelY = playerJump;
    isJumping = true;
  }
  if (key == 'R' || key == 'r') {
    resetGame();
    loop(); // Resume the game loop
  }
}


void resetGame() {    
  // Reset all variables
  playerX = 200;
  playerY = 400;
  playerSpeed = 5;
  playerJump = -10;
  gravity = 0.5;
  playerVelY = 0;
  obstacleSpeed = 5;
  obstacleGap = 500;
  obstacleWidth = 30;
  Score = 0;
  
  // Reset obstacle variables
  obstacleX = 800;
  obstacleY = 450;
  obstacleHeight = 50;
  
  // Reset game states
  isJumping = false;
  isGameOver = false;
}
