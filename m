Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0043825F2B3
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 07:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgIGFq0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 01:46:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44618 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbgIGFqR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 01:46:17 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 286BB1A16B7;
        Mon,  7 Sep 2020 07:46:12 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C1A281A0FB4;
        Mon,  7 Sep 2020 07:46:06 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 67311402F2;
        Mon,  7 Sep 2020 07:45:55 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com,
        lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 7/7] PCI: layerscape: Add power management support
Date:   Mon,  7 Sep 2020 13:38:01 +0800
Message-Id: <20200907053801.22149-8-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PME_Turn_Off/PME_TO_Ack handshake sequence, and finally
put the PCIe controller into D3 state after the L2/L3 ready
state transition process completion.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape.c  | 384 ++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h |   1 +
 2 files changed, 383 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index be404c16bcbe..ca9ea07f77c1 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -3,13 +3,16 @@
  * PCIe host controller driver for Freescale Layerscape SoCs
  *
  * Copyright (C) 2014 Freescale Semiconductor.
+ * Copyright 2020 NXP
  *
  * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
@@ -27,17 +30,66 @@
 #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
 #define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
 
+#define PCIE_PM_SCR		0x44
+#define PCIE_PM_SCR_PMEPS_D0	0x0
+#define PCIE_PM_SCR_PMEPS_D3	0x3
+
+#define PCIE_LNKCTL		0x80  /* PCIe link ctrl Register */
+
+/* PF Message Command Register */
+#define LS_PCIE_PF_MCR		0x2c
+#define PF_MCR_PTOMR		BIT(0)
+#define PF_MCR_EXL2S		BIT(1)
+
+/* LS1021A PEXn PM Write Control Register */
+#define SCFG_PEXPMWRCR(idx)	(0x5c + (idx) * 0x64)
+#define PMXMTTURNOFF		BIT(31)
+#define SCFG_PEXSFTRSTCR	0x190
+#define PEXSR(idx)		BIT(idx)
+
+/* LS1043A PEX PME control register */
+#define SCFG_PEXPMECR		0x144
+#define PEXPME(idx)		BIT(31 - (idx) * 4)
+
+/* LS1043A PEX LUT debug register */
+#define LS_PCIE_LDBG	0x7fc
+#define LDBG_SR		BIT(30)
+#define LDBG_WE		BIT(31)
+
 #define PCIE_IATU_NUM		6
 
+#define LS_PCIE_IS_L2(v)	\
+	(((v) & PORT_LOGIC_LTSSM_STATE_MASK) == PORT_LOGIC_LTSSM_STATE_L2)
+
+struct ls_pcie;
+
+struct ls_pcie_host_pm_ops {
+	int (*pm_init)(struct ls_pcie *pcie);
+	void (*send_turn_off_message)(struct ls_pcie *pcie);
+	void (*exit_from_l2)(struct ls_pcie *pcie);
+};
+
 struct ls_pcie_drvdata {
+	const u32 pf_off;
+	const u32 lut_off;
 	const struct dw_pcie_host_ops *ops;
+	const struct ls_pcie_host_pm_ops *pm_ops;
 };
 
 struct ls_pcie {
 	struct dw_pcie *pci;
 	const struct ls_pcie_drvdata *drvdata;
+	void __iomem *pf_base;
+	void __iomem *lut_base;
+	bool big_endian;
+	bool ep_presence;
+	bool pm_support;
+	struct regmap *scfg;
+	int index;
 };
 
+#define ls_pcie_lut_readl_addr(addr)	ls_pcie_lut_readl(pcie, addr)
+#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
 #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
 
 static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
@@ -86,6 +138,208 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
 	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
 }
 
+static u32 ls_pcie_lut_readl(struct ls_pcie *pcie, u32 off)
+{
+	if (pcie->big_endian)
+		return ioread32be(pcie->lut_base + off);
+
+	return ioread32(pcie->lut_base + off);
+}
+
+static void ls_pcie_lut_writel(struct ls_pcie *pcie, u32 off, u32 val)
+{
+	if (pcie->big_endian)
+		return iowrite32be(val, pcie->lut_base + off);
+
+	return iowrite32(val, pcie->lut_base + off);
+
+}
+
+static u32 ls_pcie_pf_readl(struct ls_pcie *pcie, u32 off)
+{
+	if (pcie->big_endian)
+		return ioread32be(pcie->pf_base + off);
+
+	return ioread32(pcie->pf_base + off);
+}
+
+static void ls_pcie_pf_writel(struct ls_pcie *pcie, u32 off, u32 val)
+{
+	if (pcie->big_endian)
+		return iowrite32be(val, pcie->pf_base + off);
+
+	return iowrite32(val, pcie->pf_base + off);
+
+}
+
+static void ls_pcie_send_turnoff_msg(struct ls_pcie *pcie)
+{
+	u32 val;
+	int ret;
+
+	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
+	val |= PF_MCR_PTOMR;
+	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
+
+	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
+				 val, !(val & PF_MCR_PTOMR), 100, 10000);
+	if (ret)
+		dev_info(pcie->pci->dev, "poll turn off message timeout\n");
+}
+
+static void ls1021a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	if (!pcie->scfg) {
+		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
+		return;
+	}
+
+	/* Send Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
+	val |= PMXMTTURNOFF;
+	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
+
+	mdelay(10);
+
+	/* Clear Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
+	val &= ~PMXMTTURNOFF;
+	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
+}
+
+static void ls1043a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	if (!pcie->scfg) {
+		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
+		return;
+	}
+
+	/* Send Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMECR, &val);
+	val |= PEXPME(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXPMECR, val);
+
+	mdelay(10);
+
+	/* Clear Turn_off message */
+	regmap_read(pcie->scfg, SCFG_PEXPMECR, &val);
+	val &= ~PEXPME(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXPMECR, val);
+}
+
+static void ls_pcie_exit_from_l2(struct ls_pcie *pcie)
+{
+	u32 val;
+	int ret;
+
+	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
+	val |= PF_MCR_EXL2S;
+	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
+
+	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
+				 val, !(val & PF_MCR_EXL2S), 100, 10000);
+	if (ret)
+		dev_info(pcie->pci->dev, "poll exit L2 state timeout\n");
+}
+
+static void ls_pcie_retrain_link(struct ls_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u32 val;
+
+	val = dw_pcie_readw_dbi(pci, PCIE_LNKCTL);
+	val |= PCI_EXP_LNKCTL_RL;
+	dw_pcie_writew_dbi(pci, PCIE_LNKCTL, val);
+}
+
+static void ls1021a_pcie_exit_from_l2(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
+	val |= PEXSR(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
+
+	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
+	val &= ~PEXSR(pcie->index);
+	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
+
+	mdelay(1);
+
+	ls_pcie_retrain_link(pcie);
+}
+static void ls1043a_pcie_exit_from_l2(struct ls_pcie *pcie)
+{
+	u32 val;
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val |= LDBG_WE;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val |= LDBG_SR;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val &= ~LDBG_SR;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	val = ls_pcie_lut_readl(pcie, LS_PCIE_LDBG);
+	val &= ~LDBG_WE;
+	ls_pcie_lut_writel(pcie, LS_PCIE_LDBG, val);
+
+	mdelay(1);
+
+	ls_pcie_retrain_link(pcie);
+}
+
+static int ls1021a_pcie_pm_init(struct ls_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	u32 index[2];
+	int ret;
+
+	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
+						     "fsl,pcie-scfg");
+	if (IS_ERR(pcie->scfg)) {
+		ret = PTR_ERR(pcie->scfg);
+		dev_err(dev, "No syscfg phandle specified\n");
+		pcie->scfg = NULL;
+		return ret;
+	}
+
+	ret = of_property_read_u32_array(dev->of_node, "fsl,pcie-scfg",
+					 index, 2);
+	if (ret) {
+		pcie->scfg = NULL;
+		return ret;
+	}
+
+	pcie->index = index[1];
+
+	return 0;
+}
+
+static int ls_pcie_pm_init(struct ls_pcie *pcie)
+{
+	return 0;
+}
+
+static void ls_pcie_set_dstate(struct ls_pcie *pcie, u32 dstate)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u32 val;
+
+	val = dw_pcie_readw_dbi(pci, PCIE_PM_SCR);
+	val &= ~PCI_PM_CTRL_STATE_MASK;
+	val |= dstate;
+	dw_pcie_writew_dbi(pci, PCIE_PM_SCR, val);
+}
+
 static int ls_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -133,20 +387,52 @@ static int ls_pcie_msi_host_init(struct pcie_port *pp)
 	return 0;
 }
 
+static struct ls_pcie_host_pm_ops ls1021a_pcie_host_pm_ops = {
+	.pm_init = &ls1021a_pcie_pm_init,
+	.send_turn_off_message = &ls1021a_pcie_send_turnoff_msg,
+	.exit_from_l2 = &ls1021a_pcie_exit_from_l2,
+};
+
+static struct ls_pcie_host_pm_ops ls1043a_pcie_host_pm_ops = {
+	.pm_init = &ls1021a_pcie_pm_init,
+	.send_turn_off_message = &ls1043a_pcie_send_turnoff_msg,
+	.exit_from_l2 = &ls1043a_pcie_exit_from_l2,
+};
+
+static struct ls_pcie_host_pm_ops ls_pcie_host_pm_ops = {
+	.pm_init = &ls_pcie_pm_init,
+	.send_turn_off_message = &ls_pcie_send_turnoff_msg,
+	.exit_from_l2 = &ls_pcie_exit_from_l2,
+};
+
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
 	.msi_host_init = ls_pcie_msi_host_init,
 };
 
+static const struct ls_pcie_drvdata ls1021a_drvdata = {
+	.ops = &ls_pcie_host_ops,
+	.pm_ops = &ls1021a_pcie_host_pm_ops,
+};
+
+static const struct ls_pcie_drvdata ls1043a_drvdata = {
+	.ops = &ls_pcie_host_ops,
+	.lut_off = 0x10000,
+	.pm_ops = &ls1043a_pcie_host_pm_ops,
+};
+
 static const struct ls_pcie_drvdata layerscape_drvdata = {
 	.ops = &ls_pcie_host_ops,
+	.lut_off = 0x80000,
+	.pf_off = 0xc0000,
+	.pm_ops = &ls_pcie_host_pm_ops,
 };
 
 static const struct of_device_id ls_pcie_of_match[] = {
 	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
-	{ .compatible = "fsl,ls1021a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021a_drvdata },
 	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
-	{ .compatible = "fsl,ls1043a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043a_drvdata },
 	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
 	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
 	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
@@ -170,6 +456,15 @@ static int __init ls_add_pcie_port(struct ls_pcie *pcie)
 		return ret;
 	}
 
+	if (dw_pcie_link_up(pci)) {
+		dev_dbg(pci->dev, "Endpoint is present\n");
+		pcie->ep_presence = true;
+	}
+
+	if (pcie->drvdata->pm_ops && pcie->drvdata->pm_ops->pm_init &&
+	    !pcie->drvdata->pm_ops->pm_init(pcie))
+		pcie->pm_support = true;
+
 	return 0;
 }
 
@@ -200,6 +495,14 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
+	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
+
+	if (pcie->drvdata->lut_off)
+		pcie->lut_base = pci->dbi_base + pcie->drvdata->lut_off;
+
+	if (pcie->drvdata->pf_off)
+		pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
+
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
@@ -212,11 +515,88 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static bool ls_pcie_pm_check(struct ls_pcie *pcie)
+{
+	if (!pcie->ep_presence) {
+		dev_dbg(pcie->pci->dev, "Endpoint isn't present\n");
+		return false;
+	}
+
+	if (!pcie->pm_support)
+		return false;
+
+	return true;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ls_pcie_suspend_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+	u32 val;
+	int ret;
+
+	if (!ls_pcie_pm_check(pcie))
+		return 0;
+
+	pcie->drvdata->pm_ops->send_turn_off_message(pcie);
+
+	/* 10ms timeout to check L2 ready */
+	ret = readl_poll_timeout(pci->dbi_base + PCIE_PORT_DEBUG0,
+				 val, LS_PCIE_IS_L2(val), 100, 10000);
+	if (ret) {
+		dev_err(dev, "PCIe link enter L2 timeout! ltssm = 0x%x\n", val);
+		return ret;
+	}
+
+	ls_pcie_set_dstate(pcie, PCIE_PM_SCR_PMEPS_D3);
+
+	return 0;
+}
+
+static int ls_pcie_resume_noirq(struct device *dev)
+{
+	struct ls_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+	int ret;
+
+	if (!ls_pcie_pm_check(pcie))
+		return 0;
+
+	ls_pcie_set_dstate(pcie, PCIE_PM_SCR_PMEPS_D0);
+
+	pcie->drvdata->pm_ops->exit_from_l2(pcie);
+
+	/* delay 10ms to access EP */
+	mdelay(10);
+
+	ret = ls_pcie_host_init(&pci->pp);
+	if (ret) {
+		dev_err(dev, "ls_pcie_host_init failed! ret = 0x%x\n", ret);
+		return ret;
+	}
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret) {
+		dev_err(dev, "wait link up timeout! ret = 0x%x\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops ls_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq,
+				      ls_pcie_resume_noirq)
+};
+
 static struct platform_driver ls_pcie_driver = {
 	.driver = {
 		.name = "layerscape-pcie",
 		.of_match_table = ls_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &ls_pcie_pm_ops,
 	},
 };
 builtin_platform_driver_probe(ls_pcie_driver, ls_pcie_probe);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f911760dcc69..1f2fd03d1eba 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -46,6 +46,7 @@
 #define PCIE_PORT_DEBUG0		0x728
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
+#define PORT_LOGIC_LTSSM_STATE_L2	0x15
 #define PCIE_PORT_DEBUG1		0x72C
 #define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
 #define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
-- 
2.17.1

