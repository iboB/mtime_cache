#include <iostream>
#include <unordered_map>
#include <string>

typedef std::unordered_map<std::string, std::vector<int>> map;

void add_at(map& m, const std::string& key, int n);
int check_map(const map& m);
