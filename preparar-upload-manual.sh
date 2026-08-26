#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SITE_DIR="$(cd -- "$SCRIPT_DIR/../site" && pwd)"
UPLOAD_DIR="$(mktemp -d /tmp/northon-upload-manual.XXXXXX)"
FILES=(
  index.html
  sobre.html
  conteudos-intermitentes.html
  curiosidades-homeomorfas.html
  404.html
  styles.css
  app.js
  .nojekyll
)

python3 "$SCRIPT_DIR/validar-site.py" "$SITE_DIR"

for file in "${FILES[@]}"; do
  if [[ ! -e "$SITE_DIR/$file" ]]; then
    printf 'Erro: arquivo público ausente: %s\n' "$file" >&2
    exit 1
  fi
  cp -a "$SITE_DIR/$file" "$UPLOAD_DIR/"
done

printf '\nPasta preparada para o upload manual:\n  %s\n\n' "$UPLOAD_DIR"
printf 'Arquivos que devem ser enviados para a raiz do repositório:\n'
for file in "${FILES[@]}"; do
  printf '  - %s\n' "$file"
done

printf '\nProcedimento no GitHub:\n'
printf '  1. Abra https://github.com/NORTHLEME/northon-site\n'
printf '  2. Escolha Add file > Upload files.\n'
printf '  3. Abra a pasta temporária indicada acima e selecione todos os oito arquivos.\n'
printf '  4. Confirme que index.html ficará na raiz, sem uma pasta adicional.\n'
printf '  5. Use a mensagem: Atualiza perfil e produção acadêmica.\n'
printf '  6. Clique em Commit changes e acompanhe a publicação em Actions.\n'
printf '  7. Aguarde até 10 minutos e atualize a página com Ctrl+Shift+R.\n\n'
printf 'Não envie o PDF do Lattes, documentos, scripts, logs ou arquivos da pasta docs.\n'
