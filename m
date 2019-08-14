Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8578D636
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 16:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfHNOcw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 14 Aug 2019 10:32:52 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:2401 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfHNOcw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2019 10:32:52 -0400
IronPort-SDR: TC7J2TPCpQq+h5jzUzfERvFAtXZ3JoB9AGYyYLKiqfa+4tRcAtOr+JfmeQkEDqRM+t0ZALOyY1
 abiIC8qQkBmiIOSCnoyz8/7UJvY252dE/BlasE2x7dKKFY+dP/IMlyHRW4s7zv/CVQeqoRKP4h
 3fAd50RZdUkYHXllQcI/sPLt0kKwnyx7rPqP6nQ1YjIubC6hiOSckLNB3AP6VOQtEUhlQwi//F
 F7mNTACRCNtA/xQVl3HDzLklSc/wkFepMoVtYkOQ84Op8Vvz85KiyhGnJ9CKJpXVJbdYmrYHD1
 QL0=
X-IronPort-AV: E=Sophos;i="5.64,385,1559548800"; 
   d="scan'208";a="40450057"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 14 Aug 2019 06:32:51 -0800
IronPort-SDR: NLYVRwkFwNT7pjSE9ru1OFQVkT4FwXSoOHTzEgFStKGjx/9bs34IRNNtkLWR7ZfltULKTXJauj
 dWmfBwRJwH1l0CUAs5wvaS/Zx3CfDdsJqGbiWVnRtXcPmj47p3CHmBJtsRxCnaLsRqDaPuLE4T
 jB9YUhOEW4KGuPEfoZqdZkY3Xc9OIejC/O6FovCWPnkfDWVqKndThjzTdt3ma0CwL3emhMnJK0
 vm7dfsNmtA4x6LfJfze2vl6bueFMvGOpJGv77S87dFDQUuIwPbSibUiLNe5/ijb9sWmCAwudIv
 quY=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH v2] usb: xhci-pci: reorder removal to avoid use-after-free
Thread-Topic: [PATCH v2] usb: xhci-pci: reorder removal to avoid
 use-after-free
Thread-Index: AQHVUqy8Nhj3BRvGDEy2Ur9dpf2v1Q==
Date:   Wed, 14 Aug 2019 14:32:45 +0000
Message-ID: <1565793165678.11527@mentor.com>
References: <1565782781938.37795@mentor.com>
 <15aa45c7-6e45-d03f-9336-4291f8b2dc66@redhat.com>
 <29aadcf136bb4d5285afb4fc5b500b49@SVR-IES-MBX-03.mgc.mentorg.com>,<662c2014-f52c-a4a7-cbf0-78d43c3a4f22@redhat.com>
In-Reply-To: <662c2014-f52c-a4a7-cbf0-78d43c3a4f22@redhat.com>
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
v2:
  - more speaking name for private data element
  - consider failure in driver init sequence
  - fix minor issues found by checkpatch.pl
---
 drivers/usb/host/xhci-ext-caps.c | 25 +++++++++++++++----------
 drivers/usb/host/xhci-pci.c      |  8 +++++++-
 drivers/usb/host/xhci-pci.h      | 20 ++++++++++++++++++++
 drivers/usb/host/xhci.h          |  1 +
 4 files changed, 43 insertions(+), 11 deletions(-)
 create mode 100644 drivers/usb/host/xhci-pci.h

diff --git a/drivers/usb/host/xhci-ext-caps.c b/drivers/usb/host/xhci-ext-caps.c
index 399113f9fc5c..28a7d53ecf2c 100644
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
+	priv->role_switch_pdev = pdev;
 
 	return 0;
 }
@@ -88,3 +82,14 @@ int xhci_ext_cap_init(struct xhci_hcd *xhci)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xhci_ext_cap_init);
+
+void xhci_ext_cap_remove(struct xhci_hcd *xhci)
+{
+	struct xhci_pci_priv *priv = (struct xhci_pci_priv *)xhci->priv;
+
+	if (priv->role_switch_pdev) {
+		platform_device_unregister(priv->role_switch_pdev);
+		priv->role_switch_pdev = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(xhci_ext_cap_remove);
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index c2fe218e051f..f2201f380c17 100644
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
 
@@ -350,7 +352,7 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	retval = usb_add_hcd(xhci->shared_hcd, dev->irq,
 			IRQF_SHARED);
 	if (retval)
-		goto put_usb3_hcd;
+		goto remove_ext_cap;
 	/* Roothub already marked as USB 3.0 speed */
 
 	if (!(xhci->quirks & XHCI_BROKEN_STREAMS) &&
@@ -368,6 +370,8 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	return 0;
 
+remove_ext_cap:
+	xhci_ext_cap_remove(xhci);
 put_usb3_hcd:
 	usb_put_hcd(xhci->shared_hcd);
 dealloc_usb2_hcd:
@@ -393,6 +397,8 @@ static void xhci_pci_remove(struct pci_dev *dev)
 		xhci->shared_hcd = NULL;
 	}
 
+	xhci_ext_cap_remove(xhci);
+
 	/* Workaround for spurious wakeups at shutdown with HSW */
 	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
 		pci_set_power_state(dev, PCI_D3hot);
diff --git a/drivers/usb/host/xhci-pci.h b/drivers/usb/host/xhci-pci.h
new file mode 100644
index 000000000000..fc0cde231679
--- /dev/null
+++ b/drivers/usb/host/xhci-pci.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
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
+	struct platform_device *role_switch_pdev;
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
