Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8638146CDA6
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhLHGWw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48474 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbhLHGWw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46587B81FA7
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7318C341C3;
        Wed,  8 Dec 2021 06:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944359;
        bh=730D4kCLanCh63s5LsGLNpEJREKp9B9bQn6TmiBL9tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vr7bxkNatt3f5nlZkMFErR8NB9+z/YTNrI6VnZdTI+s46rtWrLFea2+06jJ/W8RpY
         NsIhK/7VwRFwwrCX87NseXQWiSqATmTnliFOXnY4OsRiSYxZ2mYyiYbTfWj9Iljsai
         xQb18O2S5qnVDuxIPm6LsJTd6pcN+ldlaEHIgkMv/QyoR5fcRn2IR7kRkIzHrgr/dS
         yCvmcNpcmwHcBU4kKwZkezy22GPomLEL1Ey0BUrU9aYlI5IYnBD6BKf0JAw5gJKyBR
         hZShqxXOI/OxJS5QEEbZQqtMQXwtRSBfb5S9SV8ujyugvUeeBY42nMRKpRytk2h1um
         P32MrFfMPLAeQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 14/17] PCI: aardvark: Use separate INTA interrupt for emulated root bridge
Date:   Wed,  8 Dec 2021 07:18:48 +0100
Message-Id: <20211208061851.31867-15-kabel@kernel.org>
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

Emulated root bridge currently provides only one Legacy INTA interrupt
which is used for reporting PCIe PME and ERR events and handled by kernel
PCIe PME and AER drivers.

Aardvark HW reports these PME and ERR events separately, so there is no
need to mix real INTA interrupt and emulated INTA interrupt for PCIe PME
and AER drivers.

Register a new advk-EMU irq chip and a new irq domain for emulated root
bridge and use this new separate irq domain for providing INTA interrupt
from emulated root bridge for PME and ERR events.

The real INTA interrupt from real devices is now separate.

A custom map_irq callback function on PCI host bridge structure is used to
allocate IRQ mapping for emulated root bridge from new irq domain. Original
callback of_irq_parse_and_map_pci() is used for all other devices as before.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 66 ++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index bea44bd5cc0c..b3e64ae8c438 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -278,6 +278,8 @@ struct advk_pcie {
 	} wins[OB_WIN_COUNT];
 	u8 wins_count;
 	int irq;
+	struct irq_domain *emul_irq_domain;
+	struct irq_chip emul_irq_chip;
 	struct irq_domain *irq_domain;
 	struct irq_chip irq_chip;
 	raw_spinlock_t irq_lock;
@@ -1450,6 +1452,40 @@ static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
 	irq_domain_remove(pcie->irq_domain);
 }
 
+static int advk_pcie_emul_irq_map(struct irq_domain *h,
+				  unsigned int virq, irq_hw_number_t hwirq)
+{
+	struct advk_pcie *pcie = h->host_data;
+
+	irq_set_chip_and_handler(virq, &pcie->emul_irq_chip, handle_simple_irq);
+	irq_set_chip_data(virq, pcie);
+
+	return 0;
+}
+
+static const struct irq_domain_ops advk_pcie_emul_irq_domain_ops = {
+	.map = advk_pcie_emul_irq_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int advk_pcie_init_emul_irq_domain(struct advk_pcie *pcie)
+{
+	pcie->emul_irq_chip.name = "advk-EMU";
+	pcie->emul_irq_domain = irq_domain_add_linear(NULL, 1,
+				&advk_pcie_emul_irq_domain_ops, pcie);
+	if (!pcie->emul_irq_domain) {
+		dev_err(&pcie->pdev->dev, "Failed to add emul IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void advk_pcie_remove_emul_irq_domain(struct advk_pcie *pcie)
+{
+	irq_domain_remove(pcie->emul_irq_domain);
+}
+
 static void advk_pcie_handle_pme(struct advk_pcie *pcie)
 {
 	u32 requester = advk_readl(pcie, PCIE_MSG_LOG_REG) >> 16;
@@ -1469,7 +1505,7 @@ static void advk_pcie_handle_pme(struct advk_pcie *pcie)
 		 * Aardvark HW returns zero for PCI_EXP_FLAGS_IRQ, so use PCIe interrupt 0.
 		 */
 		if (le16_to_cpu(pcie->bridge.pcie_conf.rootctl) & PCI_EXP_RTCTL_PMEIE) {
-			if (generic_handle_domain_irq(pcie->irq_domain, 0) == -EINVAL)
+			if (generic_handle_domain_irq(pcie->emul_irq_domain, 0) == -EINVAL)
 				dev_err_ratelimited(&pcie->pdev->dev, "unhandled ERR IRQ\n");
 		}
 	}
@@ -1523,7 +1559,7 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 		 * Aardvark HW returns zero for PCI_ERR_ROOT_AER_IRQ, so use
 		 * PCIe interrupt 0
 		 */
-		if (generic_handle_domain_irq(pcie->irq_domain, 0) == -EINVAL)
+		if (generic_handle_domain_irq(pcie->emul_irq_domain, 0) == -EINVAL)
 			dev_err_ratelimited(&pcie->pdev->dev, "unhandled ERR IRQ\n");
 	}
 
@@ -1565,6 +1601,21 @@ static void advk_pcie_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int advk_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct advk_pcie *pcie = dev->bus->sysdata;
+
+	/*
+	 * Emulated root bridge has its own emulated irq chip and irq domain.
+	 * Argument pin is the INTx pin (1=INTA, 2=INTB, 3=INTC, 4=INTD) and
+	 * hwirq for irq_create_mapping() is indexed from zero.
+	 */
+	if (pci_is_root_bus(dev->bus))
+		return irq_create_mapping(pcie->emul_irq_domain, pin - 1);
+	else
+		return of_irq_parse_and_map_pci(dev, slot, pin);
+}
+
 static void advk_pcie_disable_phy(struct advk_pcie *pcie)
 {
 	phy_power_off(pcie->phy);
@@ -1766,14 +1817,24 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = advk_pcie_init_emul_irq_domain(pcie);
+	if (ret) {
+		dev_err(dev, "Failed to initialize irq\n");
+		advk_pcie_remove_msi_irq_domain(pcie);
+		advk_pcie_remove_irq_domain(pcie);
+		return ret;
+	}
+
 	irq_set_chained_handler_and_data(pcie->irq, advk_pcie_irq_handler, pcie);
 
 	bridge->sysdata = pcie;
 	bridge->ops = &advk_pcie_ops;
+	bridge->map_irq = advk_pcie_map_irq;
 
 	ret = pci_host_probe(bridge);
 	if (ret < 0) {
 		irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
+		advk_pcie_remove_emul_irq_domain(pcie);
 		advk_pcie_remove_msi_irq_domain(pcie);
 		advk_pcie_remove_irq_domain(pcie);
 		return ret;
@@ -1825,6 +1886,7 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 
 	/* Remove IRQ domains */
+	advk_pcie_remove_emul_irq_domain(pcie);
 	advk_pcie_remove_msi_irq_domain(pcie);
 	advk_pcie_remove_irq_domain(pcie);
 
-- 
2.32.0

