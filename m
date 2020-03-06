Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C465417BBF7
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 12:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCFLoG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 06:44:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:39364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgCFLoB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 06:44:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F3588AF77;
        Fri,  6 Mar 2020 11:43:58 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, wahrenst@gmx.net,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 4/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
Date:   Fri,  6 Mar 2020 12:43:48 +0100
Message-Id: <20200306114348.5172-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306114348.5172-1-nsaenzjulienne@suse.de>
References: <20200306114348.5172-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
loaded directly from an EEPROM or, if not present, by the SoC's
VideCore. Inform VideCore that VL805 was just reset.

Also, as this creates a dependency between XHCI_PCI and VideoCore's
firmware interface, reflect that on the firmware interface Kconfg.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes since v3:
 - Add more complete error message.
 - Add braces around if statement

Changes since v1:
 - Make RASPBERRYPI_FIRMWARE dependent on this quirk to make sure it
   gets compiled when needed.

 drivers/firmware/Kconfig      |  1 +
 drivers/usb/host/pci-quirks.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index ea869addc89b..40a468d712a5 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -180,6 +180,7 @@ config ISCSI_IBFT
 config RASPBERRYPI_FIRMWARE
 	tristate "Raspberry Pi Firmware Driver"
 	depends on BCM2835_MBOX
+	default XHCI_PCI
 	help
 	  This option enables support for communicating with the firmware on the
 	  Raspberry Pi.
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index beb2efa71341..452f5f12b042 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -16,6 +16,9 @@
 #include <linux/export.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
 #include "pci-quirks.h"
 #include "xhci-ext-caps.h"
 
@@ -1243,11 +1246,24 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 
 static void quirk_usb_early_handoff(struct pci_dev *pdev)
 {
+	int ret;
+
 	/* Skip Netlogic mips SoC's internal PCI USB controller.
 	 * This device does not need/support EHCI/OHCI handoff
 	 */
 	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
 		return;
+
+	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483) {
+		ret = rpi_firmware_init_vl805(pdev);
+		if (ret) {
+			/* Firmware might be outdated, or something failed */
+			dev_warn(&pdev->dev, "Failed to load VL805's firmware: %d\n", ret);
+			dev_warn(&pdev->dev, "Will continue to attempt to work, "
+				 "but bad things might happen. You should fix this...\n");
+		}
+	}
+
 	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_EHCI &&
-- 
2.25.1

