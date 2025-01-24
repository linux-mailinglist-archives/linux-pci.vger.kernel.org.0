Return-Path: <linux-pci+bounces-20320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2448EA1B23A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 10:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DB316DC00
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF2A218AD8;
	Fri, 24 Jan 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJVSiE1S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA92219A89;
	Fri, 24 Jan 2025 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709202; cv=none; b=WMgbFheJhjZHmJL3y+m1LIgNRWl+SfZaWawlAEvjs63yw0cQa6lrLxZGqowRQqXN9cuCsZqXUdYW9DjIHVVX2Gq4uMfTMZ7ZmgZXWLuCuFpXtlWSOV4me8ENPiaFKD1WWCHpK5ybvsmkT9uRZ7ylDi1iyaKXUCJ8Ra8Wc0cR9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709202; c=relaxed/simple;
	bh=mmZFt69Qzgta/1mBLoi34q+l+yJxj/yyDWj0oHtn0VQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O9Bp8AHLG2ZAnurUq1789I5qe9iw0/CUMMBrDTWEJbUxLNRZqhAI5ytS+4XI/2XIWDYWeY9uSiIvcYE5nd/5dT218mHA80Yh0ooaMlPCoYX+B9C/43NUBfY7T5T8aasD6yjj+GsNLPBCBmavmboRuFJDgvltiBfXByyroDmPY8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJVSiE1S; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737709201; x=1769245201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mmZFt69Qzgta/1mBLoi34q+l+yJxj/yyDWj0oHtn0VQ=;
  b=kJVSiE1SJA30ULyx5rXaRSAvC3h023algK0q0EI/LFR2YFIp6cehki76
   4Z9lEGAiH1KcWwqa5I0VdToLb6UPNfJJbL6R8/46Ks44NY0dMeUxDz6j5
   t2zDDDeWGNmHlK8aWCvU79SKBdrcSiYy7WyESoPNGEHmIh7k/rMvGW4zr
   b7bxuk6A6RcCtycuiE2Y7NCh5Hf91MXIBwhhZvU0ALgVggqo+ixXbSUdw
   jTteOTW4j1PJln9tLyN1J8uw/7X5xkpPGxiO6mPMAtPgKvWMYnGqBN3DC
   dh2ya24N4ePB69VvFKrA6TLdy+jKokv4cP3fHs8X+L4dlR7sNzPQ1Qz+8
   w==;
X-CSE-ConnectionGUID: S9Mli3AjT7Oo3CQs8b85ZQ==
X-CSE-MsgGUID: KtE2a3x+RTqOmlLPk18aGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="55651353"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="55651353"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 01:00:00 -0800
X-CSE-ConnectionGUID: hQkSYB4pRd6jIWl994dauA==
X-CSE-MsgGUID: I3my9BlWR/qWbIjB338kug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="131006301"
Received: from unknown (HELO BSINU234.iind.intel.com) ([10.66.226.146])
  by fmviesa002.fm.intel.com with ESMTP; 24 Jan 2025 00:59:57 -0800
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	ChandraShekar Devegowda <chandrashekar.devegowda@intel.com>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3] Bluetooth: btintel_pcie: Support suspend-resume
Date: Fri, 24 Jan 2025 16:45:27 +0200
Message-Id: <20250124144527.3159972-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ChandraShekar Devegowda <chandrashekar.devegowda@intel.com>

This patch contains the changes in driver for vendor specific handshake
during enter of D3 and D0 exit.

The implementation is as per the Intel SAS document:
BT Platform Power Management SAS - IOSF and the specific sections are
3.1 D0Exit (D3 Entry) Flow
3.2 D0Entry (D3 Exit) Flow

Command to test host initiated wakeup after 60 seconds
    sudo rtcwake -m mem -s 60

logs from testing:
    Bluetooth: hci0: BT device resumed to D0 in 1016 usecs

Signed-off-by: ChandraShekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v3:
    - Corrected the typo's
    - Updated the CC list as suggested.
    - Corrected the format specifiers in the logs.

changes in v2:
    - Updated the commit message with test steps and logs.
    - Added logs to include the timeout message.
    - Fixed a potential race condition during suspend and resume.

 drivers/bluetooth/btintel_pcie.c | 58 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie.h |  4 +++
 2 files changed, 62 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 63eca52c0e0b..9e1d2a999f2f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -274,6 +274,12 @@ static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
 	return reg == 0 ? 0 : -ENODEV;
 }
 
+static void btintel_pcie_set_persistence_mode(struct btintel_pcie_data *data)
+{
+	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_HW_BOOT_CONFIG,
+				  BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON);
+}
+
 /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT bit in
  * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
  * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
@@ -298,6 +304,8 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
 	 */
 	data->boot_stage_cache = 0x0;
 
+	btintel_pcie_set_persistence_mode(data);
+
 	/* Set MAC_INIT bit to start primary bootloader */
 	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
 	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
@@ -1649,11 +1657,61 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 }
 
+static int btintel_pcie_suspend(struct device *dev)
+{
+	struct btintel_pcie_data *data;
+	int err;
+	struct  pci_dev *pdev = to_pci_dev(dev);
+
+	data = pci_get_drvdata(pdev);
+	data->gp0_received = false;
+	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D3_HOT);
+	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
+				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
+	if (!err) {
+		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for suspend in %d msecs",
+			   BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static int btintel_pcie_resume(struct device *dev)
+{
+	struct btintel_pcie_data *data;
+	struct  pci_dev *pdev = to_pci_dev(dev);
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+	int err;
+
+	data = pci_get_drvdata(pdev);
+	data->gp0_received = false;
+	calltime = ktime_get();
+	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
+	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
+				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
+	if (!err) {
+		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for resume in %d msecs",
+			   BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+		return -EBUSY;
+	}
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+	bt_dev_info(data->hdev, "BT device resumed to D0 in %llu usecs", duration);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(btintel_pcie_pm_ops, btintel_pcie_suspend,
+		btintel_pcie_resume);
+
 static struct pci_driver btintel_pcie_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = btintel_pcie_table,
 	.probe = btintel_pcie_probe,
 	.remove = btintel_pcie_remove,
+	.driver.pm = &btintel_pcie_pm_ops,
 };
 module_pci_driver(btintel_pcie_driver);
 
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index f9aada0543c4..38d0c8ea2b6f 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -8,6 +8,7 @@
 
 /* Control and Status Register(BTINTEL_PCIE_CSR) */
 #define BTINTEL_PCIE_CSR_BASE			(0x000)
+#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG		(BTINTEL_PCIE_CSR_BASE + 0x000)
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG		(BTINTEL_PCIE_CSR_BASE + 0x024)
 #define BTINTEL_PCIE_CSR_HW_REV_REG		(BTINTEL_PCIE_CSR_BASE + 0x028)
 #define BTINTEL_PCIE_CSR_RF_ID_REG		(BTINTEL_PCIE_CSR_BASE + 0x09C)
@@ -48,6 +49,9 @@
 #define BTINTEL_PCIE_CSR_MSIX_IVAR_BASE		(BTINTEL_PCIE_CSR_MSIX_BASE + 0x0880)
 #define BTINTEL_PCIE_CSR_MSIX_IVAR(cause)	(BTINTEL_PCIE_CSR_MSIX_IVAR_BASE + (cause))
 
+/* CSR HW BOOT CONFIG Register */
+#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON		(BIT(31))
+
 /* Causes for the FH register interrupts */
 enum msix_fh_int_causes {
 	BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0	= BIT(0),	/* cause 0 */
-- 
2.34.1


