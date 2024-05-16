Return-Path: <linux-pci+bounces-7562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD2B8C73E4
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 11:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714191C232DA
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA22914375A;
	Thu, 16 May 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eU9RSQ2I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8E1144317;
	Thu, 16 May 2024 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852048; cv=none; b=N/8N9HklFbAzyWsYy7P51VZp6t6d6XN+JjvGxHK8YkmoNUcUJfeDSIPIjU1LOisLtV9cCyvn1fUFJQA3qXry2qRagatTWqh9MdeGG3MhsMCSou1xvJCSbtJcwqwk+GqWaDkN4P0enVMM55WfKnc42A6IU655ymwM2qmZOkHD3jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852048; c=relaxed/simple;
	bh=ZzbyjOkJxa4z/Qz3gvuL/n1sfN3XgXLqmsGCeM2kmMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkGsCqeqKmdtJP/zzQCOZcmgP5XolPQ/BrHcNa3ztkRzf+Cm+hBixZuPD5azApBbyPS9HaBFqOMhhHpXUVgkp22NxQRpKMrmVcHiJ2YD0y1/p0Y9q26a/XybR6sG9yE/C+SESUYhF+BLFpDNkyHTHs0xrnu0hdHumxAV7e2IKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eU9RSQ2I; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715852047; x=1747388047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZzbyjOkJxa4z/Qz3gvuL/n1sfN3XgXLqmsGCeM2kmMA=;
  b=eU9RSQ2InCOPXzKEcHhcJ6DPtQUEER2KQhZI9inA7nj8Hs59Vv1bsQ5/
   5PBAHeKl8+xYdUpZisSMYL3UowhOYPTzmL9xxY9Hj/WHMwy0KUlgyxMx8
   7AiFJoC6vePC1+TS0Xvh39duYEo8g29tW2phVDhur18F9YmtIy+rGML21
   UyX3sMhGr5iG6RVCoca5yEfdmzwC3ji+NienZqVROS7aJoA27EcDCRbAa
   lbBLBduF0c22FzlCwMSEF/TYP4+3pdf64bEZ+oXUok7Ju+KtNsWrPl32M
   /WGp5H+BkWxPu5uBKokctDKDbNT2h4WnVntpLNQtTb3wBjog0JWXcZxzb
   g==;
X-CSE-ConnectionGUID: 2sUCxSqgTk2uaMaCRdto8w==
X-CSE-MsgGUID: ZUMqAZXbQcKyd1bWNsC1rQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23355048"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="23355048"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 02:34:06 -0700
X-CSE-ConnectionGUID: Kmjrx8OOTOq3nPI0Raxxmw==
X-CSE-MsgGUID: FWOAUXICTqyh4+ctSk8Tgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31372502"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 02:34:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org
Cc: Amit Kucheria <amitk@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 7/8] thermal: Add PCIe cooling driver
Date: Thu, 16 May 2024 12:32:21 +0300
Message-Id: <20240516093222.1684-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240516093222.1684-1-ilpo.jarvinen@linux.intel.com>
References: <20240516093222.1684-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a thermal cooling driver to provide path to access PCIe bandwidth
controller using the usual thermal interfaces.

A cooling device is instantiated for controllable PCIe Ports from the
bwctrl service driver.

If registering the cooling device fails, allow bwctrl's probe to
succeed regardless. As cdev in that case contains IS_ERR() pseudo
"pointer", clean that up inside the probe function so the remove side
doesn't need to suddenly make an odd looking IS_ERR() check.

The thermal side state 0 means no throttling, i.e., maximum supported
PCIe Link Speed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org> # From the cooling device interface perspective
---
 MAINTAINERS                    |  2 +
 drivers/pci/pcie/bwctrl.c      | 11 +++++
 drivers/thermal/Kconfig        | 10 +++++
 drivers/thermal/Makefile       |  2 +
 drivers/thermal/pcie_cooling.c | 80 ++++++++++++++++++++++++++++++++++
 include/linux/pci-bwctrl.h     | 28 ++++++++++++
 6 files changed, 133 insertions(+)
 create mode 100644 drivers/thermal/pcie_cooling.c
 create mode 100644 include/linux/pci-bwctrl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bd420cb09821..3a94ae81b13f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17104,6 +17104,8 @@ M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	drivers/pci/pcie/bwctrl.c
+F:	drivers/thermal/pcie_cooling.c
+F:	include/linux/pci-bwctrl.h
 
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index c44da36ef81a..c1d0ccbcc3ab 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-bwctrl.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -38,10 +39,12 @@
  * struct pcie_bwctrl_data - PCIe bandwidth controller
  * @set_speed_mutex:	Serializes link speed changes
  * @lbms_count:		Count for LBMS (since last reset)
+ * @cdev:		thermal cooling device associated with the port
  */
 struct pcie_bwctrl_data {
 	struct mutex set_speed_mutex;
 	atomic_t lbms_count;
+	struct thermal_cooling_device *cdev;
 };
 
 static bool pcie_valid_speed(enum pci_bus_speed speed)
@@ -290,6 +293,11 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 
 	pci_dbg(port, "enabled with IRQ %d\n", srv->irq);
 
+	/* Don't fail on errors. Don't leave IS_ERR() "pointer" into ->cdev */
+	port->link_bwctrl->cdev = pcie_cooling_device_register(port);
+	if (IS_ERR(port->link_bwctrl->cdev))
+		port->link_bwctrl->cdev = NULL;
+
 	return 0;
 }
 
@@ -297,6 +305,9 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
 {
 	struct pcie_bwctrl_data *data = get_service_data(srv);
 
+	if (data->cdev)
+		pcie_cooling_device_unregister(data->cdev);
+
 	pcie_bwnotif_disable(srv->port);
 	scoped_guard(rwsem_write, &pcie_bwctrl_remove_rwsem)
 		srv->port->link_bwctrl = NULL;
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 204ed89a3ec9..7ddc44be4701 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -211,6 +211,16 @@ config DEVFREQ_THERMAL
 
 	  If you want this support, you should say Y here.
 
+config PCIE_THERMAL
+	bool "PCIe cooling support"
+	depends on PCIEPORTBUS
+	select PCIE_BWCTRL
+	help
+	  This implements PCIe cooling mechanism through bandwidth reduction
+	  for PCIe devices.
+
+	  If you want this support, you should say Y here.
+
 config THERMAL_EMULATION
 	bool "Thermal emulation mode support"
 	help
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 5cdf7d68687f..5b9bf8e80eb6 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -31,6 +31,8 @@ thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
 # devfreq cooling
 thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
+thermal_sys-$(CONFIG_PCIE_THERMAL) += pcie_cooling.o
+
 obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o k3_j72xx_bandgap.o
 # platform thermal drivers
 obj-y				+= broadcom/
diff --git a/drivers/thermal/pcie_cooling.c b/drivers/thermal/pcie_cooling.c
new file mode 100644
index 000000000000..a876d64f1582
--- /dev/null
+++ b/drivers/thermal/pcie_cooling.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe cooling device
+ *
+ * Copyright (C) 2023-2024 Intel Corporation
+ */
+
+#include <linux/build_bug.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci-bwctrl.h>
+#include <linux/slab.h>
+#include <linux/sprintf.h>
+#include <linux/thermal.h>
+
+#define COOLING_DEV_TYPE_PREFIX		"PCIe_Port_Link_Speed_"
+
+static int pcie_cooling_get_max_level(struct thermal_cooling_device *cdev, unsigned long *state)
+{
+	struct pci_dev *port = cdev->devdata;
+
+	/* cooling state 0 is same as the maximum PCIe speed */
+	*state = port->subordinate->max_bus_speed - PCIE_SPEED_2_5GT;
+
+	return 0;
+}
+
+static int pcie_cooling_get_cur_level(struct thermal_cooling_device *cdev, unsigned long *state)
+{
+	struct pci_dev *port = cdev->devdata;
+
+	/* cooling state 0 is same as the maximum PCIe speed */
+	*state = cdev->max_state - (port->subordinate->cur_bus_speed - PCIE_SPEED_2_5GT);
+
+	return 0;
+}
+
+static int pcie_cooling_set_cur_level(struct thermal_cooling_device *cdev, unsigned long state)
+{
+	struct pci_dev *port = cdev->devdata;
+	enum pci_bus_speed speed;
+
+	/* cooling state 0 is same as the maximum PCIe speed */
+	speed = (cdev->max_state - state) + PCIE_SPEED_2_5GT;
+
+	return pcie_set_target_speed(port, speed, true);
+}
+
+static struct thermal_cooling_device_ops pcie_cooling_ops = {
+	.get_max_state = pcie_cooling_get_max_level,
+	.get_cur_state = pcie_cooling_get_cur_level,
+	.set_cur_state = pcie_cooling_set_cur_level,
+};
+
+struct thermal_cooling_device *pcie_cooling_device_register(struct pci_dev *port)
+{
+	char *name __free(kfree) =
+		kasprintf(GFP_KERNEL, COOLING_DEV_TYPE_PREFIX "%s", pci_name(port));
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	return thermal_cooling_device_register(name, port, &pcie_cooling_ops);
+}
+
+void pcie_cooling_device_unregister(struct thermal_cooling_device *cdev)
+{
+	thermal_cooling_device_unregister(cdev);
+}
+
+/* For bus_speed <-> state arithmetic */
+static_assert(PCIE_SPEED_2_5GT + 1 == PCIE_SPEED_5_0GT);
+static_assert(PCIE_SPEED_5_0GT + 1 == PCIE_SPEED_8_0GT);
+static_assert(PCIE_SPEED_8_0GT + 1 == PCIE_SPEED_16_0GT);
+static_assert(PCIE_SPEED_16_0GT + 1 == PCIE_SPEED_32_0GT);
+static_assert(PCIE_SPEED_32_0GT + 1 == PCIE_SPEED_64_0GT);
+
+MODULE_AUTHOR("Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>");
+MODULE_DESCRIPTION("PCIe cooling driver");
diff --git a/include/linux/pci-bwctrl.h b/include/linux/pci-bwctrl.h
new file mode 100644
index 000000000000..cee07127455b
--- /dev/null
+++ b/include/linux/pci-bwctrl.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * PCIe bandwidth controller
+ *
+ * Copyright (C) 2023-2024 Intel Corporation
+ */
+
+#ifndef LINUX_PCI_BWCTRL_H
+#define LINUX_PCI_BWCTRL_H
+
+#include <linux/pci.h>
+
+struct thermal_cooling_device;
+
+#ifdef CONFIG_PCIE_THERMAL
+struct thermal_cooling_device *pcie_cooling_device_register(struct pci_dev *port);
+void pcie_cooling_device_unregister(struct thermal_cooling_device *cdev);
+#else
+static inline struct thermal_cooling_device *pcie_cooling_device_register(struct pci_dev *port)
+{
+	return NULL;
+}
+static inline void pcie_cooling_device_unregister(struct thermal_cooling_device *cdev)
+{
+}
+#endif
+
+#endif
-- 
2.39.2


