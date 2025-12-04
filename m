Return-Path: <linux-pci+bounces-42604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3099DCA22AF
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 03:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B42033052225
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 02:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEF92512E6;
	Thu,  4 Dec 2025 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgd4kThe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52B72580D1;
	Thu,  4 Dec 2025 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764814901; cv=none; b=mFu9KjAqhXSifoMfWoLs1RzFEHvZjytCSs0EssMTlwqJHGRBMlKP4Kxb37TiHsnryPSuvaNczvopSzhewdPpZI2pIL5t7rXW87HgIwTpa0lY9b5/j3q01SQu+ZaPTrtfE4SzDbjXwB185jRSt2XYqHG2lN5+m3MK8svJF/7OwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764814901; c=relaxed/simple;
	bh=xjyl30mUFsDDunvEK7Sr/1lpXabunxBNQdKAfCZagm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaSJg2irG6PpXLhcBNL0XWWDU1YkHYHWR6Sxy4LReMHfAQ7juI944xevkcz8Pa4axllt0Z23iga9qNr5Ju5s0hHWJWILrvYBlPM4ysn8Ph4FbDmeOiQFw0t3RrME5eAWXIXMXoJzbr1Yp/9hWWJIvI25XT7J5ZWRGtkqJ78Gw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgd4kThe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764814900; x=1796350900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xjyl30mUFsDDunvEK7Sr/1lpXabunxBNQdKAfCZagm8=;
  b=fgd4kTheE2dLbVafWAPZ/az4hxBCYaeH3hr5+LNvCe2eWitGjM5xc1AX
   phqlvvqHTiFiyNo9sIU8mEB3CLqkebTZbamsBAyX9fHG8zCTNIgFv0ISt
   pghWQCyeQXxd9M82MqFEfrHuDC5zlT2G3hw4dkahquF57MTirXIjTdJip
   E2iLI6WoASDVyyhbJqL0Kqec3SXNTpdPzUJtn+iThyXLYgwbIeJ6k3Kxg
   TFNtuzG8QjcezhB3i3med9sLN42KckJ8xUCpKp98u95D2JCYP5c6YTg8x
   IGGbbRHRCXRO8h9CCDh1fTQRoIuh72SNoMD9D3y0M1GmnUxdGIu2j42fo
   A==;
X-CSE-ConnectionGUID: nMdSLmB1Q/qjHoBtMA2vWQ==
X-CSE-MsgGUID: pbqZDoGaR0enXp/JrxkVLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77508656"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="77508656"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 18:21:40 -0800
X-CSE-ConnectionGUID: iCDuahsbSMakzL/Dympfjw==
X-CSE-MsgGUID: xn27NTa0R92IAjlzuhjoIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="225802556"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa001.fm.intel.com with ESMTP; 03 Dec 2025 18:21:36 -0800
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
	Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH 4/6] cxl/mem: Convert devm_cxl_add_memdev() to scope-based-cleanup
Date: Wed,  3 Dec 2025 18:21:34 -0800
Message-ID: <20251204022136.2573521-5-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251204022136.2573521-1-dan.j.williams@intel.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
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
Cc: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c | 58 +++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 7a4153e1c6a7..d0efc9ceda2a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1050,6 +1050,33 @@ static const struct file_operations cxl_memdev_fops = {
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
 /*
  * Core helper for devm_cxl_add_memdev() that wants to both create a device and
  * assert to the caller that upon return cxl_mem::probe() has been invoked.
@@ -1057,45 +1084,28 @@ static const struct file_operations cxl_memdev_fops = {
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
+		return ERR_PTR(rc);
 
-	cdev = &cxlmd->cdev;
-	rc = cdev_device_add(cdev, dev);
+	rc = cxlmd_add(cxlmd, cxlds);
 	if (rc)
-		goto err;
+		return ERR_PTR(rc);
 
-	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
+	rc = devm_add_action_or_reset(host, cxl_memdev_unregister,
+				      no_free_ptr(cxlmd));
 	if (rc)
 		return ERR_PTR(rc);
 	return cxlmd;
-
-err:
-	/*
-	 * The cdev was briefly live, shutdown any ioctl operations that
-	 * saw that state.
-	 */
-	cxl_memdev_shutdown(dev);
-	put_device(dev);
-	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_FOR_MODULES(__devm_cxl_add_memdev, "cxl_mem");
 
-- 
2.51.1


