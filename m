Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237AB416460
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 19:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbhIWR22 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 13:28:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:47623 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242543AbhIWR21 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Sep 2021 13:28:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211144814"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="211144814"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 10:26:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="704832548"
Received: from unknown (HELO bad-guy.kumite) ([10.252.132.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 10:26:54 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/9] cxl/pci: Make more use of cxl_register_map
Date:   Thu, 23 Sep 2021 10:26:43 -0700
Message-Id: <20210923172647.72738-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923172647.72738-1-ben.widawsky@intel.com>
References: <20210923172647.72738-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The structure exists to pass around information about register mapping.
Using it more extensively cleans up many existing functions.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h |  1 +
 drivers/cxl/pci.c | 36 +++++++++++++++++-------------------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7d6b011dd963..3b128ce71564 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -140,6 +140,7 @@ struct cxl_device_reg_map {
 };
 
 struct cxl_register_map {
+	void __iomem *base;
 	u64 block_offset;
 	u8 reg_type;
 	u8 barno;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bbbacbc94fbf..5eaf2736f779 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -306,35 +306,36 @@ static int cxl_pci_setup_mailbox(struct cxl_mem *cxlm)
 	return 0;
 }
 
-static void __iomem *cxl_pci_map_regblock(struct cxl_mem *cxlm,
-					  u8 bar, u64 offset)
+static int cxl_pci_map_regblock(struct cxl_mem *cxlm, struct cxl_register_map *map)
 {
-	void __iomem *addr;
+	int bar = map->barno;
 	struct device *dev = cxlm->dev;
 	struct pci_dev *pdev = to_pci_dev(dev);
+	resource_size_t offset = map->block_offset;
 
 	/* Basic sanity check that BAR is big enough */
 	if (pci_resource_len(pdev, bar) < offset) {
 		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
 			&pdev->resource[bar], (unsigned long long)offset);
-		return IOMEM_ERR_PTR(-ENXIO);
+		return -ENXIO;
 	}
 
-	addr = pci_iomap(pdev, bar, 0);
-	if (!addr) {
+	map->base = pci_iomap(pdev, bar, 0);
+	if (!map->base) {
 		dev_err(dev, "failed to map registers\n");
-		return addr;
+		return PTR_ERR(map->base);
 	}
 
 	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %#llx\n",
 		bar, offset);
 
-	return addr;
+	return 0;
 }
 
-static void cxl_pci_unmap_regblock(struct cxl_mem *cxlm, void __iomem *base)
+static void cxl_pci_unmap_regblock(struct cxl_mem *cxlm, struct cxl_register_map *map)
 {
-	pci_iounmap(to_pci_dev(cxlm->dev), base);
+	pci_iounmap(to_pci_dev(cxlm->dev), map->base);
+	map->base = 0;
 }
 
 static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
@@ -360,9 +361,9 @@ static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
 	return 0;
 }
 
-static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
-			  struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
 {
+	void __iomem *base = map->base + map->block_offset;
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
 	struct device *dev = cxlm->dev;
@@ -487,7 +488,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 
 	for (i = 0; i < ARRAY_SIZE(types); i++) {
 		struct cxl_register_map map;
-		void __iomem *base;
 
 		rc = find_register_block(pdev, types[i], &map);
 		if (rc) {
@@ -498,14 +498,12 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 			break;
 		}
 
-		base = cxl_pci_map_regblock(cxlm, map.barno, map.block_offset);
-		if (!base) {
-			rc = -ENOMEM;
+		rc = cxl_pci_map_regblock(cxlm, &map);
+		if (rc)
 			break;
-		}
 
-		rc = cxl_probe_regs(cxlm, base + map.block_offset, &map);
-		cxl_pci_unmap_regblock(cxlm, base);
+		rc = cxl_probe_regs(cxlm, &map);
+		cxl_pci_unmap_regblock(cxlm, &map);
 		if (rc)
 			break;
 
-- 
2.33.0

