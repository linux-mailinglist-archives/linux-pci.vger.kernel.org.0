Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39F32AE84E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 06:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgKKFoo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 00:44:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:54150 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgKKFoH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 00:44:07 -0500
IronPort-SDR: Gn52N7/v4HVmeOcNx/VTWozOXjE+nFcEBV3BMOiGgUQnu8+fYMwh9/tZBqE0Fu8xXubLS8rlAA
 XC6mOlIGjAiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="149372962"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="149372962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:44:05 -0800
IronPort-SDR: y+L7DoqIphxCfgbmHMu89ucgdp18Wkpq5lLB1IOm/8A8IMmV0QO3615+uwLRN+SgFXL5NsWGbF
 5JoKjMFRp7Og==
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="360414751"
Received: from hccoutan-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.131.159])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:44:04 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [RFC PATCH 4/9] cxl/mem: Map memory device registers
Date:   Tue, 10 Nov 2020 21:43:51 -0800
Message-Id: <20201111054356.793390-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111054356.793390-1-ben.widawsky@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All the necessary bits are initialized in order to find and map the
register space for CXL Memory Devices. This is accomplished by using the
Register Locator DVSEC (CXL 2.0 - 8.1.9.1) to determine which PCI BAR to
use, and how much of an offset from that BAR should be added.

If the memory device registers are found and mapped a new internal data
structure tracking device state is allocated.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 68 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/cxl/pci.h |  6 +++++
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index aa7d881fa47b..8d9b9ab6c5ea 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -7,9 +7,49 @@
 #include "pci.h"
 
 struct cxl_mem {
+	struct pci_dev *pdev;
 	void __iomem *regs;
 };
 
+static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi)
+{
+	struct device *dev = &pdev->dev;
+	struct cxl_mem *cxlm;
+	void __iomem *regs;
+	u64 offset;
+	u8 bar;
+	int rc;
+
+	offset = ((u64)reg_hi << 32) | (reg_lo & 0xffff0000);
+	bar = reg_lo & 0x7;
+
+	/* Basic sanity check that BAR is big enough */
+	if (pci_resource_len(pdev, bar) < offset) {
+		dev_err(dev, "bar%d: %pr: too small (offset: %#llx)\n",
+				bar, &pdev->resource[bar], (unsigned long long) offset);
+		return ERR_PTR(-ENXIO);
+	}
+
+	rc = pcim_iomap_regions(pdev, 1 << bar, pci_name(pdev));
+	if (rc != 0) {
+		dev_err(dev, "failed to map registers\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
+	if (!cxlm) {
+		dev_err(dev, "No memory available\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	regs = pcim_iomap_table(pdev)[bar];
+	cxlm->pdev = pdev;
+	cxlm->regs = regs + offset;
+
+	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
+	return cxlm;
+}
+
 static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 {
 	int pos;
@@ -34,9 +74,9 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 
 static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct cxl_mem *cxlm = ERR_PTR(-ENXIO);
 	struct device *dev = &pdev->dev;
-	struct cxl_mem *cxlm;
-	int rc, regloc;
+	int rc, regloc, i;
 
 	rc = cxl_bus_prepared(pdev);
 	if (rc != 0) {
@@ -44,15 +84,33 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 	}
 
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
 	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
 	if (!regloc) {
 		dev_err(dev, "register location dvsec not found\n");
 		return -ENXIO;
 	}
+	regloc += 0xc; /* Skip DVSEC + reserved fields */
+
+	for (i = regloc; i < regloc + 0x24; i += 8) {
+		u32 reg_lo, reg_hi;
+
+		pci_read_config_dword(pdev, i, &reg_lo);
+		pci_read_config_dword(pdev, i + 4, &reg_hi);
+
+		if (CXL_REGLOG_IS_MEMDEV(reg_lo)) {
+			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
+			break;
+		}
+	}
+
+	if (IS_ERR(cxlm))
+		return -ENXIO;
 
-	cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
-	if (!cxlm)
-		return -ENOMEM;
+	pci_set_drvdata(pdev, cxlm);
 
 	return 0;
 }
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index beb03921e6da..be87f62e9132 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -12,4 +12,10 @@
 #define PCI_DVSEC_ID_CXL	0x0
 #define PCI_DVSEC_ID_CXL_REGLOC	0x8
 
+#define CXL_REGLOG_RBI_EMPTY 0
+#define CXL_REGLOG_RBI_COMPONENT 1
+#define CXL_REGLOG_RBI_VIRT 2
+#define CXL_REGLOG_RBI_MEMDEV 3
+#define CXL_REGLOG_IS_MEMDEV(x) ((((x) >> 8) & 0xff) == CXL_REGLOG_RBI_MEMDEV)
+
 #endif /* __CXL_PCI_H__ */
-- 
2.29.2

