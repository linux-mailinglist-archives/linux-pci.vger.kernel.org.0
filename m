Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18871203924
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 16:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgFVO0c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 10:26:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:46762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbgFVO0c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 10:26:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E1A0C1E3;
        Mon, 22 Jun 2020 14:26:29 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, robh@kernel.org,
        wahrenst@gmx.net, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 6/9] Revert "USB: pci-quirks: Add Raspberry Pi 4 quirk"
Date:   Mon, 22 Jun 2020 12:38:15 +0200
Message-Id: <20200622103817.476-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622103817.476-1-nsaenzjulienne@suse.de>
References: <20200622103817.476-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit c65822fef4adc0ba40c37a47337376ce75f7a7bc.

The initialization of Raspberry Pi 4's USB chip is now handled through a
reset controller. No need to directly call the firmware routine trough a
pci quirk.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/firmware/Kconfig      |  3 +--
 drivers/usb/host/pci-quirks.c | 16 ----------------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index fbd785dd0513..4843e94713a4 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -178,9 +178,8 @@ config ISCSI_IBFT
 	  Otherwise, say N.
 
 config RASPBERRYPI_FIRMWARE
-	bool "Raspberry Pi Firmware Driver"
+	tristate "Raspberry Pi Firmware Driver"
 	depends on BCM2835_MBOX
-	default USB_PCI
 	help
 	  This option enables support for communicating with the firmware on the
 	  Raspberry Pi.
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 0b949acfa258..92150ecdb036 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -16,9 +16,6 @@
 #include <linux/export.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
-
-#include <soc/bcm2835/raspberrypi-firmware.h>
-
 #include "pci-quirks.h"
 #include "xhci-ext-caps.h"
 
@@ -1246,24 +1243,11 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 
 static void quirk_usb_early_handoff(struct pci_dev *pdev)
 {
-	int ret;
-
 	/* Skip Netlogic mips SoC's internal PCI USB controller.
 	 * This device does not need/support EHCI/OHCI handoff
 	 */
 	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
 		return;
-
-	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483) {
-		ret = rpi_firmware_init_vl805(pdev);
-		if (ret) {
-			/* Firmware might be outdated, or something failed */
-			dev_warn(&pdev->dev,
-				 "Failed to load VL805's firmware: %d. Will continue to attempt to work, but bad things might happen. You should fix this...\n",
-				 ret);
-		}
-	}
-
 	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_EHCI &&
-- 
2.27.0

