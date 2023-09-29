Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6199F7B31E9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 13:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjI2L7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 07:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjI2L7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 07:59:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AB01BC;
        Fri, 29 Sep 2023 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695988773; x=1727524773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R6q50hIsxJxwMzl5sfDYXB22ERRmSyiw64DNluIWWRk=;
  b=OWQ32rLCIo4C2GiMoFZPpeFDp4/FEwFFO844N8jFT5HOyHl6ATF1xgFX
   fQT+qEG4snG08clR5qwJM0H55jRO61byu7LYxHnyM+n1Y6BYo9r2tSsDG
   PNJgsVsEqQAG8Arp3vMMLMu+kTlAKZzSKlhcYxy0jeqFfsNgmuwrisp7M
   ijuZmCBIyO+0MqUfnEK7Vo9B2GCqKguAlXw8UR/bKKbCoJ/Ma/PzGbxoG
   fhXkM/dGpzVELVFyqCTzRo1BD43LZtcALx5U/fYlSVIKZ69pH1KyYe7uM
   Ijxh03j3p4HHDFBC9rLOC1KllTk+ZdbL9dTdRyzGOtL8ek2twm19ljRKL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="372636747"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="372636747"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="699624837"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="699624837"
Received: from valeks2x-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.242])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:59:25 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 08/10] PCI/bwctrl: Add "controller" part into PCIe bwctrl
Date:   Fri, 29 Sep 2023 14:57:21 +0300
Message-Id: <20230929115723.7864-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add "controller" parts into PCIe bwctrl for limiting PCIe Link Speed
(due to thermal reasons).

PCIe bandwidth controller introduces an in-kernel API to set PCIe Link
Speed. This new API is intended to be used in an upcoming commit that
adds a thermal cooling device to throttle PCIe bandwidth when thermal
thresholds are reached. No users are introduced in this commit yet.

The PCIe bandwidth control procedure is as follows. The requested speed
is validated against Link Speeds supported by the port and downstream
device. Then bandwidth controller sets the Target Link Speed in the
Link Control 2 Register and retrains the PCIe Link.

Bandwidth notifications enable the cur_bus_speed in the struct pci_bus
to keep track PCIe Link Speed changes. This keeps the link speed seen
through sysfs correct (both for PCI device and thermal cooling device).
While bandwidth notifications should also be generated when bandwidth
controller alters the PCIe Link Speed, a few platforms do not deliver
LMBS interrupt after Link Training as expected. Thus, after changing
the Link Speed, bandwidth controller makes additional read for the Link
Status Register to ensure cur_bus_speed is consistent with the new PCIe
Link Speed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 MAINTAINERS                |   7 ++
 drivers/pci/pcie/Kconfig   |   9 +-
 drivers/pci/pcie/bwctrl.c  | 177 +++++++++++++++++++++++++++++++++++--
 include/linux/pci-bwctrl.h |  17 ++++
 4 files changed, 201 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/pci-bwctrl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..2e4ad074eaf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16569,6 +16569,13 @@ F:	include/linux/pci*
 F:	include/uapi/linux/pci*
 F:	lib/pci*
 
+PCIE BANDWIDTH CONTROLLER
+M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	drivers/pci/pcie/bwctrl.c
+F:	include/linux/pci-bwctrl.h
+
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
 L:	linux-pci@vger.kernel.org
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 1ef8073fa89a..1c6509cf169a 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -138,12 +138,13 @@ config PCIE_PTM
 	  is safe to enable even if you don't.
 
 config PCIE_BW
-	bool "PCI Express Bandwidth Change Notification"
+	bool "PCI Express Bandwidth Controller"
 	depends on PCIEPORTBUS
 	help
-	  This enables PCI Express Bandwidth Change Notification.  If
-	  you know link width or rate changes occur to correct unreliable
-	  links, you may answer Y.
+	  This enables PCI Express Bandwidth Controller. The Bandwidth
+	  Controller allows controlling PCIe link speed and listens for link
+	  peed Change Notifications. If you know link width or rate changes
+	  occur to correct unreliable links, you may answer Y.
 
 config PCIE_EDR
 	bool "PCI Express Error Disconnect Recover support"
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 4fc6718fc0e5..e3172d69476f 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -1,14 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * PCI Express Link Bandwidth Notification services driver
+ * PCIe bandwidth controller
+ *
  * Author: Alexandru Gagniuc <mr.nuke.me@gmail.com>
  *
  * Copyright (C) 2019, Dell Inc
+ * Copyright (C) 2023 Intel Corporation.
  *
- * The PCIe Link Bandwidth Notification provides a way to notify the
- * operating system when the link width or data rate changes.  This
- * capability is required for all root ports and downstream ports
- * supporting links wider than x1 and/or multiple link speeds.
+ * The PCIe Bandwidth Controller provides a way to alter PCIe link speeds
+ * and notify the operating system when the link width or data rate changes.
+ * The notification capability is required for all Root Ports and Downstream
+ * Ports supporting links wider than x1 and/or multiple link speeds.
  *
  * This service port driver hooks into the bandwidth notification interrupt
  * watching for link speed changes or links becoming degraded in operation
@@ -17,9 +19,48 @@
 
 #define dev_fmt(fmt) "bwctrl: " fmt
 
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci-bwctrl.h>
+#include <linux/types.h>
+
+#include <asm/rwonce.h>
+
 #include "../pci.h"
 #include "portdrv.h"
 
+/**
+ * struct bwctrl_service_data - PCIe Port Bandwidth Controller
+ * @set_speed_mutex: serializes link speed changes
+ */
+struct bwctrl_service_data {
+	struct mutex set_speed_mutex;
+};
+
+static bool bwctrl_valid_pcie_speed(enum pci_bus_speed speed)
+{
+	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
+}
+
+static u16 speed2lnkctl2(enum pci_bus_speed speed)
+{
+	static const u16 speed_conv[] = {
+		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
+		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
+		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
+		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
+		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
+		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
+	};
+
+	if (WARN_ON_ONCE(!bwctrl_valid_pcie_speed(speed)))
+		return 0;
+
+	return speed_conv[speed];
+}
+
 static bool pcie_link_bandwidth_notification_supported(struct pci_dev *dev)
 {
 	int ret;
@@ -77,8 +118,118 @@ static irqreturn_t pcie_bw_notification_irq(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
+/* Configure target speed to the requested speed and set train link */
+static int bwctrl_set_speed(struct pci_dev *port, u16 lnkctl2_speed)
+{
+	int ret;
+
+	ret = pcie_capability_clear_and_set_word(port, PCI_EXP_LNKCTL2,
+						 PCI_EXP_LNKCTL2_TLS, lnkctl2_speed);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+
+	return 0;
+}
+
+static int bwctrl_select_speed(struct pcie_device *srv, enum pci_bus_speed *speed)
+{
+	struct pci_bus *bus = srv->port->subordinate;
+	u8 speeds, dev_speeds;
+	int i;
+
+	if (*speed > PCIE_LNKCAP2_SLS2SPEED(bus->pcie_bus_speeds))
+		return -EINVAL;
+
+	dev_speeds = READ_ONCE(bus->pcie_dev_speeds);
+	/* Only the lowest speed can be set when there are no devices */
+	if (!dev_speeds)
+		dev_speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
+
+	/*
+	 * Implementation Note in PCIe r6.0.1 sec 7.5.3.18 recommends OS to
+	 * utilize Supported Link Speeds vector for determining which link
+	 * speeds are supported.
+	 *
+	 * Take into account Supported Link Speeds both from the Root Port
+	 * and the device.
+	 */
+	speeds = bus->pcie_bus_speeds & dev_speeds;
+	i = BIT(fls(speeds));
+	while (i >= PCI_EXP_LNKCAP2_SLS_2_5GB) {
+		enum pci_bus_speed candidate;
+
+		if (speeds & i) {
+			candidate = PCIE_LNKCAP2_SLS2SPEED(i);
+			if (candidate <= *speed) {
+				*speed = candidate;
+				return 0;
+			}
+		}
+		i >>= 1;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * bwctrl_set_current_speed - Set downstream link speed for PCIe port
+ * @srv: PCIe port
+ * @speed: PCIe bus speed to set
+ *
+ * Attempts to set PCIe port link speed to @speed. As long as @speed is less
+ * than the maximum of what is supported by @srv, the speed is adjusted
+ * downwards to the best speed supported by both the port and device
+ * underneath it.
+ *
+ * Return:
+ * * 0 - on success
+ * * -EINVAL - @speed is higher than the maximum @srv supports
+ * * -ETIMEDOUT - changing link speed took too long
+ * * -EAGAIN - link speed was changed but @speed was not achieved
+ */
+int bwctrl_set_current_speed(struct pcie_device *srv, enum pci_bus_speed speed)
+{
+	struct bwctrl_service_data *data = get_service_data(srv);
+	struct pci_dev *port = srv->port;
+	u16 link_status;
+	int ret;
+
+	if (WARN_ON_ONCE(!bwctrl_valid_pcie_speed(speed)))
+		return -EINVAL;
+
+	ret = bwctrl_select_speed(srv, &speed);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&data->set_speed_mutex);
+	ret = bwctrl_set_speed(port, speed2lnkctl2(speed));
+	if (ret < 0)
+		goto unlock;
+
+	ret = pcie_retrain_link(port, true);
+	if (ret < 0)
+		goto unlock;
+
+	/*
+	 * Ensure link speed updates also with platforms that have problems
+	 * with notifications
+	 */
+	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
+	if (ret == PCIBIOS_SUCCESSFUL)
+		pcie_update_link_speed(port->subordinate, link_status);
+
+	if (port->subordinate->cur_bus_speed != speed)
+		ret = -EAGAIN;
+
+unlock:
+	mutex_unlock(&data->set_speed_mutex);
+
+	return ret;
+}
+
 static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
 {
+	struct bwctrl_service_data *data;
 	struct pci_dev *port = srv->port;
 	int ret;
 
@@ -91,16 +242,32 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
 	if (ret)
 		return ret;
 
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto free_irq;
+	}
+	mutex_init(&data->set_speed_mutex);
+	set_service_data(srv, data);
+
 	pcie_enable_link_bandwidth_notification(port);
 	pci_info(port, "enabled with IRQ %d\n", srv->irq);
 
 	return 0;
+
+free_irq:
+	free_irq(srv->irq, srv);
+	return ret;
 }
 
 static void pcie_bandwidth_notification_remove(struct pcie_device *srv)
 {
+	struct bwctrl_service_data *data = get_service_data(srv);
+
 	pcie_disable_link_bandwidth_notification(srv->port);
 	free_irq(srv->irq, srv);
+	mutex_destroy(&data->set_speed_mutex);
+	kfree(data);
 }
 
 static int pcie_bandwidth_notification_suspend(struct pcie_device *srv)
diff --git a/include/linux/pci-bwctrl.h b/include/linux/pci-bwctrl.h
new file mode 100644
index 000000000000..8eae09bd03b5
--- /dev/null
+++ b/include/linux/pci-bwctrl.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * PCIe bandwidth controller
+ *
+ * Copyright (C) 2023 Intel Corporation.
+ */
+
+#ifndef LINUX_PCI_BWCTRL_H
+#define LINUX_PCI_BWCTRL_H
+
+#include <linux/pci.h>
+
+struct pcie_device;
+
+int bwctrl_set_current_speed(struct pcie_device *srv, enum pci_bus_speed speed);
+
+#endif
-- 
2.30.2

