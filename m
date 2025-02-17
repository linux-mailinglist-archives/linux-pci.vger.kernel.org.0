Return-Path: <linux-pci+bounces-21649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ACBA38A17
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2703B1B47
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE05226163;
	Mon, 17 Feb 2025 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHwaIXoO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47CF225A4E;
	Mon, 17 Feb 2025 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811193; cv=none; b=kWTtZ7bxRzXLmjtn2GonQNO0oxIxlq1KZ+edFqzsMvra0qAi+nKdGz0mAIY6vB0KrHVdV19Om8yVAJyDMxOMQ1WfrPF8jyAdUgQo1FR4FcPWsh2FPcV1hq/RXL4/XL0ijUAUj6C01cr3/u188zGVs2h60zc/hSLogqvjg+4kgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811193; c=relaxed/simple;
	bh=k5klOe0el+gRBmc4oyWVlzannr3hukSD6r4iebAZnvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=h1Rnf4XE1egAVUDtu623Hom8dXszDGTyaPKWJDMz1eXhjT5UKyoe/3zq9TQmlJYhNBgT69UCL9p++d7i+YffPsSIojPCnl1ILjlALqJ4Ofk6IWyW6dR71NRgRmSzpfCd8svOf+FCUAMD6dIKtswRFS2QNNnSzZc948QduAcvt0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHwaIXoO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739811192; x=1771347192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k5klOe0el+gRBmc4oyWVlzannr3hukSD6r4iebAZnvg=;
  b=JHwaIXoO08FPlYvfNDnhEhOFjMMbdweDEjuPrJLcSxTYJBwk+BGpSF4L
   pg8zGcS5ui8gbvBemgjnkmRu+LsjmTIY/0heeNEzarK0zthavdFQ8lHn/
   h63LTaf1xoKDXBt0K05ybGR20BuNig6hKM0eUwau04TA+ocXtcoeh4w2h
   +TsQCuGNn90ePg4H+voe/ZFKPdjuqkZC6anLg7/m7jbqufsHiEt4m4oxJ
   2f3jCieweGI0CUKqeY16VqsrP9uQxRpoIsT1rhkHcgo+ryZMjzL/3vAvD
   ZRzarVMKHcRDcBrfxjkNNSvk0Z7Ogu0f9TR3VuW28x/SHFggaWOMkoXon
   Q==;
X-CSE-ConnectionGUID: Yig8adAuSpS76/GhCWFLew==
X-CSE-MsgGUID: +n+HuglES0GwK1V82g507w==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40635319"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="40635319"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 08:53:10 -0800
X-CSE-ConnectionGUID: s3QlSUGfRGaM63Exzz4IbA==
X-CSE-MsgGUID: DE8Lyl9LT9mLDJHZaiDwHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="114370098"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 08:53:07 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joel Mathew Thomas <proxy0@tutamail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] PCI/bwctrl: Disable PCIe BW controller during reset
Date: Mon, 17 Feb 2025 18:52:58 +0200
Message-Id: <20250217165258.3811-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe BW controller enables BW notifications for Downstream Ports by
setting Link Bandwidth Management Interrupt Enable (LBMIE) and Link
Autonomous Bandwidth Interrupt Enable (LABIE) (PCIe Spec. r6.2 sec.
7.5.3.7).

It was discovered that performing a reset can lead to the device
underneath the Downstream Port becoming unavailable if BW notifications
are left enabled throughout the reset sequence (at least LBMIE was
found to cause an issue).

While the PCIe Specifications do not indicate BW notifications could not
be kept enabled during resets, the PCIe Link state during an
intentional reset is not of large interest. Thus, disable BW controller
for the bridge while reset is performed and re-enable it after the
reset has completed to workaround the problems some devices encounter
if BW notifications are left on throughout the reset sequence.

Keep a counter for the disable/enable because MFD will execute
pci_dev_save_and_disable() and pci_dev_restore() back to back for
sibling devices:

[   50.139010] vfio-pci 0000:01:00.0: resetting
[   50.139053] vfio-pci 0000:01:00.1: resetting
[   50.141126] pcieport 0000:00:01.1: PME: Spurious native interrupt!
[   50.141133] pcieport 0000:00:01.1: PME: Spurious native interrupt!
[   50.441466] vfio-pci 0000:01:00.0: reset done
[   50.501534] vfio-pci 0000:01:00.1: reset done

Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219765
Tested-by: Joel Mathew Thomas <proxy0@tutamail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---

I suspect the root cause is some kind of violation of specifications.
Resets shouldn't cause devices to become unavailable just because BW
notifications have been enabled.

Before somebody comments on those dual rwsems, I do have yet to be
submitted patch to simplify the locking as per Lukas Wunner's earlier
suggestion. I've just focused on solving the regressions first.

 drivers/pci/pci.c         |  8 +++++++
 drivers/pci/pci.h         |  4 ++++
 drivers/pci/pcie/bwctrl.c | 49 ++++++++++++++++++++++++++++++++-------
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..7a53d7474175 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5148,6 +5148,7 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
+	struct pci_dev *bridge = pci_upstream_bridge(dev);
 
 	/*
 	 * dev->driver->err_handler->reset_prepare() is protected against
@@ -5166,6 +5167,9 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	 */
 	pci_set_power_state(dev, PCI_D0);
 
+	if (bridge)
+		pcie_bwnotif_disable(bridge);
+
 	pci_save_state(dev);
 	/*
 	 * Disable the device by clearing the Command register, except for
@@ -5181,9 +5185,13 @@ static void pci_dev_restore(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
+	struct pci_dev *bridge = pci_upstream_bridge(dev);
 
 	pci_restore_state(dev);
 
+	if (bridge)
+		pcie_bwnotif_enable(bridge);
+
 	/*
 	 * dev->driver->err_handler->reset_done() is protected against
 	 * races with ->remove() by the device lock, which must be held by
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..856546f1aad9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -759,12 +759,16 @@ static inline void pcie_ecrc_get_policy(char *str) { }
 #ifdef CONFIG_PCIEPORTBUS
 void pcie_reset_lbms_count(struct pci_dev *port);
 int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
+void pcie_bwnotif_enable(struct pci_dev *port);
+void pcie_bwnotif_disable(struct pci_dev *port);
 #else
 static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
 static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
 {
 	return -EOPNOTSUPP;
 }
+static inline void pcie_bwnotif_enable(struct pci_dev *port) {}
+static inline void pcie_bwnotif_disable(struct pci_dev *port) {}
 #endif
 
 struct pci_dev_reset_methods {
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 0a5e7efbce2c..a117f6f67c07 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -40,11 +40,13 @@
  * @set_speed_mutex:	Serializes link speed changes
  * @lbms_count:		Count for LBMS (since last reset)
  * @cdev:		Thermal cooling device associated with the port
+ * @disable_count:	BW notifications disabled/enabled counter
  */
 struct pcie_bwctrl_data {
 	struct mutex set_speed_mutex;
 	atomic_t lbms_count;
 	struct thermal_cooling_device *cdev;
+	int disable_count;
 };
 
 /*
@@ -200,10 +202,9 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 	return ret;
 }
 
-static void pcie_bwnotif_enable(struct pcie_device *srv)
+static void __pcie_bwnotif_enable(struct pci_dev *port)
 {
-	struct pcie_bwctrl_data *data = srv->port->link_bwctrl;
-	struct pci_dev *port = srv->port;
+	struct pcie_bwctrl_data *data = port->link_bwctrl;
 	u16 link_status;
 	int ret;
 
@@ -224,12 +225,44 @@ static void pcie_bwnotif_enable(struct pcie_device *srv)
 	pcie_update_link_speed(port->subordinate);
 }
 
-static void pcie_bwnotif_disable(struct pci_dev *port)
+void pcie_bwnotif_enable(struct pci_dev *port)
+{
+	guard(rwsem_read)(&pcie_bwctrl_setspeed_rwsem);
+	guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
+
+	if (!port->link_bwctrl)
+		return;
+
+	port->link_bwctrl->disable_count--;
+	if (!port->link_bwctrl->disable_count) {
+		__pcie_bwnotif_enable(port);
+		pci_dbg(port, "BW notifications enabled\n");
+	}
+	WARN_ON_ONCE(port->link_bwctrl->disable_count < 0);
+}
+
+static void __pcie_bwnotif_disable(struct pci_dev *port)
 {
 	pcie_capability_clear_word(port, PCI_EXP_LNKCTL,
 				   PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
 }
 
+void pcie_bwnotif_disable(struct pci_dev *port)
+{
+	guard(rwsem_read)(&pcie_bwctrl_setspeed_rwsem);
+	guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
+
+	if (!port->link_bwctrl)
+		return;
+
+	port->link_bwctrl->disable_count++;
+
+	if (port->link_bwctrl->disable_count == 1) {
+		__pcie_bwnotif_disable(port);
+		pci_dbg(port, "BW notifications disabled\n");
+	}
+}
+
 static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
 {
 	struct pcie_device *srv = context;
@@ -314,7 +347,7 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 				return ret;
 			}
 
-			pcie_bwnotif_enable(srv);
+			__pcie_bwnotif_enable(port);
 		}
 	}
 
@@ -336,7 +369,7 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
 
 	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
 		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
-			pcie_bwnotif_disable(srv->port);
+			__pcie_bwnotif_disable(srv->port);
 
 			free_irq(srv->irq, srv);
 
@@ -347,13 +380,13 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
 
 static int pcie_bwnotif_suspend(struct pcie_device *srv)
 {
-	pcie_bwnotif_disable(srv->port);
+	__pcie_bwnotif_disable(srv->port);
 	return 0;
 }
 
 static int pcie_bwnotif_resume(struct pcie_device *srv)
 {
-	pcie_bwnotif_enable(srv);
+	__pcie_bwnotif_enable(srv->port);
 	return 0;
 }
 

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.39.5


