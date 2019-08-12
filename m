Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499AA8A122
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 16:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfHLObj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 10:31:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:15933 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfHLObj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 10:31:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 07:31:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="259812957"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 12 Aug 2019 07:31:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 882B42DD; Mon, 12 Aug 2019 17:31:33 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: pciehp: Do not disable interrupt twice on suspend
Date:   Mon, 12 Aug 2019 17:31:32 +0300
Message-Id: <20190812143133.75319-1-mika.westerberg@linux.intel.com>
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
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
Changes from previous version:

  * Move .resume inside CONFIG_PM_SLEEP
  * Added tags from Kai-Heng and Rafael

 drivers/pci/hotplug/pciehp_core.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 6ad0d86762cb..e9f82afa3773 100644
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
 	.resume		= pciehp_resume,
-	.runtime_suspend = pciehp_suspend,
+#endif
+	.runtime_suspend = pciehp_runtime_suspend,
 	.runtime_resume	= pciehp_runtime_resume,
 #endif	/* PM */
 };
-- 
2.20.1

