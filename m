Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A6B7327A8
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 08:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243313AbjFPGdS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 02:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241738AbjFPGdQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 02:33:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540BB26B6;
        Thu, 15 Jun 2023 23:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686897194; x=1718433194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xDvGHEhxIaTEDZNQgnliKlxecUpzAbclhN1htm00KeA=;
  b=OiMOj+2U2gmcbUDpP5CfyZCrykBIabeliutdppjrJhs3zo2Xh+isvqa2
   lWUMkQOZi4dsqu1uAbbsKVAjRt3Al6EmpiYQCGOYo4li6N3shtixgbGrS
   8wlDoBzdpZsq5cZ+cXjPSrWwjpY0ipT/p43iR9ZYAt8WqEkIw/4WhAi6l
   yBPsJqiVf4VrvPGYeqoMZyTDbuDi1eh8wSx8cHooRSL+NzAgcEay2rE+O
   Epf3WwYiQZGuPNIfyfgqBOdw5toH4Nzd/z3ymnjBvbLYyRvbxwtaiv0iu
   9jKSH01lpbehQ9G34XDxGA+f3HYj/hI3qLZ3F+8dcZMSHI5QvZjGAciKg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445520578"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="445520578"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="663071125"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="663071125"
Received: from unknown (HELO bapvecise024..) ([10.190.254.46])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2023 23:33:10 -0700
From:   sharath.kumar.d.m@intel.com
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org, dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        D M Sharath Kumar <sharath.kumar.d.m@intel.com>
Subject: [PATCH 1/1] pci: agilex_pci: add pcie rootport support for agilex
Date:   Fri, 16 Jun 2023 12:03:13 +0530
Message-Id: <20230616063313.862996-2-sharath.kumar.d.m@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616063313.862996-1-sharath.kumar.d.m@intel.com>
References: <20230616063313.862996-1-sharath.kumar.d.m@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>

Signed-off-by: D M Sharath Kumar <sharath.kumar.d.m@intel.com>
---
 drivers/pci/controller/pcie-altera.c | 278 ++++++++++++++++++++++++++-
 1 file changed, 268 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 18b2361d6462..d198a73c39fe 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -3,6 +3,7 @@
  * Copyright Altera Corporation (C) 2013-2015. All rights reserved
  *
  * Author: Ley Foon Tan <lftan@altera.com>
+ * Author: sharath <sharath.kumar.d.m@intel.com>
  * Description: Altera PCIe host controller driver
  */
 
@@ -18,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/bitops.h>
 
 #include "../pci.h"
 
@@ -79,9 +81,21 @@
 #define S10_TLP_FMTTYPE_CFGWR0		0x45
 #define S10_TLP_FMTTYPE_CFGWR1		0x44
 
+#define AGLX_RP_CFG_ADDR(pcie, reg)	\
+	(((pcie)->hip_base) + (reg))
+#define AGLX_RP_SECONDARY(pcie)		\
+	readb(AGLX_RP_CFG_ADDR(pcie, PCI_SECONDARY_BUS))
+
+#define AGLX_BDF_REG 0x00002004
+#define AGLX_ROOT_PORT_IRQ_STATUS 0x14c
+#define AGLX_ROOT_PORT_IRQ_ENABLE 0x150
+#define CFG_AER                   BIT(4)
+static u32 port_conf_off;
+
 enum altera_pcie_version {
 	ALTERA_PCIE_V1 = 0,
 	ALTERA_PCIE_V2,
+	ALTERA_PCIE_V3, /* AGILEX */
 };
 
 struct altera_pcie {
@@ -93,6 +107,7 @@ struct altera_pcie {
 	struct irq_domain	*irq_domain;
 	struct resource		bus_range;
 	const struct altera_pcie_data	*pcie_data;
+	void __iomem		*cs_base;
 };
 
 struct altera_pcie_ops {
@@ -104,6 +119,11 @@ struct altera_pcie_ops {
 			   int size, u32 *value);
 	int (*rp_write_cfg)(struct altera_pcie *pcie, u8 busno,
 			    int where, int size, u32 value);
+	int (*ep_read_cfg)(struct altera_pcie *pcie, u8 busno,
+			unsigned int devfn, int where, int size, u32 *value);
+	int (*ep_write_cfg)(struct altera_pcie *pcie, u8 busno,
+			unsigned int devfn, int where, int size, u32 value);
+	void (*rp_isr)(struct irq_desc *desc);
 };
 
 struct altera_pcie_data {
@@ -133,6 +153,38 @@ static inline u32 cra_readl(struct altera_pcie *pcie, const u32 reg)
 	return readl_relaxed(pcie->cra_base + reg);
 }
 
+static inline void cs_writel(struct altera_pcie *pcie, const u32 value,
+			      const u32 reg)
+{
+	writel_relaxed(value, pcie->cs_base + reg);
+}
+
+static inline void cs_writew(struct altera_pcie *pcie, const u32 value,
+			      const u32 reg)
+{
+	writew_relaxed(value, pcie->cs_base + reg);
+}
+
+static inline void cs_writeb(struct altera_pcie *pcie, const u32 value,
+			      const u32 reg)
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
 static bool altera_pcie_link_up(struct altera_pcie *pcie)
 {
 	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
@@ -147,6 +199,15 @@ static bool s10_altera_pcie_link_up(struct altera_pcie *pcie)
 	return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);
 }
 
+static bool aglx_altera_pcie_link_up(struct altera_pcie *pcie)
+{
+	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie,
+				   pcie->pcie_data->cap_offset +
+				   PCI_EXP_LNKSTA);
+
+	return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);
+}
+
 /*
  * Altera PCIe port uses BAR0 of RC's configuration space as the translation
  * from PCI bus to native BUS.  Entire DDR region is mapped into PCIe space
@@ -427,6 +488,126 @@ static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static int aglx_rp_read_cfg(struct altera_pcie *pcie, int where,
+			   int size, u32 *value)
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
+	if (where == 0x3d)
+		*value = 0x01;
+	if (where == 0x3c)
+		*value |= 0x0100;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int aglx_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
+			    int where, int size, u32 value)
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
+	cs_writel(pcie, ((busno << 8) | devfn), AGLX_BDF_REG);
+	if (busno > AGLX_RP_SECONDARY(pcie)) {
+		/* type 1 */
+		switch (size) {
+		case 1:
+			cs_writeb(pcie, value, ((1 << 12) | where));
+			break;
+		case 2:
+			cs_writew(pcie, value, ((1 << 12) | where));
+			break;
+		default:
+			cs_writel(pcie, value, ((1 << 12) | where));
+			break;
+		}
+	} else {
+		/* type 0 */
+		switch (size) {
+		case 1:
+			cs_writeb(pcie, value, where);
+			break;
+		case 2:
+			cs_writew(pcie, value, where);
+			break;
+		default:
+			cs_writel(pcie, value, where);
+				break;
+		}
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int aglx_ep_read_cfg(struct altera_pcie *pcie, u8 busno,
+		unsigned int devfn, int where, int size, u32 *value)
+{
+	cs_writel(pcie, ((busno << 8) | devfn), AGLX_BDF_REG);
+	if (busno > AGLX_RP_SECONDARY(pcie)) {
+		/* type 0 */
+		switch (size) {
+		case 1:
+			*value = cs_readb(pcie, ((1 << 12) | where));
+			break;
+		case 2:
+			*value = cs_readw(pcie, ((1 << 12) | where));
+			break;
+		default:
+			*value = cs_readl(pcie, ((1 << 12) | where));
+			break;
+		}
+	} else {
+		/* type 0 */
+		switch (size) {
+		case 1:
+			*value = cs_readb(pcie, where);
+			break;
+		case 2:
+			*value = cs_readw(pcie, where);
+			break;
+		default:
+			*value = cs_readl(pcie, where);
+			break;
+		}
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
 				 unsigned int devfn, int where, int size,
 				 u32 *value)
@@ -439,6 +620,10 @@ static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
 		return pcie->pcie_data->ops->rp_read_cfg(pcie, where,
 							 size, value);
 
+	if (pcie->pcie_data->ops->ep_read_cfg)
+		return pcie->pcie_data->ops->ep_read_cfg(pcie, busno, devfn,
+							where, size, value);
+
 	switch (size) {
 	case 1:
 		byte_en = 1 << (where & 3);
@@ -483,6 +668,10 @@ static int _altera_pcie_cfg_write(struct altera_pcie *pcie, u8 busno,
 		return pcie->pcie_data->ops->rp_write_cfg(pcie, busno,
 						     where, size, value);
 
+	if (pcie->pcie_data->ops->ep_write_cfg)
+		return pcie->pcie_data->ops->ep_write_cfg(pcie, busno, devfn,
+						     where, size, value);
+
 	switch (size) {
 	case 1:
 		data32 = (value & 0xff) << shift;
@@ -661,7 +850,30 @@ static void altera_pcie_isr(struct irq_desc *desc)
 				dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n", bit);
 		}
 	}
+	chained_irq_exit(chip, desc);
+}
 
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
+			+ AGLX_ROOT_PORT_IRQ_STATUS));
 	chained_irq_exit(chip, desc);
 }
 
@@ -692,11 +904,27 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 {
 	struct platform_device *pdev = pcie->pdev;
 
-	pcie->cra_base = devm_platform_ioremap_resource_byname(pdev, "Cra");
-	if (IS_ERR(pcie->cra_base))
-		return PTR_ERR(pcie->cra_base);
+	if ((pcie->pcie_data->version == ALTERA_PCIE_V1) ||
+		(pcie->pcie_data->version == ALTERA_PCIE_V2)) {
+		pcie->cra_base =
+			devm_platform_ioremap_resource_byname(pdev, "Cra");
+		if (IS_ERR(pcie->cra_base))
+			return PTR_ERR(pcie->cra_base);
+	}
 
-	if (pcie->pcie_data->version == ALTERA_PCIE_V2) {
+	if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
+		pcie->cs_base =
+			devm_platform_ioremap_resource_byname(pdev, "Cs");
+		if (IS_ERR(pcie->cs_base))
+			return PTR_ERR(pcie->cs_base);
+		of_property_read_u32(pcie->pdev->dev.of_node, "port_conf_stat",
+				&port_conf_off);
+		dev_info(&pcie->pdev->dev, "port_conf_stat_off =%x\n",
+			port_conf_off);
+	}
+
+	if ((pcie->pcie_data->version == ALTERA_PCIE_V2) ||
+		(pcie->pcie_data->version == ALTERA_PCIE_V3)) {
 		pcie->hip_base =
 			devm_platform_ioremap_resource_byname(pdev, "Hip");
 		if (IS_ERR(pcie->hip_base))
@@ -708,7 +936,8 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	if (pcie->irq < 0)
 		return pcie->irq;
 
-	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
+	irq_set_chained_handler_and_data(pcie->irq,
+		pcie->pcie_data->ops->rp_isr, pcie);
 	return 0;
 }
 
@@ -721,6 +950,7 @@ static const struct altera_pcie_ops altera_pcie_ops_1_0 = {
 	.tlp_read_pkt = tlp_read_packet,
 	.tlp_write_pkt = tlp_write_packet,
 	.get_link_status = altera_pcie_link_up,
+	.rp_isr = altera_pcie_isr,
 };
 
 static const struct altera_pcie_ops altera_pcie_ops_2_0 = {
@@ -729,6 +959,16 @@ static const struct altera_pcie_ops altera_pcie_ops_2_0 = {
 	.get_link_status = s10_altera_pcie_link_up,
 	.rp_read_cfg = s10_rp_read_cfg,
 	.rp_write_cfg = s10_rp_write_cfg,
+	.rp_isr = altera_pcie_isr,
+};
+
+static const struct altera_pcie_ops altera_pcie_ops_3_0 = {
+	.rp_read_cfg = aglx_rp_read_cfg,
+	.rp_write_cfg = aglx_rp_write_cfg,
+	.get_link_status = aglx_altera_pcie_link_up,
+	.ep_read_cfg = aglx_ep_read_cfg,
+	.ep_write_cfg = aglx_ep_write_cfg,
+	.rp_isr = aglx_isr,
 };
 
 static const struct altera_pcie_data altera_pcie_1_0_data = {
@@ -751,11 +991,23 @@ static const struct altera_pcie_data altera_pcie_2_0_data = {
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
+	 .data = &altera_pcie_3_0_data },
 	{},
 };
 
@@ -793,11 +1045,17 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* clear all interrupts */
-	cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
-	/* enable all interrupts */
-	cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
-	altera_pcie_host_init(pcie);
+	if ((pcie->pcie_data->version == ALTERA_PCIE_V1) ||
+		(pcie->pcie_data->version == ALTERA_PCIE_V2)) {
+		/* clear all interrupts */
+		cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
+		/* enable all interrupts */
+		cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
+		altera_pcie_host_init(pcie);
+	} else if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
+		writel(CFG_AER, (pcie->hip_base + port_conf_off
+			+ AGLX_ROOT_PORT_IRQ_ENABLE));
+	}
 
 	bridge->sysdata = pcie;
 	bridge->busnr = pcie->root_bus_nr;
-- 
2.34.1

