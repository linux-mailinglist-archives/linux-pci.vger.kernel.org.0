Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C1227A616
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 06:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgI1EIb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 00:08:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:30276 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgI1EIb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 00:08:31 -0400
IronPort-SDR: FiVrtDQG9bay6GnCKpZFR3Wc2QzPcJ6fGT1dOdGfy0vdRbPh2XMqjSCF8JY1x99cqk0NMVVesz
 BciQGF0eQmpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="149710887"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="149710887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 21:08:30 -0700
IronPort-SDR: iO93QGv7jL1XT/ipHq5GyhMxbGz15cz/xSA3QsQjcqNsYQlPQh07ZCGdVpquyclgZ6fcQuPeqW
 bmXmxA7w2gWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="311628148"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2020 21:08:27 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com,
        Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH 2/5 V5] PCI: pciehp: check and wait port status out of DPC before handling DLLSC and PDC
Date:   Mon, 28 Sep 2020 00:06:48 -0400
Message-Id: <20200928040651.24937-3-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200928040651.24937-1-haifeng.zhao@intel.com>
References: <20200928040651.24937-1-haifeng.zhao@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When root port has DPC capability and it is enabled, then triggered by
errors, DPC DLLSC and PDC interrupts will be sent to DPC driver, pciehp
driver at the same time.
That will cause following result:

1. Link and device are recovered by hardware DPC and software DPC driver, 
   device
   isn't removed, but the pciehp might treat it as device was hot removed.

2. Race condition happens bettween pciehp_unconfigure_device() called by
   pciehp_ist() in pciehp driver and pci_do_recovery() called by
   dpc_handler in DPC driver. no luck, there is no lock to protect 
   pci_stop_and_remove_bus_device()
   against pci_walk_bus(), they hold different samphore and mutex,
   pci_stop_and_remove_bus_device holds pci_rescan_remove_lock, and
   pci_walk_bus() holds pci_bus_sem.

This race condition is not purely code analysis, it could be triggered by
following command series:

  # setpci -s 64:02.0 0x196.w=000a // 64:02.0 rootport has DPC capability
  # setpci -s 65:00.0 0x04.w=0544  // 65:00.0 NVMe SSD populated in port
  # mount /dev/nvme0n1p1 nvme

One shot will cause system panic and NULL pointer reference happened.
(tested on stable 5.8 & ICS(Ice Lake SP platform, see
https://en.wikichip.org/wiki/intel/microarchitectures/ice_lake_(server))

   Buffer I/O error on dev nvme0n1p1, logical block 3328, async page read
   BUG: kernel NULL pointer dereference, address: 0000000000000050
   #PF: supervisor read access in kernel mode
   #PF: error_code(0x0000) - not-present page
   PGD 0
   Oops: 0000 [#1] SMP NOPTI
   CPU: 12 PID: 513 Comm: irq/124-pcie-dp Not tainted 5.8.0 el8.x86_64+ #1
   RIP: 0010:report_error_detected.cold.4+0x7d/0xe6
   Code: b6 d0 e8 e8 fe 11 00 e8 16 c5 fb ff be 06 00 00 00 48 89 df e8 d3
   65 ff ff b8 06 00 00 00 e9 75 fc ff ff 48 8b 43 68 45 31 c9 <48> 8b 50
   50 48 83 3a 00 41 0f 94 c1 45 31 c0 48 85 d2 41 0f 94 c0
   RSP: 0018:ff8e06cf8762fda8 EFLAGS: 00010246
   RAX: 0000000000000000 RBX: ff4e3eaacf42a000 RCX: ff4e3eb31f223c01
   RDX: ff4e3eaacf42a140 RSI: ff4e3eb31f223c00 RDI: ff4e3eaacf42a138
   RBP: ff8e06cf8762fdd0 R08: 00000000000000bf R09: 0000000000000000
   R10: 000000eb8ebeab53 R11: ffffffff93453258 R12: 0000000000000002
   R13: ff4e3eaacf42a130 R14: ff8e06cf8762fe2c R15: ff4e3eab44733828
   FS:  0000000000000000(0000) GS:ff4e3eab1fd00000(0000) knl
   GS:0000000000000000
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
   irq_thread+0xea/0x170
   ? irq_forced_thread_fn+0x80/0x80
   ? irq_thread_check_affinity+0xf0/0xf0
   kthread+0x124/0x140
   ? kthread_park+0x90/0x90
   ret_from_fork+0x1f/0x30
   Modules linked in: nft_fib_inet.........
   CR2: 0000000000000050

With this patch, the handling flow of DPC containment and hotplug is
partly ordered and serialized, let hardware DPC do the controller reset
etc recovery action first, then DPC driver handling the call-back from
device drivers, clear the DPC status, at the end, pciehp handle the DLLSC
and PDC etc.

Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
Tested-by: Wen Jin <wen.jin@intel.com>
Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
---
Changes:
 V2: revise doc according to Andy's suggestion.
 V3: no change.
 V4: no change.
 V5: no change.

 drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 53433b37e181..6f271160f18d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -710,8 +710,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	down_read(&ctrl->reset_lock);
 	if (events & DISABLE_SLOT)
 		pciehp_handle_disable_request(ctrl);
-	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
+	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) {
+		pci_wait_port_outdpc(pdev);
 		pciehp_handle_presence_or_link_change(ctrl, events);
+	}
 	up_read(&ctrl->reset_lock);
 
 	ret = IRQ_HANDLED;
-- 
2.18.4

