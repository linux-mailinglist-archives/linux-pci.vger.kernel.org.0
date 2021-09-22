Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274A3415215
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 22:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhIVU5H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 16:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237869AbhIVU45 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Sep 2021 16:56:57 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7090461242;
        Wed, 22 Sep 2021 20:55:21 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mT9Gx-00CP8z-PB; Wed, 22 Sep 2021 21:55:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: [PATCH v4 06/10] PCI: apple: Add INTx and per-port interrupt support
Date:   Wed, 22 Sep 2021 21:54:54 +0100
Message-Id: <20210922205458.358517-7-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922205458.358517-1-maz@kernel.org>
References: <20210922205458.358517-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, Robin.Murphy@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for the per-port interrupt controller that deals
with both INTx signalling and management interrupts.

This allows the Link-up/Link-down interrupts to be wired, allowing
the bring-up to be synchronised (and provide debug information).
The framework can further be used to handle the rest of the per
port events if and when necessary.

Likewise, INTx signalling is implemented so that end-points can
actually be used.

Tested-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 209 ++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 2620fd9d0ab1..38b5e0b7b691 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -21,6 +21,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/iopoll.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -118,12 +119,14 @@
 struct apple_pcie {
 	struct device		*dev;
 	void __iomem            *base;
+	struct completion	event;
 };
 
 struct apple_pcie_port {
 	struct apple_pcie	*pcie;
 	struct device_node	*np;
 	void __iomem		*base;
+	struct irq_domain	*domain;
 	int			idx;
 };
 
@@ -137,6 +140,200 @@ static void rmw_clear(u32 clr, void __iomem *addr)
 	writel_relaxed(readl_relaxed(addr) & ~clr, addr);
 }
 
+static void apple_port_irq_mask(struct irq_data *data)
+{
+	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(BIT(data->hwirq), port->base + PORT_INTMSKSET);
+}
+
+static void apple_port_irq_unmask(struct irq_data *data)
+{
+	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(BIT(data->hwirq), port->base + PORT_INTMSKCLR);
+}
+
+static bool hwirq_is_intx(unsigned int hwirq)
+{
+	return BIT(hwirq) & PORT_INT_INTx_MASK;
+}
+
+static void apple_port_irq_ack(struct irq_data *data)
+{
+	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
+
+	if (!hwirq_is_intx(data->hwirq))
+		writel_relaxed(BIT(data->hwirq), port->base + PORT_INTSTAT);
+}
+
+static int apple_port_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	/*
+	 * It doesn't seem that there is any way to configure the
+	 * trigger, so assume INTx have to be level (as per the spec),
+	 * and the rest is edge (which looks likely).
+	 */
+	if (hwirq_is_intx(data->hwirq) ^ !!(type & IRQ_TYPE_LEVEL_MASK))
+		return -EINVAL;
+
+	irqd_set_trigger_type(data, type);
+	return 0;
+}
+
+static struct irq_chip apple_port_irqchip = {
+	.name		= "PCIe",
+	.irq_ack	= apple_port_irq_ack,
+	.irq_mask	= apple_port_irq_mask,
+	.irq_unmask	= apple_port_irq_unmask,
+	.irq_set_type	= apple_port_irq_set_type,
+};
+
+static int apple_port_irq_domain_alloc(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs,
+				       void *args)
+{
+	struct apple_pcie_port *port = domain->host_data;
+	struct irq_fwspec *fwspec = args;
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_flow_handler_t flow = handle_edge_irq;
+		unsigned int type = IRQ_TYPE_EDGE_RISING;
+
+		if (hwirq_is_intx(fwspec->param[0] + i)) {
+			flow = handle_level_irq;
+			type = IRQ_TYPE_LEVEL_HIGH;
+		}
+
+		irq_domain_set_info(domain, virq + i, fwspec->param[0] + i,
+				    &apple_port_irqchip, port, flow,
+				    NULL, NULL);
+
+		irq_set_irq_type(virq + i, type);
+	}
+
+	return 0;
+}
+
+static void apple_port_irq_domain_free(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);
+		irq_set_handler(virq + i, NULL);
+		irq_domain_reset_irq_data(d);
+	}
+}
+
+static const struct irq_domain_ops apple_port_irq_domain_ops = {
+	.translate	= irq_domain_translate_onecell,
+	.alloc		= apple_port_irq_domain_alloc,
+	.free		= apple_port_irq_domain_free,
+};
+
+static void apple_port_irq_handler(struct irq_desc *desc)
+{
+	struct apple_pcie_port *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long stat;
+	int i;
+
+	chained_irq_enter(chip, desc);
+
+	stat = readl_relaxed(port->base + PORT_INTSTAT);
+
+	for_each_set_bit(i, &stat, 32)
+		generic_handle_domain_irq(port->domain, i);
+
+	chained_irq_exit(chip, desc);
+}
+
+static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
+{
+	struct fwnode_handle *fwnode = &port->np->fwnode;
+	unsigned int irq;
+
+	/* FIXME: consider moving each interrupt under each port */
+	irq = irq_of_parse_and_map(to_of_node(dev_fwnode(port->pcie->dev)),
+				   port->idx);
+	if (!irq)
+		return -ENXIO;
+
+	port->domain = irq_domain_create_linear(fwnode, 32,
+						&apple_port_irq_domain_ops,
+						port);
+	if (!port->domain)
+		return -ENOMEM;
+
+	/* Disable all interrupts */
+	writel_relaxed(~0, port->base + PORT_INTMSKSET);
+	writel_relaxed(~0, port->base + PORT_INTSTAT);
+
+	irq_set_chained_handler_and_data(irq, apple_port_irq_handler, port);
+
+	return 0;
+}
+
+static irqreturn_t apple_pcie_port_irq(int irq, void *data)
+{
+	struct apple_pcie_port *port = data;
+	unsigned int hwirq = irq_domain_get_irq_data(port->domain, irq)->hwirq;
+
+	switch (hwirq) {
+	case PORT_INT_LINK_UP:
+		dev_info_ratelimited(port->pcie->dev, "Link up on %pOF\n",
+				     port->np);
+		complete_all(&port->pcie->event);
+		break;
+	case PORT_INT_LINK_DOWN:
+		dev_info_ratelimited(port->pcie->dev, "Link down on %pOF\n",
+				     port->np);
+		break;
+	default:
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int apple_pcie_port_register_irqs(struct apple_pcie_port *port)
+{
+	static struct {
+		unsigned int	hwirq;
+		const char	*name;
+	} port_irqs[] = {
+		{ PORT_INT_LINK_UP,	"Link up",	},
+		{ PORT_INT_LINK_DOWN,	"Link down",	},
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(port_irqs); i++) {
+		struct irq_fwspec fwspec = {
+			.fwnode		= &port->np->fwnode,
+			.param_count	= 1,
+			.param		= {
+				[0]	= port_irqs[i].hwirq,
+			},
+		};
+		unsigned int irq;
+		int ret;
+
+		irq = irq_domain_alloc_irqs(port->domain, 1, NUMA_NO_NODE,
+					    &fwspec);
+		if (WARN_ON(!irq))
+			continue;
+
+		ret = request_irq(irq, apple_pcie_port_irq, 0,
+				  port_irqs[i].name, port);
+		WARN_ON(ret);
+	}
+
+	return 0;
+}
+
 static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
 				   struct apple_pcie_port *port)
 {
@@ -224,8 +421,20 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	/* Flush writes and enable the link */
 	dma_wmb();
 
+	ret = apple_pcie_port_setup_irq(port);
+	if (ret)
+		return ret;
+
+	init_completion(&pcie->event);
+
+	ret = apple_pcie_port_register_irqs(port);
+	WARN_ON(ret);
+
 	writel_relaxed(PORT_LTSSMCTL_START, port->base + PORT_LTSSMCTL);
 
+	if (!wait_for_completion_timeout(&pcie->event, HZ / 10))
+		dev_warn(pcie->dev, "%pOF link didn't come up\n", np);
+
 	return 0;
 }
 
-- 
2.30.2

