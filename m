Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C56945FF04
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351293AbhK0OKS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355187AbhK0OIS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:08:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C9FC061759
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:05:03 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q3so2301266wru.5
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5SmlbGz5AzGOa51KDhhJi2z8boXsxZopGisOzaRi8bk=;
        b=Sn37F6D2scr5ALYazYqPTPOXpkAkxdlUDsTUN6iDxTWm+LjV2feo0yON9q90bw1IsS
         X81M9vDGt0yuztA37IyMLARoLi0ZEH0KqCFdpxXAcgGpN2HPEKuwnpu1E0DqRjlTLrum
         Nb7xvYOLX+Y2Kcn2Rf2OsmAVKcgp/hocjMm0I/nKsRlowWCisg97OP17S/11Lh2Dd+Ii
         LTjvw4Xn6ApWKxe59K6NYJf7WNh0a5qCJJxmElfqSCmLkNSIwmncVx1jIUipeOQRpM8p
         6RDpHG1uRF2jCfj8DwYVwi0oWloIGuZlU7KiBTydnxf9q66AlFWgUxoQK0YYO8BFRYOx
         7gAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5SmlbGz5AzGOa51KDhhJi2z8boXsxZopGisOzaRi8bk=;
        b=IewNKRh6SS0l1lLq5A+JZSeaLFOI9scsEKAIMHX0cHQTtE4VTw+5Pquz/cFNkQPJhI
         BOTxTbp+MVZyq0XM19sVAOu0pXA72sVWiDbjcKB5hIgj2JpKTP5bwucPuo/rKTovQQT3
         5C2ElzSGlRW5kSZHekPycs8AjxmWxPfmVrOvETm0Dzf2sZru/iErYZqRpTAU35j2OZKW
         Y/eyZP0/byHC8FKqB4q6Zf1p32b5wNIavRe+9phFHcXzf6ieAG3GpcUzSUEszfTyWz0w
         FMdtuBjdosBC0WpOcI30XZEQDDQUViJA66kvIBJ2eyDcz+W24MrJslNzS5coLF7zgQs6
         DNhA==
X-Gm-Message-State: AOAM530Gt1eWmCXva6vQlS9nrrmrzBMVI4TDwHvNV4KdUxnyUB4PnnHU
        gE5cdlamsuaf1ghL/AiWyMCDMCfTIQNu1Q==
X-Google-Smtp-Source: ABdhPJxMxNk+IVigRQqkLbtL9IC0DvRhkzW6Dcq0pYbmB0mMRE/Tk9TwUYdQ3Du1D68zucJHlmVAxQ==
X-Received: by 2002:a05:6000:168e:: with SMTP id y14mr20987065wrd.331.1638021902138;
        Sat, 27 Nov 2021 06:05:02 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id w7sm8447071wru.51.2021.11.27.06.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:05:01 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 3/6] PCI: uniphier: Rename struct uniphier_pcie_priv to uniphier_pcie
Date:   Sat, 27 Nov 2021 15:04:40 +0100
Message-Id: <3eb1b81cb731ab355f53699bf1e15d006ed08327.1638021831.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638021831.git.ffclaire1224@gmail.com>
References: <cover.1638021831.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename struct uniphier_pcie_priv to uniphier_pcie to match the convention
of <driver>_pcie. No functional change intended.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 159 +++++++++++----------
 1 file changed, 87 insertions(+), 72 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index d05be942956e..a899dcfb28c4 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -61,7 +61,7 @@
 #define PCL_RDLH_LINK_UP		BIT(1)
 #define PCL_XMLH_LINK_UP		BIT(0)
 
-struct uniphier_pcie_priv {
+struct uniphier_pcie {
 	void __iomem *base;
 	struct dw_pcie pci;
 	struct clk *clk;
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
@@ -148,39 +148,54 @@ static int uniphier_pcie_link_up(struct dw_pcie *pci)
 
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
+static void uniphier_pcie_irq_ack(struct irq_data *d)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
+	u32 val;
+
+	val = readl(pcie->base + PCL_RCV_INTX);
+	val &= ~PCL_RCV_INTX_ALL_STATUS;
+	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_STATUS_SHIFT);
+	writel(val, pcie->base + PCL_RCV_INTX);
+}
+
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
@@ -189,15 +204,15 @@ static void uniphier_pcie_irq_unmask(struct irq_data *d)
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
@@ -226,13 +241,13 @@ static void uniphier_pcie_irq_handler(struct irq_desc *desc)
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
@@ -243,16 +258,16 @@ static void uniphier_pcie_irq_handler(struct irq_desc *desc)
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
@@ -260,7 +275,7 @@ static void uniphier_pcie_irq_handler(struct irq_desc *desc)
 static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
 	struct device_node *np = pci->dev->of_node;
 	struct device_node *np_intc;
 	int ret = 0;
@@ -278,9 +293,9 @@ static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
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
@@ -297,14 +312,14 @@ static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
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
@@ -313,36 +328,36 @@ static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
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
@@ -356,41 +371,41 @@ static const struct dw_pcie_ops dw_pcie_ops = {
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

