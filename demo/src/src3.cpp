#include "header.hpp"

#define CHECK(foo) if(!(foo)) return 1;

int check_map(const map& m)
{
    std::string k = "asd";
    CHECK(m.size() == 1);
    CHECK(m.find(k) != m.end());
    CHECK(m.at(k).size() == 2);
    CHECK(m.at(k)[0] == 5);
    CHECK(m.at(k)[1] == 15);
    return 0;
}
