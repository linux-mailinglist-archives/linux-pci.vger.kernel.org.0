Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A06283589
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 14:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgJEMOB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 08:14:01 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11468 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgJEMOA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 08:14:00 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b0dfb0000>; Mon, 05 Oct 2020 05:13:47 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 12:13:57 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 5 Oct 2020 12:13:54 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH] PCI: dwc: Use ATU regions to map memory regions
Date:   Mon, 5 Oct 2020 17:43:51 +0530
Message-ID: <20201005121351.32516-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601900027; bh=lO0HDidGPFmx2vLsOELT1TeoB3G4Z1UJtWvQEooKw0I=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=GGkZrBNLSmOW+03MCLY8tXh3aZb9z8hZ07GMerAMYTtxlfTMVhHd3LGfNhb6JtPl4
         cELYMGusL9vhU9IGiUhyhN00qysgcFylO0wngNrzFqrOhDCCY47J5Suc+cLCs3C1KM
         XW5EQjtlPaiULrdusTS7P5LXti7DjhgtQwCLH3csM/gZypy+wjM/eMW8j7si4uOo/C
         H8tziZ7qndyAyViPM0Pnhst1m7NrsAZQO2koWSAXDSIgc2XlEEfkKy5Ts5k+VNyxzw
         7FF8l2wvBu1Ar4hI4caJOAAEhfSZ9dTg1q9/sjdLPkDWoEZilAX1R8+vcQEAsQmpth
         YmnY1HwtydhyQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use ATU region-3 and region-0 to setup mapping for prefetchable and
non-prefetchable memory regions respectively only if their respective CPU
and bus addresses are different.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 44 ++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c  | 12 ++---
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
 3 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 317ff512f8df..cefde8e813e9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -515,9 +515,40 @@ static struct pci_ops dw_pcie_ops = {
 	.write = pci_generic_config_write,
 };
 
+static void dw_pcie_setup_mem_atu(struct pcie_port *pp,
+				  struct resource_entry *win)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	if (win->res->flags & IORESOURCE_PREFETCH && pci->num_viewport >= 4 &&
+	    win->offset) {
+		dw_pcie_prog_outbound_atu(pci,
+					  PCIE_ATU_REGION_INDEX3,
+					  PCIE_ATU_TYPE_MEM,
+					  win->res->start,
+					  win->res->start - win->offset,
+					  resource_size(win->res));
+	} else if (win->res->flags & IORESOURCE_PREFETCH &&
+		   pci->num_viewport < 4) {
+		dev_warn(pci->dev,
+			 "Insufficient ATU regions to map Prefetchable memory\n");
+	} else if (win->offset) {
+		if (upper_32_bits(resource_size(win->res)))
+			dev_warn(pci->dev,
+				 "Memory resource size exceeds max for 32 bits\n");
+		dw_pcie_prog_outbound_atu(pci,
+					  PCIE_ATU_REGION_INDEX0,
+					  PCIE_ATU_TYPE_MEM,
+					  win->res->start,
+					  win->res->start - win->offset,
+					  resource_size(win->res));
+	}
+}
+
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val, ctrl, num_ctrls;
+	struct resource_entry *win;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	/*
@@ -572,13 +603,14 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * ATU, so we should not program the ATU here.
 	 */
 	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
-		struct resource_entry *entry =
-			resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+		resource_list_for_each_entry(win, &pp->bridge->windows) {
+			switch (resource_type(win->res)) {
+			case IORESOURCE_MEM:
+				dw_pcie_setup_mem_atu(pp, win);
+				break;
+			}
+		}
 
-		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
-					  PCIE_ATU_TYPE_MEM, entry->res->start,
-					  entry->res->start - entry->offset,
-					  resource_size(entry->res));
 		if (pci->num_viewport > 2)
 			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
 						  PCIE_ATU_TYPE_IO, pp->io_base,
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 3c1f17c78241..6033689abb15 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -227,7 +227,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 					     int index, int type,
 					     u64 cpu_addr, u64 pci_addr,
-					     u32 size)
+					     u64 size)
 {
 	u32 retries, val;
 	u64 limit_addr = cpu_addr + size - 1;
@@ -244,8 +244,10 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 				 lower_32_bits(pci_addr));
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
 				 upper_32_bits(pci_addr));
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
-				 type | PCIE_ATU_FUNC_NUM(func_no));
+	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	val = upper_32_bits(size - 1) ?
+		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
 				 PCIE_ATU_ENABLE);
 
@@ -266,7 +268,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 
 static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 					int index, int type, u64 cpu_addr,
-					u64 pci_addr, u32 size)
+					u64 pci_addr, u64 size)
 {
 	u32 retries, val;
 
@@ -310,7 +312,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 }
 
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			       u64 cpu_addr, u64 pci_addr, u32 size)
+			       u64 cpu_addr, u64 pci_addr, u64 size)
 {
 	__dw_pcie_prog_outbound_atu(pci, 0, index, type,
 				    cpu_addr, pci_addr, size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 97c7063b9e89..b81a1813cf9e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -80,10 +80,12 @@
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
@@ -295,7 +297,7 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
 			       int type, u64 cpu_addr, u64 pci_addr,
-			       u32 size);
+			       u64 size);
 void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				  int type, u64 cpu_addr, u64 pci_addr,
 				  u32 size);
-- 
2.17.1

