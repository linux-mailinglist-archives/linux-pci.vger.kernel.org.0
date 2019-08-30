Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA6CA3780
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2019 15:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfH3NFV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Aug 2019 09:05:21 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:60068 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfH3NFV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Aug 2019 09:05:21 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Aug 2019 09:05:20 EDT
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl-tcp.brodo.linta [10.1.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 2A1C02006F1;
        Fri, 30 Aug 2019 12:59:01 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 21948807E2; Fri, 30 Aug 2019 14:58:48 +0200 (CEST)
Date:   Fri, 30 Aug 2019 14:58:48 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: lockdep warning on thunderbolt docking
Message-ID: <20190830125848.GA25929@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When connecting a thunderbolt-enabled docking station to my work laptop,
the following lockdep warning is reported on v5.3.0-rc6+ as of Thursday
morning (can look up the exact git id if so required):


thunderbolt 0-1: new device found, vendor=0xd4 device=0xb070
thunderbolt 0-1: Dell WD19TB Thunderbolt Dock

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


Thanks,
	Dominik
