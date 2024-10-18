Return-Path: <linux-pci+bounces-14871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB749A41B4
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 16:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA54628A28A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B622022E1;
	Fri, 18 Oct 2024 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOsDBrCW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4534420127F;
	Fri, 18 Oct 2024 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262996; cv=none; b=n8a6I1RzLpTylUwS8UVEcby21rypSpZpQqv+s1rw6IQiNUxT1NYK8yiutquHKMTdek6976GH/Y2AedwIXzLuaS8Kj6gevtX07jQmQWsrRgztF+BTC3wg8nW5VmP88upXRQydcnueGKeKXsUOsjpOvpDgR/Y51cgIEBBVqXfvrkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262996; c=relaxed/simple;
	bh=p1ngU8DgzAsjEcJJauS+Sxm0jeX5ORDY++TfpEqLsjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTaYMy/wsqlzX55xHBojc228lRx94ZFj5gTAcAwtZSrw8NJqcL6msth+5RQhEZq7QqlpFA1ddPO6+s6d5GflQ2d/my+pA61dbsSlWr4Xa6vzqhEr2nJ/xy9lFU7OIiL49qgXwyAEN5VxfqOYFwsTl6lRPxCKF4vN4bRWSI3H3tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOsDBrCW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729262994; x=1760798994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p1ngU8DgzAsjEcJJauS+Sxm0jeX5ORDY++TfpEqLsjc=;
  b=cOsDBrCWf2b8FIUqAydak1Uhs82Wo5qmr0L5+38NDmg1b5vFM1HLoHNE
   olSeZ0QZQorNUZS07Z5IA/L+Q8ZOG4qafeRmlUB1DCPgPP8Ws0E+aYybi
   z2t2SrRmy35gTRUaAXi+x9Y7lhwrdbI9GQBv0R2jW6N6TyUyP7y0yVrO/
   PUOXM+XsGfIiuZDvUiSE/MvOytE+Can/Z4RnQhQ3AlEr/mL1W2dDvkqfX
   +U+Bi4IQLphfgvwVT3WiXdcErUxxvOpwORnAVd9vg2adUSUE7QlSZjm0j
   aSOIj8GoZUHcqNlHjlROWRe18kv2sq2hFfbpnZ83gxU+7c6BEgyL9vkE2
   w==;
X-CSE-ConnectionGUID: /UrwbCrEQ9+YXgPkP602ZQ==
X-CSE-MsgGUID: cGXc5f4mRZCQhFjQ5HKJvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28931121"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="28931121"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:49:53 -0700
X-CSE-ConnectionGUID: EnvSV78QRpSHmHch24go9g==
X-CSE-MsgGUID: bPNB+h+PS5OBJrRtgmpCNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83463645"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:49:46 -0700
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
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org
Cc: Amit Kucheria <amitk@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v9 8/9] thermal: Add PCIe cooling driver
Date: Fri, 18 Oct 2024 17:47:54 +0300
Message-Id: <20241018144755.7875-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
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
 drivers/pci/pcie/bwctrl.c      | 13 ++++++
 drivers/thermal/Kconfig        |  9 ++++
 drivers/thermal/Makefile       |  2 +
 drivers/thermal/pcie_cooling.c | 80 ++++++++++++++++++++++++++++++++++
 include/linux/pci-bwctrl.h     | 28 ++++++++++++
 6 files changed, 134 insertions(+)
 create mode 100644 drivers/thermal/pcie_cooling.c
 create mode 100644 include/linux/pci-bwctrl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c555b3325d6..393ed7ce5ea1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17938,6 +17938,8 @@ M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	drivers/pci/pcie/bwctrl.c
+F:	drivers/thermal/pcie_cooling.c
+F:	include/linux/pci-bwctrl.h
 
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 8a2bd1e887e2..d00675e33ad9 100644
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
 
 /*
@@ -313,11 +316,21 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 
 	pci_dbg(port, "enabled with IRQ %d\n", srv->irq);
 
+	/* Don't fail on errors. Don't leave IS_ERR() "pointer" into ->cdev */
+	port->link_bwctrl->cdev = pcie_cooling_device_register(port);
+	if (IS_ERR(port->link_bwctrl->cdev))
+		port->link_bwctrl->cdev = NULL;
+
 	return 0;
 }
 
 static void pcie_bwnotif_remove(struct pcie_device *srv)
 {
+	struct pcie_bwctrl_data *data = srv->port->link_bwctrl;
+
+	if (data->cdev)
+		pcie_cooling_device_unregister(data->cdev);
+
 	pcie_bwnotif_disable(srv->port);
 
 	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem)
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 61e7ae524b1f..d3f9686e26e7 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -220,6 +220,15 @@ config DEVFREQ_THERMAL
 
 	  If you want this support, you should say Y here.
 
+config PCIE_THERMAL
+	bool "PCIe cooling support"
+	depends on PCIEPORTBUS
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
index 41c4d56beb40..210c16c91461 100644
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
2.39.5


