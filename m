Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC44F3B989A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 00:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhGAWgk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 18:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhGAWgj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 18:36:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7917361413;
        Thu,  1 Jul 2021 22:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625178848;
        bh=um+DsWhzP6/1XCBIMxqwmPRQOTB4SRnrN8hyDiOrnrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QtraqzB+0TsOT7WuKkJg4P4Laz4Af1N4kqDZW8EBlpnM67StMIv2ACoiqelLYiEIj
         ds+opev5qaQAUfF3gfn7NF95A5p4eSB+cnphpir2oxfcAEO1iJA20t/RCwyaBPMHU/
         pGIfjbiqFRC/ohbJ1EBbK8FZ+I3ViFER8JqD4Ppd5cLYgk3U+psjViuKr2fwFl9QVq
         sHka7wQQldDpO2kHFUodR+u773usoAQM+JCc3jDxQJ1QYO0L+pQ1RHDsbNqvcOSpkY
         W3Qxy4jK1ZOgSI7piOaYps+oUWusBoJ7wMee19OHyTX/aqouvx+Sw9xDG4JhC+c8JJ
         KBFYSZUZUhaNg==
Date:   Thu, 1 Jul 2021 17:34:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     scott@spiteful.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH] PCI: hotplug: set 'thread_finished' flag to be true by
 default
Message-ID: <20210701223407.GA104070@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623294161-7917-1-git-send-email-zheyuma97@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Tong]

On Thu, Jun 10, 2021 at 03:02:41AM +0000, Zheyu Ma wrote:
> In the process of probing the driver 'cpcihp_zt5550', function
> 'pci_get_device' may fail, at this time 'cpci_hp_unregister_controller'
> will be called. Since the default value of 'thread_finished' is 0,
> 'cpci_stop_thread' will be executed, but at this time 'cpci_thread' has
> not been allocated, which leads to a null pointer dereference.

This looks like the same problem Tong reported here:

  https://lore.kernel.org/r/20210321055109.322496-1-ztong0001@gmail.com

I responded to Tong in that thread, and my response to this patch is
basically the same: I think "thread_finished" is a hack and we can do
better.

> Fix this by set 'thread_finished' to be true by default.
> 
> This log reveals it:

It's good to have the essential details from the log, but most of this
is not relevant to the problem and should be omitted.

> BUG: kernel NULL pointer dereference, address: 0000000000000028
> PGD 0 P4D 0
> Oops: 0002 [#1] PREEMPT SMP PTI
> CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.12.4-g70e7f0549188-dirty #74
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:kthread_stop+0x51/0x380
> Code: b5 4e 10 00 65 8b 05 46 da e1 7e 89 c0 48 0f a3 05 5c c1 ef 05 0f 82 68 01 00 00 e8 99 4e 10 00 4c 8d 6b 28 41 bc 01 00 00 00 <f0> 44 0f c1 63 28 45 85 e4 0f 84 af 02 00 00 e8 7b 4e 10 00 45 85
> RSP: 0000:ffffc90000017ba8 EFLAGS: 00010293
> RAX: ffff888100850000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff811f3b37 RDI: ffffffff86259ca6
> RBP: ffffc90000017bc8 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000001 R11: 00000000ffffffff R12: 0000000000000001
> R13: 0000000000000028 R14: ffff88810160a0c8 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88817b200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000028 CR3: 0000000006a32000 CR4: 00000000000006e0
> Call Trace:
>  cpci_stop_thread+0x1a/0x30
>  cpci_hp_unregister_controller+0x43/0xc0
>  zt5550_hc_init_one+0x67d/0x720
>  local_pci_probe+0x4f/0xb0
>  pci_device_probe+0x169/0x230
>  ? pci_device_remove+0x110/0x110
>  really_probe+0x283/0x650
>  driver_probe_device+0x89/0x1d0
>  ? mutex_lock_nested+0x1b/0x20
>  device_driver_attach+0x68/0x70
>  __driver_attach+0x11c/0x1b0
>  ? device_driver_attach+0x70/0x70
>  bus_for_each_dev+0xbb/0x110
>  ? rdinit_setup+0x45/0x45
>  driver_attach+0x27/0x30
>  bus_add_driver+0x1eb/0x2a0
>  driver_register+0xa9/0x180
>  __pci_register_driver+0x7c/0x90
>  ? cpci_hotplug_init+0x1c/0x1c
>  zt5550_init+0x66/0x91
>  do_one_initcall+0x7f/0x3d0
>  ? rdinit_setup+0x45/0x45
>  ? rcu_read_lock_sched_held+0x4f/0x80
>  kernel_init_freeable+0x2d7/0x329
>  ? rest_init+0x2c0/0x2c0
>  kernel_init+0x18/0x190
>  ? rest_init+0x2c0/0x2c0
>  ? rest_init+0x2c0/0x2c0
>  ret_from_fork+0x1f/0x30
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> CR2: 0000000000000028
> ---[ end trace ef108f49fd26a20c ]---
> RIP: 0010:kthread_stop+0x51/0x380
> Code: b5 4e 10 00 65 8b 05 46 da e1 7e 89 c0 48 0f a3 05 5c c1 ef 05 0f 82 68 01 00 00 e8 99 4e 10 00 4c 8d 6b 28 41 bc 01 00 00 00 <f0> 44 0f c1 63 28 45 85 e4 0f 84 af 02 00 00 e8 7b 4e 10 00 45 85
> RSP: 0000:ffffc90000017ba8 EFLAGS: 00010293
> RAX: ffff888100850000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff811f3b37 RDI: ffffffff86259ca6
> RBP: ffffc90000017bc8 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000001 R11: 00000000ffffffff R12: 0000000000000001
> R13: 0000000000000028 R14: ffff88810160a0c8 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88817b200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000028 CR3: 0000000006a32000 CR4: 00000000000006e0
> Kernel panic - not syncing: Fatal exception
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 1 seconds..
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/pci/hotplug/cpci_hotplug_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
> index d0559d2faf50..d527aae4cc60 100644
> --- a/drivers/pci/hotplug/cpci_hotplug_core.c
> +++ b/drivers/pci/hotplug/cpci_hotplug_core.c
> @@ -47,7 +47,7 @@ static atomic_t extracting;
>  int cpci_debug;
>  static struct cpci_hp_controller *controller;
>  static struct task_struct *cpci_thread;
> -static int thread_finished;
> +static int thread_finished = 1;
>  
>  static int enable_slot(struct hotplug_slot *slot);
>  static int disable_slot(struct hotplug_slot *slot);
> -- 
> 2.17.6
> 
