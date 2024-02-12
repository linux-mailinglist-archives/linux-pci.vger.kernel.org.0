Return-Path: <linux-pci+bounces-3337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECCF850F68
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 10:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC06283C01
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62C101C1;
	Mon, 12 Feb 2024 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K85mfHk6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A4FBFC;
	Mon, 12 Feb 2024 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707729140; cv=none; b=TgE0J9ovgfWE5Tcy0JimjBRvyUZttRJ2ekJixF5QWn3/O7BkC34BxH6ndYH0WW4iZkBdBqpS/e6emElVOpSkBsNZsVdtTN4I7m/JI87ukJ+GOR70hqgMfDfpTOV6xei493o/8/hssHHsncyz7JxZx6pU5VZrVkznMQl2PShcYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707729140; c=relaxed/simple;
	bh=hU4JqTgEX1Tz6qm53KazJ+VwpJp+5TGm9hF0fPKSL/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nw0z/BLf+QHw2cFegfeSNBFSrbanOn/Clmgm31BIebBr0mw5jgSrQpojpAFWz00yMZz5aqfj8ote2Vsi1u36lkfbF52kZUELDjJ+CHQZdzQ2899KCTVw6EhLigr/PAudvIG6IiQ/v6prL8obUA3wjMNwxXqrU7Q8J3wtn6oqVcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K85mfHk6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707729139; x=1739265139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hU4JqTgEX1Tz6qm53KazJ+VwpJp+5TGm9hF0fPKSL/k=;
  b=K85mfHk6MUZ5NLt5pwUk4lHBay+Ehwn4STN0DcHJKjKfcg4Oztx30tkJ
   qixGhmmKckW1OwQen8IqYfoneOkDwSYjlEuYo3gd0HZH+2HdKI75RVqix
   9VmkHDTB6BcX9dvguMw7MjLZR1/nV3sX2sQrj7BTKmhQHNi4VD29pidoB
   oq4WO6eYsBmZICZdIDotqSt3NvrZMN9RuW46c3t0R4uNJ4BgvewBBT/Gw
   6HxIuO4ll1Qy9yM8U3HGY8BCVrSebjpp36QoAJxDuVYGf2HTIgVbuurkB
   eV4Yv59tKBpv1nE/Fwp+ikwPvC9NZiSAlK3UKTXkUfmfl06pLJF1gjIiD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12256147"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="12256147"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 01:12:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2508051"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.62.245])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 01:12:15 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v2] PCI/AER: Block runtime suspend when handling errors
Date: Mon, 12 Feb 2024 09:31:58 +0100
Message-Id: <20240212083158.76549-1-stanislaw.gruszka@linux.intel.com>
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

pm_runtime_get_sync() will increase dev->power.usage_count counter                                                                                                                                                                          to prevent any possible future request to runtime suspend a device                                                                                                                                                                          It will also resume a device, if it was previously in D3hot state.

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


