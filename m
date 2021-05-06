Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DEF375760
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhEFPf0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235645AbhEFPdw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6416261468;
        Thu,  6 May 2021 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315173;
        bh=OEaFaYCn4Fs+blLV4e+MvHGsjsrcVg0+nuuN5Mw4ZwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ng9dDMo+LuMGAj/2YXtZTh6SPrG+ul3sPkewAKWkEgoOK55x6JPqyE0Vd8rPRrO5R
         ht7cgzBqxZQ5jZonBDQ5N0ZS8T9BYgN7V4KXM9ZrP7JMpOooHqSgg8Ny9ErH7JNa3E
         sDpFUF8d1zcSHwp12X8SfAA4s2IuTlu72U/KekZ3gQnATCr+zC+JqpPfjMTucepPhU
         F1r7b70iPbttT9N5TtGleguUlZLFlU/WVdtPgN12r6dA4H3kg7IH4Fh17evA20PLQ3
         GNR5xgAqSzZyw2U+3Xg7HJ4UPcuIVslBgh7FpBPof/9kWFTa+Q6rt607ni5Nxflczt
         54XN5UpBn3aVw==
Received: by pali.im (Postfix)
        id 1B9FC732; Thu,  6 May 2021 17:32:53 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 30/42] PCI: aardvark: Rewrite irq code to chained irq handler
Date:   Thu,  6 May 2021 17:31:41 +0200
Message-Id: <20210506153153.30454-31-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

advk_pcie_irq_handler() reads irq status bits and calls other functions
based on which bits are set. These function then reads its own irq status
bits and calls other aardvark functions based on these bits. Finally
generic_handle_irq() with translated linux irq numbers are called.

Rewrite the code to use irq_set_chained_handler_and_data() handler with
chained_irq_enter() and chained_irq_exit() processing instead of using
devm_request_irq().

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 45 ++++++++++++++-------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index b1e6a8a839e0..f2ed276b7e18 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -193,6 +193,7 @@ struct advk_msi_range {
 struct advk_pcie {
 	struct platform_device *pdev;
 	void __iomem *base;
+	int irq;
 	struct irq_domain *irq_domain;
 	struct irq_chip irq_chip;
 	struct irq_domain *msi_domain;
@@ -1283,21 +1284,24 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
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
+		advk_writel(pcie, PCIE_IRQ_CORE_INT, HOST_CTRL_INT_STATUS_REG);
+	}
 
-	return IRQ_HANDLED;
+	chained_irq_exit(chip, desc);
 }
 
 static void __maybe_unused advk_pcie_disable_phy(struct advk_pcie *pcie)
@@ -1363,7 +1367,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct advk_pcie *pcie;
 	struct pci_host_bridge *bridge;
-	int ret, irq;
+	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct advk_pcie));
 	if (!bridge)
@@ -1377,17 +1381,9 @@ static int advk_pcie_probe(struct platform_device *pdev)
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
@@ -1436,6 +1432,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	irq_set_chained_handler_and_data(pcie->irq, advk_pcie_irq_handler, pcie);
+
 	bridge->sysdata = pcie;
 	bridge->ops = &advk_pcie_ops;
 
@@ -1443,6 +1441,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		advk_pcie_remove_msi_irq_domain(pcie);
 		advk_pcie_remove_irq_domain(pcie);
+		irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 		return ret;
 	}
 
@@ -1491,6 +1490,8 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	advk_pcie_remove_msi_irq_domain(pcie);
 	advk_pcie_remove_irq_domain(pcie);
 
+	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
+
 	/* Free config space for emulated root bridge */
 	pci_bridge_emul_cleanup(&pcie->bridge);
 
-- 
2.20.1

