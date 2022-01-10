Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6CA488E4B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiAJBvF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:51:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38520 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbiAJBvD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:51:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 123A8B8111A
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C84C36AEB;
        Mon, 10 Jan 2022 01:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779460;
        bh=SlxQBQrWAYeP7zsIXGg/ePMIWtH0FKRDMLtj/O82KD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YRKPJbi9w5+Nw35LGPLjwUtfljWGgzorU9gVutqyhOOZbOXRa7FZwDAjKLO2y5QS+
         egC5UOrjGoX90FYbRum6Gfqwu097MnJuhLBz6RQUSb5sO1b1zwZ1+y0Kc1es1247OZ
         CPN1oZRIyJefBdW9QB3DqhRiVZCEOIqsF32fsX3PN/DX6yyE7DYomXGZ2pwYiwwUp3
         xFQKQiPgpY/lpaDhoqMl/ovA0VHOy+GFF0sKMlrTl7pprE45hXFYSLtTLwomFWlggd
         EgpICqDa1mGbN9O45W3MikE+QIlEIW86VIBDaUjg7YQmYCD3ru0LH2q4zvPVhPn7Zy
         3XVHPT1Fheyeg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 18/23] PCI: aardvark: Use separate INTA interrupt for emulated root bridge
Date:   Mon, 10 Jan 2022 02:50:13 +0100
Message-Id: <20220110015018.26359-19-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
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

Register a new advk-RP (as in Root Port) irq chip and a new irq domain
for emulated root bridge and use this new separate irq domain for
providing INTA interrupt from emulated root bridge for PME and ERR events.

The real INTA interrupt from real devices is now separate.

A custom map_irq callback function on PCI host bridge structure is used to
allocate IRQ mapping for emulated root bridge from new irq domain. Original
callback of_irq_parse_and_map_pci() is used for all other devices as before.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 69 ++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 730ff1ffc952..ca519cadcdfe 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -274,6 +274,7 @@ struct advk_pcie {
 	} wins[OB_WIN_COUNT];
 	u8 wins_count;
 	int irq;
+	struct irq_domain *rp_irq_domain;
 	struct irq_domain *irq_domain;
 	struct irq_chip irq_chip;
 	raw_spinlock_t irq_lock;
@@ -1443,6 +1444,44 @@ static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
 	irq_domain_remove(pcie->irq_domain);
 }
 
+static struct irq_chip advk_rp_irq_chip = {
+	.name = "advk-RP",
+};
+
+static int advk_pcie_rp_irq_map(struct irq_domain *h,
+				unsigned int virq, irq_hw_number_t hwirq)
+{
+	struct advk_pcie *pcie = h->host_data;
+
+	irq_set_chip_and_handler(virq, &advk_rp_irq_chip, handle_simple_irq);
+	irq_set_chip_data(virq, pcie);
+
+	return 0;
+}
+
+static const struct irq_domain_ops advk_pcie_rp_irq_domain_ops = {
+	.map = advk_pcie_rp_irq_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int advk_pcie_init_rp_irq_domain(struct advk_pcie *pcie)
+{
+	pcie->rp_irq_domain = irq_domain_add_linear(NULL, 1,
+						    &advk_pcie_rp_irq_domain_ops,
+						    pcie);
+	if (!pcie->rp_irq_domain) {
+		dev_err(&pcie->pdev->dev, "Failed to add Root Port IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void advk_pcie_remove_rp_irq_domain(struct advk_pcie *pcie)
+{
+	irq_domain_remove(pcie->rp_irq_domain);
+}
+
 static void advk_pcie_handle_pme(struct advk_pcie *pcie)
 {
 	u32 requester = advk_readl(pcie, PCIE_MSG_LOG_REG) >> 16;
@@ -1464,7 +1503,7 @@ static void advk_pcie_handle_pme(struct advk_pcie *pcie)
 		if (!(le16_to_cpu(pcie->bridge.pcie_conf.rootctl) & PCI_EXP_RTCTL_PMEIE))
 			return;
 
-		if (generic_handle_domain_irq(pcie->irq_domain, 0) == -EINVAL)
+		if (generic_handle_domain_irq(pcie->rp_irq_domain, 0) == -EINVAL)
 			dev_err_ratelimited(&pcie->pdev->dev, "unhandled PME IRQ\n");
 	}
 }
@@ -1516,7 +1555,7 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 		 * Aardvark HW returns zero for PCI_ERR_ROOT_AER_IRQ, so use
 		 * PCIe interrupt 0
 		 */
-		if (generic_handle_domain_irq(pcie->irq_domain, 0) == -EINVAL)
+		if (generic_handle_domain_irq(pcie->rp_irq_domain, 0) == -EINVAL)
 			dev_err_ratelimited(&pcie->pdev->dev, "unhandled ERR IRQ\n");
 	}
 
@@ -1560,6 +1599,21 @@ static void advk_pcie_irq_handler(struct irq_desc *desc)
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
+		return irq_create_mapping(pcie->rp_irq_domain, pin - 1);
+	else
+		return of_irq_parse_and_map_pci(dev, slot, pin);
+}
+
 static void __maybe_unused advk_pcie_disable_phy(struct advk_pcie *pcie)
 {
 	phy_power_off(pcie->phy);
@@ -1761,14 +1815,24 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = advk_pcie_init_rp_irq_domain(pcie);
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
+		advk_pcie_remove_rp_irq_domain(pcie);
 		advk_pcie_remove_msi_irq_domain(pcie);
 		advk_pcie_remove_irq_domain(pcie);
 		return ret;
@@ -1820,6 +1884,7 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 
 	/* Remove IRQ domains */
+	advk_pcie_remove_rp_irq_domain(pcie);
 	advk_pcie_remove_msi_irq_domain(pcie);
 	advk_pcie_remove_irq_domain(pcie);
 
-- 
2.34.1

