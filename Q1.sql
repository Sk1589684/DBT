-- Drop old procedure if exists
DROP PROCEDURE IF EXISTS transfer_funds;
DELIMITER //

CREATE PROCEDURE transfer_funds(
    IN sender_id INT, 
    IN receiver_id INT, 
    IN amount_to_send INT
)
BEGIN
    -- 1. START: Tell the database to wait before saving changes permanently
    START TRANSACTION;

    -- 2. DEDUCT: Take money from the sender
    UPDATE accounts 
    SET balance = balance - amount_to_send 
    WHERE acc_no = sender_id;

    -- 3. ADD: Give money to the receiver
    UPDATE accounts 
    SET balance = balance + amount_to_send 
    WHERE acc_no = receiver_id;

    -- 4. CHECK: If the sender's balance just dropped below 0, cancel everything!
    IF (SELECT balance FROM accounts WHERE acc_no = sender_id) < 0 THEN
        ROLLBACK; -- Undo everything
    ELSE
        -- 5. LOG: Record the transfer in history
        INSERT INTO transaction_history (from_acc, to_acc, amount)
        VALUES (sender_id, receiver_id, amount_to_send);
        
        COMMIT; -- Save everything permanently
    END IF;

END //