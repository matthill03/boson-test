#include "boson/application.h"

int main() {
    boson::Application app({ 1280, 720, "Hello World", {1.0f, 0.0f, 0.0f} });
    app.run();
    return 0;
}
