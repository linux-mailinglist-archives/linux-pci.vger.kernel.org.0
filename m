Return-Path: <linux-pci+bounces-6813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3B58B65CC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 00:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729A21F227A2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 22:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0779E18C1F;
	Mon, 29 Apr 2024 22:36:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD580364;
	Mon, 29 Apr 2024 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430177; cv=none; b=AQ2JzAbz1vdoO2GINi/aVDyvR+3fVnQo6ERHQoQQQJE1QBLloTy3RemjQKo7yr+N4s28iVYOu4LHQQuXgwypw1hOAMmr36XPP7QV8CfxAekrLliOwo4eJWziaApffS+KVqZ3/yEAIoR7AmY9qem031axl+l9hhnlYwn2qBiGEOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430177; c=relaxed/simple;
	bh=nUosDTkxM1hNQQbrzMAt6a4sFj7E6e81s2FqlA5y06Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+agecncDlWBcB2yYiJU4aD/RsRRGj4hV9aitat9iprdn31bvaSQohW7Bb4IihP30WZ+O7h1diJxi/axx82O0aYu9JQ6m7O8ixC1goBKAggloHexSCEeYdjqwlTE4huYoPuPP+vs7d65Ir3w0VmLdMAGWfCDezo/lUKZtnUypnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2D8C4AF1D;
	Mon, 29 Apr 2024 22:36:17 +0000 (UTC)
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
	Bjorn Helgaas <helgaas@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v5 1/4] PCI/cxl: Move PCI CXL vendor Id to a common location from CXL subsystem
Date: Mon, 29 Apr 2024 15:35:29 -0700
Message-ID: <20240429223610.1341811-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429223610.1341811-1-dave.jiang@intel.com>
References: <20240429223610.1341811-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move PCI_DVSEC_VENDOR_ID_CXL in CXL private code to PCI_VENDOR_ID_CXL in
pci_ids.h in order to be utilized in PCI subsystem.

When uplevelling PCI_DVSEC_VENDOR_ID_CXL to a common locatoin Bjorn
suggested making it a proper PCI_VENDOR_ID_* define in
include/linux/pci_ids.h. While it is not in the PCI IDs database it is a
reserved value and Linux treats it as a 'vendor id' for all intents and
purposes [1].

Link: https://lore.kernel.org/linux-cxl/20240402172323.GA1818777@bhelgaas/
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Improve commit log. (Dan)
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
index 3c42f984eeaf..e1082e749c69 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -314,7 +314,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
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


