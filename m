Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C96511AB2D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 13:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfLKMpV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 07:45:21 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42476 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbfLKMpU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2019 07:45:20 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBCj1og012041;
        Wed, 11 Dec 2019 06:45:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576068301;
        bh=bd3Ck13/1cv/byJZHXr9phvyeVkUVFbwJ9DqoFa3n9I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O9omnOCgwGA98BHj4bawgCkBPM5GrcUAUTrGSRCOcC1M4k+47NAQ3hGLm2QP0SLbK
         Egp25w/pHe+0dvaoqzco3tvu3omE63IDoEfWWJbYxpwbE7cbVloLvHtL+Kuirtrdy/
         VrggVMcTVVWKsXskT9L340RtzobSe4XTES6DoAcA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBBCj1Yn036611
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Dec 2019 06:45:01 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 06:45:01 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 06:45:01 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBCirfi125451;
        Wed, 11 Dec 2019 06:44:58 -0600
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
Subject: [PATCH 1/4] PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments
Date:   Wed, 11 Dec 2019 18:16:05 +0530
Message-ID: <20191211124608.887-2-kishon@ti.com>
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

commit 8963106eabdc5691 ("PCI: endpoint: Add MSI-X interfaces") while
adding support to raise MSIX interrupts from endpoint didn't include
BAR Indicator register (BIR) configuration and MSIX table offset as
arguments in pci_epc_set_msix(). This would result in endpoint
controller register using random BAR indicator register, the memory
for which might not be allocated by the endpoint function driver.
Add BAR indicator register and MSIX table offset as arguments in
pci_epc_set_msix() and allocate space for MSIX table and pending
bit array (PBA) in pci-epf-test endpoint function driver.

Fixes: commit 8963106eabdc5691 ("PCI: endpoint: Add MSI-X interfaces")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 15 +++++++--
 drivers/pci/endpoint/functions/pci-epf-test.c | 31 +++++++++++++++----
 drivers/pci/endpoint/pci-epc-core.c           |  7 +++--
 include/linux/pci-epc.h                       |  6 ++--
 4 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 3dd2e2697294..4cd3193c9c7c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -269,7 +269,8 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
 	return val;
 }
 
-static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
+static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
+			       enum pci_barno bir, u32 offset)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -278,12 +279,22 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
 	if (!ep->msix_cap)
 		return -EINVAL;
 
+	dw_pcie_dbi_ro_wr_en(pci);
+
 	reg = ep->msix_cap + PCI_MSIX_FLAGS;
 	val = dw_pcie_readw_dbi(pci, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
 	val |= interrupts;
-	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, reg, val);
+
+	reg = ep->msix_cap + PCI_MSIX_TABLE;
+	val = offset | bir;
+	dw_pcie_writel_dbi(pci, reg, val);
+
+	reg = ep->msix_cap + PCI_MSIX_PBA;
+	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	dw_pcie_writel_dbi(pci, reg, val);
+
 	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 5d74f81ddfe4..f4bd3200cd74 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -47,6 +47,7 @@ struct pci_epf_test {
 	void			*reg[PCI_STD_NUM_BARS];
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
+	size_t			msix_table_offset;
 	struct delayed_work	cmd_handler;
 	const struct pci_epc_features *epc_features;
 };
@@ -429,6 +430,10 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct device *dev = &epf->dev;
 	struct pci_epf_bar *epf_bar;
+	size_t msix_table_size = 0;
+	size_t test_reg_bar_size;
+	size_t pba_size = 0;
+	bool msix_capable;
 	void *base;
 	int bar, add;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
@@ -437,13 +442,25 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 
 	epc_features = epf_test->epc_features;
 
-	if (epc_features->bar_fixed_size[test_reg_bar])
+	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
+
+	msix_capable = epc_features->msix_capable;
+	if (msix_capable) {
+		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
+		epf_test->msix_table_offset = test_reg_bar_size;
+		/* Align to QWORD or 8 Bytes */
+		pba_size = ALIGN(DIV_ROUND_UP(epf->msix_interrupts, 8), 8);
+	}
+	test_reg_size = test_reg_bar_size + msix_table_size + pba_size;
+
+	if (epc_features->bar_fixed_size[test_reg_bar]) {
+		if (test_reg_size > bar_size[test_reg_bar])
+			return -ENOMEM;
 		test_reg_size = bar_size[test_reg_bar];
-	else
-		test_reg_size = sizeof(struct pci_epf_test_reg);
+	}
 
-	base = pci_epf_alloc_space(epf, test_reg_size,
-				   test_reg_bar, epc_features->align);
+	base = pci_epf_alloc_space(epf, test_reg_size, test_reg_bar,
+				   epc_features->align);
 	if (!base) {
 		dev_err(dev, "Failed to allocated register space\n");
 		return -ENOMEM;
@@ -539,7 +556,9 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	}
 
 	if (msix_capable) {
-		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
+		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts,
+				       epf_test->test_reg_bar,
+				       epf_test->msix_table_offset);
 		if (ret) {
 			dev_err(dev, "MSI-X configuration failed\n");
 			return ret;
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2091508c1620..3b278fb99206 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -305,10 +305,13 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
  * @epc: the EPC device on which MSI-X has to be configured
  * @func_no: the endpoint function number in the EPC device
  * @interrupts: number of MSI-X interrupts required by the EPF
+ * @bir: BAR where the MSI-X table resides
+ * @offset: Offset pointing to the start of MSI-X table
  *
  * Invoke to set the required number of MSI-X interrupts.
  */
-int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
+		     enum pci_barno bir, u32 offset)
 {
 	int ret;
 	unsigned long flags;
@@ -321,7 +324,7 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
 		return 0;
 
 	spin_lock_irqsave(&epc->lock, flags);
-	ret = epc->ops->set_msix(epc, func_no, interrupts - 1);
+	ret = epc->ops->set_msix(epc, func_no, interrupts - 1, bir, offset);
 	spin_unlock_irqrestore(&epc->lock, flags);
 
 	return ret;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 56f1846b9d39..4e2bed5fd39c 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -53,7 +53,8 @@ struct pci_epc_ops {
 			      phys_addr_t addr);
 	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 interrupts);
 	int	(*get_msi)(struct pci_epc *epc, u8 func_no);
-	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u16 interrupts);
+	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u16 interrupts,
+			    enum pci_barno, u32 offset);
 	int	(*get_msix)(struct pci_epc *epc, u8 func_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
@@ -165,7 +166,8 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
 			phys_addr_t phys_addr);
 int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no);
-int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts);
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
+		     enum pci_barno, u32 offset);
 int pci_epc_get_msix(struct pci_epc *epc, u8 func_no);
 int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num);
-- 
2.17.1

