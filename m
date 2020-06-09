Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708281F4558
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 20:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbgFIRub (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 13:50:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:36900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732666AbgFIRu0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 13:50:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A1E7FB14B;
        Tue,  9 Jun 2020 17:50:28 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 7/9] usb: host: pci-quirks: Bypass xHCI quirks for Raspberry Pi 4
Date:   Tue,  9 Jun 2020 19:50:00 +0200
Message-Id: <20200609175003.19793-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609175003.19793-1-nsaenzjulienne@suse.de>
References: <20200609175003.19793-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The board doesn't need the quirks to be run, and takes care of its own
initialization trough a reset controller device. So let's bypass them.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

---

Changes since v1:
 - Correct typos

 drivers/usb/host/pci-quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 92150ecdb036..294412ebbd0b 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -16,6 +16,8 @@
 #include <linux/export.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/of.h>
+
 #include "pci-quirks.h"
 #include "xhci-ext-caps.h"
 
@@ -1248,6 +1250,16 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
 	 */
 	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
 		return;
+
+	/*
+	 * Bypass the Raspberry Pi 4 controller xHCI controller, things are
+	 * taken care of by the board's co-processor.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483 &&
+	    of_device_is_compatible(of_get_parent(pdev->bus->dev.of_node),
+				    "brcm,bcm2711-pcie"))
+		return;
+
 	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_EHCI &&
-- 
2.26.2

