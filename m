Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B0413530E
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 07:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgAIGHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 01:07:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgAIGHF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 01:07:05 -0500
Received: from localhost (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ADA8205F4;
        Thu,  9 Jan 2020 06:07:05 +0000 (UTC)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     linux-pci@vger.kernel.org
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Zaihai Yu <yuzaihai@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] PCI: dwc: Separate CFG0 and CFG1 into different ATU regions
Date:   Thu,  9 Jan 2020 14:06:57 +0800
Message-Id: <20200109060657.1953-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platform has 4 (or more) viewports.  In that case, CFG0 and CFG1
can be separated into different ATU regions.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c    | 16 +++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h     |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0f36a926059a..504d2a192bba 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -532,6 +532,7 @@ static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	u64 cpu_addr;
 	void __iomem *va_cfg_base;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	int index = PCIE_ATU_REGION_INDEX1;
 
 	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
 		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
@@ -548,7 +549,20 @@ static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		va_cfg_base = pp->va_cfg1_base;
 	}
 
-	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
+	if (pci->num_viewport >= 4) {
+		/*
+		 * If there are 4 (or more) viewports, we can separate
+		 * CFG0 and CFG1 into different ATU regions:
+		 *  - region0: MEM
+		 *  - region1: CFG0
+		 *  - region2: IO
+		 *  - region3: CFG1
+		 */
+		if (type == PCIE_ATU_TYPE_CFG1)
+			index = PCIE_ATU_REGION_INDEX3;
+	}
+
+	dw_pcie_prog_outbound_atu(pci, index,
 				  type, cpu_addr,
 				  busdev, cfg_size);
 	if (write)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5a18e94e52c8..86225804f1e7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -63,6 +63,7 @@
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
+#define PCIE_ATU_REGION_INDEX3		0x3
 #define PCIE_ATU_REGION_INDEX2		0x2
 #define PCIE_ATU_REGION_INDEX1		0x1
 #define PCIE_ATU_REGION_INDEX0		0x0
-- 
2.17.1

