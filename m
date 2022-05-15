Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CC5527799
	for <lists+linux-pci@lfdr.de>; Sun, 15 May 2022 15:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiEOM7j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 May 2022 08:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiEOM7i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 May 2022 08:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6B93A739;
        Sun, 15 May 2022 05:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8CE260ED7;
        Sun, 15 May 2022 12:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF53C385B8;
        Sun, 15 May 2022 12:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652619576;
        bh=Er1icabn7IATRCtWvAKCaZjREXU9z20DohHXO16mmQM=;
        h=From:To:Cc:Subject:Date:From;
        b=uTpCEPIgJCY5lRX9hVZ3eN/1yRQ0ujHoW9UKB2JHx4Y5QTrglRVb9vQUZH+sV6kZA
         uf7IuLb+tmtLNPBFUT1kxSdRLAnTZAsq+tljBXQNIPao1/Wb50p3lhH3yI6EhTL3Lk
         udzvKpY4fyPvegyofNS13yU1XWHpvAdnjo3ax45AxXJyOZL+f0m++PXAmMMSE8d5ar
         EMRyUBNVEvAVoktqeymHBO0kXYNWreSgWqD4tGLwrl57p0q6Gw0U8dviFAt92AHdzm
         QQ5QehFLLfevgJSHg0XBT9JrKA7HgOjF7/r/dqinZCHgGkid3GXp4jN4TaFpC6z9Yv
         aZYF0EVkNIw+w==
Received: by pali.im (Postfix)
        id 503B77B8; Sun, 15 May 2022 14:59:32 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "PCI: aardvark: Rewrite IRQ code to chained IRQ handler"
Date:   Sun, 15 May 2022 14:58:15 +0200
Message-Id: <20220515125815.30157-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 1571d67dc190e50c6c56e8f88cdc39f7cc53166e.

This commit broke support for setting interrupt affinity. It looks like
that it is related to the chained IRQ handler. Revert this commit until
issue with setting interrupt affinity is fixed.

Fixes: 1571d67dc190 ("PCI: aardvark: Rewrite IRQ code to chained IRQ handler")
Signed-off-by: Pali Rohár <pali@kernel.org>

---
This commit was introduced in v5.18-rc1 and hence it is regression for 5.18
release. After reverting this commit, it is possible to move aardvark
interrupt from CPU0 to CPU1 by "echo 2 > /proc/irq/XX/smp_affinity" where
XX is the interrupt number which can be find in /proc/interrupts on line
with advk-pcie.
---
 drivers/pci/controller/pci-aardvark.c | 48 ++++++++++++---------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 54651a1808cc..22ac607343bd 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -274,7 +274,6 @@ struct advk_pcie {
 		u32 actions;
 	} wins[OB_WIN_COUNT];
 	u8 wins_count;
-	int irq;
 	struct irq_domain *rp_irq_domain;
 	struct irq_domain *irq_domain;
 	struct irq_chip irq_chip;
@@ -1664,26 +1663,21 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	}
 }
 
-static void advk_pcie_irq_handler(struct irq_desc *desc)
+static irqreturn_t advk_pcie_irq_handler(int irq, void *arg)
 {
-	struct advk_pcie *pcie = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	u32 val, mask, status;
+	struct advk_pcie *pcie = arg;
+	u32 status;
 
-	chained_irq_enter(chip, desc);
+	status = advk_readl(pcie, HOST_CTRL_INT_STATUS_REG);
+	if (!(status & PCIE_IRQ_CORE_INT))
+		return IRQ_NONE;
 
-	val = advk_readl(pcie, HOST_CTRL_INT_STATUS_REG);
-	mask = advk_readl(pcie, HOST_CTRL_INT_MASK_REG);
-	status = val & ((~mask) & PCIE_IRQ_ALL_MASK);
+	advk_pcie_handle_int(pcie);
 
-	if (status & PCIE_IRQ_CORE_INT) {
-		advk_pcie_handle_int(pcie);
+	/* Clear interrupt */
+	advk_writel(pcie, PCIE_IRQ_CORE_INT, HOST_CTRL_INT_STATUS_REG);
 
-		/* Clear interrupt */
-		advk_writel(pcie, PCIE_IRQ_CORE_INT, HOST_CTRL_INT_STATUS_REG);
-	}
-
-	chained_irq_exit(chip, desc);
+	return IRQ_HANDLED;
 }
 
 static int advk_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
@@ -1763,7 +1757,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	struct advk_pcie *pcie;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
-	int ret;
+	int ret, irq;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct advk_pcie));
 	if (!bridge)
@@ -1849,9 +1843,17 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->base))
 		return PTR_ERR(pcie->base);
 
-	pcie->irq = platform_get_irq(pdev, 0);
-	if (pcie->irq < 0)
-		return pcie->irq;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, advk_pcie_irq_handler,
+			       IRQF_SHARED | IRQF_NO_THREAD, "advk-pcie",
+			       pcie);
+	if (ret) {
+		dev_err(dev, "Failed to register interrupt\n");
+		return ret;
+	}
 
 	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
 						       "reset-gpios", 0,
@@ -1916,15 +1918,12 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	irq_set_chained_handler_and_data(pcie->irq, advk_pcie_irq_handler, pcie);
-
 	bridge->sysdata = pcie;
 	bridge->ops = &advk_pcie_ops;
 	bridge->map_irq = advk_pcie_map_irq;
 
 	ret = pci_host_probe(bridge);
 	if (ret < 0) {
-		irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 		advk_pcie_remove_rp_irq_domain(pcie);
 		advk_pcie_remove_msi_irq_domain(pcie);
 		advk_pcie_remove_irq_domain(pcie);
@@ -1973,9 +1972,6 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
 	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
 
-	/* Remove IRQ handler */
-	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
-
 	/* Remove IRQ domains */
 	advk_pcie_remove_rp_irq_domain(pcie);
 	advk_pcie_remove_msi_irq_domain(pcie);
-- 
2.20.1

