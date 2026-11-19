"use strict";

document.addEventListener("DOMContentLoaded", () => {
    const STORAGE_TASKS = "foco-oo-completed";
    const STORAGE_THEME = "foco-oo-theme";
    const cards = [...document.querySelectorAll(".task-card")];
    const filterButtons = [...document.querySelectorAll(".filter-button")];
    const progressValue = document.querySelector("#progress-value");
    const progressBar = document.querySelector("#progress-bar");
    const progressTrack = document.querySelector(".progress-track");
    const progressMessage = document.querySelector("#progress-message");
    const emptyState = document.querySelector("#empty-state");
    const themeToggle = document.querySelector("#theme-toggle");
    const toast = document.querySelector("#toast");
    let activeFilter = "all";
    let toastTimeout;

    function loadCompletedTasks() {
        try {
            const saved = JSON.parse(localStorage.getItem(STORAGE_TASKS) || "[]");
            return new Set(Array.isArray(saved) ? saved : []);
        } catch {
            return new Set();
        }
    }

    const completedTasks = loadCompletedTasks();

    function showToast(message) {
        window.clearTimeout(toastTimeout);
        toast.textContent = message;
        toast.classList.add("is-visible");
        toastTimeout = window.setTimeout(() => toast.classList.remove("is-visible"), 2600);
    }

    function updateProgress() {
        const total = cards.length;
        const completed = cards.filter((card) => completedTasks.has(card.dataset.taskId)).length;
        const percentage = total ? Math.round((completed / total) * 100) : 0;

        progressValue.textContent = `${completed}/${total}`;
        progressBar.style.width = `${percentage}%`;
        progressTrack.setAttribute("aria-valuenow", String(completed));

        if (completed === total && total > 0) {
            progressMessage.textContent = "Semana concluída. Hora de revisar o que você aprendeu.";
        } else if (completed > 0) {
            progressMessage.textContent = `${percentage}% concluído. Continue no seu ritmo.`;
        } else {
            progressMessage.textContent = "Comece por uma tarefa pequena. O ritmo vem depois.";
        }
    }

    function applyFilter() {
        let visibleCards = 0;

        cards.forEach((card) => {
            const done = completedTasks.has(card.dataset.taskId);
            const visible = activeFilter === "all"
                || (activeFilter === "done" && done)
                || (activeFilter === "pending" && !done);
            card.hidden = !visible;
            if (visible) visibleCards += 1;
        });

        emptyState.hidden = visibleCards !== 0;
    }

    cards.forEach((card) => {
        const checkbox = card.querySelector("input[type='checkbox']");
        const id = card.dataset.taskId;
        checkbox.checked = completedTasks.has(id);
        card.classList.toggle("is-done", checkbox.checked);

        checkbox.addEventListener("change", () => {
            if (checkbox.checked) {
                completedTasks.add(id);
                showToast("Tarefa concluída. Bom trabalho!");
            } else {
                completedTasks.delete(id);
                showToast("Tarefa marcada como pendente.");
            }

            card.classList.toggle("is-done", checkbox.checked);
            localStorage.setItem(STORAGE_TASKS, JSON.stringify([...completedTasks]));
            updateProgress();
            applyFilter();
        });
    });

    filterButtons.forEach((button) => {
        button.addEventListener("click", () => {
            activeFilter = button.dataset.filter;
            filterButtons.forEach((item) => {
                const active = item === button;
                item.classList.toggle("is-active", active);
                item.setAttribute("aria-pressed", String(active));
            });
            applyFilter();
        });
    });

    function updateThemeButton() {
        const isDark = document.documentElement.dataset.theme === "dark";
        themeToggle.setAttribute("aria-label", isDark ? "Ativar tema claro" : "Ativar tema escuro");
        themeToggle.querySelector(".theme-icon").textContent = isDark ? "☀" : "◐";
    }

    themeToggle.addEventListener("click", () => {
        const nextTheme = document.documentElement.dataset.theme === "dark" ? "light" : "dark";
        document.documentElement.dataset.theme = nextTheme;
        localStorage.setItem(STORAGE_THEME, nextTheme);
        updateThemeButton();
    });

    const timerDisplay = document.querySelector("#timer");
    const timerStatus = document.querySelector("#timer-status");
    const timerToggle = document.querySelector("#timer-toggle");
    const timerReset = document.querySelector("#timer-reset");
    const sessionLength = 25 * 60;
    let remainingSeconds = sessionLength;
    let timerId = null;

    function formatTime(seconds) {
        const minutes = Math.floor(seconds / 60).toString().padStart(2, "0");
        const remainder = (seconds % 60).toString().padStart(2, "0");
        return `${minutes}:${remainder}`;
    }

    function renderTimer() {
        timerDisplay.textContent = formatTime(remainingSeconds);
        document.title = timerId ? `${formatTime(remainingSeconds)} | Foco OO` : "Foco OO | Plano de estudos";
    }

    function pauseTimer(message = "Sessão pausada") {
        window.clearInterval(timerId);
        timerId = null;
        timerToggle.textContent = "Continuar";
        timerStatus.textContent = message;
        renderTimer();
    }

    function startTimer() {
        if (remainingSeconds === 0) remainingSeconds = sessionLength;
        timerToggle.textContent = "Pausar";
        timerStatus.textContent = "Foco em andamento";
        timerId = window.setInterval(() => {
            remainingSeconds -= 1;
            renderTimer();

            if (remainingSeconds === 0) {
                pauseTimer("Sessão concluída");
                timerToggle.textContent = "Nova sessão";
                showToast("25 minutos concluídos. Faça uma pausa curta.");
            }
        }, 1000);
        renderTimer();
    }

    timerToggle.addEventListener("click", () => {
        if (timerId) pauseTimer();
        else startTimer();
    });

    timerReset.addEventListener("click", () => {
        window.clearInterval(timerId);
        timerId = null;
        remainingSeconds = sessionLength;
        timerToggle.textContent = "Iniciar foco";
        timerStatus.textContent = "Pronto para começar";
        renderTimer();
    });

    const now = new Date();
    const formattedDate = new Intl.DateTimeFormat("pt-BR", {
        weekday: "long",
        day: "2-digit",
        month: "long",
    }).format(now);
    document.querySelector("#today-label").textContent = formattedDate;
    document.querySelector("#current-year").textContent = String(now.getFullYear());

    updateThemeButton();
    updateProgress();
    applyFilter();
    renderTimer();
});
