#include "header.hpp"

void add_at(map& m, const std::string& key, int n)
{
    m[key].push_back(n);
}
