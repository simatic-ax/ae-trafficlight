USING Simatic.Ax.Stateframework;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE ApplicationStateFramwerok
    CLASS StateYellow EXTENDS State1Transition

        VAR  PUBLIC
            LightStack : REF_TO LightStackRdYeGnBl;
        END_VAR

        METHOD PUBLIC OVERRIDE OnEntry
            LightStack^.SwitchOn(Colors#Yellow);
        END_METHOD

        METHOD PUBLIC OVERRIDE OnExit
            LightStack^.SwitchOff(Colors#Yellow);
        END_METHOD

        METHOD PUBLIC OVERRIDE Action
            ;
        END_METHOD

    END_CLASS 
END_NAMESPACE
