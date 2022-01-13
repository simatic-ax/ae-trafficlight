USING Simatic.Ax.StateFramework;
USING Simatic.Ax.IO.Output;
USING Simatic.Ax.SimpleControlModules;

PROGRAM MainProgram
    VAR_EXTERNAL
        StateController : StateController;
        TrafficLight : LightStackRdYeGnBl;
    
        QRd : BOOL;
        QYe : BOOL;
        QGn : BOOL;
    END_VAR

    StateController.Execute();
    QRd := TrafficLight.GetState(Colors#Red);
    QYe := TrafficLight.GetState(Colors#Yellow);
    QGn := TrafficLight.GetState(Colors#Green);

END_PROGRAM