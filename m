Return-Path: <linux-pci+bounces-7560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5458C73DF
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 11:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA61B24321
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC38143880;
	Thu, 16 May 2024 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSmrQn0p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5437182AF;
	Thu, 16 May 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852039; cv=none; b=klTFUVlZIhQWMAsvKzgwA/jGw1G6gon6hkgBjw7G7NHw8VR9wdiLfV6zImr0wQd0qLzldwIrQhJy7Wre7zvGhQg0cWA40FNYLI+btqe1Zm0Pw1Ifz5Qyut8hjfWfQtYqxL4BDOEHVJ81j7mW7sx1GQANCWgtYhyIgeebxfji/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852039; c=relaxed/simple;
	bh=eZCyLma/Em5HCPqSF80iWFHJDAVVFQLC3YecfXAnF3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhMTxCPSPlnAOeuSwccg6PY1xB6g/ksdvDKvC38I2n4tfesFd5yazi2UTZbKrlX4lOWL2jR303cyynQBGF+eir3dasZ/FwvTVBxW/xJPWnBiddJAuhRqZL1Je+I378FwQw+nzQwdJSKBiDvDh1KRpTrU2M1RgnIFSJqiqwVmtwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSmrQn0p; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715852038; x=1747388038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eZCyLma/Em5HCPqSF80iWFHJDAVVFQLC3YecfXAnF3k=;
  b=HSmrQn0pTiGQsh4Jxl6L3pqAzOJ0FquBmriA3ewKZNyAKAPuKr6IU9+7
   euiBjFC+BVzAjbwIsnSnm7TROyWqtaeTA6J3U9WEKrhaN1MSh8edzt6X6
   WbF5Eb1XbxN/BJ4hZ1oAfMQ+hPcOI92wAJjS3JvzSOud7mpLwnLjMkysx
   Cm6s9rDnvoODT8BmflpviOkQI5vyFrzTHgzE6hC0MtJxoyMBIyD/9d8nf
   tprQ057YhX1pRIgTmuYaQ5XoteEweZzXAyKBeSoZ1+TZSLFa6zVveVPd0
   smhS6WCGL5CKNhCExiUanhVEJHan05BsjI0u6rfwyruHMLToJOvKMBXha
   g==;
X-CSE-ConnectionGUID: 6WcqJ6Z2ThWp0nsW2gn6UQ==
X-CSE-MsgGUID: ElNN62+8RmaAVweHqLoKNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23355018"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="23355018"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 02:33:56 -0700
X-CSE-ConnectionGUID: uOXlKOfJSeSw5Gi27AB9JQ==
X-CSE-MsgGUID: RiTczmm5SI6t9RvQ4Geyqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31372494"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 02:33:51 -0700
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
	linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v6 6/8] PCI/bwctrl: Add API to set PCIe Link Speed
Date: Thu, 16 May 2024 12:32:20 +0300
Message-Id: <20240516093222.1684-7-ilpo.jarvinen@linux.intel.com>
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

Currently, PCIe Link Speeds are adjusted by custom code rather than in
a common function provided in PCI core. PCIe bandwidth controller
(bwctrl) introduces an in-kernel API to set PCIe Link Speed. Convert
Target Speed quirk to use the new API.

The new API is also intended to be used in an upcoming commit that adds
a thermal cooling device to throttle PCIe bandwidth when thermal
thresholds are reached.

The PCIe bandwidth control procedure is as follows. The highest speed
supported by the Port and the PCIe device which is not higher than the
requested speed is selected and written into the Target Link Speed in
the Link Control 2 Register. Then bandwidth controller retrains the
PCIe Link.

Bandwidth Notifications enable the cur_bus_speed in the struct pci_bus
to keep track PCIe Link Speed changes. While Bandwidth Notifications
should also be generated when bandwidth controller alters the PCIe Link
Speed, a few platforms do not deliver LMBS interrupt after Link
Training as expected. Thus, after changing the Link Speed, bandwidth
controller makes additional read for the Link Status Register to ensure
cur_bus_speed is consistent with the new PCIe Link Speed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h         |  11 +++
 drivers/pci/pcie/Makefile |   2 +-
 drivers/pci/pcie/bwctrl.c | 147 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c      |  12 +---
 include/linux/pci.h       |   3 +
 5 files changed, 164 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 416540baf27b..f95e0fedb35c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -270,6 +270,17 @@ void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);
 
+#define PCIE_LNKCAP_SLS2SPEED(lnkcap)					\
+({									\
+	(lnkcap == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
+	 lnkcap == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
+	 lnkcap == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
+	 lnkcap == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
+	 lnkcap == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
+	 lnkcap == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
+	 PCI_SPEED_UNKNOWN);						\
+})
+
 /* PCIe link information from Link Capabilities 2 */
 #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
 	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 6357bc219632..e8cf58a0fa3f 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -12,5 +12,5 @@ obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
-obj-$(CONFIG_PCIE_BWCTRL)	+= bwctrl.o
+obj-y				+= bwctrl.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 048a9cffc531..c44da36ef81a 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -7,6 +7,11 @@
  * Copyright (C) 2019 Dell Inc
  * Copyright (C) 2023-2024 Intel Corporation
  *
+ * The PCIe bandwidth controller provides a way to alter PCIe Link Speeds
+ * and notify the operating system when the Link Width or Speed changes. The
+ * notification capability is required for all Root Ports and Downstream
+ * Ports supporting Link Width wider than x1 and/or multiple Link Speeds.
+ *
  * This service port driver hooks into the Bandwidth Notification interrupt
  * watching for changes or links becoming degraded in operation. It updates
  * the cached Current Link Speed that is exposed to user space through sysfs.
@@ -15,9 +20,12 @@
 #define dev_fmt(fmt) "bwctrl: " fmt
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
@@ -28,15 +36,151 @@
 
 /**
  * struct pcie_bwctrl_data - PCIe bandwidth controller
+ * @set_speed_mutex:	Serializes link speed changes
  * @lbms_count:		Count for LBMS (since last reset)
  */
 struct pcie_bwctrl_data {
+	struct mutex set_speed_mutex;
 	atomic_t lbms_count;
 };
 
+static bool pcie_valid_speed(enum pci_bus_speed speed)
+{
+	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
+}
+
+static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
+{
+	static const u8 speed_conv[] = {
+		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
+		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
+		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
+		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
+		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
+		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
+	};
+
+	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
+		return 0;
+
+	return speed_conv[speed];
+}
+
+static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds)
+{
+	return __fls(supported_speeds);
+}
+
+/**
+ * pcie_bwctrl_select_speed - Select Target Link Speed
+ * @port:	PCIe Port
+ * @speed_req:	requested PCIe Link Speed
+ *
+ * Select Target Link Speed by take into account Supported Link Speeds of
+ * both the Root Port and the Endpoint.
+ *
+ * Return: Target Link Speed (1=2.5GT/s, 2=5GT/s, 3=8GT/s, etc.)
+ */
+static u16 pcie_bwctrl_select_speed(struct pci_dev *port, enum pci_bus_speed speed_req)
+{
+	struct pci_bus *bus = port->subordinate;
+	u8 desired_speeds;
+
+	if (WARN_ON_ONCE(!bus->supported_speeds))
+		return PCI_EXP_LNKCAP2_SLS_2_5GB;
+
+	desired_speeds = GENMASK(pci_bus_speed2lnkctl2(speed_req),
+				 __fls(PCI_EXP_LNKCAP2_SLS_2_5GB));
+
+	return pcie_supported_speeds2target_speed(bus->supported_speeds & desired_speeds);
+}
+
+static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool use_lt)
+{
+	int ret;
+
+	ret = pcie_capability_clear_and_set_word(port, PCI_EXP_LNKCTL2,
+						 PCI_EXP_LNKCTL2_TLS, target_speed);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+
+	ret = pcie_retrain_link(port, use_lt);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Ensure link speed updates also with platforms that have problems
+	 * with notifications.
+	 */
+	pcie_update_link_speed(port->subordinate);
+
+	return 0;
+}
+
+#ifdef CONFIG_PCIE_BWCTRL
 /* Prevents port removal during link speed changes and LBMS count accessors */
 static DECLARE_RWSEM(pcie_bwctrl_remove_rwsem);
 
+static int __pcie_set_target_speed(struct pci_dev *port, u16 target_speed, bool use_lt)
+{
+	struct pcie_bwctrl_data *data = NULL;
+
+	guard(rwsem_read)(&pcie_bwctrl_remove_rwsem);
+	data = port->link_bwctrl;
+	if (!data)
+		return -ENODEV;
+
+	guard(mutex)(&data->set_speed_mutex);
+
+	return pcie_bwctrl_change_speed(port, target_speed, use_lt);
+}
+#else
+static int __pcie_set_target_speed(struct pci_dev *port, u16 target_speed, bool use_lt)
+{
+	return pcie_bwctrl_change_speed(port, target_speed, use_lt);
+}
+#endif
+
+/**
+ * pcie_set_target_speed - Set downstream Link Speed for PCIe Port
+ * @port:	PCIe Port
+ * @speed_req:	requested PCIe Link Speed
+ * @use_lt:	Wait for the LT or DLLLA bit to detect the end of link training
+ *
+ * Attempts to set PCIe Port Link Speed to @speed_req. @speed_req may be
+ * adjusted downwards to the best speed supported by both the Port and PCIe
+ * Device underneath it.
+ *
+ * Return:
+ * * 0		- on success
+ * * -EINVAL	- @speed_req is not a PCIe Link Speed
+ * * -ENODEV	- @port is not controllable
+ * * -ETIMEDOUT	- changing Link Speed took too long
+ * * -EAGAIN	- Link Speed was changed but @speed_req was not achieved
+ */
+int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
+			  bool use_lt)
+{
+	u16 target_speed;
+	int ret;
+
+	if (WARN_ON_ONCE(!pcie_valid_speed(speed_req)))
+		return -EINVAL;
+
+	if (port->subordinate->cur_bus_speed == speed_req)
+		return 0;
+
+	target_speed = pcie_bwctrl_select_speed(port, speed_req);
+
+	ret = __pcie_set_target_speed(port, target_speed, use_lt);
+	if (!ret && port->subordinate->cur_bus_speed != speed_req)
+		ret = -EAGAIN;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pcie_set_target_speed);
+
+#ifdef CONFIG_PCIE_BWCTRL
 static void pcie_bwnotif_enable(struct pcie_device *srv)
 {
 	struct pcie_bwctrl_data *data = get_service_data(srv);
@@ -133,6 +277,7 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 	if (!data)
 		return -ENOMEM;
 
+	mutex_init(&data->set_speed_mutex);
 	set_service_data(srv, data);
 
 	ret = request_threaded_irq(srv->irq, NULL, pcie_bwnotif_irq_thread,
@@ -157,6 +302,7 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
 		srv->port->link_bwctrl = NULL;
 
 	free_irq(srv->irq, srv);
+	mutex_destroy(&data->set_speed_mutex);
 	kfree(data);
 }
 
@@ -186,3 +332,4 @@ int __init pcie_bwctrl_init(void)
 {
 	return pcie_port_service_register(&pcie_bwctrl_driver);
 }
+#endif	/* CONFIG_PCIE_BWCTRL */
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 85e6624ba3b9..783494f04789 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -105,11 +105,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
-		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
-		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
-
-		ret = pcie_retrain_link(dev, false);
+		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
 		if (ret) {
 			pci_info(dev, "retraining failed\n");
 			return ret;
@@ -125,11 +121,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
 		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
-		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
-		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
-
-		ret = pcie_retrain_link(dev, false);
+		ret = pcie_set_target_speed(dev, PCIE_LNKCAP_SLS2SPEED(lnkcap), false);
 		if (ret) {
 			pci_info(dev, "retraining failed\n");
 			return ret;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 406ed87fb0aa..b43bbd61c437 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1876,6 +1876,9 @@ bool pci_aer_available(void);
 static inline bool pci_aer_available(void) { return false; }
 #endif
 
+int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
+			  bool use_lt);
+
 bool pci_ats_disabled(void);
 
 #ifdef CONFIG_PCIE_PTM
-- 
2.39.2


