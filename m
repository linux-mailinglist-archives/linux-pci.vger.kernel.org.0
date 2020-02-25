Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 116F316BB97
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 09:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgBYINC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 03:13:02 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41010 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbgBYINB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 03:13:01 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P8Ck4r022848;
        Tue, 25 Feb 2020 02:12:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582618366;
        bh=MFKlsVEIsp/GM8V4eXJvs2LWVxdQ1A0Od80VYBrMQL0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KL2C3bOp08O9vYDn2sumYsHzTO2DYtiIO+keBI+XhoV+aKg1eQXj7SHlGf6xOHC1X
         qvGo8v8PRUCU4vdW9e7tm8AOsuHNTzpDfi5F12ajbm0rYnBESQLOXTKuiAVBsQWTsF
         +r5gJMWU9QQFSCvQphGY7T2FviJKOrSC6SVZO01c=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P8CkQQ092228
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Feb 2020 02:12:46 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 02:12:45 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 02:12:46 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P8CYuA026220;
        Tue, 25 Feb 2020 02:12:42 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH v2 2/3] PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table address
Date:   Tue, 25 Feb 2020 13:47:02 +0530
Message-ID: <20200225081703.8857-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225081703.8857-1-kishon@ti.com>
References: <20200225081703.8857-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler"),
in order to raise MSI-X interrupt, obtained MSIX table address from
Base Address Register (BAR). However BAR only holds PCI address
programmed by the host whereas the MSI-X table should be in the local
memory.

Store the MSI-X table address (virtual address) as part of ->set_bar()
callback and use that to get the message address and message data
here.

Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 46 +++++++------------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 drivers/pci/endpoint/pci-epf-core.c           |  2 +
 include/linux/pci-epf.h                       | 15 ++++++
 4 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 19ab3903f042..b61e47365456 100644
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
-	msix_tbl = ioremap(ep->phys_base + tbl_addr,
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
index a22ea5982817..0813c2b62f89 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -233,6 +233,7 @@ struct dw_pcie_ep {
 	phys_addr_t		msi_mem_phys;
 	u8			msi_cap;	/* MSI capability offset */
 	u8			msix_cap;	/* MSI-X capability offset */
+	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
 };
 
 struct dw_pcie_ops {
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 6e0648991b5c..244e00f48c5c 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -87,6 +87,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar)
 			  epf->bar[bar].phys_addr);
 
 	epf->bar[bar].phys_addr = 0;
+	epf->bar[bar].addr = NULL;
 	epf->bar[bar].size = 0;
 	epf->bar[bar].barno = 0;
 	epf->bar[bar].flags = 0;
@@ -123,6 +124,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	epf->bar[bar].phys_addr = phys_addr;
+	epf->bar[bar].addr = space;
 	epf->bar[bar].size = size;
 	epf->bar[bar].barno = bar;
 	epf->bar[bar].flags |= upper_32_bits(size) ?
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index bcdf4f07bde7..efbc08a153ff 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -89,10 +89,12 @@ struct pci_epf_driver {
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
@@ -129,6 +131,19 @@ struct pci_epf {
 	struct mutex		lock;
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

