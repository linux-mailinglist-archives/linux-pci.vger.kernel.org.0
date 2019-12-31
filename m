Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BFA12D857
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 12:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfLaLei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 06:34:38 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44956 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLaLei (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 06:34:38 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVBY6AO027186;
        Tue, 31 Dec 2019 05:34:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577792046;
        bh=8G0yxVHx0MSzllfsDhLuBDiJDTJwb6Mj9m9ztEj1uLE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xmV3sRIHfjxinAYpfrslb+shoEDhyDUW7QB3HvcsEQMhonW26RP8LVz0SjWdMLteC
         896yhIrchaN1zxlAJ8n0HnFUaXD/ngKTSXMwXTTDGnc7DjOYxN6u9VGrbUm2qrKY30
         +ZRMyF8UysQZenWzQzhGe70iVHMAFp289+JaQODA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBVBY606123940
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Dec 2019 05:34:06 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 05:34:06 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 05:34:06 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVBXX36024759;
        Tue, 31 Dec 2019 05:34:01 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 5/7] PCI: endpoint: Add virtual function number in pci_epc ops
Date:   Tue, 31 Dec 2019 17:05:32 +0530
Message-ID: <20191231113534.30405-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231113534.30405-1-kishon@ti.com>
References: <20191231113534.30405-1-kishon@ti.com>
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
 .../pci/controller/cadence/pcie-cadence-ep.c  |  31 ++---
 .../pci/controller/dwc/pcie-designware-ep.c   |  36 ++---
 drivers/pci/controller/pcie-rockchip-ep.c     |  18 +--
 drivers/pci/endpoint/functions/pci-epf-test.c |  64 +++++----
 drivers/pci/endpoint/pci-epc-core.c           | 124 +++++++++++++-----
 include/linux/pci-epc.h                       |  53 ++++----
 6 files changed, 199 insertions(+), 127 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 26cb492fdb81..673224e2e314 100644
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
@@ -332,7 +333,7 @@ static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 intx)
 	return 0;
 }
 
-static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
+static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 				     u8 interrupt_num)
 {
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -430,7 +431,7 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn,
 	return 0;
 }
 
-static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
+static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 				  enum pci_epc_irq_type type,
 				  u16 interrupt_num)
 {
@@ -441,7 +442,7 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
 		return cdns_pcie_ep_send_legacy_irq(ep, fn, 0);
 
 	case PCI_EPC_IRQ_MSI:
-		return cdns_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
+		return cdns_pcie_ep_send_msi_irq(ep, fn, vfn, interrupt_num);
 
 	case PCI_EPC_IRQ_MSIX:
 		return cdns_pcie_ep_send_msix_irq(ep, fn, interrupt_num);
@@ -487,7 +488,7 @@ static const struct pci_epc_features cdns_pcie_epc_features = {
 };
 
 static const struct pci_epc_features*
-cdns_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+cdns_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	return &cdns_pcie_epc_features;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index b61e47365456..e9a9d0c4ade4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -40,7 +40,7 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 	__dw_pcie_ep_reset_bar(pci, bar, 0);
 }
 
-static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
+static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				   struct pci_epf_header *hdr)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -113,7 +113,7 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t phys_addr,
 	return 0;
 }
 
-static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
+static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				 struct pci_epf_bar *epf_bar)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -128,7 +128,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
 	ep->epf_bar[bar] = NULL;
 }
 
-static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
+static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      struct pci_epf_bar *epf_bar)
 {
 	int ret;
@@ -180,7 +180,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	return -EINVAL;
 }
 
-static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
+static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  phys_addr_t addr)
 {
 	int ret;
@@ -196,9 +196,8 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
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
@@ -213,7 +212,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
 	return 0;
 }
 
-static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no)
+static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -232,7 +231,8 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no)
 	return val;
 }
 
-static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
+static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      u8 interrupts)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -252,7 +252,7 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 	return 0;
 }
 
-static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
+static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -271,8 +271,8 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
 	return val;
 }
 
-static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
-			       enum pci_barno bir, u32 offset)
+static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			       u16 interrupts, enum pci_barno bir, u32 offset)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -302,7 +302,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
 	return 0;
 }
 
-static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
+static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -336,7 +336,7 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 }
 
 static const struct pci_epc_features*
-dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 
@@ -406,14 +406,14 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
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
@@ -451,14 +451,14 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 
 	aligned_offset = msg_addr & (epc->mem->page_size - 1);
-	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys,  msg_addr,
+	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys,  msg_addr,
 				  epc->mem->page_size);
 	if (ret)
 		return ret;
 
 	writel(msg_data, ep->msi_mem + aligned_offset);
 
-	dw_pcie_ep_unmap_addr(epc, func_no, ep->msi_mem_phys);
+	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
 
 	return 0;
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
index 8de33219a364..5a3a698b6daa 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -94,8 +94,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, reg->src_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr,
+			       reg->src_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map source address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -110,8 +110,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err_src_map_addr;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, reg->dst_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr,
+			       reg->dst_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map destination address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -120,13 +120,13 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 
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
@@ -156,8 +156,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->src_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
+			       reg->src_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -179,7 +179,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
 
 err_addr:
 	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
@@ -208,8 +208,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->dst_addr,
-			       reg->size);
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
+			       reg->dst_addr, reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -236,7 +236,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
 
 err_addr:
 	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
@@ -258,13 +258,16 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_type,
 
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
@@ -299,7 +302,8 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 
 	if (command & COMMAND_RAISE_LEGACY_IRQ) {
 		reg->status = STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_LEGACY, 0);
+		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
+				  PCI_EPC_IRQ_LEGACY, 0);
 		goto reset_handler;
 	}
 
@@ -337,22 +341,22 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
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
 		epf_bar = &epf->bar[bar];
 
 		if (epf_test->reg[bar]) {
-			pci_epc_clear_bar(epc, epf->func_no, epf_bar);
+			pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
+					  epf_bar);
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
 		}
 	}
@@ -417,7 +422,8 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 		if (!!(epc_features->reserved_bar & (1 << bar)))
 			continue;
 
-		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
+				      epf_bar);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
 			dev_err(dev, "Failed to set BAR%d\n", bar);
@@ -525,7 +531,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
 
-	epc_features = pci_epc_get_features(epc, epf->func_no);
+	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
 	if (epc_features) {
 		linkup_notifier = epc_features->linkup_notifier;
 		msix_capable = epc_features->msix_capable;
@@ -537,7 +543,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
 
-	ret = pci_epc_write_header(epc, epf->func_no, header);
+	ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
 	if (ret) {
 		dev_err(dev, "Configuration header write failed\n");
 		return ret;
@@ -552,7 +558,8 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		return ret;
 
 	if (msi_capable) {
-		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
+		ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
+				      epf->msi_interrupts);
 		if (ret) {
 			dev_err(dev, "MSI configuration failed\n");
 			return ret;
@@ -560,7 +567,8 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	}
 
 	if (msix_capable) {
-		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts,
+		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
+				       epf->msix_interrupts,
 				       epf_test->test_reg_bar,
 				       epf_test->msix_table_offset);
 		if (ret) {
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index fef8a212cbd9..9b0cc8a8f639 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -111,24 +111,30 @@ EXPORT_SYMBOL_GPL(pci_epc_get_first_free_bar);
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
 
+	if (vfunc_no > 0 && !WARN_ON(!epc->max_vfs) &&
+	    vfunc_no > epc->max_vfs[func_no])
+		return NULL;
+
 	if (!epc->ops->get_features)
 		return NULL;
 
 	mutex_lock(&epc->lock);
-	epc_features = epc->ops->get_features(epc, func_no);
+	epc_features = epc->ops->get_features(epc, func_no, vfunc_no);
 	mutex_unlock(&epc->lock);
 
 	return epc_features;
@@ -179,13 +185,14 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
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
@@ -193,11 +200,15 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
 
+	if (vfunc_no > 0 && !WARN_ON(!epc->max_vfs) &&
+	    vfunc_no > epc->max_vfs[func_no])
+		return -EINVAL;
+
 	if (!epc->ops->raise_irq)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->raise_irq(epc, func_no, type, interrupt_num);
+	ret = epc->ops->raise_irq(epc, func_no, vfunc_no, type, interrupt_num);
 	mutex_unlock(&epc->lock);
 
 	return ret;
@@ -207,22 +218,27 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
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
 
+	if (vfunc_no > 0 && !WARN_ON(!epc->max_vfs) &&
+	    vfunc_no > epc->max_vfs[func_no])
+		return 0;
+
 	if (!epc->ops->get_msi)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	interrupt = epc->ops->get_msi(epc, func_no);
+	interrupt = epc->ops->get_msi(epc, func_no, vfunc_no);
 	mutex_unlock(&epc->lock);
 
 	if (interrupt < 0)
@@ -237,12 +253,13 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msi);
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
@@ -251,13 +268,17 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 	    interrupts > 32)
 		return -EINVAL;
 
+	if (vfunc_no > 0 && !WARN_ON(!epc->max_vfs) &&
+	    vfunc_no > epc->max_vfs[func_no])
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
@@ -267,22 +288,27 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msi);
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
 
+	if (vfunc_no > 0 && !WARN_ON(!epc->max_vfs) &&
+	    vfunc_no > epc->max_vfs[func_no])
+		return 0;
+
 	if (!epc->ops->get_msix)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	interrupt = epc->ops->get_msix(epc, func_no);
+	interrupt = epc->ops->get_msix(epc, func_no, vfunc_no);
 	mutex_unlock(&epc->lock);
 
 	if (interrupt < 0)
@@ -295,15 +321,16 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
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
 
@@ -311,11 +338,16 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
 	    interrupts < 1 || interrupts > 2048)
 		return -EINVAL;
 
+	if (vfunc_no > 0 && !WARN_ON(!epc->max_vfs) &&
+	    vfunc_no > epc->max_vfs[func_no])
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
@@ -325,22 +357,27 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
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
 
+	if (vfunc_no > 0 && !WARN_ON(!epc->max_vfs) &&
+	    vfunc_no > epc->max_vfs[func_no])
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
@@ -348,14 +385,15 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
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
@@ -363,11 +401,16 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
 
+	if (vfunc_no > 0 && !WARN_ON(!epc->max_vfs) &&
+	    vfunc_no > epc->max_vfs[func_no])
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
@@ -377,12 +420,13 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
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
@@ -390,11 +434,15 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
 	     epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
 		return;
 
+	if (vfunc_no > 0 && !WARN_ON(!epc->max_vfs) &&
+	    vfunc_no > epc->max_vfs[func_no])
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
@@ -402,12 +450,13 @@ EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
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
@@ -422,11 +471,15 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
 	     !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64)))
 		return -EINVAL;
 
+	if (vfunc_no > 0 && !WARN_ON(!epc->max_vfs) &&
+	    vfunc_no > epc->max_vfs[func_no])
+		return -EINVAL;
+
 	if (!epc->ops->set_bar)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_bar(epc, func_no, epf_bar);
+	ret = epc->ops->set_bar(epc, func_no, vfunc_no, epf_bar);
 	mutex_unlock(&epc->lock);
 
 	return ret;
@@ -436,7 +489,8 @@ EXPORT_SYMBOL_GPL(pci_epc_set_bar);
 /**
  * pci_epc_write_header() - write standard configuration header
  * @epc: the EPC device to which the configuration header should be written
- * @func_no: the endpoint function number in the EPC device
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
  * @header: standard configuration header fields
  *
  * Invoke to write the configuration header to the endpoint controller. Every
@@ -444,7 +498,7 @@ EXPORT_SYMBOL_GPL(pci_epc_set_bar);
  * configuration header would be written. The callback function should write
  * the header fields to this dedicated location.
  */
-int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
+int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			 struct pci_epf_header *header)
 {
 	int ret;
@@ -452,11 +506,15 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
 
+	if (vfunc_no > 0 && !WARN_ON(!epc->max_vfs) &&
+	    vfunc_no > epc->max_vfs[func_no])
+		return -EINVAL;
+
 	if (!epc->ops->write_header)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->write_header(epc, func_no, header);
+	ret = epc->ops->write_header(epc, func_no, vfunc_no, header);
 	mutex_unlock(&epc->lock);
 
 	return ret;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 105801f6e300..2b480d32dfb8 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -41,27 +41,28 @@ enum pci_epc_irq_type {
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
 	int	(*start)(struct pci_epc *epc);
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
-						       u8 func_no);
+						       u8 func_no, u8 vfunc_no);
 	struct module *owner;
 };
 
@@ -91,6 +92,8 @@ struct pci_epc_mem {
  * @ops: function pointers for performing endpoint operations
  * @mem: address space of the endpoint controller
  * @max_functions: max number of functions that can be configured in this EPC
+ * @max_vfs: Array indicating the maximum number of virtual functions that can
+ *   be associated with each physical function
  * @group: configfs group representing the PCI EPC device
  * @lock: mutex to protect pci_epc ops
  * @function_num_map: bitmap to manage physical function number
@@ -102,6 +105,7 @@ struct pci_epc {
 	const struct pci_epc_ops	*ops;
 	struct pci_epc_mem		*mem;
 	u8				max_functions;
+	u16				*max_vfs;
 	struct config_group		*group;
 	/* mutex to protect against concurrent access of EP controller */
 	struct mutex			lock;
@@ -166,28 +170,29 @@ void pci_epc_destroy(struct pci_epc *epc);
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
-int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
-		     enum pci_barno, u32 offset);
-int pci_epc_get_msix(struct pci_epc *epc, u8 func_no);
-int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
+int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		    u8 interrupts);
+int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+		     u16 interrupts, enum pci_barno, u32 offset);
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

