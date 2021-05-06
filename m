Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C787375763
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhEFPfg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235680AbhEFPdw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6214613B5;
        Thu,  6 May 2021 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315174;
        bh=JtpzxROGnZVDcJeZYzWfrsnJEYa+UhigCuLwKzPz8pI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7xwc5ANNXpJa4sYpgJ9cScgGOgl2KJRynZD6qVxsvTciEAhMSEZY9Rw/gOM1dJKR
         YRhUlLxjn6KcSeiB6BFwCKxYxrndvvlneMqpRA/sDRPcWTX+Gy+cex9e+jaPjApjID
         8M4Ep7ErS7+tGRKkm+MC9lhABLkBxjnM28NJCrR1vPOlIavw8lZdlwTRFt1RDXC2IT
         FKLA0eSQkU6/MT+bkR4XTE8Rfmh8bPU/9nwWKsvQjQpJkuZDnwh2J/X+lRWhzOIPVj
         YBhFanaOYqNc9ouWufijbUX/F22Qx27TkFLV6yxfNek2rwcHUO7upf1nVS1J12uBE1
         BD5jRGzIsD4KA==
Received: by pali.im (Postfix)
        id 6A75189A; Thu,  6 May 2021 17:32:53 +0200 (CEST)
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
Subject: [PATCH 31/42] PCI: aardvark: Use separate INTA interrupt for emulated root bridge
Date:   Thu,  6 May 2021 17:31:42 +0200
Message-Id: <20210506153153.30454-32-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 66 ++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index f2ed276b7e18..e724d05a61a8 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -194,6 +194,8 @@ struct advk_pcie {
 	struct platform_device *pdev;
 	void __iomem *base;
 	int irq;
+	struct irq_domain *emul_irq_domain;
+	struct irq_chip emul_irq_chip;
 	struct irq_domain *irq_domain;
 	struct irq_chip irq_chip;
 	struct irq_domain *msi_domain;
@@ -1074,6 +1076,22 @@ static const struct irq_domain_ops advk_pcie_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
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
 static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
@@ -1167,6 +1185,24 @@ static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
 	irq_domain_remove(pcie->irq_domain);
 }
 
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
 static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 {
 	struct irq_data *irq_data;
@@ -1244,7 +1280,7 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 			 * Aardvark HW returns zero for PCI_EXP_FLAGS_IRQ, so use PCIe interrupt 0.
 			 */
 			if (le16_to_cpu(pcie->bridge.pcie_conf.rootctl) & PCI_EXP_RTCTL_PMEIE) {
-				virq = irq_find_mapping(pcie->irq_domain, 0);
+				virq = irq_find_mapping(pcie->emul_irq_domain, 0);
 				if (virq)
 					generic_handle_irq(virq);
 				else
@@ -1257,7 +1293,7 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	if (err_bits) {
 		advk_writel(pcie, err_bits, PCIE_ISR0_REG);
 		/* Aardvark HW returns zero for PCI_ERR_ROOT_AER_IRQ, so use PCIe interrupt 0 */
-		virq = irq_find_mapping(pcie->irq_domain, 0);
+		virq = irq_find_mapping(pcie->emul_irq_domain, 0);
 		if (virq)
 			generic_handle_irq(virq);
 		else
@@ -1304,6 +1340,21 @@ static void advk_pcie_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int advk_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct advk_pcie *pcie = dev->bus->sysdata;
+
+	/*
+	 * Emulated root bridge has itw own emulated irq chip and irq domain.
+	 * Variable pin is the INTx pin (1=INTA, 2=INTB, 3=INTC, 4=INTD) and
+	 * hwirq for irq_create_mapping() is indexed from zero.
+	 */
+	if (pci_is_root_bus(dev->bus))
+		return irq_create_mapping(pcie->emul_irq_domain, pin-1);
+	else
+		return of_irq_parse_and_map_pci(dev, slot, pin);
+}
+
 static void __maybe_unused advk_pcie_disable_phy(struct advk_pcie *pcie)
 {
 	phy_power_off(pcie->phy);
@@ -1432,13 +1483,23 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = advk_pcie_init_emul_irq_domain(pcie);
+	if (ret) {
+		dev_err(dev, "Failed to initialize irq\n");
+		advk_pcie_remove_irq_domain(pcie);
+		advk_pcie_remove_msi_irq_domain(pcie);
+		return ret;
+	}
+
 	irq_set_chained_handler_and_data(pcie->irq, advk_pcie_irq_handler, pcie);
 
 	bridge->sysdata = pcie;
 	bridge->ops = &advk_pcie_ops;
+	bridge->map_irq = advk_pcie_map_irq;
 
 	ret = pci_host_probe(bridge);
 	if (ret < 0) {
+		advk_pcie_remove_emul_irq_domain(pcie);
 		advk_pcie_remove_msi_irq_domain(pcie);
 		advk_pcie_remove_irq_domain(pcie);
 		irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
@@ -1487,6 +1548,7 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
 
 	/* Remove IRQ domains */
+	advk_pcie_remove_emul_irq_domain(pcie);
 	advk_pcie_remove_msi_irq_domain(pcie);
 	advk_pcie_remove_irq_domain(pcie);
 
-- 
2.20.1

