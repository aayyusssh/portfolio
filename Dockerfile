FROM node:20.11.0 AS build

WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the React application for production
RUN npm run build

# Step 2: Serve the application using an Nginx server
# Use the official Nginx image as the base image
FROM nginx:alpine

# Copy the build output from the previous step to the Nginx web root
COPY --from=build /app/build /usr/share/nginx/html


# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
