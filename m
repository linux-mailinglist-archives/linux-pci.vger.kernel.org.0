Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB5E458D1D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 12:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhKVLQx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 06:16:53 -0500
Received: from marcansoft.com ([212.63.210.85]:41400 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236311AbhKVLQx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 06:16:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id CCA6841E57;
        Mon, 22 Nov 2021 11:13:41 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [PATCH] PCI: apple: Configure link speeds properly
Date:   Mon, 22 Nov 2021 20:13:32 +0900
Message-Id: <20211122111332.72264-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This sets the maximum link speed from the devicetree, and also requests
a link speed change from the controller. Without the request, the link
always comes up at Gen1 initially, and the core PCIe code complains
about a bandwidth bottleneck.

It turns out ASPM ends up retraining at a higher speed anyway even
without this code, but let's not rely on that.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/pci/controller/pcie-apple.c | 53 +++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 03bfe977c579..073cbac49d8b 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -30,6 +30,10 @@
 #include <linux/of_irq.h>
 #include <linux/pci-ecam.h>
 
+#include "../pci.h"
+/* Apple PCIe is based on DesignWare IP and shares some registers */
+#include "dwc/pcie-designware.h"
+
 #define CORE_RC_PHYIF_CTL		0x00024
 #define   CORE_RC_PHYIF_CTL_RUN		BIT(0)
 #define CORE_RC_PHYIF_STAT		0x00028
@@ -130,9 +134,13 @@
  */
 #define DOORBELL_ADDR		CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR
 
+/* The offset of the PCIe capabilities structure in bridge config space */
+#define PCIE_CAP_BASE		0x70
+
 struct apple_pcie {
 	struct mutex		lock;
 	struct device		*dev;
+	struct pci_config_window *cfg;
 	void __iomem            *base;
 	struct irq_domain	*domain;
 	unsigned long		*bitmap;
@@ -506,6 +514,48 @@ static u32 apple_pcie_rid2sid_write(struct apple_pcie_port *port,
 	return readl_relaxed(port->base + PORT_RID2SID(idx));
 }
 
+static inline void __iomem *bridge_reg(struct apple_pcie_port *port,
+						  int where)
+{
+	struct pci_config_window *cfg = port->pcie->cfg;
+
+	return cfg->win + PCIE_ECAM_OFFSET(0, PCI_DEVFN(port->idx, 0), where);
+}
+
+static void apple_pcie_unlock_dwc_regs(struct apple_pcie_port *port)
+{
+	rmw_set(PCIE_DBI_RO_WR_EN, bridge_reg(port, PCIE_MISC_CONTROL_1_OFF));
+}
+
+static void apple_pcie_lock_dwc_regs(struct apple_pcie_port *port)
+{
+	rmw_clear(PCIE_DBI_RO_WR_EN, bridge_reg(port, PCIE_MISC_CONTROL_1_OFF));
+}
+
+static int apple_pcie_link_configure_max_speed(struct apple_pcie_port *port)
+{
+	int max_gen;
+	u32 ctrl2;
+
+	max_gen = of_pci_get_max_link_speed(port->np);
+	if (max_gen < 0) {
+		dev_err(port->pcie->dev, "max link speed not specified\n");
+		return max_gen;
+	}
+
+	ctrl2 = readw_relaxed(bridge_reg(port, PCIE_CAP_BASE + PCI_EXP_LNKCTL2));
+	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
+	ctrl2 |= FIELD_PREP(PCI_EXP_LNKCTL2_TLS, max_gen);
+	writew_relaxed(ctrl2, bridge_reg(port, PCIE_CAP_BASE + PCI_EXP_LNKCTL2));
+
+	apple_pcie_unlock_dwc_regs(port);
+	rmw_set(PORT_LOGIC_SPEED_CHANGE,
+		bridge_reg(port, PCIE_LINK_WIDTH_SPEED_CONTROL));
+	apple_pcie_lock_dwc_regs(port);
+
+	return 0;
+}
+
 static int apple_pcie_setup_port(struct apple_pcie *pcie,
 				 struct device_node *np)
 {
@@ -577,6 +627,8 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	ret = apple_pcie_port_register_irqs(port);
 	WARN_ON(ret);
 
+	apple_pcie_link_configure_max_speed(port);
+
 	writel_relaxed(PORT_LTSSMCTL_START, port->base + PORT_LTSSMCTL);
 
 	if (!wait_for_completion_timeout(&pcie->event, HZ / 10))
@@ -762,6 +814,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 		return -ENOMEM;
 
 	pcie->dev = dev;
+	pcie->cfg = cfg;
 
 	mutex_init(&pcie->lock);
 
-- 
2.33.0

