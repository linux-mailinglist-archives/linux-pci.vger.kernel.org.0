Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82B212AE5
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgGBRJQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 13:09:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:38719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgGBRJF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 13:09:05 -0400
IronPort-SDR: YwNlft0A/TDhjL/pk4GSQy8l6+Xq+t1fET97h/j4xJdgZtGrKqTKAwfzOt2Af04mVKatJJZy7V
 at4TA9D2nQkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="126587522"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="126587522"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:09:03 -0700
IronPort-SDR: GrStkSZ/4wIrIdpVmNQwLLaBKrjlb5VqvtSzabLi4WEovblSOMJW6n0qGhs3Sza2rfGC0KmGpE
 eiwAqZOLZJcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="481763241"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2020 10:09:03 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, bhelgaas@google.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jeffrey.t.kirsher@intel.com, olof@lixom.net,
        dan.j.williams@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6/7] perf/x86/intel/uncore: Generic support for the platform device
Date:   Thu,  2 Jul 2020 10:05:16 -0700
Message-Id: <1593709517-108857-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
References: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some uncore counters may be located in the configuration space of a PCI
device, which already has a bonded driver. Currently, the uncore driver
cannot register a PCI uncore PMU for these counters. Because, to
register a PCI uncore PMU, the uncore driver must be bond to the device.
However, one device can only have one bonded driver.

The PCI device can create a platform device as its child device. The
uncore driver can bind to the platform device instead.

The probe() and remove() methods are implemented to support the platform
device. When probing a platform device, its parent PCI device is
searched in an id table. If a matched device is found, a PMU for the
platform device will be registered, which will be used to monitor its
parents' PCI device. When the parent device is removed, the remove()
method will be triggered, which unregister the PMU.

Other modules' loading/unloading will trigger the loading/unloading of
the platform device, and impact the uncore driver. The potential race
condition can be prevented by the device_lock() of the platform device,
which guarantees the probe(), and remove() are sequential.

The id table varies on different platforms, which will be implemented in
the following platform-specific patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/events/intel/uncore.h | 19 +++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index b702dc3..30fe187 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -12,6 +12,8 @@ struct intel_uncore_type **uncore_mmio_uncores = empty_uncore;
 
 static bool pcidrv_registered;
 struct pci_driver *uncore_pci_driver;
+struct uncore_platform_driver *uncore_platform_driver;
+
 /* pci bus to socket mapping */
 DEFINE_RAW_SPINLOCK(pci2phy_map_lock);
 struct list_head pci2phy_map_head = LIST_HEAD_INIT(pci2phy_map_head);
@@ -1159,6 +1161,42 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 	uncore_pci_pmu_unregister(pmu, box);
 }
 
+static int uncore_platform_probe(struct platform_device *pdev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(pdev->dev.parent);
+	struct intel_uncore_pmu *pmu;
+	int phys_id, die, ret;
+
+	pmu = uncore_find_pmu_by_pci_dev(pci_dev, uncore_platform_driver->pci_ids);
+	if (!pmu)
+		return -ENODEV;
+
+	ret = uncore_pci_get_die_info(pci_dev, &phys_id, &die);
+	if (ret)
+		return ret;
+
+	ret = uncore_pci_pmu_register(pci_dev, pmu->type, pmu, phys_id, die);
+
+	platform_set_drvdata(pdev, pmu->boxes[die]);
+
+	return ret;
+}
+
+static int uncore_platform_remove(struct platform_device *pdev)
+{
+	struct intel_uncore_box *box;
+
+	box = platform_get_drvdata(pdev);
+	if (!box)
+		return 0;
+
+	uncore_pci_pmu_unregister(box->pmu, box);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
 static int __init uncore_pci_init(void)
 {
 	size_t size;
@@ -1183,6 +1221,19 @@ static int __init uncore_pci_init(void)
 		goto errtype;
 
 	pcidrv_registered = true;
+
+	if (uncore_platform_driver) {
+		uncore_platform_driver->driver->probe = uncore_platform_probe;
+		uncore_platform_driver->driver->remove = uncore_platform_remove;
+
+		ret = platform_driver_register(uncore_platform_driver->driver);
+		if (ret) {
+			pr_warn("Failed to register platform driver. "
+				"Disable %s uncore unit.\n",
+				uncore_platform_driver->driver->driver.name);
+			uncore_platform_driver = NULL;
+		}
+	}
 	return 0;
 
 errtype:
@@ -1197,6 +1248,9 @@ static int __init uncore_pci_init(void)
 
 static void uncore_pci_exit(void)
 {
+	if (uncore_platform_driver)
+		platform_driver_unregister(uncore_platform_driver->driver);
+
 	if (pcidrv_registered) {
 		pcidrv_registered = false;
 		pci_unregister_driver(uncore_pci_driver);
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 105fdc6..da4cb36 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -3,6 +3,7 @@
 #include <linux/pci.h>
 #include <asm/apicdef.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/platform_device.h>
 
 #include <linux/perf_event.h>
 #include "../perf_event.h"
@@ -161,6 +162,24 @@ struct uncore_event_desc {
 	const char *config;
 };
 
+/*
+ * A platform device created by other drivers for uncore monitoring
+ * @driver: platform_driver for the platform device
+ * @pci_ids: id_table for supported PCI devices
+ *           Used to compare with the platform device's parent PCI device
+ *
+ * Other drivers may create a platform device for uncore monitoring,
+ * e.g. pcieport driver on SNR. To match the platform device, the probe
+ * function has to compare the platform device's parent PCI device with
+ * pci_ids.
+ */
+struct uncore_platform_driver {
+	struct platform_driver		*driver;
+	const struct pci_device_id	*pci_ids;
+};
+
+extern struct uncore_platform_driver *uncore_platform_driver;
+
 struct freerunning_counters {
 	unsigned int counter_base;
 	unsigned int counter_offset;
-- 
2.7.4

