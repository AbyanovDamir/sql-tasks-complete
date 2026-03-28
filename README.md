# SQL Tasks Project – решение 13 задач по SQL

## Описание проекта

Данный проект представляет собой комплексное решение для практики работы с SQL базами данных. Проект включает в себя четыре независимые базы данных:

- **Транспортные средства** — база данных для учета автомобилей, мотоциклов и велосипедов
- **Автомобильные гонки** — база данных для отслеживания результатов гоночных соревнований
- **Бронирование отелей** — система управления бронированиями в отелях
- **Структура организации** — иерархическая структура сотрудников, проектов и задач



### Цели проекта

- Практическое применение навыков работы с SQL
- Решение реальных аналитических задач с использованием сложных запросов
- Освоение продвинутых возможностей SQL, включая:
  - JOIN-операции
  - Агрегатные функции
  - Оконные функции
  - Рекурсивные запросы
  - Группировку и сортировку данных
  - Подзапросы и CTE (Common Table Expressions)

### Решаемые задачи

В рамках проекта решаются 13 аналитических задач:

| № | База данных | Количество задач | Баллы |
|---|-------------|------------------|-------|
| 1 | Транспортные средства | 2 | 6 |
| 2 | Автомобильные гонки | 5 | 20 |
| 3 | Бронирование отелей | 3 | 12 |
| 4 | Структура организации | 3 | 12 |
| **Итого** | | **13** | **50** |

---

## Технологический стек

| Компонент | Технология |
|-----------|------------|
| Контейнеризация | Docker, Docker Compose |
| СУБД 1 | MySQL 8.0 |
| СУБД 2 | PostgreSQL 15 |
| Автоматизация | Makefile |
| Скрипты инициализации | Bash |

---
## Структура проекта

sql-tasks-complete/
├── docker-compose.yml
├── Makefile
├── init.sh
├── databases/
│ ├── vehicles/ -- таблицы Vehicle, Car, Motorcycle, Bicycle
│ ├── racing/ -- таблицы Classes, Cars, Races, Results
│ ├── hotel/ -- таблицы Hotel, Room, Customer, Booking
│ └── organization/ -- таблицы Departments, Roles, Employees, Projects, Tasks
├── solutions/
│ ├── mysql/ -- решения для MySQL (13 файлов)
│ │ ├── vehicles/task1.sql, task2.sql
│ │ ├── racing/task1..5.sql
│ │ ├── hotel/task1..3.sql
│ │ └── organization/task1..3.sql
│ └── postgresql/ -- решения для PostgreSQL (13 файлов)
│ ├── vehicles/
│ ├── racing/
│ ├── hotel/
│ └── organization/
└── scripts/ -- вспомогательные скрипты

---
## Структура базы данных

### 1. Транспортные средства (vehicles)

**Назначение:** хранение информации о различных типах транспортных средств.

#### Таблицы:

**Vehicle** — основная информация о транспортных средствах
| Поле | Тип | Описание |
|------|-----|----------|
| maker | VARCHAR(100) | Производитель |
| model | VARCHAR(100) | Модель (PK) |
| type | ENUM/CHECK | Тип: Car, Motorcycle, Bicycle |

**Car** — характеристики автомобилей
| Поле | Тип | Описание |
|------|-----|----------|
| vin | VARCHAR(17) | VIN-номер (PK) |
| model | VARCHAR(100) | Модель (FK → Vehicle) |
| engine_capacity | DECIMAL(4,2) | Объем двигателя (литры) |
| horsepower | INT | Мощность (л.с.) |
| price | DECIMAL(10,2) | Цена (доллары) |
| transmission | ENUM/CHECK | Тип трансмиссии: Automatic, Manual |

**Motorcycle** — характеристики мотоциклов
| Поле | Тип | Описание |
|------|-----|----------|
| vin | VARCHAR(17) | VIN-номер (PK) |
| model | VARCHAR(100) | Модель (FK → Vehicle) |
| engine_capacity | DECIMAL(4,2) | Объем двигателя (литры) |
| horsepower | INT | Мощность (л.с.) |
| price | DECIMAL(10,2) | Цена (доллары) |
| type | ENUM/CHECK | Тип: Sport, Cruiser, Touring |

**Bicycle** — характеристики велосипедов
| Поле | Тип | Описание |
|------|-----|----------|
| serial_number | VARCHAR(20) | Серийный номер (PK) |
| model | VARCHAR(100) | Модель (FK → Vehicle) |
| gear_count | INT | Количество передач |
| price | DECIMAL(10,2) | Цена (доллары) |
| type | ENUM/CHECK | Тип: Mountain, Road, Hybrid |

**Связи:** `Vehicle (1) ──< Car (N)`, `Vehicle (1) ──< Motorcycle (N)`, `Vehicle (1) ──< Bicycle (N)`

---

### 2. Автомобильные гонки (racing)

**Назначение:** учет участия автомобилей в гонках и анализ их результатов.

#### Таблицы:

**Classes** — классы автомобилей
| Поле | Тип | Описание |
|------|-----|----------|
| class | VARCHAR(100) | Название класса (PK) |
| type | ENUM/CHECK | Тип: Racing, Street |
| country | VARCHAR(100) | Страна производства |
| numDoors | INT | Количество дверей |
| engineSize | DECIMAL(3,1) | Размер двигателя (литры) |
| weight | INT | Вес (кг) |

**Cars** — автомобили-участники
| Поле | Тип | Описание |
|------|-----|----------|
| name | VARCHAR(100) | Название (PK) |
| class | VARCHAR(100) | Класс (FK → Classes) |
| year | INT | Год выпуска |

**Races** — гонки
| Поле | Тип | Описание |
|------|-----|----------|
| name | VARCHAR(100) | Название (PK) |
| date | DATE | Дата проведения |

**Results** — результаты гонок
| Поле | Тип | Описание |
|------|-----|----------|
| car | VARCHAR(100) | Автомобиль (FK → Cars) |
| race | VARCHAR(100) | Гонка (FK → Races) |
| position | INT | Позиция |

**Связи:** `Classes (1) ──< Cars (N)`, `Cars (1) ──< Results (N)`, `Races (1) ──< Results (N)`

---

### 3. Бронирование отелей (hotel)

**Назначение:** управление бронированиями номеров в отелях.

#### Таблицы:

**Hotel** — отели
| Поле | Тип | Описание |
|------|-----|----------|
| ID_hotel | INT/SERIAL | Идентификатор (PK) |
| name | VARCHAR(255) | Название |
| location | VARCHAR(255) | Расположение |

**Room** — номера
| Поле | Тип | Описание |
|------|-----|----------|
| ID_room | INT/SERIAL | Идентификатор (PK) |
| ID_hotel | INT | Отель (FK → Hotel) |
| room_type | ENUM/CHECK | Тип: Single, Double, Suite |
| price | DECIMAL(10,2) | Цена за ночь |
| capacity | INT | Вместимость (человек) |

**Customer** — клиенты
| Поле | Тип | Описание |
|------|-----|----------|
| ID_customer | INT/SERIAL | Идентификатор (PK) |
| name | VARCHAR(255) | Имя |
| email | VARCHAR(255) | Email (UNIQUE) |
| phone | VARCHAR(20) | Телефон |

**Booking** — бронирования
| Поле | Тип | Описание |
|------|-----|----------|
| ID_booking | INT/SERIAL | Идентификатор (PK) |
| ID_room | INT | Номер (FK → Room) |
| ID_customer | INT | Клиент (FK → Customer) |
| check_in_date | DATE | Дата заезда |
| check_out_date | DATE | Дата выезда |

**Связи:** `Hotel (1) ──< Room (N)`, `Room (1) ──< Booking (N)`, `Customer (1) ──< Booking (N)`

---

### 4. Структура организации (organization)

**Назначение:** управление иерархической структурой организации, проектами и задачами.

#### Таблицы:

**Departments** — отделы
| Поле | Тип | Описание |
|------|-----|----------|
| DepartmentID | INT/SERIAL | Идентификатор (PK) |
| DepartmentName | VARCHAR(100) | Название отдела |

**Roles** — роли сотрудников
| Поле | Тип | Описание |
|------|-----|----------|
| RoleID | INT/SERIAL | Идентификатор (PK) |
| RoleName | VARCHAR(100) | Название роли |

**Employees** — сотрудники
| Поле | Тип | Описание |
|------|-----|----------|
| EmployeeID | INT/SERIAL | Идентификатор (PK) |
| Name | VARCHAR(100) | Имя |
| Position | VARCHAR(100) | Должность |
| ManagerID | INT | Руководитель (FK → Employees) |
| DepartmentID | INT | Отдел (FK → Departments) |
| RoleID | INT | Роль (FK → Roles) |

**Projects** — проекты
| Поле | Тип | Описание |
|------|-----|----------|
| ProjectID | INT/SERIAL | Идентификатор (PK) |
| ProjectName | VARCHAR(100) | Название |
| StartDate | DATE | Дата начала |
| EndDate | DATE | Дата окончания |
| DepartmentID | INT | Отдел-исполнитель (FK → Departments) |

**Tasks** — задачи
| Поле | Тип | Описание |
|------|-----|----------|
| TaskID | INT/SERIAL | Идентификатор (PK) |
| TaskName | VARCHAR(100) | Название |
| AssignedTo | INT | Исполнитель (FK → Employees) |
| ProjectID | INT | Проект (FK → Projects) |

**Связи:** 
- `Departments (1) ──< Employees (N)`
- `Roles (1) ──< Employees (N)`
- `Employees (1) ──< Employees (N)` (самореференция через ManagerID)
- `Departments (1) ──< Projects (N)`
- `Employees (1) ──< Tasks (N)`
- `Projects (1) ──< Tasks (N)`

---

## Условия задач и решения

### 1. Транспортные средства (2 задачи)

#### Задача 1
Найдите производителей (maker) и модели всех мотоциклов, которые имеют мощность более 150 лошадиных сил, стоят менее 20 тысяч долларов и являются спортивными (тип Sport). Также отсортируйте результаты по мощности в порядке убывания.  
**Ожидаемый результат:** Yamaha | YZF-R1

**Решение (MySQL/PostgreSQL):**
```sql
SELECT 
    v.maker,
    m.model
FROM Motorcycle m
JOIN Vehicle v ON m.model = v.model
WHERE m.horsepower > 150 
    AND m.price < 20000 
    AND m.type = 'Sport'
ORDER BY m.horsepower DESC;
```



#### Задача 2

Найти информацию о производителях и моделях различных типов транспортных средств (автомобили, мотоциклы и велосипеды), которые соответствуют заданным критериям.

    Автомобили:

    Извлечь данные о всех автомобилях, которые имеют:
        Мощность двигателя более 150 лошадиных сил.
        Объем двигателя менее 3 литров.
        Цену менее 35 тысяч долларов.

    В выводе должны быть указаны производитель (maker), номер модели (model), мощность (horsepower), объем двигателя (engine_capacity) и тип транспортного средства, который будет обозначен как Car.
    Мотоциклы:

    Извлечь данные о всех мотоциклах, которые имеют:
        Мощность двигателя более 150 лошадиных сил.
        Объем двигателя менее 1,5 литров.
        Цену менее 20 тысяч долларов.

    В выводе должны быть указаны производитель (maker), номер модели (model), мощность (horsepower), объем двигателя (engine_capacity) и тип транспортного средства, который будет обозначен как Motorcycle.
    Велосипеды:

    Извлечь данные обо всех велосипедах, которые имеют:
        Количество передач больше 18.
        Цену менее 4 тысяч долларов.

    В выводе должны быть указаны производитель (maker), номер модели (model), а также NULL для мощности и объема двигателя, так как эти характеристики не применимы для велосипедов. Тип транспортного средства будет обозначен как Bicycle.
    Сортировка:

    Результаты должны быть объединены в один набор данных и отсортированы по мощности в порядке убывания. Для велосипедов, у которых нет значения мощности, они будут располагаться внизу списка.

**Ожидаемый результат: Toyota Camry, Yamaha YZF-R1, Honda Civic, Trek Domane, Giant Defy**

**Решение:**
```sql

-- Задача 2: Объединенный запрос для всех типов ТС (PostgreSQL)
SELECT * FROM (
    -- Автомобили
    SELECT 
        v.maker,
        c.model,
        c.horsepower,
        c.engine_capacity,
        'Car' AS vehicle_type
    FROM Car c
    JOIN Vehicle v ON c.model = v.model
    WHERE c.horsepower > 150 
        AND c.engine_capacity < 3.0 
        AND c.price < 35000
    
    UNION ALL
    
    -- Мотоциклы
    SELECT 
        v.maker,
        m.model,
        m.horsepower,
        m.engine_capacity,
        'Motorcycle' AS vehicle_type
    FROM Motorcycle m
    JOIN Vehicle v ON m.model = v.model
    WHERE m.horsepower > 150 
        AND m.engine_capacity < 1.5 
        AND m.price < 20000
    
    UNION ALL
    
    -- Велосипеды
    SELECT 
        v.maker,
        b.model,
        NULL AS horsepower,
        NULL AS engine_capacity,
        'Bicycle' AS vehicle_type
    FROM Bicycle b
    JOIN Vehicle v ON b.model = v.model
    WHERE b.gear_count > 18 
        AND b.price < 4000
) AS combined
ORDER BY horsepower DESC NULLS LAST;

```
### 2. Автомобильные гонки (5 задач)
#### Задача 1

Определить, какие автомобили из каждого класса имеют наименьшую среднюю позицию в гонках, и вывести информацию о каждом таком автомобиле для данного класса, включая его класс, среднюю позицию и количество гонок, в которых он участвовал. Также отсортировать результаты по средней позиции.
**Ожидаемый вывод: 8 автомобилей (Ferrari 488, Ford Mustang, Toyota RAV4, Mercedes S-Class, BMW 3 Series, Chevrolet Camaro, Renault Clio, Ford F-150)**

**Решение (CTE):**
```sql
-- Задача 1: Автомобили с наименьшей средней позицией в каждом классе (PostgreSQL)
WITH AvgPositions AS (
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
MinAvgByClass AS (
    SELECT 
        car_class,
        MIN(average_position) AS min_avg_position
    FROM AvgPositions
    GROUP BY car_class
)
SELECT 
    ap.car_name,
    ap.car_class,
    ROUND(ap.average_position, 4) AS average_position,
    ap.race_count
FROM AvgPositions ap
JOIN MinAvgByClass mac ON ap.car_class = mac.car_class 
    AND ap.average_position = mac.min_avg_position
ORDER BY ap.average_position;


```
#### Задача 2

Определить автомобиль, который имеет наименьшую среднюю позицию в гонках среди всех автомобилей, и вывести информацию об этом автомобиле, включая его класс, среднюю позицию, количество гонок, в которых он участвовал, и страну производства класса автомобиля. Если несколько автомобилей имеют одинаковую наименьшую среднюю позицию, выбрать один из них по алфавиту (по имени автомобиля).
**Ожидаемый вывод: Ferrari 488 | Convertible | 1.0000 | 1 | Italy**

**Решение (CTE):**
```sql
-- Задача 2: Автомобиль с наименьшей средней позицией (PostgreSQL)
WITH AvgPositions AS (
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count,
        cls.country AS car_country
    FROM Cars c
    JOIN Results r ON c.name = r.car
    JOIN Classes cls ON c.class = cls.class
    GROUP BY c.name, c.class, cls.country
)
SELECT 
    car_name,
    car_class,
    ROUND(average_position, 4) AS average_position,
    race_count,
    car_country
FROM AvgPositions
WHERE average_position = (SELECT MIN(average_position) FROM AvgPositions)
ORDER BY car_name
LIMIT 1;


```
#### Задача 3

Определить классы автомобилей, которые имеют наименьшую среднюю позицию в гонках, и вывести информацию о каждом автомобиле из этих классов, включая его имя, среднюю позицию, количество гонок, в которых он участвовал, страну производства класса автомобиля, а также общее количество гонок, в которых участвовали автомобили этих классов. Если несколько классов имеют одинаковую среднюю позицию, выбрать все из них.
**Ожидаемый вывод: Ferrari 488 и Ford Mustang**

**Решение (CTE):**
```sql
-- Задача 3: Классы с наименьшей средней позицией (PostgreSQL)
WITH ClassAvg AS (
    SELECT 
        c.class AS car_class,
        AVG(r.position) AS class_avg_position
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.class
),
MinClassAvg AS (
    SELECT MIN(class_avg_position) AS min_avg
    FROM ClassAvg
),
SelectedClasses AS (
    SELECT car_class
    FROM ClassAvg
    WHERE class_avg_position = (SELECT min_avg FROM MinClassAvg)
)
SELECT 
    c.name AS car_name,
    c.class AS car_class,
    ROUND(AVG(r.position), 4) AS average_position,
    COUNT(r.race) AS race_count,
    cls.country AS car_country,
    (SELECT COUNT(DISTINCT race) FROM Results WHERE car IN (SELECT name FROM Cars WHERE class = c.class)) AS total_races
FROM Cars c
JOIN Results r ON c.name = r.car
JOIN Classes cls ON c.class = cls.class
WHERE c.class IN (SELECT car_class FROM SelectedClasses)
GROUP BY c.name, c.class, cls.country
ORDER BY average_position;


```
#### Задача 4

Определить, какие автомобили имеют среднюю позицию лучше (меньше) средней позиции всех автомобилей в своем классе (то есть автомобилей в классе должно быть минимум два, чтобы выбрать один из них). Вывести информацию об этих автомобилях, включая их имя, класс, среднюю позицию, количество гонок, в которых они участвовали, и страну производства класса автомобиля. Также отсортировать результаты по классу и затем по средней позиции в порядке возрастания.
**Ожидаемый вывод: BMW 3 Series (Sedan), Toyota RAV4 (SUV)**
```sql
-- Задача 4: Автомобили со средней позицией лучше средней по классу (PostgreSQL)
WITH CarAvg AS (
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS car_avg_position,
        COUNT(r.race) AS race_count,
        cls.country AS car_country
    FROM Cars c
    JOIN Results r ON c.name = r.car
    JOIN Classes cls ON c.class = cls.class
    GROUP BY c.name, c.class, cls.country
),
ClassAvg AS (
    SELECT 
        car_class,
        AVG(car_avg_position) AS class_avg_position,
        COUNT(*) AS cars_in_class
    FROM CarAvg
    GROUP BY car_class
    HAVING COUNT(*) >= 2
)
SELECT 
    ca.car_name,
    ca.car_class,
    ROUND(ca.car_avg_position, 4) AS average_position,
    ca.race_count,
    ca.car_country
FROM CarAvg ca
JOIN ClassAvg cla ON ca.car_class = cla.car_class
WHERE ca.car_avg_position < cla.class_avg_position
ORDER BY ca.car_class, ca.car_avg_position;


```
#### Задача 5

Определить, какие классы автомобилей имеют наибольшее количество автомобилей с низкой средней позицией (больше 3.0) и вывести информацию о каждом автомобиле из этих классов, включая его имя, класс, среднюю позицию, количество гонок, в которых он участвовал, страну производства класса автомобиля, а также общее количество гонок для каждого класса. Отсортировать результаты по количеству автомобилей с низкой средней позицией.
**Ожидаемый вывод: Audi A4 (Sedan), Chevrolet Camaro (Coupe), Renault Clio (Hatchback), Ford F-150 (Pickup)**

**Решение (CTE):**
```sql
-- Задача 5: Классы с наибольшим количеством автомобилей с позицией > 3.0 (PostgreSQL)
WITH CarAvg AS (
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count,
        cls.country AS car_country,
        (SELECT COUNT(DISTINCT race) FROM Results WHERE car IN (SELECT name FROM Cars WHERE class = c.class)) AS total_races
    FROM Cars c
    JOIN Results r ON c.name = r.car
    JOIN Classes cls ON c.class = cls.class
    GROUP BY c.name, c.class, cls.country
),
LowPositionCars AS (
    SELECT 
        car_class,
        COUNT(*) AS low_position_count
    FROM CarAvg
    WHERE average_position > 3.0
    GROUP BY car_class
),
MaxLowCount AS (
    SELECT MAX(low_position_count) AS max_count
    FROM LowPositionCars
)
SELECT 
    ca.car_name,
    ca.car_class,
    ROUND(ca.average_position, 4) AS average_position,
    ca.race_count,
    ca.car_country,
    ca.total_races,
    lpc.low_position_count
FROM CarAvg ca
JOIN LowPositionCars lpc ON ca.car_class = lpc.car_class
WHERE lpc.low_position_count = (SELECT max_count FROM MaxLowCount)
ORDER BY lpc.low_position_count DESC;

```
### 3. Бронирование отелей (3 задачи)
#### Задача 1

Определить, какие клиенты сделали более двух бронирований в разных отелях, и вывести информацию о каждом таком клиенте, включая его имя, электронную почту, телефон, общее количество бронирований, а также список отелей, в которых они бронировали номера (объединенные в одно поле через запятую). Также подсчитать среднюю длительность их пребывания (в днях) по всем бронированиям. Отсортировать результаты по количеству бронирований в порядке убывания.
**Ожидаемый вывод: Bob Brown, Ethan Hunt**

**Решение (MySQL):**
```sql
-- Задача 1: Клиенты с более чем двумя бронированиями в разных отелях (PostgreSQL)
WITH CustomerBookings AS (
    SELECT 
        c.ID_customer,
        c.name,
        c.email,
        c.phone,
        COUNT(DISTINCT b.ID_booking) AS total_bookings,
        COUNT(DISTINCT h.ID_hotel) AS unique_hotels,
        STRING_AGG(DISTINCT h.name, ', ' ORDER BY h.name) AS hotels_list,
        AVG(b.check_out_date - b.check_in_date) AS avg_stay_days
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r ON b.ID_room = r.ID_room
    JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    GROUP BY c.ID_customer, c.name, c.email, c.phone
    HAVING COUNT(DISTINCT b.ID_booking) > 2 AND COUNT(DISTINCT h.ID_hotel) > 1
)
SELECT 
    name,
    email,
    phone,
    total_bookings,
    hotels_list,
    ROUND(avg_stay_days, 4) AS avg_stay_days
FROM CustomerBookings
ORDER BY total_bookings DESC;


```
#### Задача 2

Необходимо провести анализ клиентов, которые сделали более двух бронирований в разных отелях и потратили более 500 долларов на свои бронирования. Для этого:

    Определить клиентов, которые сделали более двух бронирований и забронировали номера в более чем одном отеле. Вывести для каждого такого клиента следующие данные: ID_customer, имя, общее количество бронирований, общее количество уникальных отелей, в которых они бронировали номера, и общую сумму, потраченную на бронирования.
    Также определить клиентов, которые потратили более 500 долларов на бронирования, и вывести для них ID_customer, имя, общую сумму, потраченную на бронирования, и общее количество бронирований.
    В результате объединить данные из первых двух пунктов, чтобы получить список клиентов, которые соответствуют условиям обоих запросов. Отобразить поля: ID_customer, имя, общее количество бронирований, общую сумму, потраченную на бронирования, и общее количество уникальных отелей.
    Результаты отсортировать по общей сумме, потраченной клиентами, в порядке возрастания.

**Ожидаемый вывод: Bob Brown (820.00, 2 отеля), Ethan Hunt (850.00, 2 отеля)**

**Решение (MySQL):**
```sql
-- Задача 2: Клиенты с более чем двумя бронированиями и тратами > 500$ (PostgreSQL)
WITH CustomerSpending AS (
    SELECT 
        c.ID_customer,
        c.name,
        COUNT(b.ID_booking) AS total_bookings,
        COUNT(DISTINCT h.ID_hotel) AS unique_hotels,
        SUM(r.price * (b.check_out_date - b.check_in_date)) AS total_spent
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r ON b.ID_room = r.ID_room
    JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    GROUP BY c.ID_customer, c.name
    HAVING COUNT(b.ID_booking) > 2 AND COUNT(DISTINCT h.ID_hotel) > 1
)
SELECT 
    ID_customer,
    name,
    total_bookings,
    ROUND(total_spent, 2) AS total_spent,
    unique_hotels
FROM CustomerSpending
WHERE total_spent > 500
ORDER BY total_spent;


```
#### Задача 3

Вам необходимо провести анализ данных о бронированиях в отелях и определить предпочтения клиентов по типу отелей. Для этого выполните следующие шаги:

    Категоризация отелей.

    Определите категорию каждого отеля на основе средней стоимости номера:
        «Дешевый»: средняя стоимость менее 175 долларов.
        «Средний»: средняя стоимость от 175 до 300 долларов.
        «Дорогой»: средняя стоимость более 300 долларов.
    Анализ предпочтений клиентов.

    Для каждого клиента определите предпочитаемый тип отеля на основании условия ниже:
        Если у клиента есть хотя бы один «дорогой» отель, присвойте ему категорию «дорогой».
        Если у клиента нет «дорогих» отелей, но есть хотя бы один «средний», присвойте ему категорию «средний».
        Если у клиента нет «дорогих» и «средних» отелей, но есть «дешевые», присвойте ему категорию предпочитаемых отелей «дешевый».
    Вывод информации.

    Выведите для каждого клиента следующую информацию:
        ID_customer: уникальный идентификатор клиента.
        name: имя клиента.
        preferred_hotel_type: предпочитаемый тип отеля.
        visited_hotels: список уникальных отелей, которые посетил клиент.
    Сортировка результатов.

    Отсортируйте клиентов так, чтобы сначала шли клиенты с «дешевыми» отелями, затем со «средними» и в конце — с «дорогими».

**Ожидаемый вывод: 10 клиентов с соответствующими категориями**

**Решение (MySQL):**
```sql
-- Задача 3: Категоризация отелей и предпочтения клиентов (PostgreSQL)
WITH HotelCategory AS (
    SELECT 
        h.ID_hotel,
        h.name,
        AVG(r.price) AS avg_price,
        CASE 
            WHEN AVG(r.price) < 175 THEN 'Дешевый'
            WHEN AVG(r.price) BETWEEN 175 AND 300 THEN 'Средний'
            ELSE 'Дорогой'
        END AS category
    FROM Hotel h
    JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY h.ID_hotel, h.name
),
CustomerHotels AS (
    SELECT 
        c.ID_customer,
        c.name,
        STRING_AGG(DISTINCT h.name, ', ' ORDER BY h.name) AS visited_hotels,
        MAX(CASE WHEN hc.category = 'Дорогой' THEN 1 ELSE 0 END) AS has_expensive,
        MAX(CASE WHEN hc.category = 'Средний' THEN 1 ELSE 0 END) AS has_medium,
        MAX(CASE WHEN hc.category = 'Дешевый' THEN 1 ELSE 0 END) AS has_cheap
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r ON b.ID_room = r.ID_room
    JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    JOIN HotelCategory hc ON h.ID_hotel = hc.ID_hotel
    GROUP BY c.ID_customer, c.name
)
SELECT 
    ID_customer,
    name,
    CASE 
        WHEN has_expensive = 1 THEN 'Дорогой'
        WHEN has_medium = 1 THEN 'Средний'
        ELSE 'Дешевый'
    END AS preferred_hotel_type,
    visited_hotels
FROM CustomerHotels
ORDER BY 
    CASE 
        WHEN has_expensive = 1 THEN 3
        WHEN has_medium = 1 THEN 2
        ELSE 1
    END;


```
### 4. Структура организации (3 задачи)
#### Задача 1

Найти всех сотрудников, подчиняющихся Ивану Иванову (с EmployeeID = 1), включая их подчиненных и подчиненных подчиненных, а также самого Ивана Иванова. Для каждого сотрудника вывести следующую информацию:

    EmployeeID: идентификатор сотрудника.
    Имя сотрудника.
    ManagerID: Идентификатор менеджера.
    Название отдела, к которому он принадлежит.
    Название роли, которую он занимает.
    Название проектов, к которым он относится (если есть, конкатенированные в одном столбце через запятую).
    Название задач, назначенных этому сотруднику (если есть, конкатенированные в одном столбце через запятую).
    Если у сотрудника нет назначенных проектов или задач, отобразить NULL.

Требования:

    Рекурсивно извлечь всех подчиненных сотрудников Ивана Иванова и их подчиненных.
    Для каждого сотрудника отобразить информацию из всех таблиц.
    Результаты должны быть отсортированы по имени сотрудника.
    Решение задачи должно представлять из себя один sql-запрос и задействовать ключевое слово RECURSIVE.

**Ожидаемый вывод: 30 сотрудников**

**Решение (MySQL):**

```sql
-- Задача 1: Все подчиненные Ивана Иванова (EmployeeID = 1) с рекурсией (PostgreSQL)
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT 
        EmployeeID,
        Name,
        ManagerID,
        DepartmentID,
        RoleID
    FROM Employees
    WHERE EmployeeID = 1
    
    UNION ALL
    
    SELECT 
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT 
    eh.EmployeeID,
    eh.Name AS EmployeeName,
    eh.ManagerID,
    d.DepartmentName,
    r.RoleName,
    (SELECT STRING_AGG(DISTINCT p.ProjectName, ', ' ORDER BY p.ProjectName)
     FROM Projects p
     WHERE p.DepartmentID = d.DepartmentID) AS ProjectNames,
    (SELECT STRING_AGG(DISTINCT t.TaskName, ', ' ORDER BY t.TaskName)
     FROM Tasks t
     WHERE t.AssignedTo = eh.EmployeeID) AS TaskNames
FROM EmployeeHierarchy eh
LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
LEFT JOIN Roles r ON eh.RoleID = r.RoleID
ORDER BY eh.Name;


```



#### Задача 2

Найти всех сотрудников, подчиняющихся Ивану Иванову с EmployeeID = 1, включая их подчиненных и подчиненных подчиненных, а также самого Ивана Иванова. Для каждого сотрудника вывести следующую информацию:

    EmployeeID: идентификатор сотрудника.
    Имя сотрудника.
    Идентификатор менеджера.
    Название отдела, к которому он принадлежит.
    Название роли, которую он занимает.
    Название проектов, к которым он относится (если есть, конкатенированные в одном столбце).
    Название задач, назначенных этому сотруднику (если есть, конкатенированные в одном столбце).
    Общее количество задач, назначенных этому сотруднику.
    Общее количество подчиненных у каждого сотрудника (не включая подчиненных их подчиненных).
    Если у сотрудника нет назначенных проектов или задач, отобразить NULL.

**Ожидаемый вывод: данные с TotalTasks и TotalSubordinates**

**Решение (MySQL):**

```sql
-- Задача 2: Подчиненные Ивана Иванова с подсчетом подчиненных и задач (PostgreSQL)
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT 
        EmployeeID,
        Name,
        ManagerID,
        DepartmentID,
        RoleID
    FROM Employees
    WHERE EmployeeID = 1
    
    UNION ALL
    
    SELECT 
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
),
EmployeeTasks AS (
    SELECT 
        AssignedTo,
        COUNT(*) AS task_count,
        STRING_AGG(TaskName, ', ' ORDER BY TaskName) AS task_list
    FROM Tasks
    GROUP BY AssignedTo
),
EmployeeProjects AS (
    SELECT 
        e.EmployeeID,
        STRING_AGG(DISTINCT p.ProjectName, ', ' ORDER BY p.ProjectName) AS project_list
    FROM Employees e
    LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
    GROUP BY e.EmployeeID
),
SubordinateCount AS (
    SELECT 
        ManagerID,
        COUNT(*) AS total_subordinates
    FROM Employees
    GROUP BY ManagerID
)
SELECT 
    eh.EmployeeID,
    eh.Name AS EmployeeName,
    eh.ManagerID,
    d.DepartmentName,
    r.RoleName,
    ep.project_list AS ProjectNames,
    et.task_list AS TaskNames,
    COALESCE(et.task_count, 0) AS TotalTasks,
    COALESCE(sc.total_subordinates, 0) AS TotalSubordinates
FROM EmployeeHierarchy eh
LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
LEFT JOIN Roles r ON eh.RoleID = r.RoleID
LEFT JOIN EmployeeTasks et ON eh.EmployeeID = et.AssignedTo
LEFT JOIN EmployeeProjects ep ON eh.EmployeeID = ep.EmployeeID
LEFT JOIN SubordinateCount sc ON eh.EmployeeID = sc.ManagerID
ORDER BY eh.Name;


```

#### Задача 3

Найти всех сотрудников, которые занимают роль менеджера и имеют подчиненных (то есть число подчиненных больше 0). Для каждого такого сотрудника вывести следующую информацию:

    EmployeeID: идентификатор сотрудника.
    Имя сотрудника.
    Идентификатор менеджера.
    Название отдела, к которому он принадлежит.
    Название роли, которую он занимает.
    Название проектов, к которым он относится (если есть, конкатенированные в одном столбце).
    Название задач, назначенных этому сотруднику (если есть, конкатенированные в одном столбце).
    Общее количество подчиненных у каждого сотрудника (включая их подчиненных).
    Если у сотрудника нет назначенных проектов или задач, отобразить NULL.

**Ожидаемый вывод: Алексей Алексеев (4 подчиненных)**

**Решение (MySQL):**

```sql
-- Задача 3: Менеджеры с подчиненными (PostgreSQL)
WITH RECURSIVE SubordinateTree AS (
    SELECT 
        ManagerID,
        EmployeeID,
        1 AS level
    FROM Employees
    WHERE ManagerID IS NOT NULL
    
    UNION ALL
    
    SELECT 
        st.ManagerID,
        e.EmployeeID,
        st.level + 1
    FROM SubordinateTree st
    JOIN Employees e ON st.EmployeeID = e.ManagerID
),
ManagerSubordinates AS (
    SELECT 
        ManagerID,
        COUNT(DISTINCT EmployeeID) AS total_subordinates
    FROM SubordinateTree
    GROUP BY ManagerID
),
EmployeeTasks AS (
    SELECT 
        AssignedTo,
        STRING_AGG(TaskName, ', ' ORDER BY TaskName) AS task_list
    FROM Tasks
    GROUP BY AssignedTo
),
EmployeeProjects AS (
    SELECT 
        e.EmployeeID,
        STRING_AGG(DISTINCT p.ProjectName, ', ' ORDER BY p.ProjectName) AS project_list
    FROM Employees e
    LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
    GROUP BY e.EmployeeID
)
SELECT 
    e.EmployeeID,
    e.Name AS EmployeeName,
    e.ManagerID,
    d.DepartmentName,
    r.RoleName,
    ep.project_list AS ProjectNames,
    et.task_list AS TaskNames,
    ms.total_subordinates AS TotalSubordinates
FROM Employees e
JOIN Roles r ON e.RoleID = r.RoleID
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN EmployeeTasks et ON e.EmployeeID = et.AssignedTo
LEFT JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
JOIN ManagerSubordinates ms ON e.EmployeeID = ms.ManagerID
WHERE r.RoleName = 'Менеджер'
ORDER BY e.Name;

```

---
### Запуск проекта и тестирование
#### Требования
- Docker (20.10+), Docker Compose (2.0+)

#### Установка и запуск
```bash

# Клонирование репозитория
git clone https://github.com/AbyanovDamir/sql-tasks-complete.git
cd sql-tasks-complete

# Запуск контейнеров
sudo make up

# Инициализация баз данных (создание таблиц и заполнение данными)
sudo ./init.sh
# или по отдельности:
sudo make init-mysql
sudo make init-postgres

#### Выполнение задач


# Все задачи для MySQL
sudo make all-mysql

# Все задачи для PostgreSQL
sudo make all-postgres

# Задачи по темам
sudo make vehicles-mysql
sudo make racing-mysql
sudo make hotel-mysql
sudo make organization-mysql

# Отдельные задачи
sudo make task1-mysql              # транспорт 1
sudo make racing-task1-postgres    # гонки 1
sudo make hotel-task1-mysql        # отели 1
sudo make org-task1-postgres       # организация 1
```


#### Ожидаемые результаты выполнения

При запуске make all-mysql или make all-postgres выводятся таблицы, идентичные приведенным в условиях задач (см. раздел «Ожидаемый вывод»). Все 13 задач отрабатывают без ошибок в обеих СУБД.
#### Очистка
```bash

sudo make down                     # остановка контейнеров
sudo docker compose down -v        # полное удаление контейнеров и данных
```

#### Заключение

Проект  реализует 13 задач, покрывает 4 предметные области, поддерживает MySQL и PostgreSQL, автоматизирован через Docker и Makefile. Все запросы соответствуют ожидаемым выводам. 