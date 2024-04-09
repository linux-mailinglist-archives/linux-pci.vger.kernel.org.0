Return-Path: <linux-pci+bounces-5953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4D189DFF7
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 18:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA061F213DC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 16:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494413D88E;
	Tue,  9 Apr 2024 16:03:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39010137C4B;
	Tue,  9 Apr 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678581; cv=none; b=d3aIP8BBC4Th6wVS3Z/UyqI3RPBc3oBmwChhn7Uis/aiYEYC4odGDgfx6mzGnilTo7ITr4iiOQaaSL4HpkYa8II4npMpbzR3Axp1ZSALE9iFgQw133xxPVqQ9+5Y1eWIfD9Xzc5yerFO2dRg/Jpm4iS8boxLtrcJtOCgnyXs5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678581; c=relaxed/simple;
	bh=mA+sU05JoMmTiNgM3hHSVkqRK59ibDyVx+FChXurszA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URsDlPMikQEAYaU9pUO6CPtNDfWQ5W+ODF/7+e3auwQPBPZG57/vWvQ1eNQBBp6VeINPLGdAHri1BweWCSMyqeUQO+4cK4ySAginsU+Usc4gkigdmfO9uXNIHJiEZOxSnICOm46YgoGzW3/wctZceEby3KAmTXAU7SgGGgO5Omw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5FCC433A6;
	Tue,  9 Apr 2024 16:03:00 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	bhelgaas@google.com,
	lukas@wunner.de,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v4 1/4] PCI/cxl: Move PCI CXL vendor Id to a common location from CXL subsystem
Date: Tue,  9 Apr 2024 09:01:14 -0700
Message-ID: <20240409160256.94184-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409160256.94184-1-dave.jiang@intel.com>
References: <20240409160256.94184-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move PCI_DVSEC_VENDOR_ID_CXL in CXL private code to PCI_VENDOR_ID_CXL in
pci_ids.h in order to be utilized in PCI subsystem.

The response Bjorn received from the PCI SIG was "1E98h is not a VID in our
system, but 1E98 has already been reserved by CXL." He suggested "we should
add '#define PCI_VENDOR_ID_CXL 0x1e98' so that if we ever *do* see such an
assignment, we'll be more likely to flag it as an issue.

Link: https://lore.kernel.org/linux-cxl/20240402172323.GA1818777@bhelgaas/
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c  | 6 +++---
 drivers/cxl/core/regs.c | 2 +-
 drivers/cxl/cxlpci.h    | 1 -
 drivers/cxl/pci.c       | 2 +-
 drivers/perf/cxl_pmu.c  | 2 +-
 include/linux/pci_ids.h | 2 ++
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0df09bd79408..c496a9710d62 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -525,7 +525,7 @@ static int cxl_cdat_get_length(struct device *dev,
 	__le32 response[2];
 	int rc;
 
-	rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
+	rc = pci_doe(doe_mb, PCI_VENDOR_ID_CXL,
 		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
 		     &request, sizeof(request),
 		     &response, sizeof(response));
@@ -555,7 +555,7 @@ static int cxl_cdat_read_table(struct device *dev,
 		__le32 request = CDAT_DOE_REQ(entry_handle);
 		int rc;
 
-		rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
+		rc = pci_doe(doe_mb, PCI_VENDOR_ID_CXL,
 			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
 			     &request, sizeof(request),
 			     rsp, sizeof(*rsp) + remaining);
@@ -640,7 +640,7 @@ void read_cdat_data(struct cxl_port *port)
 	if (!pdev)
 		return;
 
-	doe_mb = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+	doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_CXL,
 				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
 	if (!doe_mb) {
 		dev_dbg(dev, "No CDAT mailbox\n");
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 372786f80955..da52fc9e234b 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -313,7 +313,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 		.resource = CXL_RESOURCE_NONE,
 	};
 
-	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
 					   CXL_DVSEC_REG_LOCATOR);
 	if (!regloc)
 		return -ENXIO;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 93992a1c8eec..4da07727ab9c 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -13,7 +13,6 @@
  * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
  */
 #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
-#define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
 
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..110478573296 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -817,7 +817,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	cxlds->rcd = is_cxl_restricted(pdev);
 	cxlds->serial = pci_get_dsn(pdev);
 	cxlds->cxl_dvsec = pci_find_dvsec_capability(
-		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
+		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
 	if (!cxlds->cxl_dvsec)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 308c9969642e..a1b742b1a735 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -345,7 +345,7 @@ static ssize_t cxl_pmu_event_sysfs_show(struct device *dev,
 
 /* For CXL spec defined events */
 #define CXL_PMU_EVENT_CXL_ATTR(_name, _gid, _msk)			\
-	CXL_PMU_EVENT_ATTR(_name, PCI_DVSEC_VENDOR_ID_CXL, _gid, _msk)
+	CXL_PMU_EVENT_ATTR(_name, PCI_VENDOR_ID_CXL, _gid, _msk)
 
 static struct attribute *cxl_pmu_event_attrs[] = {
 	CXL_PMU_EVENT_CXL_ATTR(clock_ticks,			CXL_PMU_GID_CLOCK_TICKS, BIT(0)),
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a0c75e467df3..7dfbf6d96b3d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2607,6 +2607,8 @@
 
 #define PCI_VENDOR_ID_ALIBABA		0x1ded
 
+#define PCI_VENDOR_ID_CXL		0x1e98
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.44.0


