//+------------------------------------------------------------------+
//|                                           ChartObjectCreator.mqh |
//|                        Copyright 2023, MetaQuotes Software Corp. |
//|                                        https://github.com/sdstar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Software Corp."
#property link      "https://github.com/sdstar"
#property strict
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+ 
//| Create the vertical line                                         | 
//+------------------------------------------------------------------+ 
bool VLineCreate(const long            chart_ID=0,        // chart's ID 
                 const string          name="VLine",      // line name 
                 const int             sub_window=0,      // subwindow index 
                 datetime              time=0,            // line time 
                 const color           clr=clrRed,        // line color 
                 const ENUM_LINE_STYLE style=STYLE_SOLID, // line style 
                 const int             width=1,           // line width 
                 const bool            back=false,        // in the background 
                 const bool            selection=true,    // highlight to move 
                 const bool            hidden=true,       // hidden in the object list 
                 const long            z_order=0)         // priority for mouse click 
  { 
//--- if the line time is not set, draw it via the last bar 
   if(!time) 
      time=TimeCurrent(); 
//--- reset the error value 
   ResetLastError(); 
//--- create a vertical line 
   if(!ObjectCreate(chart_ID,name,OBJ_VLINE,sub_window,time,0)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create a vertical line! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set line color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set line display style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set line width 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of moving the line by mouse 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 
  
  
//+------------------------------------------------------------------+ 
//| Create the horizontal line                                       | 
//+------------------------------------------------------------------+ 
bool HLineCreate(const long            chart_ID=0,        // chart's ID 
                 const string          name="HLine",      // line name 
                 const int             sub_window=0,      // subwindow index 
                 double                price=0,           // line price 
                 const color           clr=clrRed,        // line color 
                 const ENUM_LINE_STYLE style=STYLE_SOLID, // line style 
                 const int             width=1,           // line width 
                 const bool            back=false,        // in the background 
                 const bool            selection=true,    // highlight to move 
                 const bool            hidden=true,       // hidden in the object list 
                 const long            z_order=0)         // priority for mouse click 
  { 
//--- if the price is not set, set it at the current Bid price level 
   if(!price) 
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- reset the error value 
   ResetLastError(); 
//--- create a horizontal line 
   if(!ObjectCreate(chart_ID,name,OBJ_HLINE,sub_window,0,price)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create a horizontal line! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set line color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set line display style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set line width 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of moving the line by mouse 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 
  
  
//+------------------------------------------------------------------+ 
//| Create a trend line by the given coordinates                     | 
//+------------------------------------------------------------------+ 
bool TrendCreate(const long            chart_ID=0,        // chart's ID 
                 const string          name="TrendLine",  // line name 
                 const int             sub_window=0,      // subwindow index 
                 datetime              time1=0,           // first point time 
                 double                price1=0,          // first point price 
                 datetime              time2=0,           // second point time 
                 double                price2=0,          // second point price 
                 const color           clr=clrRed,        // line color 
                 const ENUM_LINE_STYLE style=STYLE_SOLID, // line style 
                 const int             width=1,           // line width 
                 const bool            back=false,        // in the background 
                 const bool            selection=true,    // highlight to move 
                 const bool            ray_right=false,   // line's continuation to the right 
                 const bool            hidden=true,       // hidden in the object list 
                 const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeTrendEmptyPoints(time1,price1,time2,price2); 
//--- reset the error value 
   ResetLastError(); 
//--- create a trend line by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create a trend line! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set line color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set line display style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set line width 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of moving the line by mouse 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- enable (true) or disable (false) the mode of continuation of the line's display to the right 
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  }
  
  
//+------------------------------------------------------------------+ 
//| Create a trend line by angle                                     | 
//+------------------------------------------------------------------+ 
bool TrendByAngleCreate(const long            chart_ID=0,        // chart's ID 
                        const string          name="TrendLine",  // line name 
                        const int             sub_window=0,      // subwindow index 
                        datetime              time=0,            // point time 
                        double                price=0,           // point price 
                        const double          angle=45.0,        // slope angle 
                        const color           clr=clrRed,        // line color 
                        const ENUM_LINE_STYLE style=STYLE_SOLID, // line style 
                        const int             width=1,           // line width 
                        const bool            back=false,        // in the background 
                        const bool            selection=true,    // highlight to move 
                        const bool            ray_right=true,    // line's continuation to the right 
                        const bool            hidden=true,       // hidden in the object list 
                        const long            z_order=0)         // priority for mouse click 
  { 
//--- create the second point to facilitate dragging the trend line by mouse 
   datetime time2=0; 
   double   price2=0; 
//--- set anchor points' coordinates if they are not set 
   ChangeTrendEmptyPoints(time,price,time2,price2); 
//--- reset the error value 
   ResetLastError(); 
//--- create a trend line using 2 points 
   if(!ObjectCreate(chart_ID,name,OBJ_TRENDBYANGLE,sub_window,time,price,time2,price2)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create a trend line! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- change trend line's slope angle; when changing the angle, coordinates of the second 
//--- point of the line are redefined automatically according to the angle's new value 
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle); 
//--- set line color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set line style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set line width 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of moving the line by mouse 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- enable (true) or disable (false) the mode of continuation of the line's display to the right 
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create cycle lines                                               | 
//+------------------------------------------------------------------+ 
bool CyclesCreate(const long            chart_ID=0,        // chart's ID 
                  const string          name="Cycles",     // object name 
                  const int             sub_window=0,      // subwindow index 
                  datetime              time1=0,           // first point time 
                  double                price1=0,          // first point price 
                  datetime              time2=0,           // second point time 
                  double                price2=0,          // second point price 
                  const color           clr=clrRed,        // color of cycle lines 
                  const ENUM_LINE_STYLE style=STYLE_SOLID, // style of cycle lines 
                  const int             width=1,           // width of cycle lines 
                  const bool            back=false,        // in the background 
                  const bool            selection=true,    // highlight to move 
                  const bool            hidden=true,       // hidden in the object list 
                  const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeCyclesEmptyPoints(time1,price1,time2,price2); 
//--- reset the error value 
   ResetLastError(); 
//--- create cycle lines by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_CYCLES,sub_window,time1,price1,time2,price2)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create cycle lines! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set color of the lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set display style of the lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set width of the lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of moving the lines by mouse 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 
  

//+------------------------------------------------------------------+ 
//| Create an equidistant channel by the given coordinates           | 
//+------------------------------------------------------------------+ 
bool ChannelCreate(const long            chart_ID=0,        // chart's ID 
                   const string          name="Channel",    // channel name 
                   const int             sub_window=0,      // subwindow index  
                   datetime              time1=0,           // first point time 
                   double                price1=0,          // first point price 
                   datetime              time2=0,           // second point time 
                   double                price2=0,          // second point price 
                   datetime              time3=0,           // third point time 
                   double                price3=0,          // third point price 
                   const color           clr=clrRed,        // channel color 
                   const ENUM_LINE_STYLE style=STYLE_SOLID, // style of channel lines 
                   const int             width=1,           // width of channel lines 
                   const bool            fill=false,        // filling the channel with color 
                   const bool            back=false,        // in the background 
                   const bool            selection=true,    // highlight to move 
                   const bool            ray_right=false,   // channel's continuation to the right 
                   const bool            hidden=true,       // hidden in the object list 
                   const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeChannelEmptyPoints(time1,price1,time2,price2,time3,price3); 
//--- reset the error value 
   ResetLastError(); 
//--- create a channel by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_CHANNEL,sub_window,time1,price1,time2,price2,time3,price3)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create an equidistant channel! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set channel color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set style of the channel lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set width of the channel lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the channel for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- enable (true) or disable (false) the mode of continuation of the channel's display to the right 
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  }


//+------------------------------------------------------------------+ 
//| Create standard deviation channel by the given coordinates       | 
//+------------------------------------------------------------------+ 
bool StdDevChannelCreate(const long            chart_ID=0,        // chart's ID 
                         const string          name="Channel",    // channel name 
                         const int             sub_window=0,      // subwindow index  
                         datetime              time1=0,           // first point time 
                         datetime              time2=0,           // second point time 
                         const double          deviation=1.0,     // deviation  
                         const color           clr=clrRed,        // channel color 
                         const ENUM_LINE_STYLE style=STYLE_SOLID, // style of channel lines 
                         const int             width=1,           // width of channel lines 
                         const bool            fill=false,        // filling the channel with color 
                         const bool            back=false,        // in the background 
                         const bool            selection=true,    // highlight to move 
                         const bool            ray_right=false,   // channel's continuation to the right 
                         const bool            hidden=true,       // hidden in the object list 
                         const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeChannelEmptyPoints(time1,time2); 
//--- reset the error value 
   ResetLastError(); 
//--- create a channel by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_STDDEVCHANNEL,sub_window,time1,0,time2,0)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create standard deviation channel! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set deviation value affecting the channel width 
   ObjectSetDouble(chart_ID,name,OBJPROP_DEVIATION,deviation); 
//--- set channel color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set style of the channel lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set width of the channel lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the channel for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- enable (true) or disable (false) the mode of continuation of the channel's display to the right 
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create Linear Regression Channel by the given coordinates        | 
//+------------------------------------------------------------------+ 
bool RegressionCreate(const long            chart_ID=0,        // chart's ID 
                      const string          name="Regression", // channel name 
                      const int             sub_window=0,      // subwindow index  
                      datetime              time1=0,           // first point time 
                      datetime              time2=0,           // second point time 
                      const color           clr=clrRed,        // channel color 
                      const ENUM_LINE_STYLE style=STYLE_SOLID, // style of channel lines 
                      const int             width=1,           // width of channel lines 
                      const bool            fill=false,        // filling the channel with color 
                      const bool            back=false,        // in the background 
                      const bool            selection=true,    // highlight to move 
                      const bool            ray_right=false,   // channel's continuation to the right 
                      const bool            hidden=true,       // hidden in the object list 
                      const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeRegressionEmptyPoints(time1,time2); 
//--- reset the error value 
   ResetLastError(); 
//--- create a channel by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_REGRESSION,sub_window,time1,0,time2,0)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create linear regression channel! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set channel color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set style of the channel lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set width of the channel lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the channel for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- enable (true) or disable (false) the mode of continuation of the channel's display to the right 
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create Andrews' Pitchfork by the given coordinates               | 
//+------------------------------------------------------------------+ 
bool PitchforkCreate(const long            chart_ID=0,        // chart's ID 
                     const string          name="Pitchfork",  // pitchfork name 
                     const int             sub_window=0,      // subwindow index  
                     datetime              time1=0,           // first point time 
                     double                price1=0,          // first point price 
                     datetime              time2=0,           // second point time 
                     double                price2=0,          // second point price 
                     datetime              time3=0,           // third point time 
                     double                price3=0,          // third point price 
                     const color           clr=clrRed,        // color of pitchfork lines 
                     const ENUM_LINE_STYLE style=STYLE_SOLID, // style of pitchfork lines 
                     const int             width=1,           // width of pitchfork lines 
                     const bool            back=false,        // in the background 
                     const bool            selection=true,    // highlight to move 
                     const bool            ray_right=false,   // pitchfork's continuation to the right 
                     const bool            hidden=true,       // hidden in the object list 
                     const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeChannelEmptyPoints(time1,price1,time2,price2,time3,price3); 
//--- reset the error value 
   ResetLastError(); 
//--- create Andrews' Pitchfork by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_PITCHFORK,sub_window,time1,price1,time2,price2,time3,price3)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Andrews' Pitchfork\"! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set the line style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set width of the lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the pitchfork for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- enable (true) or disable (false) the mode of continuation of the pitchfork's display to the right 
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create Gann Line by the coordinates, angle and scale             | 
//+------------------------------------------------------------------+ 
bool GannLineCreate(const long            chart_ID=0,        // chart's ID 
                    const string          name="GannLine",   // line name 
                    const int             sub_window=0,      // subwindow index 
                    datetime              time1=0,           // first point time 
                    double                price1=0,          // first point price 
                    datetime              time2=0,           // second point time 
                    const double          angle=1.0,         // Gann angle 
                    const double          scale=1.0,         // scale 
                    const color           clr=clrRed,        // line color 
                    const ENUM_LINE_STYLE style=STYLE_SOLID, // line style 
                    const int             width=1,           // line width 
                    const bool            back=false,        // in the background 
                    const bool            selection=true,    // highlight to move 
                    const bool            ray_right=true,    // line's continuation to the right 
                    const bool            hidden=true,       // hidden in the object list 
                    const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeGannLineEmptyPoints(time1,price1,time2); 
//--- reset the error value 
   ResetLastError(); 
//--- create Gann Line by the given coordinates 
//--- correct coordinate of the second anchor point is redefined 
//--- automatically after Gann angle and/or the scale changes, 
   if(!ObjectCreate(chart_ID,name,OBJ_GANNLINE,sub_window,time1,price1,time2,0)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Gann Line\"! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- change Gann angle 
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle); 
//--- change the scale (number of pips per bar) 
   ObjectSetDouble(chart_ID,name,OBJPROP_SCALE,scale); 
//--- set line color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set line display style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set line width 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the lines for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- enable (true) or disable (false) the mode of continuation of the line's display to the right 
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create Gann Fan                                                  | 
//+------------------------------------------------------------------+ 
bool GannFanCreate(const long            chart_ID=0,        // chart's ID 
                   const string          name="GannFan",    // fan name 
                   const int             sub_window=0,      // subwindow index 
                   datetime              time1=0,           // first point time 
                   double                price1=0,          // first point price 
                   datetime              time2=0,           // second point time 
                   const double          scale=1.0,         // scale 
                   const bool            direction=true,    // trend direction 
                   const color           clr=clrRed,        // fan color 
                   const ENUM_LINE_STYLE style=STYLE_SOLID, // style of fan lines 
                   const int             width=1,           // width of fan lines 
                   const bool            back=false,        // in the background 
                   const bool            selection=true,    // highlight to move 
                   const bool            hidden=true,       // hidden in the object list 
                   const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeGannFanEmptyPoints(time1,price1,time2); 
//--- reset the error value 
   ResetLastError(); 
//--- create Gann Fan by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_GANNFAN,sub_window,time1,price1,time2,0)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Gann Fan\"! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- change the scale (number of pips per bar) 
   ObjectSetDouble(chart_ID,name,OBJPROP_SCALE,scale); 
//--- change Gann Fan's trend direction (true - descending, false - ascending) 
   ObjectSetInteger(chart_ID,name,OBJPROP_DIRECTION,direction); 
//--- set fan color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set display style of the fan lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set width of the fan lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the fan for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create Gann Grid                                                 | 
//+------------------------------------------------------------------+ 
bool GannGridCreate(const long            chart_ID=0,        // chart's ID 
                    const string          name="GannGrid",   // grid name 
                    const int             sub_window=0,      // subwindow index 
                    datetime              time1=0,           // first point time 
                    double                price1=0,          // first point price 
                    datetime              time2=0,           // second point time 
                    const double          scale=1.0,         // scale 
                    const bool            direction=true,    // trend direction 
                    const color           clr=clrRed,        // grid color 
                    const ENUM_LINE_STYLE style=STYLE_SOLID, // style of grid lines 
                    const int             width=1,           // width of grid lines 
                    const bool            back=false,        // in the background 
                    const bool            selection=true,    // highlight to move 
                    const bool            hidden=true,       // hidden in the object list 
                    const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeGannGridEmptyPoints(time1,price1,time2); 
//--- reset the error value 
   ResetLastError(); 
//--- create Gann Grid by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_GANNGRID,sub_window,time1,price1,time2,0)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Gann Grid\"! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- change the scale (number of pips per bar) 
   ObjectSetDouble(chart_ID,name,OBJPROP_SCALE,scale); 
//--- change Gann Fan's trend direction (true - descending, false - ascending) 
   ObjectSetInteger(chart_ID,name,OBJPROP_DIRECTION,direction); 
//--- set grid color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set display style of the grid lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set width of the grid lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the grid for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create Fibonacci Retracement by the given coordinates            | 
//+------------------------------------------------------------------+ 
bool FiboLevelsCreate(const long            chart_ID=0,        // chart's ID 
                      const string          name="FiboLevels", // object name 
                      const int             sub_window=0,      // subwindow index  
                      datetime              time1=0,           // first point time 
                      double                price1=0,          // first point price 
                      datetime              time2=0,           // second point time 
                      double                price2=0,          // second point price 
                      const color           clr=clrRed,        // object color 
                      const ENUM_LINE_STYLE style=STYLE_SOLID, // object line style 
                      const int             width=1,           // object line width 
                      const bool            back=false,        // in the background 
                      const bool            selection=true,    // highlight to move 
                      const bool            ray_right=false,   // object's continuation to the right 
                      const bool            hidden=true,       // hidden in the object list 
                      const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeFiboLevelsEmptyPoints(time1,price1,time2,price2); 
//--- reset the error value 
   ResetLastError(); 
//--- Create Fibonacci Retracement by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_FIBO,sub_window,time1,price1,time2,price2)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Fibonacci Retracement\"! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set line style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set line width 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the channel for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- enable (true) or disable (false) the mode of continuation of the object's display to the right 
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create Fibonacci Time Zones by the given coordinates             | 
//+------------------------------------------------------------------+ 
bool FiboTimesCreate(const long            chart_ID=0,        // chart's ID 
                     const string          name="FiboTimes",  // object name 
                     const int             sub_window=0,      // subwindow index  
                     datetime              time1=0,           // first point time 
                     double                price1=0,          // first point price 
                     datetime              time2=0,           // second point time 
                     double                price2=0,          // second point price 
                     const color           clr=clrRed,        // object color 
                     const ENUM_LINE_STYLE style=STYLE_SOLID, // object line style 
                     const int             width=1,           // object line width 
                     const bool            back=false,        // in the background 
                     const bool            selection=true,    // highlight to move 
                     const bool            hidden=true,       // hidden in the object list 
                     const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeFiboTimesEmptyPoints(time1,price1,time2,price2); 
//--- reset the error value 
   ResetLastError(); 
//--- create Fibonacci Time Zones by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_FIBOTIMES,sub_window,time1,price1,time2,price2)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Fibonacci Time Zones\"! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set line style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set line width 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the channel for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create Fibonacci Fan by the given coordinates                    | 
//+------------------------------------------------------------------+ 
bool FiboFanCreate(const long            chart_ID=0,        // chart's ID 
                   const string          name="FiboFan",    // fan name 
                   const int             sub_window=0,      // subwindow index  
                   datetime              time1=0,           // first point time 
                   double                price1=0,          // first point price 
                   datetime              time2=0,           // second point time 
                   double                price2=0,          // second point price 
                   const color           clr=clrRed,        // fan line color 
                   const ENUM_LINE_STYLE style=STYLE_SOLID, // fan line style 
                   const int             width=1,           // fan line width 
                   const bool            back=false,        // in the background 
                   const bool            selection=true,    // highlight to move 
                   const bool            hidden=true,       // hidden in the object list 
                   const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeFiboFanEmptyPoints(time1,price1,time2,price2); 
//--- reset the error value 
   ResetLastError(); 
//--- create Fibonacci Fan by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_FIBOFAN,sub_window,time1,price1,time2,price2)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Fibonacci Fan\"! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set line style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set line width 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the fan for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create Fibonacci Arcs by the given coordinates                   | 
//+------------------------------------------------------------------+ 
bool FiboArcCreate(const long            chart_ID=0,         // chart's ID 
                   const string          name="FiboArc",     // object name 
                   const int             sub_window=0,       // subwindow index  
                   datetime              time1=0,            // first point time 
                   double                price1=0,           // first point price 
                   datetime              time2=0,            // second point time 
                   double                price2=0,           // second point price 
                   const double          scale=1.0,          // scale 
                   const bool            full_ellipse=false, // shape of the arcs 
                   const color           clr=clrRed,         // line color 
                   const ENUM_LINE_STYLE style=STYLE_SOLID,  // line style 
                   const int             width=1,            // line width 
                   const bool            back=false,         // in the background 
                   const bool            selection=true,     // highlight to move 
                   const bool            hidden=true,        // hidden in the object list 
                   const long            z_order=0)          // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeFiboArcEmptyPoints(time1,price1,time2,price2); 
//--- reset the error value 
   ResetLastError(); 
//--- create Fibonacci Arcs by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_FIBOARC,sub_window,time1,price1,time2,price2)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Fibonacci Arcs\"! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set the scale 
   ObjectSetDouble(chart_ID,name,OBJPROP_SCALE,scale); 
//--- set display of the arcs as a full ellipse (true) or a half of it (false) 
   ObjectSetInteger(chart_ID,name,OBJPROP_ELLIPSE,full_ellipse); 
//--- set color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set line style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set line width 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the arcs for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create Fibonacci Channel by the given coordinates                | 
//+------------------------------------------------------------------+ 
bool FiboChannelCreate(const long            chart_ID=0,         // chart's ID 
                       const string          name="FiboChannel", // channel name 
                       const int             sub_window=0,       // subwindow index  
                       datetime              time1=0,            // first point time 
                       double                price1=0,           // first point price 
                       datetime              time2=0,            // second point time 
                       double                price2=0,           // second point price 
                       datetime              time3=0,            // third point time 
                       double                price3=0,           // third point price 
                       const color           clr=clrRed,         // channel color 
                       const ENUM_LINE_STYLE style=STYLE_SOLID,  // style of channel lines 
                       const int             width=1,            // width of channel lines 
                       const bool            back=false,         // in the background 
                       const bool            selection=true,     // highlight to move 
                       const bool            ray=false,          // channel's continuation to the chart 
                       const bool            hidden=true,        // hidden in the object list 
                       const long            z_order=0)          // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeFiboChannelEmptyPoints(time1,price1,time2,price2,time3,price3); 
//--- reset the error value 
   ResetLastError(); 
//--- create a channel by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_FIBOCHANNEL,sub_window,time1,price1,time2,price2,time3,price3)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Fibonacci Channel\"! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set channel color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set style of the channel lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set width of the channel lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the channel for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- enable (true) or disable (false) the mode of continuation of the channel's display to the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY,ray); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create Fibonacci Extension by the given coordinates              | 
//+------------------------------------------------------------------+ 
bool FiboExpansionCreate(const long            chart_ID=0,           // chart's ID 
                         const string          name="FiboExpansion", // channel name 
                         const int             sub_window=0,         // subwindow index  
                         datetime              time1=0,              // first point time 
                         double                price1=0,             // first point price 
                         datetime              time2=0,              // second point time 
                         double                price2=0,             // second point price 
                         datetime              time3=0,              // third point time 
                         double                price3=0,             // third point price 
                         const color           clr=clrRed,           // object color 
                         const ENUM_LINE_STYLE style=STYLE_SOLID,    // style of the lines 
                         const int             width=1,              // width of the lines 
                         const bool            back=false,           // in the background 
                         const bool            selection=true,       // highlight to move 
                         const bool            ray_right=false,      // object's continuation to the right 
                         const bool            hidden=true,          // hidden in the object list 
                         const long            z_order=0)            // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeFiboExpansionEmptyPoints(time1,price1,time2,price2,time3,price3); 
//--- reset the error value 
   ResetLastError(); 
//--- Create Fibonacci Extension by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_EXPANSION,sub_window,time1,price1,time2,price2,time3,price3)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Fibonacci Extension\"! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set the object's color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set the line style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set width of the lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the channel for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- enable (true) or disable (false) the mode of continuation of the object's display to the right 
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create rectangle by the given coordinates                        | 
//+------------------------------------------------------------------+ 
bool RectangleCreate(const long            chart_ID=0,        // chart's ID 
                     const string          name="Rectangle",  // rectangle name 
                     const int             sub_window=0,      // subwindow index  
                     datetime              time1=0,           // first point time 
                     double                price1=0,          // first point price 
                     datetime              time2=0,           // second point time 
                     double                price2=0,          // second point price 
                     const color           clr=clrRed,        // rectangle color 
                     const ENUM_LINE_STYLE style=STYLE_SOLID, // style of rectangle lines 
                     const int             width=1,           // width of rectangle lines 
                     const bool            fill=false,        // filling rectangle with color 
                     const bool            back=false,        // in the background 
                     const bool            selection=true,    // highlight to move 
                     const bool            hidden=true,       // hidden in the object list 
                     const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeRectangleEmptyPoints(time1,price1,time2,price2); 
//--- reset the error value 
   ResetLastError(); 
//--- create a rectangle by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_RECTANGLE,sub_window,time1,price1,time2,price2)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create a rectangle! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set rectangle color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set the style of rectangle lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set width of the rectangle lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- enable (true) or disable (false) the mode of filling the rectangle 
   ObjectSetInteger(chart_ID,name,OBJPROP_FILL,fill); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the rectangle for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create triangle by the given coordinates                         | 
//+------------------------------------------------------------------+ 
bool TriangleCreate(const long            chart_ID=0,        // chart's ID 
                    const string          name="Triangle",   // triangle name 
                    const int             sub_window=0,      // subwindow index  
                    datetime              time1=0,           // first point time 
                    double                price1=0,          // first point price 
                    datetime              time2=0,           // second point time 
                    double                price2=0,          // second point price 
                    datetime              time3=0,           // third point time 
                    double                price3=0,          // third point price 
                    const color           clr=clrRed,        // triangle color 
                    const ENUM_LINE_STYLE style=STYLE_SOLID, // style of triangle lines 
                    const int             width=1,           // width of triangle lines 
                    const bool            fill=false,        // filling triangle with color 
                    const bool            back=false,        // in the background 
                    const bool            selection=true,    // highlight to move 
                    const bool            hidden=true,       // hidden in the object list 
                    const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeTriangleEmptyPoints(time1,price1,time2,price2,time3,price3); 
//--- reset the error value 
   ResetLastError(); 
//--- create triangle by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_TRIANGLE,sub_window,time1,price1,time2,price2,time3,price3)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create a triangle! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set triangle color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set style of triangle lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set width of triangle lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the triangle for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create an ellipse by the given coordinates                       | 
//+------------------------------------------------------------------+ 
bool EllipseCreate(const long            chart_ID=0,        // chart's ID 
                   const string          name="Ellipse",    // ellipse name 
                   const int             sub_window=0,      // subwindow index  
                   datetime              time1=0,           // first point time 
                   double                price1=0,          // first point price 
                   datetime              time2=0,           // second point time 
                   double                price2=0,          // second point price 
                   double                ellipse_scale=0,   // ellipse scale ratio  
                   const color           clr=clrRed,        // ellipse color 
                   const ENUM_LINE_STYLE style=STYLE_SOLID, // style of ellipse lines 
                   const int             width=1,           // width of ellipse lines 
                   const bool            fill=false,        // filling ellipse with color 
                   const bool            back=false,        // in the background 
                   const bool            selection=true,    // highlight to move 
                   const bool            hidden=true,       // hidden in the object list 
                   const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor points' coordinates if they are not set 
   ChangeEllipseEmptyPoints(time1,price1,time2,price2); 
//--- reset the error value 
   ResetLastError(); 
//--- create an ellipse by the given coordinates 
   if(!ObjectCreate(chart_ID,name,OBJ_ELLIPSE,sub_window,time1,price1,time2,price2)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create an ellipse! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set ellipse scale ratio  
   ObjectSetDouble(chart_ID,name,OBJPROP_SCALE,0.2); 
//--- set an ellipse color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set style of ellipse lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set width of ellipse lines 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of highlighting the ellipse for moving 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create Array Up sign                                             | 
//+------------------------------------------------------------------+ 
bool ArrowUpCreate(const long              chart_ID=0,           // chart's ID 
                   const string            name="ArrowUp",       // sign name 
                   const int               sub_window=0,         // subwindow index 
                   datetime                time=0,               // anchor point time 
                   double                  price=0,              // anchor point price 
                   const ENUM_ARROW_ANCHOR anchor=ANCHOR_BOTTOM, // anchor type 
                   const color             clr=clrRed,           // sign color 
                   const ENUM_LINE_STYLE   style=STYLE_SOLID,    // border line style 
                   const int               width=3,              // sign size 
                   const bool              back=false,           // in the background 
                   const bool              selection=true,       // highlight to move 
                   const bool              hidden=true,          // hidden in the object list 
                   const long              z_order=0)            // priority for mouse click 
  { 
//--- set anchor point coordinates if they are not set 
   ChangeArrowEmptyPoint(time,price); 
//--- reset the error value 
   ResetLastError(); 
//--- create the sign 
   if(!ObjectCreate(chart_ID,name,OBJ_ARROW_UP,sub_window,time,price)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Arrow Up\" sign! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set anchor type 
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor); 
//--- set a sign color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set the border line style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set the sign size 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of moving the sign by mouse 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create Array Down sign                                           | 
//+------------------------------------------------------------------+ 
bool ArrowDownCreate(const long              chart_ID=0,           // chart's ID 
                     const string            name="ArrowDown",     // sign name 
                     const int               sub_window=0,         // subwindow index 
                     datetime                time=0,               // anchor point time 
                     double                  price=0,              // anchor point price 
                     const ENUM_ARROW_ANCHOR anchor=ANCHOR_BOTTOM, // anchor type 
                     const color             clr=clrRed,           // sign color 
                     const ENUM_LINE_STYLE   style=STYLE_SOLID,    // border line style 
                     const int               width=3,              // sign size 
                     const bool              back=false,           // in the background 
                     const bool              selection=true,       // highlight to move 
                     const bool              hidden=true,          // hidden in the object list 
                     const long              z_order=0)            // priority for mouse click 
  { 
//--- set anchor point coordinates if they are not set 
   ChangeArrowEmptyPoint(time,price); 
//--- reset the error value 
   ResetLastError(); 
//--- create the sign 
   if(!ObjectCreate(chart_ID,name,OBJ_ARROW_DOWN,sub_window,time,price)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Arrow Down\" sign! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- anchor type 
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor); 
//--- set a sign color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set the border line style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set the sign size 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of moving the sign by mouse 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create the left price label                                      | 
//+------------------------------------------------------------------+ 
bool ArrowLeftPriceCreate(const long            chart_ID=0,        // chart's ID 
                          const string          name="LeftPrice",  // price label name 
                          const int             sub_window=0,      // subwindow index 
                          datetime              time=0,            // anchor point time 
                          double                price=0,           // anchor point price 
                          const color           clr=clrRed,        // price label color 
                          const ENUM_LINE_STYLE style=STYLE_SOLID, // border line style 
                          const int             width=1,           // price label size 
                          const bool            back=false,        // in the background 
                          const bool            selection=true,    // highlight to move 
                          const bool            hidden=true,       // hidden in the object list 
                          const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor point coordinates if they are not set 
   ChangeArrowEmptyPoint(time,price); 
//--- reset the error value 
   ResetLastError(); 
//--- create a price label 
   if(!ObjectCreate(chart_ID,name,OBJ_ARROW_LEFT_PRICE,sub_window,time,price)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create the left price label! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set the label color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set the border line style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set the label size 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of moving the label by mouse 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create the right price label                                     | 
//+------------------------------------------------------------------+ 
bool ArrowRightPriceCreate(const long            chart_ID=0,        // chart's ID 
                           const string          name="RightPrice", // price label name 
                           const int             sub_window=0,      // subwindow index 
                           datetime              time=0,            // anchor point time 
                           double                price=0,           // anchor point price 
                           const color           clr=clrRed,        // price label color 
                           const ENUM_LINE_STYLE style=STYLE_SOLID, // border line style 
                           const int             width=1,           // price label size 
                           const bool            back=false,        // in the background 
                           const bool            selection=true,    // highlight to move 
                           const bool            hidden=true,       // hidden in the object list 
                           const long            z_order=0)         // priority for mouse click 
  { 
//--- set anchor point coordinates if they are not set 
   ChangeArrowEmptyPoint(time,price); 
//--- reset the error value 
   ResetLastError(); 
//--- create a price label 
   if(!ObjectCreate(chart_ID,name,OBJ_ARROW_RIGHT_PRICE,sub_window,time,price)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create the right price label! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set the label color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- set the border line style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style); 
//--- set the label size 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of moving the label by mouse 
//--- when creating a graphical object using ObjectCreate function, the object cannot be 
//--- highlighted and moved by default. Inside this method, selection parameter 
//--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Creating Text object                                             | 
//+------------------------------------------------------------------+ 
bool TextCreate(const long              chart_ID=0,               // chart's ID 
                const string            name="Text",              // object name 
                const int               sub_window=0,             // subwindow index 
                datetime                time=0,                   // anchor point time 
                double                  price=0,                  // anchor point price 
                const string            text="Text",              // the text itself 
                const string            font="Arial",             // font 
                const int               font_size=10,             // font size 
                const color             clr=clrRed,               // color 
                const double            angle=0.0,                // text slope 
                const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // anchor type 
                const bool              back=false,               // in the background 
                const bool              selection=false,          // highlight to move 
                const bool              hidden=true,              // hidden in the object list 
                const long              z_order=0)                // priority for mouse click 
  { 
//--- set anchor point coordinates if they are not set 
   ChangeTextEmptyPoint(time,price); 
//--- reset the error value 
   ResetLastError(); 
//--- create Text object 
   if(!ObjectCreate(chart_ID,name,OBJ_TEXT,sub_window,time,price)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Text\" object! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set the text 
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text); 
//--- set text font 
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font); 
//--- set font size 
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size); 
//--- set the slope angle of the text 
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle); 
//--- set anchor type 
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor); 
//--- set color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of moving the object by mouse 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  } 


//+------------------------------------------------------------------+ 
//| Create a text label                                              | 
//+------------------------------------------------------------------+ 
bool LabelCreate(const long              chart_ID=0,               // chart's ID 
                 const string            name="Label",             // label name 
                 const int               sub_window=0,             // subwindow index 
                 const int               x=0,                      // X coordinate 
                 const int               y=0,                      // Y coordinate 
                 const ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER, // chart corner for anchoring 
                 const string            text="Label",             // text 
                 const string            font="Arial",             // font 
                 const int               font_size=10,             // font size 
                 const color             clr=clrRed,               // color 
                 const double            angle=0.0,                // text slope 
                 const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // anchor type 
                 const bool              back=false,               // in the background 
                 const bool              selection=false,          // highlight to move 
                 const bool              hidden=true,              // hidden in the object list 
                 const long              z_order=0)                // priority for mouse click 
  { 
//--- reset the error value 
   ResetLastError(); 
//--- create a text label 
   if(!ObjectCreate(chart_ID,name,OBJ_LABEL,sub_window,0,0)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create text label! Error code = ",GetLastError()); 
      return(false); 
     } 
//--- set label coordinates 
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x); 
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y); 
//--- set the chart's corner, relative to which point coordinates are defined 
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner); 
//--- set the text 
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text); 
//--- set text font 
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font); 
//--- set font size 
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size); 
//--- set the slope angle of the text 
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle); 
//--- set anchor type 
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor); 
//--- set color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
//--- enable (true) or disable (false) the mode of moving the label by mouse 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
//--- successful execution 
   return(true); 
  }


//+------------------------------------------------------------------+
//| Dependencies                                                                 |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+ 
//| Check the values of trend line's anchor points and set default   | 
//| values for empty ones                                            | 
//+------------------------------------------------------------------+ 
void ChangeTrendEmptyPoints(datetime &time1,double &price1, 
                            datetime &time2,double &price2) 
  { 
//--- if the first point's time is not set, it will be on the current bar 
   if(!time1) 
      time1=TimeCurrent(); 
//--- if the first point's price is not set, it will have Bid value 
   if(!price1) 
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- if the second point's time is not set, it is located 9 bars left from the second one 
   if(!time2) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time1,10,temp); 
      //--- set the second point 9 bars left from the first one 
      time2=temp[0]; 
     } 
//--- if the second point's price is not set, it is equal to the first point's one 
   if(!price2) 
      price2=price1; 
  } 


//+-----------------------------------------------------------------------+ 
//| Check the values of cycle lines' anchor points and set default values | 
//| values for empty ones                                                 | 
//+-----------------------------------------------------------------------+ 
void ChangeCyclesEmptyPoints(datetime &time1,double &price1, 
                             datetime &time2,double &price2) 
  { 
//--- if the first point's time is not set, it will be on the current bar 
   if(!time1) 
      time1=TimeCurrent(); 
//--- if the first point's price is not set, it will have Bid value 
   if(!price1) 
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- if the second point's time is not set, it is located 9 bars left from the second one 
   if(!time2) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time1,10,temp); 
      //--- set the second point 9 bars left from the first one 
      time2=temp[0]; 
     } 
//--- if the second point's price is not set, it is equal to the first point's one 
   if(!price2) 
      price2=price1; 
  }


//+-------------------------------------------------------------------------+ 
//| Check the values of the channel's anchor points and set default values  | 
//| for empty ones                                                          | 
//+-------------------------------------------------------------------------+ 
void ChangeChannelEmptyPoints(datetime &time1,double &price1,datetime &time2, 
                              double &price2,datetime &time3,double &price3) 
  { 
//--- if the second (right) point's time is not set, it will be on the current bar 
   if(!time2) 
      time2=TimeCurrent(); 
//--- if the second point's price is not set, it will have Bid value 
   if(!price2) 
      price2=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- if the first (left) point's time is not set, it is located 9 bars left from the second one 
   if(!time1) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time2,10,temp); 
      //--- set the first point 9 bars left from the second one 
      time1=temp[0]; 
     } 
//--- if the first point's price is not set, move it 300 points higher than the second one 
   if(!price1) 
      price1=price2+300*SymbolInfoDouble(Symbol(),SYMBOL_POINT); 
//--- if the third point's time is not set, it coincides with the first point's one 
   if(!time3) 
      time3=time1; 
//--- if the third point's price is not set, it is equal to the second point's one 
   if(!price3) 
      price3=price2; 
  } 


//+-------------------------------------------------------------------------+ 
//| Check the values of the channel's anchor points and set default values  | 
//| for empty ones                                                          | 
//+-------------------------------------------------------------------------+ 
void ChangeChannelEmptyPoints(datetime &time1,datetime &time2) 
  { 
//--- if the second point's time is not set, it will be on the current bar 
   if(!time2) 
      time2=TimeCurrent(); 
//--- if the first point's time is not set, it is located 9 bars left from the second one 
   if(!time1) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time2,10,temp); 
      //--- set the first point 9 bars left from the second one 
      time1=temp[0]; 
     } 
  }
  

//+-------------------------------------------------------------------------+ 
//| Check the values of the channel's anchor points and set default values  | 
//| for empty ones                                                          | 
//+-------------------------------------------------------------------------+ 
void ChangeRegressionEmptyPoints(datetime &time1,datetime &time2) 
  { 
//--- if the second point's time is not set, it will be on the current bar 
   if(!time2) 
      time2=TimeCurrent(); 
//--- if the first point's time is not set, it is located 9 bars left from the second one 
   if(!time1) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time2,10,temp); 
      //--- set the first point 9 bars left from the second one 
      time1=temp[0]; 
     } 
  }


//+------------------------------------------------------------------+ 
//| Check the values of Gann Line anchor points and set default      | 
//| values for empty ones                                            | 
//+------------------------------------------------------------------+ 
void ChangeGannLineEmptyPoints(datetime &time1,double &price1,datetime &time2) 
  { 
//--- if the second point's time is not set, it will be on the current bar 
   if(!time2) 
      time2=TimeCurrent(); 
//--- if the first point's time is not set, it is located 9 bars left from the second one 
   if(!time1) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time2,10,temp); 
      //--- set the first point 9 bars left from the second one 
      time1=temp[0]; 
     } 
//--- if the first point's price is not set, it will have Bid value 
   if(!price1) 
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
  } 


//+------------------------------------------------------------------+ 
// | Check the values of Gann Fan anchor points and set default      | 
//| values for empty ones                                            | 
//+------------------------------------------------------------------+ 
void ChangeGannFanEmptyPoints(datetime &time1,double &price1,datetime &time2) 
  { 
//--- if the second point's time is not set, it will be on the current bar 
   if(!time2) 
      time2=TimeCurrent(); 
//--- if the first point's time is not set, it is located 9 bars left from the second one 
   if(!time1) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time2,10,temp); 
      //--- set the first point 9 bars left from the second one 
      time1=temp[0]; 
     } 
//--- if the first point's price is not set, it will have Bid value 
   if(!price1) 
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
  } 


//+------------------------------------------------------------------+ 
//| Check the values of Gann Grid anchor points and set default      | 
//| values for empty ones                                            | 
//+------------------------------------------------------------------+ 
void ChangeGannGridEmptyPoints(datetime &time1,double &price1,datetime &time2) 
  { 
//--- if the second point's time is not set, it will be on the current bar 
   if(!time2) 
      time2=TimeCurrent(); 
//--- if the first point's time is not set, it is located 9 bars left from the second one 
   if(!time1) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time2,10,temp); 
      //--- set the first point 9 bars left from the second one 
      time1=temp[0]; 
     } 
//--- if the first point's price is not set, it will have Bid value 
   if(!price1) 
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
  }


//+------------------------------------------------------------------+ 
//| Check the values of Fibonacci Retracement anchor points and set  | 
//| default values for empty ones                                    | 
//+------------------------------------------------------------------+ 
void ChangeFiboLevelsEmptyPoints(datetime &time1,double &price1, 
                                 datetime &time2,double &price2) 
  { 
//--- if the second point's time is not set, it will be on the current bar 
   if(!time2) 
      time2=TimeCurrent(); 
//--- if the second point's price is not set, it will have Bid value 
   if(!price2) 
      price2=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- if the first point's time is not set, it is located 9 bars left from the second one 
   if(!time1) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time2,10,temp); 
      //--- set the first point 9 bars left from the second one 
      time1=temp[0]; 
     } 
//--- if the first point's price is not set, move it 200 points below the second one 
   if(!price1) 
      price1=price2-200*SymbolInfoDouble(Symbol(),SYMBOL_POINT); 
  } 


//+------------------------------------------------------------------+ 
//| Check the values of Fibonacci Time Zones and                     | 
//| set default values for empty ones                                | 
//+------------------------------------------------------------------+ 
void ChangeFiboTimesEmptyPoints(datetime &time1,double &price1, 
                                datetime &time2,double &price2) 
  { 
//--- if the first point's time is not set, it will be on the current bar 
   if(!time1) 
      time1=TimeCurrent(); 
//--- if the first point's price is not set, it will have Bid value 
   if(!price1) 
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- if the second point's time is not set, it is located 2 bars left from the second one 
   if(!time2) 
     { 
      //--- array for receiving the open time of the last 3 bars 
      datetime temp[3]; 
      CopyTime(Symbol(),Period(),time1,3,temp); 
      //--- set the first point 2 bars left from the second one 
      time2=temp[0]; 
     } 
//--- if the second point's price is not set, it is equal to the first point's one 
   if(!price2) 
      price2=price1; 
  } 


//+------------------------------------------------------------------+ 
//| Check the values of Fibonacci Fan anchor points and set          | 
//| default values for empty ones                                    | 
//+------------------------------------------------------------------+ 
void ChangeFiboFanEmptyPoints(datetime &time1,double &price1, 
                              datetime &time2,double &price2) 
  { 
//--- if the second point's time is not set, it will be on the current bar 
   if(!time2) 
      time2=TimeCurrent(); 
//--- if the second point's price is not set, it will have Bid value 
   if(!price2) 
      price2=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- if the first point's time is not set, it is located 9 bars left from the second one 
   if(!time1) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time2,10,temp); 
      //--- set the first point 9 bars left from the second one 
      time1=temp[0]; 
     } 
//--- if the first point's price is not set, move it 200 points below the second one 
   if(!price1) 
      price1=price2-200*SymbolInfoDouble(Symbol(),SYMBOL_POINT); 
  } 


//+------------------------------------------------------------------+ 
//| Check the values of Fibonacci Arcs anchor points and set default | 
//| values for empty ones                                            | 
//+------------------------------------------------------------------+ 
void ChangeFiboArcEmptyPoints(datetime &time1,double &price1, 
                              datetime &time2,double &price2) 
  { 
//--- if the second point's time is not set, it will be on the current bar 
   if(!time2) 
      time2=TimeCurrent(); 
//--- if the second point's price is not set, it will have Bid value 
   if(!price2) 
      price2=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- if the first point's time is not set, it is located 9 bars left from the second one 
   if(!time1) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time2,10,temp); 
      //--- set the first point 9 bars left from the second one 
      time1=temp[0]; 
     } 
//--- if the first point's price is not set, move it 300 points below the second one 
   if(!price1) 
      price1=price2-300*SymbolInfoDouble(Symbol(),SYMBOL_POINT); 
  } 


//+------------------------------------------------------------------+ 
//| Check the values of Fibonacci Channel anchor points and set      | 
//| default values for empty ones                                    | 
//+------------------------------------------------------------------+ 
void ChangeFiboChannelEmptyPoints(datetime &time1,double &price1,datetime &time2, 
                                  double &price2,datetime &time3,double &price3) 
  { 
//--- if the second (right) point's time is not set, it will be on the current bar 
   if(!time2) 
      time2=TimeCurrent(); 
//--- if the second point's price is not set, it will have Bid value 
   if(!price2) 
      price2=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- if the first (left) point's time is not set, it is located 9 bars left from the second one 
   if(!time1) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time2,10,temp); 
      //--- set the first point 9 bars left from the second one 
      time1=temp[0]; 
     } 
//--- if the first point's price is not set, move it 300 points higher than the second one 
   if(!price1) 
      price1=price2+300*SymbolInfoDouble(Symbol(),SYMBOL_POINT); 
//--- if the third point's time is not set, it coincides with the first point's one 
   if(!time3) 
      time3=time1; 
//--- if the third point's price is not set, it is equal to the second point's one 
   if(!price3) 
      price3=price2; 
  } 


//+------------------------------------------------------------------+ 
//| Check the values of Fibonacci Expansion anchor points and set    | 
//| default values for empty ones                                    | 
//+------------------------------------------------------------------+ 
void ChangeFiboExpansionEmptyPoints(datetime &time1,double &price1,datetime &time2, 
                                    double &price2,datetime &time3,double &price3) 
  { 
//--- if the third (right) point's time is not set, it will be on the current bar 
   if(!time3) 
      time3=TimeCurrent(); 
//--- if the third point's price is not set, it will have Bid value 
   if(!price3) 
      price3=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- if the first (left) point's time is not set, it is located 9 bars left from the third one 
//--- array for receiving the open time of the last 10 bars 
   datetime temp[]; 
   ArrayResize(temp,10); 
   if(!time1) 
     { 
      CopyTime(Symbol(),Period(),time3,10,temp); 
      //--- set the first point 9 bars left from the second one 
      time1=temp[0]; 
     } 
//--- if the first point's price is not set, it is equal to the third point's one 
   if(!price1) 
      price1=price3; 
//--- if the second point's time is not set, it is located 7 bars left from the third one 
   if(!time2) 
      time2=temp[2]; 
//--- if the second point's price is not set, move it 250 points lower than the first one 
   if(!price2) 
      price2=price1-250*SymbolInfoDouble(Symbol(),SYMBOL_POINT); 
  } 


//+------------------------------------------------------------------+ 
//| Check the values of rectangle's anchor points and set default    | 
//| values for empty ones                                            | 
//+------------------------------------------------------------------+ 
void ChangeRectangleEmptyPoints(datetime &time1,double &price1, 
                                datetime &time2,double &price2) 
  { 
//--- if the first point's time is not set, it will be on the current bar 
   if(!time1) 
      time1=TimeCurrent(); 
//--- if the first point's price is not set, it will have Bid value 
   if(!price1) 
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- if the second point's time is not set, it is located 9 bars left from the second one 
   if(!time2) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time1,10,temp); 
      //--- set the second point 9 bars left from the first one 
      time2=temp[0]; 
     } 
//--- if the second point's price is not set, move it 300 points lower than the first one 
   if(!price2) 
      price2=price1-300*SymbolInfoDouble(Symbol(),SYMBOL_POINT); 
  } 


//+------------------------------------------------------------------+ 
//| Check the values of triangle's anchor points and set default     | 
//| values for empty ones                                            | 
//+------------------------------------------------------------------+ 
void ChangeTriangleEmptyPoints(datetime &time1,double &price1, 
                               datetime &time2,double &price2, 
                               datetime &time3,double &price3) 
  { 
//--- if the first point's time is not set, it will be on the current bar 
   if(!time1) 
      time1=TimeCurrent(); 
//--- if the first point's price is not set, it will have Bid value 
   if(!price1) 
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- if the second point's time is not set, it is located 9 bars left from the second one 
   if(!time2) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time1,10,temp); 
      //--- set the second point 9 bars left from the first one 
      time2=temp[0]; 
     } 
//--- if the second point's price is not set, move it 300 points lower than the first one 
   if(!price2) 
      price2=price1-300*SymbolInfoDouble(Symbol(),SYMBOL_POINT); 
//--- if the third point's time is not set, it coincides with the second point's date 
   if(!time3) 
      time3=time2; 
//--- if the third point's price is not set, it is equal to the first point's one 
   if(!price3) 
      price3=price1; 
  } 


//+------------------------------------------------------------------+ 
//| Check the values of ellipse anchor points and set default values | 
//| for empty ones                                                   | 
//+------------------------------------------------------------------+ 
void ChangeEllipseEmptyPoints(datetime &time1,double &price1, 
                              datetime &time2,double &price2) 
  { 
//--- if the first point's time is not set, it will be on the current bar 
   if(!time1) 
      time1=TimeCurrent(); 
//--- if the first point's price is not set, it will have Bid value 
   if(!price1) 
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
//--- if the second point's time is not set, it is located 9 bars left from the second one 
   if(!time2) 
     { 
      //--- array for receiving the open time of the last 10 bars 
      datetime temp[10]; 
      CopyTime(Symbol(),Period(),time1,10,temp); 
      //--- set the second point 9 bars left from the first one 
      time2=temp[0]; 
     } 
//--- if the second point's price is not set, move it 300 points lower than the first one 
   if(!price2) 
      price2=price1-300*SymbolInfoDouble(Symbol(),SYMBOL_POINT); 
  } 


//+------------------------------------------------------------------+ 
//| Check anchor point values and set default values                 | 
//| for empty ones                                                   | 
//+------------------------------------------------------------------+ 
void ChangeArrowEmptyPoint(datetime &time,double &price) 
  { 
//--- if the point's time is not set, it will be on the current bar 
   if(!time) 
      time=TimeCurrent(); 
//--- if the point's price is not set, it will have Bid value 
   if(!price) 
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
  } 


//+------------------------------------------------------------------+ 
//| Check anchor point values and set default values                 | 
//| for empty ones                                                   | 
//+------------------------------------------------------------------+ 
void ChangeTextEmptyPoint(datetime &time,double &price) 
  { 
//--- if the point's time is not set, it will be on the current bar 
   if(!time) 
      time=TimeCurrent(); 
//--- if the point's price is not set, it will have Bid value 
   if(!price) 
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
  } 

