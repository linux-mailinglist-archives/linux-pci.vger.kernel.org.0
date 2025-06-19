Return-Path: <linux-pci+bounces-30175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3C1AE01CF
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 11:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266DB174604
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 09:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E5D21CA04;
	Thu, 19 Jun 2025 09:37:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m32124.qiye.163.com (mail-m32124.qiye.163.com [220.197.32.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248021C9E0;
	Thu, 19 Jun 2025 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325879; cv=none; b=qu+rzz9PIeMp7Zxefv+7dkzbt8zM9TORpGCBO0606L6ZsN7gpnEVgW8xz9zY/fQpyEYMyykXa1hkDzCc0A5e4RXBPTWKk9nj5bzZul53RQgPx6kH99hp52FhyvbS81Y6ENzVvQE6vyhgPYTVayh3wZxiCxqour/IQK/2vkZUEro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325879; c=relaxed/simple;
	bh=mEBTu47aw5GvM+JvGHuuz9zrHjnrCHfVaTvuFpR7CC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKn2MKCqf4UNkWqv5L3fy6Oa4Ml82qG9T2h32fHFLQHP7UKxnbBq6NwZh94yoDeZ6uAUQsJsAppas27QckvGhQvVupct+CEPHMFOJqbPciNQhMo2GXE1945TmWW4B6vUGtiJaaq5NSB/n9a85A+hZlJpwI0ACa7ZRNMBg+tJCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; arc=none smtp.client-ip=220.197.32.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Received: from localhost.localdomain (unknown [122.224.147.158])
	by smtp.qiye.163.com (Hmail) with ESMTP id 193d4dd7c;
	Thu, 19 Jun 2025 17:32:34 +0800 (GMT+08:00)
From: Hongbo Yao <andy.xu@hj-micro.com>
To: bhelgaas@google.com,
	lukas@wunner.de
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	peter.du@hj-micro.com,
	jemma.zhang@hj-micro.com,
	Hongbo Yao <andy.xu@hj-micro.com>
Subject: [RFC PATCH] PCI: pciehp: Replace fixed delay with polling for slot power-off
Date: Thu, 19 Jun 2025 17:32:28 +0800
Message-ID: <20250619093228.283171-1-andy.xu@hj-micro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSk4aVkJCTk8YGEhDHxgZTVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUpPTFVKTkNZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTEpVSk
	tLVUpCS0tZBg++
X-HM-Tid: 0a9787886cc303afkunm9e7d02ee206d1a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NiI6Mjo6CjEzAjc0N0o#Ix4a
	KE4aChZVSlVKTE5LSElOTk5OT0NCVTMWGhIXVRoVHwJVAw47ExFWFhIYCRRVGBQWRVlXWRILWUFZ
	SklJVUlJT1VKT0xVSk5DWVdZCAFZQUJDSk03Bg++

Fixed 1-second delay in remove_board() fails to accommodate certain
hardware like multi-host OCP cards, which exhibit longer power-off
latencies.

Failure scenario:
1. Software clears pending_events prematurely
2. Hardware triggers DLLSC after software clearance
3. Subsequent power-off process may generate AER interrupts
4. System misinterprets residual DLLSC as valid hotplug event

Fix this by replacing the fixed delay with polling for DLLLA bit in
the link status register.

Logs before fix:
[157.778307] pcieport 0003:00:00.0: pciehp: pending interrupts 0x0001 from Slot Status
[157.778321] pcieport 0003:00:00.0: pciehp: Slot(31): Attention button pressed
[157.785445] pcieport 0003:00:00.0: pciehp: Slot(31): Powering off due to button press
[157.798931] pcieport 000b:00:02.0: pciehp: pending interrupts 0x0001 from Slot Status
[157.799263] pcieport 0003:00:00.0: pciehp: pciehp_set_indicators: SLOTCTRL 88 write cmd 2c0
[157.799273] pcieport 000b:00:02.0: pciehp: Slot(113): Attention button pressed
[157.800484] pcieport 000b:00:02.0: pciehp: Slot(113): Powering off due to button press
[157.800830] pcieport 000b:00:02.0: pciehp: pciehp_set_indicators: SLOTCTRL 88 write cmd 2c0
[162.850249] pcieport 0003:00:00.0: pciehp: pciehp_get_power_status: SLOTCTRL 88 value read 12e1
[162.850251] pcieport 000b:00:02.0: pciehp: pciehp_get_power_status: SLOTCTRL 88 value read 12e1
[162.850253] pcieport 0003:00:00.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0003:01:00
[162.850254] pcieport 000b:00:02.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 000b:02:00
[162.850278] mlx5_core 000b:02:00.1: PME# disabled
[164.862362] mlx5_core 000b:02:00.1: E-Switch: cleanup
[165.171541] mlx5_core 000b:02:00.1: disabling bus mastering
[165.171591] mlx5_core 000b:02:00.0: PME# disabled
[167.214351] mlx5_core 000b:02:00.0: E-Switch: cleanup
[167.539871] mlx5_core 000b:02:00.0: disabling bus mastering
[167.540342] pcieport 000b:00:02.0: pciehp: pciehp_power_off_slot: SLOTCTRL 88 write cmd 400
[167.540345] mlx5_core 0003:01:00.1: PME# disabled
[168.546269] pcieport 000b:00:02.0: pciehp: pciehp_set_indicators: SLOTCTRL 88 write cmd 300
[169.590320] mlx5_core 0003:01:00.1: E-Switch: cleanup
[169.899852] mlx5_core 0003:01:00.1: disabling bus mastering
[169.899241] mlx5_core 0003:01:00.0: PME# disabled
[171.870344] mlx5_core 0003:01:00.0: E-Switch: cleanup
[172.289046] mlx5_core 0003:01:00.0: disabling bus mastering
[172.289366] pcieport 0003:00:00.0: pciehp: pciehp_power_off_slot: SLOTCTRL 88 write cmd 400
[172.302385] pcieport 0003:00:00.0: AER: Corrected error message received from 0003:00:00.0
[172.302396] pcieport 000b:00:02.0: AER: Corrected error message received from 000b:00:02.0
[172.310641] pcieport 0003:00:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
[172.310892] pcieport 000b:00:02.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
[172.310893] pcieport 0003:00:00.0:   device [0823:0110] error status/mask=00000001/0000e000
[172.310894] pcieport 0003:00:00.0:    [ 0] RxErr
[172.310893] pcieport 000b:00:02.0:   device [0823:0112] error status/mask=00000001/0000e000
[172.310894] pcieport 000b:00:02.0:    [ 0] RxErr                  (First)
[172.332915] pcieport 0003:00:00.0: pciehp: pending interrupts 0x0100 from Slot Status
[172.353876] pcieport 000b:00:02.0: pciehp: pending interrupts 0x0100 from Slot Status
[172.360212] pcieport 000b:00:02.0: pciehp: pciehp_check_link_active: lnk_status = d011
[172.360362] pcieport 000b:00:02.0: pciehp: Slot(113): Card present
[172.374314] pcieport 000b:00:02.0: pciehp: pciehp_get_power_status: SLOTCTRL 88 value read 17e1
[172.374357] pcieport 000b:00:02.0: pciehp: pciehp_power_on_slot: SLOTCTRL 88 write cmd 0
[172.374383] pcieport 000b:00:02.0: pciehp: pciehp_set_indicators: SLOTCTRL 88 write cmd 200
[173.314226] pcieport 000b:00:02.0: pciehp: pciehp_set_indicators: SLOTCTRL 88 write cmd 300
[174.111245] pcieport 0003:00:00.0: pciehp: pending interrupts 0x0100 from Slot Status
[174.111232] pcieport 0003:00:00.0: pciehp: pciehp_check_link_active: lnk_status = f085
[174.111234] pcieport 0003:00:00.0: pciehp: Slot(31): Card present
[174.117136] pcieport 0003:00:00.0: pciehp: Slot(31): Link Up
[174.122963] pcieport 0003:00:00.0: pciehp: pciehp_get_power_status: SLOTCTRL 88 value read 17e1
[174.122964] pcieport 0003:00:00.0: pciehp: pciehp_power_on_slot: SLOTCTRL 88 write cmd 0
[174.122967] pcieport 0003:00:00.0: pciehp: pciehp_set_indicators: SLOTCTRL 88 write cmd 200

Logs after fix:
[143.610100] pcieport 000b:00:02.0: pciehp: pending interrupts 0x0001 from Slot Status
[143.616525] pcieport 0003:00:00.0: pciehp: pending interrupts 0x0001 from Slot Status
[143.629921] pcieport 000b:00:02.0: pciehp: Slot(113): Attention button pressed
[143.629923] pcieport 000b:00:02.0: pciehp: Slot(113): Powering off due to button press
[143.629926] pcieport 000b:00:02.0: pciehp: pciehp_set_indicators: SLOTCTRL 88 write cmd 2c0
[143.651725] pcieport 0003:00:00.0: pciehp: Slot(31): Attention button pressed
[143.658848] pcieport 0003:00:00.0: pciehp: Slot(31): Powering off due to button press
[143.666666] pcieport 0003:00:00.0: pciehp: pciehp_set_indicators: SLOTCTRL 88 write cmd 2c0
[148.863526] pcieport 000b:00:02.0: pciehp: pciehp_get_power_status: SLOTCTRL 88 value read 12e1
[148.870562] pcieport 0003:00:00.0: pciehp: pciehp_get_power_status: SLOTCTRL 88 value read 12e1
[148.870572] pcieport 0003:00:00.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0003:01:00
[148.870579] pcieport 000b:00:02.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 000b:02:00
[148.870605] mlx5_core 0003:01:00.1: PME# disabled
[152.536968] mlx5_core 0003:01:00.1: E-Switch: cleanup
[152.877666] mlx5_core 0003:01:00.1: disabling bus mastering
[152.878202] mlx5_core 0003:01:00.0: PME# disabled
[156.592567] mlx5_core 0003:01:00.0: E-Switch: cleanup
[156.904767] mlx5_core 0003:01:00.0: disabling bus mastering
[156.905195] pcieport 0003:00:00.0: pciehp: pciehp_power_off_slot: SLOTCTRL 88 write cmd 400
[156.905231] mlx5_core 000b:02:00.1: PME# disabled
[160.360660] mlx5_core 000b:02:00.1: E-Switch: cleanup
[161.272871] mlx5_core 000b:02:00.1: disabling bus mastering
[161.273719] mlx5_core 000b:02:00.0: PME# disabled
[165.028632] mlx5_core 000b:02:00.0: E-Switch: cleanup
[165.454213] mlx5_core 000b:02:00.0: disabling bus mastering
[165.454925] pcieport 000b:00:02.0: pciehp: pciehp_power_off_slot: SLOTCTRL 88 write cmd 400
[165.464333] pcieport 0003:00:00.0: AER: Corrected error message received from 0003:00:00.0
[165.478716] pcieport 000b:00:02.0: AER: Corrected error message received from 000b:00:02.0
[165.481156] pcieport 0003:00:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
[165.481158] pcieport 0003:00:00.0:   device [0823:0110] error status/mask=00000001/0000e000
[165.481166] pcieport 0003:00:00.0:    [ 0] RxErr                  (First)
[165.528873] pcieport 000b:00:02.0: pciehp: pending interrupts 0x0001 from Slot Status
[165.535384] pcieport 0003:00:00.0: pciehp: pending interrupts 0x0100 from Slot Status
[165.535403] pcieport 000b:00:02.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
[165.535403] pcieport 000b:00:02.0:   device [0823:0112] error status/mask=00000001/0000e000
[165.541315] pcieport 0003:00:00.0: pciehp: pciehp_set_indicators: SLOTCTRL 88 write cmd 300
[165.550871] pcieport 0003:00:00.0:    [ 0] RxErr                  (First)
[165.578591] pcieport 000b:00:02.0: pciehp: pciehp_set_indicators: SLOTCTRL 88 write cmd 300

Signed-off-by: Hongbo Yao <andy.xu@hj-micro.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index bcc938d4420f..179ebe4f7797 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -30,6 +30,25 @@
 #define SAFE_REMOVAL	 true
 #define SURPRISE_REMOVAL false
 
+static void pciehp_wait_for_link_inactive(struct controller *ctrl)
+{
+	u16 lnk_status;
+	int timeout = 10000, step = 20;
+
+	do {
+		pcie_capability_read_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
+					  &lnk_status);
+
+		if (!(lnk_status & PCI_EXP_LNKSTA_DLLLA))
+			return;
+
+		msleep(step);
+		timeout -= step;
+	} while (timeout >= 0);
+
+	ctrl_dbg(ctrl, "Timeout waiting for link inactive state\n");
+}
+
 static void set_slot_off(struct controller *ctrl)
 {
 	/*
@@ -119,8 +138,11 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
 		 * After turning power off, we must wait for at least 1 second
 		 * before taking any action that relies on power having been
 		 * removed from the slot/adapter.
+		 *
+		 * Extended wait with polling to ensure hardware has completed
+		 * power-off sequence.
 		 */
-		msleep(1000);
+		pciehp_wait_for_link_inactive(ctrl);
 
 		/* Ignore link or presence changes caused by power off */
 		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
-- 
2.43.0


