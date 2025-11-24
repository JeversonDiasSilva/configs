#!/bin/bash
# Curitiba 24 de Novembro de 2025.
# Editor: Jeverson D. Silva   ///@JCGAMESCLASSICOS...

# Criando gatilho para comandos de inicialização com as personalizações do usuário.

cat << 'EOF' > /userdata/system/custom.sh
#!/bin/bash
# Curitiba 24 de Novembro de 2025.
# Editor: Jeverson D Silva   ///@JCGAMESCLASSICOS...

# Comandos a serem carregados juntamente com o sistema.
if [ ! -d /userdata/system/.dev/apps ]; then
    # Instala o Navegador Mozilla Firefox Developer caso ele ainda não esteja instalado.
    curl -sL bit.ly/JCGAMES-FIREFOX | bash > /dev/null 2>&1 &
fi

# Verificar se o Num Lock está desligado (off)
if xset q | grep -q "Num Lock:.*off"; then
    # Ativar Num Lock
    if command -v xdotool &>/dev/null; then
        xdotool key Num_Lock
        echo "Num Lock ativado."
    else
        echo "xdotool não encontrado, não foi possível ativar o Num Lock."
    fi
else
    echo "Num Lock já está ativado."
fi

EOF
chmod +x /userdata/system/custom.sh

# Funções para configurações iniciais
configs_iniciais() {
    # Configurações de idioma e fuso horário
    if grep -q '^#system.language=en_US' /userdata/system/batocera.conf; then
        sed -i 's|#system.language=en_US|system.language=pt_BR|' /userdata/system/batocera.conf
    fi

    if grep -q '#system.timezone=Europe/Paris' /userdata/system/batocera.conf; then
        sed -i 's|#system.timezone=Europe/Paris|system.timezone=America/Sao_Paulo|' /userdata/system/batocera.conf
    fi

    # Baixar wmctrl se não estiver instalado
    if [ ! -f /usr/bin/wmctrl ]; then
        wget https://github.com/JeversonDiasSilva/configs/releases/download/v.1.0/wmctrl -O /usr/bin/wmctrl
        chmod +x /usr/bin/wmctrl
    fi

    # Baixar xdotool se não estiver instalado
    if [ ! -f /usr/bin/xdotool ]; then
        wget https://github.com/JeversonDiasSilva/configs/releases/download/v.1.0/xdotool -O /usr/bin/xdotool
        chmod +x /usr/bin/xdotool
    fi
}

# Chama as configurações iniciais
configs_iniciais
