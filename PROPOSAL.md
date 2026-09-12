# MoonBit Motion Lab 项目说明

## 基本信息

- **项目名称**：MoonBit Motion Lab
- **MoonBit 模块**：`Kai-Junhan/moonbit-motion-lab`
- **GitHub 仓库**：https://github.com/Kai-Junhan/moonbit-motion-lab
- **许可证**：Apache-2.0
- **项目性质**：原创 MoonBit 项目，不是移植项目

## 项目定位

MoonBit Motion Lab 是一个面向动画、数据可视化和交互程序的运动曲线质量验证与确定性时间轴工具包。它接收调用方已经选择的 `MotionFn`，输出可检查的数值诊断、显式的验收结论和固定帧率数据；不提供任何命名或固定的 easing 公式。

`Zlj6566/moonbit-easing` 等包解决“使用哪条缓动曲线”。Motion Lab 解决“这条曲线是否符合端点、单调性、超调和速度约束，以及如何生成可复现的数值帧”。调用方可以把外部 easing 函数包裹为 `MotionFn` 后交给 Motion Lab，因此两个包可以组合使用，而不存在公式目录的重复建设。

## 交付内容

- `MotionFn`：调用方曲线的统一接入类型
- 确定性采样、插值、速度、单调性和超调计算
- `CurveReport`：范围、峰值速度、峰值时间、单调性和端点误差
- `CurvePolicy` 与 `check`：端点容差、单调性、超调和速度的验收策略
- `MotionTimeline`：顺序数值段落和固定帧率输出
- 可运行示例、单元测试和 GitHub Actions CI

## 明确不做

- 标准、命名或固定 easing 公式目录
- CSS `ease*` 预设、spring/back/bounce/elastic/cubic-Bezier 公式
- DOM、渲染器、动画循环、调度器或运行时
- 对 `Zlj6566/moonbit-easing` 的源码、API 或数据进行移植、复制或重写

## 验证

```bash
moon fmt --check
moon check
moon test
moon build
moon run ./examples/basic
```
