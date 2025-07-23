Return-Path: <linux-pci+bounces-32812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF78B0F43F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6F71C8100D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF6A2E7BC8;
	Wed, 23 Jul 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkCKiO0B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C502E762A;
	Wed, 23 Jul 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278052; cv=none; b=jyutyvhMjHlXLG84E/cf+XMB42QkPm0vRJLqBJvm71Wt1yfEnFB6kEF8x2C8M8u+KmoyI5GYjawMNgXuQjLG8g/GixX8bdWANojCIv4/7VDJo8SutnGZl0DMgzFhGHgulP4cPllECJt5p/l84KkWZfVdK2Or3Ftcyp67pPpUGWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278052; c=relaxed/simple;
	bh=coLoLYxWLllvcdZbIRjO431b+308cMu89PGKwdtOb3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOS0OzzcgJfiavDxNL0uWh6pnI0i/h855nPVCsseL3kKN50JjAfQsNk3F1zg7q5WJgpujTNs8GnB2bIvsh42yERfa1YTPnsL+dBwE0l3J1Ztjag1jF7RheZ0bvjxK5HNRNTVhu+PoCoIElOnXHI9msJ+8qs1ByTzRpDW+lmlrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkCKiO0B; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753278050; x=1784814050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=coLoLYxWLllvcdZbIRjO431b+308cMu89PGKwdtOb3o=;
  b=UkCKiO0Bwkd6PLh5iaEYuSTTxn7M+DUbmnT0YfPYDd5yUdSz/sK8pMPg
   nknpJB/LmphiexTsJ9HNVjqEWTTF9JYpvT5Ho/XDnIK2Q7l/Cz6MTbBEH
   owSbS+K31/C78hGjkO0bll7P4+Nha8N+2+ctU/RHBYvNqylo/NWqMHVun
   FJUFCwGHmhQft6a9Gg3837gmLdObWKaCf6oze4AS3ByC1Lyd+4A6h1S7L
   pZYweV6z10GFSgIOm+lwCjBBQKFh6XYRpRQecI7Wg9ALwJ6hsxRS0K3RK
   x8vkRHDMstJe+tP61+Y4FNyk+kCxk28AbX78NVEBqmEAmGb8/jwL2Y+fD
   w==;
X-CSE-ConnectionGUID: mSCJ8HT5SQ2V+EPYohKJOw==
X-CSE-MsgGUID: HxiyGPwfRfqTh2739gY5Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="58175407"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="58175407"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:40:49 -0700
X-CSE-ConnectionGUID: r8XU4QRDQteAE1UuqzchEg==
X-CSE-MsgGUID: I5lzYzdbQ4GRu7SYbdmniw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159278054"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa009.jf.intel.com with ESMTP; 23 Jul 2025 06:40:47 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v5] Bluetooth: btintel_pcie: Add support for _suspend() / _resume()
Date: Wed, 23 Jul 2025 19:27:15 +0530
Message-ID: <20250723135715.1302241-1-kiran.k@intel.com>
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
[  516.418316] Bluetooth: hci0: device entered into d3 state from d0 in 81 us

On system resume:
[  542.174128] Bluetooth: hci0: device entered into d0 state from d3 in 357 us

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v5:
     - Address review comments

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

 drivers/bluetooth/btintel_pcie.c | 102 +++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie.h |   4 ++
 2 files changed, 106 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 6e7bbbd35279..a96975a55cbe 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -540,6 +540,12 @@ static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
 	return reg == 0 ? 0 : -ENODEV;
 }
 
+static void btintel_pcie_set_persistence_mode(struct btintel_pcie_data *data)
+{
+	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_HW_BOOT_CONFIG,
+				  BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON);
+}
+
 static void btintel_pcie_mac_init(struct btintel_pcie_data *data)
 {
 	u32 reg;
@@ -829,6 +835,8 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
 	 */
 	data->boot_stage_cache = 0x0;
 
+	btintel_pcie_set_persistence_mode(data);
+
 	/* Set MAC_INIT bit to start primary bootloader */
 	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
 	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
@@ -2573,11 +2581,105 @@ static void btintel_pcie_coredump(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM
+static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct btintel_pcie_data *data;
+	ktime_t start;
+	u32 dxstate;
+	s64 delta;
+	int err;
+
+	data = pci_get_drvdata(pdev);
+
+	if (mesg.event == PM_EVENT_SUSPEND)
+		dxstate = BTINTEL_PCIE_STATE_D3_HOT;
+	else
+		dxstate = BTINTEL_PCIE_STATE_D3_COLD;
+
+	data->gp0_received = false;
+
+	start = ktime_get();
+
+	/* Refer: 6.4.11.7 -> Platform power management */
+	btintel_pcie_wr_sleep_cntrl(data, dxstate);
+	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
+				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
+	delta = ktime_to_ns(ktime_get() - start) / 1000;
+
+	if (err == 0) {
+		bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrupt for D3 entry",
+				BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+		return -EBUSY;
+	}
+	bt_dev_info(data->hdev, "device entered into d3 state from d0 in %lld us",
+		    delta);
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
+	s64 delta;
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
+	delta = ktime_to_ns(ktime_get() - start) / 1000;
+
+	if (err == 0) {
+		bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrupt for D0 entry",
+				BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+		return -EBUSY;
+	}
+	bt_dev_info(data->hdev, "device entered into d0 state from d3 in %lld us",
+		    delta);
+	return 0;
+}
+
+const struct dev_pm_ops btintel_pcie_pm_ops = {
+	.suspend = btintel_pcie_suspend,
+	.resume = btintel_pcie_resume,
+	.freeze = btintel_pcie_freeze,
+	.thaw = btintel_pcie_resume,
+	.poweroff = btintel_pcie_hibernate,
+	.restore = btintel_pcie_resume,
+};
+#define BTINTELPCIE_PM_OPS	(&btintel_pcie_pm_ops)
+#else
+#define BTINTELPCIE_PM_OPS	NULL
+#endif
 static struct pci_driver btintel_pcie_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = btintel_pcie_table,
 	.probe = btintel_pcie_probe,
 	.remove = btintel_pcie_remove,
+	.driver.pm = BTINTELPCIE_PM_OPS,
 #ifdef CONFIG_DEV_COREDUMP
 	.driver.coredump = btintel_pcie_coredump
 #endif
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 0fa876c5b954..5bc69004b692 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -8,6 +8,7 @@
 
 /* Control and Status Register(BTINTEL_PCIE_CSR) */
 #define BTINTEL_PCIE_CSR_BASE			(0x000)
+#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG		(BTINTEL_PCIE_CSR_BASE + 0x000)
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG		(BTINTEL_PCIE_CSR_BASE + 0x024)
 #define BTINTEL_PCIE_CSR_HW_REV_REG		(BTINTEL_PCIE_CSR_BASE + 0x028)
 #define BTINTEL_PCIE_CSR_RF_ID_REG		(BTINTEL_PCIE_CSR_BASE + 0x09C)
@@ -55,6 +56,9 @@
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_ALIVE		(BIT(23))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY	(BIT(24))
 
+/* CSR HW BOOT CONFIG Register */
+#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON		(BIT(31))
+
 /* Registers for MSI-X */
 #define BTINTEL_PCIE_CSR_MSIX_BASE		(0x2000)
 #define BTINTEL_PCIE_CSR_MSIX_FH_INT_CAUSES	(BTINTEL_PCIE_CSR_MSIX_BASE + 0x0800)
-- 
2.43.0


