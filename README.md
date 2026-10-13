# TP Jet · Teleprompter

Teleprompter web para gravar Reels no celular ou tablet.

- Cole o roteiro vindo do WhatsApp ou do e-mail (no Android instalado: Compartilhar → TP Jet).
- Rolagem contínua com velocidade ajustável, tamanho de fonte, margem e linha-guia.
- Espelhamento horizontal e vertical para uso com vidro de teleprompter.
- Controle Bluetooth: teclas, rolagem e gestos (deslizar/tocar) são aceitos. Use a tela **Teste** para ver o que o seu controle envia.
- Modo selfie: câmera frontal com o texto no topo da tela, perto da lente; grava o vídeo e salva na galeria.
- Funciona offline e pode ser instalado na tela inicial.
- Banco compartilhado (Supabase): login com código por e-mail, só para @jetbov.com. Toda a equipe vê a mesma lista de roteiros, em qualquer aparelho. Sem configuração em `config.js`, os roteiros ficam só no aparelho.

## Banco de dados

1. Rode `supabase.sql` no SQL Editor do projeto Supabase.
2. Preencha `config.js` com a Project URL e a chave publishable/anon (nunca a service_role/secret).

## Comandos

| Ação | Teclado / controle de slides | Gesto (controle de Reels/TikTok) |
|---|---|---|
| Avançar um pouco | ↓, PageDown | deslizar para cima |
| Voltar um pouco | ↑, PageUp | deslizar para baixo |
| Pausar / continuar | Espaço, Enter | toque ou toque duplo |
| Velocidade + / − | → / ← | deslizar para esquerda / direita |
| Voltar ao início | Home | — |
| Sair | Esc | — |
