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
