-- =========================================================
-- ROLES
-- =========================================================

INSERT INTO roles (nombre, descripcion) VALUES
('Administrador', 'Tiene acceso completo al sistema'),
('Vendedor', 'Registra clientes y pedidos'),
('Cocina', 'Prepara los cheesecakes'),
('Repartidor', 'Realiza las entregas');


-- =========================================================
-- SABORES
-- =========================================================

INSERT INTO sabores (nombre, descripcion, precio) VALUES
('Oreo', 'Cheesecake con sabor y galletas Oreo', 15000),
('Frutos Rojos', 'Cheesecake con mezcla de frutos rojos', 16000),
('Maracuya', 'Cheesecake con cobertura de maracuya', 16000),
('Limon', 'Cheesecake con sabor fresco a limon', 15000),
('Arandanos', 'Cheesecake con arandanos frescos', 17000);


-- =========================================================
-- TAMAÑOS
-- =========================================================

INSERT INTO tamanos (nombre, descripcion, precio) VALUES
('Personal', 'Cheesecake individual', 8000),
('Mediano', 'Para aproximadamente 4 a 6 personas', 15000),
('Grande', 'Para aproximadamente 8 a 12 personas', 25000);


-- =========================================================
-- TOPPINGS
-- =========================================================

INSERT INTO toppings (nombre, descripcion, precio) VALUES
('Oreo', 'Galletas Oreo trituradas', 2000),
('Fresas', 'Fresas frescas', 3000),
('Frutos Rojos', 'Mezcla de frutos rojos', 3000),
('Arandanos', 'Arandanos frescos', 3000),
('Chocolate', 'Chocolate derretido', 2500),
('Galletas', 'Galletas trituradas', 2000);


-- =========================================================
-- EXTRAS
-- =========================================================

INSERT INTO extras (nombre, descripcion, precio) VALUES
('Salsa de Chocolate', 'Salsa adicional de chocolate', 2000),
('Salsa de Maracuya', 'Salsa adicional de maracuya', 2000),
('Fruta Extra', 'Porcion adicional de fruta', 3000),
('Oreo Extra', 'Porcion adicional de Oreo', 2000);


-- =========================================================
-- CLIENTE DE PRUEBA
-- =========================================================

INSERT INTO clientes
(nombre, telefono, correo, direccion)
VALUES
('Daniel Fonseca', '3001234567', 'daniel@gmail.com', 'Bogota');


-- =========================================================
-- CLIENTE INTERNO / ADMINISTRADOR DE PRUEBA
-- =========================================================

INSERT INTO clientes_internos
(nombre, apellido, documento, telefono, correo,
 id_rol, usuario, contrasena, fecha_ingreso)
VALUES
(
    'Administrador',
    'Principal',
    '1000000001',
    '3000000000',
    'admin@cheesecake.com',
    1,
    'admin',
    '123456',
    '2026-09-02'
);


-- =========================================================
-- TIPOS DE ERROR
-- =========================================================

INSERT INTO tipos_error (nombre, descripcion) VALUES
('Producto equivocado', 'Se entrego un cheesecake diferente al solicitado'),
('Producto danado', 'El cheesecake llego danado'),
('Pedido incompleto', 'Falta uno o varios productos'),
('Retraso', 'El pedido fue entregado fuera del tiempo establecido'),
('Error de personalizacion', 'El cheesecake no coincide con la personalizacion solicitada'),
('Error de pago', 'Problema relacionado con el pago');


-- =========================================================
-- INGREDIENTES
-- =========================================================

INSERT INTO ingredientes
(nombre, unidad_medida, cantidad_stock, stock_minimo, precio_compra)
VALUES
('Queso crema', 'Kilogramos', 10, 2, 25000),
('Galletas Oreo', 'Unidad', 100, 20, 1000),
('Fresas', 'Kilogramos', 5, 1, 12000),
('Frutos rojos', 'Kilogramos', 4, 1, 18000),
('Maracuya', 'Kilogramos', 5, 1, 10000),
('Limon', 'Kilogramos', 4, 1, 6000),
('Arandanos', 'Kilogramos', 3, 1, 22000),
('Chocolate', 'Kilogramos', 5, 1, 18000);
