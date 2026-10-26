module counter #(
    parameter int WIDTH = 4
) (
    input  logic clk,
    input  logic rst,
    input  logic en,
    output logic [WIDTH-1:0] count
);

    // Synchronous reset takes priority over enable.
    always_ff @(posedge clk) begin
        if (rst) begin
            count <= '0;
        end else if (en) begin
            count <= count + 1'b1;
        end
        // Otherwise the register holds its value.
    end

endmodule
