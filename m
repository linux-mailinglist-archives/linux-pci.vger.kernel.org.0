Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C68C47DCA8
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345780AbhLWBLo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345696AbhLWBLh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F4BC061574;
        Wed, 22 Dec 2021 17:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4697FCE1EFE;
        Thu, 23 Dec 2021 01:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAFAC36AE8;
        Thu, 23 Dec 2021 01:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221893;
        bh=3Tj4Y1m9tQ5GKnqMmsuZj0fnhQ1cujxeFXKQmeEOGCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e4T/UIuTuSxuQWUbrBMmwjRXo7GAwjebtuOpycOF3xRaUwUM2hnS7AW4KzQCODVuL
         Uf1Yow7CEEsRjDShB9kOSUEbTUio5deGIxPBrj9mzei059v6Jc+/MdzpiCmR6d99ux
         5yHgct7S8B4wiQWht7gJz7WdNSoUBa9uIAlaPVPQ3BWrxWs31hScI3Ir/CmPZbxXlf
         NW2QUBNu+FPdkpqfngMl57zmf1aKBKn129Vko91N6N0CDXpFfl7FsCwouaOTfqhW+S
         /GHJtEcLlQQGri6PeFR033NCsds6cfpRE2LSZCaCvM+6uTb1L9ADJvLfFxiXY2hrOt
         jT0le0eNfNpXw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 13/23] PCI: ls-gen4: Rename ls_pcie_g4 to ls_g4_pcie
Date:   Wed, 22 Dec 2021 19:10:44 -0600
Message-Id: <20211223011054.1227810-14-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Rename struct ls_pcie_g4 to ls_g4_pcie to match the convention of
<driver>_pcie. No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 .../mobiveil/pcie-layerscape-gen4.c           | 84 +++++++++----------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
index 306950272fd6..d7b7350f02dd 100644
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -34,31 +34,31 @@
 #define PF_DBG_WE			BIT(31)
 #define PF_DBG_PABR			BIT(27)
 
-#define to_ls_pcie_g4(x)		platform_get_drvdata((x)->pdev)
+#define to_ls_g4_pcie(x)		platform_get_drvdata((x)->pdev)
 
-struct ls_pcie_g4 {
+struct ls_g4_pcie {
 	struct mobiveil_pcie pci;
 	struct delayed_work dwork;
 	int irq;
 };
 
-static inline u32 ls_pcie_g4_pf_readl(struct ls_pcie_g4 *pcie, u32 off)
+static inline u32 ls_g4_pcie_pf_readl(struct ls_g4_pcie *pcie, u32 off)
 {
 	return ioread32(pcie->pci.csr_axi_slave_base + PCIE_PF_OFF + off);
 }
 
-static inline void ls_pcie_g4_pf_writel(struct ls_pcie_g4 *pcie,
+static inline void ls_g4_pcie_pf_writel(struct ls_g4_pcie *pcie,
 					u32 off, u32 val)
 {
 	iowrite32(val, pcie->pci.csr_axi_slave_base + PCIE_PF_OFF + off);
 }
 
-static int ls_pcie_g4_link_up(struct mobiveil_pcie *pci)
+static int ls_g4_pcie_link_up(struct mobiveil_pcie *pci)
 {
-	struct ls_pcie_g4 *pcie = to_ls_pcie_g4(pci);
+	struct ls_g4_pcie *pcie = to_ls_g4_pcie(pci);
 	u32 state;
 
-	state = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
+	state = ls_g4_pcie_pf_readl(pcie, PCIE_PF_DBG);
 	state =	state & PF_DBG_LTSSM_MASK;
 
 	if (state == PF_DBG_LTSSM_L0)
@@ -67,14 +67,14 @@ static int ls_pcie_g4_link_up(struct mobiveil_pcie *pci)
 	return 0;
 }
 
-static void ls_pcie_g4_disable_interrupt(struct ls_pcie_g4 *pcie)
+static void ls_g4_pcie_disable_interrupt(struct ls_g4_pcie *pcie)
 {
 	struct mobiveil_pcie *mv_pci = &pcie->pci;
 
 	mobiveil_csr_writel(mv_pci, 0, PAB_INTP_AMBA_MISC_ENB);
 }
 
-static void ls_pcie_g4_enable_interrupt(struct ls_pcie_g4 *pcie)
+static void ls_g4_pcie_enable_interrupt(struct ls_g4_pcie *pcie)
 {
 	struct mobiveil_pcie *mv_pci = &pcie->pci;
 	u32 val;
@@ -87,7 +87,7 @@ static void ls_pcie_g4_enable_interrupt(struct ls_pcie_g4 *pcie)
 	mobiveil_csr_writel(mv_pci, val, PAB_INTP_AMBA_MISC_ENB);
 }
 
-static int ls_pcie_g4_reinit_hw(struct ls_pcie_g4 *pcie)
+static int ls_g4_pcie_reinit_hw(struct ls_g4_pcie *pcie)
 {
 	struct mobiveil_pcie *mv_pci = &pcie->pci;
 	struct device *dev = &mv_pci->pdev->dev;
@@ -97,7 +97,7 @@ static int ls_pcie_g4_reinit_hw(struct ls_pcie_g4 *pcie)
 	/* Poll for pab_csb_reset to set and PAB activity to clear */
 	do {
 		usleep_range(10, 15);
-		val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_INT_STAT);
+		val = ls_g4_pcie_pf_readl(pcie, PCIE_PF_INT_STAT);
 		act_stat = mobiveil_csr_readl(mv_pci, PAB_ACTIVITY_STAT);
 	} while (((val & PF_INT_STAT_PABRST) == 0 || act_stat) && to--);
 	if (to < 0) {
@@ -106,22 +106,22 @@ static int ls_pcie_g4_reinit_hw(struct ls_pcie_g4 *pcie)
 	}
 
 	/* clear PEX_RESET bit in PEX_PF0_DBG register */
-	val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
+	val = ls_g4_pcie_pf_readl(pcie, PCIE_PF_DBG);
 	val |= PF_DBG_WE;
-	ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
+	ls_g4_pcie_pf_writel(pcie, PCIE_PF_DBG, val);
 
-	val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
+	val = ls_g4_pcie_pf_readl(pcie, PCIE_PF_DBG);
 	val |= PF_DBG_PABR;
-	ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
+	ls_g4_pcie_pf_writel(pcie, PCIE_PF_DBG, val);
 
-	val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
+	val = ls_g4_pcie_pf_readl(pcie, PCIE_PF_DBG);
 	val &= ~PF_DBG_WE;
-	ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
+	ls_g4_pcie_pf_writel(pcie, PCIE_PF_DBG, val);
 
 	mobiveil_host_init(mv_pci, true);
 
 	to = 100;
-	while (!ls_pcie_g4_link_up(mv_pci) && to--)
+	while (!ls_g4_pcie_link_up(mv_pci) && to--)
 		usleep_range(200, 250);
 	if (to < 0) {
 		dev_err(dev, "PCIe link training timeout\n");
@@ -131,9 +131,9 @@ static int ls_pcie_g4_reinit_hw(struct ls_pcie_g4 *pcie)
 	return 0;
 }
 
-static irqreturn_t ls_pcie_g4_isr(int irq, void *dev_id)
+static irqreturn_t ls_g4_pcie_isr(int irq, void *dev_id)
 {
-	struct ls_pcie_g4 *pcie = (struct ls_pcie_g4 *)dev_id;
+	struct ls_g4_pcie *pcie = (struct ls_g4_pcie *)dev_id;
 	struct mobiveil_pcie *mv_pci = &pcie->pci;
 	u32 val;
 
@@ -142,7 +142,7 @@ static irqreturn_t ls_pcie_g4_isr(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (val & PAB_INTP_RESET) {
-		ls_pcie_g4_disable_interrupt(pcie);
+		ls_g4_pcie_disable_interrupt(pcie);
 		schedule_delayed_work(&pcie->dwork, msecs_to_jiffies(1));
 	}
 
@@ -151,9 +151,9 @@ static irqreturn_t ls_pcie_g4_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int ls_pcie_g4_interrupt_init(struct mobiveil_pcie *mv_pci)
+static int ls_g4_pcie_interrupt_init(struct mobiveil_pcie *mv_pci)
 {
-	struct ls_pcie_g4 *pcie = to_ls_pcie_g4(mv_pci);
+	struct ls_g4_pcie *pcie = to_ls_g4_pcie(mv_pci);
 	struct platform_device *pdev = mv_pci->pdev;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -162,7 +162,7 @@ static int ls_pcie_g4_interrupt_init(struct mobiveil_pcie *mv_pci)
 	if (pcie->irq < 0)
 		return pcie->irq;
 
-	ret = devm_request_irq(dev, pcie->irq, ls_pcie_g4_isr,
+	ret = devm_request_irq(dev, pcie->irq, ls_g4_pcie_isr,
 			       IRQF_SHARED, pdev->name, pcie);
 	if (ret) {
 		dev_err(dev, "Can't register PCIe IRQ, errno = %d\n", ret);
@@ -172,11 +172,11 @@ static int ls_pcie_g4_interrupt_init(struct mobiveil_pcie *mv_pci)
 	return 0;
 }
 
-static void ls_pcie_g4_reset(struct work_struct *work)
+static void ls_g4_pcie_reset(struct work_struct *work)
 {
 	struct delayed_work *dwork = container_of(work, struct delayed_work,
 						  work);
-	struct ls_pcie_g4 *pcie = container_of(dwork, struct ls_pcie_g4, dwork);
+	struct ls_g4_pcie *pcie = container_of(dwork, struct ls_g4_pcie, dwork);
 	struct mobiveil_pcie *mv_pci = &pcie->pci;
 	u16 ctrl;
 
@@ -184,26 +184,26 @@ static void ls_pcie_g4_reset(struct work_struct *work)
 	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 	mobiveil_csr_writew(mv_pci, ctrl, PCI_BRIDGE_CONTROL);
 
-	if (!ls_pcie_g4_reinit_hw(pcie))
+	if (!ls_g4_pcie_reinit_hw(pcie))
 		return;
 
-	ls_pcie_g4_enable_interrupt(pcie);
+	ls_g4_pcie_enable_interrupt(pcie);
 }
 
-static struct mobiveil_rp_ops ls_pcie_g4_rp_ops = {
-	.interrupt_init = ls_pcie_g4_interrupt_init,
+static struct mobiveil_rp_ops ls_g4_pcie_rp_ops = {
+	.interrupt_init = ls_g4_pcie_interrupt_init,
 };
 
-static const struct mobiveil_pab_ops ls_pcie_g4_pab_ops = {
-	.link_up = ls_pcie_g4_link_up,
+static const struct mobiveil_pab_ops ls_g4_pcie_pab_ops = {
+	.link_up = ls_g4_pcie_link_up,
 };
 
-static int __init ls_pcie_g4_probe(struct platform_device *pdev)
+static int __init ls_g4_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
 	struct mobiveil_pcie *mv_pci;
-	struct ls_pcie_g4 *pcie;
+	struct ls_g4_pcie *pcie;
 	struct device_node *np = dev->of_node;
 	int ret;
 
@@ -220,13 +220,13 @@ static int __init ls_pcie_g4_probe(struct platform_device *pdev)
 	mv_pci = &pcie->pci;
 
 	mv_pci->pdev = pdev;
-	mv_pci->ops = &ls_pcie_g4_pab_ops;
-	mv_pci->rp.ops = &ls_pcie_g4_rp_ops;
+	mv_pci->ops = &ls_g4_pcie_pab_ops;
+	mv_pci->rp.ops = &ls_g4_pcie_rp_ops;
 	mv_pci->rp.bridge = bridge;
 
 	platform_set_drvdata(pdev, pcie);
 
-	INIT_DELAYED_WORK(&pcie->dwork, ls_pcie_g4_reset);
+	INIT_DELAYED_WORK(&pcie->dwork, ls_g4_pcie_reset);
 
 	ret = mobiveil_pcie_host_probe(mv_pci);
 	if (ret) {
@@ -234,22 +234,22 @@ static int __init ls_pcie_g4_probe(struct platform_device *pdev)
 		return  ret;
 	}
 
-	ls_pcie_g4_enable_interrupt(pcie);
+	ls_g4_pcie_enable_interrupt(pcie);
 
 	return 0;
 }
 
-static const struct of_device_id ls_pcie_g4_of_match[] = {
+static const struct of_device_id ls_g4_pcie_of_match[] = {
 	{ .compatible = "fsl,lx2160a-pcie", },
 	{ },
 };
 
-static struct platform_driver ls_pcie_g4_driver = {
+static struct platform_driver ls_g4_pcie_driver = {
 	.driver = {
 		.name = "layerscape-pcie-gen4",
-		.of_match_table = ls_pcie_g4_of_match,
+		.of_match_table = ls_g4_pcie_of_match,
 		.suppress_bind_attrs = true,
 	},
 };
 
-builtin_platform_driver_probe(ls_pcie_g4_driver, ls_pcie_g4_probe);
+builtin_platform_driver_probe(ls_g4_pcie_driver, ls_g4_pcie_probe);
-- 
2.25.1

