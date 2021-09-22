Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF7E415231
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 22:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhIVU60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 16:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237904AbhIVU6U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Sep 2021 16:58:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA08C608FB;
        Wed, 22 Sep 2021 20:56:49 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mT9Gz-00CP8z-OS; Wed, 22 Sep 2021 21:55:21 +0100
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
Subject: [PATCH v4 10/10] PCI: apple: Configure RID to SID mapper on device addition
Date:   Wed, 22 Sep 2021 21:54:58 +0100
Message-Id: <20210922205458.358517-11-maz@kernel.org>
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

Reviewed-by: Sven Peter <sven@svenpeter.dev>
Tested-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 165 +++++++++++++++++++++++++++-
 1 file changed, 163 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index abe94168a36d..3ce3594da548 100644
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
@@ -141,6 +146,9 @@ struct apple_pcie_port {
 	struct device_node	*np;
 	void __iomem		*base;
 	struct irq_domain	*domain;
+	struct list_head	entry;
+	DECLARE_BITMAP(		sid_map, MAX_RID2SID);
+	int			sid_map_sz;
 	int			idx;
 };
 
@@ -489,6 +497,14 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
 	return 0;
 }
 
+static u32 apple_pcie_rid2sid_write(struct apple_pcie_port *port,
+				    int idx, u32 val)
+{
+	writel_relaxed(val, port->base + PORT_RID2SID(idx));
+	/* Read back to ensure completion of the write */
+	return readl_relaxed(port->base + PORT_RID2SID(idx));
+}
+
 static int apple_pcie_setup_port(struct apple_pcie *pcie,
 				 struct device_node *np)
 {
@@ -496,7 +512,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	struct apple_pcie_port *port;
 	struct gpio_desc *reset;
 	u32 stat, idx;
-	int ret;
+	int ret, i;
 
 	reset = gpiod_get_from_of_node(np, "reset-gpios", 0,
 				       GPIOD_OUT_LOW, "#PERST");
@@ -543,6 +559,18 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	if (ret)
 		return ret;
 
+	/* Reset all RID/SID mappings, and check for RAZ/WI registers */
+	for (i = 0; i < MAX_RID2SID; i++) {
+		if (apple_pcie_rid2sid_write(port, i, 0xbad1d) != 0xbad1d)
+			break;
+		apple_pcie_rid2sid_write(port, i, 0);
+	}
+
+	dev_dbg(pcie->dev, "%pOF: %d RID/SID mapping entries\n", np, i);
+
+	port->sid_map_sz = i;
+
+	list_add_tail(&port->entry, &pcie->ports);
 	init_completion(&pcie->event);
 
 	ret = apple_pcie_port_register_irqs(port);
@@ -605,6 +633,121 @@ static int apple_msi_init(struct apple_pcie *pcie)
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
+	port_pdev = pcie_find_root_port(pdev);
+
+	/* If finding the port itself, nothing to do */
+	if (WARN_ON(!port_pdev) || pdev == port_pdev)
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
+static int apple_pcie_add_device(struct apple_pcie_port *port,
+				 struct pci_dev *pdev)
+{
+	u32 sid, rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	int idx, err;
+
+	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
+		pci_name(pdev->bus->self), port->idx);
+
+	err = of_map_id(port->pcie->dev->of_node, rid, "iommu-map",
+			"iommu-map-mask", NULL, &sid);
+	if (err)
+		return err;
+
+	mutex_lock(&port->pcie->lock);
+
+	idx = bitmap_find_free_region(port->sid_map, port->sid_map_sz, 0);
+	if (idx >= 0) {
+		apple_pcie_rid2sid_write(port, idx,
+					 PORT_RID2SID_VALID |
+					 (sid << PORT_RID2SID_SID_SHIFT) | rid);
+
+		dev_dbg(&pdev->dev, "mapping RID%x to SID%x (index %d)\n",
+			rid, sid, idx);
+	}
+
+	mutex_unlock(&port->pcie->lock);
+
+	return idx >= 0 ? 0 : -ENOSPC;
+}
+
+static void apple_pcie_release_device(struct apple_pcie_port *port,
+				      struct pci_dev *pdev)
+{
+	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	int idx;
+
+	mutex_lock(&port->pcie->lock);
+
+	for_each_set_bit(idx, port->sid_map, port->sid_map_sz) {
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
+	struct apple_pcie_port *port;
+	int err;
+
+	/*
+	 * This is a bit ugly. We assume that if we get notified for
+	 * any PCI device, we must be in charge of it, and that there
+	 * is no other PCI controller in the whole system. It probably
+	 * holds for now, but who knows for how long?
+	 */
+	port = apple_pcie_get_port(pdev);
+	if (!port)
+		return NOTIFY_DONE;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		err = apple_pcie_add_device(port, pdev);
+		if (err)
+			return notifier_from_errno(err);
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		apple_pcie_release_device(port, pdev);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block apple_pcie_nb = {
+	.notifier_call = apple_pcie_bus_notifier,
+};
+
 static int apple_pcie_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -626,6 +769,9 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	if (IS_ERR(pcie->base))
 		return -ENODEV;
 
+	cfg->priv = pcie;
+	INIT_LIST_HEAD(&pcie->ports);
+
 	for_each_child_of_node(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
@@ -637,6 +783,21 @@ static int apple_pcie_init(struct pci_config_window *cfg)
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
@@ -653,7 +814,7 @@ static const struct of_device_id apple_pcie_of_match[] = {
 MODULE_DEVICE_TABLE(of, apple_pcie_of_match);
 
 static struct platform_driver apple_pcie_driver = {
-	.probe	= pci_host_common_probe,
+	.probe	= apple_pcie_probe,
 	.driver	= {
 		.name			= "pcie-apple",
 		.of_match_table		= apple_pcie_of_match,
-- 
2.30.2

