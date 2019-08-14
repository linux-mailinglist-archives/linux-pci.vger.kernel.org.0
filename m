Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896B98D278
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 13:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfHNLqy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 14 Aug 2019 07:46:54 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:46014 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfHNLqy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2019 07:46:54 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 07:46:54 EDT
IronPort-SDR: oy9sF8ZShLMsG66RYhvMLKDdtoV0TWmRr9RRJ1B+2emNbzD8vdz1qvGZaW8HfcSPLJe5c2m8Ui
 +k60b3sVjibSSClIaDo5O1B7E43wMjT7Vx2cgKfTNfo38sAQaNs9cqOSYQTFHSXN2QbCDLQ6n9
 wElcFuanxhImlBYIiJALx49lk1wbkQ9c55p+OUaHuLM6tBKEP8zhWLY8sxFH7kW+qQ0drdeacz
 5DpDQLsSNfuiwVHNVqceCtEbNL3a/rba7Qc5afZC6lKLcmB2SnCV9cADo9UInwTM1QiWIhi67R
 zjc=
X-IronPort-AV: E=Sophos;i="5.64,385,1559548800"; 
   d="scan'208";a="40454989"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 14 Aug 2019 03:39:47 -0800
IronPort-SDR: Aoeb+lm75XWbI7uH8v6v17c8kZdqfZs0aTRMRUksJQ0xXff1sjbZgy7ImoFVeVB/eUbpd7Xiqq
 L7+uyFqwat4KZqnnixTJD+O6ta5iOIiUXHwRdZ0STugmqPQ8fl2j4ezQBt2bxj5M2lXtviBunn
 nxiTDkVxRfStU00D/ABLfzEBC3kY3Gweuh/XmvZs9EJfuGiGHPPvNBxMNWHW5QjBf1snLQ9H4g
 +ZA4O3yWmZUQ5wrCR2XflTH8mq91Qwv+AjgoyPQf08c6EUnfbZBS7q4ilA6twMCMg+wH40PknM
 eEE=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH] usb: xhci-pci: reorder removal to avoid use-after-free
Thread-Topic: [PATCH] usb: xhci-pci: reorder removal to avoid use-after-free
Thread-Index: AQHVUpSXBvBKq97fNkaS50QUUgX/8g==
Date:   Wed, 14 Aug 2019 11:39:41 +0000
Message-ID: <1565782781938.37795@mentor.com>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On driver removal, the platform_device_unregister call
attached through devm_add_action_or_reset was executed
after usb_hcd_pci_remove.
This lead to a use-after-free for the iomem resorce of
the xhci-ext-caps driver in the platform removal
because the parent of the resource was freed earlier.

Fix this by reordering of the removal sequence.

Signed-off-by: Carsten Schmid <carsten_schmid@mentor.com>
---
 drivers/usb/host/xhci-ext-caps.c | 22 ++++++++++++----------
 drivers/usb/host/xhci-pci.c      |  4 ++++
 drivers/usb/host/xhci-pci.h      | 19 +++++++++++++++++++
 drivers/usb/host/xhci.h          |  1 +
 4 files changed, 36 insertions(+), 10 deletions(-)
 create mode 100644 drivers/usb/host/xhci-pci.h

diff --git a/drivers/usb/host/xhci-ext-caps.c b/drivers/usb/host/xhci-ext-caps.c
index 399113f9fc5c..d2ab1e2a39c0 100644
--- a/drivers/usb/host/xhci-ext-caps.c
+++ b/drivers/usb/host/xhci-ext-caps.c
@@ -7,21 +7,19 @@
 
 #include <linux/platform_device.h>
 #include "xhci.h"
+#include "xhci-pci.h"
 
 #define USB_SW_DRV_NAME		"intel_xhci_usb_sw"
 #define USB_SW_RESOURCE_SIZE	0x400
 
-static void xhci_intel_unregister_pdev(void *arg)
-{
-	platform_device_unregister(arg);
-}
-
 static int xhci_create_intel_xhci_sw_pdev(struct xhci_hcd *xhci, u32 cap_offset)
 {
 	struct usb_hcd *hcd = xhci_to_hcd(xhci);
 	struct device *dev = hcd->self.controller;
 	struct platform_device *pdev;
 	struct resource	res = { 0, };
+	struct xhci_pci_priv *priv = (struct xhci_pci_priv *)xhci->priv;
+
 	int ret;
 
 	pdev = platform_device_alloc(USB_SW_DRV_NAME, PLATFORM_DEVID_NONE);
@@ -52,11 +50,7 @@ static int xhci_create_intel_xhci_sw_pdev(struct xhci_hcd *xhci, u32 cap_offset)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(dev, xhci_intel_unregister_pdev, pdev);
-	if (ret) {
-		dev_err(dev, "couldn't add unregister action for intel_xhci_usb_sw pdev\n");
-		return ret;
-	}
+	priv->pdev = pdev;
 
 	return 0;
 }
@@ -88,3 +82,11 @@ int xhci_ext_cap_init(struct xhci_hcd *xhci)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xhci_ext_cap_init);
+
+void xhci_ext_cap_remove(struct xhci_hcd *xhci)
+{
+	struct xhci_pci_priv *priv = (struct xhci_pci_priv *)xhci->priv;
+	if (priv->pdev)
+		platform_device_unregister(priv->pdev);
+}
+EXPORT_SYMBOL_GPL(xhci_ext_cap_remove);
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index c2fe218e051f..a4d094df56f7 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 
 #include "xhci.h"
+#include "xhci-pci.h"
 #include "xhci-trace.h"
 
 #define SSIC_PORT_NUM		2
@@ -62,6 +63,7 @@ static struct hc_driver __read_mostly xhci_pci_hc_driver;
 static int xhci_pci_setup(struct usb_hcd *hcd);
 
 static const struct xhci_driver_overrides xhci_pci_overrides __initconst = {
+	.extra_priv_size = sizeof(struct xhci_pci_priv),
 	.reset = xhci_pci_setup,
 };
 
@@ -393,6 +395,8 @@ static void xhci_pci_remove(struct pci_dev *dev)
 		xhci->shared_hcd = NULL;
 	}
 
+	xhci_ext_cap_remove(xhci);
+
 	/* Workaround for spurious wakeups at shutdown with HSW */
 	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
 		pci_set_power_state(dev, PCI_D3hot);
diff --git a/drivers/usb/host/xhci-pci.h b/drivers/usb/host/xhci-pci.h
new file mode 100644
index 000000000000..ead9618d7368
--- /dev/null
+++ b/drivers/usb/host/xhci-pci.h
@@ -0,0 +1,19 @@
+/*
+ * xhci-pci.h - xHCI extended capability handling platform Glue.
+ *
+ * Copyright (C) 2019 Mentor Graphics (Deutschland) GmbH
+ * Derived from xhci-plat.h
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+
+#ifndef _XHCI_PCI_H
+#define _XHCI_PCI_H
+
+struct xhci_pci_priv {
+	struct platform_device *pdev;
+};
+
+#endif	/* _XHCI_PCI_H */
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index fabbce1c542a..847d2021fc2c 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2052,6 +2052,7 @@ void xhci_init_driver(struct hc_driver *drv,
 		      const struct xhci_driver_overrides *over);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
 int xhci_ext_cap_init(struct xhci_hcd *xhci);
+void xhci_ext_cap_remove(struct xhci_hcd *xhci);
 
 int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup);
 int xhci_resume(struct xhci_hcd *xhci, bool hibernated);
-- 
2.17.1
