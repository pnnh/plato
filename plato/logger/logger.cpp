#include "logger.h"

#include <iostream>

void plato::Logger::LogInfo(const std::string& message)
{
    std::cout << "[INFO] " << message << std::endl;
}
