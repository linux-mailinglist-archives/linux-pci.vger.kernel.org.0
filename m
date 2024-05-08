Return-Path: <linux-pci+bounces-7248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B188BFF79
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20901F2B5E3
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E115685929;
	Wed,  8 May 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEJ9ttr0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D30579DDB;
	Wed,  8 May 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176173; cv=none; b=SBruxX8BJXhi5N8MgLD+zvWZ+SoUGDzLtnHSl9CU69qLTaLZ7WGMlZwv7DVB7+3mUpEF1AeFY2T1by+Oe9qg2gOq0PK8Nnr663QmjTUQvTeZYuwx93Git1qAtIL/f0e1Db+vc1LiEQWk8195MUl4hmEC8kRXB6YQTPwmDSYqH0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176173; c=relaxed/simple;
	bh=44LUioKVyxVSs/VwnYY9a2YeasH0Z8yoMUSiqQozluA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjxoI1LKnyGP1D/Xpxe9vH38f4J7NOrsdJOWhwzMr+VVmf6z3+UlN7CEi625MBN2X2UR6hzWxXlH8X9fyZUThy23YvtJjj2iUhR/3kGhHtNTQhW4bOKmnJVKAnW46X2WP6FldHBBiOYqhD/0kV+CzGwNVhaiXoW2vn18s4Vxw4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEJ9ttr0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715176172; x=1746712172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=44LUioKVyxVSs/VwnYY9a2YeasH0Z8yoMUSiqQozluA=;
  b=TEJ9ttr0qppyqRaTMX74ubvUcug6HIZalk5jus9o5JDBJ3muhvKoNgMa
   zFK/T6JEpH0ty9/ElTT0zlrAlkLWUmn+scvuMXUQ4JbbHPTuB310qRYw1
   /H3nnCKAIAnn4xH4AmwDwmw10CNQlcvDU9sraDJmhVau2krSxiZVFVVwM
   EluEHYlXJLOvcmdDjFX0w6ZiqyOMwCy5M8a36a/tGke+5sTKIQ7hqarxL
   C+HdS7rcC7hqpfaeO9kbZ2ZpHMYUuxiVzEFM4Z9MrUGXgHHA+VltzUrim
   qn3E2t+ueUhXid+hnmvYQkDSnNiHuWs47KPYwgEtQdN1bmmhBbkuyZpH/
   Q==;
X-CSE-ConnectionGUID: hkLXEK3iSwyoW5aFXoFRfg==
X-CSE-MsgGUID: LMgyhiaQSxeyS848Ec6J+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10906662"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10906662"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:49:32 -0700
X-CSE-ConnectionGUID: /Z3vJd8FSluqSNlmtgcIYg==
X-CSE-MsgGUID: nTwDswqaR1iF6A+wJvklbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28855368"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.80])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:49:25 -0700
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
Cc: Amit Kucheria <amitk@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v5 7/8] thermal: Add PCIe cooling driver
Date: Wed,  8 May 2024 16:47:43 +0300
Message-Id: <20240508134744.52134-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508134744.52134-1-ilpo.jarvinen@linux.intel.com>
References: <20240508134744.52134-1-ilpo.jarvinen@linux.intel.com>
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
 MAINTAINERS                    |  2 +
 drivers/pci/pcie/bwctrl.c      |  8 ++++
 drivers/thermal/Kconfig        | 10 ++++
 drivers/thermal/Makefile       |  2 +
 drivers/thermal/pcie_cooling.c | 84 ++++++++++++++++++++++++++++++++++
 include/linux/pci-bwctrl.h     | 28 ++++++++++++
 6 files changed, 134 insertions(+)
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
index e97665848158..5d1df9e6a349 100644
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
@@ -287,6 +290,8 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 	pcie_bwnotif_enable(srv);
 	pci_info(port, "enabled with IRQ %d\n", srv->irq);
 
+	port->link_bwctrl->cdev = pcie_cooling_device_register(port);
+
 	return 0;
 }
 
@@ -294,6 +299,9 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
 {
 	struct pcie_bwctrl_data *data = get_service_data(srv);
 
+	if (data->cdev)
+		pcie_cooling_device_unregister(data->cdev);
+
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
index 000000000000..367290d57e99
--- /dev/null
+++ b/drivers/thermal/pcie_cooling.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe cooling device
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+
+#include <linux/build_bug.h>
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
+	struct thermal_cooling_device *cdev;
+	char *name;
+
+	name = kasprintf(GFP_KERNEL, COOLING_DEV_TYPE_PREFIX "%s", pci_name(port));
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	cdev = thermal_cooling_device_register(name, port, &pcie_cooling_ops);
+	kfree(name);
+
+	return cdev;
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


