#!/bin/bash

cd armbian

# 定义不同板子的编译参数
declare -A BOARD_CONFIGS=(
    # 格式: ["BOARD_NAME"]="BRANCH BUILD_DESKTOP BUILD_MINIMAL ..."
    ["uefi-x86"]="current no yes"
    ["mangopi-m28k"]="vendor no yes"
    ["nanopi-r5c"]="current no yes"
    # 可以继续添加其他板子
)

# 提取所有 BOARD 名字，用于用户选择
BOARDS=("${!BOARD_CONFIGS[@]}")

# 显示选项菜单
echo "请选择要编译的板子："
for i in "${!BOARDS[@]}"; do
    echo "$((i+1))) ${BOARDS[$i]}"
done

# 读取用户输入
read -p "输入编号 (1-${#BOARDS[@]}): " choice

# 检查用户输入是否有效
if [[ "$choice" -lt 1 || "$choice" -gt "${#BOARDS[@]}" ]]; then
    echo "错误：无效的选择！"
    exit 1
fi

# 获取用户选择的板子
SELECTED_BOARD="${BOARDS[$((choice-1))]}"
# 提取对应的参数
IFS=' ' read -r BRANCH BUILD_DESKTOP BUILD_MINIMAL <<< "${BOARD_CONFIGS[$SELECTED_BOARD]}"

echo "你选择了: $SELECTED_BOARD"
echo "参数: BRANCH=$BRANCH, BUILD_DESKTOP=$BUILD_DESKTOP, BUILD_MINIMAL=$BUILD_MINIMAL"

# 执行编译
./compile.sh \
    build BOARD="$SELECTED_BOARD" \
    BRANCH="$BRANCH" \
    BUILD_DESKTOP="$BUILD_DESKTOP" \
    BUILD_MINIMAL="$BUILD_MINIMAL" \
    KERNEL_CONFIGURE=no \
    RELEASE=bookworm \
    KERNEL_GIT=shallow \
    NETWORKING_STACK="none"


