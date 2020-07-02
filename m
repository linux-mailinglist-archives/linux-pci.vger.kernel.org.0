Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578A2212ADC
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgGBRJC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 13:09:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:38697 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgGBRJC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 13:09:02 -0400
IronPort-SDR: rNF027PcJegIDRqHLM/0u9TQMXsJVkS3BbPnUKn3J7A4/iusvXvO34CoMSlqLV2HOYPkREPwAJ
 hNGnw/3iOUAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="126587467"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="126587467"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:08:56 -0700
IronPort-SDR: WO/SfI6y4eoNHoJ3zr6p+2KfsgDPnGNF4sd0Z/fnGgjsebPNDaGHpBlrvOYBPWOjNMWFBfS4b5
 MRfBHCs9Bhtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="481763184"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2020 10:08:56 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, bhelgaas@google.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jeffrey.t.kirsher@intel.com, olof@lixom.net,
        dan.j.williams@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/7] PCI/portdrv: Create a platform device for the perf uncore driver
Date:   Thu,  2 Jul 2020 10:05:11 -0700
Message-Id: <1593709517-108857-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
References: <1593709517-108857-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

On Snow Ridge server, several performance monitoring counters are added
in the Root Port Configuration Space of CPU Complex PCIe Root Ports A,
which can be used to collect the performance data between the PCIe
devices and the components (in M2IOSF) which are responsible for
translating and managing the requests to/from the device. The
performance data is very useful for analyzing the performance of the
PCIe devices.

However, the perf uncore driver cannot be loaded to register a
performance monitoring unit (PMU) for the counters, because the PCIe
Root Ports device already has a bonded driver portdrv_pci.

To enable the uncore PMU support for these counters on the uncore
driver, a new solution should be introduced, which has to meet the
requirements as below:
- must have a reliable way to find the PCIe Root Port device from the
  uncore driver;
- must be able to access the uncore counters of the PCIe Root Port
  device from the uncore driver;
- must support hotplug. When the PCIe Root Port device is removed, the
  uncore driver has to be notified and unregisters the uncore PMU.

A new platform device 'perf_uncore_pcieport' is introduced as part of
the new solution, which can facilitate the enabling of the uncore PMU in
the uncore driver. The new platform device
- is a child device of the PCIe Root Port device. It's allocated when
  the PCIe Root Ports A device is probed. (For SNR, the PMU counters are
  only located in the configuration space of the PCIe Root Ports A.)
- stores its pdev as the private driver data pointer of the PCIe Root
  Ports A. The pdev can be easily retrieved to check the existence of
  the platform device when removing the PCIe Root Ports A.
- is unregistered when the PCIe Root Port A is removed. The remove()
  method which is provided in the uncore driver will be invoked. The
  uncore PMU will be unregistered as well.
- doesn't share any memory and IRQ resources. The uncore driver will
  only touch the PMU counters in the configuration space of the PCIe
  Root Port A.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 drivers/pci/pcie/portdrv_pci.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 3acf151..47e33b2 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/aer.h>
 #include <linux/dmi.h>
+#include <linux/platform_device.h>
 
 #include "../pci.h"
 #include "portdrv.h"
@@ -90,6 +91,40 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 #define PCIE_PORTDRV_PM_OPS	NULL
 #endif /* !PM */
 
+static const struct pci_device_id perf_uncore_pcieport_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x334a) },
+	{ },
+};
+
+static void perf_platform_device_register(struct pci_dev *dev)
+{
+	struct platform_device *pdev;
+
+	if (!pci_match_id(perf_uncore_pcieport_ids, dev))
+		return;
+
+	pdev = platform_device_alloc("perf_uncore_pcieport", PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return;
+
+	pdev->dev.parent = &dev->dev;
+
+	if (platform_device_add(pdev)) {
+		platform_device_put(pdev);
+		return;
+	}
+
+	pci_set_drvdata(dev, pdev);
+}
+
+static void perf_platform_device_unregister(struct pci_dev *dev)
+{
+	struct platform_device *pdev = pci_get_drvdata(dev);
+
+	if (pdev)
+		platform_device_unregister(pdev);
+}
+
 /*
  * pcie_portdrv_probe - Probe PCI-Express port devices
  * @dev: PCI-Express port device being probed
@@ -113,6 +148,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	if (status)
 		return status;
 
+	perf_platform_device_register(dev);
+
 	pci_save_state(dev);
 
 	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
@@ -142,6 +179,7 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 		pm_runtime_dont_use_autosuspend(&dev->dev);
 	}
 
+	perf_platform_device_unregister(dev);
 	pcie_port_device_remove(dev);
 }
 
-- 
2.7.4

