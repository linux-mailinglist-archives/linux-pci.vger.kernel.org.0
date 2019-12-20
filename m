Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F3A127447
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 04:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLTDys (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 22:54:48 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36878 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfLTDyq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 22:54:46 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so3524659pjb.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2019 19:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AkOXN1U5p+FA8t9urRZFtx3Sofb7iv3pGbosqKjKqRs=;
        b=bNCUhLtJzwpphDO9+pjk73srA6q0wCM9ztvBg23x0X77leUP30sLTA3bAocQamoI0n
         XJ0oac8POFP6Lp+xQZ6knmalmt7ULbx+Rz84ghIkvLiIFdZ4NnK2ra6EjFMrB+ijfFB6
         /Dsi3CK2XZqZj0MWSz+WiYH6ak3wqN2zTTVAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AkOXN1U5p+FA8t9urRZFtx3Sofb7iv3pGbosqKjKqRs=;
        b=BGAJjBkEn0EmF6FhZaTdJQRG7V9Sdn5SuBFPFXg/MXCDMl/x7jNaBF2DkyaXxQsSLU
         4a+TTXTk8izdRRPtndEsz2Y2x4gxgSZAwQKGQee/Fgh+wD3nZ8Q7dAn+rZAma0R9xeYm
         EHp7mqXuxUIhgWnIFZO7R81pIoY4BjXca7waE71OevdRQn9Uth/zhfs15XG8fIYa5zP4
         jliLcbIB49oymkFzzVGR/SC3aXVfhHvnpt/6oUz5RbY73QmBQ9rLA/QBeR2XOsPlmk/J
         1W1Uck0HNxyZ0mpTQ7WP9/8yLMwV/mmIl86iA1ZyGaceVYJbXZXKhGQt1FtItGg6h+Nu
         4+Cg==
X-Gm-Message-State: APjAAAWeUr2+mqMiBQ8W5JVEXklF8XzK6wrkmVyqIHYUWlWP7ACWee0T
        ZdwO0F/W/xpUEopuzl4vPIY95A==
X-Google-Smtp-Source: APXvYqyNAzJyyIkRooVgrLqc96ZaB3g8apwlmlflB2vLTaGTiuWqG0Fdb/+vnuF9VAsjn+VaxwatzQ==
X-Received: by 2002:a17:90a:8a0e:: with SMTP id w14mr13899092pjn.51.1576814084983;
        Thu, 19 Dec 2019 19:54:44 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t65sm10522205pfd.178.2019.12.19.19.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Dec 2019 19:54:44 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 2/6] PCI: iproc: Add INTx support with better modeling
Date:   Fri, 20 Dec 2019 09:24:14 +0530
Message-Id: <1576814058-30003-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576814058-30003-1-git-send-email-srinath.mannam@broadcom.com>
References: <1576814058-30003-1-git-send-email-srinath.mannam@broadcom.com>
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
 drivers/pci/controller/pcie-iproc.c | 108 +++++++++++++++++++++++++++++++++++-
 drivers/pci/controller/pcie-iproc.h |   6 ++
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 0a468c7..485967b 100644
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
@@ -846,9 +851,103 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
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
+			virq = irq_find_mapping(pcie->irq_domain, bit);
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
+	/*
+	 * BCMA devices do not map INTx the same way as platform devices. All
+	 * BCMA needs below line to enable INTx
+	 */
 	iproc_pcie_write_reg(pcie, IPROC_PCIE_INTX_EN, SYS_RC_INTX_MASK);
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
+	pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
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
+	uint32_t offset, virq;
+
+	iproc_pcie_write_reg(pcie, IPROC_PCIE_INTX_EN, 0x0);
+
+	if (pcie->irq <= 0)
+		return;
+
+	for (offset = 0; offset < PCI_NUM_INTX; offset++) {
+		virq = irq_find_mapping(pcie->irq_domain, offset);
+		if (virq)
+			irq_dispose_mapping(virq);
+	}
+
+	irq_domain_remove(pcie->irq_domain);
+	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 }
 
 static inline bool iproc_pcie_ob_is_valid(struct iproc_pcie *pcie,
@@ -1518,7 +1617,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
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
@@ -1562,6 +1665,7 @@ int iproc_pcie_remove(struct iproc_pcie *pcie)
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

