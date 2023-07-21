Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E433F75C035
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 09:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGUHpM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 03:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjGUHpI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 03:45:08 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79FAE270A;
        Fri, 21 Jul 2023 00:45:06 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,220,1684767600"; 
   d="scan'208";a="170346710"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Jul 2023 16:45:02 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id BCBF2418F611;
        Fri, 21 Jul 2023 16:45:02 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v18 07/20] PCI: dwc: endpoint: Add multiple PFs support for dbi2
Date:   Fri, 21 Jul 2023 16:44:39 +0900
Message-Id: <20230721074452.65545-8-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The commit 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support
for DWC") added .func_conf_select() to get the configuration space of
different PFs and assumed that the offsets between dbi and dbi2 would
be the same. However, Renesas R-Car Gen4 PCIe controllers have different
offsets of function 1: dbi (+0x1000) and dbi2 (+0x800). To get
the offset for dbi2, add .func_conf_select2() and
dw_pcie_ep_func_select2().

Notes that dw_pcie_ep_func_select2() will call .func_conf_select()
if .func_conf_select2() doesn't exist for backward compatibility.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 32 ++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  3 +-
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1d24ebf9686f..bd57516d5313 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -54,21 +54,35 @@ static unsigned int dw_pcie_ep_func_select(struct dw_pcie_ep *ep, u8 func_no)
 	return func_offset;
 }
 
+static unsigned int dw_pcie_ep_func_select2(struct dw_pcie_ep *ep, u8 func_no)
+{
+	unsigned int func_offset = 0;
+
+	if (ep->ops->func_conf_select2)
+		func_offset = ep->ops->func_conf_select2(ep, func_no);
+	else if (ep->ops->func_conf_select)	/* for backward compatibility */
+		func_offset = ep->ops->func_conf_select(ep, func_no);
+
+	return func_offset;
+}
+
 static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
 				   enum pci_barno bar, int flags)
 {
-	u32 reg;
-	unsigned int func_offset = 0;
+	u32 reg, reg_dbi2;
+	unsigned int func_offset, func_offset_dbi2;
 	struct dw_pcie_ep *ep = &pci->ep;
 
 	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	func_offset_dbi2 = dw_pcie_ep_func_select2(ep, func_no);
 
 	reg = func_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
+	reg_dbi2 = func_offset_dbi2 + PCI_BASE_ADDRESS_0 + (4 * bar);
 	dw_pcie_dbi_ro_wr_en(pci);
-	dw_pcie_writel_dbi2(pci, reg, 0x0);
+	dw_pcie_writel_dbi2(pci, reg_dbi2, 0x0);
 	dw_pcie_writel_dbi(pci, reg, 0x0);
 	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-		dw_pcie_writel_dbi2(pci, reg + 4, 0x0);
+		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, 0x0);
 		dw_pcie_writel_dbi(pci, reg + 4, 0x0);
 	}
 	dw_pcie_dbi_ro_wr_dis(pci);
@@ -232,13 +246,15 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	enum pci_barno bar = epf_bar->barno;
 	size_t size = epf_bar->size;
 	int flags = epf_bar->flags;
-	unsigned int func_offset = 0;
+	unsigned int func_offset, func_offset_dbi2;
 	int ret, type;
-	u32 reg;
+	u32 reg, reg_dbi2;
 
 	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	func_offset_dbi2 = dw_pcie_ep_func_select2(ep, func_no);
 
 	reg = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset;
+	reg_dbi2 = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset_dbi2;
 
 	if (!(flags & PCI_BASE_ADDRESS_SPACE))
 		type = PCIE_ATU_TYPE_MEM;
@@ -254,11 +270,11 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
-	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
+	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
 	dw_pcie_writel_dbi(pci, reg, flags);
 
 	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
+		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, upper_32_bits(size - 1));
 		dw_pcie_writel_dbi(pci, reg + 4, 0);
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 812c221b3f7c..94bc20f5f600 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -340,9 +340,10 @@ struct dw_pcie_ep_ops {
 	 * access for different platform, if different func have different
 	 * offset, return the offset of func. if use write a register way
 	 * return a 0, and implement code in callback function of platform
-	 * driver.
+	 * driver. The func_conf_select2 is for dbi2.
 	 */
 	unsigned int (*func_conf_select)(struct dw_pcie_ep *ep, u8 func_no);
+	unsigned int (*func_conf_select2)(struct dw_pcie_ep *ep, u8 func_no);
 };
 
 struct dw_pcie_ep_func {
-- 
2.25.1

