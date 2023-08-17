Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078EA77F655
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 14:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350760AbjHQMSj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 08:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350754AbjHQMSH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 08:18:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2875CE7C;
        Thu, 17 Aug 2023 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692274685; x=1723810685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C4c6AKUHEkPYgp9NFigxij3BZiIJDVglDccALiQyRUo=;
  b=nOae0Pjq/HFBNZQVHhiPaAjAYkZqcSG6Emxz8QxOMX/DcK/DPKccP0Kc
   F+xSE3fRujZteO1DM0EnupIJVCAUn4wOvNg+BKR4f01TkG6DAUucKFBTu
   1pByBeTGkFC5c2TmMOXRBx1BdQeomxDF80jtyCpXrOOG426GYlmbBM6r+
   qRV9ccqVbBO6nKiaLHLjevyJ1dJ1XLkiAdqI3kHJOy8gvzd1vrv2ZEx7y
   HFnilzvsE8/7Zgs8h7qNuxlh+GjHkG0eJJ5qtHlts9W+vW8B4B3ww1jNE
   yNMZx8GMp83FKlD575SpBi/YXV9bBgYcGW/MxgEYnPdCEfIknmouwYvc2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436696851"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436696851"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:18:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848873185"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="848873185"
Received: from lababeix-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.212.52])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:18:00 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 09/10] thermal: Add PCIe cooling driver
Date:   Thu, 17 Aug 2023 15:17:07 +0300
Message-Id: <20230817121708.53213-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
References: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a thermal cooling driver to provide path to access PCIe bandwidth
controller using the usual thermal interfaces.

A cooling device is instantiated for controllable PCIe ports from the
bwctrl service driver.

The thermal side state 0 means no throttling, i.e., maximum supported
PCIe speed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 MAINTAINERS                    |   1 +
 drivers/pci/pcie/bwctrl.c      |  11 ++++
 drivers/thermal/Kconfig        |  10 +++
 drivers/thermal/Makefile       |   2 +
 drivers/thermal/pcie_cooling.c | 107 +++++++++++++++++++++++++++++++++
 include/linux/pci-bwctrl.h     |  15 +++++
 6 files changed, 146 insertions(+)
 create mode 100644 drivers/thermal/pcie_cooling.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d2eed2883a43..a0b40253fd5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16421,6 +16421,7 @@ PCIE BANDWIDTH CONTROLLER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 S:	Supported
 F:	drivers/pci/pcie/bwctrl.c
+F:	drivers/thermal/pcie_cooling.c
 F:	include/linux/pci-bwctrl.h
 
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index e3172d69476f..13c73546244e 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -34,9 +34,11 @@
 /**
  * struct bwctrl_service_data - PCIe Port Bandwidth Controller
  * @set_speed_mutex: serializes link speed changes
+ * @cdev: thermal cooling device associated with the port
  */
 struct bwctrl_service_data {
 	struct mutex set_speed_mutex;
+	struct thermal_cooling_device *cdev;
 };
 
 static bool bwctrl_valid_pcie_speed(enum pci_bus_speed speed)
@@ -253,8 +255,16 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
 	pcie_enable_link_bandwidth_notification(port);
 	pci_info(port, "enabled with IRQ %d\n", srv->irq);
 
+	data->cdev = pcie_cooling_device_register(port, srv);
+	if (IS_ERR(data->cdev)) {
+		ret = PTR_ERR(data->cdev);
+		goto disable_notifications;
+	}
 	return 0;
 
+disable_notifications:
+	pcie_disable_link_bandwidth_notification(srv->port);
+	kfree(data);
 free_irq:
 	free_irq(srv->irq, srv);
 	return ret;
@@ -264,6 +274,7 @@ static void pcie_bandwidth_notification_remove(struct pcie_device *srv)
 {
 	struct bwctrl_service_data *data = get_service_data(srv);
 
+	pcie_cooling_device_unregister(data->cdev);
 	pcie_disable_link_bandwidth_notification(srv->port);
 	free_irq(srv->irq, srv);
 	mutex_destroy(&data->set_speed_mutex);
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 19a4b33cb564..7deda3a0237d 100644
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
index 058664bc3ec0..065972a08c84 100644
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
index 000000000000..d86265c03e80
--- /dev/null
+++ b/drivers/thermal/pcie_cooling.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe cooling device
+ *
+ * Copyright (C) 2023 Intel Corporation.
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
+#define COOLING_DEV_TYPE_PREFIX		"PCIe_Port_"
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
+	return bwctrl_set_current_speed(pcie_cdev->pdev, speed);
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
index 46026fa25deb..366445517b72 100644
--- a/include/linux/pci-bwctrl.h
+++ b/include/linux/pci-bwctrl.h
@@ -15,4 +15,19 @@ struct thermal_cooling_device;
 
 int bwctrl_set_current_speed(struct pcie_device *srv, enum pci_bus_speed speed);
 
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
2.30.2

