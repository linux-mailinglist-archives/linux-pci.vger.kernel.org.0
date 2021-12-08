Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0712746CD99
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbhLHGWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbhLHGWe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EDCC061574
        for <linux-pci@vger.kernel.org>; Tue,  7 Dec 2021 22:19:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E9341CE2032
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBDBC341CB;
        Wed,  8 Dec 2021 06:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944339;
        bh=C3+g/GnEwap7YbCIqwOfuqe7hCGsOoHEjp0naLppse4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OrrwFuE9pwbsiIA3kc+I0PsySUGqfG1C7jU7Vtj4oULFnoWdUUBZMg4NeV/RBXUXV
         +/yY7JLRZ7FkopnMjyqlRy1IWs2wbkvdHJSzC4tv80GlErg7O5ctR4Yk+LjVna641e
         G3YNHVe5Wq3LdZ5unaMR84tnb+vPPvjcBfPXmlFkDCTqdl43XCAP9v2ETdICd5T7+k
         GMCoASrg2OPtGEnzbYmit9kumR2lWtPKhj8EfIyml2s1H4sO19QQfp0HZUxJTpJWI7
         gz+IpzAMLFwVqd+5w33DQSbFK9A3slBwgFu8gXjOn5gBC57/ylCpPqJzVbhdyAi27V
         y1wyBPxeB+BVg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 02/17] PCI: aardvark: Rewrite IRQ code to chained IRQ handler
Date:   Wed,  8 Dec 2021 07:18:36 +0100
Message-Id: <20211208061851.31867-3-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208061851.31867-1-kabel@kernel.org>
References: <20211208061851.31867-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Rewrite the code to use irq_set_chained_handler_and_data() handler with
chained_irq_enter() and chained_irq_exit() processing instead of using
devm_request_irq().

advk_pcie_irq_handler() reads IRQ status bits and calls other functions
based on which bits are set. These functions then read its own IRQ status
bits and calls other aardvark functions based on these bits. Finally
generic_handle_irq() with translated linux IRQ numbers are called.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 48 +++++++++++++++------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e2ab23f0837f..e7edbc1fd4aa 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -273,6 +273,7 @@ struct advk_pcie {
 		u32 actions;
 	} wins[OB_WIN_COUNT];
 	u8 wins_count;
+	int irq;
 	struct irq_domain *irq_domain;
 	struct irq_chip irq_chip;
 	raw_spinlock_t irq_lock;
@@ -1450,21 +1451,26 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	}
 }
 
-static irqreturn_t advk_pcie_irq_handler(int irq, void *arg)
+static void advk_pcie_irq_handler(struct irq_desc *desc)
 {
-	struct advk_pcie *pcie = arg;
-	u32 status;
+	struct advk_pcie *pcie = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 val, mask, status;
 
-	status = advk_readl(pcie, HOST_CTRL_INT_STATUS_REG);
-	if (!(status & PCIE_IRQ_CORE_INT))
-		return IRQ_NONE;
+	chained_irq_enter(chip, desc);
 
-	advk_pcie_handle_int(pcie);
+	val = advk_readl(pcie, HOST_CTRL_INT_STATUS_REG);
+	mask = advk_readl(pcie, HOST_CTRL_INT_MASK_REG);
+	status = val & ((~mask) & PCIE_IRQ_ALL_MASK);
 
-	/* Clear interrupt */
-	advk_writel(pcie, PCIE_IRQ_CORE_INT, HOST_CTRL_INT_STATUS_REG);
+	if (status & PCIE_IRQ_CORE_INT) {
+		advk_pcie_handle_int(pcie);
 
-	return IRQ_HANDLED;
+		/* Clear interrupt */
+		advk_writel(pcie, PCIE_IRQ_CORE_INT, HOST_CTRL_INT_STATUS_REG);
+	}
+
+	chained_irq_exit(chip, desc);
 }
 
 static void advk_pcie_disable_phy(struct advk_pcie *pcie)
@@ -1531,7 +1537,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	struct advk_pcie *pcie;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
-	int ret, irq;
+	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct advk_pcie));
 	if (!bridge)
@@ -1617,17 +1623,9 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->base))
 		return PTR_ERR(pcie->base);
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_irq(dev, irq, advk_pcie_irq_handler,
-			       IRQF_SHARED | IRQF_NO_THREAD, "advk-pcie",
-			       pcie);
-	if (ret) {
-		dev_err(dev, "Failed to register interrupt\n");
-		return ret;
-	}
+	pcie->irq = platform_get_irq(pdev, 0);
+	if (pcie->irq < 0)
+		return pcie->irq;
 
 	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
 						       "reset-gpios", 0,
@@ -1676,11 +1674,14 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	irq_set_chained_handler_and_data(pcie->irq, advk_pcie_irq_handler, pcie);
+
 	bridge->sysdata = pcie;
 	bridge->ops = &advk_pcie_ops;
 
 	ret = pci_host_probe(bridge);
 	if (ret < 0) {
+		irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 		advk_pcie_remove_msi_irq_domain(pcie);
 		advk_pcie_remove_irq_domain(pcie);
 		return ret;
@@ -1728,6 +1729,9 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
 	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
 
+	/* Remove IRQ handler */
+	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
+
 	/* Remove IRQ domains */
 	advk_pcie_remove_msi_irq_domain(pcie);
 	advk_pcie_remove_irq_domain(pcie);
-- 
2.32.0

