#include "header.hpp"

using namespace std;

int main()
{
    map m;
    add_at(m, "asd", 5);
    add_at(m, "asd", 15);
    return check_map(m);
}
