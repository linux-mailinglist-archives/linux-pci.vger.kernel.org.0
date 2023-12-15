Return-Path: <linux-pci+bounces-1036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA012813FD5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 03:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E601F22DDC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 02:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2957519E;
	Fri, 15 Dec 2023 02:35:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3634E62F;
	Fri, 15 Dec 2023 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.04,277,1695654000"; 
   d="scan'208";a="190428758"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Dec 2023 11:30:04 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 893EC40121A3;
	Fri, 15 Dec 2023 11:30:04 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	mani@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v3 3/6] PCI: dwc: Rename to .get_dbi_offset in struct dw_pcie_ep_ops
Date: Fri, 15 Dec 2023 11:29:52 +0900
Message-Id: <20231215022955.3574063-4-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215022955.3574063-1-yoshihiro.shimoda.uh@renesas.com>
References: <20231215022955.3574063-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since meaning of .func_conf_select is difficult to understand,
rename it to .get_dbi_offset.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../pci/controller/dwc/pci-layerscape-ep.c    |   5 +-
 .../pci/controller/dwc/pcie-designware-ep.c   | 108 +++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |   4 +-
 4 files changed, 59 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 4e4b687ef508..961ff1b719a1 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -184,8 +184,7 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 }
 
-static unsigned int ls_pcie_ep_func_conf_select(struct dw_pcie_ep *ep,
-						u8 func_no)
+static unsigned int ls_pcie_ep_get_dbi_offset(struct dw_pcie_ep *ep, u8 func_no)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct ls_pcie_ep *pcie = to_ls_pcie_ep(pci);
@@ -198,7 +197,7 @@ static const struct dw_pcie_ep_ops ls_pcie_ep_ops = {
 	.init = ls_pcie_ep_init,
 	.raise_irq = ls_pcie_ep_raise_irq,
 	.get_features = ls_pcie_ep_get_features,
-	.func_conf_select = ls_pcie_ep_func_conf_select,
+	.get_dbi_offset = ls_pcie_ep_get_dbi_offset,
 };
 
 static const struct ls_pcie_ep_drvdata ls1_ep_drvdata = {
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index ea99a97ce504..1100671db887 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -43,14 +43,14 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 	return NULL;
 }
 
-static unsigned int dw_pcie_ep_func_select(struct dw_pcie_ep *ep, u8 func_no)
+static unsigned int dw_pcie_ep_get_dbi_offset(struct dw_pcie_ep *ep, u8 func_no)
 {
-	unsigned int func_offset = 0;
+	unsigned int dbi_offset = 0;
 
-	if (ep->ops->func_conf_select)
-		func_offset = ep->ops->func_conf_select(ep, func_no);
+	if (ep->ops->get_dbi_offset)
+		dbi_offset = ep->ops->get_dbi_offset(ep, func_no);
 
-	return func_offset;
+	return dbi_offset;
 }
 
 static unsigned int dw_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep, u8 func_no)
@@ -59,8 +59,8 @@ static unsigned int dw_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep, u8 func_no
 
 	if (ep->ops->get_dbi2_offset)
 		dbi2_offset = ep->ops->get_dbi2_offset(ep, func_no);
-	else if (ep->ops->func_conf_select)     /* for backward compatibility */
-		dbi2_offset = ep->ops->func_conf_select(ep, func_no);
+	else if (ep->ops->get_dbi_offset)     /* for backward compatibility */
+		dbi2_offset = ep->ops->get_dbi_offset(ep, func_no);
 
 	return dbi2_offset;
 }
@@ -68,14 +68,14 @@ static unsigned int dw_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep, u8 func_no
 static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
 				   enum pci_barno bar, int flags)
 {
-	unsigned int func_offset, dbi2_offset;
+	unsigned int dbi_offset, dbi2_offset;
 	struct dw_pcie_ep *ep = &pci->ep;
 	u32 reg, reg_dbi2;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
 	dbi2_offset = dw_pcie_ep_get_dbi2_offset(ep, func_no);
 
-	reg = func_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
+	reg = dbi_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
 	reg_dbi2 = dbi2_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
 	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writel_dbi2(pci, reg_dbi2, 0x0);
@@ -102,16 +102,16 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
 		u8 cap_ptr, u8 cap)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	unsigned int func_offset = 0;
+	unsigned int dbi_offset = 0;
 	u8 cap_id, next_cap_ptr;
 	u16 reg;
 
 	if (!cap_ptr)
 		return 0;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
 
-	reg = dw_pcie_readw_dbi(pci, func_offset + cap_ptr);
+	reg = dw_pcie_readw_dbi(pci, dbi_offset + cap_ptr);
 	cap_id = (reg & 0x00ff);
 
 	if (cap_id > PCI_CAP_ID_MAX)
@@ -127,13 +127,13 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
 static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	unsigned int func_offset = 0;
+	unsigned int dbi_offset = 0;
 	u8 next_cap_ptr;
 	u16 reg;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
 
-	reg = dw_pcie_readw_dbi(pci, func_offset + PCI_CAPABILITY_LIST);
+	reg = dw_pcie_readw_dbi(pci, dbi_offset + PCI_CAPABILITY_LIST);
 	next_cap_ptr = (reg & 0x00ff);
 
 	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
@@ -144,23 +144,23 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	unsigned int func_offset = 0;
+	unsigned int dbi_offset = 0;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
 
 	dw_pcie_dbi_ro_wr_en(pci);
-	dw_pcie_writew_dbi(pci, func_offset + PCI_VENDOR_ID, hdr->vendorid);
-	dw_pcie_writew_dbi(pci, func_offset + PCI_DEVICE_ID, hdr->deviceid);
-	dw_pcie_writeb_dbi(pci, func_offset + PCI_REVISION_ID, hdr->revid);
-	dw_pcie_writeb_dbi(pci, func_offset + PCI_CLASS_PROG, hdr->progif_code);
-	dw_pcie_writew_dbi(pci, func_offset + PCI_CLASS_DEVICE,
+	dw_pcie_writew_dbi(pci, dbi_offset + PCI_VENDOR_ID, hdr->vendorid);
+	dw_pcie_writew_dbi(pci, dbi_offset + PCI_DEVICE_ID, hdr->deviceid);
+	dw_pcie_writeb_dbi(pci, dbi_offset + PCI_REVISION_ID, hdr->revid);
+	dw_pcie_writeb_dbi(pci, dbi_offset + PCI_CLASS_PROG, hdr->progif_code);
+	dw_pcie_writew_dbi(pci, dbi_offset + PCI_CLASS_DEVICE,
 			   hdr->subclass_code | hdr->baseclass_code << 8);
-	dw_pcie_writeb_dbi(pci, func_offset + PCI_CACHE_LINE_SIZE,
+	dw_pcie_writeb_dbi(pci, dbi_offset + PCI_CACHE_LINE_SIZE,
 			   hdr->cache_line_size);
-	dw_pcie_writew_dbi(pci, func_offset + PCI_SUBSYSTEM_VENDOR_ID,
+	dw_pcie_writew_dbi(pci, dbi_offset + PCI_SUBSYSTEM_VENDOR_ID,
 			   hdr->subsys_vendor_id);
-	dw_pcie_writew_dbi(pci, func_offset + PCI_SUBSYSTEM_ID, hdr->subsys_id);
-	dw_pcie_writeb_dbi(pci, func_offset + PCI_INTERRUPT_PIN,
+	dw_pcie_writew_dbi(pci, dbi_offset + PCI_SUBSYSTEM_ID, hdr->subsys_id);
+	dw_pcie_writeb_dbi(pci, dbi_offset + PCI_INTERRUPT_PIN,
 			   hdr->interrupt_pin);
 	dw_pcie_dbi_ro_wr_dis(pci);
 
@@ -243,17 +243,17 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	unsigned int func_offset, dbi2_offset;
+	unsigned int dbi_offset, dbi2_offset;
 	enum pci_barno bar = epf_bar->barno;
 	size_t size = epf_bar->size;
 	int flags = epf_bar->flags;
 	u32 reg, reg_dbi2;
 	int ret, type;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
 	dbi2_offset = dw_pcie_ep_get_dbi2_offset(ep, func_no);
 
-	reg = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset;
+	reg = PCI_BASE_ADDRESS_0 + (4 * bar) + dbi_offset;
 	reg_dbi2 = PCI_BASE_ADDRESS_0 + (4 * bar) + dbi2_offset;
 
 	if (!(flags & PCI_BASE_ADDRESS_SPACE))
@@ -337,16 +337,16 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	u32 val, reg;
-	unsigned int func_offset = 0;
+	unsigned int dbi_offset = 0;
 	struct dw_pcie_ep_func *ep_func;
 
 	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	if (!ep_func || !ep_func->msi_cap)
 		return -EINVAL;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
 
-	reg = ep_func->msi_cap + func_offset + PCI_MSI_FLAGS;
+	reg = ep_func->msi_cap + dbi_offset + PCI_MSI_FLAGS;
 	val = dw_pcie_readw_dbi(pci, reg);
 	if (!(val & PCI_MSI_FLAGS_ENABLE))
 		return -EINVAL;
@@ -362,16 +362,16 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	u32 val, reg;
-	unsigned int func_offset = 0;
+	unsigned int dbi_offset = 0;
 	struct dw_pcie_ep_func *ep_func;
 
 	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	if (!ep_func || !ep_func->msi_cap)
 		return -EINVAL;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
 
-	reg = ep_func->msi_cap + func_offset + PCI_MSI_FLAGS;
+	reg = ep_func->msi_cap + dbi_offset + PCI_MSI_FLAGS;
 	val = dw_pcie_readw_dbi(pci, reg);
 	val &= ~PCI_MSI_FLAGS_QMASK;
 	val |= FIELD_PREP(PCI_MSI_FLAGS_QMASK, interrupts);
@@ -387,16 +387,16 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	u32 val, reg;
-	unsigned int func_offset = 0;
+	unsigned int dbi_offset = 0;
 	struct dw_pcie_ep_func *ep_func;
 
 	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	if (!ep_func || !ep_func->msix_cap)
 		return -EINVAL;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
 
-	reg = ep_func->msix_cap + func_offset + PCI_MSIX_FLAGS;
+	reg = ep_func->msix_cap + dbi_offset + PCI_MSIX_FLAGS;
 	val = dw_pcie_readw_dbi(pci, reg);
 	if (!(val & PCI_MSIX_FLAGS_ENABLE))
 		return -EINVAL;
@@ -412,7 +412,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	u32 val, reg;
-	unsigned int func_offset = 0;
+	unsigned int dbi_offset = 0;
 	struct dw_pcie_ep_func *ep_func;
 
 	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
@@ -421,19 +421,19 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
 
-	reg = ep_func->msix_cap + func_offset + PCI_MSIX_FLAGS;
+	reg = ep_func->msix_cap + dbi_offset + PCI_MSIX_FLAGS;
 	val = dw_pcie_readw_dbi(pci, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
 	val |= interrupts;
 	dw_pcie_writew_dbi(pci, reg, val);
 
-	reg = ep_func->msix_cap + func_offset + PCI_MSIX_TABLE;
+	reg = ep_func->msix_cap + dbi_offset + PCI_MSIX_TABLE;
 	val = offset | bir;
 	dw_pcie_writel_dbi(pci, reg, val);
 
-	reg = ep_func->msix_cap + func_offset + PCI_MSIX_PBA;
+	reg = ep_func->msix_cap + dbi_offset + PCI_MSIX_PBA;
 	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
 	dw_pcie_writel_dbi(pci, reg, val);
 
@@ -514,7 +514,7 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dw_pcie_ep_func *ep_func;
 	struct pci_epc *epc = ep->epc;
 	unsigned int aligned_offset;
-	unsigned int func_offset = 0;
+	unsigned int dbi_offset = 0;
 	u16 msg_ctrl, msg_data;
 	u32 msg_addr_lower, msg_addr_upper, reg;
 	u64 msg_addr;
@@ -525,22 +525,22 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	if (!ep_func || !ep_func->msi_cap)
 		return -EINVAL;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
 
 	/* Raise MSI per the PCI Local Bus Specification Revision 3.0, 6.8.1. */
-	reg = ep_func->msi_cap + func_offset + PCI_MSI_FLAGS;
+	reg = ep_func->msi_cap + dbi_offset + PCI_MSI_FLAGS;
 	msg_ctrl = dw_pcie_readw_dbi(pci, reg);
 	has_upper = !!(msg_ctrl & PCI_MSI_FLAGS_64BIT);
-	reg = ep_func->msi_cap + func_offset + PCI_MSI_ADDRESS_LO;
+	reg = ep_func->msi_cap + dbi_offset + PCI_MSI_ADDRESS_LO;
 	msg_addr_lower = dw_pcie_readl_dbi(pci, reg);
 	if (has_upper) {
-		reg = ep_func->msi_cap + func_offset + PCI_MSI_ADDRESS_HI;
+		reg = ep_func->msi_cap + dbi_offset + PCI_MSI_ADDRESS_HI;
 		msg_addr_upper = dw_pcie_readl_dbi(pci, reg);
-		reg = ep_func->msi_cap + func_offset + PCI_MSI_DATA_64;
+		reg = ep_func->msi_cap + dbi_offset + PCI_MSI_DATA_64;
 		msg_data = dw_pcie_readw_dbi(pci, reg);
 	} else {
 		msg_addr_upper = 0;
-		reg = ep_func->msi_cap + func_offset + PCI_MSI_DATA_32;
+		reg = ep_func->msi_cap + dbi_offset + PCI_MSI_DATA_32;
 		msg_data = dw_pcie_readw_dbi(pci, reg);
 	}
 	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
@@ -585,7 +585,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dw_pcie_ep_func *ep_func;
 	struct pci_epf_msix_tbl *msix_tbl;
 	struct pci_epc *epc = ep->epc;
-	unsigned int func_offset = 0;
+	unsigned int dbi_offset = 0;
 	u32 reg, msg_data, vec_ctrl;
 	unsigned int aligned_offset;
 	u32 tbl_offset;
@@ -597,9 +597,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	if (!ep_func || !ep_func->msix_cap)
 		return -EINVAL;
 
-	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
 
-	reg = ep_func->msix_cap + func_offset + PCI_MSIX_TABLE;
+	reg = ep_func->msix_cap + dbi_offset + PCI_MSIX_TABLE;
 	tbl_offset = dw_pcie_readl_dbi(pci, reg);
 	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 3bc03a93732f..5e36da166ffe 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -344,7 +344,7 @@ struct dw_pcie_ep_ops {
 	 * return a 0, and implement code in callback function of platform
 	 * driver.
 	 */
-	unsigned int (*func_conf_select)(struct dw_pcie_ep *ep, u8 func_no);
+	unsigned int (*get_dbi_offset)(struct dw_pcie_ep *ep, u8 func_no);
 	unsigned int (*get_dbi2_offset)(struct dw_pcie_ep *ep, u8 func_no);
 };
 
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 1c017997fb3e..70492f562e48 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -394,7 +394,7 @@ rcar_gen4_pcie_ep_get_features(struct dw_pcie_ep *ep)
 	return &rcar_gen4_pcie_epc_features;
 }
 
-static unsigned int rcar_gen4_pcie_ep_func_conf_select(struct dw_pcie_ep *ep,
+static unsigned int rcar_gen4_pcie_ep_get_dbi_offset(struct dw_pcie_ep *ep,
 						       u8 func_no)
 {
 	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET;
@@ -412,7 +412,7 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.deinit = rcar_gen4_pcie_ep_deinit,
 	.raise_irq = rcar_gen4_pcie_ep_raise_irq,
 	.get_features = rcar_gen4_pcie_ep_get_features,
-	.func_conf_select = rcar_gen4_pcie_ep_func_conf_select,
+	.get_dbi_offset = rcar_gen4_pcie_ep_get_dbi_offset,
 	.get_dbi2_offset = rcar_gen4_pcie_ep_get_dbi2_offset,
 };
 
-- 
2.34.1


