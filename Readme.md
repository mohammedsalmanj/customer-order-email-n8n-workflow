# Customer Order Email Generator using n8n + OpenAI

This project uses **n8n** and **OpenAI** to generate professional, AI-powered customer order emails from structured input data.

---

## Use Case

When a customer places an order, this workflow:

- Accepts order data (name, product, quantity, status)
- Sends a formatted prompt to OpenAI
- Receives a dynamic email subject and body
- Optionally sends it via email or Slack

---

## Sample Input

```json
{
  "Order ID": "#12345",
  "Customer Name": "John Doe",
  "Product": "Noise Cancelling Headphones",
  "Quantity": "1",
  "Price (₹)": "3999",
  "Status": "Shipped"
}
