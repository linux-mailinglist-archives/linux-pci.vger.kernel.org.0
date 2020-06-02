Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E5A1EB931
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 12:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgFBKKK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 06:10:10 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2134 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBKKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 06:10:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed6251f0032>; Tue, 02 Jun 2020 03:08:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Jun 2020 03:10:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Jun 2020 03:10:07 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Jun
 2020 10:10:00 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 2 Jun 2020 10:10:00 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ed625740001>; Tue, 02 Jun 2020 03:09:59 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 2/2] PCI: dwc: Use ATU region to map prefetchable memory region
Date:   Tue, 2 Jun 2020 15:39:40 +0530
Message-ID: <20200602100940.10575-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602100940.10575-1-vidyas@nvidia.com>
References: <20200602100940.10575-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591092511; bh=EksAjlCQ6LX5WqYVfkmFGD/CMICr7v45x6LOun1LW0w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=F1QgtWp1jNiLRT5w9cJhjb/yTLDF2YwlnhSx8j1ombacH9opDB+lee6QNjVMpr7nw
         lx2acFl1J63YHQSeskbhXJs2ltrhIBIQ/rj4AQl0kY6uWMerStrXUnIdEKQPYfzzbZ
         pBlN7lhB7RUAtR0Wok3RjZpUc47Yadg1UW6GxcOJlTok6z5J1ddlLGM/iZkDabcLwS
         OsdztXVXpw3P2ATo7gRIwc3LgjqM8hnKj6AQyo7Q1wei+03X2fkGElvd056wZtEapq
         nynrjFxh2kab73O8bSQSKnFDQEefy2i4POiPXh33oXlEIaPU9p8cFLLJSs+1t8853B
         QeHK2klthyhCg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use ATU region-3 to setup mapping for prefetchable memory region. It also
modifies the code to consume an ATU region for mapping non-prefetchable or
prefetchable memory regions only if the CPU address and PCIe bus addresses
are not equal as there is no need to use ATU mapping if there is a 1:1
mapping between CPU address and PCIe bus address.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 20 ++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c  |  6 ++++--
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +++-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6f06d6bd9f00..cd3b52c93f05 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -701,13 +701,27 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * we should not program the ATU here.
 	 */
 	if (!pp->ops->rd_other_conf) {
-		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
-					  PCIE_ATU_TYPE_MEM, pp->mem_base,
-					  pp->mem_bus_addr, pp->mem_size);
+		if (pp->mem_base != pp->mem_bus_addr) {
+			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
+						  PCIE_ATU_TYPE_MEM,
+						  pp->mem_base,
+						  pp->mem_bus_addr,
+						  pp->mem_size);
+		}
 		if (pci->num_viewport > 2)
 			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
 						  PCIE_ATU_TYPE_IO, pp->io_base,
 						  pp->io_bus_addr, pp->io_size);
+		if (pp->prefetch_base != pp->perfetch_bus_addr &&
+		    pci->num_viewport >= 4) {
+			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX3,
+						  PCIE_ATU_TYPE_MEM,
+						  pp->prefetch_base,
+						  pp->perfetch_bus_addr,
+						  pp->prefetch_size);
+		} else {
+			dev_warn(pci->dev, "Insufficient ATU regions to map Prefetchable memory\n");
+		}
 	}
 
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c92496e36fd5..87f0ab8eb954 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -241,7 +241,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 
 static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
 					     int type, u64 cpu_addr,
-					     u64 pci_addr, u32 size)
+					     u64 pci_addr, u64 size)
 {
 	u32 retries, val;
 	u64 limit_addr = cpu_addr + size - 1;
@@ -259,6 +259,8 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
 				 upper_32_bits(pci_addr));
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
+				 upper_32_bits(size - 1) ?
+				 type | PCIE_ATU_INCREASE_REGION_SIZE :
 				 type);
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
 				 PCIE_ATU_ENABLE);
@@ -279,7 +281,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
 }
 
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			       u64 cpu_addr, u64 pci_addr, u32 size)
+			       u64 cpu_addr, u64 pci_addr, u64 size)
 {
 	u32 retries, val;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index c87c1b2a1177..5c21b6732755 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -72,10 +72,12 @@
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
+#define PCIE_ATU_REGION_INDEX3		0x3
 #define PCIE_ATU_REGION_INDEX2		0x2
 #define PCIE_ATU_REGION_INDEX1		0x1
 #define PCIE_ATU_REGION_INDEX0		0x0
 #define PCIE_ATU_CR1			0x904
+#define PCIE_ATU_INCREASE_REGION_SIZE	BIT(13)
 #define PCIE_ATU_TYPE_MEM		0x0
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
@@ -294,7 +296,7 @@ void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
 			       int type, u64 cpu_addr, u64 pci_addr,
-			       u32 size);
+			       u64 size);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
 			     u64 cpu_addr, enum dw_pcie_as_type as_type);
 void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
-- 
2.17.1

