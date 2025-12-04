Return-Path: <linux-pci+bounces-42606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2A6CA22A6
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 03:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0EF33028515
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 02:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2DA2638BC;
	Thu,  4 Dec 2025 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJ5OKXi9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12445246778;
	Thu,  4 Dec 2025 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764814908; cv=none; b=SKMRqozuOFGH5LxjRQw1W0fd/UQINX4MyMDfmrIoycCFxbESsXVhwQ6dWXGx1YZp3uTQqcBBZ+EU0EgmvKoNQVLFRJTHeJnmeuGOeP+h7UmykmUSJIV7bogF4OQ0JpoKIZvrlTjLsj+6L3HxzJqHOr34OV/KKGOcTassfefUipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764814908; c=relaxed/simple;
	bh=dhRnMWJVTTaMotmEjQQ0wdNyIvt6Le1YRaYPaaQCU5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srGbzfZyTq7JloyhVYnmINgDOuPkhYgHIsx72ekJlpMIUYrp1Tk2OCHQ0AT5qbGPyXAczORXG4WeGzB9pRoZMwTqd2NJqLYXaqUAzhtt26lv2nGDTFyIsXplpzeOuUju6NjYl7ZZARdpvTH13nTx0e18ikMJi9/hYLWZD7lxRsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJ5OKXi9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764814907; x=1796350907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dhRnMWJVTTaMotmEjQQ0wdNyIvt6Le1YRaYPaaQCU5c=;
  b=XJ5OKXi9Hh0Xc0BVeXspa7QcoyGEFgsEUXx054m1rcQsHqpHvgHVwABw
   lIbT9PmsvnEBre8noyNrweWdBYd/t7JOnu7mBWiuGhlIUJa49lDMpk78b
   tmnyfoq5uKRq0iik/jtWq4SEIrJxjdFNiYyjvJ+79+0yJCRDubT0QEjQh
   zPlohkyzeprThnnDpuulEnZAJ4THDS6640BlLS/zT//7m1eQRL5A/LEDf
   am2rEzLPIQ7zgEvB5XWpe6Aqbflr9ZkkqpsBz91jbbryvreBOwyepij02
   XghWmECgEDUYnI4Y5WJYrPCY0CjafN6Z+yf4MU+7lSas04+BWymX0ruiC
   Q==;
X-CSE-ConnectionGUID: +JDBXtgRQS2WO4hOSycV4g==
X-CSE-MsgGUID: chkHcNE6Tiu4rTaUV6Qnyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77508665"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="77508665"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 18:21:46 -0800
X-CSE-ConnectionGUID: oexLYP4lRJyiD2MrUBSLrg==
X-CSE-MsgGUID: IKWK40WqQmiqkJUwCO65NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="225802573"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa001.fm.intel.com with ESMTP; 03 Dec 2025 18:21:43 -0800
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
Subject: [PATCH 6/6] cxl/mem: Introduce a memdev creation ->probe() operation
Date: Wed,  3 Dec 2025 18:21:36 -0800
Message-ID: <20251204022136.2573521-7-dan.j.williams@intel.com>
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

Allow for a driver to pass a routine to be called in cxl_mem_probe()
context. This ability is inspired by and mirrors the semantics of
faux_device_create(). It allows for the caller to run CXL-topology
attach-dependent logic on behalf of the caller.

This capability is needed for CXL accelerator device drivers that need to
make decisions about enabling CXL dependent functionality in the device, or
falling back to PCIe-only operation.

The probe callback runs after the port topology is successfully attached
for the given memdev.

Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxlmem.h         | 12 ++++++++--
 drivers/cxl/core/memdev.c    | 46 +++++++++++++++++++++++++++++-------
 drivers/cxl/mem.c            | 12 ++++++++--
 drivers/cxl/pci.c            |  2 +-
 tools/testing/cxl/test/mem.c |  2 +-
 5 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 9db31c7993c4..ed759f88b21f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -34,6 +34,10 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
+struct cxl_memdev_ops {
+	int (*probe)(struct cxl_memdev *cxlmd);
+};
+
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
@@ -43,6 +47,7 @@
  * @cxl_nvb: coordinate removal of @cxl_nvd if present
  * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
  * @endpoint: connection to the CXL port topology for this memory device
+ * @ops: incremental caller specific probe routine
  * @id: id number of this memdev instance.
  * @depth: endpoint port depth
  * @scrub_cycle: current scrub cycle set for this device
@@ -59,6 +64,7 @@ struct cxl_memdev {
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_nvdimm *cxl_nvd;
 	struct cxl_port *endpoint;
+	const struct cxl_memdev_ops *ops;
 	int id;
 	int depth;
 	u8 scrub_cycle;
@@ -95,8 +101,10 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
+struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
+					 const struct cxl_memdev_ops *ops);
+struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
+				       const struct cxl_memdev_ops *ops);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 7d85ba25835a..41f1964d8cbf 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -648,7 +648,8 @@ static void detach_memdev(struct work_struct *work)
 static struct lock_class_key cxl_memdev_key;
 
 static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
-					   const struct file_operations *fops)
+					   const struct file_operations *fops,
+					   const struct cxl_memdev_ops *ops)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
@@ -664,6 +665,8 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 		goto err;
 	cxlmd->id = rc;
 	cxlmd->depth = -1;
+	cxlmd->ops = ops;
+	cxlmd->endpoint = ERR_PTR(-ENXIO);
 
 	dev = &cxlmd->dev;
 	device_initialize(dev);
@@ -1077,17 +1080,48 @@ static int cxlmd_add(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
 DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
 	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev);)
 
+static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
+{
+	struct cxl_memdev *ret = cxlmd;
+	int rc;
+
+	/*
+	 * If ops is provided fail if the driver is not attached upon
+	 * return. The ->endpoint ERR_PTR may have a more precise error
+	 * code to convey. Note that failure here could be the result of
+	 * a race to teardown the CXL port topology. I.e.
+	 * cxl_mem_probe() could have succeeded and then cxl_mem unbound
+	 * before the lock is acquired.
+	 */
+	guard(device)(&cxlmd->dev);
+	if (cxlmd->ops && !cxlmd->dev.driver) {
+		ret = ERR_PTR(-ENXIO);
+		if (IS_ERR(cxlmd->endpoint))
+			ret = ERR_CAST(cxlmd->endpoint);
+		cxl_memdev_unregister(cxlmd);
+		return ret;
+	}
+
+	rc = devm_add_action_or_reset(cxlmd->cxlds->dev, cxl_memdev_unregister,
+				      cxlmd);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return ret;
+}
+
 /*
  * Core helper for devm_cxl_add_memdev() that wants to both create a device and
  * assert to the caller that upon return cxl_mem::probe() has been invoked.
  */
-struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
+struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
+					 const struct cxl_memdev_ops *ops)
 {
 	struct device *dev;
 	int rc;
 
 	struct cxl_memdev *cxlmd __free(put_cxlmd) =
-		cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
+		cxl_memdev_alloc(cxlds, &cxl_memdev_fops, ops);
 	if (IS_ERR(cxlmd))
 		return cxlmd;
 
@@ -1100,11 +1134,7 @@ struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	if (rc)
 		return ERR_PTR(rc);
 
-	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister,
-				      no_free_ptr(cxlmd));
-	if (rc)
-		return ERR_PTR(rc);
-	return cxlmd;
+	return cxl_memdev_autoremove(no_free_ptr(cxlmd));
 }
 EXPORT_SYMBOL_FOR_MODULES(__devm_cxl_add_memdev, "cxl_mem");
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 677996c65272..d61f121c6f97 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -142,6 +142,12 @@ static int cxl_mem_probe(struct device *dev)
 			return rc;
 	}
 
+	if (cxlmd->ops) {
+		rc = cxlmd->ops->probe(cxlmd);
+		if (rc)
+			return rc;
+	}
+
 	rc = devm_cxl_memdev_edac_register(cxlmd);
 	if (rc)
 		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
@@ -166,6 +172,7 @@ static int cxl_mem_probe(struct device *dev)
 /**
  * devm_cxl_add_memdev - Add a CXL memory device
  * @cxlds: CXL device state to associate with the memdev
+ * @ops: optional operations to run in cxl_mem::{probe,remove}() context
  *
  * Upon return the device will have had a chance to attach to the
  * cxl_mem driver, but may fail if the CXL topology is not ready
@@ -174,9 +181,10 @@ static int cxl_mem_probe(struct device *dev)
  * The parent of the resulting device and the devm context for allocations is
  * @cxlds->dev.
  */
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
+struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
+				       const struct cxl_memdev_ops *ops)
 {
-	return __devm_cxl_add_memdev(cxlds);
+	return __devm_cxl_add_memdev(cxlds, ops);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1c6fc5334806..549368a9c868 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1006,7 +1006,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
 
-	cxlmd = devm_cxl_add_memdev(cxlds);
+	cxlmd = devm_cxl_add_memdev(cxlds, NULL);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 8a22b7601627..cb87e8c0e63c 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1767,7 +1767,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 
 	cxl_mock_add_event_logs(&mdata->mes);
 
-	cxlmd = devm_cxl_add_memdev(cxlds);
+	cxlmd = devm_cxl_add_memdev(cxlds, NULL);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-- 
2.51.1


