module uart #(
  parameter BAUD_RATE = 115200
)(
  input wire rst,
  input wire clk,
  input wire [31:0] clk_freq,

  input wire rx,
  input wire read,
  input wire irq_en,
  output wire irq,
  output wire [7:0] rx_data,

  output wire tx,
  input wire tx_start,
  input wire [7:0] tx_data,
  output wire clear_req
);

  wire [31:0] clk_div;
  assign clk_div = clk_freq / BAUD_RATE;

  uart_receive      receive(
    .rst        (rst    ),
    .clk        (clk    ),
    .clk_div    (clk_div),
    .rx         (rx     ),
    .read       (read   ),
    .irq_en     (irq_en ),
    .irq        (irq    ),
    .rx_data    (rx_data)
  );

  uart_transmission transmission(
    .rst        (rst    ),
    .clk        (clk    ),
    .clk_div    (clk_div),
    .tx_start   (rx_start),
    .tx_data    (tx_data),
    .tx         (tx     ),
    .clear_req  (clear_req)
  );

endmodule
