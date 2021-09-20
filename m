Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4646410F93
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 08:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhITGnb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 02:43:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48790 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbhITGna (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 02:43:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18K6fnNH073492;
        Mon, 20 Sep 2021 01:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632120109;
        bh=/4Zz3FNlBeAefxVx1iflggGljsIGocoijkMKMEhCHa8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iFrTV5T69RG37DgBBAFe7S2cGN4k2Vo32OxbM4eQP8/OabfOLgi/XiEPBqxDUmThz
         b99kSHMwPSbdgeooIayfpomBASLh45lx4px5okM0UqQJpPgd6awTb5PYv3zHsbtX7f
         fKoG2BjNc/Ksa2G5FrkTSCIWv25mAD2dlkO0HQqw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18K6fnvh064834
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 01:41:49 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Sep 2021 01:41:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Sep 2021 01:41:48 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18K6fYa8015912;
        Mon, 20 Sep 2021 01:41:45 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 3/3] irqchip/gic-v3-its: Include "msi-map-mask" for calculating nvecs
Date:   Mon, 20 Sep 2021 12:11:33 +0530
Message-ID: <20210920064133.14115-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210920064133.14115-1-kishon@ti.com>
References: <20210920064133.14115-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Using "msi-map-mask" in device tree lets multiple PCIe requestor ID to
use the same GIC ITS device ID. So while creating the Interrupt
Translation Table (ITT) for a specific GIC ITS device ID, the total number
of interrupts required by all the PCIe requestor ID that maps to the
same GIC ITS device ID should be calculated

Add support for gic-v3-its to include "msi-map-mask" property in device
tree for calculating the total number of MSI interrupts in
its_pci_msi_prepare().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index ad2810c017ed..c79bca1a5787 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -54,9 +54,13 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
 static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 			       int nvec, msi_alloc_info_t *info)
 {
+	int alias_count = 0, map_count = 0, minnvec = 1, ret;
 	struct pci_dev *pdev, *alias_dev;
 	struct msi_domain_info *msi_info;
-	int alias_count = 0, minnvec = 1;
+	struct device *parent_dev;
+	struct pci_bus *root_bus;
+	struct device_node *np;
+	u32 map_mask, rid;
 
 	if (!dev_is_pci(dev))
 		return -EINVAL;
@@ -78,6 +82,21 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 		info->flags |= MSI_ALLOC_FLAGS_PROXY_DEVICE;
 	}
 
+	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
+		np = parent_dev->of_node;
+		if (!np)
+			continue;
+
+		ret = of_property_read_u32(np, "msi-map-mask", &map_mask);
+		if (!ret && map_mask != 0xffff) {
+			rid = pci_dev_id(pdev) & map_mask;
+			root_bus = find_pci_root_bus(pdev->bus);
+			__pci_walk_bus(root_bus, its_pci_msi_vec_count, &map_count, rid, map_mask);
+			break;
+		}
+	}
+	alias_count = max(map_count, alias_count);
+
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
 	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
 
-- 
2.17.1

