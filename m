Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398BF16446A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2020 13:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgBSMjr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Feb 2020 07:39:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:52888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbgBSMjq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Feb 2020 07:39:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 38868B4D1;
        Wed, 19 Feb 2020 12:39:45 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, wahrenst@gmx.net,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 4/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
Date:   Wed, 19 Feb 2020 13:39:33 +0100
Message-Id: <20200219123933.2792-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219123933.2792-1-nsaenzjulienne@suse.de>
References: <20200219123933.2792-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
loaded directly from an EEPROM or, if not present, by the SoC's
VideCore. Inform VideCore that VL805 was just reset.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/usb/host/pci-quirks.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index beb2efa71341..aee2eaa3f0e1 100644
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
 
@@ -1243,11 +1246,26 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 
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
+		if (ret)
+			/*
+			 * Firmware might be outdated, or else, something
+			 * failed, keep going and hope for the best.
+			 */
+			dev_warn(&pdev->dev,
+				 "Failed to load VL805's firmware: %d\n",
+				 ret);
+	}
+
 	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_EHCI &&
-- 
2.25.0

