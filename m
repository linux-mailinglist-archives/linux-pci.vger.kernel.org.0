Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5167634868
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfFDNTn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:19:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50622 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfFDNTn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:19:43 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DIaju082539;
        Tue, 4 Jun 2019 08:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654316;
        bh=uIWp4qDbG1NykW532GZzuY4+xF2z8W0k6KDslRvbItM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LIL1u9SMO724vdDX8NYF+Pg4/zioHTzzaoNrixZi2euPxbgXqX5VCGIJAm2LXf3pz
         lUQHQO4qEAOmsICZNAbt+8Kmxu+n5VFiCxzdl+yt8R26VBXNSoh00GoPr7di9EIW76
         rJlOr1JoIsAUR69KZinu7IA3Q75Tb2b+jKmSNBRM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DIaqT044385
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:18:36 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:18:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:18:36 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGa098972;
        Tue, 4 Jun 2019 08:18:31 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 20/30] PCI: endpoint: Add virtual function number in pci_epc  ops
Date:   Tue, 4 Jun 2019 18:45:06 +0530
Message-ID: <20190604131516.13596-21-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add virtual function number in pci_epc ops. EPC controller driver
can perform virtual function specific initialization based on the
virtual function number.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 35 +++++----
 drivers/pci/controller/pcie-cadence-ep.c      | 31 ++++----
 drivers/pci/controller/pcie-rockchip-ep.c     | 18 ++---
 drivers/pci/endpoint/functions/pci-epf-test.c | 64 ++++++++-------
 drivers/pci/endpoint/pci-epc-core.c           | 78 +++++++++++--------
 include/linux/pci-epc.h                       | 48 ++++++------
 6 files changed, 151 insertions(+), 123 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 2bf5a35c0570..c62c5eb48e78 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -73,7 +73,7 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
 	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
 }
 
-static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
+static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				   struct pci_epf_header *hdr)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -146,7 +146,7 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t phys_addr,
 	return 0;
 }
 
-static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
+static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				 struct pci_epf_bar *epf_bar)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -160,7 +160,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
 	clear_bit(atu_index, ep->ib_window_map);
 }
 
-static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
+static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      struct pci_epf_bar *epf_bar)
 {
 	int ret;
@@ -211,7 +211,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	return -EINVAL;
 }
 
-static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
+static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  phys_addr_t addr)
 {
 	int ret;
@@ -227,9 +227,8 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
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
@@ -244,7 +243,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
 	return 0;
 }
 
-static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no)
+static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -263,7 +262,8 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no)
 	return val;
 }
 
-static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
+static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      u8 interrupts)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -283,7 +283,7 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 	return 0;
 }
 
-static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
+static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -302,7 +302,8 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
 	return val;
 }
 
-static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
+static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			       u16 interrupts)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -322,7 +323,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
 	return 0;
 }
 
-static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
+static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -356,7 +357,7 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 }
 
 static const struct pci_epc_features*
-dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 
@@ -426,14 +427,14 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	aligned_offset = msg_addr_lower & (epc->mem->page_size - 1);
 	msg_addr = ((u64)msg_addr_upper) << 32 |
 			(msg_addr_lower & ~aligned_offset);
-	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
+	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->page_size);
 	if (ret)
 		return ret;
 
 	writel(msg_data | (interrupt_num - 1), ep->msi_mem + aligned_offset);
 
-	dw_pcie_ep_unmap_addr(epc, func_no, ep->msi_mem_phys);
+	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
 
 	return 0;
 }
@@ -485,14 +486,14 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 		return -EPERM;
 	}
 
-	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
+	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->page_size);
 	if (ret)
 		return ret;
 
 	writel(msg_data, ep->msi_mem);
 
-	dw_pcie_ep_unmap_addr(epc, func_no, ep->msi_mem_phys);
+	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 23aa5aba1c86..df8fc495ffd9 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -49,7 +49,7 @@ struct cdns_pcie_ep {
 	u8				irq_pending;
 };
 
-static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
+static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
 				     struct pci_epf_header *hdr)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
@@ -80,7 +80,7 @@ static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
+static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 				struct pci_epf_bar *epf_bar)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
@@ -147,7 +147,7 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
+static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 				   struct pci_epf_bar *epf_bar)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
@@ -174,8 +174,8 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar), 0);
 }
 
-static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, phys_addr_t addr,
-				 u64 pci_addr, size_t size)
+static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
+				 phys_addr_t addr, u64 pci_addr, size_t size)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -196,7 +196,7 @@ static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, phys_addr_t addr,
 	return 0;
 }
 
-static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
+static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 				    phys_addr_t addr)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
@@ -216,7 +216,7 @@ static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
 	clear_bit(r, &ep->ob_region_map);
 }
 
-static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 mmc)
+static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 mmc)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -236,7 +236,7 @@ static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 mmc)
 	return 0;
 }
 
-static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
+static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -297,7 +297,8 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
 	writel(0, ep->irq_cpu_addr + offset);
 }
 
-static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 intx)
+static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
+					u8 intx)
 {
 	u16 cmd;
 
@@ -305,17 +306,17 @@ static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 intx)
 	if (cmd & PCI_COMMAND_INTX_DISABLE)
 		return -EINVAL;
 
-	cdns_pcie_ep_assert_intx(ep, fn, intx, true);
+	cdns_pcie_ep_assert_intx(ep, fn, vfn, intx, true);
 	/*
 	 * The mdelay() value was taken from dra7xx_pcie_raise_legacy_irq()
 	 * from drivers/pci/dwc/pci-dra7xx.c
 	 */
 	mdelay(1);
-	cdns_pcie_ep_assert_intx(ep, fn, intx, false);
+	cdns_pcie_ep_assert_intx(ep, fn, vfn, intx, false);
 	return 0;
 }
 
-static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
+static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 				     u8 interrupt_num)
 {
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -371,10 +372,10 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
 
 	switch (type) {
 	case PCI_EPC_IRQ_LEGACY:
-		return cdns_pcie_ep_send_legacy_irq(ep, fn, 0);
+		return cdns_pcie_ep_send_legacy_irq(ep, fn, vfn, 0);
 
 	case PCI_EPC_IRQ_MSI:
-		return cdns_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
+		return cdns_pcie_ep_send_msi_irq(ep, fn, vfn, interrupt_num);
 
 	default:
 		break;
@@ -414,7 +415,7 @@ static const struct pci_epc_features cdns_pcie_epc_features = {
 };
 
 static const struct pci_epc_features*
-cdns_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+cdns_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	return &cdns_pcie_epc_features;
 }
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index d743b0a48988..361d3ec8fa02 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -121,7 +121,7 @@ static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
 			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(r));
 }
 
-static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
+static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vf,
 					 struct pci_epf_header *hdr)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
@@ -158,7 +158,7 @@ static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
+static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vf,
 				    struct pci_epf_bar *epf_bar)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
@@ -226,7 +226,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static void rockchip_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
+static void rockchip_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vf,
 				       struct pci_epf_bar *epf_bar)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
@@ -255,7 +255,7 @@ static void rockchip_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
 			    ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar));
 }
 
-static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn,
+static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vf,
 				     phys_addr_t addr, u64 pci_addr,
 				     size_t size)
 {
@@ -283,7 +283,7 @@ static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
+static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vf,
 					phys_addr_t addr)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
@@ -307,7 +307,7 @@ static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
 	clear_bit(r, &ep->ob_region_map);
 }
 
-static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn,
+static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vf,
 				    u8 multi_msg_cap)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
@@ -328,7 +328,7 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn,
 	return 0;
 }
 
-static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
+static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vf)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
@@ -470,7 +470,7 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 	return 0;
 }
 
-static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
+static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vf,
 				      enum pci_epc_irq_type type,
 				      u16 interrupt_num)
 {
@@ -509,7 +509,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
 };
 
 static const struct pci_epc_features*
-rockchip_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+rockchip_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	return &rockchip_pcie_epc_features;
 }
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 6380641ccc7a..aaa90590984c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -93,8 +93,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, reg->src_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr,
+			       reg->src_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map source address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -109,8 +109,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err_src_map_addr;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, reg->dst_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr,
+			       reg->dst_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map destination address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -119,13 +119,13 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 
 	memcpy(dst_addr, src_addr, reg->size);
 
-	pci_epc_unmap_addr(epc, epf->func_no, dst_phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr);
 
 err_dst_addr:
 	pci_epc_mem_free_addr(epc, dst_phys_addr, dst_addr, reg->size);
 
 err_src_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, src_phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr);
 
 err_src_addr:
 	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
@@ -155,8 +155,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->src_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
+			       reg->src_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -178,7 +178,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
 
 err_addr:
 	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
@@ -207,8 +207,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->dst_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
+			       reg->dst_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -235,7 +235,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
 
 err_addr:
 	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
@@ -257,13 +257,16 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_type,
 
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
@@ -298,7 +301,8 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 
 	if (command & COMMAND_RAISE_LEGACY_IRQ) {
 		reg->status = STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_LEGACY, 0);
+		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
+				  PCI_EPC_IRQ_LEGACY, 0);
 		goto reset_handler;
 	}
 
@@ -336,22 +340,22 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
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
 
@@ -386,7 +390,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 
 		if (epf_test->reg[bar]) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
-			pci_epc_clear_bar(epc, epf->func_no, epf_bar);
+			pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
+					  epf_bar);
 		}
 	}
 }
@@ -410,7 +415,8 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 		if (!!(epc_features->reserved_bar & (1 << bar)))
 			continue;
 
-		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
+				      epf_bar);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
 			dev_err(dev, "Failed to set BAR%d\n", bar);
@@ -503,7 +509,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
 
-	epc_features = pci_epc_get_features(epc, epf->func_no);
+	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
 	if (epc_features) {
 		linkup_notifier = epc_features->linkup_notifier;
 		msix_capable = epc_features->msix_capable;
@@ -515,7 +521,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
 
-	ret = pci_epc_write_header(epc, epf->func_no, header);
+	ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
 	if (ret) {
 		dev_err(dev, "Configuration header write failed\n");
 		return ret;
@@ -530,7 +536,8 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		return ret;
 
 	if (msi_capable) {
-		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
+		ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
+				      epf->msi_interrupts);
 		if (ret) {
 			dev_err(dev, "MSI configuration failed\n");
 			return ret;
@@ -538,7 +545,8 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	}
 
 	if (msix_capable) {
-		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
+		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
+				       epf->msix_interrupts);
 		if (ret) {
 			dev_err(dev, "MSI-X configuration failed\n");
 			return ret;
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 55417504791b..acd74565021b 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -111,13 +111,15 @@ EXPORT_SYMBOL_GPL(pci_epc_get_first_free_bar);
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
 
@@ -128,7 +130,7 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 		return NULL;
 
 	mutex_lock(&epc->lock);
-	epc_features = epc->ops->get_features(epc, func_no);
+	epc_features = epc->ops->get_features(epc, func_no, vfunc_no);
 	mutex_unlock(&epc->lock);
 
 	return epc_features;
@@ -179,13 +181,14 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
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
@@ -197,7 +200,7 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->raise_irq(epc, func_no, type, interrupt_num);
+	ret = epc->ops->raise_irq(epc, func_no, vfunc_no, type, interrupt_num);
 	mutex_unlock(&epc->lock);
 
 	return ret;
@@ -207,11 +210,12 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
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
 
@@ -222,7 +226,7 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	interrupt = epc->ops->get_msi(epc, func_no);
+	interrupt = epc->ops->get_msi(epc, func_no, vfunc_no);
 	mutex_unlock(&epc->lock);
 
 	if (interrupt < 0)
@@ -237,12 +241,13 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msi);
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
@@ -257,7 +262,7 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 	encode_int = order_base_2(interrupts);
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_msi(epc, func_no, encode_int);
+	ret = epc->ops->set_msi(epc, func_no, vfunc_no, encode_int);
 	mutex_unlock(&epc->lock);
 
 	return ret;
@@ -267,11 +272,12 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msi);
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
 
@@ -282,7 +288,7 @@ int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	interrupt = epc->ops->get_msix(epc, func_no);
+	interrupt = epc->ops->get_msix(epc, func_no, vfunc_no);
 	mutex_unlock(&epc->lock);
 
 	if (interrupt < 0)
@@ -295,12 +301,14 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
 /**
  * pci_epc_set_msix() - set the number of MSI-X interrupt numbers required
  * @epc: the EPC device on which MSI-X has to be configured
- * @func_no: the endpoint function number in the EPC device
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  * @interrupts: number of MSI-X interrupts required by the EPF
  *
  * Invoke to set the required number of MSI-X interrupts.
  */
-int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		     u16 interrupts)
 {
 	int ret;
 
@@ -312,7 +320,7 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_msix(epc, func_no, interrupts - 1);
+	ret = epc->ops->set_msix(epc, func_no, vfunc_no, interrupts - 1);
 	mutex_unlock(&epc->lock);
 
 	return ret;
@@ -322,12 +330,13 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
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
@@ -337,7 +346,7 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
 		return;
 
 	mutex_lock(&epc->lock);
-	epc->ops->unmap_addr(epc, func_no, phys_addr);
+	epc->ops->unmap_addr(epc, func_no, vfunc_no, phys_addr);
 	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
@@ -345,14 +354,15 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
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
@@ -364,7 +374,8 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr, size);
+	ret = epc->ops->map_addr(epc, func_no, vfunc_no, phys_addr, pci_addr,
+				 size);
 	mutex_unlock(&epc->lock);
 
 	return ret;
@@ -374,12 +385,13 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
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
@@ -391,7 +403,7 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
 		return;
 
 	mutex_lock(&epc->lock);
-	epc->ops->clear_bar(epc, func_no, epf_bar);
+	epc->ops->clear_bar(epc, func_no, vfunc_no, epf_bar);
 	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
@@ -399,12 +411,13 @@ EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
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
@@ -423,7 +436,7 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_bar(epc, func_no, epf_bar);
+	ret = epc->ops->set_bar(epc, func_no, vfunc_no, epf_bar);
 	mutex_unlock(&epc->lock);
 
 	return ret;
@@ -433,7 +446,8 @@ EXPORT_SYMBOL_GPL(pci_epc_set_bar);
 /**
  * pci_epc_write_header() - write standard configuration header
  * @epc: the EPC device to which the configuration header should be written
- * @func_no: the endpoint function number in the EPC device
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  * @header: standard configuration header fields
  *
  * Invoke to write the configuration header to the endpoint controller. Every
@@ -441,7 +455,7 @@ EXPORT_SYMBOL_GPL(pci_epc_set_bar);
  * configuration header would be written. The callback function should write
  * the header fields to this dedicated location.
  */
-int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
+int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			 struct pci_epf_header *header)
 {
 	int ret;
@@ -453,7 +467,7 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->write_header(epc, func_no, header);
+	ret = epc->ops->write_header(epc, func_no, vfunc_no, header);
 	mutex_unlock(&epc->lock);
 
 	return ret;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index ad118a3f1330..ab389d62ee6c 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -41,26 +41,28 @@ enum pci_epc_irq_type {
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
-	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u16 interrupts);
-	int	(*get_msix)(struct pci_epc *epc, u8 func_no);
-	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
+	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			   u8 interrupts);
+	int	(*get_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			    u16 interrupts);
+	int	(*get_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+	int	(*raise_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
 	int	(*start)(struct pci_epc *epc);
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
-						       u8 func_no);
+						       u8 func_no, u8 vfunc_no);
 	struct module *owner;
 };
 
@@ -162,27 +164,29 @@ void pci_epc_destroy(struct pci_epc *epc);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf);
 void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf);
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
-int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts);
-int pci_epc_get_msix(struct pci_epc *epc, u8 func_no);
-int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
+int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		    u8 interrupts);
+int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		     u16 interrupts);
+int pci_epc_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
-						    u8 func_no);
+						    u8 func_no, u8 vfunc_no);
 unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
 					*epc_features);
 struct pci_epc *pci_epc_get(const char *epc_name);
-- 
2.17.1

