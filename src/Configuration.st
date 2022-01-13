USING Simatic.Ax.StateFramework;
USING Simatic.Ax.IO.Output;
USING Simatic.Ax.SimpleControlModules;

CONFIGURATION MyConfiguration
    TASK Main(Priority := 1);
    
    PROGRAM P1 WITH Main: MainProgram;
        
    VAR_GLOBAL
        
        StateController : StateController := (InitialState := InitState);
        TrafficLight : LightStackRdYeGnBl := (QRed := QRed, QYellow := QYellow, QGreen := QGreen);
        QRed : BinOutput;
        QYellow : BinOutput;
        QGreen : BinOutput;

        QRd AT %Q0.0 : BOOL;
        QYe AT %Q0.0 : BOOL;
        QGn AT %Q0.0 : BOOL;

        // Initial State
        InitGuard : TimeoutGuard := (Timeout := T#3000ms);
        Init2Red : Transition := (Guard := InitGuard, NextState := RedState);
        InitState : State1Transition;

        // State Red
        RedGuard : TimeoutGuard := (Timeout := T#1500ms);
        Red2RedYellow : Transition := (Guard := RedGuard, NextState := RedYellowState);
        RedState : State1Transition;

        // State RedYellow
        RedYellowGuard : TimeoutGuard := (Timeout := T#1500ms);
        RedYellowToGreen : Transition := (Guard := RedGuard, NextState := GreenState);
        RedYellowState : State1Transition;
        
        // State Green
        Green : TimeoutGuard := (Timeout := T#1500ms);
        Green2Yellow : Transition := (Guard := RedGuard, NextState := YellowState);
        GreenState : State1Transition;

        // State Yellow
        YellowGuard : TimeoutGuard := (Timeout := T#1500ms);
        Yellow2Count : Transition := (Guard := RedGuard, NextState := CycleCountState);
        YellowState : State1Transition;

        // Check Cycles
        CycleCountGuard : CountGuard := (count := LINT#5);
        CycleCountAlwaysTrueGuard : TrueGuard;
        CycleCountToInit : Transition := (Guard := CycleCountGuard, NextState := InitState);
        CycleCountToRed: Transition := (Guard := CycleCountAlwaysTrueGuard, NextState := RedState);
        CycleCountState : State2Transition := (StateID := 6, Transition1 := CycleCountToInit, transition2 := CycleCountToRed);
        
    END_VAR
END_CONFIGURATION
