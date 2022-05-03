Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0051B519071
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243253AbiECVuy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243165AbiECVuw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:50:52 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 245EC41F8D;
        Tue,  3 May 2022 14:47:11 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 97DCC16D8;
        Wed,  4 May 2022 00:47:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 97DCC16D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651614464;
        bh=DeOBReCdD0Cgmoi70A7Dnyl6k+eb/Z7LXMxENYE7VVM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=kBTGtXcASodiT8AyVgNzDAZbwf2KlUE3o79wdzl/3Y4yieGY6JXRNOPROW7alXYY5
         xgGvPR3HgyCjnVeJsepbchSUsAfVsXuX5J+KD0VZ0zXHo2kGifsqdFQUHSnlncL6SI
         R3bYazieipx//byq7WQZq1UDGgzaWqxzoG3odxjE=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:47:10 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/17] PCI: dwc: Drop iATU regions enumeration - dw_pcie_region_type
Date:   Wed, 4 May 2022 00:46:31 +0300
Message-ID: <20220503214638.1895-11-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no point in having the dw_pcie_region_type enumeration for almost
the same reasons as it was stated for dw_pcie_as_type. First of all it's
redundant since the driver already has a set of the macros declared which
describe the possible inbound and outbound iATU regions. Having an
addition abstraction just needlessly complicates the code. Secondly
checking the region type passed to the dw_pcie_disable_atu() method for
validity is pointless since the erroneous situation is just ignored in the
current method implementation. So to speak let's drop the redundant
dw_pcie_region_type enumeration replacing it with the direct iATU
direction macro usage.

Since the dw_pcie_disable_atu() method now directly accepts the
in-/outbound iATU region direction instead of the abstract region type we
need to change the argument name and the arguments order. The later change
makes the function prototype looking more logical since the passed index
indicates an iATU window within the regions with the corresponding
direction.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Move this patch to being applied before the IB/OB iATU windows setup
  simplification patch (@Rob).
---
 .../pci/controller/dwc/pcie-designware-ep.c   |  4 +--
 .../pci/controller/dwc/pcie-designware-host.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 28 +++++--------------
 drivers/pci/controller/dwc/pcie-designware.h  | 13 ++-------
 4 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 6ce44c12ea1c..68ad3d250450 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -212,7 +212,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
 
-	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND);
+	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
 	clear_bit(atu_index, ep->ib_window_map);
 	ep->epf_bar[bar] = NULL;
 }
@@ -286,7 +286,7 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (ret < 0)
 		return;
 
-	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_OUTBOUND);
+	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, atu_index);
 	clear_bit(atu_index, ep->ob_window_map);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index bb1c25c32f2d..ade31a04f9df 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -649,7 +649,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		 * multiple matches
 		 */
 		for (i = 0; i < pci->num_ob_windows; i++)
-			dw_pcie_disable_atu(pci, i, DW_PCIE_REGION_OUTBOUND);
+			dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, i);
 
 		/* Get last memory resource entry */
 		resource_list_for_each_entry(entry, &pp->bridge->windows) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4edfc95e0213..596c249445ec 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -353,7 +353,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 	limit_addr = cpu_addr + size - 1;
 
 	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT,
-			   PCIE_ATU_REGION_OUTBOUND | index);
+			   PCIE_ATU_REGION_DIR_OB | index);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_BASE,
 			   lower_32_bits(cpu_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_BASE,
@@ -464,7 +464,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 		return dw_pcie_prog_inbound_atu_unroll(pci, func_no, index, type,
 						       cpu_addr, bar);
 
-	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_INBOUND |
+	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_DIR_IB |
 			   index);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET, lower_32_bits(cpu_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET, upper_32_bits(cpu_addr));
@@ -491,24 +491,10 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 	return -EBUSY;
 }
 
-void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
-			 enum dw_pcie_region_type type)
+void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 {
-	int region;
-
-	switch (type) {
-	case DW_PCIE_REGION_INBOUND:
-		region = PCIE_ATU_REGION_INBOUND;
-		break;
-	case DW_PCIE_REGION_OUTBOUND:
-		region = PCIE_ATU_REGION_OUTBOUND;
-		break;
-	default:
-		return;
-	}
-
 	if (pci->iatu_unroll_enabled) {
-		if (region == PCIE_ATU_REGION_INBOUND) {
+		if (dir == PCIE_ATU_REGION_DIR_IB) {
 			dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
 						 ~(u32)PCIE_ATU_ENABLE);
 		} else {
@@ -516,7 +502,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 						 ~(u32)PCIE_ATU_ENABLE);
 		}
 	} else {
-		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
+		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, dir | index);
 		dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~(u32)PCIE_ATU_ENABLE);
 	}
 }
@@ -661,7 +647,7 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
 	max_region = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT) + 1;
 
 	for (i = 0; i < max_region; i++) {
-		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_OUTBOUND | i);
+		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_DIR_OB | i);
 		dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET, 0x11110000);
 		val = dw_pcie_readl_dbi(pci, PCIE_ATU_LOWER_TARGET);
 		if (val == 0x11110000)
@@ -671,7 +657,7 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
 	}
 
 	for (i = 0; i < max_region; i++) {
-		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_INBOUND | i);
+		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_DIR_IB | i);
 		dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET, 0x11110000);
 		val = dw_pcie_readl_dbi(pci, PCIE_ATU_LOWER_TARGET);
 		if (val == 0x11110000)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 449c5ad92edc..0bda68f8ffdb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -104,8 +104,8 @@
 #define PCIE_VERSION_TYPE		0x8FC
 
 #define PCIE_ATU_VIEWPORT		0x900
-#define PCIE_ATU_REGION_INBOUND		BIT(31)
-#define PCIE_ATU_REGION_OUTBOUND	0
+#define PCIE_ATU_REGION_DIR_IB		BIT(31)
+#define PCIE_ATU_REGION_DIR_OB		0
 #define PCIE_ATU_CR1			0x904
 #define PCIE_ATU_INCREASE_REGION_SIZE	BIT(13)
 #define PCIE_ATU_TYPE_MEM		0x0
@@ -185,12 +185,6 @@ struct pcie_port;
 struct dw_pcie;
 struct dw_pcie_ep;
 
-enum dw_pcie_region_type {
-	DW_PCIE_REGION_UNKNOWN,
-	DW_PCIE_REGION_INBOUND,
-	DW_PCIE_REGION_OUTBOUND,
-};
-
 enum dw_pcie_device_mode {
 	DW_PCIE_UNKNOWN_TYPE,
 	DW_PCIE_EP_TYPE,
@@ -326,8 +320,7 @@ void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				  u64 size);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 			     int type, u64 cpu_addr, u8 bar);
-void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
-			 enum dw_pcie_region_type type);
+void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
 void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 
-- 
2.35.1

