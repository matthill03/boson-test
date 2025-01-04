#include "boson/application.h"

int main() {
    boson::Application app({1080, 720, "Hello World"});
    app.run();
    return 0;
}
