Return-Path: <linux-pci+bounces-32924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5C6B11A2B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 10:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628911C861F5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 08:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9EB277CA2;
	Fri, 25 Jul 2025 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYKtBw6V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69DC2376FD;
	Fri, 25 Jul 2025 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433105; cv=none; b=ZmkHQuH6D+gXHU6nSozcjNAJPAKg3iVehGWlXRl7f3sSkkHuuUZpczWlhKrbuZ8V2AVYO3RoL8JvNKWmG8TCJi8Izc1asg7eOoS3kUGgHB/BQBRmE/PlmFI8MNEQo6plXyJmGSUDERYaoBulF2zCY++UXg58pZ+b7Epnh2nOc6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433105; c=relaxed/simple;
	bh=Z54MU4uAq8FcQF8kT3zCUU+M3jDpITVm7P0r4/+tI2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBRpg1k+T3fmlr9gjU5FDmu9osvBG1YYQitv6gr6iZrw4kv7/2nALqZHeGbUBEOwBSf1yPYmdO9LZQpfT+/Q1i98Wbex4E7UcGvtnuQYMIM7eaWQvoYWaMiqjxLV2bFPh3CFCqKF4F1lo4GnC735OWrIQrxKwTIiJqRv2cl73wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYKtBw6V; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753433103; x=1784969103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z54MU4uAq8FcQF8kT3zCUU+M3jDpITVm7P0r4/+tI2E=;
  b=LYKtBw6Vm3hpDn6tZWD91QhFGejwTzmik3EU+U9Q/wH90h+/VSMPfGgM
   Ff0Xjgh1j/FybbfSO9Q+L9rosgXvR84OgfLyJ7rnaWRiYmRWJ5zWO4CFY
   xizmiqzQ9GTCyo3sBZxuiPHr2BFw+ESR1QykTGLfb3FmG3qwxKY4yNnCD
   a/8A76ImjcVSwQaX+Zxr3QHgM5HqGQMlL5tUGGhQN0gTSEWoNilbN+hXt
   3T8IwjSgRDhgXjcuRi0wB5Lb/a94CPozyZ1wLgujYBBmWSqnzAFbIE2MS
   PIPErOrAzpPL8efj0IQBwQmDWrs2TgZyQtfXAq0ZaE7B0cL0dbUiCN5ZE
   Q==;
X-CSE-ConnectionGUID: o131pEWsQFi2tHp7ppTpRA==
X-CSE-MsgGUID: jd8MUIt+T+KjvHZzLFkDjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55864821"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55864821"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 01:45:03 -0700
X-CSE-ConnectionGUID: x218zPXtT9uDLDQQ1RbWyA==
X-CSE-MsgGUID: YPORv5rmSj+Cs3mleHo2lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166219414"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jul 2025 01:45:00 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v6] Bluetooth: btintel_pcie: Add support for _suspend() / _resume()
Date: Fri, 25 Jul 2025 14:31:33 +0530
Message-ID: <20250725090133.1358775-1-kiran.k@intel.com>
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
[Fri Jul 25 11:05:37 2025] Bluetooth: hci0: device entered into d3 state from d0 in 80 us

On system resume:
[Fri Jul 25 11:06:36 2025] Bluetooth: hci0: device entered into d0 state from d3 in 7117 us

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
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

 drivers/bluetooth/btintel_pcie.c | 90 ++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 6e7bbbd35279..c419521493fe 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2573,11 +2573,101 @@ static void btintel_pcie_coredump(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct btintel_pcie_data *data;
+	ktime_t start;
+	u32 dxstate;
+	s64 delta_us;
+	int err;
+
+	data = pci_get_drvdata(pdev);
+
+	dxstate = (mesg.event == PM_EVENT_SUSPEND ?
+		   BTINTEL_PCIE_STATE_D3_HOT : BTINTEL_PCIE_STATE_D3_COLD);
+
+	data->gp0_received = false;
+
+	start = ktime_get();
+
+	/* Refer: 6.4.11.7 -> Platform power management */
+	btintel_pcie_wr_sleep_cntrl(data, dxstate);
+	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
+				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
+	if (err == 0) {
+		bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrupt for D3 entry",
+				BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+		return -EBUSY;
+	}
+
+	delta_us = ktime_to_ns(ktime_get() - start) / 1000;
+	bt_dev_info(data->hdev, "device entered into d3 state from d0 in %lld us",
+		    delta_us);
+	return 0;
+}
+
+static int btintel_pcie_suspend(struct device *dev)
+{
+	return btintel_pcie_suspend_late(dev, PMSG_SUSPEND);
+}
+
+static int btintel_pcie_hibernate(struct device *dev)
+{
+	return btintel_pcie_suspend_late(dev, PMSG_HIBERNATE);
+}
+
+static int btintel_pcie_freeze(struct device *dev)
+{
+	return btintel_pcie_suspend_late(dev, PMSG_FREEZE);
+}
+
+static int btintel_pcie_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct btintel_pcie_data *data;
+	ktime_t start;
+	int err;
+	s64 delta_us;
+
+	data = pci_get_drvdata(pdev);
+	data->gp0_received = false;
+
+	start = ktime_get();
+
+	/* Refer: 6.4.11.7 -> Platform power management */
+	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
+	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
+				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
+	if (err == 0) {
+		bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrupt for D0 entry",
+				BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+		return -EBUSY;
+	}
+
+	delta_us = ktime_to_ns(ktime_get() - start) / 1000;
+	bt_dev_info(data->hdev, "device entered into d0 state from d3 in %lld us",
+		    delta_us);
+	return 0;
+}
+
+const struct dev_pm_ops btintel_pcie_pm_ops = {
+	.suspend = pm_sleep_ptr(btintel_pcie_suspend),
+	.resume = pm_sleep_ptr(btintel_pcie_resume),
+	.freeze = pm_sleep_ptr(btintel_pcie_freeze),
+	.thaw = pm_sleep_ptr(btintel_pcie_resume),
+	.poweroff = pm_sleep_ptr(btintel_pcie_hibernate),
+	.restore = pm_sleep_ptr(btintel_pcie_resume),
+};
+#endif
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


