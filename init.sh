#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=== Инициализация проекта SQL-задач ===${NC}"

# Запуск контейнеров
echo -e "${GREEN}Запуск контейнеров...${NC}"
docker compose up -d

# Ожидание готовности MySQL
echo -e "${GREEN}Ожидание готовности MySQL...${NC}"
until docker compose exec mysql mysqladmin ping -h localhost -uroot -proot --silent; do
    echo -n "."
    sleep 2
done
echo -e "\n${GREEN}MySQL готов${NC}"

# Ожидание готовности PostgreSQL
echo -e "${GREEN}Ожидание готовности PostgreSQL...${NC}"
until docker compose exec postgres pg_isready -U postgres; do
    echo -n "."
    sleep 2
done
echo -e "\n${GREEN}PostgreSQL готов${NC}"

# Инициализация баз данных
echo -e "${GREEN}Инициализация баз данных...${NC}"
make init-mysql
make init-postgres

echo -e "${GREEN}=== Инициализация завершена ===${NC}"
echo -e "${BLUE}Для выполнения всех задач используйте:${NC}"
echo "  make all-mysql      - Выполнить все задачи в MySQL"
echo "  make all-postgres   - Выполнить все задачи в PostgreSQL"
echo ""
echo -e "${BLUE}Для выполнения конкретных задач:${NC}"
echo "  make task1-mysql    - Задача 1 (Транспортные средства) в MySQL"
echo "  make racing-task1-mysql - Задача 1 (Автомобильные гонки) в MySQL"
echo "  make hotel-task1-mysql  - Задача 1 (Бронирование отелей) в MySQL"
echo "  make org-task1-mysql    - Задача 1 (Структура организации) в MySQL"
