Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBDC6FC6C2
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 14:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjEIMmM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 08:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjEIMmI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 08:42:08 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7D4746B5;
        Tue,  9 May 2023 05:42:04 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,262,1677510000"; 
   d="scan'208";a="158709382"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 May 2023 21:42:00 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id BD417403832F;
        Tue,  9 May 2023 21:42:00 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v15 06/22] PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()
Date:   Tue,  9 May 2023 21:41:40 +0900
Message-Id: <20230509124156.150200-7-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230509124156.150200-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230509124156.150200-1-yoshihiro.shimoda.uh@renesas.com>
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

To add more arguments to the dw_pcie_prog_outbound_atu() in
the future, introduce struct dw_pcie_ob_atu_cfg and change
the argument. And, drop dw_pcie_prog_ep_outbound_atu(). No behavior
changes.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++---
 .../pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.c  | 49 ++++++-----------
 drivers/pci/controller/dwc/pcie-designware.h  | 15 ++++--
 4 files changed, 77 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 27278010ecec..fe2e0d765be9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -182,9 +182,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	return 0;
 }
 
-static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
-				   phys_addr_t phys_addr,
-				   u64 pci_addr, size_t size)
+static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
+				   struct dw_pcie_ob_atu_cfg *atu)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	u32 free_win;
@@ -196,13 +195,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 		return -EINVAL;
 	}
 
-	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
-					   phys_addr, pci_addr, size);
+	atu->index = free_win;
+	ret = dw_pcie_prog_outbound_atu(pci, atu);
 	if (ret)
 		return ret;
 
 	set_bit(free_win, ep->ob_window_map);
-	ep->outbound_addr[free_win] = phys_addr;
+	ep->outbound_addr[free_win] = atu->cpu_addr;
 
 	return 0;
 }
@@ -305,8 +304,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	int ret;
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-
-	ret = dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
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
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 5718b4bb67f0..676216d540fe 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -544,6 +544,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int type, ret;
 	u32 busdev;
 
@@ -566,8 +567,12 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 	else
 		type = PCIE_ATU_TYPE_CFG1;
 
-	ret = dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev,
-					pp->cfg0_size);
+	atu.type = type;
+	atu.cpu_addr = pp->cfg0_base;
+	atu.pci_addr = busdev;
+	atu.size = pp->cfg0_size;
+
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
 		return NULL;
 
@@ -579,6 +584,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_read(bus, devfn, where, size, val);
@@ -586,9 +592,12 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
-						pp->io_base, pp->io_bus_addr,
-						pp->io_size);
+		atu.type = PCIE_ATU_TYPE_IO;
+		atu.cpu_addr = pp->io_base;
+		atu.pci_addr = pp->io_bus_addr;
+		atu.size = pp->io_size;
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret)
 			return PCIBIOS_SET_FAILED;
 	}
@@ -601,6 +610,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_write(bus, devfn, where, size, val);
@@ -608,9 +618,12 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
-						pp->io_base, pp->io_bus_addr,
-						pp->io_size);
+		atu.type = PCIE_ATU_TYPE_IO;
+		atu.cpu_addr = pp->io_base;
+		atu.pci_addr = pp->io_bus_addr;
+		atu.size = pp->io_size;
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret)
 			return PCIBIOS_SET_FAILED;
 	}
@@ -645,6 +658,7 @@ static struct pci_ops dw_pcie_ops = {
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	struct resource_entry *entry;
 	int i, ret;
 
@@ -672,10 +686,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows <= ++i)
 			break;
 
-		ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
-						entry->res->start,
-						entry->res->start - entry->offset,
-						resource_size(entry->res));
+		atu.index = i;
+		atu.type = PCIE_ATU_TYPE_MEM;
+		atu.cpu_addr = entry->res->start;
+		atu.pci_addr = entry->res->start - entry->offset;
+		atu.size = resource_size(entry->res);
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret) {
 			dev_err(pci->dev, "Failed to set MEM range %pr\n",
 				entry->res);
@@ -685,10 +702,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 	if (pp->io_size) {
 		if (pci->num_ob_windows > ++i) {
-			ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
-							pp->io_base,
-							pp->io_bus_addr,
-							pp->io_size);
+			atu.index = i;
+			atu.type = PCIE_ATU_TYPE_IO;
+			atu.cpu_addr = pp->io_base;
+			atu.pci_addr = pp->io_bus_addr;
+			atu.size = pp->io_size;
+
+			ret = dw_pcie_prog_outbound_atu(pci, &atu);
 			if (ret) {
 				dev_err(pci->dev, "Failed to set IO range %pr\n",
 					entry->res);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index ede166645289..bd85a73d354b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -464,56 +464,56 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 	return val | PCIE_ATU_TD;
 }
 
-static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
-				       int index, int type, u64 cpu_addr,
-				       u64 pci_addr, u64 size)
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
+			      const struct dw_pcie_ob_atu_cfg *atu)
 {
+	u64 cpu_addr = atu->cpu_addr;
 	u32 retries, val;
 	u64 limit_addr;
 
 	if (pci->ops && pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
 
-	limit_addr = cpu_addr + size - 1;
+	limit_addr = cpu_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
 	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
-	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
+	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
 		return -EINVAL;
 	}
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
 			      lower_32_bits(cpu_addr));
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
 			      upper_32_bits(cpu_addr));
 
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
+	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
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
 
@@ -525,21 +525,6 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 	return -ETIMEDOUT;
 }
 
-int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			      u64 cpu_addr, u64 pci_addr, u64 size)
-{
-	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
-					   cpu_addr, pci_addr, size);
-}
-
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr,
-				 u64 size)
-{
-	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
-					   cpu_addr, pci_addr, size);
-}
-
 static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9acf6c40d252..b8fa099bbed3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -291,6 +291,15 @@ enum dw_pcie_core_rst {
 	DW_PCIE_NUM_CORE_RSTS
 };
 
+struct dw_pcie_ob_atu_cfg {
+	int index;
+	int type;
+	u8 func_no;
+	u64 cpu_addr;
+	u64 pci_addr;
+	u64 size;
+};
+
 struct dw_pcie_host_ops {
 	int (*host_init)(struct dw_pcie_rp *pp);
 	void (*host_deinit)(struct dw_pcie_rp *pp);
@@ -419,10 +428,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
-int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			      u64 cpu_addr, u64 pci_addr, u64 size);
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
+			      const struct dw_pcie_ob_atu_cfg *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 			     u64 cpu_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-- 
2.25.1

