# MoonBit Motion Lab 项目说明

## 基本信息

- **项目名称**：MoonBit Motion Lab
- **MoonBit 模块**：`Kai-Junhan/moonbit-motion-lab`
- **GitHub 仓库**：`https://github.com/Kai-Junhan/moonbit-motion-lab`
- **许可证**：Apache-2.0

## 项目定位

MoonBit Motion Lab 是面向动画、可视化和交互程序的运动曲线编排与质量验证工具包。它不发布标准固定缓动函数目录，也不提供 CSS easing 预设，因此与 Mooncakes 上维护标准缓动函数的包保持清晰边界。

项目从开发者已经选择或设计的运动曲线开始，提供统一的 `MotionFn` 接口，以及以下与渲染器无关的能力：

- 参数化 `back` 和 `spring` 运动曲线
- 用户控制点定义的三次贝塞尔曲线
- 确定性采样和应用值插值
- 速度、单调性、超调和端点误差诊断
- 顺序时间轴到固定帧率数组的编译

## 核心差异化

1. **曲线质量报告**：`profile` 返回最小值、最大值、最大速度、峰值速度时间、单调性和端点误差，适合自动化验证和调参。
2. **运动时间轴**：`MotionTimeline` 将多个区间、持续时间和运动曲线编排为可复现的固定帧率数据。
3. **显式参数**：`back_in`、`back_out` 和 `spring_out` 的行为由调用者传入参数控制，而不是增加一组固定命名预设。
4. **自定义曲线**：`CubicBezier` 只负责用户提供控制点的求值，不复制 CSS 预设集合。

## 交付内容

- `MotionFn`、参数化 back/spring 曲线
- `CubicBezier` 自定义三次贝塞尔求值
- 采样、插值、帧数组生成和速度估计
- 单调性、超调和端点质量检查
- `CurveReport` 诊断报告
- `MotionTimeline` 顺序时间轴
- 示例、单元测试和 GitHub Actions CI

## 明确不做

- 标准固定运动曲线公式集合
- CSS `ease`、`ease-in`、`ease-out`、`ease-in-out` 预设
- DOM、渲染、动画循环、调度器或并发运行时

## 验证

```bash
moon fmt --check
moon check
moon test
moon build
moon run ./examples/basic
```

## 重新申报说明

旧项目因标准缓动函数集合与已有维护库重叠而被驳回。本版本已将交付重点改为参数化运动曲线、曲线质量验证和时间轴数据编排，并同步使用 `MoonBit Motion Lab`、`moonbit-motion-lab` 和 `Kai-Junhan/moonbit-motion-lab` 作为项目、目录和模块标识。
