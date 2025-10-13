#pragma once

#include <string>

namespace plato
{
    class Logger
    {
    public:
        static void LogInfo(const std::string& message);
    };
}
