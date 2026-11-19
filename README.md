# Foco OO — BMVC com Bottle

Página acadêmica personalizada para organizar uma semana de estudos de Orientação a Objetos. O projeto demonstra o fluxo completo do BMVC com uma rota Bottle, um controlador Python, um template TPL e arquivos CSS/JavaScript externos.

## Funcionalidades

- plano de estudos renderizado pelo controlador no template;
- conclusão e filtro de tarefas com progresso automático;
- persistência das tarefas e do tema com `localStorage`;
- timer de foco de 25 minutos;
- tema claro/escuro;
- layout responsivo e navegação acessível.

## Para que utilizar o site?

O site Foco OO seria utilizado por estudantes que desejam organizar e acompanhar seus estudos de Orientação a Objetos. Ele reúne tarefas sobre os principais conteúdos da disciplina, permite marcar atividades concluídas, filtrar tarefas pendentes, acompanhar o progresso semanal e utilizar um cronômetro de 25 minutos para manter a concentração. Além disso, o tema claro ou escuro e o armazenamento do progresso no navegador tornam a experiência mais prática, personalizada e adequada a diferentes rotinas de estudo.

## Fluxo BMVC

```text
GET /foco
    ↓
route.py
    ↓
Application.foco()
    ↓
app/views/html/foco.tpl
    ↓
app/static/css/foco.css + app/static/js/foco.js
```

## Executar localmente

Requer Python 3.10 ou superior.

```bash
python -m venv .venv

# Windows
.venv\Scripts\activate

# Linux/macOS
source .venv/bin/activate

pip install -r requirements.txt
python route.py
```

Acesse [http://localhost:8080](http://localhost:8080). A raiz redireciona para `/foco`.

## Executar com Docker

```bash
docker build -t foco-oo .
docker run --rm -p 8080:8080 foco-oo
```

Depois, abra [http://localhost:8080](http://localhost:8080).

## Estrutura principal

```text
.
├── route.py                         # rotas HTTP e arquivos estáticos
├── app/
│   ├── controllers/application.py  # controlador e dados da view
│   ├── views/html/foco.tpl          # template da página
│   └── static/
│       ├── css/foco.css             # apresentação responsiva
│       └── js/foco.js               # comportamento e persistência
├── requirements.txt
└── Dockerfile
```

## Origem

Estrutura iniciada a partir do repositório didático [`hgmachine/bmvc_start_from_this`](https://github.com/hgmachine/bmvc_start_from_this) e totalmente personalizada para esta entrega.
