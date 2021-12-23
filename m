Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F3947DCB4
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345726AbhLWBMg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:12:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49958 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345738AbhLWBLr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD4DF61C2A;
        Thu, 23 Dec 2021 01:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0343EC36AE8;
        Thu, 23 Dec 2021 01:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221906;
        bh=M3t+lYIXIkPfI+UwADZM/xjt7JNOzevFEnzomazcJes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhYwZhS0dAU9IsRl37aORWZLva/2wElYTog1Pve5HDNyEL+5uHvmiEUIVwHE2A8Qf
         Nd1EAcymov+zksjZz1p7Ymy9Zvx9ghLBqI0Db1nqwkLWgplE9OBeY9ibDikZsEq3tT
         4htCDAeuX+/R1STiQJC5QlUmHUHXSLLIRPaQhCgd6DS7xzzV8KvfCZPv4mN+SEZiWX
         cHu+8bV03v5+6n57WhWckuQ7y9PtTgDGoxu1nibLAnrnAUvSVt25S0A3pD7U7I1q2u
         E6u5e4v+QXXFV/OnTGiAMdK0EWqX2oZJndvXIB2IiZwJJxNe2/6avUA9ih9rrDonA2
         8vfwMw55obHbQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 20/23] PCI: uniphier: Rename uniphier_pcie_priv to uniphier_pcie
Date:   Wed, 22 Dec 2021 19:10:51 -0600
Message-Id: <20211223011054.1227810-21-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Fan Fei <ffclaire1224@gmail.com>

Rename struct uniphier_pcie_priv to uniphier_pcie to match the convention
of <driver>_pcie. No functional change intended.

[bhelgaas: drop extraneous uniphier_pcie_irq_ack() from patch]
Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 147 +++++++++++----------
 1 file changed, 74 insertions(+), 73 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index d05be942956e..b45ac3754242 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -61,9 +61,9 @@
 #define PCL_RDLH_LINK_UP		BIT(1)
 #define PCL_XMLH_LINK_UP		BIT(0)
 
-struct uniphier_pcie_priv {
-	void __iomem *base;
+struct uniphier_pcie {
 	struct dw_pcie pci;
+	void __iomem *base;
 	struct clk *clk;
 	struct reset_control *rst;
 	struct phy *phy;
@@ -72,62 +72,62 @@ struct uniphier_pcie_priv {
 
 #define to_uniphier_pcie(x)	dev_get_drvdata((x)->dev)
 
-static void uniphier_pcie_ltssm_enable(struct uniphier_pcie_priv *priv,
+static void uniphier_pcie_ltssm_enable(struct uniphier_pcie *pcie,
 				       bool enable)
 {
 	u32 val;
 
-	val = readl(priv->base + PCL_APP_READY_CTRL);
+	val = readl(pcie->base + PCL_APP_READY_CTRL);
 	if (enable)
 		val |= PCL_APP_LTSSM_ENABLE;
 	else
 		val &= ~PCL_APP_LTSSM_ENABLE;
-	writel(val, priv->base + PCL_APP_READY_CTRL);
+	writel(val, pcie->base + PCL_APP_READY_CTRL);
 }
 
-static void uniphier_pcie_init_rc(struct uniphier_pcie_priv *priv)
+static void uniphier_pcie_init_rc(struct uniphier_pcie *pcie)
 {
 	u32 val;
 
 	/* set RC MODE */
-	val = readl(priv->base + PCL_MODE);
+	val = readl(pcie->base + PCL_MODE);
 	val |= PCL_MODE_REGEN;
 	val &= ~PCL_MODE_REGVAL;
-	writel(val, priv->base + PCL_MODE);
+	writel(val, pcie->base + PCL_MODE);
 
 	/* use auxiliary power detection */
-	val = readl(priv->base + PCL_APP_PM0);
+	val = readl(pcie->base + PCL_APP_PM0);
 	val |= PCL_SYS_AUX_PWR_DET;
-	writel(val, priv->base + PCL_APP_PM0);
+	writel(val, pcie->base + PCL_APP_PM0);
 
 	/* assert PERST# */
-	val = readl(priv->base + PCL_PINCTRL0);
+	val = readl(pcie->base + PCL_PINCTRL0);
 	val &= ~(PCL_PERST_NOE_REGVAL | PCL_PERST_OUT_REGVAL
 		 | PCL_PERST_PLDN_REGVAL);
 	val |= PCL_PERST_NOE_REGEN | PCL_PERST_OUT_REGEN
 		| PCL_PERST_PLDN_REGEN;
-	writel(val, priv->base + PCL_PINCTRL0);
+	writel(val, pcie->base + PCL_PINCTRL0);
 
-	uniphier_pcie_ltssm_enable(priv, false);
+	uniphier_pcie_ltssm_enable(pcie, false);
 
 	usleep_range(100000, 200000);
 
 	/* deassert PERST# */
-	val = readl(priv->base + PCL_PINCTRL0);
+	val = readl(pcie->base + PCL_PINCTRL0);
 	val |= PCL_PERST_OUT_REGVAL | PCL_PERST_OUT_REGEN;
-	writel(val, priv->base + PCL_PINCTRL0);
+	writel(val, pcie->base + PCL_PINCTRL0);
 }
 
-static int uniphier_pcie_wait_rc(struct uniphier_pcie_priv *priv)
+static int uniphier_pcie_wait_rc(struct uniphier_pcie *pcie)
 {
 	u32 status;
 	int ret;
 
 	/* wait PIPE clock */
-	ret = readl_poll_timeout(priv->base + PCL_PIPEMON, status,
+	ret = readl_poll_timeout(pcie->base + PCL_PIPEMON, status,
 				 status & PCL_PCLK_ALIVE, 100000, 1000000);
 	if (ret) {
-		dev_err(priv->pci.dev,
+		dev_err(pcie->pci.dev,
 			"Failed to initialize controller in RC mode\n");
 		return ret;
 	}
@@ -137,10 +137,10 @@ static int uniphier_pcie_wait_rc(struct uniphier_pcie_priv *priv)
 
 static int uniphier_pcie_link_up(struct dw_pcie *pci)
 {
-	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
 	u32 val, mask;
 
-	val = readl(priv->base + PCL_STATUS_LINK);
+	val = readl(pcie->base + PCL_STATUS_LINK);
 	mask = PCL_RDLH_LINK_UP | PCL_XMLH_LINK_UP;
 
 	return (val & mask) == mask;
@@ -148,39 +148,40 @@ static int uniphier_pcie_link_up(struct dw_pcie *pci)
 
 static int uniphier_pcie_start_link(struct dw_pcie *pci)
 {
-	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
 
-	uniphier_pcie_ltssm_enable(priv, true);
+	uniphier_pcie_ltssm_enable(pcie, true);
 
 	return 0;
 }
 
 static void uniphier_pcie_stop_link(struct dw_pcie *pci)
 {
-	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
 
-	uniphier_pcie_ltssm_enable(priv, false);
+	uniphier_pcie_ltssm_enable(pcie, false);
 }
 
-static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
+static void uniphier_pcie_irq_enable(struct uniphier_pcie *pcie)
 {
-	writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
-	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
+	writel(PCL_RCV_INT_ALL_ENABLE, pcie->base + PCL_RCV_INT);
+	writel(PCL_RCV_INTX_ALL_ENABLE, pcie->base + PCL_RCV_INTX);
 }
 
+
 static void uniphier_pcie_irq_mask(struct irq_data *d)
 {
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
 	unsigned long flags;
 	u32 val;
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	val = readl(priv->base + PCL_RCV_INTX);
+	val = readl(pcie->base + PCL_RCV_INTX);
 	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
-	writel(val, priv->base + PCL_RCV_INTX);
+	writel(val, pcie->base + PCL_RCV_INTX);
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
@@ -189,15 +190,15 @@ static void uniphier_pcie_irq_unmask(struct irq_data *d)
 {
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
 	unsigned long flags;
 	u32 val;
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	val = readl(priv->base + PCL_RCV_INTX);
+	val = readl(pcie->base + PCL_RCV_INTX);
 	val &= ~BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
-	writel(val, priv->base + PCL_RCV_INTX);
+	writel(val, pcie->base + PCL_RCV_INTX);
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
@@ -226,13 +227,13 @@ static void uniphier_pcie_irq_handler(struct irq_desc *desc)
 {
 	struct pcie_port *pp = irq_desc_get_handler_data(desc);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long reg;
 	u32 val, bit;
 
 	/* INT for debug */
-	val = readl(priv->base + PCL_RCV_INT);
+	val = readl(pcie->base + PCL_RCV_INT);
 
 	if (val & PCL_CFG_BW_MGT_STATUS)
 		dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
@@ -243,16 +244,16 @@ static void uniphier_pcie_irq_handler(struct irq_desc *desc)
 	if (val & PCL_CFG_PME_MSI_STATUS)
 		dev_dbg(pci->dev, "PME Interrupt\n");
 
-	writel(val, priv->base + PCL_RCV_INT);
+	writel(val, pcie->base + PCL_RCV_INT);
 
 	/* INTx */
 	chained_irq_enter(chip, desc);
 
-	val = readl(priv->base + PCL_RCV_INTX);
+	val = readl(pcie->base + PCL_RCV_INTX);
 	reg = FIELD_GET(PCL_RCV_INTX_ALL_STATUS, val);
 
 	for_each_set_bit(bit, &reg, PCI_NUM_INTX)
-		generic_handle_domain_irq(priv->legacy_irq_domain, bit);
+		generic_handle_domain_irq(pcie->legacy_irq_domain, bit);
 
 	chained_irq_exit(chip, desc);
 }
@@ -260,7 +261,7 @@ static void uniphier_pcie_irq_handler(struct irq_desc *desc)
 static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
 	struct device_node *np = pci->dev->of_node;
 	struct device_node *np_intc;
 	int ret = 0;
@@ -278,9 +279,9 @@ static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
 		goto out_put_node;
 	}
 
-	priv->legacy_irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
+	pcie->legacy_irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
 						&uniphier_intx_domain_ops, pp);
-	if (!priv->legacy_irq_domain) {
+	if (!pcie->legacy_irq_domain) {
 		dev_err(pci->dev, "Failed to get INTx domain\n");
 		ret = -ENODEV;
 		goto out_put_node;
@@ -297,14 +298,14 @@ static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
 static int uniphier_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
 	int ret;
 
 	ret = uniphier_pcie_config_legacy_irq(pp);
 	if (ret)
 		return ret;
 
-	uniphier_pcie_irq_enable(priv);
+	uniphier_pcie_irq_enable(pcie);
 
 	return 0;
 }
@@ -313,36 +314,36 @@ static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
 	.host_init = uniphier_pcie_host_init,
 };
 
-static int uniphier_pcie_host_enable(struct uniphier_pcie_priv *priv)
+static int uniphier_pcie_host_enable(struct uniphier_pcie *pcie)
 {
 	int ret;
 
-	ret = clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(pcie->clk);
 	if (ret)
 		return ret;
 
-	ret = reset_control_deassert(priv->rst);
+	ret = reset_control_deassert(pcie->rst);
 	if (ret)
 		goto out_clk_disable;
 
-	uniphier_pcie_init_rc(priv);
+	uniphier_pcie_init_rc(pcie);
 
-	ret = phy_init(priv->phy);
+	ret = phy_init(pcie->phy);
 	if (ret)
 		goto out_rst_assert;
 
-	ret = uniphier_pcie_wait_rc(priv);
+	ret = uniphier_pcie_wait_rc(pcie);
 	if (ret)
 		goto out_phy_exit;
 
 	return 0;
 
 out_phy_exit:
-	phy_exit(priv->phy);
+	phy_exit(pcie->phy);
 out_rst_assert:
-	reset_control_assert(priv->rst);
+	reset_control_assert(pcie->rst);
 out_clk_disable:
-	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(pcie->clk);
 
 	return ret;
 }
@@ -356,41 +357,41 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 static int uniphier_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct uniphier_pcie_priv *priv;
+	struct uniphier_pcie *pcie;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
 		return -ENOMEM;
 
-	priv->pci.dev = dev;
-	priv->pci.ops = &dw_pcie_ops;
+	pcie->pci.dev = dev;
+	pcie->pci.ops = &dw_pcie_ops;
 
-	priv->base = devm_platform_ioremap_resource_byname(pdev, "link");
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	pcie->base = devm_platform_ioremap_resource_byname(pdev, "link");
+	if (IS_ERR(pcie->base))
+		return PTR_ERR(pcie->base);
 
-	priv->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
+	pcie->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pcie->clk))
+		return PTR_ERR(pcie->clk);
 
-	priv->rst = devm_reset_control_get_shared(dev, NULL);
-	if (IS_ERR(priv->rst))
-		return PTR_ERR(priv->rst);
+	pcie->rst = devm_reset_control_get_shared(dev, NULL);
+	if (IS_ERR(pcie->rst))
+		return PTR_ERR(pcie->rst);
 
-	priv->phy = devm_phy_optional_get(dev, "pcie-phy");
-	if (IS_ERR(priv->phy))
-		return PTR_ERR(priv->phy);
+	pcie->phy = devm_phy_optional_get(dev, "pcie-phy");
+	if (IS_ERR(pcie->phy))
+		return PTR_ERR(pcie->phy);
 
-	platform_set_drvdata(pdev, priv);
+	platform_set_drvdata(pdev, pcie);
 
-	ret = uniphier_pcie_host_enable(priv);
+	ret = uniphier_pcie_host_enable(pcie);
 	if (ret)
 		return ret;
 
-	priv->pci.pp.ops = &uniphier_pcie_host_ops;
+	pcie->pci.pp.ops = &uniphier_pcie_host_ops;
 
-	return dw_pcie_host_init(&priv->pci.pp);
+	return dw_pcie_host_init(&pcie->pci.pp);
 }
 
 static const struct of_device_id uniphier_pcie_match[] = {
-- 
2.25.1

