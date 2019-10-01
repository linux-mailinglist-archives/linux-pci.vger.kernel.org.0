Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71984C315A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 12:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfJAK3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 06:29:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:11943 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfJAK3K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 06:29:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 03:29:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="342935739"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 01 Oct 2019 03:29:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 218101F6; Tue,  1 Oct 2019 13:29:06 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/3] thunderbolt: Fix lockdep circular locking depedency warning
Date:   Tue,  1 Oct 2019 13:29:04 +0300
Message-Id: <20191001102905.21680-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001102905.21680-1-mika.westerberg@linux.intel.com>
References: <20191001102905.21680-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When lockdep is enabled, plugging Thunderbolt dock on Dominik's laptop
triggers following splat:

  ======================================================
  WARNING: possible circular locking dependency detected
  5.3.0-rc6+ #1 Tainted: G                T
  ------------------------------------------------------
  pool-/usr/lib/b/1258 is trying to acquire lock:
  000000005ab0ad43 (pci_rescan_remove_lock){+.+.}, at: authorized_store+0xe8/0x210

  but task is already holding lock:
  00000000bfb796b5 (&tb->lock){+.+.}, at: authorized_store+0x7c/0x210

  which lock already depends on the new lock.

  the existing dependency chain (in reverse order) is:

  -> #1 (&tb->lock){+.+.}:
         __mutex_lock+0xac/0x9a0
         tb_domain_add+0x2d/0x130
         nhi_probe+0x1dd/0x330
         pci_device_probe+0xd2/0x150
         really_probe+0xee/0x280
         driver_probe_device+0x50/0xc0
         bus_for_each_drv+0x84/0xd0
         __device_attach+0xe4/0x150
         pci_bus_add_device+0x4e/0x70
         pci_bus_add_devices+0x2e/0x66
         pci_bus_add_devices+0x59/0x66
         pci_bus_add_devices+0x59/0x66
         enable_slot+0x344/0x450
         acpiphp_check_bridge.part.0+0x119/0x150
         acpiphp_hotplug_notify+0xaa/0x140
         acpi_device_hotplug+0xa2/0x3f0
         acpi_hotplug_work_fn+0x1a/0x30
         process_one_work+0x234/0x580
         worker_thread+0x50/0x3b0
         kthread+0x10a/0x140
         ret_from_fork+0x3a/0x50

  -> #0 (pci_rescan_remove_lock){+.+.}:
         __lock_acquire+0xe54/0x1ac0
         lock_acquire+0xb8/0x1b0
         __mutex_lock+0xac/0x9a0
         authorized_store+0xe8/0x210
         kernfs_fop_write+0x125/0x1b0
         vfs_write+0xc2/0x1d0
         ksys_write+0x6c/0xf0
         do_syscall_64+0x50/0x180
         entry_SYSCALL_64_after_hwframe+0x49/0xbe

  other info that might help us debug this:
   Possible unsafe locking scenario:
         CPU0                    CPU1
         ----                    ----
    lock(&tb->lock);
                                 lock(pci_rescan_remove_lock);
                                 lock(&tb->lock);
    lock(pci_rescan_remove_lock);

   *** DEADLOCK ***
  5 locks held by pool-/usr/lib/b/1258:
   #0: 000000003df1a1ad (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x4d/0x60
   #1: 0000000095a40b02 (sb_writers#6){.+.+}, at: vfs_write+0x185/0x1d0
   #2: 0000000017a7d714 (&of->mutex){+.+.}, at: kernfs_fop_write+0xf2/0x1b0
   #3: 000000004f262981 (kn->count#208){.+.+}, at: kernfs_fop_write+0xfa/0x1b0
   #4: 00000000bfb796b5 (&tb->lock){+.+.}, at: authorized_store+0x7c/0x210

  stack backtrace:
  CPU: 0 PID: 1258 Comm: pool-/usr/lib/b Tainted: G                T 5.3.0-rc6+ #1

On an system using ACPI hotplug the host router gets hotplugged first and then
the firmware starts sending notifications about connected devices so the above
scenario should not happen in reality. However, after taking a second
look at commit a03e828915c0 ("thunderbolt: Serialize PCIe tunnel
creation with PCI rescan") that introduced the locking, I don't think it
is actually correct. It may have cured the symptom but probably the real
root cause was somewhere closer to PCI stack and possibly is already
fixed with recent kernels. I also tried to reproduce the original issue
with the commit reverted but could not.

So to keep lockdep happy and the code bit less complex drop calls to
pci_lock_rescan_remove()/pci_unlock_rescan_remove() in
tb_switch_set_authorized() effectively reverting a03e828915c0.

Link: https://lkml.org/lkml/2019/8/30/513
Fixes: a03e828915c0 ("thunderbolt: Serialize PCIe tunnel creation with PCI rescan")
Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 8e712fbf8233..5ea8db667e83 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1034,13 +1034,6 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 	if (sw->authorized)
 		goto unlock;
 
-	/*
-	 * Make sure there is no PCIe rescan ongoing when a new PCIe
-	 * tunnel is created. Otherwise the PCIe rescan code might find
-	 * the new tunnel too early.
-	 */
-	pci_lock_rescan_remove();
-
 	switch (val) {
 	/* Approve switch */
 	case 1:
@@ -1060,8 +1053,6 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 		break;
 	}
 
-	pci_unlock_rescan_remove();
-
 	if (!ret) {
 		sw->authorized = val;
 		/* Notify status change to the userspace */
-- 
2.23.0

