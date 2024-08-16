# Tea Subscription Service API

This API provides endpoints to manage tea subscriptions for customers.

## Endpoints

### 1. Create a Subscription

- **URL**: POST `/api/v1/customers/:customer_id/subscriptions`
- **Description**: Creates a new subscription for a customer.
- **Request Body**:
  ```json
  {
    "subscription": {
      "customer_id": 1,
      "tea_id": 2
    }
  }
  ```
- **Successful Response** (Status 201):
  ```json
  {
    "data": {
      "id": "1",
      "type": "subscription",
      "attributes": {
        "title": "John's Green Tea Subscription",
        "status": "active",
        "frequency": "monthly",
        "customer_id": 1,
        "tea_id": 2,
        "price": 5
      }
    }
  }
  ```
- **Error Response** (Status 422):
  ```json
  {
    "errors": ["Tea must exist"]
  }
  ```

### 2. Cancel a Subscription

- **URL**: DELETE `/api/v1/customers/:customer_id/subscriptions/:id`
- **Description**: Cancels an existing subscription.
- **Successful Response** (Status 202):
  ```json
  {
    "data": {
      "id": "1",
      "type": "subscription",
      "attributes": {
        "status": "cancelled",
        // other attributes...
      }
    }
  }
  ```

### 3. Get All Customer Subscriptions

- **URL**: GET `/api/v1/customers/:customer_id/subscriptions`
- **Description**: Retrieves all subscriptions for a specific customer.
- **Successful Response** (Status 200):
  ```json
  {
    "data": [
      {
        "data" {
          "id": "1",
          "type": "subscription",
          "attributes": {
          // subscription details
          }
        }
      },
      // more subscriptions...
    ]
  }
  ```

## Notes

- All endpoints require a valid `customer_id`.
- Subscriptions are created with default values:
  - Status: "active"
  - Frequency: "monthly"
  - Title: "[Customer's First Name]'s [Tea Name] Subscription"
  - Price: Same as the tea's price
- Cancelling a subscription changes its status to "cancelled" but doesn't delete the record.
