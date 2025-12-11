# Backend Architecture - How It Would Work

## What Is Happening in the Backend (Simple Explanation)

The backend acts as the **brain** of the system.  
The Flutter app talks to the backend.  
The backend talks to Meta’s WhatsApp Business API.

Here is what actually happens step-by-step:

---

## 1. Flutter App → Backend API
Whenever the merchant uses the Flutter app, it sends requests to the backend such as:

- “Send this message”
- “Fetch all logs”
- “Create or update template”
- “Login”

The backend receives and processes these requests.

---

## 2. Authentication & Roles
The backend checks:

- Who is making the request? (JWT token)  
- Are they a merchant or admin?  
- Do they have permission?  

This ensures security and proper access control.

---

## 3. Backend Validates & Processes the Request
Depending on the endpoint:

### Sending Messages
- Validate number  
- Check template approval  
- Format body for Meta API  

### Creating Templates
- Validate structure  
- Format components  
- Save to DB with pending status  

### Fetching Logs / Stats
- Query DB  
- Return filtered data  

---

## 4. Backend Sends Requests to Meta (WhatsApp API)
For anything involving WhatsApp:

Example: Sending a message  
`POST https://graph.facebook.com/v18.0/{PHONE_ID}/messages`

Meta replies with message ID + “sent” status.

Backend stores this in the database.

---

## 5. Meta Sends Real-time Updates via Webhooks
Meta sends automatic updates for:

- delivered  
- read  
- failed  
- template approved/rejected  

Your backend receives these events at:

`POST /api/webhooks/meta`

Backend then:

- verifies signature  
- parses status  
- updates MongoDB  

---

## 6. Database Updates
MongoDB stores:

- message_logs  
- templates  
- webhook events  
- users  

This enables the Flutter app to show real-time accurate data.

---

## 7. Backend Responds to Flutter App
After processing any request, backend returns:

{
"success": true,
"data": ...
}


The Flutter UI updates accordingly.

---

## 8. Everything Stays in Sync
Because:

- Backend stores all truth  
- Meta updates backend via webhooks  
- Flutter reads data from backend  

Both Admin and Merchant see live updated information.

---

# Core Backend Components

## 1. API Server (Node.js + Express)
- RESTful endpoints  
- JWT auth  
- Role-based access  
- Input validation  
- Error handling  

---

## 2. Database (MongoDB)

### Why MongoDB?
- Flexible document structure  
- Good for nested components  
- Fast for logs  
- Matches Meta API JSON format  

### Collections
- `users`  
- `templates`  
- `message_logs`  
- `webhooks_log`  

---

## 3. Meta API Integration

### Template Creation Flow
1. Flutter → `/api/templates`  
2. Backend formats and sends to Meta API  
3. Saved with `"pending"` status  
4. Webhook updates on approval/rejection  

### Message Sending Flow
1. Flutter → `/api/messages/send`  
2. Backend validates and sends to Meta API  
3. Saves `"sent"`  
4. Webhook updates status  

---

## 4. Webhook Handler

### Process
1. Meta → sends update to `/api/webhooks/meta`  
2. Backend verifies signature  
3. Extracts new status  
4. Updates DB  
5. Optionally pushes notification to app  

### Why Webhooks?
- Instant  
- Efficient  
- No polling  
- Better UX  

---

# API Endpoints Structure

## Authentication
POST /api/auth/login
POST /api/auth/register
POST /api/auth/refresh


## Messages
GET /api/messages/logs
GET /api/messages/logs/:id
POST /api/messages/send
GET /api/messages/stats
POST /api/messages/export


## Templates
GET /api/templates
GET /api/templates/:id
POST /api/templates
PUT /api/templates/:id
DELETE /api/templates/:id
POST /api/templates/sync


## Webhooks
GET /api/webhooks/meta
POST /api/webhooks/meta


## Admin
GET /api/admin/merchants
GET /api/admin/analytics
POST /api/admin/templates


# Security Measures

## JWT Authentication
- Access token (15 min)  
- Refresh token (7 days)  

## Role-Based Access
```javascript
Merchant:
- View own logs
- Manage own templates
- Send messages

Admin:
- View all merchants
- Manage all templates
- View analytics

## Meta API Security
- Token stored in env vars  
- 90-day rotation  
- Webhook signature validation  

## Input Validation
- Phone validation  
- Sanitizing fields  
- XSS protection  

## Data Synchronization  

### How Backend Keeps Both Apps In Sync
- Shared API  
- Single MongoDB  
- Real-time webhook updates  
- Flutter fetches latest data  

