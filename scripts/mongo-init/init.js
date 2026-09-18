db = db.getSiblingDB("operations_log");

db.createCollection("hr_logs");
db.createCollection("finance_logs");
db.createCollection("admin_logs");
db.createCollection("operational_logs");

db.hr_logs.createIndex({ event_id: 1 }, { unique: true });
db.hr_logs.createIndex({ employee_id: 1, created_at: -1 });
db.hr_logs.createIndex({ complaint_id: 1, created_at: -1 });

db.finance_logs.createIndex({ event_id: 1 }, { unique: true });
db.finance_logs.createIndex({ complaint_id: 1, created_at: -1 });
db.finance_logs.createIndex({ event_type: 1, created_at: -1 });

db.admin_logs.createIndex({ event_id: 1 }, { unique: true });
db.admin_logs.createIndex({ actor: 1, created_at: -1 });
db.admin_logs.createIndex({ event_type: 1, created_at: -1 });

db.operational_logs.createIndex({ event_id: 1 }, { unique: true });
db.operational_logs.createIndex({ complaint_id: 1, created_at: -1 });

print("operations_log initialized");
