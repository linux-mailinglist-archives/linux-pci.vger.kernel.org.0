Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60BA018B7D
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEIOPy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfEIOPR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 10:15:17 -0400
Received: from localhost (50-81-63-4.client.mchsi.com [50.81.63.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C102177B;
        Thu,  9 May 2019 14:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557411316;
        bh=u6q0Pg2OL3Py+IxHhJLbr82hQI5NOVhVXSbkc/oe1uQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYFroVDZauLesCkfkIsha6zyux2eyZYbGxVIXnMwELns5SdAWkCVxkDKrxn8eCL6/
         S+t/QFge7JZwaEFlETzcbRt1FBYXKpdsbEbWymOAZDetqU9VNYOHpLbeUym+GIhkZ2
         HbdDPcKfpqlF9EUYBnPrlqJpSvBMMa8wV9kK1P1s=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 07/10] PCI: pciehp: Log messages with pci_dev, not pcie_device
Date:   Thu,  9 May 2019 09:14:53 -0500
Message-Id: <20190509141456.223614-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509141456.223614-1-helgaas@kernel.org>
References: <20190509141456.223614-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frederick Lawler <fred@fredlawl.com>

Log messages with pci_dev, not pcie_device.  Factor out common message
prefixes with dev_fmt().

Example output change:

  - pciehp 0000:00:06.0:pcie004: Slot(0) Powering on due to button press
  + pcieport 0000:00:06.0: pciehp: Slot(0) Powering on due to button press

Link: https://lore.kernel.org/lkml/20190503035946.23608-7-fred@fredlawl.com
Signed-off-by: Frederick Lawler <fred@fredlawl.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h      | 16 ++++++++--------
 drivers/pci/hotplug/pciehp_core.c |  7 +++++--
 drivers/pci/hotplug/pciehp_ctrl.c |  2 ++
 drivers/pci/hotplug/pciehp_hpc.c  |  2 ++
 drivers/pci/hotplug/pciehp_pci.c  |  2 ++
 5 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index af5d9f92e6d5..2f0295b48d5d 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -35,22 +35,22 @@ extern int pciehp_poll_time;
  * enable debug messages.
  */
 #define dbg(format, arg...)						\
-	pr_debug("%s: " format, MY_NAME, ## arg);
+	pr_debug(format, ## arg);
 #define err(format, arg...)						\
-	printk(KERN_ERR "%s: " format, MY_NAME, ## arg)
+	pr_err(format, ## arg)
 #define info(format, arg...)						\
-	printk(KERN_INFO "%s: " format, MY_NAME, ## arg)
+	pr_info(format, ## arg)
 #define warn(format, arg...)						\
-	printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)
+	pr_warn(format, ## arg)
 
 #define ctrl_dbg(ctrl, format, arg...)					\
-	dev_dbg(&ctrl->pcie->device, format, ## arg)
+	pci_dbg(ctrl->pcie->port, format, ## arg)
 #define ctrl_err(ctrl, format, arg...)					\
-	dev_err(&ctrl->pcie->device, format, ## arg)
+	pci_err(ctrl->pcie->port, format, ## arg)
 #define ctrl_info(ctrl, format, arg...)					\
-	dev_info(&ctrl->pcie->device, format, ## arg)
+	pci_info(ctrl->pcie->port, format, ## arg)
 #define ctrl_warn(ctrl, format, arg...)					\
-	dev_warn(&ctrl->pcie->device, format, ## arg)
+	pci_warn(ctrl->pcie->port, format, ## arg)
 
 #define SLOT_NAME_SIZE 10
 
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 6ff204c435bf..b85b22880c50 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -17,6 +17,9 @@
  *   Dely Sy <dely.l.sy@intel.com>"
  */
 
+#define pr_fmt(fmt) "pciehp: " fmt
+#define dev_fmt pr_fmt
+
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -179,14 +182,14 @@ static int pciehp_probe(struct pcie_device *dev)
 
 	if (!dev->port->subordinate) {
 		/* Can happen if we run out of bus numbers during probe */
-		dev_err(&dev->device,
+		pci_err(dev->port,
 			"Hotplug bridge without secondary bus, ignoring\n");
 		return -ENODEV;
 	}
 
 	ctrl = pcie_init(dev);
 	if (!ctrl) {
-		dev_err(&dev->device, "Controller initialization failed\n");
+		pci_err(dev->port, "Controller initialization failed\n");
 		return -ENODEV;
 	}
 	set_service_data(dev, ctrl);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 3f3df4c29f6e..bf81f977a751 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -13,6 +13,8 @@
  *
  */
 
+#define dev_fmt(fmt) "pciehp: " fmt
+
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index e121f1c06c21..913c7e66504f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -12,6 +12,8 @@
  * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
  */
 
+#define dev_fmt(fmt) "pciehp: " fmt
+
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/jiffies.h>
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index b9c1396db6fe..d17f3bf36f70 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -13,6 +13,8 @@
  *
  */
 
+#define dev_fmt(fmt) "pciehp: " fmt
+
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-- 
2.21.0.1020.gf2820cf01a-goog

