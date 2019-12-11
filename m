Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C639511AB33
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 13:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfLKMpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 07:45:31 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35796 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLKMpa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2019 07:45:30 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBCj5l9089491;
        Wed, 11 Dec 2019 06:45:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576068305;
        bh=DrzozqxqnLdLGz6rBnagl7+5mj8R28GaxJdvkdPqrmA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GZ6eL1hv2UOa3i5ABiiSWuemVGekjf1lVkTwW/qQHJAN+XZdUfdR03fIQIfxJXca6
         ktFhEPRWWUQh0wkzNMu0eqp0qXwClWwYoe8pmQwOnOx10VSug89fdEJmBVHbEceucc
         nc6beGmGcS+T/4phGXYF4oMcT4KCjbN0jPj7W38M=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBBCj5HS036932
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Dec 2019 06:45:05 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 06:45:04 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 06:45:04 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBCirfj125451;
        Wed, 11 Dec 2019 06:45:01 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH 2/4] PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSIX table address
Date:   Wed, 11 Dec 2019 18:16:06 +0530
Message-ID: <20191211124608.887-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211124608.887-1-kishon@ti.com>
References: <20191211124608.887-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit beb4641a787df79a14 ("PCI: dwc: Add MSI-X callbacks handler"),
in order to raise MSIX interrupt, obtained MSIX table address from
Base Address Register (BAR). However BAR only holds PCI address
programmed by the host whereas the MSIX table should be in the local
memory.

Store the MSIX table address (virtual address) as part of ->set_bar()
callback and use that to get the message address and message data
here.

Fixes: commit beb4641a787df79a14 ("PCI: dwc: Add MSI-X callbacks
handler")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 46 +++++++------------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 drivers/pci/endpoint/pci-epf-core.c           |  2 +
 include/linux/pci-epf.h                       | 15 ++++++
 4 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 4cd3193c9c7c..b61e47365456 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -125,6 +125,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
 
 	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND);
 	clear_bit(atu_index, ep->ib_window_map);
+	ep->epf_bar[bar] = NULL;
 }
 
 static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
@@ -158,6 +159,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
 		dw_pcie_writel_dbi(pci, reg + 4, 0);
 	}
 
+	ep->epf_bar[bar] = epf_bar;
 	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
@@ -420,55 +422,41 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct pci_epf_msix_tbl *msix_tbl;
 	struct pci_epc *epc = ep->epc;
-	u16 tbl_offset, bir;
-	u32 bar_addr_upper, bar_addr_lower;
-	u32 msg_addr_upper, msg_addr_lower;
+	struct pci_epf_bar *epf_bar;
 	u32 reg, msg_data, vec_ctrl;
-	u64 tbl_addr, msg_addr, reg_u64;
-	void __iomem *msix_tbl;
+	unsigned int aligned_offset;
+	u32 tbl_offset;
+	u64 msg_addr;
 	int ret;
+	u8 bir;
 
 	reg = ep->msix_cap + PCI_MSIX_TABLE;
 	tbl_offset = dw_pcie_readl_dbi(pci, reg);
 	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
 
-	reg = PCI_BASE_ADDRESS_0 + (4 * bir);
-	bar_addr_upper = 0;
-	bar_addr_lower = dw_pcie_readl_dbi(pci, reg);
-	reg_u64 = (bar_addr_lower & PCI_BASE_ADDRESS_MEM_TYPE_MASK);
-	if (reg_u64 == PCI_BASE_ADDRESS_MEM_TYPE_64)
-		bar_addr_upper = dw_pcie_readl_dbi(pci, reg + 4);
+	epf_bar = ep->epf_bar[bir];
+	msix_tbl = epf_bar->addr;
+	msix_tbl = (struct pci_epf_msix_tbl *)((char *)msix_tbl + tbl_offset);
 
-	tbl_addr = ((u64) bar_addr_upper) << 32 | bar_addr_lower;
-	tbl_addr += (tbl_offset + ((interrupt_num - 1) * PCI_MSIX_ENTRY_SIZE));
-	tbl_addr &= PCI_BASE_ADDRESS_MEM_MASK;
-
-	msix_tbl = ioremap_nocache(ep->phys_base + tbl_addr,
-				   PCI_MSIX_ENTRY_SIZE);
-	if (!msix_tbl)
-		return -EINVAL;
-
-	msg_addr_lower = readl(msix_tbl + PCI_MSIX_ENTRY_LOWER_ADDR);
-	msg_addr_upper = readl(msix_tbl + PCI_MSIX_ENTRY_UPPER_ADDR);
-	msg_addr = ((u64) msg_addr_upper) << 32 | msg_addr_lower;
-	msg_data = readl(msix_tbl + PCI_MSIX_ENTRY_DATA);
-	vec_ctrl = readl(msix_tbl + PCI_MSIX_ENTRY_VECTOR_CTRL);
-
-	iounmap(msix_tbl);
+	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
+	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
+	vec_ctrl = msix_tbl[(interrupt_num - 1)].vector_ctrl;
 
 	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT) {
 		dev_dbg(pci->dev, "MSI-X entry ctrl set\n");
 		return -EPERM;
 	}
 
-	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
+	aligned_offset = msg_addr & (epc->mem->page_size - 1);
+	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys,  msg_addr,
 				  epc->mem->page_size);
 	if (ret)
 		return ret;
 
-	writel(msg_data, ep->msi_mem);
+	writel(msg_data, ep->msi_mem + aligned_offset);
 
 	dw_pcie_ep_unmap_addr(epc, func_no, ep->msi_mem_phys);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5accdd6bc388..6c7fcd867581 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -224,6 +224,7 @@ struct dw_pcie_ep {
 	phys_addr_t		msi_mem_phys;
 	u8			msi_cap;	/* MSI capability offset */
 	u8			msix_cap;	/* MSI-X capability offset */
+	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
 };
 
 struct dw_pcie_ops {
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index fb1306de8f40..93ebe916949e 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -99,6 +99,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar)
 			  epf->bar[bar].phys_addr);
 
 	epf->bar[bar].phys_addr = 0;
+	epf->bar[bar].addr = NULL;
 	epf->bar[bar].size = 0;
 	epf->bar[bar].barno = 0;
 	epf->bar[bar].flags = 0;
@@ -135,6 +136,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	epf->bar[bar].phys_addr = phys_addr;
+	epf->bar[bar].addr = space;
 	epf->bar[bar].size = size;
 	epf->bar[bar].barno = bar;
 	epf->bar[bar].flags |= upper_32_bits(size) ?
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 2d6f07556682..bc5ce7afd79a 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -92,10 +92,12 @@ struct pci_epf_driver {
 /**
  * struct pci_epf_bar - represents the BAR of EPF device
  * @phys_addr: physical address that should be mapped to the BAR
+ * @addr: virtual address corresponding to the @phys_addr
  * @size: the size of the address space present in BAR
  */
 struct pci_epf_bar {
 	dma_addr_t	phys_addr;
+	void		*addr;
 	size_t		size;
 	enum pci_barno	barno;
 	int		flags;
@@ -127,6 +129,19 @@ struct pci_epf {
 	struct list_head	list;
 };
 
+/**
+ * struct pci_epf_msix_tbl - represents the MSIX table entry structure
+ * @msg_addr: Writes to this address will trigger MSIX interrupt in host
+ * @msg_data: Data that should be written to @msg_addr to trigger MSIX interrupt
+ * @vector_ctrl: Identifies if the function is prohibited from sending a message
+ * using this MSIX table entry
+ */
+struct pci_epf_msix_tbl {
+	u64 msg_addr;
+	u32 msg_data;
+	u32 vector_ctrl;
+};
+
 #define to_pci_epf(epf_dev) container_of((epf_dev), struct pci_epf, dev)
 
 #define pci_epf_register_driver(driver)    \
-- 
2.17.1

