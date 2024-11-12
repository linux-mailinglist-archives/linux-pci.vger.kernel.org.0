Return-Path: <linux-pci+bounces-16563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7551A9C618B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 20:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5F7B8270C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812A2123DF;
	Tue, 12 Nov 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUJRdw6M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E9206E61;
	Tue, 12 Nov 2024 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427293; cv=none; b=DqKta/rPgfGQYlTHvVHNnELGp2IEHogQUZFuIly6MmQOboxjAhNdyD2EV5hFSazv1XSUBdGMC0KsfjfjaHmNW1tPSXqcGNJIsCQ4aZjjkZonCBPV6k2jkI2Z8PCaPKusavvWL6rxi3SIbnUUNcVZiKwZ/ZtxvI8x9aCEy/ruGq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427293; c=relaxed/simple;
	bh=rE1n742XV6Hh13YXAK03XaqAi+NRIgacwErEEh/8Nto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tgk4q+bPAJhgGQ8eGWIb+SgFnFiPRsgnOd9cYN6kS/xamsUZTWzXF0Li7ph7GNYCpuTZYQhkU32qKaM/kxxpnru4Ny0RBYHWc/nJTSFYXZ6qaluQl7V4+HED8AUZcVPi5Xmqrcpfs4kv0uoH0s38DG/RU1BXxO7EQ4i0He9Oy7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUJRdw6M; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731427292; x=1762963292;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rE1n742XV6Hh13YXAK03XaqAi+NRIgacwErEEh/8Nto=;
  b=DUJRdw6Mux3ocdraaH8w4dphmI5Kxh0+lvt9V1QT80U2KSRoA3US2JG9
   xur+QDzg2Ux0eqTkQF0Nda9D8Vzs+eZ4xnzU4HYX7I1SoOTvvp6YegTyh
   4f9hlrLCQ+SM7jt6Cax5xfY3FXer2LRVYRc+xll5gDXMobCjAH+FDqO+7
   4V3xY3u3HBXxdUIt2w4q1navglVz7ZZLYTlc1cQn0cxV1BBoxVs1c+IrY
   ICYrVQ8KaKNXr62hK7cqiHMVLbq5d9gNjxp34oqAEAtqrEWrxpJxveORn
   BP5PONUCrFlRZkqoTINgFv0/B9m5Tm+2yOvfw6Fz98mwzPtAS5I6UTNLP
   w==;
X-CSE-ConnectionGUID: r00eIVo0RXWAump5SFMEpA==
X-CSE-MsgGUID: ryj38hkrTmmaXlz06P6hWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41831474"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41831474"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 08:01:31 -0800
X-CSE-ConnectionGUID: 7Orz8rzdQA+vB3J+K3Cg1A==
X-CSE-MsgGUID: UQQKbw39RLis5EwXPvg7zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87489572"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 12 Nov 2024 08:01:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 440FA1BE; Tue, 12 Nov 2024 18:01:27 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 1/1] usb: cdns3: Synchronise PCI IDs via common data base
Date: Tue, 12 Nov 2024 18:01:25 +0200
Message-ID: <20241112160125.2340972-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few places in the kernel where PCI IDs for different Cadence
USB controllers are being used. Besides different naming, they duplicate
each other. Make this all in order by providing common definitions via
PCI IDs database and use in all users. While doing that, rename
definitions as Roger suggested.

Suggested-by: Roger Quadros <rogerq@kernel.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/cdns3/cdns3-pci-wrap.c       |  4 +---
 drivers/usb/cdns3/cdnsp-pci.c            | 26 +++++++++---------------
 drivers/usb/gadget/udc/cdns2/cdns2-pci.c |  3 +--
 drivers/usb/host/xhci-pci.c              |  5 ++---
 include/linux/pci_ids.h                  |  4 ++++
 5 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
index 591d149de8f3..3b3b3dc75f35 100644
--- a/drivers/usb/cdns3/cdns3-pci-wrap.c
+++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
@@ -37,8 +37,6 @@ struct cdns3_wrap {
 #define PCI_DRIVER_NAME		"cdns3-pci-usbss"
 #define PLAT_DRIVER_NAME	"cdns-usb3"
 
-#define PCI_DEVICE_ID_CDNS_USB3	0x0100
-
 static struct pci_dev *cdns3_get_second_fun(struct pci_dev *pdev)
 {
 	struct pci_dev *func;
@@ -189,7 +187,7 @@ static void cdns3_pci_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id cdns3_pci_ids[] = {
-	{ PCI_VDEVICE(CDNS, PCI_DEVICE_ID_CDNS_USB3) },
+	{ PCI_VDEVICE(CDNS, PCI_DEVICE_ID_CDNS_USBSS) },
 	{ 0, }
 };
 
diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index 2d05368a6745..a51144504ff3 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -28,12 +28,6 @@
 #define PCI_DRIVER_NAME		"cdns-pci-usbssp"
 #define PLAT_DRIVER_NAME	"cdns-usbssp"
 
-#define PCI_DEVICE_ID_CDNS_USB3		0x0100
-#define PCI_DEVICE_ID_CDNS_UDC		0x0200
-
-#define PCI_CLASS_SERIAL_USB_CDNS_USB3	(PCI_CLASS_SERIAL_USB << 8 | 0x80)
-#define PCI_CLASS_SERIAL_USB_CDNS_UDC	PCI_CLASS_SERIAL_USB_DEVICE
-
 static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
 {
 	/*
@@ -41,10 +35,10 @@ static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
 	 * Platform has two function. The fist keeps resources for
 	 * Host/Device while the secon keeps resources for DRD/OTG.
 	 */
-	if (pdev->device == PCI_DEVICE_ID_CDNS_UDC)
-		return pci_get_device(pdev->vendor, PCI_DEVICE_ID_CDNS_USB3, NULL);
-	if (pdev->device == PCI_DEVICE_ID_CDNS_USB3)
-		return pci_get_device(pdev->vendor, PCI_DEVICE_ID_CDNS_UDC, NULL);
+	if (pdev->device == PCI_DEVICE_ID_CDNS_USBSSP)
+		return pci_get_device(pdev->vendor, PCI_DEVICE_ID_CDNS_USBSS, NULL);
+	if (pdev->device == PCI_DEVICE_ID_CDNS_USBSS)
+		return pci_get_device(pdev->vendor, PCI_DEVICE_ID_CDNS_USBSSP, NULL);
 
 	return NULL;
 }
@@ -221,12 +215,12 @@ static const struct dev_pm_ops cdnsp_pci_pm_ops = {
 };
 
 static const struct pci_device_id cdnsp_pci_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_UDC),
-	  .class = PCI_CLASS_SERIAL_USB_CDNS_UDC },
-	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_UDC),
-	  .class = PCI_CLASS_SERIAL_USB_CDNS_USB3 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USB3),
-	  .class = PCI_CLASS_SERIAL_USB_CDNS_USB3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USBSSP),
+	  .class = PCI_CLASS_SERIAL_USB_DEVICE },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USBSSP),
+	  .class = PCI_CLASS_SERIAL_USB_CDNS },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USBSS),
+	  .class = PCI_CLASS_SERIAL_USB_CDNS },
 	{ 0, }
 };
 
diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
index b1a8f772467c..e589593b4cbf 100644
--- a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
@@ -15,7 +15,6 @@
 #include "cdns2-gadget.h"
 
 #define PCI_DRIVER_NAME		"cdns-pci-usbhs"
-#define PCI_DEVICE_ID_CDNS_USB2	0x0120
 #define PCI_BAR_DEV		0
 #define PCI_DEV_FN_DEVICE	0
 
@@ -113,7 +112,7 @@ static const struct dev_pm_ops cdns2_pci_pm_ops = {
 };
 
 static const struct pci_device_id cdns2_pci_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USB2),
+	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USB),
 	  .class = PCI_CLASS_SERIAL_USB_DEVICE },
 	{ 0, }
 };
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 47c4f70793e4..b21474e81482 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -82,8 +82,6 @@
 #define PCI_DEVICE_ID_ASMEDIA_3042_XHCI			0x3042
 #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
 
-#define PCI_DEVICE_ID_CDNS_SSP				0x0200
-
 static const char hcd_name[] = "xhci_hcd";
 
 static struct hc_driver __read_mostly xhci_pci_hc_driver;
@@ -475,8 +473,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		if (pdev->device == 0x9203)
 			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
 	}
+
 	if (pdev->vendor == PCI_VENDOR_ID_CDNS &&
-	    pdev->device == PCI_DEVICE_ID_CDNS_SSP)
+	    pdev->device == PCI_DEVICE_ID_CDNS_USBSSP)
 		xhci->quirks |= XHCI_CDNS_SCTX_QUIRK;
 
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e4bddb927795..d2402bf4aea2 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -121,6 +121,7 @@
 #define PCI_CLASS_SERIAL_USB_OHCI	0x0c0310
 #define PCI_CLASS_SERIAL_USB_EHCI	0x0c0320
 #define PCI_CLASS_SERIAL_USB_XHCI	0x0c0330
+#define PCI_CLASS_SERIAL_USB_CDNS	0x0c0380
 #define PCI_CLASS_SERIAL_USB_DEVICE	0x0c03fe
 #define PCI_CLASS_SERIAL_FIBER		0x0c04
 #define PCI_CLASS_SERIAL_SMBUS		0x0c05
@@ -2421,6 +2422,9 @@
 #define PCI_VENDOR_ID_QCOM		0x17cb
 
 #define PCI_VENDOR_ID_CDNS		0x17cd
+#define PCI_DEVICE_ID_CDNS_USBSS	0x0100
+#define PCI_DEVICE_ID_CDNS_USB		0x0120
+#define PCI_DEVICE_ID_CDNS_USBSSP	0x0200
 
 #define PCI_VENDOR_ID_ARECA		0x17d3
 #define PCI_DEVICE_ID_ARECA_1110	0x1110
-- 
2.43.0.rc1.1336.g36b5255a03ac


