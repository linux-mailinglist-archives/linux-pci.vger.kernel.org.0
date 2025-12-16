Return-Path: <linux-pci+bounces-43072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1DECC0636
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 01:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 820493022632
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 00:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276142066DE;
	Tue, 16 Dec 2025 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiVvK+Px"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C3325F99B;
	Tue, 16 Dec 2025 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846535; cv=none; b=S3Z85mIFFu2N2SSRw8BE225r2KSfHapr23oQ+TeLuwqQqf0Eb94toWS9Zyr/5bFzCi0FyRSGZk0RO/wIZO54yhvRouaHvJAesg4iFWlpI5mKEXa7yFCqZHL4uJRtwnED0OcA/fIZZjTmfOEDw4PkO+oDy/+OqUgKuj5CkL9SaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846535; c=relaxed/simple;
	bh=n8gUZPw7fFS/ouO5litSACm7nPNUbvHr1RQeqbjFMuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/eD1eflFiWsJGRImgEDYzCMO5LK0Nc6l3N6LmrrSFTow2RncfqYGb0BjIZ3pO4knIAC748tvrGx3mnlTBISU4ruevL9uNGhjYftChcQj2zK4XUq9FSNZC+r78sliVuEYDyTzOO/4Jt5J06nMF+Pe23IDxZWFJBsSb2SNmG53ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiVvK+Px; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765846533; x=1797382533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n8gUZPw7fFS/ouO5litSACm7nPNUbvHr1RQeqbjFMuA=;
  b=SiVvK+Px+JTBnnGMJhwKjO7bj8HLZYvVhrsjoM7TlVK786s71xtKx9Ng
   cih0v66tkYhNO1GKqPydQfdgkQ/aGBUg8dVJtGqvb6u/ezNiGq0uYvqC4
   nun88weLjwrIAX3Le/Q2xdsEGQhlNcewf8Vgei/6/4vtaGxCCiX+5MCDk
   tcW3e2N9gGHblGItKQEq6HeXlYxMktFSACckjHUY0JRskvnMZH/uX1jde
   7hTBUIuQzep/zZ5Sb/acC2fD6XqCg6p832wWxr9nuCAq+qsr57BFW0glD
   6ch8Df3LK/l6XNvzvSGaExF9D1au1Ceg8E4oB1I8d31srgIbvxooLu31u
   Q==;
X-CSE-ConnectionGUID: Mdu94FASTJmWb70aI8omFA==
X-CSE-MsgGUID: Yln9hdzZRaW8VBWGkZdPbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79215471"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="79215471"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 16:55:32 -0800
X-CSE-ConnectionGUID: BvKWkTH8Q2SOHl5p3LZegQ==
X-CSE-MsgGUID: tf1rDnl2QXWU+I6CAvHJMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="198131522"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa008.fm.intel.com with ESMTP; 15 Dec 2025 16:55:31 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	alison.schofield@intel.com,
	terry.bowman@amd.com,
	alejandro.lucero-palau@amd.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	Shiju Jose <shiju.jose@huawei.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 1/6] cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
Date: Mon, 15 Dec 2025 16:56:11 -0800
Message-ID: <20251216005616.3090129-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251216005616.3090129-1-dan.j.williams@intel.com>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A device release method is only for undoing allocations on the path to
preparing the device for device_add(). In contrast, devm allocations are
post device_add(), are acquired during / after ->probe() and are released
synchronous with ->remove().

So, a "devm" helper in a "release" method is a clear anti-pattern.

Move this devm release action where it belongs, an action created at edac
object creation time. Otherwise, this leaks resources until
cxl_memdev_release() time which may be long after these xarray and error
record caches have gone idle.

Note, this also fixes up the type of @cxlmd->err_rec_array which needlessly
dropped type-safety.

Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
Tested-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxlmem.h      |  5 +--
 drivers/cxl/core/edac.c   | 64 ++++++++++++++++++++++-----------------
 drivers/cxl/core/memdev.c |  1 -
 3 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 434031a0c1f7..c12ab4fc9512 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -63,7 +63,7 @@ struct cxl_memdev {
 	int depth;
 	u8 scrub_cycle;
 	int scrub_region_id;
-	void *err_rec_array;
+	struct cxl_mem_err_rec *err_rec_array;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
@@ -877,7 +877,6 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
 int devm_cxl_region_edac_register(struct cxl_region *cxlr);
 int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt);
 int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt);
-void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd);
 #else
 static inline int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 { return 0; }
@@ -889,8 +888,6 @@ static inline int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd,
 static inline int cxl_store_rec_dram(struct cxl_memdev *cxlmd,
 				     union cxl_event *evt)
 { return 0; }
-static inline void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd)
-{ return; }
 #endif
 
 #ifdef CONFIG_CXL_SUSPEND
diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 79994ca9bc9f..81160260e26b 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1988,6 +1988,40 @@ static int cxl_memdev_soft_ppr_init(struct cxl_memdev *cxlmd,
 	return 0;
 }
 
+static void err_rec_free(void *_cxlmd)
+{
+	struct cxl_memdev *cxlmd = _cxlmd;
+	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
+	struct cxl_event_gen_media *rec_gen_media;
+	struct cxl_event_dram *rec_dram;
+	unsigned long index;
+
+	cxlmd->err_rec_array = NULL;
+	xa_for_each(&array_rec->rec_dram, index, rec_dram)
+		kfree(rec_dram);
+	xa_destroy(&array_rec->rec_dram);
+
+	xa_for_each(&array_rec->rec_gen_media, index, rec_gen_media)
+		kfree(rec_gen_media);
+	xa_destroy(&array_rec->rec_gen_media);
+	kfree(array_rec);
+}
+
+static int devm_cxl_memdev_setup_err_rec(struct cxl_memdev *cxlmd)
+{
+	struct cxl_mem_err_rec *array_rec =
+		kzalloc(sizeof(*array_rec), GFP_KERNEL);
+
+	if (!array_rec)
+		return -ENOMEM;
+
+	xa_init(&array_rec->rec_gen_media);
+	xa_init(&array_rec->rec_dram);
+	cxlmd->err_rec_array = array_rec;
+
+	return devm_add_action_or_reset(&cxlmd->dev, err_rec_free, cxlmd);
+}
+
 int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 {
 	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
@@ -2038,15 +2072,9 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 		}
 
 		if (repair_inst) {
-			struct cxl_mem_err_rec *array_rec =
-				devm_kzalloc(&cxlmd->dev, sizeof(*array_rec),
-					     GFP_KERNEL);
-			if (!array_rec)
-				return -ENOMEM;
-
-			xa_init(&array_rec->rec_gen_media);
-			xa_init(&array_rec->rec_dram);
-			cxlmd->err_rec_array = array_rec;
+			rc = devm_cxl_memdev_setup_err_rec(cxlmd);
+			if (rc)
+				return rc;
 		}
 	}
 
@@ -2088,22 +2116,4 @@ int devm_cxl_region_edac_register(struct cxl_region *cxlr)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_region_edac_register, "CXL");
 
-void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd)
-{
-	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
-	struct cxl_event_gen_media *rec_gen_media;
-	struct cxl_event_dram *rec_dram;
-	unsigned long index;
-
-	if (!IS_ENABLED(CONFIG_CXL_EDAC_MEM_REPAIR) || !array_rec)
-		return;
-
-	xa_for_each(&array_rec->rec_dram, index, rec_dram)
-		kfree(rec_dram);
-	xa_destroy(&array_rec->rec_dram);
 
-	xa_for_each(&array_rec->rec_gen_media, index, rec_gen_media)
-		kfree(rec_gen_media);
-	xa_destroy(&array_rec->rec_gen_media);
-}
-EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_edac_release, "CXL");
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index e370d733e440..4dff7f44d908 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -27,7 +27,6 @@ static void cxl_memdev_release(struct device *dev)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
 	ida_free(&cxl_memdev_ida, cxlmd->id);
-	devm_cxl_memdev_edac_release(cxlmd);
 	kfree(cxlmd);
 }
 
-- 
2.51.1


