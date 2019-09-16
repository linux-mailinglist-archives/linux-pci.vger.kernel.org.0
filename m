Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C7EB416C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 21:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391083AbfIPTzw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 15:55:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:35459 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732712AbfIPTzt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Sep 2019 15:55:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 12:55:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="177152711"
Received: from unknown (HELO debian-vmd.lm.intel.com) ([10.232.112.42])
  by orsmga007.jf.intel.com with ESMTP; 16 Sep 2019 12:55:48 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] PCI: vmd: Fix config addressing when using bus offsets
Date:   Mon, 16 Sep 2019 07:54:34 -0600
Message-Id: <20190916135435.5017-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916135435.5017-1-jonathan.derrick@intel.com>
References: <20190916135435.5017-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD maps child device config spaces to the VMD Config BAR linearly
regardless of the starting bus offset. Because of this, the config
address decode must ignore starting bus offsets when mapping the BDF to
the config space address.

Cc: stable@vger.kernel.org # v5.2+
Fixes: 2a5a9c9a ("PCI: vmd: Add offset to bus numbers if necessary")
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 4575e0c6dc4b..2e4da3f51d6b 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -94,6 +94,7 @@ struct vmd_dev {
 	struct resource		resources[3];
 	struct irq_domain	*irq_domain;
 	struct pci_bus		*bus;
+	u8			busn_start;
 
 	struct dma_map_ops	dma_ops;
 	struct dma_domain	dma_domain;
@@ -440,7 +441,8 @@ static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
 	char __iomem *addr = vmd->cfgbar +
-			     (bus->number << 20) + (devfn << 12) + reg;
+			     ((bus->number - vmd->busn_start) << 20) +
+			     (devfn << 12) + reg;
 
 	if ((addr - vmd->cfgbar) + len >=
 	    resource_size(&vmd->dev->resource[VMD_CFGBAR]))
@@ -563,7 +565,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	unsigned long flags;
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
-	resource_size_t membar2_offset = 0x2000, busn_start = 0;
+	resource_size_t membar2_offset = 0x2000;
 	struct pci_bus *child;
 
 	/*
@@ -606,14 +608,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		pci_read_config_dword(vmd->dev, PCI_REG_VMCONFIG, &vmconfig);
 		if (BUS_RESTRICT_CAP(vmcap) &&
 		    (BUS_RESTRICT_CFG(vmconfig) == 0x1))
-			busn_start = 128;
+			vmd->busn_start = 128;
 	}
 
 	res = &vmd->dev->resource[VMD_CFGBAR];
 	vmd->resources[0] = (struct resource) {
 		.name  = "VMD CFGBAR",
-		.start = busn_start,
-		.end   = busn_start + (resource_size(res) >> 20) - 1,
+		.start = vmd->busn_start,
+		.end   = vmd->busn_start + (resource_size(res) >> 20) - 1,
 		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
 	};
 
@@ -681,8 +683,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
 
-	vmd->bus = pci_create_root_bus(&vmd->dev->dev, busn_start, &vmd_ops,
-				       sd, &resources);
+	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
+				       &vmd_ops, sd, &resources);
 	if (!vmd->bus) {
 		pci_free_resource_list(&resources);
 		irq_domain_remove(vmd->irq_domain);
-- 
2.20.1

