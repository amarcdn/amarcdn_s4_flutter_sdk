# AmarCDN SDK for Flutter

AmarCDN is a product of [TongBari](https://tongbari.com). We have started our domain and hosting business since 2011. Over this time, we have re-branding ourself. Now we are providing Global Standard compatible cloud services.

## What is S4?

Before going to tell about S4 we have to know about S3. S3 is the abbreviation of Simple Storage Service. So the S4 is Secured S3. Finally S4 stands for Secured - Simple Storage Service.

## What is Bucket?

A container for objects stored in AmarCDN S4. AmarCDN will provide a subdomain for the bucket. The bucket is globally unique but your subdomain will be prefix with regional url. Bucket name should be 4-60 chararacters

### Install via flutter packages.

    flutter pub add amarcdn_s4

### Create instance of AmarCDN with below code.

```dart
AmarCDN _amarCDN = AmarCDN(apiKey: _apiKey,
 apiSecretKey: _apiSecretKey, regionTitle: _regionTitle);
```

### Create Bucket Example

```dart
Future createBucket() async {
    try {
      final response = await _amarCDN.createBucket(
          bucketName: 'nizam', isPrivate: false);
      debugPrint(response.data.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
```

### Get Bucket List Example

```dart
Future getBucketList() async {
    try {
      final response = await _amarCND.getBucketList();
      debugPrint(response.data.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
```

### Delete Bucket Example

```dart
Future deleteBucket() async {
    try {
      final response = await _amarCND.deleteBucket(
        bucketName: 'shamrat',
        bucketId: 'a2dfddd5-f3e2-46b9-9dff-d4fe1e30c344',
      );
      debugPrint(response.data.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
```