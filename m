Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF4E1F1FD2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 21:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgFHT1g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 15:27:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgFHT1f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jun 2020 15:27:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 37619AE35;
        Mon,  8 Jun 2020 19:27:36 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        robh@kernel.org, mathias.nyman@linux.intel.com,
        Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, tim.gover@raspberrypi.org,
        helgaas@kernel.org, lorenzo.pieralisi@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 2/9] reset: Add Raspberry Pi 4 firmware USB reset controller
Date:   Mon,  8 Jun 2020 21:26:54 +0200
Message-Id: <20200608192701.18355-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608192701.18355-1-nsaenzjulienne@suse.de>
References: <20200608192701.18355-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Raspberry Pi 4 gets its USB functionality from VL805, a PCIe chip
that implements the xHCI. After a PCI fundamental reset, VL805's
firmware may either be loaded directly from an EEPROM or, if not
present, by the SoC's co-processor, VideoCore. RPi4's VideoCore OS
contains both the non public firmware load logic and the VL805 firmware
blob.

We control this trough a reset controller device that's able to trigger
the aforementioned process when relevant.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/reset/Kconfig                 |   9 ++
 drivers/reset/Makefile                |   1 +
 drivers/reset/reset-raspberrypi-usb.c | 122 ++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 drivers/reset/reset-raspberrypi-usb.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index d9efbfd29646..80e07190cd04 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -140,6 +140,15 @@ config RESET_QCOM_PDC
 	  to control reset signals provided by PDC for Modem, Compute,
 	  Display, GPU, Debug, AOP, Sensors, Audio, SP and APPS.
 
+config RESET_RASPBERRYPI_USB
+	tristate "Raspberry Pi 4 USB Reset Driver"
+	depends on RASPBERRYPI_FIRMWARE || (RASPBERRYPI_FIRMWARE=n && COMPILE_TEST)
+	default USB_XHCI_PCI
+	help
+	  This driver provides support for resetting the USB HW available in
+	  the Raspberry Pi 4. This reset process is controlled by firmware
+	  through a custom interface (see drivers/firmware/raspberrypi.c).
+
 config RESET_SCMI
 	tristate "Reset driver controlled via ARM SCMI interface"
 	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 249ed357c997..49cd2868c7ab 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
 obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
+obj-$(CONFIG_RESET_RASPBERRYPI_USB) += reset-raspberrypi-usb.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
diff --git a/drivers/reset/reset-raspberrypi-usb.c b/drivers/reset/reset-raspberrypi-usb.c
new file mode 100644
index 000000000000..e9a6e7018c6d
--- /dev/null
+++ b/drivers/reset/reset-raspberrypi-usb.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Raspberry Pi 4 USB reset driver
+ *
+ * The Raspberry Pi 4 gets its USB functionality from VL805, a PCIe chip that
+ * implements xHCI. After a PCI reset, VL805's firmware may either be loaded
+ * directly from an EEPROM or, if not present, by the SoC's co-processor,
+ * VideoCore. rpi's VideoCore OS contains both the non public firmware load
+ * logic and the VL805 firmware blob. This driver triggers the aforementioned
+ * process.
+ *
+ * Copyright (C) 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+ */
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+struct rpi_usb_reset {
+	struct reset_controller_dev rcdev;
+	struct rpi_firmware *fw;
+};
+
+static inline
+struct rpi_usb_reset *to_rpi_usb(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct rpi_usb_reset, rcdev);
+}
+
+static int rpi_usb_reset_reset(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct rpi_usb_reset *priv = to_rpi_usb(rcdev);
+	u32 dev_addr;
+	int ret;
+
+	/*
+	 * The pci device address is expected like this:
+	 *
+	 * PCI_BUS << 20 | PCI_SLOT << 15 | PCI_FUNC << 12
+	 *
+	 * But since rpi's PCIe setup is hardwired, we know the address in
+	 * advance.
+	 */
+	dev_addr = 0x100000;
+	ret = rpi_firmware_property(priv->fw, RPI_FIRMWARE_NOTIFY_XHCI_RESET,
+				    &dev_addr, sizeof(dev_addr));
+	if (ret)
+		return ret;
+
+	/* Wait for vl805 to startup */
+	usleep_range(200, 1000);
+
+	return 0;
+}
+
+static const struct reset_control_ops rpi_usb_reset_ops = {
+	.reset	= rpi_usb_reset_reset,
+};
+
+static int rpi_usb_reset_xlate(struct reset_controller_dev *rcdev,
+			       const struct of_phandle_args *reset_spec)
+{
+	/* This is needed if #reset-cells == 0. */
+	return 0;
+}
+
+static int rpi_usb_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *fw_node;
+	struct rpi_usb_reset *priv;
+	struct rpi_firmware *fw;
+
+	fw_node = of_get_parent(dev->of_node);
+	if (!fw_node) {
+		dev_err(dev, "Missing firmware node\n");
+		return -ENOENT;
+	}
+
+	fw = rpi_firmware_get(fw_node);
+	of_node_put(fw_node);
+	if (!fw)
+		return -EPROBE_DEFER;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+
+	priv->fw = fw;
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.nr_resets = 1;
+	priv->rcdev.ops = &rpi_usb_reset_ops;
+	priv->rcdev.of_node = dev->of_node;
+	priv->rcdev.of_xlate = rpi_usb_reset_xlate;
+
+	return devm_reset_controller_register(dev, &priv->rcdev);
+}
+
+static const struct of_device_id rpi_usb_reset_of_match[] = {
+	{ .compatible = "raspberrypi,firmware-usb-reset" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rpi_usb_reset_of_match);
+
+static struct platform_driver rpi_usb_reset_driver = {
+	.probe	= rpi_usb_reset_probe,
+	.driver	= {
+		.name = "raspberrypi-usb-reset",
+		.of_match_table = rpi_usb_reset_of_match,
+	},
+};
+module_platform_driver(rpi_usb_reset_driver);
+
+MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
+MODULE_DESCRIPTION("Raspberry Pi 4 USB reset driver");
+MODULE_LICENSE("GPL");
-- 
2.26.2

