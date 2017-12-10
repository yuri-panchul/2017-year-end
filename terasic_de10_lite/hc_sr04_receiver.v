module hc_sr04_receiver
# (
    parameter clk_frequency = 50_000_000
)
(
    input            clk,
    input            rst_n,
    output reg       trig,
    input            echo,
    output reg [7:0] relative_distance
);

    localparam

        n_clk_cycles_in_microsecond         = clk_frequency / 1_000_000,
        n_clk_cycles_in_millisecond         = clk_frequency / 1_000,

        idle_time_in_milliseconds           = 60,
        trig_time_in_microseconds           = 10,

        // Roughly clk / cm for 50 MHz clk

        centimeters_in_microsecond_of_pulse = 58,
        max_range_in_centimeters            = 400,

        idle_time_in_cycles
            = idle_time_in_milliseconds * n_clk_cycles_in_millisecond,

        trig_time_in_cycles
            = trig_time_in_microseconds * n_clk_cycles_in_microseconds;

    reg [17:0] trig_cnt;  // Need to adjust the counter size for clk_frequency

    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            trig_cnt <= 0;
        else
            trig_cnt <= trig_cnt + 1;

    // After reset we need some time for the device initialization
    // After each measurement we also need some idle time
            
    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            trig <= 0;
        else if (trig_cnt == idle_time_in_cycles - trig_time_in_cycles)
            trig <= 1;
        else if (trig_cnt == idle_time_in_cycles)
            trig <= 0;

    reg prev_echo;
    
    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            prev_echo <= 0;
        else
            prev_echo <= echo;

    wire posedge_echo = ~ prev_echo &   echo;
    wire negedge_echo =   prev_echo & ~ echo;

    reg [7:0] echo_cnt;

    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            echo_cnt <= 0;
        else if (posedge_echo)
            echo_cnt <= 0;
        else if (negedge_echo)
            relative_distance <= echo_cnt;
        else
            echo_cnt <= echo_cnt + 1;

endmodule
