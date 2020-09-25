Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC0278EFA
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgIYQqa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 12:46:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:64420 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbgIYQq3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 12:46:29 -0400
IronPort-SDR: AWhwaQ/Nc4JcIwArMYjoelx2nXGCbUX/sm+vOw6mz/FJoTYZYkM02uDGG//Z5Ng2gcE0b3O979
 WgVTiTNdCoBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="141601161"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="141601161"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 09:40:26 -0700
IronPort-SDR: kwUVwbu+VdCOY4TvspoNZoj8hyQCDWzvI6GrdfnQsml4EB2oGIpUQH1P6iLdYYBlnBPFufTqlT
 nX1gs6Jss1LQ==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="306346493"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 09:40:23 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kLmu2-001uwd-LM; Fri, 25 Sep 2020 15:32:42 +0300
Date:   Fri, 25 Sep 2020 15:32:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ethan Zhao <haifeng.zhao@intel.com>
Cc:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com
Subject: Re: [PATCH 2/5] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
Message-ID: <20200925123242.GE3956970@smile.fi.intel.com>
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
 <20200925023423.42675-3-haifeng.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925023423.42675-3-haifeng.zhao@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 10:34:20PM -0400, Ethan Zhao wrote:
> When root port has DPC capability and it is enabled, then triggered by errors, DPC
> DLLSC and PDC interrupts will be sent to DPC driver, pciehp driver at the same time.
> That will cause following result:
> 
> 1. Link and device are recovered by hardware DPC and software DPC driver, device
>    isn't removed, but the pciehp might treat it as devce was hot removed.
> 
> 2. Race condition happens between pciehp_unconfigure_device() called by
>    pciehp_ist() in pciehp driver and pci_do_recovery() called by dpc_handler in
>    DPC driver. no luck, there is no lock to protect pci_stop_and_remove_bus_device()
>    against pci_walk_bus(), they hold different semaphore and mutex,
>    pci_stop_and_remove_bus_device holds pci_rescan_remove_lock, and pci_walk_bus()
>    holds pci_bus_sem.
> 
> This race condition is not purely code analysis, it could be triggered by following
> command series:
> 
>   # setpci -s 64:02.0 0x196.w=000a   // 64:02.0 is rootport has DPC capability
>   # setpci -s 65:00.0 0x04.w=0544    // 65:00.0 is NVMe SSD populated in above port
>   # mount /dev/nvme0n1p1 nvme
> 
> One shot will cause system panic and null pointer reference happened.
> (tested on stable 5.8 & ICX platform)

What is ICX (yes, I know, but you are writing this for wider audience)?

>    Buffer I/O error on dev nvme0n1p1, logical block 468843328, async page read
>    BUG: kernel NULL pointer dereference, address: 0000000000000050
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page

Please, try to remove non-relevant information from the crashes.

>    Oops: 0000 [#1] SMP NOPTI
>    CPU: 12 PID: 513 Comm: irq/124-pcie-dp Not tainted 5.8.0-0.0.7.el8.x86_64+ #1
>    Hardware name: Intel Corporation Wilxxxx.200x0x0xxx 0x/0x/20x0
>    RIP: 0010:report_error_detected.cold.4+0x7d/0xe6
>    Code: b6 d0 e8 e8 fe 11 00 e8 16 c5 fb ff be 06 00 00 00 48 89 df e8 d3 65 ff
>    ff b8 06 00 00 00 e9 75 fc ff ff 48 8b 43 68 45 31 c9 <48> 8b 50 50 48 83 3a 00
>    41 0f 94 c1 45 31 c0 48 85 d2 41 0f 94 c0
>    RSP: 0018:ff8e06cf8762fda8 EFLAGS: 00010246
>    RAX: 0000000000000000 RBX: ff4e3eaacf42a000 RCX: ff4e3eb31f223c01
>    RDX: ff4e3eaacf42a140 RSI: ff4e3eb31f223c00 RDI: ff4e3eaacf42a138
>    RBP: ff8e06cf8762fdd0 R08: 00000000000000bf R09: 0000000000000000
>    R10: 000000eb8ebeab53 R11: ffffffff93453258 R12: 0000000000000002
>    R13: ff4e3eaacf42a130 R14: ff8e06cf8762fe2c R15: ff4e3eab44733828
>    FS:  0000000000000000(0000) GS:ff4e3eab1fd00000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000000000000050 CR3: 0000000f8f80a004 CR4: 0000000000761ee0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    PKRU: 55555554
>    Call Trace:
>    ? report_normal_detected+0x20/0x20
>    report_frozen_detected+0x16/0x20
>    pci_walk_bus+0x75/0x90
>    ? dpc_irq+0x90/0x90
>    pcie_do_recovery+0x157/0x201
>    ? irq_finalize_oneshot.part.47+0xe0/0xe0
>    dpc_handler+0x29/0x40
>    irq_thread_fn+0x24/0x60
>    irq_thread+0xea/0x170
>    ? irq_forced_thread_fn+0x80/0x80
>    ? irq_thread_check_affinity+0xf0/0xf0
>    kthread+0x124/0x140
>    ? kthread_park+0x90/0x90
>    ret_from_fork+0x1f/0x30
>    Modules linked in: nft_fib_inet.........
>    CR2: 0000000000000050
> 
> With this patch, the handling flow of DPC containment and hotplug is partly ordered
> and serialized, let hardware DPC do the controller reset etc recovery action first,
> then DPC driver handling the call-back from device drivers, clear the DPC status,
> at the end, pciehp driver handles the DLLSC and PDC etc.

> This patch closes the race conditon partly.

Not sure if Bjorn require to get rid of "this patch" from commit messages... In
any case it's written in documentation.


-- 
With Best Regards,
Andy Shevchenko


