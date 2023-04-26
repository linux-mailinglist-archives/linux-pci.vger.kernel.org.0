Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543B06EED33
	for <lists+linux-pci@lfdr.de>; Wed, 26 Apr 2023 06:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbjDZE4U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 00:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbjDZE4N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 00:56:13 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 631032708;
        Tue, 25 Apr 2023 21:56:08 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,227,1677510000"; 
   d="scan'208";a="160778510"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Apr 2023 13:56:05 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D10804175EC6;
        Wed, 26 Apr 2023 13:56:05 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v14 06/21] PCI: dwc: Change arguments of dw_pcie_prog_ep_outbound_atu()
Date:   Wed, 26 Apr 2023 13:55:42 +0900
Message-Id: <20230426045557.3613826-7-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To add more arguments to the dw_pcie_prog_ep_outbound_atu() in
the future, introduce struct dw_pcie_outbound_atu and change
the argument. No behavior changes.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 21 ++++---
 drivers/pci/controller/dwc/pcie-designware.c  | 63 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h  | 13 +++-
 3 files changed, 57 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index a80b9fd03638..96375b0aba82 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -183,9 +183,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	return 0;
 }
 
-static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
-				   phys_addr_t phys_addr,
-				   u64 pci_addr, size_t size)
+static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
+				   struct dw_pcie_outbound_atu *atu)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	u32 free_win;
@@ -197,13 +196,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 		return -EINVAL;
 	}
 
-	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
-					   phys_addr, pci_addr, size);
+	atu->index = free_win;
+	ret = dw_pcie_prog_ep_outbound_atu(pci, atu);
 	if (ret)
 		return ret;
 
 	set_bit(free_win, ep->ob_window_map);
-	ep->outbound_addr[free_win] = phys_addr;
+	ep->outbound_addr[free_win] = atu->cpu_addr;
 
 	return 0;
 }
@@ -306,8 +305,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	int ret;
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-
-	ret = dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
+	struct dw_pcie_outbound_atu atu = { 0 };
+
+	atu.func_no = func_no;
+	atu.type = PCIE_ATU_TYPE_MEM;
+	atu.cpu_addr = addr;
+	atu.pci_addr = pci_addr;
+	atu.size = size;
+	ret = dw_pcie_ep_outbound_atu(ep, &atu);
 	if (ret) {
 		dev_err(pci->dev, "Failed to enable address\n");
 		return ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index ede166645289..782c4b34d0a3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -464,56 +464,55 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 	return val | PCIE_ATU_TD;
 }
 
-static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
-				       int index, int type, u64 cpu_addr,
-				       u64 pci_addr, u64 size)
+static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
+				       struct dw_pcie_outbound_atu *atu)
 {
 	u32 retries, val;
 	u64 limit_addr;
 
 	if (pci->ops && pci->ops->cpu_addr_fixup)
-		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
+		atu->cpu_addr = pci->ops->cpu_addr_fixup(pci, atu->cpu_addr);
 
-	limit_addr = cpu_addr + size - 1;
+	limit_addr = atu->cpu_addr + atu->size - 1;
 
-	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
-	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
-	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
+	if ((limit_addr & ~pci->region_limit) != (atu->cpu_addr & ~pci->region_limit) ||
+	    !IS_ALIGNED(atu->cpu_addr, pci->region_align) ||
+	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
 		return -EINVAL;
 	}
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
-			      lower_32_bits(cpu_addr));
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
-			      upper_32_bits(cpu_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
+			      lower_32_bits(atu->cpu_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
+			      upper_32_bits(atu->cpu_addr));
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
 			      lower_32_bits(limit_addr));
 	if (dw_pcie_ver_is_ge(pci, 460A))
-		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
+		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
 				      upper_32_bits(limit_addr));
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(pci_addr));
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(pci_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
+			      lower_32_bits(atu->pci_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
+			      upper_32_bits(atu->pci_addr));
 
-	val = type | PCIE_ATU_FUNC_NUM(func_no);
-	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
+	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
+	if (upper_32_bits(limit_addr) > upper_32_bits(atu->cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
 	if (dw_pcie_ver_is(pci, 490A))
 		val = dw_pcie_enable_ecrc(val);
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
+		val = dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2);
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
@@ -528,16 +527,20 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 			      u64 cpu_addr, u64 pci_addr, u64 size)
 {
-	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
-					   cpu_addr, pci_addr, size);
+	struct dw_pcie_outbound_atu atu = { 0 };
+
+	atu.index = index;
+	atu.type = type;
+	atu.cpu_addr = cpu_addr;
+	atu.pci_addr = pci_addr;
+	atu.size = size;
+	return __dw_pcie_prog_outbound_atu(pci, &atu);
 }
 
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr,
-				 u64 size)
+int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci,
+				 struct dw_pcie_outbound_atu *atu)
 {
-	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
-					   cpu_addr, pci_addr, size);
+	return __dw_pcie_prog_outbound_atu(pci, atu);
 }
 
 static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9acf6c40d252..81c7558a4718 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -291,6 +291,15 @@ enum dw_pcie_core_rst {
 	DW_PCIE_NUM_CORE_RSTS
 };
 
+struct dw_pcie_outbound_atu {
+	u64 cpu_addr;
+	u64 pci_addr;
+	u64 size;
+	int index;
+	int type;
+	u8 func_no;
+};
+
 struct dw_pcie_host_ops {
 	int (*host_init)(struct dw_pcie_rp *pp);
 	void (*host_deinit)(struct dw_pcie_rp *pp);
@@ -421,8 +430,8 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 			      u64 cpu_addr, u64 pci_addr, u64 size);
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
+int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci,
+				 struct dw_pcie_outbound_atu *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 			     u64 cpu_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-- 
2.25.1

