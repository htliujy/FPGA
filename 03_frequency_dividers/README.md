# 分频器

可以选择下降沿输出，可以选择上升沿输出。

```shell
iverilog -o divider_test frequency_divider_tb.v frequency_divider.v
vvp divider_test
gtkwave test.vcd
```
