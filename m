Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED3F7E5A08
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 16:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjKHPbi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 10:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjKHPbi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 10:31:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25741BE6;
        Wed,  8 Nov 2023 07:31:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EB6C433C8;
        Wed,  8 Nov 2023 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699457495;
        bh=r+LQL3WkM7KPM9fb4q4P1CaxPmhRBEVJJOiD0rMInZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ESrLPyde+OSfrDE4VLOq4VYxCl9CrkzVGEyoibZQIPMEwlaOwKpJGI4p3UitALOOU
         LAJ++LBzcjSw4oFBzgtorWrJLBDPkeXi+GVkcepaYBqZD2Ec7inVg7zo/iQ6n4VWsk
         Vb7p84ZN5JWzcY4ceTJc9bgx1EMSh2aJhtCB3rg9kgitBgKzvhfeJ7ch0pOxseNOue
         W1q3FKtfHOJ/nR7koERdROB5IQfkUbLBmaxj5nTpkkw/2KauJwPa18JpT3eAdN2ICE
         U0i6/i+0FQaJJ8ZpLBcxF32zIbLV9wTF1+vSv3snh1NaQYjUW/8zteiyEs4MyYudAk
         MGnRX2M9R8hCw==
Date:   Wed, 8 Nov 2023 09:31:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, michal.simek@amd.com,
        krzysztof.kozlowski+dt@linaro.org, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v6 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Message-ID: <20231108153133.GA393726@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818093507.24435-4-thippeswamy.havalige@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 03:05:07PM +0530, Thippeswamy Havalige wrote:
> Add support for Xilinx XDMA Soft IP core as Root Port.
> 
> The Zynq UltraScale+ MPSoCs devices support XDMA soft IP module in
> programmable logic.
> 
> The integrated XDMA soft IP block has integrated bridge function that
> can act as PCIe Root Port.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
> changes in v6:
> - Replaced chained irq's with regular interrupts.
> - Modified interrupt names.
> - Aligned to 80 columns
> changes in v5:
> - Added detailed comments for link_up check.
> - Modified upper case hex values to lower case. 
> ...

I really appreciate the chained IRQ to regular IRQ conversion here,
and I'm just pulling out the diff between v5 and v6 here because it's
a good example that may be useful to anybody who has the opportunity
to do similar conversions for other drivers.

These are the v5 and v6 xilinx-xdma patches:

  v5 https://lore.kernel.org/r/20230628092812.1592644-4-thippeswamy.havalige@amd.com
  v6 https://lore.kernel.org/r/20230818093507.24435-4-thippeswamy.havalige@amd.com

And here's the diff between them:

diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index 938c6934839c..c9673e905f4b 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -8,7 +8,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
-#include <linux/irqchip/chained_irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -96,9 +95,8 @@ struct xilinx_msi {
  * @pldma_domain: PL DMA IRQ domain pointer
  * @resources: Bus Resources
  * @msi: MSI information
- * @irq_misc: Legacy and error interrupt number
- * @intx_irq: legacy interrupt number
- * @lock: lock protecting shared register access
+ * @intx_irq: INTx error interrupt number
+ * @lock: Lock protecting shared register access
  */
 struct pl_dma_pcie {
 	struct device			*dev;
@@ -110,7 +108,6 @@ struct pl_dma_pcie {
 	struct irq_domain		*pldma_domain;
 	struct list_head		resources;
 	struct xilinx_msi		msi;
-	int				irq_misc;
 	int				intx_irq;
 	raw_spinlock_t			lock;
 };
@@ -143,19 +140,23 @@ static void xilinx_pl_dma_pcie_clear_err_interrupts(struct pl_dma_pcie *port)
 	}
 }
 
-static bool xilinx_pl_dma_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
+static bool xilinx_pl_dma_pcie_valid_device(struct pci_bus *bus,
+					    unsigned int devfn)
 {
 	struct pl_dma_pcie *port = bus->sysdata;
 
 	/* Check if link is up when trying to access downstream ports */
 	if (!pci_is_root_bus(bus)) {
 		/*
-		 * If the link goes down after we check for link-up, we have a problem:
-		 * if a PIO request is initiated while link-down, the whole controller
-		 * hangs, and even after link comes up again, previous PIO requests
-		 * won't work, and a reset of the whole PCIe controller is needed.
-		 * Henceforth we need link-up check here to avoid sending PIO request
-		 * when link is down.
+		 * Checking whether link is up here is a last line of defence,
+		 * if the link goes down after we check for link-up, we have a
+		 * problem: if a PIO request is initiated while link-down, the
+		 * whole controller hangs, and even after link comes up again,
+		 * previous PIO requests won't work, and a reset of the whole
+		 * PCIe controller is needed. Henceforth we need link-up check
+		 * here to avoid sending PIO request when link is down. This
+		 * check is racy by definition and does not make controller hang
+		 * if the link goes down after this check is performed.
 		 */
 		if (!xilinx_pl_dma_pcie_link_up(port))
 			return false;
@@ -178,7 +179,7 @@ static void __iomem *xilinx_pl_dma_pcie_map_bus(struct pci_bus *bus,
 }
 
 /* PCIe operations */
-static const struct pci_ecam_ops xilinx_pl_dma_pcie_ops = {
+static struct pci_ecam_ops xilinx_pl_dma_pcie_ops = {
 	.pci_ops = {
 		.map_bus = xilinx_pl_dma_pcie_map_bus,
 		.read	= pci_generic_config_read,
@@ -221,13 +222,13 @@ static void xilinx_unmask_intx_irq(struct irq_data *data)
 }
 
 static struct irq_chip xilinx_leg_irq_chip = {
-	.name		= "INTx",
+	.name		= "pl_dma:INTx",
 	.irq_mask	= xilinx_mask_intx_irq,
 	.irq_unmask	= xilinx_unmask_intx_irq,
 };
 
-static int xilinx_pl_dma_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-				       irq_hw_number_t hwirq)
+static int xilinx_pl_dma_pcie_intx_map(struct irq_domain *domain,
+				       unsigned int irq, irq_hw_number_t hwirq)
 {
 	irq_set_chip_and_handler(irq, &xilinx_leg_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
@@ -241,55 +242,54 @@ static const struct irq_domain_ops intx_domain_ops = {
 	.map = xilinx_pl_dma_pcie_intx_map,
 };
 
-static void xilinx_pl_dma_pcie_handle_msi_irq(struct pl_dma_pcie *port,
-					      u32 status_reg)
+static irqreturn_t xilinx_pl_dma_pcie_msi_handler_high(int irq, void *args)
 {
 	struct xilinx_msi *msi;
 	unsigned long status;
 	u32 bit, virq;
+	struct pl_dma_pcie *port = args;
+
+	msi = &port->msi;
+
+	while ((status = pcie_read(port, XILINX_PCIE_DMA_REG_MSI_HI)) != 0) {
+		for_each_set_bit(bit, &status, 32) {
+			pcie_write(port, 1 << bit, XILINX_PCIE_DMA_REG_MSI_HI);
+			bit = bit + 32;
+			virq = irq_find_mapping(msi->dev_domain, bit);
+			if (virq)
+				generic_handle_irq(virq);
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t xilinx_pl_dma_pcie_msi_handler_low(int irq, void *args)
+{
+	struct pl_dma_pcie *port = args;
+	struct xilinx_msi *msi;
+	unsigned long status;
+	u32 bit, virq;
 
 	msi = &port->msi;
 
-	while ((status = pcie_read(port, status_reg)) != 0) {
+	while ((status = pcie_read(port, XILINX_PCIE_DMA_REG_MSI_LOW)) != 0) {
 		for_each_set_bit(bit, &status, 32) {
-			pcie_write(port, 1 << bit, status_reg);
-			if (status_reg == XILINX_PCIE_DMA_REG_MSI_HI)
-				bit = bit + 32;
+			pcie_write(port, 1 << bit, XILINX_PCIE_DMA_REG_MSI_LOW);
 			virq = irq_find_mapping(msi->dev_domain, bit);
 			if (virq)
 				generic_handle_irq(virq);
 		}
 	}
+
+	return IRQ_HANDLED;
 }
 
-static void xilinx_pl_dma_pcie_msi_handler_high(struct irq_desc *desc)
+static irqreturn_t xilinx_pl_dma_pcie_event_flow(int irq, void *args)
 {
-	struct pl_dma_pcie *port = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	chained_irq_enter(chip, desc);
-	xilinx_pl_dma_pcie_handle_msi_irq(port, XILINX_PCIE_DMA_REG_MSI_HI);
-	chained_irq_exit(chip, desc);
-}
-
-static void xilinx_pl_dma_pcie_msi_handler_low(struct irq_desc *desc)
-{
-	struct pl_dma_pcie *port = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	chained_irq_enter(chip, desc);
-	xilinx_pl_dma_pcie_handle_msi_irq(port, XILINX_PCIE_DMA_REG_MSI_LOW);
-	chained_irq_exit(chip, desc);
-}
-
-static void xilinx_pl_dma_pcie_event_flow(struct irq_desc *desc)
-{
-	struct pl_dma_pcie *port = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct pl_dma_pcie *port = args;
 	unsigned long val;
 	int i;
 
-	chained_irq_enter(chip, desc);
 	val = pcie_read(port, XILINX_PCIE_DMA_REG_IDR);
 	val &= pcie_read(port, XILINX_PCIE_DMA_REG_IMR);
 	for_each_set_bit(i, &val, 32)
@@ -297,7 +297,7 @@ static void xilinx_pl_dma_pcie_event_flow(struct irq_desc *desc)
 
 	pcie_write(port, val, XILINX_PCIE_DMA_REG_IDR);
 
-	chained_irq_exit(chip, desc);
+	return IRQ_HANDLED;
 }
 
 #define _IC(x, s)                              \
@@ -313,8 +313,6 @@ static const struct {
 	_IC(CORRECTABLE,	"Correctable error message"),
 	_IC(NONFATAL,		"Non fatal error message"),
 	_IC(FATAL,		"Fatal error message"),
-	_IC(INTX,		"INTX error message"),
-	_IC(MSI,		"MSI message received"),
 	_IC(SLV_UNSUPP,		"Slave unsupported request"),
 	_IC(SLV_UNEXP,		"Slave unexpected completion"),
 	_IC(SLV_COMPL,		"Slave completion timeout"),
@@ -350,7 +348,7 @@ static irqreturn_t xilinx_pl_dma_pcie_intr_handler(int irq, void *dev_id)
 }
 
 static struct irq_chip xilinx_msi_irq_chip = {
-	.name = "pl_dma_pciepcie:msi",
+	.name = "pl_dma:PCIe MSI",
 	.irq_enable = pci_msi_unmask_irq,
 	.irq_disable = pci_msi_mask_irq,
 	.irq_mask = pci_msi_mask_irq,
@@ -380,7 +378,7 @@ static int xilinx_msi_set_affinity(struct irq_data *irq_data,
 }
 
 static struct irq_chip xilinx_irq_chip = {
-	.name = "Xilinx MSI",
+	.name = "pl_dma:MSI",
 	.irq_compose_msi_msg = xilinx_compose_msi_msg,
 	.irq_set_affinity = xilinx_msi_set_affinity,
 };
@@ -427,12 +425,6 @@ static const struct irq_domain_ops dev_msi_domain_ops = {
 	.free	= xilinx_irq_domain_free,
 };
 
-static void xilinx_pl_dma_pcie_free_interrupts(struct pl_dma_pcie *port)
-{
-	irq_set_chained_handler_and_data(port->msi.irq_msi0, NULL, NULL);
-	irq_set_chained_handler_and_data(port->msi.irq_msi1, NULL, NULL);
-}
-
 static void xilinx_pl_dma_pcie_free_irq_domains(struct pl_dma_pcie *port)
 {
 	struct xilinx_msi *msi = &port->msi;
@@ -487,22 +479,23 @@ static int xilinx_pl_dma_pcie_init_msi_irq_domain(struct pl_dma_pcie *port)
 	return -ENOMEM;
 }
 
-static void xilinx_pl_dma_pcie_intx_flow(struct irq_desc *desc)
+/* INTx error interrupts are Xilinx controller specific interrupt, used to
+ * notify user about error's such as cfg timeout, slave unsupported requests,
+ * fatal and non fatal error etc.
+ */
+
+static irqreturn_t xilinx_pl_dma_pcie_intx_flow(int irq, void *args)
 {
-	struct pl_dma_pcie *port = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long val;
 	int i;
-
-	chained_irq_enter(chip, desc);
+	struct pl_dma_pcie *port = args;
 
 	val = FIELD_GET(XILINX_PCIE_DMA_IDRN_MASK,
 			pcie_read(port, XILINX_PCIE_DMA_REG_IDRN));
 
 	for_each_set_bit(i, &val, PCI_NUM_INTX)
 		generic_handle_domain_irq(port->intx_domain, i);
-
-	chained_irq_exit(chip, desc);
+	return IRQ_HANDLED;
 }
 
 static void xilinx_pl_dma_pcie_mask_event_irq(struct irq_data *d)
@@ -530,7 +523,7 @@ static void xilinx_pl_dma_pcie_unmask_event_irq(struct irq_data *d)
 }
 
 static struct irq_chip xilinx_pl_dma_pcie_event_irq_chip = {
-	.name		= "RC-Event",
+	.name		= "pl_dma:RC-Event",
 	.irq_mask	= xilinx_pl_dma_pcie_mask_event_irq,
 	.irq_unmask	= xilinx_pl_dma_pcie_unmask_event_irq,
 };
@@ -602,7 +595,7 @@ static int xilinx_pl_dma_pcie_setup_irq(struct pl_dma_pcie *port)
 {
 	struct device *dev = port->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	int i, irq;
+	int i, irq, err;
 
 	port->irq = platform_get_irq(pdev, 0);
 	if (port->irq < 0)
@@ -621,7 +614,7 @@ static int xilinx_pl_dma_pcie_setup_irq(struct pl_dma_pcie *port)
 		}
 
 		err = devm_request_irq(dev, irq, xilinx_pl_dma_pcie_intr_handler,
-				       0, intr_cause[i].sym, port);
+				       IRQF_SHARED | IRQF_NO_THREAD, intr_cause[i].sym, port);
 		if (err) {
 			dev_err(dev, "Failed to request IRQ %d\n", irq);
 			return err;
@@ -635,14 +628,18 @@ static int xilinx_pl_dma_pcie_setup_irq(struct pl_dma_pcie *port)
 		return -ENXIO;
 	}
 
-	/* Plug the INTx chained handler */
-	irq_set_chained_handler_and_data(port->intx_irq,
-					 xilinx_pl_dma_pcie_intx_flow, port);
-
-	/* Plug the main event chained handler */
-	irq_set_chained_handler_and_data(port->irq,
-					 xilinx_pl_dma_pcie_event_flow, port);
-
+	err = devm_request_irq(dev, port->intx_irq, xilinx_pl_dma_pcie_intx_flow,
+			       IRQF_SHARED | IRQF_NO_THREAD, NULL, port);
+	if (err) {
+		dev_err(dev, "Failed to request INTx IRQ %d\n", irq);
+		return err;
+	}
+	err = devm_request_irq(dev, port->irq, xilinx_pl_dma_pcie_event_flow,
+			       IRQF_SHARED | IRQF_NO_THREAD, NULL, port);
+	if (err) {
+		dev_err(dev, "Failed to request event IRQ %d\n", irq);
+		return err;
+	}
 	return 0;
 }
 
@@ -666,7 +663,7 @@ static void xilinx_pl_dma_pcie_init_port(struct pl_dma_pcie *port)
 	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK, XILINX_PCIE_DMA_REG_MSI_LOW_MASK);
 	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK, XILINX_PCIE_DMA_REG_MSI_HI_MASK);
 
-	/*set the Bridge enable bit */
+	/* Set the Bridge enable bit */
 	pcie_write(port, pcie_read(port, XILINX_PCIE_DMA_REG_RPSC) |
 			 XILINX_PCIE_DMA_REG_RPSC_BEN,
 		   XILINX_PCIE_DMA_REG_RPSC);
@@ -676,29 +673,32 @@ static int xilinx_request_msi_irq(struct pl_dma_pcie *port)
 {
 	struct device *dev = port->dev;
 	struct platform_device *pdev = to_platform_device(dev);
+	int ret;
 
 	port->msi.irq_msi0 = platform_get_irq_byname(pdev, "msi0");
 	if (port->msi.irq_msi0 <= 0) {
 		dev_err(dev, "Unable to find msi0 IRQ line\n");
 		return port->msi.irq_msi0;
 	}
-
-	irq_set_chained_handler_and_data(port->msi.irq_msi0,
-					 xilinx_pl_dma_pcie_msi_handler_low,
-					 port);
-
+	ret = devm_request_irq(dev, port->msi.irq_msi0, xilinx_pl_dma_pcie_msi_handler_low,
+			       IRQF_SHARED | IRQF_NO_THREAD, "xlnx-pcie-dma-pl",
+			       port);
+	if (ret) {
+		dev_err(dev, "Failed to register interrupt\n");
+		return ret;
+		}
 	port->msi.irq_msi1 = platform_get_irq_byname(pdev, "msi1");
 	if (port->msi.irq_msi1 <= 0) {
-		irq_set_chained_handler_and_data(port->msi.irq_msi0,
-						 NULL, NULL);
 		dev_err(dev, "Unable to find msi1 IRQ line\n");
 		return port->msi.irq_msi1;
 	}
-
-	irq_set_chained_handler_and_data(port->msi.irq_msi1,
-					 xilinx_pl_dma_pcie_msi_handler_high,
-					 port);
-
+	ret = devm_request_irq(dev, port->msi.irq_msi1, xilinx_pl_dma_pcie_msi_handler_high,
+			       IRQF_SHARED | IRQF_NO_THREAD, "xlnx-pcie-dma-pl",
+			       port);
+	if (ret) {
+		dev_err(dev, "Failed to register interrupt\n");
+		return ret;
+		}
 	return 0;
 }
 
@@ -712,7 +712,7 @@ static int xilinx_pl_dma_pcie_parse_dt(struct pl_dma_pcie *port,
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-		dev_err(dev, "missing \"reg\" property\n");
+		dev_err(dev, "Missing \"reg\" property\n");
 		return -ENXIO;
 	}
 	port->phys_reg_base = res->start;
@@ -767,7 +767,7 @@ static int xilinx_pl_dma_pcie_probe(struct platform_device *pdev)
 	err = xilinx_pl_dma_pcie_setup_irq(port);
 
 	bridge->sysdata = port;
-	bridge->ops = (struct pci_ops *)&xilinx_pl_dma_pcie_ops.pci_ops;
+	bridge->ops = &xilinx_pl_dma_pcie_ops.pci_ops;
 
 	err = pci_host_probe(bridge);
 	if (err < 0)
@@ -780,7 +780,6 @@ static int xilinx_pl_dma_pcie_probe(struct platform_device *pdev)
 
 err_irq_domain:
 	pci_ecam_free(port->cfg);
-	xilinx_pl_dma_pcie_free_interrupts(port);
 	return err;
 }
 
