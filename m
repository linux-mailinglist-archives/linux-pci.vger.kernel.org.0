Return-Path: <linux-pci+bounces-31610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEF7AFB13B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 12:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7701AA3057
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 10:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC07192D97;
	Mon,  7 Jul 2025 10:30:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49194.qiye.163.com (mail-m49194.qiye.163.com [45.254.49.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B2156C6F;
	Mon,  7 Jul 2025 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751884231; cv=none; b=HalU1hb4e+ITqUO8R5JYNNKIyeD8uxPpUyVNBAOrrsTDgoKQ7bc2FfhaBUyJTcxh1EnkZyrHrUkMmyAkK9C38vyXxrLT/uOA4av1PZjaisqQlBLtHDc64/ArCqaxqJJIQsq98MdiYwScVDyvdeKllUnMwDjTxsmFP0MU2Ti2/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751884231; c=relaxed/simple;
	bh=wzvySkfSkJ4e8dwMvyxg2jF5Ke08l5dP7TDvrD6QV24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1oLQaLGMAptKG14K7XCs0rtJ4i88rdszk4rEBErJtPKWAjXLhBJe347giO7TtYqAEDEg1BkXHQXHj571yKITMVn1tHbV3IjEbo5X/qf1drS1Az9un4AtOSp5o1wW1RMTyHcF9MWJO06h6bH3pwUv6GnSQ80nir1pLQB5lPtp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; arc=none smtp.client-ip=45.254.49.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Received: from localhost.localdomain (unknown [122.224.147.158])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1b2c5dbcb;
	Mon, 7 Jul 2025 18:30:16 +0800 (GMT+08:00)
From: Andy Xu <andy.xu@hj-micro.com>
To: bhelgaas@google.com,
	lukas@wunner.de
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jemma.zhang@hj-micro.com,
	peter.du@hj-micro.com,
	Hongbo Yao <andy.xu@hj-micro.com>
Subject: [PATCH] PCI/DPC: Extend DPC recovery timeout
Date: Mon,  7 Jul 2025 18:30:14 +0800
Message-ID: <20250707103014.1279262-1-andy.xu@hj-micro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUsfVk4YShhOGRpCTExKHlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUpPTFVKTkNZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSENVSk
	tLVUpCS0tZBg++
X-HM-Tid: 0a97e46fb83003afkunmcba88557e5ad6a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PU06LBw6PTErETcvUUtKCTYI
	IwgaCiNVSlVKTE5KQ0NPSUpMSEJCVTMWGhIXVRoVHwJVAw47ExFWFhIYCRRVGBQWRVlXWRILWUFZ
	SklJVUlJT1VKT0xVSk5DWVdZCAFZQU1OT0k3Bg++

From: Hongbo Yao <andy.xu@hj-micro.com>

Extend the DPC recovery timeout from 4 seconds to 7 seconds to
support Mellanox ConnectX series network adapters.

My environment:
  - Platform: arm64 N2 based server
  - Endpoint1: Mellanox Technologies MT27800 Family [ConnectX-5]
  - Endpoint2: Mellanox Technologies MT2910 Family [ConnectX-7]

With the original 4s timeout, hotplug would still be triggered:

[ 81.012463] pcieport 0004:00:00.0: DPC: containment event, status:0x1f01 source:0x0000
[ 81.014536] pcieport 0004:00:00.0: DPC: unmasked uncorrectable error detected
[ 81.029598] pcieport 0004:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
[ 81.040830] pcieport 0004:00:00.0: device [0823:0110] error status/mask=00008000/04d40000
[ 81.049870] pcieport 0004:00:00.0: [ 0] ERCR (First)
[ 81.053520] pcieport 0004:00:00.0: AER: TLP Header: 60008010 010000ff 00001000 9c4c0000
[ 81.065793] mlx5_core 0004:01:00.0: mlx5_pci_err_detected Device state = 1 health sensors: 1 pci_status: 1. Enter, pci channel state = 2
[ 81.076183] mlx5_core 0004:01:00.0: mlx5_error_sw_reset:231:(pid 1618): start
[ 81.083307] mlx5_core 0004:01:00.0: mlx5_error_sw_reset:252:(pid 1618): PCI channel offline, stop waiting for NIC IFC
[ 81.077428] mlx5_core 0004:01:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
[ 81.486693] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid 1618): Skipping wait for vf pages stage
[ 81.496965] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid 1618): Skipping wait for vf pages stage
[ 82.395040] mlx5_core 0004:01:00.1: print_health:819:(pid 0): Fatal error detected
[ 82.395493] mlx5_core 0004:01:00.1: print_health_info:423:(pid 0): PCI slot 1 is unavailable
[ 83.431094] mlx5_core 0004:01:00.0: mlx5_pci_err_detected Device state = 2 pci_status: 0. Exit, result = 3, need reset
[ 83.442100] mlx5_core 0004:01:00.1: mlx5_pci_err_detected Device state = 2 health sensors: 1 pci_status: 1. Enter, pci channel state = 2
[ 83.441801] mlx5_core 0004:01:00.0: mlx5_crdump_collect:50:(pid 2239): crdump: failed to lock gw status -13
[ 83.454050] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:231:(pid 1618): start
[ 83.454050] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:252:(pid 1618): PCI channel offline, stop waiting for NIC IFC
[ 83.849429] mlx5_core 0004:01:00.1: E-Switch: Disable: mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
[ 83.858892] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid 1618): Skipping wait for vf pages stage
[ 83.869464] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid 1618): Skipping wait for vf pages stage
[ 85.201433] pcieport 0004:00:00.0: pciehp: Slot(41): Link Down
[ 85.815016] mlx5_core 0004:01:00.1: mlx5_health_try_recover:335:(pid 2239): handling bad device here
[ 85.824164] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:231:(pid 2239): start
[ 85.831283] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:252:(pid 2239): PCI channel offline, stop waiting for NIC IFC
[ 85.841899] mlx5_core 0004:01:00.1: mlx5_unload_one_dev_locked:1612:(pid 2239): mlx5_unload_one_dev_locked: interface is down, NOP
[ 85.853799] mlx5_core 0004:01:00.1: mlx5_health_wait_pci_up:325:(pid 2239): PCI channel offline, stop waiting for PCI
[ 85.863494] mlx5_core 0004:01:00.1: mlx5_health_try_recover:338:(pid 2239): health recovery flow aborted, PCI reads still not working
[ 85.873231] mlx5_core 0004:01:00.1: mlx5_pci_err_detected Device state = 2 pci_status: 0. Exit, result = 3, need reset
[ 85.879899] mlx5_core 0004:01:00.1: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
[ 85.921428] mlx5_core 0004:01:00.1: E-Switch: Disable: mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
[ 85.930491] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid 1617): Skipping wait for vf pages stage
[ 85.940849] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid 1617): Skipping wait for vf pages stage
[ 85.949971] mlx5_core 0004:01:00.1: mlx5_uninit_one:1528:(pid 1617): mlx5_uninit_one: interface is down, NOP
[ 85.959944] mlx5_core 0004:01:00.1: E-Switch: cleanup
[ 86.035541] mlx5_core 0004:01:00.0: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
[ 86.077568] mlx5_core 0004:01:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
[ 86.071727] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid 1617): Skipping wait for vf pages stage
[ 86.096577] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid 1617): Skipping wait for vf pages stage
[ 86.106909] mlx5_core 0004:01:00.0: mlx5_uninit_one:1528:(pid 1617): mlx5_uninit_one: interface is down, NOP
[ 86.115940] pcieport 0004:00:00.0: AER: subordinate device reset failed
[ 86.122557] pcieport 0004:00:00.0: AER: device recovery failed
[ 86.128571] mlx5_core 0004:01:00.0: E-Switch: cleanup

I added some prints and found that:
 - ConnectX-5 requires >5s for full recovery
 - ConnectX-7 requires >6s for full recovery

Setting timeout to 7s covers both devices with safety margin.

Signed-off-by: Hongbo Yao <andy.xu@hj-micro.com>
---
 drivers/pci/pcie/dpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index fc18349614d7..35a37fd86dcd 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -118,10 +118,10 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
 	/*
 	 * Need a timeout in case DPC never completes due to failure of
 	 * dpc_wait_rp_inactive().  The spec doesn't mandate a time limit,
-	 * but reports indicate that DPC completes within 4 seconds.
+	 * but reports indicate that DPC completes within 7 seconds.
 	 */
 	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
-			   msecs_to_jiffies(4000));
+			   msecs_to_jiffies(7000));
 
 	return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
 }
-- 
2.43.0


