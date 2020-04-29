Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C839F1BE447
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 18:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgD2Qrx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 12:47:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:58240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgD2Qrx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Apr 2020 12:47:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B417AAC77;
        Wed, 29 Apr 2020 16:47:49 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, wahrenst@gmx.net
Subject: [PATCH v7 2/4] firmware: raspberrypi: Introduce vl805 init routine
Date:   Wed, 29 Apr 2020 18:47:32 +0200
Message-Id: <20200429164734.21506-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429164734.21506-1-nsaenzjulienne@suse.de>
References: <20200429164734.21506-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Raspberry Pi 4 gets its USB functionality from VL805, a PCIe chip
that implements xHCI. After a PCI reset, VL805's firmware may either be
loaded directly from an EEPROM or, if not present, by the SoC's
co-processor, VideoCore. RPi4's VideoCore OS contains both the non public
firmware load logic and the VL805 firmware blob. The function this patch
introduces triggers the aforementioned process.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Change since v6:
- Add test to avoid loading the firmware when not needed
- Since we have it around, print VL805's firmware version, it'll make
debugging easier in the future
- Correct typos
- Add a clearer view of HW topology in patch description

Changes since v4:
- Inline function definition when RASPBERRYPI_FIRMWARE is not defined

Changes since v1:
- Move include into .c file and add forward declaration to .h

 drivers/firmware/raspberrypi.c             | 52 ++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h |  7 +++
 2 files changed, 59 insertions(+)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index da26a584dca0..230c05e53403 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -12,6 +12,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
 #include <soc/bcm2835/raspberrypi-firmware.h>
 
 #define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
@@ -19,6 +21,8 @@
 #define MBOX_DATA28(msg)		((msg) & ~0xf)
 #define MBOX_CHAN_PROPERTY		8
 
+#define VL805_PCI_CONFIG_VERSION_OFFSET		0x50
+
 static struct platform_device *rpi_hwmon;
 static struct platform_device *rpi_clk;
 
@@ -286,6 +290,54 @@ struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
 }
 EXPORT_SYMBOL_GPL(rpi_firmware_get);
 
+/*
+ * The Raspberry Pi 4 gets its USB functionality from VL805, a PCIe chip that
+ * implements xHCI. After a PCI reset, VL805's firmware may either be loaded
+ * directly from an EEPROM or, if not present, by the SoC's co-processor,
+ * VideoCore. RPi4's VideoCore OS contains both the non public firmware load
+ * logic and the VL805 firmware blob. This function triggers the aforementioned
+ * process.
+ */
+int rpi_firmware_init_vl805(struct pci_dev *pdev)
+{
+	struct device_node *fw_np;
+	struct rpi_firmware *fw;
+	u32 dev_addr, version;
+	int ret = 0;
+
+	fw_np = of_find_compatible_node(NULL, NULL,
+					"raspberrypi,bcm2835-firmware");
+	if (!fw_np)
+		return 0;
+
+	fw = rpi_firmware_get(fw_np);
+	of_node_put(fw_np);
+	if (!fw)
+		return -ENODEV;
+
+	/* Make sure we don't trigger a firmware load unnecesarely */
+	pci_read_config_dword(pdev, VL805_PCI_CONFIG_VERSION_OFFSET, &version);
+	if (version)
+		goto exit;
+
+	dev_addr = pdev->bus->number << 20 | PCI_SLOT(pdev->devfn) << 15 |
+		   PCI_FUNC(pdev->devfn) << 12;
+
+	ret = rpi_firmware_property(fw, RPI_FIRMWARE_NOTIFY_XHCI_RESET,
+				    &dev_addr, sizeof(dev_addr));
+	/* Wait for vl805 to startup */
+	udelay(200);
+
+exit:
+	if (!version)
+		pci_read_config_dword(pdev, VL805_PCI_CONFIG_VERSION_OFFSET,
+				      &version);
+	pci_info(pdev, "VL805 firmware version %08x\n", version);
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(rpi_firmware_init_vl805);
+
 static const struct of_device_id rpi_firmware_of_match[] = {
 	{ .compatible = "raspberrypi,bcm2835-firmware", },
 	{},
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index cc9cdbc66403..3025aca3c358 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -10,6 +10,7 @@
 #include <linux/of_device.h>
 
 struct rpi_firmware;
+struct pci_dev;
 
 enum rpi_firmware_property_status {
 	RPI_FIRMWARE_STATUS_REQUEST = 0,
@@ -141,6 +142,7 @@ int rpi_firmware_property(struct rpi_firmware *fw,
 int rpi_firmware_property_list(struct rpi_firmware *fw,
 			       void *data, size_t tag_size);
 struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node);
+int rpi_firmware_init_vl805(struct pci_dev *pdev);
 #else
 static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag,
 					void *data, size_t len)
@@ -158,6 +160,11 @@ static inline struct rpi_firmware *rpi_firmware_get(struct device_node *firmware
 {
 	return NULL;
 }
+
+static inline int rpi_firmware_init_vl805(struct pci_dev *pdev)
+{
+	return 0;
+}
 #endif
 
 #endif /* __SOC_RASPBERRY_FIRMWARE_H__ */
-- 
2.26.2

