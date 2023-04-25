USING Simatic.Ax.IO.Output;
USING Simatic.Ax.IO.Input;
USING Simatic.Ax.SimpleControlModules;
USING ApplicationStateFramwerok;
USING AxUnit;

NAMESPACE MyTest

    {TestFixture}
    CLASS TestStateRedYellow
        VAR PUBLIC
            state : StateRedYellow;
            ls : LightStackRdYeGnBl;
            qRd : BinOutput;
            qYe : BinOutput;
            qGn : BinOutput;
            qBl : BinOutput;
        END_VAR

        METHOD PROTECTED Setup
            state.LightStack := REF(ls);
            ls.QBlue := qBl;
            ls.QGreen := qGn;
            ls.QRed := qRd;
            ls.QYellow := qYe;
        END_METHOD

        {Test}
        METHOD PUBLIC OnEntry_SwitchOnGreenLamp
            THIS.Setup();
            state.OnEntry();            
            Assert.Equal(actual := ls.GetState(Colors#Red), expected := TRUE);
            Assert.Equal(actual := ls.GetState(Colors#Yellow), expected := TRUE);
            Assert.Equal(actual := ls.GetState(Colors#Green), expected := FALSE);
            Assert.Equal(actual := ls.GetState(Colors#Blue), expected := FALSE);
        END_METHOD

        {Test}
        METHOD PUBLIC OnEntry_SwitchOffGreenLamp
            THIS.OnEntry_SwitchOnGreenLamp();
            state.OnExit();            
            Assert.Equal(actual := ls.GetState(Colors#Red), expected := FALSE);
            Assert.Equal(actual := ls.GetState(Colors#Yellow), expected := FALSE);
            Assert.Equal(actual := ls.GetState(Colors#Green), expected := FALSE);
            Assert.Equal(actual := ls.GetState(Colors#Blue), expected := FALSE);
        END_METHOD
    END_CLASS

END_NAMESPACE

