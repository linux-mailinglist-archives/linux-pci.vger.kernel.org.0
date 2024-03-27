Return-Path: <linux-pci+bounces-5262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE3588E49B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 15:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0DC1C22CDE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 14:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465E11BB728;
	Wed, 27 Mar 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AppGaFmR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCF41BB722;
	Wed, 27 Mar 2024 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542541; cv=none; b=JajC3oSYiKEDhlZ311ECJJ5q7lao1ptZmBHUfD+Qandr6nsR6ns6bLAXBdsUZCNRsTaK9SW8c7R+CYL2/K9vWmPrYEj6vMXfrLCmMwrWRPHtgiR1yDdN5QHbPphn2RqiTqhqDAJYMemb+caQpN30PUC6YpRLrP8Miq7RwgVCcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542541; c=relaxed/simple;
	bh=OLO7jFtRnqCvGjaFIBp+QZLU7tw94zPs0lRQffBxt6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uK1SMZaNtysvNOECmgjZpuU13MnTxO+hz3jSvdPlOhYFXvgV3p/hEqgu0A1J/vhnkR/II60CfZcmySTPqZ1Wdl5/nBdcPOnRkP3l4pNpmsps/2ydejl8ThkCxqWLjiYT0sSSz0JagiiJeKUEYdc8fC5BmEVtXrTsuZ1Gd1CRB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AppGaFmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9704DC433C7;
	Wed, 27 Mar 2024 12:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542540;
	bh=OLO7jFtRnqCvGjaFIBp+QZLU7tw94zPs0lRQffBxt6U=;
	h=From:To:Cc:Subject:Date:From;
	b=AppGaFmR5g0QIc9/R86oeMsfxlOXo5Z4GU4Gfl9XlcXYx4jrEIZhCCnk13OLTBfIG
	 DOJx/OpA1knbzGSFxwmEr4ocGz5uFpF7Q+cvf/raoO9Y+rqeNIrFa5i9BwySKQFZ7m
	 8A34M0Jps4gXtPsnav7SmVXb7JD2u4LGLGj+C3IZaWKCbZ47xEk4yJ+qpg8bWhuH1m
	 Nx9p25TUFk6yNBijRn+4XE6CQmURKVX3H9ARyPcpR/gIgToUlqBSs72cuG9UU6Why9
	 B7tqe5tz7w/ihTAoQo1Qt8t7/0K3K0VHGWf1vIZ1Tmxklepp2yTqf/eIrJ+2VHs519
	 MtxCVvIWLnQBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stanislaw.gruszka@linux.intel.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "PCI/AER: Block runtime suspend when handling errors" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:28:58 -0400
Message-ID: <20240327122858.2843164-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 002bf2fbc00e5c4b95fb167287e2ae7d1973281e Mon Sep 17 00:00:00 2001
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Date: Mon, 12 Feb 2024 13:01:35 +0100
Subject: [PATCH] PCI/AER: Block runtime suspend when handling errors

PM runtime can be done simultaneously with AER error handling.  Avoid that
by using pm_runtime_get_sync() before and pm_runtime_put() after reset in
pcie_do_recovery() for all recovering devices.

pm_runtime_get_sync() will increase dev->power.usage_count counter to
prevent any possible future request to runtime suspend a device.  It will
also resume a device, if it was previously in D3hot state.

I tested with igc device by doing simultaneous aer_inject and rpm
suspend/resume via /sys/bus/pci/devices/PCI_ID/power/control and can
reproduce:

  igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
  pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
  pcieport 0000:00:1c.2: AER: subordinate device reset failed
  pcieport 0000:00:1c.2: AER: device recovery failed
  igc 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible

The problem disappears when this patch is applied.

Link: https://lore.kernel.org/r/20240212120135.146068-1-stanislaw.gruszka@linux.intel.com
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 59c90d04a609a..705893b5f7b09 100644
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
2.43.0





