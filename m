Return-Path: <linux-pci+bounces-43075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D7ECC065A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 01:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F178A30275F6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 00:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376A22848A1;
	Tue, 16 Dec 2025 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiLnKeg3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328EC224891;
	Tue, 16 Dec 2025 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846537; cv=none; b=fBEELipG8Ms0RKoioZHgR72EOFlUC/wiiMgnlCIGMsAJE6Ed1IorR1sJ8OkbcpnyZCMI51IQl+qdEdTf6TWbipn0HfzrDtb5B+If0xHZflcaZiDdiMgTr7PQFQLS2spSTMs36ZqU+J2Yn3vl0d1WN+Ko9291SX34NN/U9wyzcEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846537; c=relaxed/simple;
	bh=227I6CJV9ocBGsFP/LsCYQMuN5o0I8rj+s7ym38P2+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFIuZTBV5ITkjOxJkarO1Q9cd2924U9GLYhWt9vxKuzMNl2ekeH+bUJh6zurV8CHXolR7+3Tsov3uE/F/bIfhbPgRBrWdyK0JQmTAyAG+eK7myJZdUZ2i2gPBAzfNrFRJ7/zDphm8WE6wTHhFgdfOzbf4RcMVDRCLfUpAaH6AZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiLnKeg3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765846536; x=1797382536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=227I6CJV9ocBGsFP/LsCYQMuN5o0I8rj+s7ym38P2+0=;
  b=OiLnKeg34BIm/aXMvm42pu6ST2bD86BMMNX83YvIDgNJZ7H4TiMCcMrl
   g/jogDUfhDSG2YzkwoObbdm6Ei59lh5u7yMCkpLk03sb7XFIVdZLIftTC
   8dO3StYyVlgShyD+Wids3uCT/OwC54uiMe31eKlXztibRwy/yw5nDJiXH
   haCWOxgsNbxY9uIZ7gd1Ini0wADC6bOSvLXt2R8/MxsPNiofdThcaNG8B
   k483bRVTcTNAKwx03DxdSS3PkjblUf7PAJcFDQ1rapU+APMFIKZHm1WZ1
   RUL6T0PtHfYO5OJGHfKwnI8nwzno/4NgEOWiPir9C4TrHLAnLTVzxLTBt
   A==;
X-CSE-ConnectionGUID: 4mz2pVzPTouVWTFzTGoidw==
X-CSE-MsgGUID: 2ZZ3QqDQSL2siLmAzDNUQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79215484"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="79215484"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 16:55:33 -0800
X-CSE-ConnectionGUID: 6ZXeJJmnQSa8D2fkNgB7QQ==
X-CSE-MsgGUID: V8hmgQ9FSUq7ZjI+9ccEPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="198131535"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa008.fm.intel.com with ESMTP; 15 Dec 2025 16:55:32 -0800
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
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 4/6] cxl/mem: Convert devm_cxl_add_memdev() to scope-based-cleanup
Date: Mon, 15 Dec 2025 16:56:14 -0800
Message-ID: <20251216005616.3090129-5-dan.j.williams@intel.com>
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

In preparation for adding more setup steps, convert the current
implementation to scope-based cleanup.

The cxl_memdev_shutdown() is only required after cdev_device_add(). With
that moved to a helper function it precludes the need to add
scope-based-handler for that cleanup if devm_add_action_or_reset() fails.

Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Tested-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c | 70 ++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 7a4153e1c6a7..18efbf294db5 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1050,6 +1050,45 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
+/*
+ * Activate ioctl operations, no cxl_memdev_rwsem manipulation needed as this is
+ * ordered with cdev_add() publishing the device.
+ */
+static int cxlmd_add(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
+{
+	int rc;
+
+	cxlmd->cxlds = cxlds;
+	cxlds->cxlmd = cxlmd;
+
+	rc = cdev_device_add(&cxlmd->cdev, &cxlmd->dev);
+	if (rc) {
+		/*
+		 * The cdev was briefly live, shutdown any ioctl operations that
+		 * saw that state.
+		 */
+		cxl_memdev_shutdown(&cxlmd->dev);
+		return rc;
+	}
+
+	return 0;
+}
+
+DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
+	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev);)
+
+static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
+{
+	int rc;
+
+	rc = devm_add_action_or_reset(cxlmd->cxlds->dev, cxl_memdev_unregister,
+				      cxlmd);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return cxlmd;
+}
+
 /*
  * Core helper for devm_cxl_add_memdev() that wants to both create a device and
  * assert to the caller that upon return cxl_mem::probe() has been invoked.
@@ -1057,45 +1096,24 @@ static const struct file_operations cxl_memdev_fops = {
 struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
 					 struct cxl_dev_state *cxlds)
 {
-	struct cxl_memdev *cxlmd;
 	struct device *dev;
-	struct cdev *cdev;
 	int rc;
 
-	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
+	struct cxl_memdev *cxlmd __free(put_cxlmd) =
+		cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
 	if (IS_ERR(cxlmd))
 		return cxlmd;
 
 	dev = &cxlmd->dev;
 	rc = dev_set_name(dev, "mem%d", cxlmd->id);
 	if (rc)
-		goto err;
-
-	/*
-	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
-	 * needed as this is ordered with cdev_add() publishing the device.
-	 */
-	cxlmd->cxlds = cxlds;
-	cxlds->cxlmd = cxlmd;
-
-	cdev = &cxlmd->cdev;
-	rc = cdev_device_add(cdev, dev);
-	if (rc)
-		goto err;
+		return ERR_PTR(rc);
 
-	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
+	rc = cxlmd_add(cxlmd, cxlds);
 	if (rc)
 		return ERR_PTR(rc);
-	return cxlmd;
 
-err:
-	/*
-	 * The cdev was briefly live, shutdown any ioctl operations that
-	 * saw that state.
-	 */
-	cxl_memdev_shutdown(dev);
-	put_device(dev);
-	return ERR_PTR(rc);
+	return cxl_memdev_autoremove(no_free_ptr(cxlmd));
 }
 EXPORT_SYMBOL_FOR_MODULES(__devm_cxl_add_memdev, "cxl_mem");
 
-- 
2.51.1


