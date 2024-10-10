Return-Path: <linux-pci+bounces-14139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3BE997CF7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B942B22B2C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 06:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D431D1A0AEC;
	Thu, 10 Oct 2024 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GtfzXQ8u"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E318BB8E;
	Thu, 10 Oct 2024 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540987; cv=none; b=XN8oOGRhWjCjK7VYaq8jumLnmxawqF/BtQ0VGcFltbLQ4qYzmrMe7ugwiQx7aZ6QHoykHlQ/OcFz7BVhgxe8yQp7IL+QyrtEHASSQON/GOqwR4isBo8VPLgVfJggyN8FFSnbdYCgaaRFITALQKw11Ozh2Eoedd3QQvhG+ObUbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540987; c=relaxed/simple;
	bh=09NsXZJb4Q2DRy8Vnj85lLb/Wq+JhM0CD6UP61GzZEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPTckQVoa1bszl0mtzszjfSfdbfd2HkmFeqTdVZpTQ5Hhk+OW011Ebuzg4PYPyWIv9CVXkPHnFw3joh3Qr6BI4LA3FwaFSzoNFbMxNM2was5uMInHYwKmIrPcdIcpGh9Zxx18p6B7OY/kwJSChw47YsHVQTGUP9sf+QEx44F6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GtfzXQ8u; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DD5D9E0002;
	Thu, 10 Oct 2024 06:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728540982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VE8PV1Xaq1ZMgO/XF6cBMa+Y9p/NzyI5lCHztbLRL3g=;
	b=GtfzXQ8ulL1PF3nyMfB7233snzv/8mFHXfARUgftugPEEJWeo6LZIy2SLU14J53SsRMC4m
	OM3AjpI+5u7VH9qskrC8gLNz3DEtL7blpTH82ccK+8PQcv656iiuqXSoYX9DJW+quo/oSH
	3XxAGAe9knmS+Kx4i45j06Qcl1f9AFzZ4Fu8/3VfkDIWMp5gA9DVjUCiEK3Qj5FRf+5zSR
	LTkvPiZGaYHOENWWxXEwHX7mwGrcnrA1aWBIunLWl0tk/Sx6A+VYcN2wyU3cGsOoHunjkQ
	CxgYQV4/8NoI0WrvaC0lhCI2yl8duGXh5+rpqFpAIdEOscTV3eIXtkMaBESPZg==
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v8 1/6] misc: Add support for LAN966x PCI device
Date: Thu, 10 Oct 2024 08:16:09 +0200
Message-ID: <20241010061615.787073-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010061615.787073-1-herve.codina@bootlin.com>
References: <20241010061615.787073-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Add a PCI driver that handles the LAN966x PCI device using a device-tree
overlay. This overlay is applied to the PCI device DT node and allows to
describe components that are present in the device.

The memory from the device-tree is remapped to the BAR memory thanks to
"ranges" properties computed at runtime by the PCI core during the PCI
enumeration.

The PCI device itself acts as an interrupt controller and is used as the
parent of the internal LAN966x interrupt controller to route the
interrupts to the assigned PCI INTx interrupt.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/Kconfig          |  24 ++++
 drivers/misc/Makefile         |   3 +
 drivers/misc/lan966x_pci.c    | 215 ++++++++++++++++++++++++++++++++++
 drivers/misc/lan966x_pci.dtso | 167 ++++++++++++++++++++++++++
 drivers/pci/quirks.c          |   1 +
 5 files changed, 410 insertions(+)
 create mode 100644 drivers/misc/lan966x_pci.c
 create mode 100644 drivers/misc/lan966x_pci.dtso

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 3fe7e2a9bd29..8e5b06ac9b6f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -610,6 +610,30 @@ config MARVELL_CN10K_DPI
 	  To compile this driver as a module, choose M here: the module
 	  will be called mrvl_cn10k_dpi.
 
+config MCHP_LAN966X_PCI
+	tristate "Microchip LAN966x PCIe Support"
+	depends on PCI
+	select OF
+	select OF_OVERLAY
+	select IRQ_DOMAIN
+	help
+	  This enables the support for the LAN966x PCIe device.
+	  This is used to drive the LAN966x PCIe device from the host system
+	  to which it is connected.
+
+	  This driver uses an overlay to load other drivers to support for
+	  LAN966x internal components.
+	  Even if this driver does not depend on these other drivers, in order
+	  to have a fully functional board, the following drivers are needed:
+	    - fixed-clock (COMMON_CLK)
+	    - lan966x-oic (LAN966X_OIC)
+	    - lan966x-cpu-syscon (MFD_SYSCON)
+	    - lan966x-switch-reset (RESET_MCHP_SPARX5)
+	    - lan966x-pinctrl (PINCTRL_OCELOT)
+	    - lan966x-serdes (PHY_LAN966X_SERDES)
+	    - lan966x-miim (MDIO_MSCC_MIIM)
+	    - lan966x-switch (LAN966X_SWITCH)
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index a9f94525e181..885b22989580 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -71,4 +71,7 @@ obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
 obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
 obj-$(CONFIG_MARVELL_CN10K_DPI)	+= mrvl_cn10k_dpi.o
+lan966x-pci-objs		:= lan966x_pci.o
+lan966x-pci-objs		+= lan966x_pci.dtbo.o
+obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
 obj-y				+= keba/
diff --git a/drivers/misc/lan966x_pci.c b/drivers/misc/lan966x_pci.c
new file mode 100644
index 000000000000..9c79b58137e5
--- /dev/null
+++ b/drivers/misc/lan966x_pci.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip LAN966x PCI driver
+ *
+ * Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries.
+ *
+ * Authors:
+ *	Clément Léger <clement.leger@bootlin.com>
+ *	Hervé Codina <herve.codina@bootlin.com>
+ */
+
+#include <linux/device.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/slab.h>
+
+/* Embedded dtbo symbols created by cmd_wrap_S_dtb in scripts/Makefile.lib */
+extern char __dtbo_lan966x_pci_begin[];
+extern char __dtbo_lan966x_pci_end[];
+
+struct pci_dev_intr_ctrl {
+	struct pci_dev *pci_dev;
+	struct irq_domain *irq_domain;
+	int irq;
+};
+
+static int pci_dev_irq_domain_map(struct irq_domain *d, unsigned int virq, irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops pci_dev_irq_domain_ops = {
+	.map = pci_dev_irq_domain_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static irqreturn_t pci_dev_irq_handler(int irq, void *data)
+{
+	struct pci_dev_intr_ctrl *intr_ctrl = data;
+	int ret;
+
+	ret = generic_handle_domain_irq(intr_ctrl->irq_domain, 0);
+	return ret ? IRQ_NONE : IRQ_HANDLED;
+}
+
+static struct pci_dev_intr_ctrl *pci_dev_create_intr_ctrl(struct pci_dev *pdev)
+{
+	struct pci_dev_intr_ctrl *intr_ctrl __free(kfree) = NULL;
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	fwnode = dev_fwnode(&pdev->dev);
+	if (!fwnode)
+		return ERR_PTR(-ENODEV);
+
+	intr_ctrl = kmalloc(sizeof(*intr_ctrl), GFP_KERNEL);
+	if (!intr_ctrl)
+		return ERR_PTR(-ENOMEM);
+
+	intr_ctrl->pci_dev = pdev;
+
+	intr_ctrl->irq_domain = irq_domain_create_linear(fwnode, 1, &pci_dev_irq_domain_ops,
+							 intr_ctrl);
+	if (!intr_ctrl->irq_domain) {
+		pci_err(pdev, "Failed to create irqdomain\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
+	if (ret < 0) {
+		pci_err(pdev, "Unable alloc irq vector (%d)\n", ret);
+		goto err_remove_domain;
+	}
+	intr_ctrl->irq = pci_irq_vector(pdev, 0);
+	ret = request_irq(intr_ctrl->irq, pci_dev_irq_handler, IRQF_SHARED,
+			  pci_name(pdev), intr_ctrl);
+	if (ret) {
+		pci_err(pdev, "Unable to request irq %d (%d)\n", intr_ctrl->irq, ret);
+		goto err_free_irq_vector;
+	}
+
+	return_ptr(intr_ctrl);
+
+err_free_irq_vector:
+	pci_free_irq_vectors(pdev);
+err_remove_domain:
+	irq_domain_remove(intr_ctrl->irq_domain);
+	return ERR_PTR(ret);
+}
+
+static void pci_dev_remove_intr_ctrl(struct pci_dev_intr_ctrl *intr_ctrl)
+{
+	free_irq(intr_ctrl->irq, intr_ctrl);
+	pci_free_irq_vectors(intr_ctrl->pci_dev);
+	irq_dispose_mapping(irq_find_mapping(intr_ctrl->irq_domain, 0));
+	irq_domain_remove(intr_ctrl->irq_domain);
+	kfree(intr_ctrl);
+}
+
+static void devm_pci_dev_remove_intr_ctrl(void *intr_ctrl)
+{
+	pci_dev_remove_intr_ctrl(intr_ctrl);
+}
+
+static int devm_pci_dev_create_intr_ctrl(struct pci_dev *pdev)
+{
+	struct pci_dev_intr_ctrl *intr_ctrl;
+
+	intr_ctrl = pci_dev_create_intr_ctrl(pdev);
+	if (IS_ERR(intr_ctrl))
+		return PTR_ERR(intr_ctrl);
+
+	return devm_add_action_or_reset(&pdev->dev, devm_pci_dev_remove_intr_ctrl, intr_ctrl);
+}
+
+struct lan966x_pci {
+	struct device *dev;
+	int ovcs_id;
+};
+
+static int lan966x_pci_load_overlay(struct lan966x_pci *data)
+{
+	u32 dtbo_size = __dtbo_lan966x_pci_end - __dtbo_lan966x_pci_begin;
+	void *dtbo_start = __dtbo_lan966x_pci_begin;
+
+	return of_overlay_fdt_apply(dtbo_start, dtbo_size, &data->ovcs_id, dev_of_node(data->dev));
+}
+
+static void lan966x_pci_unload_overlay(struct lan966x_pci *data)
+{
+	of_overlay_remove(&data->ovcs_id);
+}
+
+static int lan966x_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct lan966x_pci *data;
+	int ret;
+
+	/*
+	 * On ACPI system, fwnode can point to the ACPI node.
+	 * This driver needs an of_node to be used as the device-tree overlay
+	 * target. This of_node should be set by the PCI core if it succeeds in
+	 * creating it (CONFIG_PCI_DYNAMIC_OF_NODES feature).
+	 * Check here for the validity of this of_node.
+	 */
+	if (!dev_of_node(dev))
+		return dev_err_probe(dev, -EINVAL, "Missing of_node for device\n");
+
+	/* Need to be done before devm_pci_dev_create_intr_ctrl.
+	 * It allocates an IRQ and so pdev->irq is updated.
+	 */
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	ret = devm_pci_dev_create_intr_ctrl(pdev);
+	if (ret)
+		return ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, data);
+	data->dev = dev;
+
+	ret = lan966x_pci_load_overlay(data);
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	ret = of_platform_default_populate(dev_of_node(dev), NULL, dev);
+	if (ret)
+		goto err_unload_overlay;
+
+	return 0;
+
+err_unload_overlay:
+	lan966x_pci_unload_overlay(data);
+	return ret;
+}
+
+static void lan966x_pci_remove(struct pci_dev *pdev)
+{
+	struct lan966x_pci *data = pci_get_drvdata(pdev);
+
+	of_platform_depopulate(data->dev);
+
+	lan966x_pci_unload_overlay(data);
+}
+
+static struct pci_device_id lan966x_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, 0x9660) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, lan966x_pci_ids);
+
+static struct pci_driver lan966x_pci_driver = {
+	.name = "mchp_lan966x_pci",
+	.id_table = lan966x_pci_ids,
+	.probe = lan966x_pci_probe,
+	.remove = lan966x_pci_remove,
+};
+module_pci_driver(lan966x_pci_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("Microchip LAN966x PCI driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/lan966x_pci.dtso b/drivers/misc/lan966x_pci.dtso
new file mode 100644
index 000000000000..94c271645ad5
--- /dev/null
+++ b/drivers/misc/lan966x_pci.dtso
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Microchip UNG
+ */
+
+#include <dt-bindings/clock/microchip,lan966x.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/mfd/atmel-flexcom.h>
+#include <dt-bindings/phy/phy-lan966x-serdes.h>
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target-path="";
+		__overlay__ {
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			pci-ep-bus@0 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				/*
+				 * map @0xe2000000 (32MB) to BAR0 (CPU)
+				 * map @0xe0000000 (16MB) to BAR1 (AMBA)
+				 */
+				ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
+				          0xe0000000 0x01 0x00 0x00 0x1000000>;
+
+				oic: oic@e00c0120 {
+					compatible = "microchip,lan966x-oic";
+					#interrupt-cells = <2>;
+					interrupt-controller;
+					interrupts = <0>; /* PCI INTx assigned interrupt */
+					reg = <0xe00c0120 0x190>;
+				};
+
+				cpu_clk: cpu_clk {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <600000000>;  // CPU clock = 600MHz
+				};
+
+				ddr_clk: ddr_clk {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <30000000>;  // Fabric clock = 30MHz
+				};
+
+				sys_clk: sys_clk {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <15625000>;  // System clock = 15.625MHz
+				};
+
+				cpu_ctrl: syscon@e00c0000 {
+					compatible = "microchip,lan966x-cpu-syscon", "syscon";
+					reg = <0xe00c0000 0xa8>;
+				};
+
+				reset: reset@e200400c {
+					compatible = "microchip,lan966x-switch-reset";
+					reg = <0xe200400c 0x4>, <0xe00c0000 0xa8>;
+					reg-names = "gcb","cpu";
+					#reset-cells = <1>;
+					cpu-syscon = <&cpu_ctrl>;
+				};
+
+				gpio: pinctrl@e2004064 {
+					compatible = "microchip,lan966x-pinctrl";
+					reg = <0xe2004064 0xb4>,
+					      <0xe2010024 0x138>;
+					resets = <&reset 0>;
+					reset-names = "switch";
+					gpio-controller;
+					#gpio-cells = <2>;
+					gpio-ranges = <&gpio 0 0 78>;
+					interrupt-parent = <&oic>;
+					interrupt-controller;
+					interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+					#interrupt-cells = <2>;
+
+					tod_pins: tod_pins {
+						pins = "GPIO_36";
+						function = "ptpsync_1";
+					};
+
+					fc0_a_pins: fcb4-i2c-pins {
+						/* RXD, TXD */
+						pins = "GPIO_9", "GPIO_10";
+						function = "fc0_a";
+					};
+
+				};
+
+				serdes: serdes@e202c000 {
+					compatible = "microchip,lan966x-serdes";
+					reg = <0xe202c000 0x9c>,
+					      <0xe2004010 0x4>;
+					#phy-cells = <2>;
+				};
+
+				mdio1: mdio@e200413c {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "microchip,lan966x-miim";
+					reg = <0xe200413c 0x24>,
+					      <0xe2010020 0x4>;
+
+					resets = <&reset 0>;
+					reset-names = "switch";
+
+					lan966x_phy0: ethernet-lan966x_phy@1 {
+						reg = <1>;
+					};
+
+					lan966x_phy1: ethernet-lan966x_phy@2 {
+						reg = <2>;
+					};
+				};
+
+				switch: switch@e0000000 {
+					compatible = "microchip,lan966x-switch";
+					reg = <0xe0000000 0x0100000>,
+					      <0xe2000000 0x0800000>;
+					reg-names = "cpu", "gcb";
+
+					interrupt-parent = <&oic>;
+					interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
+						     <9 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "xtr", "ana";
+
+					resets = <&reset 0>;
+					reset-names = "switch";
+
+					pinctrl-names = "default";
+					pinctrl-0 = <&tod_pins>;
+
+					ethernet-ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port0: port@0 {
+							phy-handle = <&lan966x_phy0>;
+
+							reg = <0>;
+							phy-mode = "gmii";
+							phys = <&serdes 0 CU(0)>;
+						};
+
+						port1: port@1 {
+							phy-handle = <&lan966x_phy1>;
+
+							reg = <1>;
+							phy-mode = "gmii";
+							phys = <&serdes 1 CU(1)>;
+						};
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dccb60c1d9cc..41dec625ed7b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6266,6 +6266,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
 
 /*
  * Devices known to require a longer delay before first config space access
-- 
2.46.2


