
# 日本語入力をibusに変更

sudo apt install ibus-mozc -y
im-config -n ibus
ibus restart

# pipxのインストール

wget https://github.com/pypa/pipx/releases/latest/download/pipx.pyz
sudo apt install python3.12-venv -y
python3 pipx.pyz install pipx
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bash_profile
rm pipx.pyz