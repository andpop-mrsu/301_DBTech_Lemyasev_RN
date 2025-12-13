-- Создание таблиц
CREATE TABLE CarCategory (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Employee (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    hire_date DATE NOT NULL,
    dismissal_date DATE NULL,
    salary_percentage DECIMAL(5,2) NOT NULL DEFAULT 25.00,
    is_active BOOLEAN NOT NULL DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (salary_percentage BETWEEN 0 AND 100),
    CHECK (dismissal_date IS NULL OR dismissal_date > hire_date)
);


CREATE TABLE Service (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    duration_minutes INTEGER NOT NULL DEFAULT 60,
    base_price DECIMAL(10,2) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (duration_minutes > 0),
    CHECK (base_price >= 0)
);


CREATE TABLE ServicePrice (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    service_id INTEGER NOT NULL,
    car_category_id INTEGER NOT NULL,
    actual_price DECIMAL(10,2) NOT NULL,
    effective_date DATE NOT NULL DEFAULT CURRENT_DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (service_id) REFERENCES Service(id) ON DELETE CASCADE,
    FOREIGN KEY (car_category_id) REFERENCES CarCategory(id) ON DELETE CASCADE,
    CHECK (actual_price >= 0),
    UNIQUE(service_id, car_category_id, effective_date)
);

CREATE TABLE EmployeeSpecialization (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    employee_id INTEGER NOT NULL,
    service_id INTEGER NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES Employee(id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES Service(id) ON DELETE CASCADE,
    UNIQUE(employee_id, service_id)
);


CREATE TABLE Appointment (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    employee_id INTEGER NOT NULL,
    service_id INTEGER NOT NULL,
    car_category_id INTEGER NOT NULL,
    client_name VARCHAR(100) NOT NULL,
    client_phone VARCHAR(20),
    car_model VARCHAR(100) NOT NULL,
    car_license_plate VARCHAR(20),
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'scheduled',
    scheduled_duration INTEGER NOT NULL,
    scheduled_price DECIMAL(10,2) NOT NULL,
    notes TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES Employee(id),
    FOREIGN KEY (service_id) REFERENCES Service(id),
    FOREIGN KEY (car_category_id) REFERENCES CarCategory(id),
    CHECK (status IN ('scheduled', 'completed', 'cancelled', 'no_show')),
    CHECK (scheduled_duration > 0),
    CHECK (scheduled_price >= 0)
);


CREATE TABLE WorkRecord (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    appointment_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    service_id INTEGER NOT NULL,
    car_category_id INTEGER NOT NULL,
    actual_duration INTEGER NOT NULL,
    actual_price DECIMAL(10,2) NOT NULL,
    work_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    notes TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(id),
    FOREIGN KEY (employee_id) REFERENCES Employee(id),
    FOREIGN KEY (service_id) REFERENCES Service(id),
    FOREIGN KEY (car_category_id) REFERENCES CarCategory(id),
    CHECK (actual_duration > 0),
    CHECK (actual_price >= 0),
    CHECK (end_time > start_time)
);

-- Вставка данных в CarCategory
INSERT INTO CarCategory (name, description) VALUES
('Легковые авто', 'Легковые автомобили всех типов и классов'),
('Внедорожники и кроссоверы', 'Паркетники, кроссоверы и внедорожники'),
('Коммерческий транспорт', 'Грузовой и коммерческий транспорт'),
('Мототехника', 'Мотоциклы, мопеды и скутеры');

-- Вставка данных в Employee
INSERT INTO Employee (first_name, last_name, phone, email, hire_date, salary_percentage) VALUES
('Иван', 'Кузнецов', '+7-900-123-45-67', 'ivan@autoservice.pro', '2023-01-15', 30.00),
('Анна', 'Федорова', '+7-900-123-45-68', 'anna@autoservice.pro', '2023-02-20', 28.00),
('Сергей', 'Николаев', '+7-900-123-45-69', 'sergey@autoservice.pro', '2023-03-10', 32.00),
('Мария', 'Васильева', '+7-900-123-45-70', 'maria@autoservice.pro', '2022-11-05', 26.00);

-- Вставка уволенного сотрудника
INSERT INTO Employee (first_name, last_name, phone, email, hire_date, dismissal_date, salary_percentage, is_active) VALUES
('Дмитрий', 'Попов', '+7-900-123-45-71', 'dmitry@autoservice.pro', '2022-08-01', '2023-06-30', 25.00, 0);

-- Вставка данных в Service
INSERT INTO Service (name, description, duration_minutes, base_price) VALUES
('Техобслуживание двигателя', 'Комплексное обслуживание силового агрегата', 50, 1700.00),
('Ремонт тормозной системы', 'Обслуживание и ремонт тормозных механизмов', 95, 3200.00),
('Регулировка ходовой части', 'Настройка подвески и рулевого управления', 65, 2700.00),
('Компьютерная диагностика', 'Полная диагностика электронных систем автомобиля', 35, 1300.00),
('Обслуживание систем зажигания', 'Проверка и замена элементов системы зажигания', 45, 1900.00);

-- Вставка данных в ServicePrice
INSERT INTO ServicePrice (service_id, car_category_id, actual_price) VALUES
(1, 1, 1700.00), (1, 2, 1950.00), (1, 3, 2400.00), (1, 4, 850.00),
(2, 1, 3200.00), (2, 2, 3700.00), (2, 3, 4800.00), (2, 4, 1300.00),
(3, 1, 2700.00), (3, 2, 2950.00), (3, 3, 3400.00), (3, 4, 1600.00),
(4, 1, 1300.00), (4, 2, 1500.00), (4, 3, 1750.00), (4, 4, 950.00),
(5, 1, 1900.00), (5, 2, 2150.00), (5, 3, 2600.00), (5, 4, 1100.00);

-- Вставка данных в EmployeeSpecialization
INSERT INTO EmployeeSpecialization (employee_id, service_id) VALUES
(1, 1), (1, 2), (1, 5),
(2, 1), (2, 4), (2, 5),
(3, 2), (3, 3),
(4, 1), (4, 4), (4, 5),
(5, 1), (5, 2);

-- Вставка данных в Appointment
INSERT INTO Appointment (employee_id, service_id, car_category_id, client_name, client_phone, car_model, car_license_plate, appointment_date, appointment_time, scheduled_duration, scheduled_price) VALUES
(1, 1, 1, 'Алексей Семенов', '+7-905-555-44-33', 'Toyota Camry', 'А123БВ777', '2024-01-15', '09:00', 50, 1700.00),
(2, 4, 2, 'Ольга Михайлова', '+7-905-555-44-34', 'Honda CR-V', 'Б456ГД777', '2024-01-15', '10:00', 35, 1500.00),
(3, 2, 1, 'Павел Алексеев', '+7-905-555-44-35', 'Lada Vesta', 'В789ЕЖ777', '2024-01-15', '11:00', 95, 3200.00),
(4, 5, 1, 'Екатерина Романова', '+7-905-555-44-36', 'Kia Rio', 'Г012ИК777', '2024-01-16', '09:30', 45, 1900.00);

-- Вставка данных в WorkRecord
INSERT INTO WorkRecord (appointment_id, employee_id, service_id, car_category_id, actual_duration, actual_price, work_date, start_time, end_time, notes) VALUES
(1, 1, 1, 1, 48, 1700.00, '2024-01-15', '09:00', '09:48', 'Замена масла и фильтров, проверка систем'),
(2, 2, 4, 2, 32, 1500.00, '2024-01-15', '10:00', '10:32', 'Диагностика показала исправность всех систем'),
(3, 3, 2, 1, 90, 3200.00, '2024-01-15', '11:00', '12:30', 'Замена тормозных колодок и дисков');

-- Создание индексов
CREATE INDEX idx_appointment_date ON Appointment(appointment_date, appointment_time);
CREATE INDEX idx_appointment_employee ON Appointment(employee_id, appointment_date);
CREATE INDEX idx_workrecord_date ON WorkRecord(work_date);
CREATE INDEX idx_workrecord_employee ON WorkRecord(employee_id, work_date);
CREATE INDEX idx_employee_active ON Employee(is_active);
CREATE INDEX idx_service_price ON ServicePrice(service_id, car_category_id);