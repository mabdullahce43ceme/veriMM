module MAC (
    input wire clk, rst,
    input wire[7:0] a, b,
    output wire[7:0] c
);

/**
 * inputs and output all are datatype: 'uint8_t'
 * to prevent overflow, saturation is applied on both the addition and multiplication.
**/
    reg cout;
    reg[7:0] internal;
    reg[15:0] mul_res;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            temp <= 8'd0;
        end else begin
            // Perform multiplication with saturation
            mul_res = a * b;
            if (mul_res > 8'd255) begin
                mul_res = 8'd255;
            end

            // Perform addition with saturation
            {cout, temp} = mul_res + temp;
            if (cout) begin
                temp <= 8'd255;
            end
        end
    end
    assign c = temp;


endmodule

