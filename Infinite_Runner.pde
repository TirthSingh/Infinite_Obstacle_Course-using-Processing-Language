// Game variables
float playerX = 200;
float playerY = 370;  // Moved up to make room for legs
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

  // Draw stickman (replacing the rectangle)
  fill(0); // Black for the stickman
  stroke(0); // Black outline
  strokeWeight(2); // Thicker lines for the stickman

  // Draw head (circle)
  ellipse(playerX + 15, playerY - 30, 20, 20); // Head positioned higher up

  // Draw body (line)
  line(playerX + 15, playerY - 20, playerX + 15, playerY + 10); // Body from neck to waist

  // Draw arms (lines)
  line(playerX, playerY - 10, playerX + 30, playerY - 10); // Arms stretched out

  // Draw legs (lines)
  line(playerX + 15, playerY + 10, playerX + 5, playerY + 40); // Left leg
  line(playerX + 15, playerY + 10, playerX + 25, playerY + 40); // Right leg
if (isJumping) {
  // Head moves up when jumping
  ellipse(playerX + 15, playerY - 30 - sin(playerVelY * 0.2) * 10, 20, 20); 

  // Legs bend slightly when jumping
  line(playerX + 15, playerY + 10, playerX + 10, playerY + 40 - sin(playerVelY * 0.2) * 5); // Left leg
  line(playerX + 15, playerY + 10, playerX + 20, playerY + 40 - sin(playerVelY * 0.2) * 5); // Right leg

  // Arms lift slightly
  line(playerX + 15, playerY - 10, playerX + 30 - cos(playerVelY * 0.2) * 5, playerY); // Right arm
  line(playerX + 15, playerY - 10, playerX - cos(playerVelY * 0.2) * 5, playerY); // Left arm
} else {
  // Normal standing stickman code here
}
  // Update player position
  playerY += playerVelY;
  playerVelY += gravity;

  // Collision detection with ground
  if (playerY > height - 40) {
    playerY = height - 40;
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
    obstacleY = height - obstacleHeight;
    Score++;
  }

  // Speed up obstacles after every 10 points
  if (Score % 10 == 0 && Score != 0) {
    obstacleSpeed += 0.02;
  }

  // Collision detection between player and obstacle
  if (dist(playerX + 15, playerY + 15, obstacleX + obstacleWidth / 2, obstacleY + obstacleHeight / 2) < 30) {
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
    text("Game Over!", width / 2 - 150, height / 2);
    fill(0);
    text("Press R to restart!", width / 2 - 150, height / 1.5);
    noLoop();
  }
}

void keyPressed() {
  if (key == ' ' && !isJumping) {
    playerVelY = playerJump;
    isJumping = true;
  }

  // Reset the game on 'R' key press
  if (key == 'R' || key == 'r') {
    resetGame();
    loop(); // Resume the game loop
  }
}

// Function to reset the game
void resetGame() {    
  // Reset all variables
  playerX = 200;
  playerY = 370; // Moved up to make stickman more visible
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
