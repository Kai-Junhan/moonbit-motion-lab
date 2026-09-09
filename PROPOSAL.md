# moonbit-easing 项目申报书

## 基本信息
- **项目名称**：moonbit-easing - MoonBit 缓动函数库
- **GitHub 仓库链接**：[待填写]
- **项目方向**：MoonBit 动画/图形工具库
- **是否为移植项目**：否，原创项目（参考标准缓动函数数学公式）

## 项目简介
moonbit-easing 是一个全面的缓动函数（easing functions）库，为 MoonBit 生态提供30+经典缓动曲线、三次贝塞尔曲线支持和动画工具。项目填补了 MoonBit 在动画和过渡效果方面的基础设施空白。

**核心痛点**：动画和可视化应用需要流畅的过渡效果，而非线性的突变。缓动函数提供数学化的加速/减速曲线，让动画看起来自然、专业。目前 MoonBit 生态缺少这一基础能力，开发者只能使用简单线性插值或手写复杂的数学公式。

**生态定位**：作为动画和交互的基础库，moonbit-easing 可以被UI框架、游戏引擎、数据可视化工具依赖，提供标准化的动画曲线。与 moonbit-color 结合可实现平滑的色彩过渡动画。

## 核心功能范围

### 1. 经典缓动函数（30+）
- **线性**：无加速（linear）
- **二次方**：ease-in/out/in-out quad
- **三次方**：ease-in/out/in-out cubic
- **四次方**：ease-in/out/in-out quart
- **五次方**：ease-in/out/in-out quint
- **正弦**：ease-in/out/in-out sine
- **指数**：ease-in/out/in-out expo
- **圆形**：ease-in/out/in-out circ
- **回弹**：ease-in/out/in-out back（超出后拉回）
- **弹性**：ease-in/out/in-out elastic（弹簧效果）
- **弹跳**：ease-in/out/in-out bounce（球体落地效果）

### 2. 三次贝塞尔曲线
- 自定义贝塞尔曲线（4个控制点）
- 牛顿-拉弗森法求解（精确计算时间点对应值）
- CSS cubic-bezier 预设（ease, ease-in, ease-out, ease-in-out）

### 3. 缓动工具函数
- 数值插值（在起始值和结束值间应用缓动）
- 序列生成（生成N帧动画的数值数组）
- 缓动链接（前半段用A曲线，后半段用B曲线）
- 缓动反转（ease-in变ease-out）
- 缓动镜像（生成ease-in-out效果）
- 输出限幅（确保结果在[0,1]区间）

## 预期使用场景

### 场景1：UI动画过渡
**问题**：按钮点击、对话框弹出、页面切换需要平滑动画，线性过渡显得生硬。
**解决**：使用缓动函数让动画自然加速和减速，提升用户体验。

```moonbit
// 对话框从0到100%透明度，使用ease-out-cubic（快速出现后慢慢稳定）
let frames = @easing.ease_sequence(0.0, 1.0, 30, @easing.ease_out_cubic)
for opacity in frames {
  render_dialog_with_opacity(opacity)
}
```

### 场景2：数据可视化动画
**问题**：图表更新时数据点需要平滑移动到新位置，而非瞬间跳变。
**解决**：使用缓动函数插值新旧坐标，配合moonbit-color实现数据+颜色双重过渡。

```moonbit
// 柱状图高度从旧值过渡到新值
let old_height = 50.0
let new_height = 80.0
let current_height = @easing.ease_value(old_height, new_height, t, @easing.ease_in_out_quad)
```

### 场景3：游戏/交互效果
**问题**：角色跳跃、相机运动、道具掉落需要符合物理直觉的运动曲线。
**解决**：弹跳、弹性、回弹缓动函数模拟真实物理效果。

```moonbit
// 角色跳跃轨迹（弹跳效果）
let jump_height = @easing.ease_value(0.0, 100.0, t, @easing.ease_out_bounce)
```

## 技术路径

### 实现路径
1. **经典缓动**：基于Robert Penner标准公式实现，处理边界值（t=0, t=1）
2. **贝塞尔曲线**：牛顿迭代法求解X轴对应的参数t，再计算Y轴值（10次迭代，精度0.0001）
3. **工具函数**：高阶函数设计，支持缓动组合和变换
4. **类型安全**：使用 `EasingFn = (Double) -> Double` 类型别名保证API一致性

### 技术理解
- **缓动分类**：
  - ease-in：慢启动，逐渐加速（适合离开屏幕）
  - ease-out：快启动，逐渐减速（适合进入屏幕）
  - ease-in-out：慢启动+慢结束（适合往返动画）
- **贝塞尔优势**：可表达任意非标准曲线，CSS动画的底层实现
- **组合模式**：通过函数式编程实现缓动变换，而非硬编码每种组合

### 所需能力
- 数学基础（幂函数、三角函数、迭代求解）
- 函数式编程（高阶函数、闭包）
- 动画原理（关键帧、时间归一化）
- 工程实践（边界条件、数值稳定性）

## 交付范围
- ✅ 30+经典缓动函数（linear, quad, cubic, quart, quint, sine, expo, circ, back, elastic, bounce）
- ✅ 三次贝塞尔曲线实现（牛顿法求解）
- ✅ CSS cubic-bezier 预设（ease系列）
- ✅ 5个工具函数（插值、序列、链接、反转、镜像）
- ✅ 25个单元测试（覆盖所有缓动函数和工具）
- ✅ 完整的API文档和使用示例
- ✅ GitHub Actions CI/CD（check/test/build）
- ✅ 发布到 mooncakes.io

## 明确不做的内容
- 不实现动画时间轴管理（属于动画引擎范畴）
- 不提供DOM操作或渲染功能（仅提供数学计算）
- 不实现关键帧系统（缓动函数是单一曲线，不管理多帧）
- 不处理并发动画调度（属于运行时范畴）

## 参考资料与开源规范
- **Robert Penner's Easing Functions**：缓动函数的行业标准
- **easings.net**（CC BY-SA 4.0）：缓动曲线可视化参考
- **W3C CSS Easing Functions Level 1**：cubic-bezier标准规范
- **Newton-Raphson Method**：数值求解算法

**参考思路**（算法独立实现）：
- easing-utils（各语言通用公式）
- bezier-easing（JS实现思路）

所有代码从零实现，仅参考数学公式和算法原理，不复制现有代码。

## 项目许可证
Apache License 2.0 - 允许商业使用、修改和分发，要求保留版权声明。

---

**项目特色**：
1. **全面性**：涵盖所有常用缓动类型，满足99%动画需求
2. **精确性**：贝塞尔曲线使用数值方法求解，精度可控
3. **组合性**：函数式设计支持缓动自由组合和变换
4. **协同性**：与moonbit-color配合实现色彩+运动的双重动画效果
5. **标准化**：遵循CSS和行业标准，开发者无需学习新概念
