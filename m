Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDDC422C20
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhJEPQi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 11:16:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:46206 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhJEPQi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 11:16:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="289274430"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="289274430"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 08:14:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="458093483"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Oct 2021 08:14:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 66B7C1C8; Tue,  5 Oct 2021 18:14:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 1/1] watchdog: wdt_pci: Correct the PCI ID vendor name
Date:   Tue,  5 Oct 2021 18:14:45 +0300
Message-Id: <20211005151445.89620-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The proper name of Acces I/O is with a single 's'. Correct it respectively.

While at it, convert to use PCI_DEVICE() macro, drop unneeded initializer
and comma.

Fixes: 9f2cc6f759ca ("watchdog: wdt_pci.c: move ids to pci_ids.h")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/watchdog/wdt_pci.c | 9 ++-------
 include/linux/pci_ids.h    | 4 ++--
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index d5e56b601351..ba63f442438d 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -717,13 +717,8 @@ static void wdtpci_remove_one(struct pci_dev *pdev)
 
 
 static const struct pci_device_id wdtpci_pci_tbl[] = {
-	{
-		.vendor	   = PCI_VENDOR_ID_ACCESSIO,
-		.device	   = PCI_DEVICE_ID_ACCESSIO_WDG_CSM,
-		.subvendor = PCI_ANY_ID,
-		.subdevice = PCI_ANY_ID,
-	},
-	{ 0, }, /* terminate list */
+	{ PCI_DEVICE(PCI_VENDOR_ID_ACCESIO, PCI_DEVICE_ID_ACCESIO_WDG_CSM) },
+	{ } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, wdtpci_pci_tbl);
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 011f2f1ea5bb..37a9f12b4def 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2611,8 +2611,8 @@
 #define PCI_VENDOR_ID_AKS		0x416c
 #define PCI_DEVICE_ID_AKS_ALADDINCARD	0x0100
 
-#define PCI_VENDOR_ID_ACCESSIO		0x494f
-#define PCI_DEVICE_ID_ACCESSIO_WDG_CSM	0x22c0
+#define PCI_VENDOR_ID_ACCESIO		0x494f
+#define PCI_DEVICE_ID_ACCESIO_WDG_CSM	0x22c0
 
 #define PCI_VENDOR_ID_S3		0x5333
 #define PCI_DEVICE_ID_S3_TRIO		0x8811
-- 
2.33.0

