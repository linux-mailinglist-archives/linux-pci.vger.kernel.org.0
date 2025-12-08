Return-Path: <linux-pci+bounces-42788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D9BCAE0EF
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 20:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C0C5302CF64
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4331E7C18;
	Mon,  8 Dec 2025 19:20:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679182E6CA8;
	Mon,  8 Dec 2025 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221624; cv=none; b=E507CT0AIq7BZecWQgUT3C5UPwzn0RiqaNPmLr58ROIyWnAmFh9mtZOPiwC6cGYrAd57EXSxcGPcUKgOOpvoZIITUYxmqWERv4br9R0BXHJQi+bAWJZt8/tL63xbtEKv9tD59hwVy5S6OW4CTzYShsfyM9HU6idpiCC5vwkVSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221624; c=relaxed/simple;
	bh=ZvzubhbjaPPIB27TBG+LgkPEThq3zam8An+ceJQtgSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NyQBeD6XWmWHMry66V96Si73QQxoBaWpc1LPPCbkqo/aL/YS3L1bLUahpo8bivbM7gyLNwL4g1c+nGFtVZsIKG/aGdvvORApuDp1gPELs7JLQBXQw2w4osiURg6Y+ABPilHqUdyaLiSU+8jWLmUp2vXWtfI+++RW25feuEXoCXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dQBdF1BVYzJ468L;
	Tue,  9 Dec 2025 03:20:01 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D2D840565;
	Tue,  9 Dec 2025 03:20:16 +0800 (CST)
Received: from dubpeml100008.china.huawei.com (7.214.145.227) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Dec 2025 19:20:15 +0000
Received: from dubpeml100008.china.huawei.com ([7.214.145.227]) by
 dubpeml100008.china.huawei.com ([7.214.145.227]) with mapi id 15.02.1544.036;
 Mon, 8 Dec 2025 19:20:15 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "terry.bowman@amd.com" <terry.bowman@amd.com>,
	"alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
Subject: RE: [PATCH 1/6] cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
Thread-Topic: [PATCH 1/6] cxl/mem: Fix devm_cxl_memdev_edac_release()
 confusion
Thread-Index: AQHcZMSxU6y9BCMwtEyyE/sQ3sAKtbUYJCZQ
Date: Mon, 8 Dec 2025 19:20:15 +0000
Message-ID: <4a489f66af1c4f83b0ece5d54ef35fc9@huawei.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-2-dan.j.williams@intel.com>
In-Reply-To: <20251204022136.2573521-2-dan.j.williams@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: 04 December 2025 02:22
>To: dave.jiang@intel.com
>Cc: linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org;
>Smita.KoralahalliChannabasappa@amd.com; alison.schofield@intel.com;
>terry.bowman@amd.com; alejandro.lucero-palau@amd.com; linux-
>pci@vger.kernel.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
>Shiju Jose <shiju.jose@huawei.com>
>Subject: [PATCH 1/6] cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
>
>A device release method is only for undoing allocations on the path to pre=
paring
>the device for device_add(). In contrast, devm allocations are post device=
_add(),
>are acquired during / after ->probe() and are released synchronous with -
>>remove().
>
>So, a "devm" helper in a "release" method is a clear anti-pattern.
>
>Move this devm release action where it belongs, an action created at edac =
object
>creation time. Otherwise, this leaks resources until
>cxl_memdev_release() time which may be long after these xarray and error
>record caches have gone idle.
>
>Note, this also fixes up the type of @cxlmd->err_rec_array which needlessl=
y
>dropped type-safety.
>
>Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation
>attributes from the current boot")
>Cc: Dave Jiang <dave.jiang@intel.com>
>Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Cc: Shiju Jose <shiju.jose@huawei.com>
>Cc: Alison Schofield <alison.schofield@intel.com>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Tested-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
>---
> drivers/cxl/cxlmem.h      |  5 +--
> drivers/cxl/core/edac.c   | 64 ++++++++++++++++++++++-----------------
> drivers/cxl/core/memdev.c |  1 -
> 3 files changed, 38 insertions(+), 32 deletions(-)
>
>diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
>434031a0c1f7..c12ab4fc9512 100644
>--- a/drivers/cxl/cxlmem.h
>+++ b/drivers/cxl/cxlmem.h
>@@ -63,7 +63,7 @@ struct cxl_memdev {
> 	int depth;
> 	u8 scrub_cycle;
> 	int scrub_region_id;
>-	void *err_rec_array;
>+	struct cxl_mem_err_rec *err_rec_array;
> };
>
> static inline struct cxl_memdev *to_cxl_memdev(struct device *dev) @@ -87=
7,7
>+877,6 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
>int devm_cxl_region_edac_register(struct cxl_region *cxlr);  int
>cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt);  =
int
>cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt); -void
>devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd);  #else  static
>inline int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)  { retu=
rn
>0; } @@ -889,8 +888,6 @@ static inline int cxl_store_rec_gen_media(struct
>cxl_memdev *cxlmd,  static inline int cxl_store_rec_dram(struct cxl_memdev
>*cxlmd,
> 				     union cxl_event *evt)
> { return 0; }
>-static inline void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd)=
 -
>{ return; }  #endif
>
> #ifdef CONFIG_CXL_SUSPEND
>diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c index
>79994ca9bc9f..81160260e26b 100644
>--- a/drivers/cxl/core/edac.c
>+++ b/drivers/cxl/core/edac.c
>@@ -1988,6 +1988,40 @@ static int cxl_memdev_soft_ppr_init(struct
>cxl_memdev *cxlmd,
> 	return 0;
> }
>
>+static void err_rec_free(void *_cxlmd)
>+{
>+	struct cxl_memdev *cxlmd =3D _cxlmd;
>+	struct cxl_mem_err_rec *array_rec =3D cxlmd->err_rec_array;
>+	struct cxl_event_gen_media *rec_gen_media;
>+	struct cxl_event_dram *rec_dram;
>+	unsigned long index;
>+
>+	cxlmd->err_rec_array =3D NULL;
>+	xa_for_each(&array_rec->rec_dram, index, rec_dram)
>+		kfree(rec_dram);
>+	xa_destroy(&array_rec->rec_dram);
>+
>+	xa_for_each(&array_rec->rec_gen_media, index, rec_gen_media)
>+		kfree(rec_gen_media);
>+	xa_destroy(&array_rec->rec_gen_media);
>+	kfree(array_rec);
>+}
>+
>+static int devm_cxl_memdev_setup_err_rec(struct cxl_memdev *cxlmd) {
>+	struct cxl_mem_err_rec *array_rec =3D
>+		kzalloc(sizeof(*array_rec), GFP_KERNEL);
>+
>+	if (!array_rec)
>+		return -ENOMEM;
>+
>+	xa_init(&array_rec->rec_gen_media);
>+	xa_init(&array_rec->rec_dram);
>+	cxlmd->err_rec_array =3D array_rec;
>+
>+	return devm_add_action_or_reset(&cxlmd->dev, err_rec_free, cxlmd); }
>+
> int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)  {
> 	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
>@@ -2038,15 +2072,9 @@ int devm_cxl_memdev_edac_register(struct
>cxl_memdev *cxlmd)
> 		}
>
> 		if (repair_inst) {
>-			struct cxl_mem_err_rec *array_rec =3D
>-				devm_kzalloc(&cxlmd->dev, sizeof(*array_rec),
>-					     GFP_KERNEL);
>-			if (!array_rec)
>-				return -ENOMEM;
>-
>-			xa_init(&array_rec->rec_gen_media);
>-			xa_init(&array_rec->rec_dram);
>-			cxlmd->err_rec_array =3D array_rec;
>+			rc =3D devm_cxl_memdev_setup_err_rec(cxlmd);
>+			if (rc)
>+				return rc;
> 		}
> 	}
>
>@@ -2088,22 +2116,4 @@ int devm_cxl_region_edac_register(struct
>cxl_region *cxlr)  }  EXPORT_SYMBOL_NS_GPL(devm_cxl_region_edac_register,
>"CXL");
>
>-void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd) -{
>-	struct cxl_mem_err_rec *array_rec =3D cxlmd->err_rec_array;
>-	struct cxl_event_gen_media *rec_gen_media;
>-	struct cxl_event_dram *rec_dram;
>-	unsigned long index;
>-
>-	if (!IS_ENABLED(CONFIG_CXL_EDAC_MEM_REPAIR) || !array_rec)
>-		return;
>-
>-	xa_for_each(&array_rec->rec_dram, index, rec_dram)
>-		kfree(rec_dram);
>-	xa_destroy(&array_rec->rec_dram);
>
>-	xa_for_each(&array_rec->rec_gen_media, index, rec_gen_media)
>-		kfree(rec_gen_media);
>-	xa_destroy(&array_rec->rec_gen_media);
>-}
>-EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_edac_release, "CXL"); diff --git
>a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c index
>e370d733e440..4dff7f44d908 100644
>--- a/drivers/cxl/core/memdev.c
>+++ b/drivers/cxl/core/memdev.c
>@@ -27,7 +27,6 @@ static void cxl_memdev_release(struct device *dev)
> 	struct cxl_memdev *cxlmd =3D to_cxl_memdev(dev);
>
> 	ida_free(&cxl_memdev_ida, cxlmd->id);
>-	devm_cxl_memdev_edac_release(cxlmd);
> 	kfree(cxlmd);
> }
>
>--
>2.51.1
>


