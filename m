Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4997C285E39
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 13:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgJGLeQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 07:34:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:24765 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbgJGLdd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 07:33:33 -0400
IronPort-SDR: 9UwsPGyIXJw8TGD8dCOyD+HVPhpR+NVJt/ON4aNFyJtOjDQIVTXsUC8AfJ81gWR2bLpHpPCpB0
 ts/HauWZgj+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="226492541"
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="226492541"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 04:33:32 -0700
IronPort-SDR: CVvURUDlvr2U5KFmAXOv6BEbjVy9c6nP19osBPFM9wfrooear287pjJQ4IU0xjvXHP5u6kc8IW
 Qdh96LQsuxCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="354862128"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 04:33:29 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@linux.intel.com, sathyanarayanan.kuppuswamy@intel.com,
        xerces.zhao@gmail.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH v8 1/6] PCI/ERR: get device before call device driver to avoid NULL pointer dereference
Date:   Wed,  7 Oct 2020 07:31:53 -0400
Message-Id: <20201007113158.48933-2-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201007113158.48933-1-haifeng.zhao@intel.com>
References: <20201007113158.48933-1-haifeng.zhao@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During DPC error injection test we found there is race condition between
pciehp and DPC driver, NULL pointer dereference caused panic as following

 # setpci -s 64:02.0 0x196.w=000a
  // 64:02.0 is rootport has DPC capability
 # setpci -s 65:00.0 0x04.w=0544
  // 65:00.0 is NVMe SSD populated in above port
 # mount /dev/nvme0n1p1 nvme

 (tested on stable 5.8 & ICS(Ice Lake SP platform, see
 https://en.wikichip.org/wiki/intel/microarchitectures/ice_lake_(server))

 BUG: kernel NULL pointer dereference, address: 0000000000000050
 ...
 CPU: 12 PID: 513 Comm: irq/124-pcie-dp Not tainted 5.8.0-0.0.7.el8.x86_64+ #1
 RIP: 0010:report_error_detected.cold.4+0x7d/0xe6
 Code: b6 d0 e8 e8 fe 11 00 e8 16 c5 fb ff be 06 00 00 00 48 89 df e8 d3 65 ff
 ff b8 06 00 00 00 e9 75 fc ff ff 48 8b 43 68 45 31 c9 <48> 8b 50 50 48 83 3a 00
 41 0f 94 c1 45 31 c0 48 85 d2 41 0f 94 c0
 RSP: 0018:ff8e06cf8762fda8 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ff4e3eaacf42a000 RCX: ff4e3eb31f223c01
 RDX: ff4e3eaacf42a140 RSI: ff4e3eb31f223c00 RDI: ff4e3eaacf42a138
 RBP: ff8e06cf8762fdd0 R08: 00000000000000bf R09: 0000000000000000
 R10: 000000eb8ebeab53 R11: ffffffff93453258 R12: 0000000000000002
 R13: ff4e3eaacf42a130 R14: ff8e06cf8762fe2c R15: ff4e3eab44733828
 FS:  0000000000000000(0000) GS:ff4e3eab1fd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000050 CR3: 0000000f8f80a004 CR4: 0000000000761ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
 ? report_normal_detected+0x20/0x20
 report_frozen_detected+0x16/0x20
 pci_walk_bus+0x75/0x90
 ? dpc_irq+0x90/0x90
 pcie_do_recovery+0x157/0x201
 ? irq_finalize_oneshot.part.47+0xe0/0xe0
 dpc_handler+0x29/0x40
 irq_thread_fn+0x24/0x60
 ...

Debug shows when port DPC feature was enabled and triggered by errors,
DLLSC/PDC/DPC interrupts will be sent to pciehp and DPC driver almost
at the same time, and no delay between them is required by specification.
so DPC driver and pciehp drivers may handle these interrupts cocurrently.

While DPC driver is doing pci_walk_bus() and calling device driver's 
callback without pci_dev_get() to increase device reference count, the
device and its driver instance are likely being freed by
pci_stop_and_removed_bus_device()
-> pci_dev_put().

So does pci_dev_get() before using the device instance to avoid NULL
pointer dereference.

Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
Tested-by: Wen Jin <wen.jin@intel.com>
Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
---
Changes:
 v2: revise doc according to Andy's suggestion.
 v3: no change.
 v4: no change.
 v5: no change.
 v6: moved to [1/5] from [3/5] and revised comment according to Lukas'
     suggestion.
 v7: no change.
 v8: no change.

 drivers/pci/pcie/err.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c543f419d8f9..e35c4480c86b 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -52,6 +52,8 @@ static int report_error_detected(struct pci_dev *dev,
 	pci_ers_result_t vote;
 	const struct pci_error_handlers *err_handler;
 
+	if (!pci_dev_get(dev))
+		return 0;
 	device_lock(&dev->dev);
 	if (!pci_dev_set_io_state(dev, state) ||
 		!dev->driver ||
@@ -76,6 +78,7 @@ static int report_error_detected(struct pci_dev *dev,
 	pci_uevent_ers(dev, vote);
 	*result = merge_result(*result, vote);
 	device_unlock(&dev->dev);
+	pci_dev_put(dev);
 	return 0;
 }
 
@@ -94,6 +97,8 @@ static int report_mmio_enabled(struct pci_dev *dev, void *data)
 	pci_ers_result_t vote, *result = data;
 	const struct pci_error_handlers *err_handler;
 
+	if (!pci_dev_get(dev))
+		return 0;
 	device_lock(&dev->dev);
 	if (!dev->driver ||
 		!dev->driver->err_handler ||
@@ -105,6 +110,7 @@ static int report_mmio_enabled(struct pci_dev *dev, void *data)
 	*result = merge_result(*result, vote);
 out:
 	device_unlock(&dev->dev);
+	pci_dev_put(dev);
 	return 0;
 }
 
@@ -113,6 +119,8 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
 	pci_ers_result_t vote, *result = data;
 	const struct pci_error_handlers *err_handler;
 
+	if (!pci_dev_get(dev))
+		return 0;
 	device_lock(&dev->dev);
 	if (!dev->driver ||
 		!dev->driver->err_handler ||
@@ -124,6 +132,7 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
 	*result = merge_result(*result, vote);
 out:
 	device_unlock(&dev->dev);
+	pci_dev_put(dev);
 	return 0;
 }
 
@@ -131,6 +140,8 @@ static int report_resume(struct pci_dev *dev, void *data)
 {
 	const struct pci_error_handlers *err_handler;
 
+	if (!pci_dev_get(dev))
+		return 0;
 	device_lock(&dev->dev);
 	if (!pci_dev_set_io_state(dev, pci_channel_io_normal) ||
 		!dev->driver ||
@@ -143,6 +154,7 @@ static int report_resume(struct pci_dev *dev, void *data)
 out:
 	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
 	device_unlock(&dev->dev);
+	pci_dev_put(dev);
 	return 0;
 }
 
-- 
2.18.4

