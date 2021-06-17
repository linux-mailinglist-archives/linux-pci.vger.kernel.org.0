Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681D83ABE73
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 23:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhFQV5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 17:57:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:16702 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231478AbhFQV5u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 17:57:50 -0400
IronPort-SDR: jJFG6EplS3Qd/P5jWLyvnvyipZHmO7uJd6UUHGWgjtpTm3uV/ZSOSENVZfpLhDdWcOi/+whrYd
 U8RbrLmDrw0g==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="270304158"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="270304158"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 14:55:41 -0700
IronPort-SDR: j8KQ4vjUpd30dU+blyQ+FlyTi1wQT9EycJwuWaB8IVlF+u7iOVOse8YyfZcyv3oW4i6/5FICfB
 /VjZiF1O1S0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="637964279"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2021 14:55:41 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id D79D35801CF;
        Thu, 17 Jun 2021 14:55:40 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 3/4] MFD: Intel Out of Band Management Services Module (OOBMSM) driver
Date:   Thu, 17 Jun 2021 14:54:07 -0700
Message-Id: <20210617215408.1412409-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210617215408.1412409-1-david.e.box@linux.intel.com>
References: <20210617215408.1412409-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Intel Out of Band Management Services Module (OOBMSM) is a device
that provides access to Intel capabilities described in PCIE vendor
specific extended capability registers (both VSEC and DVSEC). These
capabilities include features like Intel Platform Monitoring Technology
as well as others that are not supported by the intel_pmt driver. Add a
driver for creating platform devices for these capabilities coming from
OOBMSM.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 MAINTAINERS                  |  1 +
 drivers/mfd/Kconfig          | 11 +++++++
 drivers/mfd/Makefile         |  1 +
 drivers/mfd/intel_oobmsm.c   | 61 ++++++++++++++++++++++++++++++++++++
 drivers/platform/x86/Kconfig |  4 +--
 5 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mfd/intel_oobmsm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ebdc2a0f794b..0961e3f89497 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9356,6 +9356,7 @@ INTEL PMT DRIVER
 M:	"David E. Box" <david.e.box@linux.intel.com>
 S:	Maintained
 F:	drivers/mfd/intel_extended_cap.c
+F:	drivers/mfd/intel_oobmsm.c
 F:	drivers/mfd/intel_pmt.c
 F:	drivers/platform/x86/intel_pmt_*
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4dde8e223a9e..269312de2666 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -687,6 +687,17 @@ config MFD_INTEL_PMT
 	  Telemetry, Watcher, and Crashlog PMT capabilities/devices for
 	  platforms starting from Tiger Lake.
 
+config MFD_INTEL_OOBMSM
+	tristate "Intel Out Of Band Management Services Module (OOBMSM) support"
+	depends on PCI
+	select MFD_INTEL_EXTENDED_CAPS
+	help
+	  The Intel Out of Band Management Service Module driver is used to
+	  enumerate auxiliary platform features described in both Vendor
+	  Specific and Designated Vendor Specific PCIe config space. Supported
+	  features include Intel Platform Monitoring Technology (PMT) as well
+	  as other non-PMT capabilities.
+
 config MFD_IPAQ_MICRO
 	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
 	depends on SA1100_H3100 || SA1100_H3600
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 7fa35399ec76..50fa38810bbd 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -213,6 +213,7 @@ obj-$(CONFIG_MFD_INTEL_EXTENDED_CAPS)	+= intel_extended_caps.o
 obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
 obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
 obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
+obj-$(CONFIG_MFD_INTEL_OOBMSM)	+= intel_oobmsm.o
 obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
 obj-$(CONFIG_MFD_INTEL_PMT)	+= intel_pmt.o
 obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
diff --git a/drivers/mfd/intel_oobmsm.c b/drivers/mfd/intel_oobmsm.c
new file mode 100644
index 000000000000..c66532f11c29
--- /dev/null
+++ b/drivers/mfd/intel_oobmsm.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Out of Band Management Services Module driver
+ *
+ * Copyright (c) 2021, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Author: David E. Box <david.e.box@linux.intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+
+#include "intel_extended_caps.h"
+
+static int intel_oobmsm_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct intel_ext_cap_platform_info *info;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	info = (struct intel_ext_cap_platform_info *)id->driver_data;
+
+	ret = intel_ext_cap_probe(pdev, info);
+	if (ret)
+		return ret;
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
+	return 0;
+}
+
+static void intel_oobmsm_pci_remove(struct pci_dev *pdev)
+{
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+}
+
+#define PCI_DEVICE_ID_INTEL_PMT_OOBMSM	0x09a7
+static const struct pci_device_id intel_oobmsm_pci_ids[] = {
+	{ PCI_DEVICE_DATA(INTEL, PMT_OOBMSM, NULL) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, intel_oobmsm_pci_ids);
+
+static struct pci_driver intel_oobmsm_pci_driver = {
+	.name = "intel-oobmsm",
+	.id_table = intel_oobmsm_pci_ids,
+	.probe = intel_oobmsm_pci_probe,
+	.remove = intel_oobmsm_pci_remove,
+};
+module_pci_driver(intel_oobmsm_pci_driver);
+
+MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
+MODULE_DESCRIPTION("Intel Out of Band Management Services Module driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 60592fb88e7a..4dd3af9f848e 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1226,7 +1226,7 @@ config INTEL_PMT_CLASS
 
 config INTEL_PMT_TELEMETRY
 	tristate "Intel Platform Monitoring Technology (PMT) Telemetry driver"
-	depends on MFD_INTEL_PMT
+	depends on MFD_INTEL_PMT || MFD_INTEL_OOBMSM
 	select INTEL_PMT_CLASS
 	help
 	  The Intel Platform Monitory Technology (PMT) Telemetry driver provides
@@ -1238,7 +1238,7 @@ config INTEL_PMT_TELEMETRY
 
 config INTEL_PMT_CRASHLOG
 	tristate "Intel Platform Monitoring Technology (PMT) Crashlog driver"
-	depends on MFD_INTEL_PMT
+	depends on MFD_INTEL_PMT || MFD_INTEL_OOBMSM
 	select INTEL_PMT_CLASS
 	help
 	  The Intel Platform Monitoring Technology (PMT) crashlog driver provides
-- 
2.25.1

