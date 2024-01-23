Return-Path: <linux-pci+bounces-2460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0F88389E0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 10:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703341C22E76
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5416524A9;
	Tue, 23 Jan 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6tnzK6m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D32F51C54;
	Tue, 23 Jan 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706000435; cv=none; b=ExLfgyeA6cj64CzbXcEL9d21NY3LxLuE3jCL4xr4Ovb5mgHWA42UXa17hB6ZxVoUtD5HoeHvBIPS/ZP5as0yckon8/kjGGZKRavbNFLLjI7LhGJ5/MMOXrVFmcCcc+il/Wjw3G/5wYbPAMA3COUjoecPqV1ynDAi0XsUEKv0r94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706000435; c=relaxed/simple;
	bh=0svduiBP+izLXYyEtAJohWESFuhORT2hBDiCUsVLtqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UMz6BQvkfSyzQiEDfQlX2COHPmWLBOwSEZR27gqQmTlyH02xY+0hvr8L5G6smhdcXvJeuwm2TD/iyqdtTgc5Pzxoqfmiq8FiNlQEGW/4uCeqzCYQDZcbyJVraQfrR5DIJ6WN4Aqgg06uI9/4Q0s6sI2bPeLEa+MGHTBIuEUMxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6tnzK6m; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706000433; x=1737536433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0svduiBP+izLXYyEtAJohWESFuhORT2hBDiCUsVLtqM=;
  b=I6tnzK6mFiHtaDKcjgkrBqkPDvD2HLnwkClrBJzxr3zwWl7A1U2okl4x
   pQwyO9F38D7xse/cB/APYSzlxLnAVsyWeIol9cpYbUomJnBKelHbxkElo
   ErJf9WN632IyZuJ9HcTuzMSsv/L45/YAvzJLEx95egWDplcamGOfxawNY
   cwgC5kYcNRFPNnFboWSayDSJgFSxZqW7dhanwUAYwpcvRr5U5POw7w8su
   K3zK3jns8aodvjb/t7/9ZMM6YGtvrF0EpMF5bf/LveuCiH7Th+lNaGJoM
   3g7fxAEz/O9rWZ4Hsrs4LCmQVN5dCcL4mHrxNMUQS/6fOv4/dRaxtE3fe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="400314541"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="400314541"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 01:00:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1522808"
Received: from abityuts-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.41.26])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 01:00:27 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [RFC] PCI/AER: Block runtime suspend when handling errors
Date: Tue, 23 Jan 2024 10:00:16 +0100
Message-Id: <20240123090016.281252-1-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PM runtime can be done simultaneously with AER error handling.
Avoid that by using pm_runtime_get_sync() just after pci_dev_get()
and pm_runtime_put() just before pci_dev_put() in AER recovery
procedures.

I'm not sure about DPC case since I do not see get/put there. It
just call pci_do_recovery() from threaded irq dcd_handler().
I think pm_runtime* should be added to this handler as well.

pm_runtime_get_sync() will increase dev->power.usage_count counter to
prevent any rpm actives. When there is suspending pending, it will wait
for it and do the rpm resume. Not sure if that problem, on my testing
I did not encounter issues with that.

I tested with igc device by doing simultaneous aer_inject and 
rpm suspend/resume via /sys/bus/pci/devices/PCI_ID/power/control
and can reproduce: 

[  853.253938] igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
[  853.253973] pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
[  853.253996] pcieport 0000:00:1c.2: AER: subordinate device reset failed
[  853.254099] pcieport 0000:00:1c.2: AER: device recovery failed
[  853.254178] igc 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible

The problem disappears when applied this patch.

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 8 ++++++++
 drivers/pci/pcie/edr.c | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 42a3bd35a3e1..9b56460edc76 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -813,6 +814,7 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 {
 	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
 		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
+		pm_runtime_get_sync(&dev->dev);
 		e_info->error_dev_num++;
 		return 0;
 	}
@@ -1111,6 +1113,8 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
 	cxl_rch_handle_error(dev, info);
 	pci_aer_handle_error(dev, info);
+
+	pm_runtime_put(&dev->dev);
 	pci_dev_put(dev);
 }
 
@@ -1143,6 +1147,8 @@ static void aer_recover_work_func(struct work_struct *work)
 			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
 			continue;
 		}
+		pm_runtime_get_sync(&pdev->dev);
+
 		pci_print_aer(pdev, entry.severity, entry.regs);
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being allocated from the
@@ -1159,6 +1165,8 @@ static void aer_recover_work_func(struct work_struct *work)
 		else if (entry.severity == AER_FATAL)
 			pcie_do_recovery(pdev, pci_channel_io_frozen,
 					 aer_root_reset);
+
+		pm_runtime_put(&pdev->dev);
 		pci_dev_put(pdev);
 	}
 }
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index 5f4914d313a1..bd96babd7249 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -10,6 +10,7 @@
 
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
+#include <linux/pm_runtime.h>
 
 #include "portdrv.h"
 #include "../pci.h"
@@ -169,6 +170,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 		return;
 	}
 
+	pm_runtime_get_sync(&edev->dev);
 	pci_dbg(pdev, "Reported EDR dev: %s\n", pci_name(edev));
 
 	/* If port does not support DPC, just send the OST */
@@ -209,6 +211,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 		acpi_send_edr_status(pdev, edev, EDR_OST_FAILED);
 	}
 
+	pm_runtime_put(&edev->dev);
 	pci_dev_put(edev);
 }
 
-- 
2.34.1


