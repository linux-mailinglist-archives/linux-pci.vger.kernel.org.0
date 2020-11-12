Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA34A2B0BC4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 18:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgKLRzM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 12:55:12 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59074 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgKLRzG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 12:55:06 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACHsVH7028214;
        Thu, 12 Nov 2020 11:54:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605203671;
        bh=8+iITJAy33OCpxyBR4hrlYZiFYdw7d25hjSuSCze7l4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TwGdpgCgteK7rFIBH0efWEipHoMaRKKyZ/KHC4435NMgqsbQJpqbg+hp9uMhNlBi2
         Pdxp9HVHExomUQbSq8LEnp1G8KKWO0QtFnMKHTuiazY5HKtf9LPY8Ybi2SdfLxUPTo
         G6exe7wyo+FWVTkgWDSazM8g1ulEgxkfyOApEFYE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACHsVrK006354
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 11:54:31 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 11:54:31 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 11:54:31 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACHrx9u094087;
        Thu, 12 Nov 2020 11:54:25 -0600
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
Subject: [PATCH v2 4/6] PCI: endpoint: Add virtual function number in pci_epc ops
Date:   Thu, 12 Nov 2020 23:23:56 +0530
Message-ID: <20201112175358.2653-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201112175358.2653-1-kishon@ti.com>
References: <20201112175358.2653-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add virtual function number in pci_epc ops. EPC controller driver
can perform virtual function specific initialization based on the
virtual function number.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  |  44 ++---
 .../pci/controller/dwc/pcie-designware-ep.c   |  36 ++--
 drivers/pci/controller/pcie-rcar-ep.c         |  19 +-
 drivers/pci/controller/pcie-rockchip-ep.c     |  18 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  83 +++++----
 drivers/pci/endpoint/functions/pci-epf-test.c |  66 +++----
 drivers/pci/endpoint/pci-epc-core.c           | 164 ++++++++++++++----
 drivers/pci/endpoint/pci-epf-core.c           |  48 ++++-
 include/linux/pci-epc.h                       |  57 +++---
 9 files changed, 351 insertions(+), 184 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 4e4eb30cd1a2..1d171b1f6b1b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -16,7 +16,7 @@
 #define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
 #define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
 
-static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
+static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
 				     struct pci_epf_header *hdr)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
@@ -47,7 +47,7 @@ static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
+static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 				struct pci_epf_bar *epf_bar)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
@@ -117,7 +117,7 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
+static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 				   struct pci_epf_bar *epf_bar)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
@@ -147,8 +147,8 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
 	epf->epf_bar[bar] = NULL;
 }
 
-static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, phys_addr_t addr,
-				 u64 pci_addr, size_t size)
+static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
+				 phys_addr_t addr, u64 pci_addr, size_t size)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -169,7 +169,7 @@ static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, phys_addr_t addr,
 	return 0;
 }
 
-static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
+static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 				    phys_addr_t addr)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
@@ -189,7 +189,7 @@ static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
 	clear_bit(r, &ep->ob_region_map);
 }
 
-static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 mmc)
+static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 mmc)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -209,7 +209,7 @@ static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 mmc)
 	return 0;
 }
 
-static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
+static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -230,7 +230,7 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
 	return mme;
 }
 
-static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
+static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -247,8 +247,9 @@ static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
 	return val;
 }
 
-static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u16 interrupts,
-				 enum pci_barno bir, u32 offset)
+static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
+				 u16 interrupts, enum pci_barno bir,
+				 u32 offset)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -317,7 +318,8 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
 	writel(0, ep->irq_cpu_addr + offset);
 }
 
-static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 intx)
+static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
+					u8 intx)
 {
 	u16 cmd;
 
@@ -334,7 +336,7 @@ static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 intx)
 	return 0;
 }
 
-static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
+static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 				     u8 interrupt_num)
 {
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -382,7 +384,7 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 	return 0;
 }
 
-static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn,
+static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 				    phys_addr_t addr, u8 interrupt_num,
 				    u32 entry_size, u32 *msi_data,
 				    u32 *msi_addr_offset)
@@ -419,7 +421,7 @@ static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn,
 	pci_addr &= GENMASK_ULL(63, 2);
 
 	for (i = 0; i < interrupt_num; i++) {
-		ret = cdns_pcie_ep_map_addr(epc, fn, addr,
+		ret = cdns_pcie_ep_map_addr(epc, fn, vfn, addr,
 					    pci_addr & ~pci_addr_mask,
 					    entry_size);
 		if (ret)
@@ -433,7 +435,7 @@ static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn,
+static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 				      u16 interrupt_num)
 {
 	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
@@ -478,7 +480,7 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn,
 	return 0;
 }
 
-static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
+static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 				  enum pci_epc_irq_type type,
 				  u16 interrupt_num)
 {
@@ -486,13 +488,13 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
 
 	switch (type) {
 	case PCI_EPC_IRQ_LEGACY:
-		return cdns_pcie_ep_send_legacy_irq(ep, fn, 0);
+		return cdns_pcie_ep_send_legacy_irq(ep, fn, vfn, 0);
 
 	case PCI_EPC_IRQ_MSI:
-		return cdns_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
+		return cdns_pcie_ep_send_msi_irq(ep, fn, vfn, interrupt_num);
 
 	case PCI_EPC_IRQ_MSIX:
-		return cdns_pcie_ep_send_msix_irq(ep, fn, interrupt_num);
+		return cdns_pcie_ep_send_msix_irq(ep, fn, vfn, interrupt_num);
 
 	default:
 		break;
@@ -531,7 +533,7 @@ static const struct pci_epc_features cdns_pcie_epc_features = {
 };
 
 static const struct pci_epc_features*
-cdns_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+cdns_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	return &cdns_pcie_epc_features;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index ad7da4ea43a5..0be61840b67a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -124,7 +124,7 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
 	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
 }
 
-static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
+static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				   struct pci_epf_header *hdr)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -201,7 +201,7 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
-static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
+static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				 struct pci_epf_bar *epf_bar)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -216,7 +216,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
 	ep->epf_bar[bar] = NULL;
 }
 
-static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
+static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      struct pci_epf_bar *epf_bar)
 {
 	int ret;
@@ -274,7 +274,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	return -EINVAL;
 }
 
-static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
+static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  phys_addr_t addr)
 {
 	int ret;
@@ -290,9 +290,8 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
 	clear_bit(atu_index, ep->ob_window_map);
 }
 
-static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
-			       phys_addr_t addr,
-			       u64 pci_addr, size_t size)
+static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			       phys_addr_t addr, u64 pci_addr, size_t size)
 {
 	int ret;
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -307,7 +306,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
 	return 0;
 }
 
-static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no)
+static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -331,7 +330,8 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no)
 	return val;
 }
 
-static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
+static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      u8 interrupts)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -356,7 +356,7 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 	return 0;
 }
 
-static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
+static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -380,8 +380,8 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
 	return val;
 }
 
-static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
-			       enum pci_barno bir, u32 offset)
+static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			       u16 interrupts, enum pci_barno bir, u32 offset)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -416,7 +416,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
 	return 0;
 }
 
-static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
+static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -450,7 +450,7 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 }
 
 static const struct pci_epc_features*
-dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 
@@ -525,14 +525,14 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
 	msg_addr = ((u64)msg_addr_upper) << 32 |
 			(msg_addr_lower & ~aligned_offset);
-	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
+	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)
 		return ret;
 
 	writel(msg_data | (interrupt_num - 1), ep->msi_mem + aligned_offset);
 
-	dw_pcie_ep_unmap_addr(epc, func_no, ep->msi_mem_phys);
+	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
 
 	return 0;
 }
@@ -593,14 +593,14 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 
 	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
-	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys,  msg_addr,
+	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)
 		return ret;
 
 	writel(msg_data, ep->msi_mem + aligned_offset);
 
-	dw_pcie_ep_unmap_addr(epc, func_no, ep->msi_mem_phys);
+	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index b4a288e24aaf..6cee4e09acca 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -159,7 +159,7 @@ static int rcar_pcie_ep_get_pdata(struct rcar_pcie_endpoint *ep,
 	return 0;
 }
 
-static int rcar_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
+static int rcar_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
 				     struct pci_epf_header *hdr)
 {
 	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
@@ -195,7 +195,7 @@ static int rcar_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static int rcar_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
+static int rcar_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				struct pci_epf_bar *epf_bar)
 {
 	int flags = epf_bar->flags | LAR_ENABLE | LAM_64BIT;
@@ -246,7 +246,7 @@ static int rcar_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
 	return 0;
 }
 
-static void rcar_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
+static void rcar_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 				   struct pci_epf_bar *epf_bar)
 {
 	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
@@ -259,7 +259,8 @@ static void rcar_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
 	clear_bit(atu_index + 1, ep->ib_window_map);
 }
 
-static int rcar_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 interrupts)
+static int rcar_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
+				u8 interrupts)
 {
 	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
 	struct rcar_pcie *pcie = &ep->pcie;
@@ -272,7 +273,7 @@ static int rcar_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 interrupts)
 	return 0;
 }
 
-static int rcar_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
+static int rcar_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 {
 	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
 	struct rcar_pcie *pcie = &ep->pcie;
@@ -285,7 +286,7 @@ static int rcar_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
 	return ((flags & MSICAP0_MMESE_MASK) >> MSICAP0_MMESE_OFFSET);
 }
 
-static int rcar_pcie_ep_map_addr(struct pci_epc *epc, u8 fn,
+static int rcar_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 				 phys_addr_t addr, u64 pci_addr, size_t size)
 {
 	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
@@ -322,7 +323,7 @@ static int rcar_pcie_ep_map_addr(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static void rcar_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
+static void rcar_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 				    phys_addr_t addr)
 {
 	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
@@ -403,7 +404,7 @@ static int rcar_pcie_ep_assert_msi(struct rcar_pcie *pcie,
 	return 0;
 }
 
-static int rcar_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
+static int rcar_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 				  enum pci_epc_irq_type type,
 				  u16 interrupt_num)
 {
@@ -451,7 +452,7 @@ static const struct pci_epc_features rcar_pcie_epc_features = {
 };
 
 static const struct pci_epc_features*
-rcar_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+rcar_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	return &rcar_pcie_epc_features;
 }
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 7631dc3961c1..5fb9ce6e536e 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -122,7 +122,7 @@ static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
 			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(r));
 }
 
-static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
+static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
 					 struct pci_epf_header *hdr)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
@@ -159,7 +159,7 @@ static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
+static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 				    struct pci_epf_bar *epf_bar)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
@@ -227,7 +227,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static void rockchip_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
+static void rockchip_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 				       struct pci_epf_bar *epf_bar)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
@@ -256,7 +256,7 @@ static void rockchip_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
 			    ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar));
 }
 
-static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn,
+static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 				     phys_addr_t addr, u64 pci_addr,
 				     size_t size)
 {
@@ -284,7 +284,7 @@ static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
+static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 					phys_addr_t addr)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
@@ -308,7 +308,7 @@ static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
 	clear_bit(r, &ep->ob_region_map);
 }
 
-static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn,
+static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
 				    u8 multi_msg_cap)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
@@ -329,7 +329,7 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
+static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
@@ -471,7 +471,7 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 	return 0;
 }
 
-static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
+static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 				      enum pci_epc_irq_type type,
 				      u16 interrupt_num)
 {
@@ -510,7 +510,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
 };
 
 static const struct pci_epc_features*
-rockchip_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+rockchip_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	return &rockchip_pcie_epc_features;
 }
diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index e2dc5cae5c81..69399ad41bc9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -87,6 +87,7 @@ struct epf_ntb {
 
 struct epf_ntb_epc {
 	u8 func_no;
+	u8 vfunc_no;
 	bool linkup;
 	bool is_msix;
 	int msix_bar;
@@ -142,13 +143,14 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 	enum pci_epc_irq_type irq_type;
 	struct epf_ntb_epc *ntb_epc;
 	struct epf_ntb_ctrl *ctrl;
+	u8 func_no, vfunc_no;
 	bool is_msix;
-	u8 func_no;
 	int ret;
 
 	for (type = PRIMARY_INTERFACE; type <= SECONDARY_INTERFACE; type++) {
 		ntb_epc = ntb->epc[type];
 		func_no = ntb_epc->func_no;
+		vfunc_no = ntb_epc->vfunc_no;
 		is_msix = ntb_epc->is_msix;
 		ctrl = ntb_epc->reg;
 		if (link_up)
@@ -156,8 +158,8 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 		else
 			ctrl->link_status &= ~LINK_STATUS_UP;
 		irq_type = is_msix ? PCI_EPC_IRQ_MSIX : PCI_EPC_IRQ_MSI;
-		ret = pci_epc_raise_irq(ntb_epc->epc, func_no, irq_type,
-					1);
+		ret = pci_epc_raise_irq(ntb_epc->epc, func_no, vfunc_no,
+					irq_type, 1);
 		if (ret < 0) {
 			WARN(1, "%s intf: Failed to raise Link Up IRQ\n",
 			     pci_epc_interface_string(type));
@@ -237,10 +239,10 @@ epf_ntb_configure_mw(struct epf_ntb *ntb, enum pci_epc_interface_type type,
 	enum pci_barno peer_barno;
 	struct epf_ntb_ctrl *ctrl;
 	phys_addr_t phys_addr;
+	u8 func_no, vfunc_no;
 	struct pci_epc *epc;
 	u64 addr, size;
 	int ret = 0;
-	u8 func_no;
 
 	ntb_epc = ntb->epc[type];
 	epc = ntb_epc->epc;
@@ -265,8 +267,9 @@ epf_ntb_configure_mw(struct epf_ntb *ntb, enum pci_epc_interface_type type,
 	}
 
 	func_no = ntb_epc->func_no;
+	vfunc_no = ntb_epc->vfunc_no;
 
-	ret = pci_epc_map_addr(epc, func_no, phys_addr, addr, size);
+	ret = pci_epc_map_addr(epc, func_no, vfunc_no, phys_addr, addr, size);
 	WARN(ret < 0, "%s intf: Failed to map memory window %d address\n",
 	     pci_epc_interface_string(type), mw);
 
@@ -293,8 +296,8 @@ epf_ntb_teardown_mw(struct epf_ntb *ntb, enum pci_epc_interface_type type,
 	enum pci_barno peer_barno;
 	struct epf_ntb_ctrl *ctrl;
 	phys_addr_t phys_addr;
+	u8 func_no, vfunc_no;
 	struct pci_epc *epc;
-	u8 func_no;
 
 	ntb_epc = ntb->epc[type];
 	epc = ntb_epc->epc;
@@ -308,8 +311,9 @@ epf_ntb_teardown_mw(struct epf_ntb *ntb, enum pci_epc_interface_type type,
 	if (mw + NTB_MW_OFFSET == BAR_DB_MW1)
 		phys_addr += ctrl->mw1_offset;
 	func_no = ntb_epc->func_no;
+	vfunc_no = ntb_epc->vfunc_no;
 
-	pci_epc_unmap_addr(epc, func_no, phys_addr);
+	pci_epc_unmap_addr(epc, func_no, vfunc_no, phys_addr);
 }
 
 /**
@@ -383,8 +387,8 @@ epf_ntb_configure_msi(struct epf_ntb *ntb, enum pci_epc_interface_type type,
 	struct epf_ntb_ctrl *peer_ctrl;
 	enum pci_barno peer_barno;
 	phys_addr_t phys_addr;
+	u8 func_no, vfunc_no;
 	struct pci_epc *epc;
-	u8 func_no;
 	int ret, i;
 
 	ntb_epc = ntb->epc[type];
@@ -398,8 +402,9 @@ epf_ntb_configure_msi(struct epf_ntb *ntb, enum pci_epc_interface_type type,
 
 	phys_addr = peer_epf_bar->phys_addr;
 	func_no = ntb_epc->func_no;
+	vfunc_no = ntb_epc->vfunc_no;
 
-	ret = pci_epc_map_msi_irq(epc, func_no, phys_addr, db_count,
+	ret = pci_epc_map_msi_irq(epc, func_no, vfunc_no, phys_addr, db_count,
 				  db_entry_size, &db_data, &db_offset);
 	if (ret < 0) {
 		WARN(1, "%s intf: Failed to map MSI IRQ\n",
@@ -488,10 +493,10 @@ static int epf_ntb_configure_msix(struct epf_ntb *ntb,
 	u32 db_entry_size, msg_data;
 	enum pci_barno peer_barno;
 	phys_addr_t phys_addr;
+	u8 func_no, vfunc_no;
 	struct pci_epc *epc;
 	size_t align;
 	u64 msg_addr;
-	u8 func_no;
 	int ret, i;
 
 	ntb_epc = ntb->epc[type];
@@ -509,13 +514,14 @@ static int epf_ntb_configure_msix(struct epf_ntb *ntb,
 	align = epc_features->align;
 
 	func_no = ntb_epc->func_no;
+	vfunc_no = ntb_epc->vfunc_no;
 	db_entry_size = peer_ctrl->db_entry_size;
 
 	for (i = 0; i < db_count; i++) {
 		msg_addr = ALIGN_DOWN(msix_tbl[i].msg_addr, align);
 		msg_data = msix_tbl[i].msg_data;
-		ret = pci_epc_map_addr(epc, func_no, phys_addr, msg_addr,
-				       db_entry_size);
+		ret = pci_epc_map_addr(epc, func_no, vfunc_no, phys_addr,
+				       msg_addr, db_entry_size);
 		if (ret)
 			return ret;
 		phys_addr = phys_addr + db_entry_size;
@@ -573,8 +579,8 @@ epf_ntb_teardown_db(struct epf_ntb *ntb, enum pci_epc_interface_type type)
 	struct pci_epf_bar *peer_epf_bar;
 	enum pci_barno peer_barno;
 	phys_addr_t phys_addr;
+	u8 func_no, vfunc_no;
 	struct pci_epc *epc;
-	u8 func_no;
 
 	ntb_epc = ntb->epc[type];
 	epc = ntb_epc->epc;
@@ -584,8 +590,9 @@ epf_ntb_teardown_db(struct epf_ntb *ntb, enum pci_epc_interface_type type)
 	peer_epf_bar = &peer_ntb_epc->epf_bar[peer_barno];
 	phys_addr = peer_epf_bar->phys_addr;
 	func_no = ntb_epc->func_no;
+	vfunc_no = ntb_epc->vfunc_no;
 
-	pci_epc_unmap_addr(epc, func_no, phys_addr);
+	pci_epc_unmap_addr(epc, func_no, vfunc_no, phys_addr);
 }
 
 /**
@@ -714,14 +721,15 @@ static void epf_ntb_peer_spad_bar_clear(struct epf_ntb_epc *ntb_epc)
 {
 	struct pci_epf_bar *epf_bar;
 	enum pci_barno barno;
+	u8 func_no, vfunc_no;
 	struct pci_epc *epc;
-	u8 func_no;
 
 	epc = ntb_epc->epc;
 	func_no = ntb_epc->func_no;
+	vfunc_no = ntb_epc->vfunc_no;
 	barno = ntb_epc->epf_ntb_bar[BAR_PEER_SPAD];
 	epf_bar = &ntb_epc->epf_bar[barno];
-	pci_epc_clear_bar(epc, func_no, epf_bar);
+	pci_epc_clear_bar(epc, func_no, vfunc_no, epf_bar);
 }
 
 /**
@@ -760,9 +768,9 @@ epf_ntb_peer_spad_bar_set(struct epf_ntb *ntb, enum pci_epc_interface_type type)
 	struct pci_epf_bar *peer_epf_bar, *epf_bar;
 	enum pci_barno peer_barno, barno;
 	u32 peer_spad_offset;
+	u8 func_no, vfunc_no;
 	struct pci_epc *epc;
 	struct device *dev;
-	u8 func_no;
 	int ret;
 
 	dev = &ntb->epf->dev;
@@ -775,6 +783,7 @@ epf_ntb_peer_spad_bar_set(struct epf_ntb *ntb, enum pci_epc_interface_type type)
 	barno = ntb_epc->epf_ntb_bar[BAR_PEER_SPAD];
 	epf_bar = &ntb_epc->epf_bar[barno];
 	func_no = ntb_epc->func_no;
+	vfunc_no = ntb_epc->vfunc_no;
 	epc = ntb_epc->epc;
 
 	peer_spad_offset = peer_ntb_epc->reg->spad_offset;
@@ -783,7 +792,7 @@ epf_ntb_peer_spad_bar_set(struct epf_ntb *ntb, enum pci_epc_interface_type type)
 	epf_bar->barno = barno;
 	epf_bar->flags = PCI_BASE_ADDRESS_MEM_TYPE_32;
 
-	ret = pci_epc_set_bar(ntb_epc->epc, func_no, epf_bar);
+	ret = pci_epc_set_bar(ntb_epc->epc, func_no, vfunc_no, epf_bar);
 	if (ret) {
 		dev_err(dev, "%s intf: peer SPAD BAR set failed\n",
 			pci_epc_interface_string(type));
@@ -826,14 +835,15 @@ static void epf_ntb_config_sspad_bar_clear(struct epf_ntb_epc *ntb_epc)
 {
 	struct pci_epf_bar *epf_bar;
 	enum pci_barno barno;
+	u8 func_no, vfunc_no;
 	struct pci_epc *epc;
-	u8 func_no;
 
 	epc = ntb_epc->epc;
 	func_no = ntb_epc->func_no;
+	vfunc_no = ntb_epc->vfunc_no;
 	barno = ntb_epc->epf_ntb_bar[BAR_CONFIG];
 	epf_bar = &ntb_epc->epf_bar[barno];
-	pci_epc_clear_bar(epc, func_no, epf_bar);
+	pci_epc_clear_bar(epc, func_no, vfunc_no, epf_bar);
 }
 
 /**
@@ -869,10 +879,10 @@ static int epf_ntb_config_sspad_bar_set(struct epf_ntb_epc *ntb_epc)
 {
 	struct pci_epf_bar *epf_bar;
 	enum pci_barno barno;
+	u8 func_no, vfunc_no;
 	struct epf_ntb *ntb;
 	struct pci_epc *epc;
 	struct device *dev;
-	u8 func_no;
 	int ret;
 
 	ntb = ntb_epc->epf_ntb;
@@ -880,10 +890,11 @@ static int epf_ntb_config_sspad_bar_set(struct epf_ntb_epc *ntb_epc)
 
 	epc = ntb_epc->epc;
 	func_no = ntb_epc->func_no;
+	vfunc_no = ntb_epc->vfunc_no;
 	barno = ntb_epc->epf_ntb_bar[BAR_CONFIG];
 	epf_bar = &ntb_epc->epf_bar[barno];
 
-	ret = pci_epc_set_bar(epc, func_no, epf_bar);
+	ret = pci_epc_set_bar(epc, func_no, vfunc_no, epf_bar);
 	if (ret) {
 		dev_err(dev, "%s inft: Config/Status/SPAD BAR set failed\n",
 			pci_epc_interface_string(ntb_epc->type));
@@ -1200,17 +1211,18 @@ static void epf_ntb_db_mw_bar_clear(struct epf_ntb_epc *ntb_epc)
 	struct pci_epf_bar *epf_bar;
 	enum epf_ntb_bar bar;
 	enum pci_barno barno;
+	u8 func_no, vfunc_no;
 	struct pci_epc *epc;
-	u8 func_no;
 
 	epc = ntb_epc->epc;
 
 	func_no = ntb_epc->func_no;
+	vfunc_no = ntb_epc->vfunc_no;
 
 	for (bar = BAR_DB_MW1; bar < BAR_MW4; bar++) {
 		barno = ntb_epc->epf_ntb_bar[bar];
 		epf_bar = &ntb_epc->epf_bar[barno];
-		pci_epc_clear_bar(epc, func_no, epf_bar);
+		pci_epc_clear_bar(epc, func_no, vfunc_no, epf_bar);
 	}
 }
 
@@ -1250,10 +1262,10 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
 	const struct pci_epc_features *epc_features;
 	bool msix_capable, msi_capable;
 	struct epf_ntb_epc *ntb_epc;
+	u8 func_no, vfunc_no;
 	struct pci_epc *epc;
 	struct device *dev;
 	u32 db_count;
-	u8 func_no;
 	int ret;
 
 	ntb_epc = ntb->epc[type];
@@ -1269,6 +1281,7 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
 	}
 
 	func_no = ntb_epc->func_no;
+	vfunc_no = ntb_epc->vfunc_no;
 
 	db_count = ntb->db_count;
 	if (db_count > MAX_DB_COUNT) {
@@ -1280,7 +1293,7 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
 	epc = ntb_epc->epc;
 
 	if (msi_capable) {
-		ret = pci_epc_set_msi(epc, func_no, db_count);
+		ret = pci_epc_set_msi(epc, func_no, vfunc_no, db_count);
 		if (ret) {
 			dev_err(dev, "%s intf: MSI configuration failed\n",
 				pci_epc_interface_string(type));
@@ -1289,7 +1302,7 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
 	}
 
 	if (msix_capable) {
-		ret = pci_epc_set_msix(epc, func_no, db_count,
+		ret = pci_epc_set_msix(epc, func_no, vfunc_no, db_count,
 				       ntb_epc->msix_bar,
 				       ntb_epc->msix_table_offset);
 		if (ret) {
@@ -1409,11 +1422,11 @@ static int epf_ntb_db_mw_bar_init(struct epf_ntb *ntb,
 	u32 num_mws, db_count;
 	enum epf_ntb_bar bar;
 	enum pci_barno barno;
+	u8 func_no, vfunc_no;
 	struct pci_epc *epc;
 	struct device *dev;
 	size_t align;
 	int ret, i;
-	u8 func_no;
 	u64 size;
 
 	ntb_epc = ntb->epc[type];
@@ -1423,6 +1436,7 @@ static int epf_ntb_db_mw_bar_init(struct epf_ntb *ntb,
 	epc_features = ntb_epc->epc_features;
 	align = epc_features->align;
 	func_no = ntb_epc->func_no;
+	vfunc_no = ntb_epc->vfunc_no;
 	epc = ntb_epc->epc;
 	num_mws = ntb->num_mws;
 	db_count = ntb->db_count;
@@ -1447,7 +1461,7 @@ static int epf_ntb_db_mw_bar_init(struct epf_ntb *ntb,
 		barno = ntb_epc->epf_ntb_bar[bar];
 		epf_bar = &ntb_epc->epf_bar[barno];
 
-		ret = pci_epc_set_bar(epc, func_no, epf_bar);
+		ret = pci_epc_set_bar(epc, func_no, vfunc_no, epf_bar);
 		if (ret) {
 			dev_err(dev, "%s intf: DoorBell BAR set failed\n",
 				pci_epc_interface_string(type));
@@ -1519,9 +1533,9 @@ epf_ntb_epc_create_interface(struct epf_ntb *ntb, struct pci_epc *epc,
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar *epf_bar;
 	struct epf_ntb_epc *ntb_epc;
+	u8 func_no, vfunc_no;
 	struct pci_epf *epf;
 	struct device *dev;
-	u8 func_no;
 
 	dev = &ntb->epf->dev;
 
@@ -1530,6 +1544,7 @@ epf_ntb_epc_create_interface(struct epf_ntb *ntb, struct pci_epc *epc,
 		return -ENOMEM;
 
 	epf = ntb->epf;
+	vfunc_no = epf->vfunc_no;
 	if (type == PRIMARY_INTERFACE) {
 		func_no = epf->func_no;
 		epf_bar = epf->bar;
@@ -1541,11 +1556,12 @@ epf_ntb_epc_create_interface(struct epf_ntb *ntb, struct pci_epc *epc,
 	ntb_epc->linkup = false;
 	ntb_epc->epc = epc;
 	ntb_epc->func_no = func_no;
+	ntb_epc->vfunc_no = vfunc_no;
 	ntb_epc->type = type;
 	ntb_epc->epf_bar = epf_bar;
 	ntb_epc->epf_ntb = ntb;
 
-	epc_features = pci_epc_get_features(epc, func_no);
+	epc_features = pci_epc_get_features(epc, func_no, vfunc_no);
 	if (!epc_features)
 		return -EINVAL;
 	ntb_epc->epc_features = epc_features;
@@ -1686,10 +1702,10 @@ static int epf_ntb_epc_init_interface(struct epf_ntb *ntb,
 				      enum pci_epc_interface_type type)
 {
 	struct epf_ntb_epc *ntb_epc;
+	u8 func_no, vfunc_no;
 	struct pci_epc *epc;
 	struct pci_epf *epf;
 	struct device *dev;
-	u8 func_no;
 	int ret;
 
 	ntb_epc = ntb->epc[type];
@@ -1697,6 +1713,7 @@ static int epf_ntb_epc_init_interface(struct epf_ntb *ntb,
 	dev = &epf->dev;
 	epc = ntb_epc->epc;
 	func_no = ntb_epc->func_no;
+	vfunc_no = ntb_epc->vfunc_no;
 
 	ret = epf_ntb_config_sspad_bar_set(ntb->epc[type]);
 	if (ret) {
@@ -1726,7 +1743,7 @@ static int epf_ntb_epc_init_interface(struct epf_ntb *ntb,
 		goto err_db_mw_bar_init;
 	}
 
-	ret = pci_epc_write_header(epc, func_no, epf->header);
+	ret = pci_epc_write_header(epc, func_no, vfunc_no, epf->header);
 	if (ret) {
 		dev_err(dev, "%s intf: Configuration header write failed\n",
 			pci_epc_interface_string(type));
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index c0ac4e9cbe72..b588c94d97e9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -247,8 +247,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, reg->src_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr,
+			       reg->src_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map source address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -263,8 +263,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err_src_map_addr;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, reg->dst_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr,
+			       reg->dst_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map destination address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -291,13 +291,13 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, dst_phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr);
 
 err_dst_addr:
 	pci_epc_mem_free_addr(epc, dst_phys_addr, dst_addr, reg->size);
 
 err_src_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, src_phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr);
 
 err_src_addr:
 	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
@@ -331,8 +331,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->src_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
+			       reg->src_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -386,7 +386,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
 
 err_addr:
 	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
@@ -419,8 +419,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->dst_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
+			       reg->dst_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -479,7 +479,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
 
 err_addr:
 	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
@@ -501,13 +501,16 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_type,
 
 	switch (irq_type) {
 	case IRQ_TYPE_LEGACY:
-		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_LEGACY, 0);
+		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
+				  PCI_EPC_IRQ_LEGACY, 0);
 		break;
 	case IRQ_TYPE_MSI:
-		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI, irq);
+		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
+				  PCI_EPC_IRQ_MSI, irq);
 		break;
 	case IRQ_TYPE_MSIX:
-		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSIX, irq);
+		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
+				  PCI_EPC_IRQ_MSIX, irq);
 		break;
 	default:
 		dev_err(dev, "Failed to raise IRQ, unknown type\n");
@@ -542,7 +545,8 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 
 	if (command & COMMAND_RAISE_LEGACY_IRQ) {
 		reg->status = STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_LEGACY, 0);
+		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
+				  PCI_EPC_IRQ_LEGACY, 0);
 		goto reset_handler;
 	}
 
@@ -580,22 +584,22 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	}
 
 	if (command & COMMAND_RAISE_MSI_IRQ) {
-		count = pci_epc_get_msi(epc, epf->func_no);
+		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
 		if (reg->irq_number > count || count <= 0)
 			goto reset_handler;
 		reg->status = STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI,
-				  reg->irq_number);
+		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
+				  PCI_EPC_IRQ_MSI, reg->irq_number);
 		goto reset_handler;
 	}
 
 	if (command & COMMAND_RAISE_MSIX_IRQ) {
-		count = pci_epc_get_msix(epc, epf->func_no);
+		count = pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
 		if (reg->irq_number > count || count <= 0)
 			goto reset_handler;
 		reg->status = STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSIX,
-				  reg->irq_number);
+		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
+				  PCI_EPC_IRQ_MSIX, reg->irq_number);
 		goto reset_handler;
 	}
 
@@ -618,7 +622,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		epf_bar = &epf->bar[bar];
 
 		if (epf_test->reg[bar]) {
-			pci_epc_clear_bar(epc, epf->func_no, epf_bar);
+			pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
+					  epf_bar);
 			pci_epf_free_space(epf, epf_test->reg[bar], bar,
 					   PRIMARY_INTERFACE);
 		}
@@ -650,7 +655,8 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 		if (!!(epc_features->reserved_bar & (1 << bar)))
 			continue;
 
-		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
+				      epf_bar);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar,
 					   PRIMARY_INTERFACE);
@@ -674,13 +680,13 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 	bool msi_capable = true;
 	int ret;
 
-	epc_features = pci_epc_get_features(epc, epf->func_no);
+	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
 	if (epc_features) {
 		msix_capable = epc_features->msix_capable;
 		msi_capable = epc_features->msi_capable;
 	}
 
-	ret = pci_epc_write_header(epc, epf->func_no, header);
+	ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
 	if (ret) {
 		dev_err(dev, "Configuration header write failed\n");
 		return ret;
@@ -691,7 +697,8 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 		return ret;
 
 	if (msi_capable) {
-		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
+		ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
+				      epf->msi_interrupts);
 		if (ret) {
 			dev_err(dev, "MSI configuration failed\n");
 			return ret;
@@ -699,7 +706,8 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 	}
 
 	if (msix_capable) {
-		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts,
+		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
+				       epf->msix_interrupts,
 				       epf_test->test_reg_bar,
 				       epf_test->msix_table_offset);
 		if (ret) {
@@ -832,7 +840,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
 
-	epc_features = pci_epc_get_features(epc, epf->func_no);
+	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
 	if (epc_features) {
 		linkup_notifier = epc_features->linkup_notifier;
 		core_init_notifier = epc_features->core_init_notifier;
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index fe6d23849502..bff3e1f40e27 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -137,24 +137,32 @@ EXPORT_SYMBOL_GPL(pci_epc_get_next_free_bar);
  * @epc: the features supported by *this* EPC device will be returned
  * @func_no: the features supported by the EPC device specific to the
  *	     endpoint function with func_no will be returned
+ * @vfunc_no: the features supported by the EPC device specific to the
+ *	     virtual endpoint function with vfunc_no will be returned
  *
  * Invoke to get the features provided by the EPC which may be
  * specific to an endpoint function. Returns pci_epc_features on success
  * and NULL for any failures.
  */
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
-						    u8 func_no)
+						    u8 func_no, u8 vfunc_no)
 {
 	const struct pci_epc_features *epc_features;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return NULL;
 
+	if (vfunc_no > 0 && !epc->max_vfs)
+		return NULL;
+
+	if (vfunc_no > epc->max_vfs[func_no])
+		return NULL;
+
 	if (!epc->ops->get_features)
 		return NULL;
 
 	mutex_lock(&epc->lock);
-	epc_features = epc->ops->get_features(epc, func_no);
+	epc_features = epc->ops->get_features(epc, func_no, vfunc_no);
 	mutex_unlock(&epc->lock);
 
 	return epc_features;
@@ -205,13 +213,14 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
 /**
  * pci_epc_raise_irq() - interrupt the host system
  * @epc: the EPC device which has to interrupt the host
- * @func_no: the endpoint function number in the EPC device
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  * @type: specify the type of interrupt; legacy, MSI or MSI-X
  * @interrupt_num: the MSI or MSI-X interrupt number
  *
  * Invoke to raise an legacy, MSI or MSI-X interrupt
  */
-int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
+int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	int ret;
@@ -219,11 +228,17 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
 
+	if (vfunc_no > 0 && !epc->max_vfs)
+		return -EINVAL;
+
+	if (vfunc_no > epc->max_vfs[func_no])
+		return -EINVAL;
+
 	if (!epc->ops->raise_irq)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->raise_irq(epc, func_no, type, interrupt_num);
+	ret = epc->ops->raise_irq(epc, func_no, vfunc_no, type, interrupt_num);
 	mutex_unlock(&epc->lock);
 
 	return ret;
@@ -235,6 +250,7 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
  *                         MSI data
  * @epc: the EPC device which has the MSI capability
  * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  * @phys_addr: the physical address of the outbound region
  * @interrupt_num: the MSI interrupt number
  * @entry_size: Size of Outbound address region for each interrupt
@@ -250,21 +266,28 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
  * physical address (in outbound region) of the other interface to ring
  * doorbell.
  */
-int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, phys_addr_t phys_addr,
-			u8 interrupt_num, u32 entry_size, u32 *msi_data,
-			u32 *msi_addr_offset)
+int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			phys_addr_t phys_addr, u8 interrupt_num, u32 entry_size,
+			u32 *msi_data, u32 *msi_addr_offset)
 {
 	int ret;
 
 	if (IS_ERR_OR_NULL(epc))
 		return -EINVAL;
 
+	if (vfunc_no > 0 && !epc->max_vfs)
+		return -EINVAL;
+
+	if (vfunc_no > epc->max_vfs[func_no])
+		return -EINVAL;
+
 	if (!epc->ops->map_msi_irq)
 		return -EINVAL;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->map_msi_irq(epc, func_no, phys_addr, interrupt_num,
-				    entry_size, msi_data, msi_addr_offset);
+	ret = epc->ops->map_msi_irq(epc, func_no, vfunc_no, phys_addr,
+				    interrupt_num, entry_size, msi_data,
+				    msi_addr_offset);
 	mutex_unlock(&epc->lock);
 
 	return ret;
@@ -274,22 +297,29 @@ EXPORT_SYMBOL_GPL(pci_epc_map_msi_irq);
 /**
  * pci_epc_get_msi() - get the number of MSI interrupt numbers allocated
  * @epc: the EPC device to which MSI interrupts was requested
- * @func_no: the endpoint function number in the EPC device
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  *
  * Invoke to get the number of MSI interrupts allocated by the RC
  */
-int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
+int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	int interrupt;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return 0;
 
+	if (vfunc_no > 0 && !epc->max_vfs)
+		return -EINVAL;
+
+	if (vfunc_no > epc->max_vfs[func_no])
+		return -EINVAL;
+
 	if (!epc->ops->get_msi)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	interrupt = epc->ops->get_msi(epc, func_no);
+	interrupt = epc->ops->get_msi(epc, func_no, vfunc_no);
 	mutex_unlock(&epc->lock);
 
 	if (interrupt < 0)
@@ -304,12 +334,13 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msi);
 /**
  * pci_epc_set_msi() - set the number of MSI interrupt numbers required
  * @epc: the EPC device on which MSI has to be configured
- * @func_no: the endpoint function number in the EPC device
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  * @interrupts: number of MSI interrupts required by the EPF
  *
  * Invoke to set the required number of MSI interrupts.
  */
-int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
+int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 interrupts)
 {
 	int ret;
 	u8 encode_int;
@@ -318,13 +349,19 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 	    interrupts > 32)
 		return -EINVAL;
 
+	if (vfunc_no > 0 && !epc->max_vfs)
+		return -EINVAL;
+
+	if (vfunc_no > epc->max_vfs[func_no])
+		return -EINVAL;
+
 	if (!epc->ops->set_msi)
 		return 0;
 
 	encode_int = order_base_2(interrupts);
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_msi(epc, func_no, encode_int);
+	ret = epc->ops->set_msi(epc, func_no, vfunc_no, encode_int);
 	mutex_unlock(&epc->lock);
 
 	return ret;
@@ -334,22 +371,29 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msi);
 /**
  * pci_epc_get_msix() - get the number of MSI-X interrupt numbers allocated
  * @epc: the EPC device to which MSI-X interrupts was requested
- * @func_no: the endpoint function number in the EPC device
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  *
  * Invoke to get the number of MSI-X interrupts allocated by the RC
  */
-int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
+int pci_epc_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	int interrupt;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return 0;
 
+	if (vfunc_no > 0 && !epc->max_vfs)
+		return -EINVAL;
+
+	if (vfunc_no > epc->max_vfs[func_no])
+		return -EINVAL;
+
 	if (!epc->ops->get_msix)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	interrupt = epc->ops->get_msix(epc, func_no);
+	interrupt = epc->ops->get_msix(epc, func_no, vfunc_no);
 	mutex_unlock(&epc->lock);
 
 	if (interrupt < 0)
@@ -362,15 +406,16 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
 /**
  * pci_epc_set_msix() - set the number of MSI-X interrupt numbers required
  * @epc: the EPC device on which MSI-X has to be configured
- * @func_no: the endpoint function number in the EPC device
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  * @interrupts: number of MSI-X interrupts required by the EPF
  * @bir: BAR where the MSI-X table resides
  * @offset: Offset pointing to the start of MSI-X table
  *
  * Invoke to set the required number of MSI-X interrupts.
  */
-int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
-		     enum pci_barno bir, u32 offset)
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		     u16 interrupts, enum pci_barno bir, u32 offset)
 {
 	int ret;
 
@@ -378,11 +423,18 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
 	    interrupts < 1 || interrupts > 2048)
 		return -EINVAL;
 
+	if (vfunc_no > 0 && !epc->max_vfs)
+		return -EINVAL;
+
+	if (vfunc_no > epc->max_vfs[func_no])
+		return -EINVAL;
+
 	if (!epc->ops->set_msix)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_msix(epc, func_no, interrupts - 1, bir, offset);
+	ret = epc->ops->set_msix(epc, func_no, vfunc_no, interrupts - 1, bir,
+				 offset);
 	mutex_unlock(&epc->lock);
 
 	return ret;
@@ -392,22 +444,29 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
 /**
  * pci_epc_unmap_addr() - unmap CPU address from PCI address
  * @epc: the EPC device on which address is allocated
- * @func_no: the endpoint function number in the EPC device
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  * @phys_addr: physical address of the local system
  *
  * Invoke to unmap the CPU address from PCI address.
  */
-void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
+void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			phys_addr_t phys_addr)
 {
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return;
 
+	if (vfunc_no > 0 && !epc->max_vfs)
+		return;
+
+	if (vfunc_no > epc->max_vfs[func_no])
+		return;
+
 	if (!epc->ops->unmap_addr)
 		return;
 
 	mutex_lock(&epc->lock);
-	epc->ops->unmap_addr(epc, func_no, phys_addr);
+	epc->ops->unmap_addr(epc, func_no, vfunc_no, phys_addr);
 	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
@@ -415,14 +474,15 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
 /**
  * pci_epc_map_addr() - map CPU address to PCI address
  * @epc: the EPC device on which address is allocated
- * @func_no: the endpoint function number in the EPC device
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  * @phys_addr: physical address of the local system
  * @pci_addr: PCI address to which the physical address should be mapped
  * @size: the size of the allocation
  *
  * Invoke to map CPU address with PCI address.
  */
-int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
+int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		     phys_addr_t phys_addr, u64 pci_addr, size_t size)
 {
 	int ret;
@@ -430,11 +490,18 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
 
+	if (vfunc_no > 0 && !epc->max_vfs)
+		return -EINVAL;
+
+	if (vfunc_no > epc->max_vfs[func_no])
+		return -EINVAL;
+
 	if (!epc->ops->map_addr)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr, size);
+	ret = epc->ops->map_addr(epc, func_no, vfunc_no, phys_addr, pci_addr,
+				 size);
 	mutex_unlock(&epc->lock);
 
 	return ret;
@@ -444,12 +511,13 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
 /**
  * pci_epc_clear_bar() - reset the BAR
  * @epc: the EPC device for which the BAR has to be cleared
- * @func_no: the endpoint function number in the EPC device
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  * @epf_bar: the struct epf_bar that contains the BAR information
  *
  * Invoke to reset the BAR of the endpoint device.
  */
-void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
+void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		       struct pci_epf_bar *epf_bar)
 {
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
@@ -457,11 +525,17 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
 	     epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
 		return;
 
+	if (vfunc_no > 0 && !epc->max_vfs)
+		return;
+
+	if (vfunc_no > epc->max_vfs[func_no])
+		return;
+
 	if (!epc->ops->clear_bar)
 		return;
 
 	mutex_lock(&epc->lock);
-	epc->ops->clear_bar(epc, func_no, epf_bar);
+	epc->ops->clear_bar(epc, func_no, vfunc_no, epf_bar);
 	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
@@ -469,12 +543,13 @@ EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
 /**
  * pci_epc_set_bar() - configure BAR in order for host to assign PCI addr space
  * @epc: the EPC device on which BAR has to be configured
- * @func_no: the endpoint function number in the EPC device
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  * @epf_bar: the struct epf_bar that contains the BAR information
  *
  * Invoke to configure the BAR of the endpoint device.
  */
-int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
+int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		    struct pci_epf_bar *epf_bar)
 {
 	int ret;
@@ -489,11 +564,17 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
 	     !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64)))
 		return -EINVAL;
 
+	if (vfunc_no > 0 && !epc->max_vfs)
+		return -EINVAL;
+
+	if (vfunc_no > epc->max_vfs[func_no])
+		return -EINVAL;
+
 	if (!epc->ops->set_bar)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_bar(epc, func_no, epf_bar);
+	ret = epc->ops->set_bar(epc, func_no, vfunc_no, epf_bar);
 	mutex_unlock(&epc->lock);
 
 	return ret;
@@ -503,7 +584,8 @@ EXPORT_SYMBOL_GPL(pci_epc_set_bar);
 /**
  * pci_epc_write_header() - write standard configuration header
  * @epc: the EPC device to which the configuration header should be written
- * @func_no: the endpoint function number in the EPC device
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  * @header: standard configuration header fields
  *
  * Invoke to write the configuration header to the endpoint controller. Every
@@ -511,7 +593,7 @@ EXPORT_SYMBOL_GPL(pci_epc_set_bar);
  * configuration header would be written. The callback function should write
  * the header fields to this dedicated location.
  */
-int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
+int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			 struct pci_epf_header *header)
 {
 	int ret;
@@ -519,11 +601,17 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
 
+	if (vfunc_no > 0 && !epc->max_vfs)
+		return -EINVAL;
+
+	if (vfunc_no > epc->max_vfs[func_no])
+		return -EINVAL;
+
 	if (!epc->ops->write_header)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->write_header(epc, func_no, header);
+	ret = epc->ops->write_header(epc, func_no, vfunc_no, header);
 	mutex_unlock(&epc->lock);
 
 	return ret;
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 3f1271a63be5..ff39b54e5d05 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -90,11 +90,14 @@ EXPORT_SYMBOL_GPL(pci_epf_unbind);
  */
 int pci_epf_bind(struct pci_epf *epf)
 {
+	struct device *dev = &epf->dev;
 	struct pci_epf *epf_vf;
+	u8 func_no, vfunc_no;
+	struct pci_epc *epc;
 	int ret;
 
 	if (!epf->driver) {
-		dev_WARN(&epf->dev, "epf device not bound to driver\n");
+		dev_WARN(dev, "epf device not bound to driver\n");
 		return -EINVAL;
 	}
 
@@ -103,7 +106,50 @@ int pci_epf_bind(struct pci_epf *epf)
 
 	mutex_lock(&epf->lock);
 	list_for_each_entry(epf_vf, &epf->pci_vepf, list) {
+		vfunc_no = epf_vf->vfunc_no;
+
+		if (vfunc_no < 1) {
+			dev_err(dev, "Invalid virtual function number\n");
+			ret = -EINVAL;
+			goto ret;
+		}
+
+		epc = epf->epc;
+		func_no = epf->func_no;
+		if (!IS_ERR_OR_NULL(epc)) {
+			if (!epc->max_vfs) {
+				dev_err(dev, "No support for virt function\n");
+				ret = -EINVAL;
+				goto ret;
+			}
+
+			if (vfunc_no > epc->max_vfs[func_no]) {
+				dev_err(dev, "PF%d: Exceeds max vfunc number\n",
+					func_no);
+				ret = -EINVAL;
+				goto ret;
+			}
+		}
+
+		epc = epf->sec_epc;
+		func_no = epf->sec_epc_func_no;
+		if (!IS_ERR_OR_NULL(epc)) {
+			if (!epc->max_vfs) {
+				dev_err(dev, "No support for virt function\n");
+				ret = -EINVAL;
+				goto ret;
+			}
+
+			if (vfunc_no > epc->max_vfs[func_no]) {
+				dev_err(dev, "PF%d: Exceeds max vfunc number\n",
+					func_no);
+				ret = -EINVAL;
+				goto ret;
+			}
+		}
+
 		epf_vf->func_no = epf->func_no;
+		epf_vf->sec_epc_func_no = epf->sec_epc_func_no;
 		epf_vf->epc = epf->epc;
 		epf_vf->sec_epc = epf->sec_epc;
 		ret = epf_vf->driver->ops->bind(epf_vf);
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index b82c9b100e97..9c2136781565 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -61,31 +61,32 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
-	int	(*write_header)(struct pci_epc *epc, u8 func_no,
+	int	(*write_header)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				struct pci_epf_header *hdr);
-	int	(*set_bar)(struct pci_epc *epc, u8 func_no,
+	int	(*set_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			   struct pci_epf_bar *epf_bar);
-	void	(*clear_bar)(struct pci_epc *epc, u8 func_no,
+	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			     struct pci_epf_bar *epf_bar);
-	int	(*map_addr)(struct pci_epc *epc, u8 func_no,
+	int	(*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			    phys_addr_t addr, u64 pci_addr, size_t size);
-	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no,
+	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      phys_addr_t addr);
-	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 interrupts);
-	int	(*get_msi)(struct pci_epc *epc, u8 func_no);
-	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u16 interrupts,
-			    enum pci_barno, u32 offset);
-	int	(*get_msix)(struct pci_epc *epc, u8 func_no);
-	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
+	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			   u8 interrupts);
+	int	(*get_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			    u16 interrupts, enum pci_barno, u32 offset);
+	int	(*get_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+	int	(*raise_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
-	int	(*map_msi_irq)(struct pci_epc *epc, u8 func_no,
+	int	(*map_msi_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			       phys_addr_t phys_addr, u8 interrupt_num,
 			       u32 entry_size, u32 *msi_data,
 			       u32 *msi_addr_offset);
 	int	(*start)(struct pci_epc *epc);
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
-						       u8 func_no);
+						       u8 func_no, u8 vfunc_no);
 	struct module *owner;
 };
 
@@ -127,6 +128,8 @@ struct pci_epc_mem {
  *       single window.
  * @num_windows: number of windows supported by device
  * @max_functions: max number of functions that can be configured in this EPC
+ * @max_vfs: Array indicating the maximum number of virtual functions that can
+ *   be associated with each physical function
  * @group: configfs group representing the PCI EPC device
  * @lock: mutex to protect pci_epc ops
  * @function_num_map: bitmap to manage physical function number
@@ -140,6 +143,7 @@ struct pci_epc {
 	struct pci_epc_mem		*mem;
 	unsigned int			num_windows;
 	u8				max_functions;
+	u16				*max_vfs;
 	struct config_group		*group;
 	/* mutex to protect against concurrent access of EP controller */
 	struct mutex			lock;
@@ -205,31 +209,32 @@ void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
-int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
+int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			 struct pci_epf_header *hdr);
-int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
+int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		    struct pci_epf_bar *epf_bar);
-void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
+void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		       struct pci_epf_bar *epf_bar);
-int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
+int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		     phys_addr_t phys_addr,
 		     u64 pci_addr, size_t size);
-void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
+void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			phys_addr_t phys_addr);
-int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts);
-int pci_epc_get_msi(struct pci_epc *epc, u8 func_no);
-int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
-		     enum pci_barno, u32 offset);
-int pci_epc_get_msix(struct pci_epc *epc, u8 func_no);
-int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no,
+int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		    u8 interrupts);
+int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		     u16 interrupts, enum pci_barno, u32 offset);
+int pci_epc_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			phys_addr_t phys_addr, u8 interrupt_num,
 			u32 entry_size, u32 *msi_data, u32 *msi_addr_offset);
-int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
+int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
-						    u8 func_no);
+						    u8 func_no, u8 vfunc_no);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.17.1

