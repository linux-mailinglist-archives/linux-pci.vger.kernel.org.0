Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D36659FD92
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfH1IzL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 04:55:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39057 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfH1IzL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 04:55:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id y200so1279515pfb.6
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2019 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=61dyYaNDfoMriJU8h1vKHWMAMUW23idzIVR9rQNePeE=;
        b=EDULofUjipmqi/OcX4WoFwfZ8KYPd0xretxf3bZZ+fJdVac8x9XqRsyv/CJasjax06
         8Ms9Z0vqAEjAzNpNn2n6qmnS1kpWrzyyC1eq429eqtj4UrVRTbucFzu17E75OkI0eXFB
         083pi8jHOlLQT68KaQ7NlMK/uVmszMtJMKgFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=61dyYaNDfoMriJU8h1vKHWMAMUW23idzIVR9rQNePeE=;
        b=qsdQ3x5BZlaVUpD7jVqN3FuYZmJbgy5pz4Ff64INZgVROALHP3biABbsN7b7gK6aqQ
         bkUp6GqXHvqOGx7HIDRsyu5xeBR6/MtqIc62JxNsVfTJdE6AlxK7AphhljQT8MyXsTfP
         pxjA2crIdiYleQntu+x7A6j/3PsUjRBSUEuDn0j5fvzoVLW3YZlwjp3nvKR1ZhdajUrt
         1Kc6qCLO3qXCB7S4mZAPnE+l1MEjNQ6z9HwGS7WcH0+rA4G0tHMzxiHBYRWrduC2opwQ
         n7s/ukps25D81BpdcpODk14VoPg5ILM2Vgq3EcL1jNkLyN1dL3H6Ky9NCrvjweUqsw4r
         Fz6g==
X-Gm-Message-State: APjAAAWMElKg8StleE8kIuz0j2dBkHX2ZYzbXLRQH9QKTfTSekzfcqzS
        qaqda9Zpx5lSufhrhFbpY7oDAw==
X-Google-Smtp-Source: APXvYqxD8Xlzf+0lWvPibYn5NAFTTvFppnqVRYFnZ+dfN/tUhnNeHY0LoFyL3taacenFp6B1kiEtZQ==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr2477446pgh.24.1566982510212;
        Wed, 28 Aug 2019 01:55:10 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z189sm2431386pfb.137.2019.08.28.01.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 01:55:09 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 2/6] PCI: iproc: Add INTx support with better modeling
Date:   Wed, 28 Aug 2019 14:24:44 +0530
Message-Id: <1566982488-9673-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
References: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ray Jui <ray.jui@broadcom.com>

Add PCIe legacy interrupt INTx support to the iProc PCIe driver by
modeling it with its own IRQ domain. All 4 interrupts INTA, INTB, INTC,
INTD share the same interrupt line connected to the GIC in the system,
while the status of each INTx can be obtained through the INTX CSR
register

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 100 +++++++++++++++++++++++++++++++++++-
 drivers/pci/controller/pcie-iproc.h |   6 +++
 2 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index e3ca464..f8edd28 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -270,6 +271,7 @@ enum iproc_pcie_reg {
 
 	/* enable INTx */
 	IPROC_PCIE_INTX_EN,
+	IPROC_PCIE_INTX_CSR,
 
 	/* outbound address mapping */
 	IPROC_PCIE_OARR0,
@@ -314,6 +316,7 @@ static const u16 iproc_pcie_reg_paxb_bcma[] = {
 	[IPROC_PCIE_CFG_ADDR]		= 0x1f8,
 	[IPROC_PCIE_CFG_DATA]		= 0x1fc,
 	[IPROC_PCIE_INTX_EN]		= 0x330,
+	[IPROC_PCIE_INTX_CSR]		= 0x334,
 	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
 };
 
@@ -325,6 +328,7 @@ static const u16 iproc_pcie_reg_paxb[] = {
 	[IPROC_PCIE_CFG_ADDR]		= 0x1f8,
 	[IPROC_PCIE_CFG_DATA]		= 0x1fc,
 	[IPROC_PCIE_INTX_EN]		= 0x330,
+	[IPROC_PCIE_INTX_CSR]		= 0x334,
 	[IPROC_PCIE_OARR0]		= 0xd20,
 	[IPROC_PCIE_OMAP0]		= 0xd40,
 	[IPROC_PCIE_OARR1]		= 0xd28,
@@ -341,6 +345,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
 	[IPROC_PCIE_CFG_ADDR]		= 0x1f8,
 	[IPROC_PCIE_CFG_DATA]		= 0x1fc,
 	[IPROC_PCIE_INTX_EN]		= 0x330,
+	[IPROC_PCIE_INTX_CSR]		= 0x334,
 	[IPROC_PCIE_OARR0]		= 0xd20,
 	[IPROC_PCIE_OMAP0]		= 0xd40,
 	[IPROC_PCIE_OARR1]		= 0xd28,
@@ -846,9 +851,95 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
 	return link_is_active ? 0 : -ENODEV;
 }
 
-static void iproc_pcie_enable(struct iproc_pcie *pcie)
+static int iproc_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			       irq_hw_number_t hwirq)
 {
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = iproc_pcie_intx_map,
+};
+
+static void iproc_pcie_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct iproc_pcie *pcie;
+	struct device *dev;
+	unsigned long status;
+	u32 bit, virq;
+
+	chained_irq_enter(chip, desc);
+	pcie = irq_desc_get_handler_data(desc);
+	dev = pcie->dev;
+
+	/* go through INTx A, B, C, D until all interrupts are handled */
+	do {
+		status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR);
+		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
+			virq = irq_find_mapping(pcie->irq_domain, bit + 1);
+			if (virq)
+				generic_handle_irq(virq);
+			else
+				dev_err(dev, "unexpected INTx%u\n", bit);
+		}
+	} while ((status & SYS_RC_INTX_MASK) != 0);
+
+	chained_irq_exit(chip, desc);
+}
+
+static int iproc_pcie_intx_enable(struct iproc_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	struct device_node *node;
+	int ret;
+
 	iproc_pcie_write_reg(pcie, IPROC_PCIE_INTX_EN, SYS_RC_INTX_MASK);
+	/*
+	 * BCMA devices do not map INTx the same way as platform devices. All
+	 * BCMA needs is the above code to enable INTx
+	 */
+
+	node = of_get_compatible_child(dev->of_node, "brcm,iproc-intc");
+	if (node)
+		pcie->irq = of_irq_get(node, 0);
+
+	if (!node || pcie->irq <= 0)
+		return 0;
+
+	/* set IRQ handler */
+	irq_set_chained_handler_and_data(pcie->irq, iproc_pcie_isr, pcie);
+
+	/* add IRQ domain for INTx */
+	pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX + 1,
+						 &intx_domain_ops, pcie);
+	if (!pcie->irq_domain) {
+		dev_err(dev, "failed to add INTx IRQ domain\n");
+		ret = -ENOMEM;
+		goto err_rm_handler_data;
+	}
+
+	return 0;
+
+err_rm_handler_data:
+	of_node_put(node);
+	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
+
+	return ret;
+}
+
+static void iproc_pcie_intx_disable(struct iproc_pcie *pcie)
+{
+	iproc_pcie_write_reg(pcie, IPROC_PCIE_INTX_EN, 0x0);
+
+	if (pcie->irq <= 0)
+		return;
+
+	irq_domain_remove(pcie->irq_domain);
+	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 }
 
 static inline bool iproc_pcie_ob_is_valid(struct iproc_pcie *pcie,
@@ -1537,7 +1628,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 		goto err_power_off_phy;
 	}
 
-	iproc_pcie_enable(pcie);
+	ret = iproc_pcie_intx_enable(pcie);
+	if (ret) {
+		dev_err(dev, "failed to enable INTx\n");
+		goto err_power_off_phy;
+	}
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		if (iproc_pcie_msi_enable(pcie))
@@ -1582,6 +1677,7 @@ int iproc_pcie_remove(struct iproc_pcie *pcie)
 	pci_remove_root_bus(pcie->root_bus);
 
 	iproc_pcie_msi_disable(pcie);
+	iproc_pcie_intx_disable(pcie);
 
 	phy_power_off(pcie->phy);
 	phy_exit(pcie->phy);
diff --git a/drivers/pci/controller/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
index 4f03ea5..103e568 100644
--- a/drivers/pci/controller/pcie-iproc.h
+++ b/drivers/pci/controller/pcie-iproc.h
@@ -74,6 +74,9 @@ struct iproc_msi;
  * @ib: inbound mapping related parameters
  * @ib_map: outbound mapping region related parameters
  *
+ * @irq: interrupt line wired to the generic GIC for INTx
+ * @irq_domain: IRQ domain for INTx
+ *
  * @need_msi_steer: indicates additional configuration of the iProc PCIe
  * controller is required to steer MSI writes to external interrupt controller
  * @msi: MSI data
@@ -102,6 +105,9 @@ struct iproc_pcie {
 	struct iproc_pcie_ib ib;
 	const struct iproc_pcie_ib_map *ib_map;
 
+	int irq;
+	struct irq_domain *irq_domain;
+
 	bool need_msi_steer;
 	struct iproc_msi *msi;
 };
-- 
2.7.4

