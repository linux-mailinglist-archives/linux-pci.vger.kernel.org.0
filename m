Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FA720397F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgFVO0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 10:26:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:44782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729284AbgFVO0R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 10:26:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 259D9C1C1;
        Mon, 22 Jun 2020 14:26:13 +0000 (UTC)
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
Subject: [PATCH v4 7/9] usb: host: pci-quirks: Bypass xHCI quirks for Raspberry Pi 4
Date:   Mon, 22 Jun 2020 12:38:16 +0200
Message-Id: <20200622103817.476-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622103817.476-1-nsaenzjulienne@suse.de>
References: <20200622103817.476-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The board doesn't need the quirks to be run, and takes care of its own
initialization through a reset controller device. So let's bypass them.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

---

Changes since v2:
 - Correct reference counting on parent device node

Changes since v1:
 - Correct typos

 drivers/usb/host/pci-quirks.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 92150ecdb036..977d0b6d7577 100644
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
 
@@ -1243,11 +1245,27 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 
 static void quirk_usb_early_handoff(struct pci_dev *pdev)
 {
+	struct device_node *parent;
+	bool is_rpi;
+
 	/* Skip Netlogic mips SoC's internal PCI USB controller.
 	 * This device does not need/support EHCI/OHCI handoff
 	 */
 	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
 		return;
+
+	/*
+	 * Bypass the Raspberry Pi 4 controller xHCI controller, things are
+	 * taken care of by the board's co-processor.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483) {
+		parent = of_get_parent(pdev->bus->dev.of_node);
+		is_rpi = of_device_is_compatible(parent, "brcm,bcm2711-pcie");
+		of_node_put(parent);
+		if (is_rpi)
+			return;
+	}
+
 	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_EHCI &&
-- 
2.27.0

