Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F057AA95C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 08:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjIVGxr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 02:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIVGxq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 02:53:46 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AD7DCE;
        Thu, 21 Sep 2023 23:53:38 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,167,1694703600"; 
   d="scan'208";a="180618009"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Sep 2023 15:53:38 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 43CCE400F799;
        Fri, 22 Sep 2023 15:53:38 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v21 01/16] PCI: dwc: endpoint: Add multiple PFs support for dbi2
Date:   Fri, 22 Sep 2023 15:53:16 +0900
Message-Id: <20230922065331.3806925-2-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The commit 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support
for DWC") added .func_conf_select() to get the configuration space of
different PFs and assumed that the offsets between dbi and dbi2 would
be the same.

However, Renesas R-Car Gen4 PCIe controllers have different offsets of
function 1: dbi (+0x1000) and dbi2 (+0x800). To get the offset for dbi2,
add .get_dbi2_offset() and dw_pcie_ep_get_dbi2_offset().

Note:
 - .func_conf_select() should be renamed later.
 - dw_pcie_ep_get_dbi2_offset() will call .func_conf_select()
   if .get_dbi2_offset() doesn't exist for backward compatibility.
 - dw_pcie_writeX_{dbi/dbi2} APIs accepted the func_no argument,
   so that these offset calculations are contained in the API
   definitions itself as it should.

[kwilczynski: commit log]
Link: https://lore.kernel.org/linux-pci/20230825093219.2685912-6-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 32 ++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f9182f8d552f..851538ddec0a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -52,21 +52,35 @@ static unsigned int dw_pcie_ep_func_select(struct dw_pcie_ep *ep, u8 func_no)
 	return func_offset;
 }
 
+static unsigned int dw_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep, u8 func_no)
+{
+	unsigned int dbi2_offset = 0;
+
+	if (ep->ops->get_dbi2_offset)
+		dbi2_offset = ep->ops->get_dbi2_offset(ep, func_no);
+	else if (ep->ops->func_conf_select)     /* for backward compatibility */
+		dbi2_offset = ep->ops->func_conf_select(ep, func_no);
+
+	return dbi2_offset;
+}
+
 static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
 				   enum pci_barno bar, int flags)
 {
-	u32 reg;
-	unsigned int func_offset = 0;
+	unsigned int func_offset, dbi2_offset;
 	struct dw_pcie_ep *ep = &pci->ep;
+	u32 reg, reg_dbi2;
 
 	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	dbi2_offset = dw_pcie_ep_get_dbi2_offset(ep, func_no);
 
 	reg = func_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
+	reg_dbi2 = dbi2_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
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
@@ -228,16 +242,18 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	unsigned int func_offset, dbi2_offset;
 	enum pci_barno bar = epf_bar->barno;
 	size_t size = epf_bar->size;
 	int flags = epf_bar->flags;
-	unsigned int func_offset = 0;
+	u32 reg, reg_dbi2;
 	int ret, type;
-	u32 reg;
 
 	func_offset = dw_pcie_ep_func_select(ep, func_no);
+	dbi2_offset = dw_pcie_ep_get_dbi2_offset(ep, func_no);
 
 	reg = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset;
+	reg_dbi2 = PCI_BASE_ADDRESS_0 + (4 * bar) + dbi2_offset;
 
 	if (!(flags & PCI_BASE_ADDRESS_SPACE))
 		type = PCIE_ATU_TYPE_MEM;
@@ -253,11 +269,11 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
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
index ef0b2efa9f93..6189884b4efa 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -341,6 +341,7 @@ struct dw_pcie_ep_ops {
 	 * driver.
 	 */
 	unsigned int (*func_conf_select)(struct dw_pcie_ep *ep, u8 func_no);
+	unsigned int (*get_dbi2_offset)(struct dw_pcie_ep *ep, u8 func_no);
 };
 
 struct dw_pcie_ep_func {
-- 
2.25.1

