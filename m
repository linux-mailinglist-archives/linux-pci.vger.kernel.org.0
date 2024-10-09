Return-Path: <linux-pci+bounces-14061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533C996613
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 11:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B3C1C24A81
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4B918E750;
	Wed,  9 Oct 2024 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAOTDCTE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED0618E748;
	Wed,  9 Oct 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467626; cv=none; b=TcWZGXoJXmmPOfv621LhAy5A/ZlXk2BmcWPgJIBd1TvR/tP9+qaDDvbFOnSPGZ1LNKCyTytKNdle5KsxOwpRbxp+B3j2BJdwoWDRFuFy9ANRvgQvy8B7ICMZG95fQ00yRLUWaPkhegb5AokvQq2YSZqLyVLhSKZ1fTRWAZwc0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467626; c=relaxed/simple;
	bh=mTEjDVtFAypCUZDXBm5lkdGAI9okpyDe7LW12vQJtpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/H4Hmky7QY6Ijt7ZacvXGYAsO1ThVaeuMeyNBh+cL05P4jZgu2skpMGfEXG6bfueNmbkwvdC7bUrIT0Q/wLRPklyJcK3sN46Kv6Y4TIGT/9B4fTuGcALg5EpXA8aa0QRe2Om9ucdUEjHwwXkuWwhPdqfdS6BgaZD2dgUAaizyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAOTDCTE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728467624; x=1760003624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mTEjDVtFAypCUZDXBm5lkdGAI9okpyDe7LW12vQJtpQ=;
  b=SAOTDCTEHsrwnkgQjV34hrDPO2dKV/EAwKxn5Wtgc3wikRRpziRqv5i8
   5PwdE8DCWHZgqxYBwk6Zzeq8isfK3PHfO3JzWoR0LffY9SQjzMO1tD+Oc
   WmfnmLk4AgcYW57U+uI0fHsUq7xSlBVFlkE0Ub30V2qsfWym32eXTVoGF
   d0KBzwHzaDhpLx6TGARPOZg5/si6/jBz/cQ+gPAX5CaXX3jyGuoZLj8pP
   cobAeQXejIMiPPkQmzInqAf5HbwRvR3HeqJZVczCokUqJzyHe+WKhMJdm
   AG77sJKsndcQNlcD3xK7QbPxRTzDMrIoqAzUjooP37P9pSaqP5e5uLuB/
   w==;
X-CSE-ConnectionGUID: q5zyeXMUSF2V8aTr8uDkPA==
X-CSE-MsgGUID: myGk6fXLSMm4VdD8+ritYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38323011"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="38323011"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:53:43 -0700
X-CSE-ConnectionGUID: XaLBWVBETxG4hESvDzKw2g==
X-CSE-MsgGUID: Y2c1e617RAWInVWVV4zyeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76506929"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:53:39 -0700
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
	linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v8 6/8] PCI/bwctrl: Add API to set PCIe Link Speed
Date: Wed,  9 Oct 2024 12:52:21 +0300
Message-Id: <20241009095223.7093-7-ilpo.jarvinen@linux.intel.com>
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

Currently, PCIe Link Speeds are adjusted by custom code rather than in
a common function provided in PCI core. PCIe bandwidth controller
(bwctrl) introduces an in-kernel API to set PCIe Link Speed.

Convert Target Speed quirk to use the new API. The Target Speed quirk
runs very early when bwctrl is not yet probed for a Port and can also
run later when bwctrl is already setup for the Port, which requires the
per port mutex (set_speed_mutex) to be only taken if the bwctrl setup
is already complete.

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
 drivers/pci/pci.h         |  20 +++++
 drivers/pci/pcie/bwctrl.c | 161 +++++++++++++++++++++++++++++++++++++-
 drivers/pci/quirks.c      |  17 +---
 include/linux/pci.h       |  10 +++
 4 files changed, 193 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 33ed324d1953..c8ea672c1892 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -331,6 +331,17 @@ void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);
 
+#define PCIE_LNKCAP_SLS2SPEED(lnkcap)					\
+({									\
+	((lnkcap) == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
+	 (lnkcap) == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
+	 (lnkcap) == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
+	 (lnkcap) == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
+	 (lnkcap) == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
+	 (lnkcap) == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
+	 PCI_SPEED_UNKNOWN);						\
+})
+
 /* PCIe link information from Link Capabilities 2 */
 #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
 	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
@@ -341,6 +352,15 @@ void pci_bus_put(struct pci_bus *bus);
 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_2_5GB ? PCIE_SPEED_2_5GT : \
 	 PCI_SPEED_UNKNOWN)
 
+#define PCIE_LNKCTL2_TLS2SPEED(lnkctl2) \
+	((lnkctl2) == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT : \
+	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT : \
+	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT : \
+	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT : \
+	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT : \
+	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
+	 PCI_SPEED_UNKNOWN)
+
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
 	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 1b11b5da79d4..1d3680ea8e06 100644
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
@@ -28,15 +36,160 @@
 
 /**
  * struct pcie_bwctrl_data - PCIe bandwidth controller
+ * @set_speed_mutex:	Serializes link speed changes
  * @lbms_count:		Count for LBMS (since last reset)
  */
 struct pcie_bwctrl_data {
+	struct mutex set_speed_mutex;
 	atomic_t lbms_count;
 };
 
 /* Prevents port removal during link speed changes and LBMS count accessors */
 static DECLARE_RWSEM(pcie_bwctrl_remove_rwsem);
 
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
+	u8 desired_speeds, supported_speeds;
+	struct pci_dev *dev;
+
+	desired_speeds = GENMASK(pci_bus_speed2lnkctl2(speed_req),
+				 __fls(PCI_EXP_LNKCAP2_SLS_2_5GB));
+
+	supported_speeds = port->supported_speeds;
+	if (bus) {
+		down_read(&pci_bus_sem);
+		dev = list_first_entry_or_null(&bus->devices, struct pci_dev, bus_list);
+		if (dev)
+			supported_speeds &= dev->supported_speeds;
+		up_read(&pci_bus_sem);
+	}
+	if (!supported_speeds)
+		return PCI_EXP_LNKCAP2_SLS_2_5GB;
+
+	return pcie_supported_speeds2target_speed(supported_speeds & desired_speeds);
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
+	if (port->subordinate)
+		pcie_update_link_speed(port->subordinate);
+
+	return 0;
+}
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
+	struct pci_bus *bus = port->subordinate;
+	u16 target_speed;
+	int ret;
+
+	if (WARN_ON_ONCE(!pcie_valid_speed(speed_req)))
+		return -EINVAL;
+
+	if (bus && bus->cur_bus_speed == speed_req)
+		return 0;
+
+	target_speed = pcie_bwctrl_select_speed(port, speed_req);
+
+	scoped_guard(rwsem_read, &pcie_bwctrl_remove_rwsem) {
+		struct pcie_bwctrl_data *data = port->link_bwctrl;
+
+		/*
+		 * port->link_bwctrl is NULL during initial scan when called
+		 * e.g. from the Target Speed quirk.
+		 */
+		if (data)
+			mutex_lock(&data->set_speed_mutex);
+
+		ret = pcie_bwctrl_change_speed(port, target_speed, use_lt);
+
+		if (data)
+			mutex_unlock(&data->set_speed_mutex);
+	}
+
+	/*
+	 * Despite setting higher speed into the Target Link Speed, empty
+	 * bus won't train to 5GT+ speeds.
+	 */
+	if (!ret && bus && bus->cur_bus_speed != speed_req &&
+	    !list_empty(&bus->devices))
+		ret = -EAGAIN;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pcie_set_target_speed);
+
 static void pcie_bwnotif_enable(struct pcie_device *srv)
 {
 	struct pcie_bwctrl_data *data = get_service_data(srv);
@@ -135,6 +288,7 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 	if (!data)
 		return -ENOMEM;
 
+	mutex_init(&data->set_speed_mutex);
 	set_service_data(srv, data);
 
 	ret = request_threaded_irq(srv->irq, NULL, pcie_bwnotif_irq_thread,
@@ -142,8 +296,10 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 	if (ret)
 		return ret;
 
-	port->link_bwctrl = no_free_ptr(data);
-	pcie_bwnotif_enable(srv);
+	scoped_guard(rwsem_write, &pcie_bwctrl_remove_rwsem) {
+		port->link_bwctrl = no_free_ptr(data);
+		pcie_bwnotif_enable(srv);
+	}
 
 	pci_dbg(port, "enabled with IRQ %d\n", srv->irq);
 
@@ -159,6 +315,7 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
 		srv->port->link_bwctrl = NULL;
 
 	free_irq(srv->irq, srv);
+	mutex_destroy(&data->set_speed_mutex);
 	kfree(data);
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e6d502dca939..dcf1c86a5488 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -113,16 +113,11 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
-		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
-		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
-
-		ret = pcie_retrain_link(dev, false);
+		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
 		if (ret) {
 			pci_info(dev, "retraining failed\n");
-			pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
-						   oldlnkctl2);
-			pcie_retrain_link(dev, true);
+			pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2),
+					      true);
 			return ret;
 		}
 
@@ -136,11 +131,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 
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
index 5f9de226be13..b5ce9513b06f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1798,9 +1798,19 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 #ifdef CONFIG_PCIEPORTBUS
 extern bool pcie_ports_disabled;
 extern bool pcie_ports_native;
+
+int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
+			  bool use_lt);
 #else
 #define pcie_ports_disabled	true
 #define pcie_ports_native	false
+
+static inline int pcie_set_target_speed(struct pci_dev *port,
+					enum pci_bus_speed speed_req,
+					bool use_lt)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
-- 
2.39.5


