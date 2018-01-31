--Miguel Monterrubio A01022153*/

--Trigger para no poder incrementar salario mas de 30%
create trigger salary_control before update of salary on employee referencing old as old_values new as new_values for each row mode db2sql when (new_values.salary > old_values.salary * 1.3) begin atomic signal sqlstate '75000' set message_text='Error: Aumento de salario no debe pasar de 30%'; end

--Crear primero la tabla de la orden de compra. Despues trigger para checar inventario de un producto antes de poder hacer una orden de compra de ese producto
create table buy_order(pID varchar(20) not null, quantity int not null, status varchar(20) not null)

create trigger check_inventory before insert on buy_order referencing new as new_values for each row mode db2sql when (new_values.quantity > (select quantity from inventory where(new_values.pID = PID))) begin atomic signal sqlstate '75000' set message_text = 'No hay suficiente inventario del producto seleccionado'; end

--Trigger para restar cantidad de producto cuando el estado de la orden de compra se cambia a delivered
create trigger status_change after update of status on buy_order referencing new as new_values for each row mode db2sql when (new_values.status = 'delivered') begin atomic update INVENTORY set QUANTITY = QUANTITY - new_values.quantity where inventory.PID = new_values.pID; end 


