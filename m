Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27D37EAF9C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Nov 2023 13:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjKNMEq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Nov 2023 07:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjKNMEq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 07:04:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754CDF0;
        Tue, 14 Nov 2023 04:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699963482; x=1731499482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ACHsUrV+LT8uOqK2cdANSecqOdxav3f6s1+XieV0sTM=;
  b=jackHD5wYNGFaPTk9by/crf1kbxH8An/EjjLZppKlY1z8YpGn1u+H6e0
   e++fwMxC3SUUvIevjOnagoHwBHPiPnNY+YGMDgu3TBT2aw/Pxg36P1JVl
   LFSKMbhdPP8gJibj9shE94OAKNfPRgZkZIgkGhnUddCD7IDIgbGrvqyc1
   rsaAyNSJ4uReVGKW7P/qYMngOf26KmQS5Oa1xXFiCgfnKGeu1N9nnRA2E
   T7+SQL7cRYUa5i7CLcyu3iaY/x8NnRfRjhJI2sw1t4H5vc7VUiqZIfL8T
   Tb1vO33GZzglbgTgHu9Mazmo8bRn7212tToD4eTiuOkwI3etZwlv1N7u9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="387802770"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="387802770"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 04:04:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="714557269"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="714557269"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 04:04:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2s9j-0000000DnmU-0bgH;
        Tue, 14 Nov 2023 14:04:35 +0200
Date:   Tue, 14 Nov 2023 14:04:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Jean Delvare <jdelvare@suse.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [bug report] lockdep WARN at PCI device rescan
Message-ID: <ZVNiUuyHaez8rwL-@smile.fi.intel.com>
References: <6xb24fjmptxxn5js2fjrrddjae6twex5bjaftwqsuawuqqqydx@7cl3uik5ef6j>
 <ZVNJCxh5vgj22SfQ@shikoro>
 <ea31480f-2887-41fe-a560-f4bb1103479e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea31480f-2887-41fe-a560-f4bb1103479e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 14, 2023 at 11:47:15AM +0100, Heiner Kallweit wrote:
> On 14.11.2023 11:16, Wolfram Sang wrote:
> > On Tue, Nov 14, 2023 at 06:54:29AM +0000, Shinichiro Kawasaki wrote:
> >> Hello there.
> >>
> >> Recently I tried a couple of commands below on the kernel v6.6 and v6.7-rc1,
> >> then observed a lockdep WARN at the second command [1]. The first command
> >> removes a PCI device, and the second command rescans whole PCI devices to
> >> regain the removed device.
> >>
> >>  # echo 1 > /sys/bus/pci/devices/0000:51:00.0/remove
> >>  # echo 1 > /sys/bus/pci/rescan
> >>
> >> I tried this rescan for SAS-HBA or AHCI controller with HDDs. When those devices
> >> are left in weird status after some kernel tests, I want to remove the SAS-HBA
> >> and AHCI controller and rescan to get back the devices in good status. This
> >> rescan looks working good except the WARN.
> >>
> >> The lockdep splat indicates possible deadlock between pci_rescan_remove_lock
> >> and work_completion lock have deadlock possibility. Is the lockdep WARN a known
> >> issue? I found a similar discussion in the past [2], but it did not discuss the
> >> work_completion lock, so my observation looks a new, different issue.
> >>
> >> In the call stack, I found that the workqueue thread for i801_probe() calls
> >> p2sb_bar(), which locks pci_rescan_remove_lock. IMHO, the issue cause looks that
> >> pci_rescan_remove_lock is locked in both workqueue context and non-workqueue
> >> context. As a fix trial, I created a quick patch [3]. It calls i801_probe() in
> >> non-workqueue context only by adding a new flag to struct pci_driver. With this,
> >> I observed the lockdep WARN disappears. Is this a good solution approach? If
> >> not, is there any other better solution?

Thanks for the report!

> > Thanks for the report and the proposed solution. I'll add the i801
> > experts, Jean and Heiner, to CC.
> 
> + Bjorn, Andy

+ Keith and Lukas as per [2].

> i801 just uses p2sb_bar(), I don't see any issue in i801. Root cause seems to
> be in the PCI subsystem. Calling p2sb_bar() from a PCI driver probe callback
> seems to be problematic, nevertheless it's a valid API usage.

Yeah, the problem is that we have a PCI (kind of) device that needs to be
communicated with in order to instantiate a driver from whatever bus we are
trying to do.

> The proposed fix helps to get an idea of how to work around the issue.
> But IMO it more cures a symptom than fixes the root cause.

I agree, and reading [2] makes me think the same, i.e. that currently this is
a Big PCI lock for everything.

I wanted, before reading [2], to propose to make it nested, but I think it's
not gonna fly,

So, currently I'm lack of (good) ideas and would like to hear other (more
experienced) PCI developers on how is to address this...

> >> [1] kernel message log at the second command
> >>
> >> [  242.922091] ======================================================
> >> [  242.931663] WARNING: possible circular locking dependency detected
> >> [  242.938292] mpt3sas_cm1: 63 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (56799464 kB)
> >> [  242.939415] 6.7.0-rc1-kts #1 Not tainted
> >> [  242.939419] ------------------------------------------------------
> >> [  242.939421] bash/1615 is trying to acquire lock:
> >> [  242.939424] ff1100017bf87910 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: __flush_work+0xc5/0x980
> >> [  242.989069] 
> >>                but task is already holding lock:
> >> [  243.000283] ffffffff870bf4a8 (pci_rescan_remove_lock){+.+.}-{3:3}, at: rescan_store+0x96/0xd0
> >> [  243.012269] 
> >>                which lock already depends on the new lock.
> >>
> >> [  243.028569] 
> >>                the existing dependency chain (in reverse order) is:
> >> [  243.041611] 
> >>                -> #1 (pci_rescan_remove_lock){+.+.}-{3:3}:
> >> [  243.053709]        __mutex_lock+0x16a/0x1880
> >> [  243.060767]        p2sb_bar+0xa7/0x250
> >> [  243.067213]        i801_add_tco_spt.constprop.0+0x88/0x1f0 [i2c_i801]
> >> [  243.076707]        i801_add_tco+0x18a/0x210 [i2c_i801]
> >> [  243.084727]        i801_probe+0x99c/0x1500 [i2c_i801]
> >> [  243.092618]        local_pci_probe+0xd6/0x190
> >> [  243.099708]        work_for_cpu_fn+0x4e/0xa0
> >> [  243.106673]        process_one_work+0x736/0x1230
> >> [  243.114012]        worker_thread+0x723/0x1300
> >> [  243.121039]        kthread+0x2ee/0x3d0
> >> [  243.127372]        ret_from_fork+0x2d/0x70
> >> [  243.134073]        ret_from_fork_asm+0x1b/0x30
> >> [  243.141140] 
> >>                -> #0 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
> >> [  243.153341]        __lock_acquire+0x2e74/0x5ea0
> >> [  243.160490]        lock_acquire+0x196/0x4b0
> >> [  243.167236]        __flush_work+0xe2/0x980
> >> [  243.173882]        work_on_cpu_key+0xcc/0xf0
> >> [  243.180709]        pci_device_probe+0x548/0x740
> >> [  243.187813]        really_probe+0x3df/0xb80
> >> [  243.194525]        __driver_probe_device+0x18c/0x450
> >> [  243.202128]        driver_probe_device+0x4a/0x120
> >> [  243.209437]        __device_attach_driver+0x15e/0x270
> >> [  243.217149]        bus_for_each_drv+0x101/0x170
> >> [  243.224260]        __device_attach+0x189/0x380
> >> [  243.231254]        pci_bus_add_device+0x9f/0xf0
> >> [  243.238360]        pci_bus_add_devices+0x7f/0x190
> >> [  243.245639]        pci_bus_add_devices+0x114/0x190
> >> [  243.253017]        pci_rescan_bus+0x23/0x30
> >> [  243.259711]        rescan_store+0xa2/0xd0
> >> [  243.266187]        kernfs_fop_write_iter+0x356/0x530
> >> [  243.273735]        vfs_write+0x513/0xd60
> >> [  243.280090]        ksys_write+0xe7/0x1b0
> >> [  243.286412]        do_syscall_64+0x5d/0xe0
> >> [  243.292908]        entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >> [  243.301053] 
> >>                other info that might help us debug this:
> >>
> >> [  243.315550]  Possible unsafe locking scenario:
> >>
> >> [  243.325803]        CPU0                    CPU1
> >> [  243.332654]        ----                    ----
> >> [  243.339492]   lock(pci_rescan_remove_lock);
> >> [  243.345937]                                lock((work_completion)(&wfc.work));
> >> [  243.355852]                                lock(pci_rescan_remove_lock);
> >> [  243.365170]   lock((work_completion)(&wfc.work));
> >> [  243.372235] 
> >>                 *** DEADLOCK ***
> >>
> >> [  243.384100] 5 locks held by bash/1615:
> >> [  243.390048]  #0: ff1100013f4b0418 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0xe7/0x1b0
> >> [  243.400833]  #1: ff11000128429888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x21d/0x530
> >> [  243.412623]  #2: ff11000103849968 (kn->active#136){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x241/0x530
> >> [  243.424832]  #3: ffffffff870bf4a8 (pci_rescan_remove_lock){+.+.}-{3:3}, at: rescan_store+0x96/0xd0
> >> [  243.436773]  #4: ff1100019cc7e1a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x67/0x380
> >> [  243.448048] 
> >>                stack backtrace:
> >> [  243.456654] CPU: 16 PID: 1615 Comm: bash Not tainted 6.7.0-rc1-kts #1
> >> [  243.465797] Hardware name: Supermicro SYS-520P-WTR/X12SPW-TF, BIOS 1.2 02/14/2022
> >> [  243.476145] Call Trace:
> >> [  243.480820]  <TASK>
> >> [  243.485084]  dump_stack_lvl+0x57/0x90
> >> [  243.491112]  check_noncircular+0x2e1/0x3c0
> >> [  243.497630]  ? __pfx_check_noncircular+0x10/0x10
> >> [  243.504747]  ? __pfx___bfs+0x10/0x10
> >> [  243.510680]  ? lockdep_lock+0xbc/0x1a0
> >> [  243.516811]  ? __pfx_lockdep_lock+0x10/0x10
> >> [  243.523436]  __lock_acquire+0x2e74/0x5ea0
> >> [  243.529866]  ? __pfx___lock_acquire+0x10/0x10
> >> [  243.536682]  lock_acquire+0x196/0x4b0
> >> [  243.542710]  ? __flush_work+0xc5/0x980
> >> [  243.548829]  ? __pfx_lock_acquire+0x10/0x10
> >> [  243.555442]  ? __pfx___lock_acquire+0x10/0x10
> >> [  243.562252]  ? driver_probe_device+0x4a/0x120
> >> [  243.569061]  ? __device_attach_driver+0x15e/0x270
> >> [  243.576282]  ? mark_lock+0xee/0x16c0
> >> [  243.582222]  ? __flush_work+0xc5/0x980
> >> [  243.588364]  __flush_work+0xe2/0x980
> >> [  243.594300]  ? __flush_work+0xc5/0x980
> >> [  243.600425]  ? __queue_work+0x4e4/0xe30
> >> [  243.606658]  ? __pfx___flush_work+0x10/0x10
> >> [  243.613287]  ? lock_is_held_type+0xce/0x120
> >> [  243.619917]  ? queue_work_on+0x69/0xa0
> >> [  243.626032]  ? lockdep_hardirqs_on+0x7d/0x100
> >> [  243.632834]  work_on_cpu_key+0xcc/0xf0
> >> [  243.638950]  ? __pfx_work_on_cpu_key+0x10/0x10
> >> [  243.645849]  ? __pfx_work_for_cpu_fn+0x10/0x10
> >> [  243.652738]  ? __pfx_local_pci_probe+0x10/0x10
> >> [  243.659638]  pci_device_probe+0x548/0x740
> >> [  243.666057]  ? __pfx_pci_device_probe+0x10/0x10
> >> [  243.673057]  ? kernfs_create_link+0x167/0x230
> >> [  243.679855]  really_probe+0x3df/0xb80
> >> [  243.685860]  __driver_probe_device+0x18c/0x450
> >> [  243.692737]  driver_probe_device+0x4a/0x120
> >> [  243.699314]  __device_attach_driver+0x15e/0x270
> >> [  243.706297]  ? __pfx___device_attach_driver+0x10/0x10
> >> [  243.713890]  bus_for_each_drv+0x101/0x170
> >> [  243.720312]  ? __pfx_bus_for_each_drv+0x10/0x10
> >> [  243.727294]  ? lockdep_hardirqs_on+0x7d/0x100
> >> [  243.734063]  ? _raw_spin_unlock_irqrestore+0x35/0x60
> >> [  243.741505]  __device_attach+0x189/0x380
> >> [  243.747747]  ? __pfx___device_attach+0x10/0x10
> >> [  243.754554]  pci_bus_add_device+0x9f/0xf0
> >> [  243.760836]  pci_bus_add_devices+0x7f/0x190
> >> [  243.767328]  pci_bus_add_devices+0x114/0x190
> >> [  243.773890]  pci_rescan_bus+0x23/0x30
> >> [  243.779741]  rescan_store+0xa2/0xd0
> >> [  243.785362]  ? __pfx_rescan_store+0x10/0x10
> >> [  243.791785]  kernfs_fop_write_iter+0x356/0x530
> >> [  243.798516]  vfs_write+0x513/0xd60
> >> [  243.804054]  ? __pfx_vfs_write+0x10/0x10
> >> [  243.810193]  ? __fget_light+0x51/0x220
> >> [  243.816125]  ? __pfx_lock_release+0x10/0x10
> >> [  243.822555]  ksys_write+0xe7/0x1b0
> >> [  243.828097]  ? __pfx_ksys_write+0x10/0x10
> >> [  243.834327]  ? syscall_enter_from_user_mode+0x22/0x90
> >> [  243.841736]  ? lockdep_hardirqs_on+0x7d/0x100
> >> [  243.848366]  do_syscall_64+0x5d/0xe0
> >> [  243.854114]  ? do_syscall_64+0x6c/0xe0
> >> [  243.860053]  ? do_syscall_64+0x6c/0xe0
> >> [  243.865989]  ? lockdep_hardirqs_on+0x7d/0x100
> >> [  243.872608]  ? do_syscall_64+0x6c/0xe0
> >> [  243.878537]  ? lockdep_hardirqs_on+0x7d/0x100
> >> [  243.885147]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >> [  243.892555] RIP: 0033:0x7fee10d53c34
> >> [  243.898305] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 35 77 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
> >> [  243.922266] RSP: 002b:00007ffd173e68e8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> >> [  243.932655] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fee10d53c34
> >> [  243.942564] RDX: 0000000000000002 RSI: 000055f17c9c4bc0 RDI: 0000000000000001
> >> [  243.952485] RBP: 00007ffd173e6910 R08: 0000000000000073 R09: 0000000000000001
> >> [  243.962408] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> >> [  243.972328] R13: 000055f17c9c4bc0 R14: 00007fee10e245c0 R15: 00007fee10e21f20
> >> [  243.982259]  </TASK>
> >>
> >> [2] https://patchwork.kernel.org/project/linux-pci/patch/20180921205752.3191-1-keith.busch@intel.com/

-- 
With Best Regards,
Andy Shevchenko


