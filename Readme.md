# Application Example Traffic Light 

## Description

This application example shows how to use the state framework of the package `@simatic-ax/statemachine`. In this example a simple traffic light will be realized.

```mermaid
graph LR;
    
    Init-->|3s|Red;
    Red-->|1.5s|YellowRed;
    YellowRed-->|1.5s|Green;
    Green-->|1.5s|Yellow;
    Yellow-->|1.5s|CheckCycles;
    CheckCycles-->|1. after 5 cycles|Init
    CheckCycles-->|2. Alternatively|Init
```

## Contribution

Thanks for your interest in contributing. Anybody is free to report bugs, unclear documentation, and other problems regarding this repository in the Issues section or, even better, is free to propose any changes to this repository using Merge Requests.

## License and Legal information

Please read the [Legal information](LICENSE.md)