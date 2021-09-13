Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A29409C2E
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 20:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbhIMS2S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 14:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347266AbhIMS2F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 14:28:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DF95608FB;
        Mon, 13 Sep 2021 18:26:49 +0000 (UTC)
Received: from [198.52.44.129] (helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mPqeg-00AYPD-Ht; Mon, 13 Sep 2021 19:26:10 +0100
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
Subject: [PATCH v3 10/10] PCI: apple: Configure RID to SID mapper on device addition
Date:   Mon, 13 Sep 2021 19:25:50 +0100
Message-Id: <20210913182550.264165-11-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913182550.264165-1-maz@kernel.org>
References: <20210913182550.264165-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 198.52.44.129
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, Robin.Murphy@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Apple PCIe controller doesn't directly feed the endpoint's
Requester ID to the IOMMU (DART), but instead maps RIDs onto
Stream IDs (SIDs). The DART and the PCIe controller must thus
agree on the SIDs that are used for translation (by using
the 'iommu-map' property).

For this purpose, parse the 'iommu-map' property each time a
device gets added, and use the resulting translation to configure
the PCIe RID-to-SID mapper. Similarily, remove the translation
if/when the device gets removed.

This is all driven from a bus notifier which gets registered at
probe time. Hopefully this is the only PCI controller driver
in the whole system.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 158 +++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 76344223245d..68d71eabe708 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -23,8 +23,10 @@
 #include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/msi.h>
+#include <linux/notifier.h>
 #include <linux/of_irq.h>
 #include <linux/pci-ecam.h>
 
@@ -116,6 +118,8 @@
 #define   PORT_TUNSTAT_PERST_ACK_PEND	BIT(1)
 #define PORT_PREFMEM_ENABLE		0x00994
 
+#define MAX_RID2SID			64
+
 /*
  * The doorbell address is set to 0xfffff000, which by convention
  * matches what MacOS does, and it is possible to use any other
@@ -131,6 +135,7 @@ struct apple_pcie {
 	void __iomem            *base;
 	struct irq_domain	*domain;
 	unsigned long		*bitmap;
+	struct list_head	ports;
 	struct completion	event;
 	struct irq_fwspec	fwspec;
 	u32			nvecs;
@@ -141,6 +146,8 @@ struct apple_pcie_port {
 	struct device_node	*np;
 	void __iomem		*base;
 	struct irq_domain	*domain;
+	struct list_head	entry;
+	DECLARE_BITMAP(		sid_map, MAX_RID2SID);
 	int			idx;
 };
 
@@ -488,6 +495,14 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
 	return 0;
 }
 
+static void apple_pcie_rid2sid_write(struct apple_pcie_port *port,
+				     int idx, u32 val)
+{
+	writel_relaxed(val, port->base + PORT_RID2SID(idx));
+	/* Read back to ensure completion of the write */
+	(void)readl_relaxed(port->base + PORT_RID2SID(idx));
+}
+
 static int apple_pcie_setup_port(struct apple_pcie *pcie,
 				 struct device_node *np)
 {
@@ -495,7 +510,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	struct apple_pcie_port *port;
 	struct gpio_desc *reset;
 	u32 stat, idx;
-	int ret;
+	int ret, i;
 
 	reset = gpiod_get_from_of_node(np, "reset-gpios", 0,
 				       GPIOD_OUT_LOW, "#PERST");
@@ -542,6 +557,11 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	if (ret)
 		return ret;
 
+	/* Reset all RID/SID mappings */
+	for (i = 0; i < MAX_RID2SID; i++)
+		apple_pcie_rid2sid_write(port, i, 0);
+
+	list_add_tail(&port->entry, &pcie->ports);
 	init_completion(&pcie->event);
 
 	ret = apple_pcie_port_register_irqs(port);
@@ -604,6 +624,122 @@ static int apple_msi_init(struct apple_pcie *pcie)
 	return 0;
 }
 
+static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *pdev)
+{
+	struct pci_config_window *cfg = pdev->sysdata;
+	struct apple_pcie *pcie = cfg->priv;
+	struct pci_dev *port_pdev = pdev;
+	struct apple_pcie_port *port;
+
+	/* Find the root port this device is on */
+	while (!pci_is_root_bus(port_pdev->bus))
+		port_pdev = pci_upstream_bridge(port_pdev);
+
+	/* If finding the port itself, nothing to do */
+	if (pdev == port_pdev)
+		return NULL;
+
+	list_for_each_entry(port, &pcie->ports, entry) {
+		if (port->idx == PCI_SLOT(port_pdev->devfn))
+			return port;
+	}
+
+	return NULL;
+}
+
+static int apple_pcie_add_device(struct pci_dev *pdev)
+{
+	struct apple_pcie_port *port;
+	int sid_idx, err;
+	u32 rid, sid;
+
+	port = apple_pcie_get_port(pdev);
+	if (!port)
+		return 0;
+
+	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
+		pci_name(pdev->bus->self), port->idx);
+
+	rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	err = of_map_id(port->pcie->dev->of_node, rid, "iommu-map",
+			"iommu-map-mask", NULL, &sid);
+	if (err)
+		return err;
+
+	mutex_lock(&port->pcie->lock);
+	sid_idx = bitmap_find_free_region(port->sid_map, MAX_RID2SID, 0);
+	mutex_unlock(&port->pcie->lock);
+
+	if (sid_idx < 0)
+		return -ENOSPC;
+
+	apple_pcie_rid2sid_write(port, sid_idx,
+				 PORT_RID2SID_VALID |
+				 (sid << PORT_RID2SID_SID_SHIFT) | rid);
+
+	dev_dbg(&pdev->dev, "mapping RID%x to SID%x (index %d)\n",
+		rid, sid, sid_idx);
+	return 0;
+}
+
+static void apple_pcie_release_device(struct pci_dev *pdev)
+{
+	struct apple_pcie_port *port;
+	u32 rid;
+	int idx;
+
+	port = apple_pcie_get_port(pdev);
+	if (!port)
+		return;
+
+	rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+
+	mutex_lock(&port->pcie->lock);
+
+	for_each_set_bit(idx, port->sid_map, MAX_RID2SID) {
+		u32 val;
+
+		val = readl_relaxed(port->base + PORT_RID2SID(idx));
+		if ((val & 0xffff) == rid) {
+			apple_pcie_rid2sid_write(port, idx, 0);
+			bitmap_release_region(port->sid_map, idx, 0);
+			dev_dbg(&pdev->dev, "Released %x (%d)\n", val, idx);
+			break;
+		}
+	}
+
+	mutex_unlock(&port->pcie->lock);
+}
+
+static int apple_pcie_bus_notifier(struct notifier_block *nb,
+				   unsigned long action,
+				   void *data)
+{
+	struct device *dev = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	/*
+	 * This is a bit ugly. We assume that if we get notified for
+	 * any PCI device, we must be in charge for it, and that there
+	 * is no other PCI controller in the whole system. It probably
+	 * holds for now, but for how long?
+	 */
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		apple_pcie_add_device(pdev);
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		apple_pcie_release_device(pdev);
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block apple_pcie_nb = {
+	.notifier_call = apple_pcie_bus_notifier,
+};
+
 static int apple_pcie_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -625,6 +761,9 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	if (IS_ERR(pcie->base))
 		return -ENODEV;
 
+	cfg->priv = pcie;
+	INIT_LIST_HEAD(&pcie->ports);
+
 	for_each_child_of_node(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
@@ -636,6 +775,21 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	return apple_msi_init(pcie);
 }
 
+static int apple_pcie_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = bus_register_notifier(&pci_bus_type, &apple_pcie_nb);
+	if (ret)
+		return ret;
+
+	ret = pci_host_common_probe(pdev);
+	if (ret)
+		bus_unregister_notifier(&pci_bus_type, &apple_pcie_nb);
+
+	return ret;
+}
+
 static const struct pci_ecam_ops apple_pcie_cfg_ecam_ops = {
 	.init		= apple_pcie_init,
 	.pci_ops	= {
@@ -652,7 +806,7 @@ static const struct of_device_id apple_pcie_of_match[] = {
 MODULE_DEVICE_TABLE(of, apple_pcie_of_match);
 
 static struct platform_driver apple_pcie_driver = {
-	.probe	= pci_host_common_probe,
+	.probe	= apple_pcie_probe,
 	.driver	= {
 		.name			= "pcie-apple",
 		.of_match_table		= apple_pcie_of_match,
-- 
2.30.2

