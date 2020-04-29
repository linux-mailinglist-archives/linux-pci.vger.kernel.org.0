Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210E41BE440
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 18:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgD2Qrz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 12:47:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:58314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgD2Qry (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Apr 2020 12:47:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4B358AD80;
        Wed, 29 Apr 2020 16:47:52 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, wahrenst@gmx.net,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v7 4/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
Date:   Wed, 29 Apr 2020 18:47:34 +0200
Message-Id: <20200429164734.21506-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429164734.21506-1-nsaenzjulienne@suse.de>
References: <20200429164734.21506-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
loaded directly from an EEPROM or, if not present, by the SoC's
VideoCore. Inform VideoCore that VL805 was just reset.

Also, as this creates a dependency between USB_PCI and VideoCore's
firmware interface, and since USB_PCI can't be set as a module neither
this can. Reflect that on the firmware interface Kconfg.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes since v5:
 - Fix Kconfig issue with allmodconfig

Changes since v4:
 - Do not split up error message

Changes since v3:
 - Add more complete error message

Changes since v1:
 - Make RASPBERRYPI_FIRMWARE dependent on this quirk to make sure it
   gets compiled when needed.

 drivers/firmware/Kconfig      |  3 ++-
 drivers/usb/host/pci-quirks.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 8007d4aa76dc..b42140cff8ac 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -178,8 +178,9 @@ config ISCSI_IBFT
 	  Otherwise, say N.
 
 config RASPBERRYPI_FIRMWARE
-	tristate "Raspberry Pi Firmware Driver"
+	bool "Raspberry Pi Firmware Driver"
 	depends on BCM2835_MBOX
+	default USB_PCI
 	help
 	  This option enables support for communicating with the firmware on the
 	  Raspberry Pi.
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index beb2efa71341..0dc34668bb2a 100644
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
+			dev_warn(&pdev->dev,
+				 "Failed to load VL805's firmware: %d. Will continue to attempt to work, but bad things might happen. You should fix this...\n",
+				 ret);
+		}
+	}
+
 	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_EHCI &&
-- 
2.26.2

