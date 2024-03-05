##########
# McXFZ_ Software
# InstallGUI
# Version 1.0
##########
# 程序部分代码由@mo2提供
# 开源地址: https://gitee.com/mo2/linux
# 遵循 Apache-2.0 开源协议进行修改
##########
terminal_color() {
    RED=$(printf '\033[31m')
    GREEN=$(printf '\033[32m')
    YELLOW=$(printf '\033[33m')
    BLUE=$(printf '\033[34m')
    PURPLE=$(printf '\033[35m')
    CYAN=$(printf '\033[36m')
    RESET=$(printf '\033[m')
    BOLD=$(printf '\033[1m')
}
##########
welcome() {
    printf "%s\n" "Install ${GREEN}Xfce4 Desktop${RESET} and ${RED}Firefox Browser${RESET}"
    printf "%s\n" "Press ${CYAN}Enter${RESET} to continue."
    read
    if [ $(whoami) != 'root' ];then
        printf "%s\n" "${RED}Please run to root user!${RESET}"
        exit 1
    fi
}
install_programs() {
    printf "%s\n" "If install programs ask about you select ${PURPLE}yes or no${RESET},Please press ${CYAN}Enter${RESET} to continue!"
    printf "%s\n" "如果安装程序询问你选择${PURPLE}是或否${RESET}，请按${CYAN}Enter${RESET}继续！"
    apt update -y && apt upgrade -y
    apt install -y fonts-noto-cjk
    apt install -y fonts-noto-color-emoji
    apt install -y slim
    apt install xfce4-session xfce4-goodies -y
    apt install tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer -y
}
set_vnc_passwd() {
    printf "%s\n" "Setting VNC Password${PURPLE}(Length 6-8)${RESET}"
    printf "%s\n" "设置访问密码${PURPLE}(6-8位)${RESET}"
    read -p "Please input: " VNC_PASSWD
    check_length
}
check_length() {
    PASSWORD_LENGTH=$(printf '%s' ${VNC_PASSWD} | wc -L)
    if ((PASSWORD_LENGTH > 8)); then
        printf "%s\n" "${PASSWORD_LENGTH}"
        printf "%s\n" "密码超过${RED}8个字符${RESET}，请${BLUE}重新输入${RESET}"
        printf "%s\n" "${RED}WARNING！${RESET}The maximum password length is ${RED}8 digits.${RESET}"
        set_vnc_passwd
    elif ((PASSWORD_LENGTH < 6)); then
        printf "%s\n" "${PASSWORD_LENGTH}"
        printf "%s\n" "密码少于${RED}6个字符${RESET}，请${BLUE}重新输入${RESET}"
        printf "%s\n" "${RED}WARNING！${RESET}The minimum password length is ${RED}6 digits.${RESET}"
        set_vnc_passwd
    else
        mkdir -pv ${HOME}/.vnc
        cd ${HOME}/.vnc
        if [ $(command -v vncpasswd) ]; then
            printf "%s\n" "${VNC_PASSWD}" | vncpasswd -f >passwd
        else
            x11vnc -storepasswd ${VNC_PASSWD} passwd
        fi
        chmod 600 -v passwd
        cp passwd x11passwd

        chmod 600 -v x11passwd
    fi
}
install_novnc() {
    cd ${HOME}
    git clone https://github.com/novnc/noVNC ./novnc
    git clone https://github.com/novnc/websockify ./novnc/utils/websockify
    echo -e "vncserver :1\ncd ${HOME}/novnc/utils\n./novnc_proxy --vnc 127.0.0.1:5901 &" > /usr/local/bin/startvnc
    chmod 755 /usr/local/bin/startvnc
}
install_firefox() {
    cd ${HOME}
    wget --no-check-certificate "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=zh-CN" -O Firefox.tar.bz2
    tar xjf Firefox.tar.bz2 -C /opt/
    ln -s /opt/firefox/firefox /usr/local/bin/firefox
    wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P ${HOME}/Desktop
}
finish() {
    printf "%s\n" "${GREEN}${BOLD}Install finish.${RESET}"
    printf "%s\n" "Type(输入) ${BLUE}startvnc${RESET} to start GUI."
    printf "%s\n" "Switch to the ${BLUE}PORTS${RESET} tab(切换到PORTS选项卡) and ${GREEN}open link with port 6080${RESET}(打开带6080端口的链接)."
    printf "%s\n" "Browser open new page,please click(新页面,请点击) ${BLUE}vnc.html${RESET}"
    printf "%s\n" "Click connect buttom,input VNC Password to login it.(点击连接按钮，输入VNC密码登录。)"
    printf "%s\n" "${BLUE}Enjoy it :)${RESET}"

}
main() {
    WORK_DIR=$(pwd)
    terminal_color
    welcome
    install_programs
    set_vnc_passwd
    check_length
    install_novnc
    install_firefox
    finish
    cd ${WORK_DIR}
    exit 0
}
main