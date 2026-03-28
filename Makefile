.PHONY: help up down init-mysql init-postgres all-mysql all-postgres

help:
	@echo "Доступные команды:"
	@echo "  make up              - Запустить все контейнеры"
	@echo "  make down            - Остановить все контейнеры"
	@echo "  make init-mysql      - Инициализировать MySQL"
	@echo "  make init-postgres   - Инициализировать PostgreSQL"
	@echo "  make all-mysql       - Выполнить все задачи в MySQL"
	@echo "  make all-postgres    - Выполнить все задачи в PostgreSQL"

up:
	docker compose up -d

down:
	docker compose down

init-mysql:
	@echo "Инициализация MySQL..."
	docker compose exec -T mysql mysql -uroot -proot tasks_db < databases/vehicles/01_create_tables.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < databases/vehicles/02_insert_data.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < databases/racing/01_create_tables.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < databases/racing/02_insert_data.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < databases/hotel/01_create_tables.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < databases/hotel/02_insert_data.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < databases/organization/01_create_tables.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < databases/organization/02_insert_data.sql

init-postgres:
	@echo "Инициализация PostgreSQL..."
	docker compose exec -T postgres psql -U postgres -d tasks_db < databases/vehicles/01_create_tables_postgres.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < databases/vehicles/02_insert_data.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < databases/racing/01_create_tables_postgres.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < databases/racing/02_insert_data.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < databases/hotel/01_create_tables_postgres.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < databases/hotel/02_insert_data.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < databases/organization/01_create_tables_postgres.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < databases/organization/02_insert_data.sql

all-mysql: vehicles-mysql racing-mysql hotel-mysql organization-mysql

all-postgres: vehicles-postgres racing-postgres hotel-postgres organization-postgres

vehicles-mysql:
	@echo "=== Транспортные средства - MySQL ==="
	docker compose exec -T mysql mysql -uroot -proot tasks_db < solutions/mysql/vehicles/task1.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < solutions/mysql/vehicles/task2.sql

racing-mysql:
	@echo "=== Автомобильные гонки - MySQL ==="
	docker compose exec -T mysql mysql -uroot -proot tasks_db < solutions/mysql/racing/task1.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < solutions/mysql/racing/task2.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < solutions/mysql/racing/task3.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < solutions/mysql/racing/task4.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < solutions/mysql/racing/task5.sql

hotel-mysql:
	@echo "=== Бронирование отелей - MySQL ==="
	docker compose exec -T mysql mysql -uroot -proot tasks_db < solutions/mysql/hotel/task1.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < solutions/mysql/hotel/task2.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < solutions/mysql/hotel/task3.sql

organization-mysql:
	@echo "=== Структура организации - MySQL ==="
	docker compose exec -T mysql mysql -uroot -proot tasks_db < solutions/mysql/organization/task1.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < solutions/mysql/organization/task2.sql
	docker compose exec -T mysql mysql -uroot -proot tasks_db < solutions/mysql/organization/task3.sql

vehicles-postgres:
	@echo "=== Транспортные средства - PostgreSQL ==="
	docker compose exec -T postgres psql -U postgres -d tasks_db < solutions/postgresql/vehicles/task1.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < solutions/postgresql/vehicles/task2.sql

racing-postgres:
	@echo "=== Автомобильные гонки - PostgreSQL ==="
	docker compose exec -T postgres psql -U postgres -d tasks_db < solutions/postgresql/racing/task1.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < solutions/postgresql/racing/task2.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < solutions/postgresql/racing/task3.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < solutions/postgresql/racing/task4.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < solutions/postgresql/racing/task5.sql

hotel-postgres:
	@echo "=== Бронирование отелей - PostgreSQL ==="
	docker compose exec -T postgres psql -U postgres -d tasks_db < solutions/postgresql/hotel/task1.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < solutions/postgresql/hotel/task2.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < solutions/postgresql/hotel/task3.sql

organization-postgres:
	@echo "=== Структура организации - PostgreSQL ==="
	docker compose exec -T postgres psql -U postgres -d tasks_db < solutions/postgresql/organization/task1.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < solutions/postgresql/organization/task2.sql
	docker compose exec -T postgres psql -U postgres -d tasks_db < solutions/postgresql/organization/task3.sql
