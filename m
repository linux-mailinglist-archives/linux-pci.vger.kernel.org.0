Return-Path: <linux-pci+bounces-42605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B940CA2291
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 03:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6FEB3005D2A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 02:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E461B26056C;
	Thu,  4 Dec 2025 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGPiy0M/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB2018D636;
	Thu,  4 Dec 2025 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764814905; cv=none; b=OJiwWhvFTnJY7sSRdZgdSCOs4ZBYRGM+a3VXU1AkIWC5luBkBrSovhfO63Oavxmj2K5vSFDLoqkhvFfcoR8H5HnhFjebn/tbxUFKrcAXG/AR7kRL3BoBVbpkoJ8qaPjzb/0U/rjprFBJS0uhgO7CQ5d/nvNvOZmXx4t6Xg9CU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764814905; c=relaxed/simple;
	bh=wqbpmCjeg3EVye2mFzccYeKbLMXEYvrRQ0gh9sxI6HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pg7kl37AB2Vs/HNc3rjfX2hrVmZ5liBnqpdyS9EV+bRxA7H7Po46vBazjVH3TzcRgbDRX691wEdlTOoFrjsfFdb9fyfAa+5sBKOcdgynvRqXLXm/Nxg/Xf2YSDl0NSnZ4RFZNuLy7wT6v0+u4XVxEyVrNA2R1A4CW1J24Nt2K0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGPiy0M/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764814904; x=1796350904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wqbpmCjeg3EVye2mFzccYeKbLMXEYvrRQ0gh9sxI6HA=;
  b=MGPiy0M/M4Q0fzDdd7lPRPv9UqEbO241nbzzpL5x3AAOj2HLBlF7iUtF
   KGZaj4eClsI7VSAq+6miMOVOH4DmAy5GmGW91B69MNgE/F7781IeyrO7O
   33dBW/XdfsHAej1SsBFJcofkw/+2jP5p1IgEUGaAzEBq33Lqclx4umCWg
   uCBTzljMjwUdZOyFeVg99kAOIx6Yb3CNqzrcjS3p6tNVh3Yvo+RN7Jpnx
   hGq+SZgfDklaJrnSpK0WJUDU693N1Ir5Gb1xMn600DwjgtxQ3SR6JiBrR
   /NTEzHE9pnNUCve1iCZ9JOGzOIACQ4BWoRR0u72ypw6oJXE3b1+kumWdr
   A==;
X-CSE-ConnectionGUID: GVojQCzhQFGK0KwpNymcyg==
X-CSE-MsgGUID: N3fVe7mxT8uHSrGcZzgnxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77508661"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="77508661"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 18:21:43 -0800
X-CSE-ConnectionGUID: TCTCj6HfRnCIWeNcsGk+iQ==
X-CSE-MsgGUID: e/+og3qTREqcp0W1i93A+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="225802564"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa001.fm.intel.com with ESMTP; 03 Dec 2025 18:21:40 -0800
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
Subject: [PATCH 5/6] cxl/mem: Drop @host argument to devm_cxl_add_memdev()
Date: Wed,  3 Dec 2025 18:21:35 -0800
Message-ID: <20251204022136.2573521-6-dan.j.williams@intel.com>
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

In all cases the device that created the 'struct cxl_dev_state' instance is
also the device to host the devm cleanup of devm_cxl_add_memdev(). This
simplifies the function prototype, and limits a degree of freedom of the
API.

Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxlmem.h         | 6 ++----
 drivers/cxl/core/memdev.c    | 5 ++---
 drivers/cxl/mem.c            | 9 +++++----
 drivers/cxl/pci.c            | 2 +-
 tools/testing/cxl/test/mem.c | 2 +-
 5 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 012e68acad34..9db31c7993c4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -95,10 +95,8 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
-					 struct cxl_dev_state *cxlds);
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds);
+struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
+struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index d0efc9ceda2a..7d85ba25835a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1081,8 +1081,7 @@ DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
  * Core helper for devm_cxl_add_memdev() that wants to both create a device and
  * assert to the caller that upon return cxl_mem::probe() has been invoked.
  */
-struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
-					 struct cxl_dev_state *cxlds)
+struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
 	struct device *dev;
 	int rc;
@@ -1101,7 +1100,7 @@ struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
 	if (rc)
 		return ERR_PTR(rc);
 
-	rc = devm_add_action_or_reset(host, cxl_memdev_unregister,
+	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister,
 				      no_free_ptr(cxlmd));
 	if (rc)
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index d62931526fd4..677996c65272 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -165,17 +165,18 @@ static int cxl_mem_probe(struct device *dev)
 
 /**
  * devm_cxl_add_memdev - Add a CXL memory device
- * @host: devres alloc/release context and parent for the memdev
  * @cxlds: CXL device state to associate with the memdev
  *
  * Upon return the device will have had a chance to attach to the
  * cxl_mem driver, but may fail if the CXL topology is not ready
  * (hardware CXL link down, or software platform CXL root not attached)
+ *
+ * The parent of the resulting device and the devm context for allocations is
+ * @cxlds->dev.
  */
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds)
+struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
-	return __devm_cxl_add_memdev(host, cxlds);
+	return __devm_cxl_add_memdev(cxlds);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0be4e508affe..1c6fc5334806 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1006,7 +1006,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
 
-	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
+	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 176dcde570cd..8a22b7601627 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1767,7 +1767,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 
 	cxl_mock_add_event_logs(&mdata->mes);
 
-	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
+	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-- 
2.51.1


