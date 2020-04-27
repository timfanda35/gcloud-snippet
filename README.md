# gcloud-snippet

Note of Google Cloud SDK.

## Use `-q` to avoid inactive prompt when delete resources.

```
gcloud iam service-accounts delete -q ${SERVICE_ACCOUNT_EMAIL}
```

## List compute instances with network tags

```
gcloud compute instances list \
  --format="table[box](name, tags.items.flatten())" \
  --sort-by="name"
```

## Count by disk types

```
gcloud compute instances list \
  --filter="status=running" \
  --format="value(machine_type.basename())" \
  | sort \
  | uniq -c
```

## Count by disk size

```
gcloud compute disks list \
  --format="value(size_gb)" \
  | sort \
  | uniq -c
```

## Show all IAM roles

```
gcloud iam roles list | grep "name:"
```

## Show BigQuery public dataset

```
bq ls bigquery-public-data:
```

## List Cloud Monitoring dashboards

```
gcloud beta monitoring dashboards list --format="value(name, displayName, etag)"
```

## Use Python3 to fix encoding problem

```
# Use python3
export CLOUDSDK_PYTHON=python3

# Show Billing Account Name
gcloud alpha billing accounts list --format='value[separator=","](ACCOUNT_ID,NAME)'
```

Ref: https://cloud.google.com/sdk/gcloud/reference/topic/startup

## Use Python3 to fix Windows Long Path problem

Problem:

There's a file path exceed 260 characters: "F:\path_very_long_and_exceed260char\file.txt".

```
> gsutil cp -r F:\Data gs://BUCKET_NAME/Data
OSError: The system cannot find the path specificed
```

Root cause:

Cloud SDK and gsutil default use Python 2.7 and Python 2.7 does not support Windows registry "LongPathsEnabled".

Solution:
1. Install [python3.6+](https://www.python.org/downloads/windows/)
2. Set the environment variable: `CLOUDSDK_GSUTIL_PYTHON`
3. Run gsutil command in Powershell:
```
> $Env:CLOUDSDK_GSUTIL_PYTHON="py"
> gsutil cp -r F:\Data gs://BUCKET_NAME/Data
```

Ref: 
- https://stackoverflow.com/questions/46488118/win32-long-paths-from-python
- https://cloud.google.com/sdk/gcloud/reference/topic/startup
- https://www.howtogeek.com/266621/how-to-make-windows-10-accept-file-paths-over-260-characters/

## Show dynamic routes destination ranges of Cloud Router

```
gcloud compute routers get-status ${CLOUD_ROUTER} \
  --region=${REGION} \
  --format="value(result.bestRoutes.destRange)" \
  | tr ";" "\n" \
  | sort
```
