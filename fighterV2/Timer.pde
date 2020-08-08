class Timer {
  int startTime = 0, stopTime = 0;
  boolean running = false;
  void start() {
    startTime = millis();
    running = true;
  }
  void stop() {
    stopTime = millis();
    running = false;
  }
  int getElapsedTime() {
    int elapsed;
    if (running) {
      elapsed = (millis() - startTime);
    } else {
      elapsed = (stopTime - startTime);
    }
    return elapsed;
  }
  int millisecond() {
    return getElapsedTime()%1000;
  }

  int second() {
    return (getElapsedTime() / 1000) % 60;
  }
  int millisecond(int ct) {
    return ct%1000;
  }

  int second(int ct) {
    return ct/1000;
  }
}
