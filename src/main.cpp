#include "boson/application.h"

int main() {
    boson::Application app({1280, 720, "Hello World"});
    app.run();
    return 0;
}
