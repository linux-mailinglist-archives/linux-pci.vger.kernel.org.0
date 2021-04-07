Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696973577B1
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 00:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhDGW1Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 18:27:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:14331 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229830AbhDGW1P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 18:27:15 -0400
IronPort-SDR: uUTE5S0JR5LavUcoC3Z3dKFerghBmsoSSXFHhxLyaD7pQGtaxdojyy8oHuTyr7TMGTMfLzkhNZ
 BvQ+DH7Q6xgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193524933"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="193524933"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:40 -0700
IronPort-SDR: dNHa0MOT1sReN41KYCAdZKPnlccO+W8MxQB87GzVASQfR56+bXSuo5naYNAqHVKte7lW8BJjfJ
 SE+CHQgOxdJQ==
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="458548554"
Received: from hmfaraby-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.128.243])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:39 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] cxl/mem: Create a helper to setup device regs
Date:   Wed,  7 Apr 2021 15:26:24 -0700
Message-Id: <20210407222625.320177-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407222625.320177-1-ben.widawsky@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Memory devices have a list of required register regions within the
register block, but this isn't required of all CXL components or
devices. To make things more tidy, and allow for easily setting up other
block types in this loop, the helper is introduced.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 49f651694cb0..b7342aaf38c4 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -974,6 +974,24 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 	return 0;
 }
 
+static int __cxl_setup_device_regs(struct cxl_mem *cxlm, void __iomem *base)
+{
+	struct cxl_regs *regs = &cxlm->regs;
+	struct pci_dev *pdev = cxlm->pdev;
+	struct device *dev = &pdev->dev;
+
+	cxl_setup_device_regs(dev, base, &regs->device_regs);
+	if (!regs->status || !regs->mbox || !regs->memdev) {
+		dev_err(dev, "registers not found: %s%s%s\n",
+				!regs->status ? "status " : "",
+				!regs->mbox ? "mbox " : "",
+				!regs->memdev ? "memdev" : "");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 /**
  * cxl_mem_setup_regs() - Setup necessary MMIO.
  * @cxlm: The CXL memory device to communicate with.
@@ -986,12 +1004,11 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
  */
 static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 {
-	struct cxl_regs *regs = &cxlm->regs;
 	struct pci_dev *pdev = cxlm->pdev;
 	struct device *dev = &pdev->dev;
 	u32 regloc_size, regblocks;
 	void __iomem *base;
-	int regloc, i;
+	int regloc, i, rc;
 
 	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
 	if (!regloc) {
@@ -1021,23 +1038,14 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 			if (IS_ERR(base))
 				return PTR_ERR(base);
 
-			cxl_setup_device_regs(dev, base, &regs->device_regs);
-			if (!regs->status || !regs->mbox || !regs->memdev) {
-				dev_err(dev, "registers not found: %s%s%s\n",
-						!regs->status ? "status " : "",
-						!regs->mbox ? "mbox " : "",
-						!regs->memdev ? "memdev" : "");
-				return -ENXIO;
-			}
+			rc = __cxl_setup_device_regs(cxlm, base);
+			if (rc)
+				return rc;
+
 			break;
 		}
 	}
 
-	if (i == regblocks) {
-		dev_err(dev, "Missing register locator for device registers\n");
-		return -ENXIO;
-	}
-
 	return 0;
 }
 
-- 
2.31.1

