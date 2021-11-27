Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4701645FF06
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355081AbhK0OKX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355066AbhK0OIW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:08:22 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD0FC06175B
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:05:07 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so8682086wme.4
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VDQL0Sms8m+h5yPoYUUMCQK77iVYXtU+uH+9m6AOtjw=;
        b=bgJwwkh2xpnuUqxzv268+0ICdyOD8hfLEKOINDSsiBguHrm+NWO0bpJbPZQ2aPBH6W
         aYS84hm+8fU19xAyNLpnacRI7q9zu60LNorkK5XlDcCBJTf//P1CvVZh2edTcWvh2Tjy
         k13y3HQHIeqDis6akhq0uRvRMzsGz1xqIChQXiLYXEvVruAlWGhH0finZQQXEzHuRBNX
         iL+qHSHQm6spsMH0Lj4udJMjCxNXzFPIYnjMtyTaoID1RLFxpD/noquRmBLFoTlTbHmO
         XgXrC+3AeFq798dXWdmvl/VPDOH99Ee3NIuzoUF/piMK6+zGoyCDs+hTSjZgM33fnrRJ
         MF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VDQL0Sms8m+h5yPoYUUMCQK77iVYXtU+uH+9m6AOtjw=;
        b=wcS+yi88tkNOABvgK6xoo2x7QW1UMTfoFRJMmaBh2q369EqFruLVaDcs55LjiZYzp/
         gtclL1Sw98LTvKq+0jR3tD/f58Yrnq46OWx2Ut7jHZhjXyrfn8kyTKAzQ8xJ63CzVUS8
         cQTA74pK3OuVZApnq59Zo3EyBShDWho1czTUCBWGA8EWAFvxgwz5bYaNhYRJbI2t24T6
         THnZ5cIAL/+pp/LiksDKVNeyHZp3r6vMmMc8efs8lFiJ2Ni4KdmOc3dhn6G3xcV5urqW
         NbjHanhdREyANe+dlikaTDzgaAKMJswdApQydOlcOylC4s2yL3ZM+5g7jN7aTGdsWqJ3
         YsCQ==
X-Gm-Message-State: AOAM532P5PtKD1FKqZGd9C27U0AOg/av3VUirWsdYqER7+CzIpa0BHLE
        J7c+SAeamHDI+GAc2K+I/sA=
X-Google-Smtp-Source: ABdhPJw3zAzTlKPnGgNOqlktwvvVkFb+mX0dVCbtvr0xXGaUC9CKWbVzJfzr0gt8NFE8mZSd+IGlUQ==
X-Received: by 2002:a05:600c:1993:: with SMTP id t19mr23403686wmq.21.1638021906278;
        Sat, 27 Nov 2021 06:05:06 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id w7sm8447071wru.51.2021.11.27.06.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:05:05 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 5/6] PCI: xilinx: Rename struct xilinx_pcie_port to xilinx_pcie
Date:   Sat, 27 Nov 2021 15:04:42 +0100
Message-Id: <93d5066de3f00bdfb74549772909c3fd56c0d5e7.1638021831.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638021831.git.ffclaire1224@gmail.com>
References: <cover.1638021831.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename struct xilinx_pcie_port to xilinx_pcie to match the convention of
<driver>_pcie. No functional change intended.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pcie-xilinx.c | 154 +++++++++++++--------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index aa9bdcebc838..1e7928d81a05 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -91,7 +91,7 @@
 #define XILINX_NUM_MSI_IRQS		128
 
 /**
- * struct xilinx_pcie_port - PCIe port information
+ * struct xilinx_pcie - PCIe port information
  * @reg_base: IO Mapped Register Base
  * @dev: Device pointer
  * @msi_map: Bitmap of allocated MSIs
@@ -100,7 +100,7 @@
  * @leg_domain: Legacy IRQ domain pointer
  * @resources: Bus Resources
  */
-struct xilinx_pcie_port {
+struct xilinx_pcie {
 	void __iomem *reg_base;
 	struct device *dev;
 	unsigned long msi_map[BITS_TO_LONGS(XILINX_NUM_MSI_IRQS)];
@@ -110,35 +110,35 @@ struct xilinx_pcie_port {
 	struct list_head resources;
 };
 
-static inline u32 pcie_read(struct xilinx_pcie_port *port, u32 reg)
+static inline u32 pcie_read(struct xilinx_pcie *pcie, u32 reg)
 {
-	return readl(port->reg_base + reg);
+	return readl(pcie->reg_base + reg);
 }
 
-static inline void pcie_write(struct xilinx_pcie_port *port, u32 val, u32 reg)
+static inline void pcie_write(struct xilinx_pcie *pcie, u32 val, u32 reg)
 {
-	writel(val, port->reg_base + reg);
+	writel(val, pcie->reg_base + reg);
 }
 
-static inline bool xilinx_pcie_link_up(struct xilinx_pcie_port *port)
+static inline bool xilinx_pcie_link_up(struct xilinx_pcie *pcie)
 {
-	return (pcie_read(port, XILINX_PCIE_REG_PSCR) &
+	return (pcie_read(pcie, XILINX_PCIE_REG_PSCR) &
 		XILINX_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
 }
 
 /**
  * xilinx_pcie_clear_err_interrupts - Clear Error Interrupts
- * @port: PCIe port information
+ * @pcie: PCIe port information
  */
-static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie_port *port)
+static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie *pcie)
 {
-	struct device *dev = port->dev;
-	unsigned long val = pcie_read(port, XILINX_PCIE_REG_RPEFR);
+	struct device *dev = pcie->dev;
+	unsigned long val = pcie_read(pcie, XILINX_PCIE_REG_RPEFR);
 
 	if (val & XILINX_PCIE_RPEFR_ERR_VALID) {
 		dev_dbg(dev, "Requester ID %lu\n",
 			val & XILINX_PCIE_RPEFR_REQ_ID);
-		pcie_write(port, XILINX_PCIE_RPEFR_ALL_MASK,
+		pcie_write(pcie, XILINX_PCIE_RPEFR_ALL_MASK,
 			   XILINX_PCIE_REG_RPEFR);
 	}
 }
@@ -152,11 +152,11 @@ static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie_port *port)
  */
 static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
-	struct xilinx_pcie_port *port = bus->sysdata;
+	struct xilinx_pcie *pcie = bus->sysdata;
 
-	/* Check if link is up when trying to access downstream ports */
+	/* Check if link is up when trying to access downstream pcie ports */
 	if (!pci_is_root_bus(bus)) {
-		if (!xilinx_pcie_link_up(port))
+		if (!xilinx_pcie_link_up(pcie))
 			return false;
 	} else if (devfn > 0) {
 		/* Only one device down on each root port */
@@ -177,12 +177,12 @@ static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 static void __iomem *xilinx_pcie_map_bus(struct pci_bus *bus,
 					 unsigned int devfn, int where)
 {
-	struct xilinx_pcie_port *port = bus->sysdata;
+	struct xilinx_pcie *pcie = bus->sysdata;
 
 	if (!xilinx_pcie_valid_device(bus, devfn))
 		return NULL;
 
-	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
+	return pcie->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
 }
 
 /* PCIe operations */
@@ -215,7 +215,7 @@ static int xilinx_msi_set_affinity(struct irq_data *d, const struct cpumask *mas
 
 static void xilinx_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct xilinx_pcie_port *pcie = irq_data_get_irq_chip_data(data);
+	struct xilinx_pcie *pcie = irq_data_get_irq_chip_data(data);
 	phys_addr_t pa = ALIGN_DOWN(virt_to_phys(pcie), SZ_4K);
 
 	msg->address_lo = lower_32_bits(pa);
@@ -232,14 +232,14 @@ static struct irq_chip xilinx_msi_bottom_chip = {
 static int xilinx_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				  unsigned int nr_irqs, void *args)
 {
-	struct xilinx_pcie_port *port = domain->host_data;
+	struct xilinx_pcie *pcie = domain->host_data;
 	int hwirq, i;
 
-	mutex_lock(&port->map_lock);
+	mutex_lock(&pcie->map_lock);
 
-	hwirq = bitmap_find_free_region(port->msi_map, XILINX_NUM_MSI_IRQS, order_base_2(nr_irqs));
+	hwirq = bitmap_find_free_region(pcie->msi_map, XILINX_NUM_MSI_IRQS, order_base_2(nr_irqs));
 
-	mutex_unlock(&port->map_lock);
+	mutex_unlock(&pcie->map_lock);
 
 	if (hwirq < 0)
 		return -ENOSPC;
@@ -256,13 +256,13 @@ static void xilinx_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 				  unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct xilinx_pcie_port *port = domain->host_data;
+	struct xilinx_pcie *pcie = domain->host_data;
 
-	mutex_lock(&port->map_lock);
+	mutex_lock(&pcie->map_lock);
 
-	bitmap_release_region(port->msi_map, d->hwirq, order_base_2(nr_irqs));
+	bitmap_release_region(pcie->msi_map, d->hwirq, order_base_2(nr_irqs));
 
-	mutex_unlock(&port->map_lock);
+	mutex_unlock(&pcie->map_lock);
 }
 
 static const struct irq_domain_ops xilinx_msi_domain_ops = {
@@ -275,7 +275,7 @@ static struct msi_domain_info xilinx_msi_info = {
 	.chip	= &xilinx_msi_top_chip,
 };
 
-static int xilinx_allocate_msi_domains(struct xilinx_pcie_port *pcie)
+static int xilinx_allocate_msi_domains(struct xilinx_pcie *pcie)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
 	struct irq_domain *parent;
@@ -298,7 +298,7 @@ static int xilinx_allocate_msi_domains(struct xilinx_pcie_port *pcie)
 	return 0;
 }
 
-static void xilinx_free_msi_domains(struct xilinx_pcie_port *pcie)
+static void xilinx_free_msi_domains(struct xilinx_pcie *pcie)
 {
 	struct irq_domain *parent = pcie->msi_domain->parent;
 
@@ -342,13 +342,13 @@ static const struct irq_domain_ops intx_domain_ops = {
  */
 static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 {
-	struct xilinx_pcie_port *port = (struct xilinx_pcie_port *)data;
-	struct device *dev = port->dev;
+	struct xilinx_pcie *pcie = (struct xilinx_pcie *)data;
+	struct device *dev = pcie->dev;
 	u32 val, mask, status;
 
 	/* Read interrupt decode and mask registers */
-	val = pcie_read(port, XILINX_PCIE_REG_IDR);
-	mask = pcie_read(port, XILINX_PCIE_REG_IMR);
+	val = pcie_read(pcie, XILINX_PCIE_REG_IDR);
+	mask = pcie_read(pcie, XILINX_PCIE_REG_IMR);
 
 	status = val & mask;
 	if (!status)
@@ -371,23 +371,23 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 	if (status & XILINX_PCIE_INTR_CORRECTABLE) {
 		dev_warn(dev, "Correctable error message\n");
-		xilinx_pcie_clear_err_interrupts(port);
+		xilinx_pcie_clear_err_interrupts(pcie);
 	}
 
 	if (status & XILINX_PCIE_INTR_NONFATAL) {
 		dev_warn(dev, "Non fatal error message\n");
-		xilinx_pcie_clear_err_interrupts(port);
+		xilinx_pcie_clear_err_interrupts(pcie);
 	}
 
 	if (status & XILINX_PCIE_INTR_FATAL) {
 		dev_warn(dev, "Fatal error message\n");
-		xilinx_pcie_clear_err_interrupts(port);
+		xilinx_pcie_clear_err_interrupts(pcie);
 	}
 
 	if (status & (XILINX_PCIE_INTR_INTX | XILINX_PCIE_INTR_MSI)) {
 		struct irq_domain *domain;
 
-		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
+		val = pcie_read(pcie, XILINX_PCIE_REG_RPIFR1);
 
 		/* Check whether interrupt valid */
 		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
@@ -397,17 +397,17 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 		/* Decode the IRQ number */
 		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
-			val = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
+			val = pcie_read(pcie, XILINX_PCIE_REG_RPIFR2) &
 				XILINX_PCIE_RPIFR2_MSG_DATA;
-			domain = port->msi_domain->parent;
+			domain = pcie->msi_domain->parent;
 		} else {
 			val = (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
 				XILINX_PCIE_RPIFR1_INTR_SHIFT;
-			domain = port->leg_domain;
+			domain = pcie->leg_domain;
 		}
 
 		/* Clear interrupt FIFO register 1 */
-		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
+		pcie_write(pcie, XILINX_PCIE_RPIFR1_ALL_MASK,
 			   XILINX_PCIE_REG_RPIFR1);
 
 		generic_handle_domain_irq(domain, val);
@@ -442,20 +442,20 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 error:
 	/* Clear the Interrupt Decode register */
-	pcie_write(port, status, XILINX_PCIE_REG_IDR);
+	pcie_write(pcie, status, XILINX_PCIE_REG_IDR);
 
 	return IRQ_HANDLED;
 }
 
 /**
  * xilinx_pcie_init_irq_domain - Initialize IRQ domain
- * @port: PCIe port information
+ * @pcie: PCIe port information
  *
  * Return: '0' on success and error value on failure
  */
-static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
+static int xilinx_pcie_init_irq_domain(struct xilinx_pcie *pcie)
 {
-	struct device *dev = port->dev;
+	struct device *dev = pcie->dev;
 	struct device_node *pcie_intc_node;
 	int ret;
 
@@ -466,25 +466,25 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 		return -ENODEV;
 	}
 
-	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+	pcie->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
 						 &intx_domain_ops,
-						 port);
+						 pcie);
 	of_node_put(pcie_intc_node);
-	if (!port->leg_domain) {
+	if (!pcie->leg_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENODEV;
 	}
 
 	/* Setup MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		phys_addr_t pa = ALIGN_DOWN(virt_to_phys(port), SZ_4K);
+		phys_addr_t pa = ALIGN_DOWN(virt_to_phys(pcie), SZ_4K);
 
-		ret = xilinx_allocate_msi_domains(port);
+		ret = xilinx_allocate_msi_domains(pcie);
 		if (ret)
 			return ret;
 
-		pcie_write(port, upper_32_bits(pa), XILINX_PCIE_REG_MSIBASE1);
-		pcie_write(port, lower_32_bits(pa), XILINX_PCIE_REG_MSIBASE2);
+		pcie_write(pcie, upper_32_bits(pa), XILINX_PCIE_REG_MSIBASE1);
+		pcie_write(pcie, lower_32_bits(pa), XILINX_PCIE_REG_MSIBASE2);
 	}
 
 	return 0;
@@ -492,44 +492,44 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 
 /**
  * xilinx_pcie_init_port - Initialize hardware
- * @port: PCIe port information
+ * @pcie: PCIe port information
  */
-static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
+static void xilinx_pcie_init_port(struct xilinx_pcie *pcie)
 {
-	struct device *dev = port->dev;
+	struct device *dev = pcie->dev;
 
-	if (xilinx_pcie_link_up(port))
+	if (xilinx_pcie_link_up(pcie))
 		dev_info(dev, "PCIe Link is UP\n");
 	else
 		dev_info(dev, "PCIe Link is DOWN\n");
 
 	/* Disable all interrupts */
-	pcie_write(port, ~XILINX_PCIE_IDR_ALL_MASK,
+	pcie_write(pcie, ~XILINX_PCIE_IDR_ALL_MASK,
 		   XILINX_PCIE_REG_IMR);
 
 	/* Clear pending interrupts */
-	pcie_write(port, pcie_read(port, XILINX_PCIE_REG_IDR) &
+	pcie_write(pcie, pcie_read(pcie, XILINX_PCIE_REG_IDR) &
 			 XILINX_PCIE_IMR_ALL_MASK,
 		   XILINX_PCIE_REG_IDR);
 
 	/* Enable all interrupts we handle */
-	pcie_write(port, XILINX_PCIE_IMR_ENABLE_MASK, XILINX_PCIE_REG_IMR);
+	pcie_write(pcie, XILINX_PCIE_IMR_ENABLE_MASK, XILINX_PCIE_REG_IMR);
 
 	/* Enable the Bridge enable bit */
-	pcie_write(port, pcie_read(port, XILINX_PCIE_REG_RPSC) |
+	pcie_write(pcie, pcie_read(pcie, XILINX_PCIE_REG_RPSC) |
 			 XILINX_PCIE_REG_RPSC_BEN,
 		   XILINX_PCIE_REG_RPSC);
 }
 
 /**
  * xilinx_pcie_parse_dt - Parse Device tree
- * @port: PCIe port information
+ * @pcie: PCIe port information
  *
  * Return: '0' on success and error value on failure
  */
-static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
+static int xilinx_pcie_parse_dt(struct xilinx_pcie *pcie)
 {
-	struct device *dev = port->dev;
+	struct device *dev = pcie->dev;
 	struct device_node *node = dev->of_node;
 	struct resource regs;
 	unsigned int irq;
@@ -541,14 +541,14 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
 		return err;
 	}
 
-	port->reg_base = devm_pci_remap_cfg_resource(dev, &regs);
-	if (IS_ERR(port->reg_base))
-		return PTR_ERR(port->reg_base);
+	pcie->reg_base = devm_pci_remap_cfg_resource(dev, &regs);
+	if (IS_ERR(pcie->reg_base))
+		return PTR_ERR(pcie->reg_base);
 
 	irq = irq_of_parse_and_map(node, 0);
 	err = devm_request_irq(dev, irq, xilinx_pcie_intr_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD,
-			       "xilinx-pcie", port);
+			       "xilinx-pcie", pcie);
 	if (err) {
 		dev_err(dev, "unable to request irq %d\n", irq);
 		return err;
@@ -566,41 +566,41 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
 static int xilinx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct xilinx_pcie_port *port;
+	struct xilinx_pcie *pcie;
 	struct pci_host_bridge *bridge;
 	int err;
 
 	if (!dev->of_node)
 		return -ENODEV;
 
-	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENODEV;
 
-	port = pci_host_bridge_priv(bridge);
-	mutex_init(&port->map_lock);
-	port->dev = dev;
+	pcie = pci_host_bridge_priv(bridge);
+	mutex_init(&pcie->map_lock);
+	pcie->dev = dev;
 
-	err = xilinx_pcie_parse_dt(port);
+	err = xilinx_pcie_parse_dt(pcie);
 	if (err) {
 		dev_err(dev, "Parsing DT failed\n");
 		return err;
 	}
 
-	xilinx_pcie_init_port(port);
+	xilinx_pcie_init_port(pcie);
 
-	err = xilinx_pcie_init_irq_domain(port);
+	err = xilinx_pcie_init_irq_domain(pcie);
 	if (err) {
 		dev_err(dev, "Failed creating IRQ Domain\n");
 		return err;
 	}
 
-	bridge->sysdata = port;
+	bridge->sysdata = pcie;
 	bridge->ops = &xilinx_pcie_ops;
 
 	err = pci_host_probe(bridge);
 	if (err)
-		xilinx_free_msi_domains(port);
+		xilinx_free_msi_domains(pcie);
 
 	return err;
 }
-- 
2.25.1

