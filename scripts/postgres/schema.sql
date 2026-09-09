CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS complaints (
    id BIGSERIAL PRIMARY KEY,
    complaint_id VARCHAR(50) UNIQUE NOT NULL,
    customer_id VARCHAR(100),
    customer_name VARCHAR(255),
    customer_email VARCHAR(255) NOT NULL,
    source VARCHAR(50) DEFAULT 'GMAIL',
    email_message_id VARCHAR(255),
    subject TEXT,
    complaint_text TEXT,
    category VARCHAR(100),
    subcategory VARCHAR(100),
    severity VARCHAR(30),
    sentiment VARCHAR(30),
    refund_requested BOOLEAN DEFAULT FALSE,
    ai_recommendation VARCHAR(50),
    ai_confidence NUMERIC(5,4),
    ai_reason TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'RECEIVED',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS complaint_status_history (
    id BIGSERIAL PRIMARY KEY,
    complaint_id VARCHAR(50) NOT NULL REFERENCES complaints(complaint_id),
    old_status VARCHAR(50),
    new_status VARCHAR(50) NOT NULL,
    changed_by VARCHAR(255),
    actor_type VARCHAR(30) NOT NULL,
    reason TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS human_decisions (
    id BIGSERIAL PRIMARY KEY,
    complaint_id VARCHAR(50) NOT NULL REFERENCES complaints(complaint_id),
    decision VARCHAR(30) NOT NULL CHECK (decision IN ('REFUND','REJECT','REQUEST_INFO','ESCALATE')),
    reason TEXT NOT NULL,
    reviewer VARCHAR(255) NOT NULL,
    decided_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS refunds (
    id BIGSERIAL PRIMARY KEY,
    complaint_id VARCHAR(50) NOT NULL UNIQUE REFERENCES complaints(complaint_id),
    amount NUMERIC(12,2),
    currency VARCHAR(10) DEFAULT 'INR',
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    approved_by VARCHAR(255),
    approval_reason TEXT,
    refund_reference VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS workflow_transactions (
    id BIGSERIAL PRIMARY KEY,
    transaction_id UUID NOT NULL DEFAULT gen_random_uuid(),
    complaint_id VARCHAR(50),
    transaction_type VARCHAR(100) NOT NULL,
    source_system VARCHAR(100),
    target_system VARCHAR(100),
    status VARCHAR(50) NOT NULL,
    request_data JSONB,
    response_data JSONB,
    error_message TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS integration_transactions (
    id BIGSERIAL PRIMARY KEY,
    idempotency_key VARCHAR(255) UNIQUE NOT NULL,
    complaint_id VARCHAR(50),
    system_name VARCHAR(100) NOT NULL,
    operation VARCHAR(100) NOT NULL,
    status VARCHAR(50) NOT NULL,
    request_data JSONB,
    response_data JSONB,
    error_message TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_complaints_status ON complaints(status);
CREATE INDEX IF NOT EXISTS idx_complaints_created_at ON complaints(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_status_history_complaint ON complaint_status_history(complaint_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_workflow_transactions_complaint ON workflow_transactions(complaint_id, created_at DESC);

CREATE OR REPLACE VIEW complaint_summary AS
SELECT c.complaint_id, c.customer_name, c.customer_email,
       c.category, c.severity, c.refund_requested,
       c.ai_recommendation, c.ai_confidence, c.status,
       h.decision AS human_decision, h.reason AS human_decision_reason,
       h.reviewer, h.decided_at, r.amount AS refund_amount,
       r.status AS refund_status, r.refund_reference,
       c.created_at, c.updated_at
FROM complaints c
LEFT JOIN LATERAL (
    SELECT * FROM human_decisions hd
    WHERE hd.complaint_id = c.complaint_id
    ORDER BY hd.decided_at DESC LIMIT 1
) h ON TRUE
LEFT JOIN refunds r ON r.complaint_id = c.complaint_id;
