Return-Path: <linux-pci+bounces-14062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4024E99661B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 11:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E3F1F26E9A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 09:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBEA191F7E;
	Wed,  9 Oct 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJ4V4K4s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E3191F6C;
	Wed,  9 Oct 2024 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467638; cv=none; b=l/Xx9eeZUNZTYvJtJSTPydGWPQKbJvO5jHwjOQ66JcmQbKEycPLhyqOh4yUogm3iZLAZUZcQq4izrM4NPwL/kYX8pqStoakJ7IWNyY+VI8PVaHWoJEUvFnwJ/1yfdlDFMiqMhvRskju90J1VIPzhlhGrCmuW74tB/3g5oPNLfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467638; c=relaxed/simple;
	bh=LM7i2cl88tcJ9qDRwbvRv+sh9p8GwXv5HWO5j2jh4Cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEnZwLUiksGxJbKBBk4vkkpRCTfAMGBMKusFE+IKyCIdjkFZMSne+KJ3gGP++samtUHAioOj7o71QT7spIkSib6jVQhbYsohxFW2+7dcQioNSFENHCxCUekgWAKijP3l7k3tQk8iFZcwgzXDlMn1P3jZevvQXReIsBWsMeyM4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJ4V4K4s; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728467637; x=1760003637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LM7i2cl88tcJ9qDRwbvRv+sh9p8GwXv5HWO5j2jh4Cw=;
  b=PJ4V4K4sktPLjHylhj+w91/iosF/Z83zcP8IotN2AdNmeOxd4ivLnDL1
   ED18Lk+y1AH3KV+ROy8bcMZnoYSPQNNu/SlK7GpoLJou0qBUG9SC/ERYG
   lEvepnbf7R+YzyAA4eqvxWnAoNqOIKhv20lyiV2WTaOhydj8Hh/mY4AkB
   J/87n4ZSky1KFd3wuKiKhjiwZFSD4JcyG/kxR1L6zhSJGVIKOX5yt4auX
   BVxLYyv3KLEe0a2O81MWcZ6ILJf3/nTzDCZBTmm8nsaXkZjHUQVjDj2C5
   aoQWK9bP6r2ygC1uCCKnTNeVy3mzy8OWZSqY4dQHQ51qAMC8czFWD+0WV
   A==;
X-CSE-ConnectionGUID: bFRSffTARsGptsx8pqv6FA==
X-CSE-MsgGUID: Qunu6WTZQU2gB8j4oTiMHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="50291937"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="50291937"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:53:56 -0700
X-CSE-ConnectionGUID: 5moOZGwVR9uqZSYZK/X9dg==
X-CSE-MsgGUID: irKuw6jGQZO05CkweVIHzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76640519"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:53:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: [PATCH v8 7/8] thermal: Add PCIe cooling driver
Date: Wed,  9 Oct 2024 12:52:22 +0300
Message-Id: <20241009095223.7093-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
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
 drivers/thermal/Kconfig        |  9 ++++
 drivers/thermal/Makefile       |  2 +
 drivers/thermal/pcie_cooling.c | 80 ++++++++++++++++++++++++++++++++++
 include/linux/pci-bwctrl.h     | 28 ++++++++++++
 6 files changed, 132 insertions(+)
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
index 1d3680ea8e06..0f686a2e636f 100644
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
 
 /* Prevents port removal during link speed changes and LBMS count accessors */
@@ -303,6 +306,11 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 
 	pci_dbg(port, "enabled with IRQ %d\n", srv->irq);
 
+	/* Don't fail on errors. Don't leave IS_ERR() "pointer" into ->cdev */
+	port->link_bwctrl->cdev = pcie_cooling_device_register(port);
+	if (IS_ERR(port->link_bwctrl->cdev))
+		port->link_bwctrl->cdev = NULL;
+
 	return 0;
 }
 
@@ -310,6 +318,9 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
 {
 	struct pcie_bwctrl_data *data = get_service_data(srv);
 
+	if (data->cdev)
+		pcie_cooling_device_unregister(data->cdev);
+
 	pcie_bwnotif_disable(srv->port);
 	scoped_guard(rwsem_write, &pcie_bwctrl_remove_rwsem)
 		srv->port->link_bwctrl = NULL;
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


