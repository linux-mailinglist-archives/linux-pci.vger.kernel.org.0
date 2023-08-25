Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EA17882DC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 11:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244044AbjHYJCV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 05:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242047AbjHYJBm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 05:01:42 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EADA1BFA;
        Fri, 25 Aug 2023 02:01:40 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id C433B81FB;
        Fri, 25 Aug 2023 17:01:38 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Aug
 2023 17:01:38 +0800
Received: from ubuntu.localdomain (113.72.145.205) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Aug
 2023 17:01:37 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v4 06/11] PCI: plda: Add event interrupt codes and IRQ domain ops
Date:   Fri, 25 Aug 2023 17:01:24 +0800
Message-ID: <20230825090129.65721-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825090129.65721-1-minda.chen@starfivetech.com>
References: <20230825090129.65721-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.205]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For PolarFire implements non-PLDA local interrupt events, most of
event interrupt process codes can not be re-used. PLDA implements
new codes and IRQ domain ops like PolarFire.

plda_handle_event() adds a new IRQ num to event num mapping codes for
PLDA local event except DMA engine interrupt events. The DMA engine
interrupt events are implemented by vendors.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/pci/controller/plda/pcie-plda-host.c | 99 ++++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h      |  4 +
 2 files changed, 103 insertions(+)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index ce02cfe6b5fa..bf63f220a518 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -250,6 +250,105 @@ int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 	return 0;
 }
 
+irqreturn_t plda_event_handler(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
+void plda_handle_event(struct irq_desc *desc)
+{
+	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long events = 0;
+	u32 bit, val, origin;
+
+	chained_irq_enter(chip, desc);
+
+	val = readl_relaxed(port->bridge_addr + ISTATUS_LOCAL);
+	origin = val;
+	val = val >> A_ATR_EVT_POST_ERR_SHIFT;
+	events |= val & 0xff;
+	if (origin & PM_MSI_INT_INTX_MASK)
+		events |= BIT(EVENT_PM_MSI_INT_INTX);
+	val = (origin >> PM_MSI_INT_MSI_SHIFT) & 0xf;
+	events |= val << EVENT_PM_MSI_INT_MSI;
+
+	for_each_set_bit(bit, &events, port->num_events)
+		generic_handle_domain_irq(port->event_domain, bit);
+
+	chained_irq_exit(chip, desc);
+}
+
+static u32 plda_hwirq_to_mask(int hwirq)
+{
+	u32 mask;
+
+	if (hwirq < EVENT_PM_MSI_INT_INTX)
+		mask = BIT(hwirq + A_ATR_EVT_POST_ERR_SHIFT);
+	else if (hwirq == EVENT_PM_MSI_INT_INTX)
+		mask = PM_MSI_INT_INTX_MASK;
+	else
+		mask = BIT(hwirq + PM_MSI_TO_MASK_OFFSET);
+
+	return mask;
+}
+
+static void plda_ack_event_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(plda_hwirq_to_mask(data->hwirq),
+		       port->bridge_addr + ISTATUS_LOCAL);
+}
+
+static void plda_mask_event_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	u32 mask, val;
+
+	mask = plda_hwirq_to_mask(data->hwirq);
+
+	raw_spin_lock(&port->lock);
+	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
+	val &= ~mask;
+	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
+	raw_spin_unlock(&port->lock);
+}
+
+static void plda_unmask_event_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	u32 mask, val;
+
+	mask = plda_hwirq_to_mask(data->hwirq);
+
+	raw_spin_lock(&port->lock);
+	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
+	val |= mask;
+	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
+	raw_spin_unlock(&port->lock);
+}
+
+static struct irq_chip plda_event_irq_chip = {
+	.name = "PLDA PCIe EVENT",
+	.irq_ack = plda_ack_event_irq,
+	.irq_mask = plda_mask_event_irq,
+	.irq_unmask = plda_unmask_event_irq,
+};
+
+static int plda_pcie_event_map(struct irq_domain *domain, unsigned int irq,
+			       irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &plda_event_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops plda_evt_dom_ops = {
+	.map = plda_pcie_event_map,
+};
+
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size)
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index a5eb02ec6171..315d9874b899 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -102,6 +102,8 @@
 #define EVENT_PM_MSI_INT_SYS_ERR		12
 #define NUM_PLDA_EVENTS				13
 
+#define PM_MSI_TO_MASK_OFFSET			19
+
 struct plda_msi {
 	struct mutex lock;		/* Protect used bitmap */
 	struct irq_domain *msi_domain;
@@ -118,10 +120,12 @@ struct plda_pcie_rp {
 	raw_spinlock_t lock;
 	struct plda_msi msi;
 	void __iomem *bridge_addr;
+	int num_events;
 };
 
 void plda_handle_msi(struct irq_desc *desc);
 int plda_allocate_msi_domains(struct plda_pcie_rp *port);
+irqreturn_t plda_event_handler(int irq, void *dev_id);
 void plda_handle_intx(struct irq_desc *desc);
 int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 		       irq_hw_number_t hwirq);
-- 
2.17.1

