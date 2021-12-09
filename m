Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA31546F310
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 19:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243257AbhLISam (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 13:30:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:23370 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243309AbhLISal (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Dec 2021 13:30:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238401467"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="238401467"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 10:27:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="516782459"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 09 Dec 2021 10:27:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D4B56329; Thu,  9 Dec 2021 20:27:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>
Subject: [PATCH v2 1/1] PCI: Introduce pci_bus_*() printing macros when device is not available
Date:   Thu,  9 Dec 2021 20:27:11 +0200
Message-Id: <20211209182711.28709-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In some cases PCI device structure is not available and we want to print
information based on the bus and devfn parameters. For this cases introduce
pci_bus_*() printing macros and replace in existing users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
---
v2: split out as a separate patch, added tag (Jean)

Jean, for now it seems overkill to add pci_bus_dbg() since it's not as simple                                    as the rest, it needs a separate full macro with pr_debug() called explicitly
underneath. Hence, I tried and decided not to go until we have enough users.

 drivers/pci/probe.c | 12 +++---------
 include/linux/pci.h |  8 ++++++++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2c91d3509d17..7208901fba70 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2334,16 +2334,12 @@ static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
 	 */
 	while (pci_bus_crs_vendor_id(*l)) {
 		if (delay > timeout) {
-			pr_warn("pci %04x:%02x:%02x.%d: not ready after %dms; giving up\n",
-				pci_domain_nr(bus), bus->number,
-				PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
+			pci_bus_warn(bus, devfn, "not ready after %dms; giving up\n", delay - 1);
 
 			return false;
 		}
 		if (delay >= 1000)
-			pr_info("pci %04x:%02x:%02x.%d: not ready after %dms; waiting\n",
-				pci_domain_nr(bus), bus->number,
-				PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
+			pci_bus_info(bus, devfn, "not ready after %dms; waiting\n", delay - 1);
 
 		msleep(delay);
 		delay *= 2;
@@ -2353,9 +2349,7 @@ static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
 	}
 
 	if (delay >= 1000)
-		pr_info("pci %04x:%02x:%02x.%d: ready after %dms\n",
-			pci_domain_nr(bus), bus->number,
-			PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
+		pci_bus_info(bus, devfn, "ready after %dms\n", delay - 1);
 
 	return true;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0ce26850470e..ea8736077d83 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2482,4 +2482,12 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 	WARN_ONCE(condition, "%s %s: " fmt, \
 		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
 
+#define pci_bus_printk(level, bus, devfn, fmt, arg...) \
+	printk(level "pci %04x:%02x:%02x.%d: " fmt, \
+	       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn), ##arg)
+
+#define pci_bus_err(bus, devfn, fmt, arg...)	pci_bus_printk(KERN_ERR, bus, devfn, fmt, ##arg)
+#define pci_bus_warn(bus, devfn, fmt, arg...)	pci_bus_printk(KERN_WARNING, bus, devfn, fmt, ##arg)
+#define pci_bus_info(bus, devfn, fmt, arg...)	pci_bus_printk(KERN_INFO, bus, devfn, fmt, ##arg)
+
 #endif /* LINUX_PCI_H */
-- 
2.33.0

