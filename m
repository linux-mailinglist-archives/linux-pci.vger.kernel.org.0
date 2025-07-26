Return-Path: <linux-pci+bounces-32967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EACB12B6A
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 18:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7A94E81EB
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62EDCA5E;
	Sat, 26 Jul 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kwt0M5pu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC9286D79;
	Sat, 26 Jul 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753547025; cv=none; b=P9GX1kGvq3md9DrxkN0dTqLibeTjncEoTZTpVf/U8EyKk99efftvE9ZBfnbt3mz1BMTiyeb0nXvwE/AVOSzL1mJpJ0kgAiu19kSGtjCpfpGjVfYQYWdE4FlxgLAkJ+Buq+ZiF7U5ppp+P/Tro3JyEq5LHKbX4+48iycU7AAPOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753547025; c=relaxed/simple;
	bh=Sypf+5CdDmxRReOhTZVpkic/R1lD7L6+qTUs+UfFOY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RTq332m10MwVJBV2imKmG/7JNrDmmdyFlahT7l1WEiXRtcqLq0+ULvC4WNfRXKwNDRqKM6zIQprDqmG5rxX/qPB05/zF+CBW2v9RpgVDY255VAPLZMKQWrcRXD4qjHaql8H5kuORAfIF6GsYVKitMvkfnjma1tkZLAq5yzG/3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kwt0M5pu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753547024; x=1785083024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sypf+5CdDmxRReOhTZVpkic/R1lD7L6+qTUs+UfFOY4=;
  b=Kwt0M5pu6Ca20gn/GIGQ985NmHsucWmZmKl+rYa5xUVjkN10YvO3j812
   Ql+DDQ1wTtbzbYO7tbZNYMEpZBI80jjUmFtz7lL44OO+I3N6XT0CojinP
   /W8pjWTZ5AARLJFSJdXwdDu0iiGA9YRmt2VUwAv5dxBlhzihoEgT5MpOJ
   86rH2ghG03d2MBlr7+agSvJfMkcDVtlFw4qPokTHRwNjt1jlMRNdse6cs
   8e8OWzrapwwXRkY8WqT0sKylOr3o7dTucH69xtkbGg1H9sMpO5QGgfWK3
   PctC4edpwgEbHIbHvpvMnno4zFIinD1Pw/OsU6F7B/tsf+xfjFBwfpGx2
   A==;
X-CSE-ConnectionGUID: m9+irkPMTGWja785HXQ12w==
X-CSE-MsgGUID: sgExpCWNTmK/5ECct8Zjyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55793806"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55793806"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 09:23:43 -0700
X-CSE-ConnectionGUID: zNmjsx+XQMi+p9MMiFyDAg==
X-CSE-MsgGUID: 26CV5UfXTGCGXcvlnR0Dcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166132815"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 26 Jul 2025 09:23:40 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v7] Bluetooth: btintel_pcie: Add support for _suspend() / _resume()
Date: Sat, 26 Jul 2025 22:10:12 +0530
Message-ID: <20250726164012.1395970-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

This patch implements _suspend() and _resume() functions for the
Bluetooth controller. When the system enters a suspended state, the
driver notifies the controller to perform necessary housekeeping tasks
by writing to the sleep control register and waits for an alive
interrupt. The firmware raises the alive interrupt when it has
transitioned to the D3 state. The same flow occurs when the system
resumes.

Command to test host initiated wakeup after 60 seconds
sudo rtcwake -m mem -s 60

dmesg log (tested on Whale Peak2 on Panther Lake platform)
On system suspend:
[Fri Jul 25 11:05:37 2025] Bluetooth: hci0: device entered into d3 state
                                      from d0 in 80 us

On system resume:
[Fri Jul 25 11:06:36 2025] Bluetooth: hci0: device entered into d0 state
                                      from d3 in 7117 us

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v7:
     - Use ktime_to_us() instead of ktime_to_ns() / 1000
     - Remove CONFIG_PM_SLEEP and instead use pm_sleep_ptr() and pm_ptr()
     - Use __maybe_unused to avoid compiler warnings if CONFIG_PM_SLEEP and/or
       CONFIG_PM are not defined
     - Use parenthesis for only conditon in ternary operator
     - Include reviewers in commit message

changes in v6:
     - s/delta/delta_us/g
     - s/CONFIG_PM/CONFIG_PM_SLEEP/g
     - use pm_sleep_pr()/pm_str() to avoid #ifdefs
     - remove the code to set persistance mode as its not relevant to this patch

changes in v5:
     - refactor _suspend() / _resume() to set the D3HOT/D3COLD based on power
       event
     - remove SIMPLE_DEV_PM_OPS and define the required pm_ops callback
       functions

changes in v4:
     - Moved document and section details from the commit message as comment in code.

changes in v3:
     - Corrected the typo's
     - Updated the CC list as suggested.
     - Corrected the format specifiers in the logs.

changes in v2:
     - Updated the commit message with test steps and logs.
     - Added logs to include the timeout message.
     - Fixed a potential race condition during suspend and resume.

 drivers/bluetooth/btintel_pcie.c | 95 ++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index d08f59ae7720..fc48cd878406 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2574,11 +2574,106 @@ static void btintel_pcie_coredump(struct device *dev)
 }
 #endif
 
+static int __maybe_unused btintel_pcie_suspend_late(struct device *dev,
+						    pm_message_t mesg)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct btintel_pcie_data *data;
+	unsigned long timeout;
+	struct hci_dev *hdev;
+	ktime_t start;
+	u32 dxstate;
+	s64 delta_us;
+	int err;
+
+	data = pci_get_drvdata(pdev);
+	hdev = data->hdev;
+
+	dxstate = (mesg.event == PM_EVENT_SUSPEND) ? BTINTEL_PCIE_STATE_D3_HOT :
+		BTINTEL_PCIE_STATE_D3_COLD;
+
+	data->gp0_received = false;
+	timeout = msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+
+	start = ktime_get();
+
+	/* Refer: 6.4.11.7 -> Platform power management */
+	btintel_pcie_wr_sleep_cntrl(data, dxstate);
+	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received, timeout);
+	if (err == 0) {
+		bt_dev_err(hdev, "Timeout (%u ms) on alive interrupt for D3 entry",
+			   BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+		return -EBUSY;
+	}
+
+	delta_us = ktime_to_us(ktime_get() - start);
+	bt_dev_info(hdev, "device entered into d3 state from d0 in %lld us",
+		    delta_us);
+	return 0;
+}
+
+static int __maybe_unused btintel_pcie_suspend(struct device *dev)
+{
+	return btintel_pcie_suspend_late(dev, PMSG_SUSPEND);
+}
+
+static int __maybe_unused btintel_pcie_hibernate(struct device *dev)
+{
+	return btintel_pcie_suspend_late(dev, PMSG_HIBERNATE);
+}
+
+static int __maybe_unused btintel_pcie_freeze(struct device *dev)
+{
+	return btintel_pcie_suspend_late(dev, PMSG_FREEZE);
+}
+
+static int __maybe_unused btintel_pcie_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct btintel_pcie_data *data;
+	unsigned long timeout;
+	struct hci_dev *hdev;
+	ktime_t start;
+	int err;
+	s64 delta_us;
+
+	data = pci_get_drvdata(pdev);
+	hdev = data->hdev;
+	data->gp0_received = false;
+	timeout = msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+
+	start = ktime_get();
+
+	/* Refer: 6.4.11.7 -> Platform power management */
+	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
+	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received, timeout);
+	if (err == 0) {
+		bt_dev_err(hdev, "Timeout (%u ms) on alive interrupt for D0 entry",
+			   BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+		return -EBUSY;
+	}
+
+	delta_us = ktime_to_us(ktime_get() - start);
+	bt_dev_info(hdev, "device entered into d0 state from d3 in %lld us",
+		    delta_us);
+	return 0;
+}
+
+static const struct dev_pm_ops __maybe_unused btintel_pcie_pm_ops = {
+	.suspend = pm_sleep_ptr(btintel_pcie_suspend),
+	.resume = pm_sleep_ptr(btintel_pcie_resume),
+	.freeze = pm_sleep_ptr(btintel_pcie_freeze),
+	.thaw = pm_sleep_ptr(btintel_pcie_resume),
+	.poweroff = pm_sleep_ptr(btintel_pcie_hibernate),
+	.restore = pm_sleep_ptr(btintel_pcie_resume),
+};
+
 static struct pci_driver btintel_pcie_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = btintel_pcie_table,
 	.probe = btintel_pcie_probe,
 	.remove = btintel_pcie_remove,
+	.driver.pm = pm_ptr(&btintel_pcie_pm_ops),
 #ifdef CONFIG_DEV_COREDUMP
 	.driver.coredump = btintel_pcie_coredump
 #endif
-- 
2.43.0


