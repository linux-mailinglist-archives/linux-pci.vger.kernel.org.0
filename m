Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8841D4A121
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 14:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfFRMuz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 08:50:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:45248 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfFRMuz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jun 2019 08:50:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 05:50:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,389,1557212400"; 
   d="scan'208";a="161736527"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2019 05:50:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 6AD4C179; Tue, 18 Jun 2019 15:50:51 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: pciehp: Do not disable interrupt twice on suspend
Date:   Tue, 18 Jun 2019 15:50:50 +0300
Message-Id: <20190618125051.2382-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We try to keep PCIe hotplug ports runtime suspended when entering system
suspend. Due to the fact that the PCIe portdrv sets NEVER_SKIP driver PM
flag the PM core always calls system suspend/resume hooks even if the
device is left runtime suspended. Since PCIe hotplug driver re-uses the
same function for both it ends up disabling hotplug interrupt twice and
the second time following is printed:

  pciehp 0000:03:01.0:pcie204: pcie_do_write_cmd: no response from device

Prevent this from happening by checking whether the device is already
runtime suspended when system suspend hook is called.

Fixes: 9c62f0bfb832 ("PCI: pciehp: Implement runtime PM callbacks")
Reported-by: Kai Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_core.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 6ad0d86762cb..3f8c13ddb3e8 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -248,7 +248,7 @@ static bool pme_is_native(struct pcie_device *dev)
 	return pcie_ports_native || host->native_pme;
 }
 
-static int pciehp_suspend(struct pcie_device *dev)
+static void pciehp_disable_interrupt(struct pcie_device *dev)
 {
 	/*
 	 * Disable hotplug interrupt so that it does not trigger
@@ -256,7 +256,19 @@ static int pciehp_suspend(struct pcie_device *dev)
 	 */
 	if (pme_is_native(dev))
 		pcie_disable_interrupt(get_service_data(dev));
+}
 
+#ifdef CONFIG_PM_SLEEP
+static int pciehp_suspend(struct pcie_device *dev)
+{
+	/*
+	 * If the port is already runtime suspended we can keep it that
+	 * way.
+	 */
+	if (dev_pm_smart_suspend_and_suspended(&dev->port->dev))
+		return 0;
+
+	pciehp_disable_interrupt(dev);
 	return 0;
 }
 
@@ -274,6 +286,7 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
 
 	return 0;
 }
+#endif
 
 static int pciehp_resume(struct pcie_device *dev)
 {
@@ -287,6 +300,12 @@ static int pciehp_resume(struct pcie_device *dev)
 	return 0;
 }
 
+static int pciehp_runtime_suspend(struct pcie_device *dev)
+{
+	pciehp_disable_interrupt(dev);
+	return 0;
+}
+
 static int pciehp_runtime_resume(struct pcie_device *dev)
 {
 	struct controller *ctrl = get_service_data(dev);
@@ -313,10 +332,12 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
 	.remove		= pciehp_remove,
 
 #ifdef	CONFIG_PM
+#ifdef	CONFIG_PM_SLEEP
 	.suspend	= pciehp_suspend,
 	.resume_noirq	= pciehp_resume_noirq,
+#endif
 	.resume		= pciehp_resume,
-	.runtime_suspend = pciehp_suspend,
+	.runtime_suspend = pciehp_runtime_suspend,
 	.runtime_resume	= pciehp_runtime_resume,
 #endif	/* PM */
 };
-- 
2.20.1

