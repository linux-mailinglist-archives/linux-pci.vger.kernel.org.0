Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B762B0BC0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 18:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKLRzI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 12:55:08 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59082 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgKLRzF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 12:55:05 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACHsbRb028243;
        Thu, 12 Nov 2020 11:54:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605203677;
        bh=2t8D3dBdEUX56Ew/t9AOzrkngtbZaDuSfjoE8Jsqyww=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xTDRDrqq2pCKRnlBu3X1klUQ181G9skTugoxsW/5Web6F/Df4R7M6OPnQCjpRLHYJ
         rsD500RbgHQNnLFl9oCz+IviRkt2E54Q1iSkN0IC9iNgJc59GQA5jQ7aZ1fHVtUWg3
         pPnY2mymliam6yIv9MjRF3UneWm694VZbskFXujE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACHsbUu058580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 11:54:37 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 11:54:37 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 11:54:37 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACHrx9v094087;
        Thu, 12 Nov 2020 11:54:32 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 5/6] PCI: cadence: Add support to configure virtual functions
Date:   Thu, 12 Nov 2020 23:23:57 +0530
Message-ID: <20201112175358.2653-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201112175358.2653-1-kishon@ti.com>
References: <20201112175358.2653-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that support for SR-IOV is added in PCIe endpoint core, add support
to configure virtual functions in the Cadence PCIe EP driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  | 207 ++++++++++++++++--
 drivers/pci/controller/cadence/pcie-cadence.h |   7 +
 2 files changed, 197 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 1d171b1f6b1b..25010c2f0731 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -20,7 +20,18 @@ static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
 				     struct pci_epf_header *hdr)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
 	struct cdns_pcie *pcie = &ep->pcie;
+	u32 reg;
+
+	if (vfn > 1) {
+		dev_dbg(&epc->dev, "Only Virtual Function #1 has deviceID\n");
+		return 0;
+	} else if (vfn == 1) {
+		reg = cap + PCI_SRIOV_VF_DID;
+		cdns_pcie_ep_fn_writew(pcie, fn, reg, hdr->deviceid);
+		return 0;
+	}
 
 	cdns_pcie_ep_fn_writew(pcie, fn, PCI_DEVICE_ID, hdr->deviceid);
 	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_REVISION_ID, hdr->revid);
@@ -51,12 +62,14 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 				struct pci_epf_bar *epf_bar)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
 	struct cdns_pcie_epf *epf = &ep->epf[fn];
 	struct cdns_pcie *pcie = &ep->pcie;
 	dma_addr_t bar_phys = epf_bar->phys_addr;
 	enum pci_barno bar = epf_bar->barno;
 	int flags = epf_bar->flags;
 	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
+	u32 first_vf_offset, stride;
 	u64 sz;
 
 	/* BAR size is 2^(aperture + 7) */
@@ -92,19 +105,39 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 
 	addr0 = lower_32_bits(bar_phys);
 	addr1 = upper_32_bits(bar_phys);
+
+	if (vfn == 1) {
+		if (bar < BAR_4) {
+			reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn);
+			b = bar;
+		} else {
+			reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG1(fn);
+			b = bar - BAR_4;
+		}
+	} else {
+		if (bar < BAR_4) {
+			reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
+			b = bar;
+		} else {
+			reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
+			b = bar - BAR_4;
+		}
+	}
+
+	if (vfn > 0) {
+		first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, cap +
+							PCI_SRIOV_VF_OFFSET);
+		stride = cdns_pcie_ep_fn_readw(pcie, fn, cap +
+					       PCI_SRIOV_VF_STRIDE);
+		fn = fn + first_vf_offset + ((vfn - 1) * stride);
+		epf = &epf->epf[vfn - 1];
+	}
+
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar),
 			 addr0);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar),
 			 addr1);
 
-	if (bar < BAR_4) {
-		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
-		b = bar;
-	} else {
-		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
-		b = bar - BAR_4;
-	}
-
 	cfg = cdns_pcie_readl(pcie, reg);
 	cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
 		 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
@@ -121,17 +154,38 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 				   struct pci_epf_bar *epf_bar)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
 	struct cdns_pcie_epf *epf = &ep->epf[fn];
 	struct cdns_pcie *pcie = &ep->pcie;
 	enum pci_barno bar = epf_bar->barno;
+	u32 first_vf_offset, stride;
 	u32 reg, cfg, b, ctrl;
 
-	if (bar < BAR_4) {
-		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
-		b = bar;
+	if (vfn == 1) {
+		if (bar < BAR_4) {
+			reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn);
+			b = bar;
+		} else {
+			reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG1(fn);
+			b = bar - BAR_4;
+		}
 	} else {
-		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
-		b = bar - BAR_4;
+		if (bar < BAR_4) {
+			reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
+			b = bar;
+		} else {
+			reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
+			b = bar - BAR_4;
+		}
+	}
+
+	if (vfn > 0) {
+		first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, cap +
+							PCI_SRIOV_VF_OFFSET);
+		stride = cdns_pcie_ep_fn_readw(pcie, fn, cap +
+					       PCI_SRIOV_VF_STRIDE);
+		fn = fn + first_vf_offset + ((vfn - 1) * stride);
+		epf = &epf->epf[vfn - 1];
 	}
 
 	ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
@@ -152,8 +206,18 @@ static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
+	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
+	u32 first_vf_offset, stride;
 	u32 r;
 
+	if (vfn > 0) {
+		first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, cap +
+							PCI_SRIOV_VF_OFFSET);
+		stride = cdns_pcie_ep_fn_readw(pcie, fn, cap +
+					       PCI_SRIOV_VF_STRIDE);
+		fn = fn + first_vf_offset + ((vfn - 1) * stride);
+	}
+
 	r = find_first_zero_bit(&ep->ob_region_map,
 				sizeof(ep->ob_region_map) * BITS_PER_LONG);
 	if (r >= ep->max_regions - 1) {
@@ -193,9 +257,19 @@ static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 mmc)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
+	u32 sriov_cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
 	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
+	u32 first_vf_offset, stride;
 	u16 flags;
 
+	if (vfn > 0) {
+		first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, sriov_cap +
+							PCI_SRIOV_VF_OFFSET);
+		stride = cdns_pcie_ep_fn_readw(pcie, fn, sriov_cap +
+					       PCI_SRIOV_VF_STRIDE);
+		fn = fn + first_vf_offset + ((vfn - 1) * stride);
+	}
+
 	/*
 	 * Set the Multiple Message Capable bitfield into the Message Control
 	 * register.
@@ -213,9 +287,19 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
+	u32 sriov_cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
 	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
+	u32 first_vf_offset, stride;
 	u16 flags, mme;
 
+	if (vfn > 0) {
+		first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, sriov_cap +
+							PCI_SRIOV_VF_OFFSET);
+		stride = cdns_pcie_ep_fn_readw(pcie, fn, sriov_cap +
+					       PCI_SRIOV_VF_STRIDE);
+		fn = fn + first_vf_offset + ((vfn - 1) * stride);
+	}
+
 	/* Validate that the MSI feature is actually enabled. */
 	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
 	if (!(flags & PCI_MSI_FLAGS_ENABLE))
@@ -232,11 +316,21 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 
 static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
+	u32 sriov_cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
 	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
+	u32 first_vf_offset, stride;
 	u32 val, reg;
 
+	if (vfunc_no > 0) {
+		first_vf_offset = cdns_pcie_ep_fn_readw(pcie, func_no, sriov_cap
+							+ PCI_SRIOV_VF_OFFSET);
+		stride = cdns_pcie_ep_fn_readw(pcie, func_no, sriov_cap +
+					       PCI_SRIOV_VF_STRIDE);
+		func_no = func_no + first_vf_offset + ((vfunc_no - 1) * stride);
+	}
+
 	reg = cap + PCI_MSIX_FLAGS;
 	val = cdns_pcie_ep_fn_readw(pcie, func_no, reg);
 	if (!(val & PCI_MSIX_FLAGS_ENABLE))
@@ -251,11 +345,21 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 				 u16 interrupts, enum pci_barno bir,
 				 u32 offset)
 {
+	u32 sriov_cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
 	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
+	u32 first_vf_offset, stride;
 	u32 val, reg;
 
+	if (vfn > 0) {
+		first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, sriov_cap +
+							PCI_SRIOV_VF_OFFSET);
+		stride = cdns_pcie_ep_fn_readw(pcie, fn, sriov_cap +
+					       PCI_SRIOV_VF_STRIDE);
+		fn = fn + first_vf_offset + ((vfn - 1) * stride);
+	}
+
 	reg = cap + PCI_MSIX_FLAGS;
 	val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
@@ -275,8 +379,8 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 	return 0;
 }
 
-static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
-				     u8 intx, bool is_asserted)
+static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
+				     bool is_asserted)
 {
 	struct cdns_pcie *pcie = &ep->pcie;
 	unsigned long flags;
@@ -339,11 +443,21 @@ static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 				     u8 interrupt_num)
 {
+	u32 sriov_cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
 	struct cdns_pcie *pcie = &ep->pcie;
 	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
 	u16 flags, mme, data, data_mask;
 	u8 msi_count;
 	u64 pci_addr, pci_addr_mask = 0xff;
+	u32 first_vf_offset, stride;
+
+	if (vfn > 0) {
+		first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, sriov_cap +
+							PCI_SRIOV_VF_OFFSET);
+		stride = cdns_pcie_ep_fn_readw(pcie, fn, sriov_cap +
+					       PCI_SRIOV_VF_STRIDE);
+		fn = fn + first_vf_offset + ((vfn - 1) * stride);
+	}
 
 	/* Check whether the MSI feature has been enabled by the PCI host. */
 	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
@@ -389,15 +503,25 @@ static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 				    u32 entry_size, u32 *msi_data,
 				    u32 *msi_addr_offset)
 {
+	u32 sriov_cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
 	struct cdns_pcie *pcie = &ep->pcie;
 	u64 pci_addr, pci_addr_mask = 0xff;
 	u16 flags, mme, data, data_mask;
+	u32 first_vf_offset, stride;
 	u8 msi_count;
 	int ret;
 	int i;
 
+	if (vfn > 0) {
+		first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, sriov_cap +
+							PCI_SRIOV_VF_OFFSET);
+		stride = cdns_pcie_ep_fn_readw(pcie, fn, sriov_cap +
+					       PCI_SRIOV_VF_STRIDE);
+		fn = fn + first_vf_offset + ((vfn - 1) * stride);
+	}
+
 	/* Check whether the MSI feature has been enabled by the PCI host. */
 	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
 	if (!(flags & PCI_MSI_FLAGS_ENABLE))
@@ -438,16 +562,29 @@ static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 				      u16 interrupt_num)
 {
+	u32 sriov_cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
 	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
 	u32 tbl_offset, msg_data, reg;
 	struct cdns_pcie *pcie = &ep->pcie;
 	struct pci_epf_msix_tbl *msix_tbl;
+	u32 first_vf_offset, stride;
 	struct cdns_pcie_epf *epf;
 	u64 pci_addr_mask = 0xff;
 	u64 msg_addr;
 	u16 flags;
 	u8 bir;
 
+	epf = &ep->epf[fn];
+
+	if (vfn > 0) {
+		first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, sriov_cap +
+							PCI_SRIOV_VF_OFFSET);
+		stride = cdns_pcie_ep_fn_readw(pcie, fn, sriov_cap +
+					       PCI_SRIOV_VF_STRIDE);
+		fn = fn + first_vf_offset + ((vfn - 1) * stride);
+		epf = &epf->epf[vfn - 1];
+	}
+
 	/* Check whether the MSI-X feature has been enabled by the PCI host. */
 	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSIX_FLAGS);
 	if (!(flags & PCI_MSIX_FLAGS_ENABLE))
@@ -458,7 +595,6 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 	bir = tbl_offset & PCI_MSIX_TABLE_BIR;
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
 
-	epf = &ep->epf[fn];
 	msix_tbl = epf->epf_bar[bir]->addr + tbl_offset;
 	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
 	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
@@ -485,9 +621,15 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 				  u16 interrupt_num)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	struct device *dev = pcie->dev;
 
 	switch (type) {
 	case PCI_EPC_IRQ_LEGACY:
+		if (vfn > 0) {
+			dev_err(dev, "Cannot raise legacy interrupts for VF\n");
+			return -EINVAL;
+		}
 		return cdns_pcie_ep_send_legacy_irq(ep, fn, vfn, 0);
 
 	case PCI_EPC_IRQ_MSI:
@@ -525,6 +667,13 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	return 0;
 }
 
+static const struct pci_epc_features cdns_pcie_epc_vf_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = true,
+	.align = 65536,
+};
+
 static const struct pci_epc_features cdns_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
@@ -535,7 +684,10 @@ static const struct pci_epc_features cdns_pcie_epc_features = {
 static const struct pci_epc_features*
 cdns_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
-	return &cdns_pcie_epc_features;
+	if (!vfunc_no)
+		return &cdns_pcie_epc_features;
+
+	return &cdns_pcie_epc_vf_features;
 }
 
 static const struct pci_epc_ops cdns_pcie_epc_ops = {
@@ -561,9 +713,11 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
 	struct cdns_pcie *pcie = &ep->pcie;
+	struct cdns_pcie_epf *epf;
 	struct resource *res;
 	struct pci_epc *epc;
 	int ret;
+	int i;
 
 	pcie->is_rc = false;
 
@@ -611,6 +765,25 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	if (!ep->epf)
 		return -ENOMEM;
 
+	epc->max_vfs = devm_kcalloc(dev, epc->max_functions,
+				    sizeof(*epc->max_vfs), GFP_KERNEL);
+	if (!epc->max_vfs)
+		return -ENOMEM;
+
+	ret = of_property_read_u16_array(np, "max-virtual-functions",
+					 epc->max_vfs, epc->max_functions);
+	if (ret == 0) {
+		for (i = 0; i < epc->max_functions; i++) {
+			epf = &ep->epf[i];
+			if (epc->max_vfs[i] == 0)
+				continue;
+			epf->epf = devm_kcalloc(dev, epc->max_vfs[i],
+						sizeof(*ep->epf), GFP_KERNEL);
+			if (!epf->epf)
+				return -ENOMEM;
+		}
+	}
+
 	ret = pci_epc_mem_init(epc, pcie->mem_res->start,
 			       resource_size(pcie->mem_res), PAGE_SIZE);
 	if (ret < 0) {
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index feed1e3038f4..387fa454a5e5 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -50,6 +50,10 @@
 	(CDNS_PCIE_LM_BASE + 0x0240 + (fn) * 0x0008)
 #define CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn) \
 	(CDNS_PCIE_LM_BASE + 0x0244 + (fn) * 0x0008)
+#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn) \
+	(CDNS_PCIE_LM_BASE + 0x0280 + (fn) * 0x0008)
+#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG1(fn) \
+	(CDNS_PCIE_LM_BASE + 0x0284 + (fn) * 0x0008)
 #define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) \
 	(GENMASK(4, 0) << ((b) * 8))
 #define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
@@ -114,6 +118,7 @@
 
 #define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
 #define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET	0xb0
+#define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
 
 /*
  * Root Port Registers (PCI configuration space for the root port function)
@@ -302,9 +307,11 @@ struct cdns_pcie_rc {
 
 /**
  * struct cdns_pcie_epf - Structure to hold info about endpoint function
+ * @epf: Info about virtual functions attached to the physical function
  * @epf_bar: reference to the pci_epf_bar for the six Base Address Registers
  */
 struct cdns_pcie_epf {
+	struct cdns_pcie_epf *epf;
 	struct pci_epf_bar *epf_bar[PCI_STD_NUM_BARS];
 };
 
-- 
2.17.1

