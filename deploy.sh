docker build -t tommasolevato/multi-client:latest -t tommasolevato/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tommasolevato/multi-server:latest -t tommasolevato/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tommasolevato/multi-worker:latest -t tommasolevato/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tommasolevato/multi-client:latest
docker push tommasolevato/multi-server:latest
docker push tommasolevato/multi-worker:latest

docker push tommasolevato/multi-client:$SHA
docker push tommasolevato/multi-server:$SHA
docker push tommasolevato/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tommasolevato/multi-server:$SHA
kubectl set image deployments/client-deployment client=tommasolevato/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tommasolevato/multi-worker:$SHA