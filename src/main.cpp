#include "boson/application.h"

int main() {
    boson::Application app("../examples/basic_scene.jsonl");
    app.run();
    return 0;
}
