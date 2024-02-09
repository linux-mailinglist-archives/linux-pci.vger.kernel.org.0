Return-Path: <linux-pci+bounces-3286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3AB84F691
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 15:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52921F24732
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8D34E1A2;
	Fri,  9 Feb 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZ0p9UZV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA4664A2;
	Fri,  9 Feb 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487748; cv=none; b=okDJVyeidq8XmTrAPvES+/8DB775udUsz7EX924g4peDpJo2yR8BSbqZiY1UF5yRD4sfOtJDIDmxMjQp1AFdJ3jcvpqdt/ZRt16BiuE0FXeFV5qZIs99OYPmf4e5dPN26909xZ9zPx07TsP6GwB4LRD0EgSytmFuxuNKczY3bHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487748; c=relaxed/simple;
	bh=RtlRC4w4v77MUjZr2sfRSzuakwjhZiiQgaAkYrPTjtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IWBoLHF9mlNqXHLhBsWiPagJx7y4m11oahthLjOFZg0yT2rRrk161kNDVAxcdtK+2fKQeJPABC5CPvW7YoQZZnrt2fHeVvoT8NDVCZ5WGKsvkgh7Djjum5eU7yONfq3Qt7MhCyRC0gIul8Xm+tGCCGiwrg5za2vMfe5Iv7gtHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZ0p9UZV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707487747; x=1739023747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RtlRC4w4v77MUjZr2sfRSzuakwjhZiiQgaAkYrPTjtw=;
  b=NZ0p9UZVZTMDdjiv2LW/PH7m1I/BHQ8bS+HflxCOF3c9luIObK5oat04
   oofVFvB8xqn3vj/E303OGTPJ7V9Fjxwjtq/gKBCJGIPpygQpRSJ/E/YcE
   hBKzfddXaFEDuryvj3jSkLYqVA1xZRrDMj5yGsW2ux3He2Z2DhNOzD7hr
   qNRH6qyKM2pNtaGEzJRGkc7p6+FffcIgsFzWh29gc/Ef0sNB4VUUYhEUQ
   gRAF05lFROiulj2SfKKYV8Xs/tuGDJCYDpBp45VyY7ZZhApqjUH+5P9yz
   rBM+pZRKclq6QYYVg+jW6sZ750mg7HQOXe0sFCbIboCN5xXN1QOOQn+8l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1313060"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1313060"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="39380538"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:09:04 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH] PCI/AER: Block runtime suspend when handling errors
Date: Fri,  9 Feb 2024 15:08:41 +0100
Message-Id: <20240209140841.1854711-1-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PM runtime can be done simultaneously with AER error handling.
Avoid that by using pm_runtime_get_sync() before and pm_runtime_put()
after reset in pcie_do_recovery() for all recovering devices.

pm_runtime_get_sync() will increase dev->power.usage_count counter
to prevent any possible future request to runtime suspend a device,
as well as resume device is was in D3hot state.

I tested with igc device by doing simultaneous aer_inject and
rpm suspend/resume via /sys/bus/pci/devices/PCI_ID/power/control
and can reproduce:

igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
pcieport 0000:00:1c.2: AER: subordinate device reset failed
pcieport 0000:00:1c.2: AER: device recovery failed
igc 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible

The problem disappears when applied this patch.

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
RFC -> v1:
 add runtime callbacks to pcie_do_recovery(), this covers DPC case
 as well as case of recovering multiple devices under same port.
 
 drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 59c90d04a609..705893b5f7b0 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -13,6 +13,7 @@
 #define dev_fmt(fmt) "AER: " fmt
 
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -85,6 +86,18 @@ static int report_error_detected(struct pci_dev *dev,
 	return 0;
 }
 
+static int pci_pm_runtime_get_sync(struct pci_dev *pdev, void *data)
+{
+	pm_runtime_get_sync(&pdev->dev);
+	return 0;
+}
+
+static int pci_pm_runtime_put(struct pci_dev *pdev, void *data)
+{
+	pm_runtime_put(&pdev->dev);
+	return 0;
+}
+
 static int report_frozen_detected(struct pci_dev *dev, void *data)
 {
 	return report_error_detected(dev, pci_channel_io_frozen, data);
@@ -207,6 +220,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	else
 		bridge = pci_upstream_bridge(dev);
 
+	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
+
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
@@ -251,10 +266,15 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pcie_clear_device_status(dev);
 		pci_aer_clear_nonfatal_status(dev);
 	}
+
+	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+
 	pci_info(bridge, "device recovery successful\n");
 	return status;
 
 failed:
+	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+
 	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
 
 	/* TODO: Should kernel panic here? */
-- 
2.34.1


