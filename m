Return-Path: <linux-pci+bounces-1715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3908252D9
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 12:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC44B24B0F
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742FD28E17;
	Fri,  5 Jan 2024 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cE+MrRpG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84E42D604;
	Fri,  5 Jan 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704454051; x=1735990051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4XhcGmmYjn0I6IWJn/zmvmCpFHXqHm+/LLv5Dqbi2Nw=;
  b=cE+MrRpG8JdYmytRJMw5pz1lC9JeCwONhmdd9Cgzd0HfFjNSwXgcVl53
   Ft0ur/wIbr6mRzIIYIcGpHVqrI/LEuQGmaV+eziJeTQuioSwMyFwy0LaC
   e+DtN49v2eYkdEG7E/zzbRv+nDIETS1dxi1hYSp9z+7p7HiJFvLq2PMFq
   Spq5CMl7exUn8BN4vZvr9UuZPus79s3TOcQasm5P9TGNSTOCgQVffy5SY
   CcZdcGC/WUtwXunUpy4IX7Ss1LEkqoMsfbj9Jziuof/uz15sWVxkK2ZQ4
   +y2pG0OTrTUQpNra+xqvs2oHsG9AaHVU3Gy3WRa8bxyaevTR6wU5Js9hH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="10858546"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="10858546"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 03:27:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="773827916"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="773827916"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.38])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 03:27:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
	Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 7/8] thermal: Add PCIe cooling driver
Date: Fri,  5 Jan 2024 13:25:46 +0200
Message-Id: <20240105112547.7301-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105112547.7301-1-ilpo.jarvinen@linux.intel.com>
References: <20240105112547.7301-1-ilpo.jarvinen@linux.intel.com>
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

The thermal side state 0 means no throttling, i.e., maximum supported
PCIe Link Speed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org> # From the cooling device interface perspective
---
 MAINTAINERS                    |   1 +
 drivers/pci/pcie/bwctrl.c      |   6 ++
 drivers/thermal/Kconfig        |  10 +++
 drivers/thermal/Makefile       |   2 +
 drivers/thermal/pcie_cooling.c | 107 +++++++++++++++++++++++++++++++++
 include/linux/pci-bwctrl.h     |  16 +++++
 6 files changed, 142 insertions(+)
 create mode 100644 drivers/thermal/pcie_cooling.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ccc5d50bf340..0cacc7e777c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16771,6 +16771,7 @@ M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	drivers/pci/pcie/bwctrl.c
+F:	drivers/thermal/pcie_cooling.c
 F:	include/linux/pci-bwctrl.h
 
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index e17c98c25f06..6c50fabfea39 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -35,9 +35,11 @@
 /**
  * struct pcie_bwctrl_service_data - PCIe bandwidth controller
  * @set_speed_mutex: serializes link speed changes
+ * @cdev: thermal cooling device associated with the port
  */
 struct pcie_bwctrl_service_data {
 	struct mutex set_speed_mutex;
+	struct thermal_cooling_device *cdev;
 };
 
 static bool pcie_valid_speed(enum pci_bus_speed speed)
@@ -224,6 +226,8 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 	pcie_bwnotif_enable(port);
 	pci_info(port, "enabled with IRQ %d\n", srv->irq);
 
+	data->cdev = pcie_cooling_device_register(port, srv);
+
 	return 0;
 }
 
@@ -231,6 +235,8 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
 {
 	struct pcie_bwctrl_service_data *data = get_service_data(srv);
 
+	if (data->cdev)
+		pcie_cooling_device_unregister(data->cdev);
 	pcie_bwnotif_disable(srv->port);
 	mutex_destroy(&data->set_speed_mutex);
 }
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c81a00fbca7d..3a071396f1c6 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -219,6 +219,16 @@ config DEVFREQ_THERMAL
 
 	  If you want this support, you should say Y here.
 
+config PCIE_THERMAL
+	bool "PCIe cooling support"
+	depends on PCIEPORTBUS
+	select PCIE_BW
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
index c934cab309ae..a0b25a2742b7 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -30,6 +30,8 @@ thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
 # devfreq cooling
 thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
+thermal_sys-$(CONFIG_PCIE_THERMAL) += pcie_cooling.o
+
 obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o k3_j72xx_bandgap.o
 # platform thermal drivers
 obj-y				+= broadcom/
diff --git a/drivers/thermal/pcie_cooling.c b/drivers/thermal/pcie_cooling.c
new file mode 100644
index 000000000000..5fc52d410161
--- /dev/null
+++ b/drivers/thermal/pcie_cooling.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe cooling device
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+
+#include <linux/build_bug.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci-bwctrl.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/thermal.h>
+
+#define COOLING_DEV_TYPE_PREFIX		"PCIe_Port_Link_Speed_"
+
+struct pcie_cooling_device {
+	struct pci_dev *port;
+	struct pcie_device *pdev;
+};
+
+static int pcie_cooling_get_max_level(struct thermal_cooling_device *cdev, unsigned long *state)
+{
+	struct pcie_cooling_device *pcie_cdev = cdev->devdata;
+
+	/* cooling state 0 is same as the maximum PCIe speed */
+	*state = pcie_cdev->port->subordinate->max_bus_speed - PCIE_SPEED_2_5GT;
+
+	return 0;
+}
+
+static int pcie_cooling_get_cur_level(struct thermal_cooling_device *cdev, unsigned long *state)
+{
+	struct pcie_cooling_device *pcie_cdev = cdev->devdata;
+
+	/* cooling state 0 is same as the maximum PCIe speed */
+	*state = cdev->max_state -
+		 (pcie_cdev->port->subordinate->cur_bus_speed - PCIE_SPEED_2_5GT);
+
+	return 0;
+}
+
+static int pcie_cooling_set_cur_level(struct thermal_cooling_device *cdev, unsigned long state)
+{
+	struct pcie_cooling_device *pcie_cdev = cdev->devdata;
+	enum pci_bus_speed speed;
+
+	/* cooling state 0 is same as the maximum PCIe speed */
+	speed = (cdev->max_state - state) + PCIE_SPEED_2_5GT;
+
+	return pcie_bwctrl_set_current_speed(pcie_cdev->pdev, speed);
+}
+
+static struct thermal_cooling_device_ops pcie_cooling_ops = {
+	.get_max_state = pcie_cooling_get_max_level,
+	.get_cur_state = pcie_cooling_get_cur_level,
+	.set_cur_state = pcie_cooling_set_cur_level,
+};
+
+struct thermal_cooling_device *pcie_cooling_device_register(struct pci_dev *port,
+							    struct pcie_device *pdev)
+{
+	struct pcie_cooling_device *pcie_cdev;
+	struct thermal_cooling_device *cdev;
+	size_t name_len;
+	char *name;
+
+	pcie_cdev = kzalloc(sizeof(*pcie_cdev), GFP_KERNEL);
+	if (!pcie_cdev)
+		return ERR_PTR(-ENOMEM);
+
+	pcie_cdev->port = port;
+	pcie_cdev->pdev = pdev;
+
+	name_len = strlen(COOLING_DEV_TYPE_PREFIX) + strlen(pci_name(port)) + 1;
+	name = kzalloc(name_len, GFP_KERNEL);
+	if (!name) {
+		kfree(pcie_cdev);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	snprintf(name, name_len, COOLING_DEV_TYPE_PREFIX "%s", pci_name(port));
+	cdev = thermal_cooling_device_register(name, pcie_cdev, &pcie_cooling_ops);
+	kfree(name);
+
+	return cdev;
+}
+
+void pcie_cooling_device_unregister(struct thermal_cooling_device *cdev)
+{
+	struct pcie_cooling_device *pcie_cdev = cdev->devdata;
+
+	thermal_cooling_device_unregister(cdev);
+	kfree(pcie_cdev);
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
index be51f6f2b340..ec5b1c3515d8 100644
--- a/include/linux/pci-bwctrl.h
+++ b/include/linux/pci-bwctrl.h
@@ -11,7 +11,23 @@
 #include <linux/pci.h>
 
 struct pcie_device;
+struct thermal_cooling_device;
 
 int pcie_bwctrl_set_current_speed(struct pcie_device *srv, enum pci_bus_speed speed_req);
 
+#ifdef CONFIG_PCIE_THERMAL
+struct thermal_cooling_device *pcie_cooling_device_register(struct pci_dev *port,
+							    struct pcie_device *pdev);
+void pcie_cooling_device_unregister(struct thermal_cooling_device *cdev);
+#else
+static inline struct thermal_cooling_device *pcie_cooling_device_register(struct pci_dev *port,
+									  struct pcie_device *pdev)
+{
+	return NULL;
+}
+static inline void pcie_cooling_device_unregister(struct thermal_cooling_device *cdev)
+{
+}
+#endif
+
 #endif
-- 
2.39.2


