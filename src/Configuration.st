USING Simatic.Ax.StateFramework;
USING Simatic.Ax.IO.Output;
USING Simatic.Ax.SimpleControlModules;
USING ApplicationStateFramwerok;
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
        QYe AT %Q0.1 : BOOL;
        QGn AT %Q0.2 : BOOL;        
        QBl AT %Q0.3 : BOOL;
        ActiveStateName : STRING;

        // Initial State
        InitGuard : TRUEGUARD; //TimeoutGuard := (Timeout := T#3000ms);
        Init2Red : Transition := (Guard := InitGuard, NextState := RedState);
        InitState : StateInit := (StateName := 'Init', Transition1 := Init2Red, LightStack := REF(TrafficLight));

        // State Red
        RedGuard : TimeoutGuard := (Timeout := T#1500ms);
        Red2RedYellow : Transition := (Guard := RedGuard, NextState := RedYellowState);
        RedState : StateRed := (StateName := 'Red', Transition1 := Red2RedYellow, LightStack := REF(TrafficLight));

        // State RedYellow
        RedYellowGuard : TimeoutGuard := (Timeout := T#1500ms);
        RedYellowToGreen : Transition := (Guard := RedGuard, NextState := GreenState);
        RedYellowState : StateRedYellow := (StateName := 'RedYellow', Transition1 := RedYellowToGreen, LightStack := REF(TrafficLight));
        
        // State Green
        Green : TimeoutGuard := (Timeout := T#1500ms);
        Green2Yellow : Transition := (Guard := RedGuard, NextState := YellowState);
        GreenState : StateGreen := (StateName := 'Green', Transition1 := Green2Yellow, LightStack := REF(TrafficLight));

        // State Yellow
        YellowGuard : TimeoutGuard := (Timeout := T#1500ms);
        Yellow2Count : Transition := (Guard := RedGuard, NextState := CycleCountState);
        YellowState : StateYellow := (StateName := 'Yellow', Transition1 := Yellow2Count, LightStack := REF(TrafficLight));

        // Check Cycles
        CycleCountGuard : CountGuard := (count := LINT#5);
        CycleCountAlwaysTrueGuard : TrueGuard;
        CycleCountToInit : Transition := (Guard := CycleCountGuard, NextState := InitState);
        CycleCountToRed: Transition := (Guard := CycleCountAlwaysTrueGuard, NextState := RedState);
        CycleCountState : State2Transition := (StateID := 6, Transition1 := CycleCountToInit, transition2 := CycleCountToRed);
        
    END_VAR
END_CONFIGURATION
