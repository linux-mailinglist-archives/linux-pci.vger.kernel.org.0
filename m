Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D99793ABF
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 13:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbjIFLJp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 07:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbjIFLJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 07:09:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9717810F5;
        Wed,  6 Sep 2023 04:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693998574; x=1725534574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GUac/hbB30TVWR9RL69XUXlb9prhkA4ccRWpbnfksow=;
  b=d7x36NA5cWQXRf54C7vnNYKn0HFw7OiVveZQMX91nzoKKXLNvwSg3E+P
   kCYxHrqeOQJygmmct+50G+rCOobo5I+ASbu3RcAun5go+hAdWlGaGoN8e
   4OZfxvmlztmT5gkwA8n4k0AWRZ8KrMA64hil85LY0oa0UPgCI2Tp9wMF3
   PLhtH49W8w76po0lORFfadnqWVO2L4PveaUJH3zp8mXDCxtJNwSUTtwzX
   usNTIPKrKH3gt9lC/pew4XEqy+cFiklk5nSHjSDPweem2dQ3aBk7bI69I
   5kHbTlLuwgZrMc+2CWi2hSiLNdq+ybmfDtjaoqqXoC4R+tBy6lXGO+AXB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="357349382"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="357349382"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 04:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="884650799"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="884650799"
Received: from unknown (HELO bapvecise024..) ([10.190.254.46])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2023 04:09:21 -0700
From:   sharath.kumar.d.m@intel.com
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org, dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        D M Sharath Kumar <sharath.kumar.d.m@intel.com>
Subject: [PATCH v2 2/2] PCI: altera: add suport for Agilex Family FPGA
Date:   Wed,  6 Sep 2023 16:39:18 +0530
Message-Id: <20230906110918.1501376-3-sharath.kumar.d.m@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906110918.1501376-1-sharath.kumar.d.m@intel.com>
References: <20230616063313.862996-2-sharath.kumar.d.m@intel.com>
 <20230906110918.1501376-1-sharath.kumar.d.m@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>

Signed-off-by: D M Sharath Kumar <sharath.kumar.d.m@intel.com>
---
 drivers/pci/controller/pcie-altera.c | 215 ++++++++++++++++++++++++++-
 1 file changed, 214 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 4e543ec6dfb6..bc040a992eb9 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -80,9 +80,21 @@
 #define S10_TLP_FMTTYPE_CFGWR0		0x45
 #define S10_TLP_FMTTYPE_CFGWR1		0x44
 
+#define AGLX_RP_CFG_ADDR(pcie, reg)     \
+	(((pcie)->hip_base) + (reg))
+#define AGLX_RP_SECONDARY(pcie)         \
+	readb(AGLX_RP_CFG_ADDR(pcie, PCI_SECONDARY_BUS))
+
+#define AGLX_BDF_REG 0x00002004
+#define AGLX_ROOT_PORT_IRQ_STATUS 0x14c
+#define AGLX_ROOT_PORT_IRQ_ENABLE 0x150
+#define CFG_AER                   (1<<4)
+static u32 port_conf_off;
+
 enum altera_pcie_version {
 	ALTERA_PCIE_V1 = 0,
 	ALTERA_PCIE_V2,
+	ALTERA_PCIE_V3, /* AGILEX p-tile, f-tile */
 };
 
 struct altera_pcie {
@@ -94,6 +106,7 @@ struct altera_pcie {
 	struct irq_domain	*irq_domain;
 	struct resource		bus_range;
 	const struct altera_pcie_data	*pcie_data;
+	void __iomem		*cs_base;
 };
 
 struct altera_pcie_ops {
@@ -139,6 +152,39 @@ static inline u32 cra_readl(struct altera_pcie *pcie, const u32 reg)
 	return readl_relaxed(pcie->cra_base + reg);
 }
 
+static inline void cs_writel(struct altera_pcie *pcie, const u32 value,
+				const u32 reg)
+{
+	writel_relaxed(value, pcie->cs_base + reg);
+}
+
+static inline void cs_writew(struct altera_pcie *pcie, const u32 value,
+				const u32 reg)
+{
+	writew_relaxed(value, pcie->cs_base + reg);
+}
+
+static inline void cs_writeb(struct altera_pcie *pcie, const u32 value,
+				const u32 reg)
+{
+	writeb_relaxed(value, pcie->cs_base + reg);
+}
+
+static inline u32 cs_readl(struct altera_pcie *pcie, const u32 reg)
+{
+	return readl_relaxed(pcie->cs_base + reg);
+}
+
+static inline u32 cs_readw(struct altera_pcie *pcie, const u32 reg)
+{
+	return readw_relaxed(pcie->cs_base + reg);
+}
+
+static inline u32 cs_readb(struct altera_pcie *pcie, const u32 reg)
+{
+	return readb_relaxed(pcie->cs_base + reg);
+}
+
 static bool altera_pcie_link_up(struct altera_pcie *pcie)
 {
 	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
@@ -153,6 +199,14 @@ static bool s10_altera_pcie_link_up(struct altera_pcie *pcie)
 	return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);
 }
 
+static bool aglx_altera_pcie_link_up(struct altera_pcie *pcie)
+{
+	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie,
+		pcie->pcie_data->cap_offset + PCI_EXP_LNKSTA);
+
+	return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);
+}
+
 /*
  * Altera PCIe port uses BAR0 of RC's configuration space as the translation
  * from PCI bus to native BUS.  Entire DDR region is mapped into PCIe space
@@ -433,6 +487,106 @@ static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 busno, u32 devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static int aglx_rp_read_cfg(struct altera_pcie *pcie, u8 busno, u32 devfn,
+			int where, int size, u32 *value)
+{
+	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie, where);
+
+	switch (size) {
+	case 1:
+		*value = readb(addr);
+		break;
+	case 2:
+		*value = readw(addr);
+		break;
+	default:
+		*value = readl(addr);
+		break;
+	}
+
+	/* interrupt pin not programmed in hardware
+	 */
+	if (where == 0x3d)
+		*value = 0x01;
+	if (where == 0x3c)
+		*value |= 0x0100;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int aglx_rp_write_cfg(struct altera_pcie *pcie, u8 busno, u32 devfn,
+			int where, int size, u32 value)
+{
+	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie, where);
+
+	switch (size) {
+	case 1:
+		writeb(value, addr);
+		break;
+	case 2:
+		writew(value, addr);
+		break;
+	default:
+		writel(value, addr);
+		break;
+	}
+
+	/*
+	 * Monitor changes to PCI_PRIMARY_BUS register on root port
+	 * and update local copy of root bus number accordingly.
+	 */
+	if (busno == pcie->root_bus_nr && where == PCI_PRIMARY_BUS)
+		pcie->root_bus_nr = value & 0xff;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int aglx_ep_write_cfg(struct altera_pcie *pcie, u8 busno,
+		unsigned int devfn, int where, int size, u32 value)
+{
+	cs_writel(pcie, ((busno<<8) | devfn), AGLX_BDF_REG);
+	if (busno > AGLX_RP_SECONDARY(pcie)) {
+		/* type 1 */
+		where |= (1<<12);
+	}
+
+	switch (size) {
+	case 1:
+		cs_writeb(pcie, value, where);
+		break;
+	case 2:
+		cs_writew(pcie, value, where);
+		break;
+	default:
+		cs_writel(pcie, value, where);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int aglx_ep_read_cfg(struct altera_pcie *pcie, u8 busno,
+		unsigned int devfn, int where, int size, u32 *value)
+{
+	cs_writel(pcie, ((busno<<8) | devfn), AGLX_BDF_REG);
+	if (busno > AGLX_RP_SECONDARY(pcie)) {
+		/* type 1 */
+		where |= (1<<12);
+	}
+
+	switch (size) {
+	case 1:
+		*value = cs_readb(pcie, where);
+		break;
+	case 2:
+		*value = cs_readw(pcie, where);
+		break;
+	default:
+		*value = cs_readl(pcie, where);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static int arr_read_cfg(struct altera_pcie *pcie, u8 busno, u32 devfn,
 		int where, int size, u32 *value)
 {
@@ -689,6 +843,30 @@ static void altera_pcie_isr(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static void aglx_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct altera_pcie *pcie;
+	struct device *dev;
+	u32 status;
+	int ret;
+
+	chained_irq_enter(chip, desc);
+	pcie = irq_desc_get_handler_data(desc);
+	dev = &pcie->pdev->dev;
+
+	status = readl((pcie->hip_base + port_conf_off
+		+ AGLX_ROOT_PORT_IRQ_STATUS));
+	if (status & CFG_AER) {
+		ret = generic_handle_domain_irq(pcie->irq_domain, 0);
+		if (ret)
+			dev_err_ratelimited(dev, "unexpected IRQ,\n");
+	}
+	writel(CFG_AER, (pcie->hip_base + port_conf_off
+		+ AGLX_ROOT_PORT_IRQ_STATUS));
+	chained_irq_exit(chip, desc);
+}
+
 static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
@@ -724,13 +902,24 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 			return PTR_ERR(pcie->cra_base);
 	}
 
-	if (pcie->pcie_data->version == ALTERA_PCIE_V2) {
+	if ((pcie->pcie_data->version == ALTERA_PCIE_V2) ||
+		(pcie->pcie_data->version == ALTERA_PCIE_V3)) {
 		pcie->hip_base =
 			devm_platform_ioremap_resource_byname(pdev, "Hip");
 		if (IS_ERR(pcie->hip_base))
 			return PTR_ERR(pcie->hip_base);
 	}
 
+	if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
+		pcie->cs_base =
+			devm_platform_ioremap_resource_byname(pdev, "Cs");
+		if (IS_ERR(pcie->cs_base))
+			return PTR_ERR(pcie->cs_base);
+		of_property_read_u32(pcie->pdev->dev.of_node, "port_conf_stat",
+			&port_conf_off);
+		dev_info(&pcie->pdev->dev, "port_conf_stat_off =%x\n", port_conf_off);
+	}
+
 	/* setup IRQ */
 	pcie->irq = platform_get_irq(pdev, 0);
 	if (pcie->irq < 0)
@@ -768,6 +957,15 @@ static const struct altera_pcie_ops altera_pcie_ops_2_0 = {
 	.rp_isr = altera_pcie_isr,
 };
 
+static const struct altera_pcie_ops altera_pcie_ops_3_0 = {
+	.rp_read_cfg = aglx_rp_read_cfg,
+	.rp_write_cfg = aglx_rp_write_cfg,
+	.get_link_status = aglx_altera_pcie_link_up,
+	.ep_read_cfg = aglx_ep_read_cfg,
+	.ep_write_cfg = aglx_ep_write_cfg,
+	.rp_isr = aglx_isr,
+};
+
 static const struct altera_pcie_data altera_pcie_1_0_data = {
 	.ops = &altera_pcie_ops_1_0,
 	.cap_offset = 0x80,
@@ -788,11 +986,23 @@ static const struct altera_pcie_data altera_pcie_2_0_data = {
 	.cfgwr1 = S10_TLP_FMTTYPE_CFGWR1,
 };
 
+static const struct altera_pcie_data altera_pcie_3_0_data = {
+	.ops = &altera_pcie_ops_3_0,
+	.version = ALTERA_PCIE_V3,
+	.cap_offset = 0x70,
+	.cfgrd0 = 0,
+	.cfgrd1 = 0,
+	.cfgwr0 = 0,
+	.cfgwr1 = 0,
+};
+
 static const struct of_device_id altera_pcie_of_match[] = {
 	{.compatible = "altr,pcie-root-port-1.0",
 	 .data = &altera_pcie_1_0_data },
 	{.compatible = "altr,pcie-root-port-2.0",
 	 .data = &altera_pcie_2_0_data },
+	{.compatible = "altr,pcie-root-port-3.0",
+	.data = &altera_pcie_3_0_data },
 	{},
 };
 
@@ -837,6 +1047,9 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		/* enable all interrupts */
 		cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
 		altera_pcie_host_init(pcie);
+	} else if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
+		writel(CFG_AER, (pcie->hip_base + port_conf_off
+			+ AGLX_ROOT_PORT_IRQ_ENABLE));
 	}
 
 	bridge->sysdata = pcie;
-- 
2.34.1

