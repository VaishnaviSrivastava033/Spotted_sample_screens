# Spotted WhatsApp Message Management System


## Overview

This is a demonstration of a WhatsApp messaging system that allows Spotted merchants to manage templates and send messages to customers through Meta's WhatsApp Business API.

## What's Included

1. **System Explanation** - Clear overview of the architecture
2. **Architecture Diagram** - Visual representation of system flow
3. **Flutter UI Screens** - Two fully functional UI screens
   - Message Logs Screen
   - Templates Management Screen
4. **Backend API Routes** - RESTful API structure with authentication

## Key Features Demonstrated

### Flutter Frontend
- Clean, modern Material Design UI
- State management with StatefulWidget
- Responsive layouts
- Filter and search functionality
- Interactive cards and modals
- Status indicators with color coding

### Backend API
- RESTful API design
- JWT authentication middleware
- Role-based access control (Merchant/Admin)
- Webhook handling for Meta API
- Comprehensive error handling
- Database-ready structure

## Technical Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Node.js with Express(not implemented yet)
- **Database**: MongoDB (structure defined, not implemented)
- **Authentication**: JWT tokens(not implemented yet)
- **External API**: Meta WhatsApp Business Cloud API(not implemented yet)

## Running the Project

### Flutter App
```bash
cd flutter_app
flutter pub get
flutter run
```


## API Endpoints

### Messages
- `GET /api/messages/logs` - Fetch message logs
- `POST /api/messages/send` - Send a message
- `GET /api/messages/stats` - Get statistics

### Templates
- `GET /api/templates` - List all templates
- `POST /api/templates` - Create new template
- `PUT /api/templates/:id` - Update template
- `DELETE /api/templates/:id` - Delete template

### Webhooks
- `GET /api/webhooks/meta` - Verify webhook
- `POST /api/webhooks/meta` - Receive status updates

## Design Decisions

1. **Shared Backend**: Both Merchant App and Admin Panel use the same API
2. **Webhook-Driven**: Real-time updates from Meta instead of polling
3. **Template-Based**: All messages must use pre-approved templates
4. **Role-Based Access**: Merchants see only their data, admins see all

## Future Enhancements

- Complete database integration
- Meta API integration
- Scheduled messaging
- Advanced analytics
- Multi-language support

## Contact

Vaishnavi Srivastava  
vaishnavisrivastav033@gmail.com 
