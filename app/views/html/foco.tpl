<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Painel interativo para organizar uma semana de estudos de Orientação a Objetos.">
    <title>Foco OO | Plano de estudos</title>
    <link rel="icon" href="/static/img/favicon.svg" type="image/svg+xml">
    <script>
        document.documentElement.dataset.theme = localStorage.getItem("foco-oo-theme") === "dark" ? "dark" : "light";
    </script>
    <link rel="stylesheet" href="/static/css/foco.css">
    <script src="/static/js/foco.js" defer></script>
</head>
<body>
    <a class="skip-link" href="#conteudo">Pular para o conteúdo</a>

    <header class="site-header">
        <a class="brand" href="/foco" aria-label="Página inicial Foco OO">
            <span class="brand-mark" aria-hidden="true">FO</span>
            <span>Foco OO</span>
        </a>

        <nav class="main-nav" aria-label="Navegação principal">
            <a href="#plano">Plano</a>
            <a href="#metodo">Método</a>
        </nav>

        <button class="icon-button" id="theme-toggle" type="button" aria-label="Ativar tema escuro">
            <span class="theme-icon" aria-hidden="true">◐</span>
        </button>
    </header>

    <main id="conteudo">
        <section class="hero" aria-labelledby="hero-title">
            <div class="hero-copy">
                <p class="eyebrow"><span id="today-label">Plano da semana</span> · Orientação a Objetos</p>
                <h1 id="hero-title">Estude com intenção.<br><em>Avance com clareza.</em></h1>
                <p class="hero-text">
                    Um painel simples para transformar conceitos de OO em sessões curtas,
                    acompanhar o que já foi feito e manter o foco no próximo passo.
                </p>
                <a class="primary-action" href="#plano">Ver plano de estudos</a>
            </div>

            <div class="progress-panel" aria-label="Progresso semanal">
                <div class="progress-heading">
                    <span>Progresso semanal</span>
                    <strong id="progress-value">0/{{total_tarefas}}</strong>
                </div>
                <div class="progress-track" role="progressbar" aria-label="Tarefas concluídas" aria-valuemin="0" aria-valuemax="{{total_tarefas}}" aria-valuenow="0">
                    <span id="progress-bar"></span>
                </div>
                <p id="progress-message">Comece por uma tarefa pequena. O ritmo vem depois.</p>
            </div>
        </section>

        <section class="study-layout" id="plano" aria-labelledby="plan-title">
            <div class="plan-column">
                <div class="section-heading">
                    <div>
                        <p class="eyebrow">Roteiro prático</p>
                        <h2 id="plan-title">Plano da semana</h2>
                    </div>
                    <div class="filters" role="group" aria-label="Filtrar tarefas">
                        <button class="filter-button is-active" type="button" data-filter="all" aria-pressed="true">Todas</button>
                        <button class="filter-button" type="button" data-filter="pending" aria-pressed="false">Pendentes</button>
                        <button class="filter-button" type="button" data-filter="done" aria-pressed="false">Concluídas</button>
                    </div>
                </div>

                <div class="task-list" id="task-list">
                    % for tarefa in tarefas:
                    <article class="task-card" data-task-id="{{tarefa['id']}}">
                        <label class="task-check">
                            <input type="checkbox" aria-label="Concluir: {{tarefa['titulo']}}">
                            <span aria-hidden="true"></span>
                        </label>
                        <div class="task-content">
                            <div class="task-meta">
                                <span>{{tarefa['area']}}</span>
                                <span>{{tarefa['tempo']}}</span>
                            </div>
                            <h3>{{tarefa['titulo']}}</h3>
                            <p>{{tarefa['descricao']}}</p>
                        </div>
                    </article>
                    % end
                    <p class="empty-state" id="empty-state" hidden>Nenhuma tarefa neste filtro.</p>
                </div>
            </div>

            <aside class="focus-card" aria-labelledby="timer-title">
                <p class="eyebrow">Sessão de foco</p>
                <h2 id="timer-title">Um passo de cada vez</h2>
                <p>Escolha uma tarefa, afaste as distrações e trabalhe por 25 minutos.</p>

                <div class="timer" id="timer" role="timer" aria-live="off">25:00</div>
                <p class="timer-status" id="timer-status" aria-live="polite">Pronto para começar</p>

                <div class="timer-actions">
                    <button class="primary-button" id="timer-toggle" type="button">Iniciar foco</button>
                    <button class="secondary-button" id="timer-reset" type="button">Reiniciar</button>
                </div>

                <div class="focus-tip">
                    <span aria-hidden="true">◎</span>
                    <p><strong>Dica:</strong> escreva uma pergunta antes de iniciar. Ela orienta a sessão.</p>
                </div>
            </aside>
        </section>

        <section class="method-section" id="metodo" aria-labelledby="method-title">
            <div class="method-intro">
                <p class="eyebrow">Sob o capô</p>
                <h2 id="method-title">BMVC em funcionamento</h2>
                <p>
                    A interface também demonstra a arquitetura do projeto: cada parte tem
                    uma responsabilidade clara, da URL acessada até a interação no navegador.
                </p>
            </div>

            <ol class="flow-list">
                <li>
                    <span class="flow-code">GET /foco</span>
                    <div><strong>Rota</strong><p>O Bottle recebe a requisição e aciona o controlador.</p></div>
                </li>
                <li>
                    <span class="flow-code">Application</span>
                    <div><strong>Controlador</strong><p>Organiza os dados do plano e escolhe a view.</p></div>
                </li>
                <li>
                    <span class="flow-code">foco.tpl</span>
                    <div><strong>Template</strong><p>Gera o HTML com as tarefas recebidas.</p></div>
                </li>
                <li>
                    <span class="flow-code">CSS + JS</span>
                    <div><strong>Navegador</strong><p>Aplica o visual e ativa filtros, tema, progresso e timer.</p></div>
                </li>
            </ol>
        </section>
    </main>

    <footer>
        <p><strong>Foco OO</strong> · Projeto acadêmico construído com Bottle + BMVC.</p>
        <p>Feito para aprender fazendo · <span id="current-year">2026</span></p>
    </footer>

    <div class="toast" id="toast" role="status" aria-live="polite" aria-atomic="true"></div>
</body>
</html>
