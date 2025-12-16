Return-Path: <linux-pci+bounces-43077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C25CDCC0648
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 01:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B78930047EB
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 00:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE602BCF4A;
	Tue, 16 Dec 2025 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meZ9zK3B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7139B2248B8;
	Tue, 16 Dec 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846539; cv=none; b=aeDeX6RnR/yK1m8Tpn3U77ehcqhiCm7Qf4iFUkTWoW85v/IoDdl5fynZl7sP+tUvsi/H4ry0XFrNFmrzMJNlQuPukYHJLsl6huONzK/oRUmOnlTi9WNeKRicpcHnsp+V8Wipq3RksdItVoi/XSbR73otma5oyQpWaBnGxspu4Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846539; c=relaxed/simple;
	bh=mQWplLegDxIK0Nc6SI+GBREhDsJR//DTXIHztZu4EWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMlOu7grNoRHRqyVABi17rvdoL6vcVmxy2fXFC/ZBo7xj8tVImfk05R8AWPolPlpz3rV0SR3en0H9WypvjfVXnpC/7CA5k+loihJR9zfeh4cNH+WHj8Lx6b6f3O0B0SIfcxYJno0Vs8xwce3BfZR5KjWcO+SApEEfeC7AUnwk3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meZ9zK3B; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765846537; x=1797382537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mQWplLegDxIK0Nc6SI+GBREhDsJR//DTXIHztZu4EWw=;
  b=meZ9zK3BPvEmYN4s4IbD4Z3XMXc1zPXf25xGpEqcm1Yi4aMpmE1S0uvs
   BWJ28Uc2eAfvIoSQcgXB++r5fbK04WJaZEtxUSZr50tXCCMreFGpqy7BD
   XdxRKvmN2O3pCkV3pseWNsAvGIX4NuXQDyfkoNiDAXuWYqAEosZXYvFsN
   GobocOsVRwtF5ozCLKFHhN4MPNgxy5mSFkSUBp0b9Zw8KFp4qUaHcQmPd
   idzErAvpL6ZaEwQMmXHYTaxNwYcg0AK+z7rdUGU4dS/kByrsJEZ55b3gS
   EsZT7f2bhcP6mDfizevj1B1t9hhoEcoiVoAeSnGcfEf4tWziYFfsV3Qnh
   Q==;
X-CSE-ConnectionGUID: Bja5M+AbTwGj854FlvAMaQ==
X-CSE-MsgGUID: Mjx/sKrwQWOrKg8/JiqruQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79215490"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="79215490"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 16:55:34 -0800
X-CSE-ConnectionGUID: Ha5UA8z2Sf2UsVN8uACKYg==
X-CSE-MsgGUID: +IdhYi7bT72lAjXOAAuCYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="198131546"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa008.fm.intel.com with ESMTP; 15 Dec 2025 16:55:33 -0800
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
Subject: [PATCH v2 6/6] cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation
Date: Mon, 15 Dec 2025 16:56:16 -0800
Message-ID: <20251216005616.3090129-7-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251216005616.3090129-1-dan.j.williams@intel.com>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unlike the cxl_pci class driver that opportunistically enables memory
expansion with no other dependent functionality, CXL accelerator drivers
have distinct PCIe-only and CXL-enhanced operation states. If CXL is
available some additional coherent memory/cache operations can be enabled,
otherwise traditional DMA+MMIO over PCIe/CXL.io is a fallback.

Allow for a driver to pass a routine to be called in cxl_mem_probe()
context. This ability is inspired by and mirrors the semantics of
faux_device_create(). It allows for the caller to run CXL-topology
attach-dependent logic on behalf of the caller.

The probe callback runs after the port topology is successfully attached
for the given memdev.

Additionally the presence of @cxlmd->attach indicates that the accelerator
driver be detached when CXL operation ends. This conceptually makes a CXL
link loss event mirror a PCIe link loss event which results in triggering
the ->remove() callback of affected devices+drivers. A driver can re-attach
to recover back to PCIe-only operation. Live recovery, i.e. without a
->remove()/->probe() cycle, is left as a future consideration.

Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com> (✓ DKIM/intel.com)
Tested-by: Alejandro Lucero <alucerop@amd.com> (✓ DKIM/amd.com)
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxlmem.h         | 12 ++++++++++--
 drivers/cxl/core/memdev.c    | 33 +++++++++++++++++++++++++++++----
 drivers/cxl/mem.c            | 20 ++++++++++++++++----
 drivers/cxl/pci.c            |  2 +-
 tools/testing/cxl/test/mem.c |  2 +-
 5 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 9db31c7993c4..ef202b34e5ea 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -34,6 +34,10 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
+struct cxl_memdev_attach {
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
+ * @attach: creator of this memdev depends on CXL link attach to operate
  * @id: id number of this memdev instance.
  * @depth: endpoint port depth
  * @scrub_cycle: current scrub cycle set for this device
@@ -59,6 +64,7 @@ struct cxl_memdev {
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_nvdimm *cxl_nvd;
 	struct cxl_port *endpoint;
+	const struct cxl_memdev_attach *attach;
 	int id;
 	int depth;
 	u8 scrub_cycle;
@@ -95,8 +101,10 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
+struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
+					 const struct cxl_memdev_attach *attach);
+struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
+				       const struct cxl_memdev_attach *attach);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 63da2bd4436e..3ab4cd8f19ed 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -641,14 +641,24 @@ static void detach_memdev(struct work_struct *work)
 	struct cxl_memdev *cxlmd;
 
 	cxlmd = container_of(work, typeof(*cxlmd), detach_work);
-	device_release_driver(&cxlmd->dev);
+
+	/*
+	 * When the creator of @cxlmd sets ->attach it indicates CXL operation
+	 * is required. In that case, @cxlmd detach escalates to parent device
+	 * detach.
+	 */
+	if (cxlmd->attach)
+		device_release_driver(cxlmd->dev.parent);
+	else
+		device_release_driver(&cxlmd->dev);
 	put_device(&cxlmd->dev);
 }
 
 static struct lock_class_key cxl_memdev_key;
 
 static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
-					   const struct file_operations *fops)
+					   const struct file_operations *fops,
+					   const struct cxl_memdev_attach *attach)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
@@ -664,6 +674,8 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 		goto err;
 	cxlmd->id = rc;
 	cxlmd->depth = -1;
+	cxlmd->attach = attach;
+	cxlmd->endpoint = ERR_PTR(-ENXIO);
 
 	dev = &cxlmd->dev;
 	device_initialize(dev);
@@ -1081,6 +1093,18 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
 {
 	int rc;
 
+	/*
+	 * If @attach is provided fail if the driver is not attached upon
+	 * return. Note that failure here could be the result of a race to
+	 * teardown the CXL port topology. I.e. cxl_mem_probe() could have
+	 * succeeded and then cxl_mem unbound before the lock is acquired.
+	 */
+	guard(device)(&cxlmd->dev);
+	if (cxlmd->attach && !cxlmd->dev.driver) {
+		cxl_memdev_unregister(cxlmd);
+		return ERR_PTR(-ENXIO);
+	}
+
 	rc = devm_add_action_or_reset(cxlmd->cxlds->dev, cxl_memdev_unregister,
 				      cxlmd);
 	if (rc)
@@ -1093,13 +1117,14 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
  * Core helper for devm_cxl_add_memdev() that wants to both create a device and
  * assert to the caller that upon return cxl_mem::probe() has been invoked.
  */
-struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
+struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
+					 const struct cxl_memdev_attach *attach)
 {
 	struct device *dev;
 	int rc;
 
 	struct cxl_memdev *cxlmd __free(put_cxlmd) =
-		cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
+		cxl_memdev_alloc(cxlds, &cxl_memdev_fops, attach);
 	if (IS_ERR(cxlmd))
 		return cxlmd;
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 677996c65272..333c366b69e7 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -142,6 +142,12 @@ static int cxl_mem_probe(struct device *dev)
 			return rc;
 	}
 
+	if (cxlmd->attach) {
+		rc = cxlmd->attach->probe(cxlmd);
+		if (rc)
+			return rc;
+	}
+
 	rc = devm_cxl_memdev_edac_register(cxlmd);
 	if (rc)
 		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
@@ -166,17 +172,23 @@ static int cxl_mem_probe(struct device *dev)
 /**
  * devm_cxl_add_memdev - Add a CXL memory device
  * @cxlds: CXL device state to associate with the memdev
+ * @attach: Caller depends on CXL topology attachment
  *
  * Upon return the device will have had a chance to attach to the
- * cxl_mem driver, but may fail if the CXL topology is not ready
- * (hardware CXL link down, or software platform CXL root not attached)
+ * cxl_mem driver, but may fail to attach if the CXL topology is not ready
+ * (hardware CXL link down, or software platform CXL root not attached).
+ *
+ * When @attach is NULL it indicates the caller wants the memdev to remain
+ * registered even if it does not immediately attach to the CXL hierarchy. When
+ * @attach is provided a cxl_mem_probe() failure leads to failure of this routine.
  *
  * The parent of the resulting device and the devm context for allocations is
  * @cxlds->dev.
  */
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
+struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
+				       const struct cxl_memdev_attach *attach)
 {
-	return __devm_cxl_add_memdev(cxlds);
+	return __devm_cxl_add_memdev(cxlds, attach);
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


