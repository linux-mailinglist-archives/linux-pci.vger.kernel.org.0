Return-Path: <linux-pci+bounces-3346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3F8851723
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 15:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6EC4B22614
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 14:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D383A8CD;
	Mon, 12 Feb 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xdu0P9MN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5223B189;
	Mon, 12 Feb 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748604; cv=none; b=IhjG2Ol7jyW7KsDGv015jtOXI+qie04AJgbl5B88UbyFXstZiJLbhvlSaywE1ptZH0sy2YDAtyUm+c843rLKnQhNZVl2bH/oMerfE4BY3W044d/kkw5gEWI8wKrYmD4EiPV9BKwiaPvqwhC5dwtdjG8Kegcd6onjNQ8n+yNf0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748604; c=relaxed/simple;
	bh=b8pt0/3786l/uac5Hp7coU7axC73eUNinUyy/qZ+804=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kBR75qrKVWSgCt8+QOfLAyApabRXlyLRo+bDYmO3hLpCQ79mUtY9X8vY2m6dhzQhNtwQc+WQ8OKAFlisEMV7DTNyEM+u2MxtEcmJ3xlHZVu3WxHGBkbCjLho80ZjV/DncxXShT9O+XkN8GhOQtm4u+HHTkmWTUi+WkGUOeqj04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xdu0P9MN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707748602; x=1739284602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b8pt0/3786l/uac5Hp7coU7axC73eUNinUyy/qZ+804=;
  b=Xdu0P9MNkDveOKKFys9m2f19W5O+KrIkoO8RzNUP2Re9EY+WBsgnf+eS
   tkITH9X9CTpISov2PV/lVFCk1FlnY/dpdRYi7HnBmXJjWwuap0UQsricq
   Mn5xE7UFhjEDD0CiU7DYHAH7WOT1kH4CvudA0eB04LYDf+UO8gJeTHzib
   V5jpsSvIC3PBHHp8i0GO3CqOG/CR7RGIevvMH4wGnEl8Ls593TpzRo2Pt
   XC1lt+3F/Mm+a/WzL2xjJ4ynhPkNQngSfnlrTAQ8S/TbOeZqTLZN48wit
   5CABO680m/ye9Mgt/Eb08GOeFv0P17El7dSAw5RL91ZHnAOv+ciVYFz6H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13101316"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="13101316"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:36:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="935084054"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935084054"
Received: from oelagadx-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.44.2])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:36:38 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v3] PCI/AER: Block runtime suspend when handling errors
Date: Mon, 12 Feb 2024 13:01:35 +0100
Message-Id: <20240212120135.146068-1-stanislaw.gruszka@linux.intel.com>
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
to prevent any possible future request to runtime suspend a device.
It will also resume a device, if it was previously in D3hot state.

I tested with igc device by doing simultaneous aer_inject and
rpm suspend/resume via /sys/bus/pci/devices/PCI_ID/power/control
and can reproduce:

igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
pcieport 0000:00:1c.2: AER: subordinate device reset failed
pcieport 0000:00:1c.2: AER: device recovery failed
igc 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible

The problem disappears when applied this patch.

Cc: stable@vger.kernel.org
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

RFC -> v1:
 add runtime callbacks to pcie_do_recovery(), this covers DPC case
 as well as case of recovering multiple devices under same port.

v1 -> v2:
 - add R-b, A-b, cc-stable tags
 - tweak commit message

v2 -> v3:
 - fix mangled commit message

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


