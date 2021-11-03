Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B87444BC5
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 00:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhKCXsL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 19:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKCXsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 19:48:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3ABC061714;
        Wed,  3 Nov 2021 16:45:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635983129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXp9Lu3U6B6l2NAqi+9utvh+Hmq8hDnJ1Vzy6C5T/4k=;
        b=cJogEg3FVkGBT1u+km6LhtAFlGHVz01T7D+hVPGdk+XV356VC52liohtD6EnXrEBhlgK4o
        ivrjcFsp1iFFsqJhxRxocjKlfaH2ykqKeom6af3+7AvAL5AnEauZTvOw07fBSqF+exO5d1
        lNUu71clGiGge5xGOcstgS7goRIvrLV8lbvp2B2B5CyOW7ftofsS8i8UOiPImBL1weGKGF
        VliOdRyJIZYkfMQTQHcJEy9wXTMlBoIX7ZQexSnaZwWCJye7cQat2o/onFarcWy+xz7SKK
        1oMdQGY3tzIUd5VU2DqcqDYOQZPQsPE6/UfTwEJb54FGRW7y68XHhadydOxDuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635983129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXp9Lu3U6B6l2NAqi+9utvh+Hmq8hDnJ1Vzy6C5T/4k=;
        b=ocwXEWY8V/mdNl9ciCnRaseU1cj/8aIwVmzrb0WhvwsAnDhdUeaodP/lpQe/YwChxtlLOe
        28ugHU4I7lXJuKAA==
To:     Josef Johansson <josef@oderland.se>
Cc:     boris.ostrovsky@oracle.com, helgaas@kernel.org, jgross@suse.com,
        linux-pci@vger.kernel.org, maz@kernel.org,
        xen-devel@lists.xenproject.org, Jason Andryuk <jandryuk@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [PATCH] PCI/MSI: Move non-mask check back into low level accessors
In-Reply-To: <5b3d4653-0cdf-e098-0a4a-3c5c3ae3977b@oderland.se>
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <20211025012503.33172-1-jandryuk@gmail.com> <87fssmg8k4.ffs@tglx>
 <87cznqg5k8.ffs@tglx> <d1cc20aa-5c5c-6c7b-2e5d-bc31362ad891@oderland.se>
 <89d6c2f4-4d00-972f-e434-cb1839e78598@oderland.se>
 <5b3d4653-0cdf-e098-0a4a-3c5c3ae3977b@oderland.se>
Date:   Thu, 04 Nov 2021 00:45:29 +0100
Message-ID: <87ee7w6bxi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 27 2021 at 17:29, Josef Johansson wrote:

CC+: EFIFB and scheduler folks

> On 10/27/21 14:01, Josef Johansson wrote:
> When I suspend I get errors from Xen, including stacktraces below
> if anyone has any clue, if this might be related. I get one each time I
> suspend
> and the third time amdgpu gives up.
>
> rtc_cmos 00:01: registered as rtc0
> rtc_cmos 00:01: setting system clock to 2021-10-27T15:04:35 UTC (1635347075)
> rtc_cmos 00:01: no alarms, y3k, 114 bytes nvram
> device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
> device-mapper: uevent: version 1.0.3
> device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
> efifb: probing for efifb
> efifb: cannot reserve video memory at 0x60000000
> ------------[ cut here ]------------
> ioremap on RAM at 0x0000000060000000 - 0x00000000607e8fff
> WARNING: CPU: 7 PID: 1 at arch/x86/mm/ioremap.c:210 __ioremap_caller+0x332/0x350

That's this warning:

	/*
	 * Don't allow anybody to remap normal RAM that we're using..
	 */
	if (io_desc.flags & IORES_MAP_SYSTEM_RAM) {
		WARN_ONCE(1, "ioremap on RAM at %pa - %pa\n",
			  &phys_addr, &last_addr);
		return NULL;
	}


> Modules linked in:
> CPU: 7 PID: 1 Comm: swapper/0 Not tainted 5.15.0-0.rc7.0.fc32.qubes.x86_64 #1
> Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
> RIP: e030:__ioremap_caller+0x332/0x350
> Code: e8 c3 ca ff ff 49 09 c6 e9 32 fe ff ff 48 8d 54 24 28 48 8d 74 24 18 48 c7 c7 35 f2 5d 82 c6 05 e8 7b a9 01 01 e8 48 39 be 00 <0f> 0b 45 31 e4 e9 ac fe ff ff e8 ff f5 c3 00 66 66 2e 0f 1f 84 00
> RSP: e02b:ffffc9004007bb00 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 00000000007e9000 RCX: ffffffff82915ca8
> RDX: c0000000ffffdfff RSI: 0000000000000000 RDI: ffffffff82865ca0
> RBP: 0000000060000000 R08: 0000000000000000 R09: ffffc9004007b948
> R10: ffffc9004007b940 R11: ffffffff82945ce8 R12: 0000000000000001
> R13: 00000000007e9000 R14: 00000000007e9000 R15: ffffffff81c8f772
> FS:  0000000000000000(0000) GS:ffff8881407c0000(0000) knlGS:0000000000000000
> CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000002810000 CR4: 0000000000050660
> Call Trace:
>  efifb_probe.cold+0x2e6/0x688

Why is this probing EFIFB at resume? Josef is that hibernate or suspend
to RAM?

>  platform_probe+0x3f/0x90
>  call_driver_probe+0x24/0xc0
>  really_probe+0x1e7/0x310
>  __driver_probe_device+0xfe/0x180
>  driver_probe_device+0x1e/0x90
>  __device_attach_driver+0x72/0xe0
>  ? driver_allows_async_probing+0x50/0x50
>  ? driver_allows_async_probing+0x50/0x50
>  bus_for_each_drv+0x8f/0xd0
>  __device_attach+0xe9/0x1f0
>  bus_probe_device+0x8e/0xa0
>  device_add+0x3fb/0x630
>  platform_device_add+0x102/0x230
>  sysfb_init+0xea/0x141
>  ? firmware_map_add_early+0xb8/0xb8
>  do_one_initcall+0x57/0x200
>  do_initcalls+0x109/0x166
>  kernel_init_freeable+0x23c/0x2bd
>  ? rest_init+0xc0/0xc0
>  kernel_init+0x16/0x120
>  ret_from_fork+0x22/0x30
> ---[ end trace b068d3cd1b7f5f49 ]---
> efifb: abort, cannot remap video memory 0x7e9000 @ 0x60000000
> efi-framebuffer: probe of efi-framebuffer.0 failed with error -5
> --
> printk: Suspending console(s) (use no_console_suspend to debug)
> [drm] free PSP TMR buffer
> PM: suspend devices took 0.428 seconds
> ACPI: EC: interrupt blocked
> ACPI: PM: Preparing to enter system sleep state S3
> ACPI: EC: event blocked
> ACPI: EC: EC stopped
> ACPI: PM: Saving platform NVS memory
> Disabling non-boot CPUs ...
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 0 at arch/x86/mm/tlb.c:522  switch_mm_irqs_off+0x3c5/0x400

	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid))) {

> Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer nf_tables nfnetlink vfat fat intel_rapl_msr think_lmi firmware_attributes_class wmi_bmof intel_rapl_common pcspkr uvcvideo videobuf2_vmalloc videobuf2_memops joydev videobuf2_v4l2 sp5100_tco k10temp videobuf2_common i2c_piix4 iwlwifi videodev mc cfg80211 thinkpad_acpi ipmi_devintf ucsi_acpi platform_profile typec_ucsi ledtrig_audio ipmi_msghandler r8169 rfkill typec snd wmi soundcore video i2c_scmi fuse xenfs ip_tables dm_thin_pool dm_persistent_data dm_bio_prison dm_crypt trusted asn1_encoder hid_multitouch amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel gpu_sched i2c_algo_bit drm_ttm_helper ghash_clmulni_intel ttm serio_raw drm_kms_helper cec sdhci_pci cqhci sdhci xhci_pci drm xhci_pci_renesas nvme xhci_hcd ehci_pci mmc_core ehci_hcd nvme_core xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput
> CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W        --------- ---  5.15.0-0.rc7.0.fc32.qubes.x86_64 #1
> Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
> RIP: e030:switch_mm_irqs_off+0x3c5/0x400
> Code: f0 41 80 65 01 fb ba 01 00 00 00 49 8d b5 60 23 00 00 4c 89 ef 49 c7 85 68 23 00 00 60 1d 08 81 e8 a0 f3 08 00 e9 15 fd ff ff <0f> 0b e8 34 fa ff ff e9 ad fc ff ff 0f 0b e9 31 fe ff ff 0f 0b e9
> RSP: e02b:ffffc900400f3eb0 EFLAGS: 00010006
> RAX: 00000001336c6000 RBX: ffff888140660000 RCX: 0000000000000040
> RDX: ffff8881003027c0 RSI: 0000000000000000 RDI: ffff8881b36c6000
> RBP: ffffffff829d91c0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000008 R11: 0000000000000000 R12: ffff888104e88440
> R13: ffff8881003027c0 R14: 0000000000000000 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff888140640000(0000) knlGS:0000000000000000
> CS:  10000e030 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 000060b7d78bf198 CR3: 0000000002810000 CR4: 0000000000050660
> Call Trace:
>  switch_mm+0x1c/0x30
>  idle_task_exit+0x55/0x60
>  play_dead_common+0xa/0x20
>  xen_pv_play_dead+0xa/0x60

So this is when bringing the non boot CPUs down and the switch_mm() code
discovers inconsistency between CR3 and the expected value.

Would probably be interesting to print the actual values, but XEN folks
might have an idea.

>  do_idle+0xd1/0xe0
>  cpu_startup_entry+0x19/0x20
>  asm_cpu_bringup_and_idle+0x5/0x1000
> ---[ end trace b068d3cd1b7f5f4b ]---
> smpboot: CPU 1 is now offline
> smpboot: CPU 2 is now offline
> smpboot: CPU 3 is now offline
> smpboot: CPU 4 is now offline
> smpboot: CPU 5 is now offline
> smpboot: CPU 6 is now offline
> smpboot: CPU 7 is now offline
> ACPI: PM: Low-level resume complete
> ACPI: EC: EC started
> ACPI: PM: Restoring platform NVS memory
> xen_acpi_processor: Uploading Xen processor PM info
> xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI CPU1
> xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI CPU3
> xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI CPU5
> xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI CPU7
> xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI CPU9
> xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI CPU11
> --
> CPU2 is up
> installing Xen timer for CPU 3
> cpu 3 spinlock event irq 79
> [Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW (0x0)
> ACPI: \_SB_.PLTF.C003: Found 3 idle states
> ACPI: FW issue: working around C-state latencies out of order
> CPU3 is up
> ------------[ cut here ]------------
> cfs_rq->avg.load_avg || cfs_rq->avg.util_avg || cfs_rq->avg.runnable_avg
> installing Xen timer for CPU 4
> WARNING: CPU: 3 PID: 455 at kernel/sched/fair.c:3339  __update_blocked_fair+0x49b/0x4b0

	/*
	 * _avg must be null when _sum are null because _avg = _sum / divider
	 * Make sure that rounding and/or propagation of PELT values never
	 * break this.
	 */
	SCHED_WARN_ON(cfs_rq->avg.load_avg ||
		      cfs_rq->avg.util_avg ||
		      cfs_rq->avg.runnable_avg);

PeterZ, does that ring any bell?

> Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer nf_tables nfnetlink vfat fat intel_rapl_msr think_lmi firmware_attributes_class wmi_bmof intel_rapl_common pcspkr uvcvideo videobuf2_vmalloc videobuf2_memops joydev videobuf2_v4l2 sp5100_tco k10temp videobuf2_common i2c_piix4 iwlwifi videodev mc cfg80211 thinkpad_acpi ipmi_devintf ucsi_acpi platform_profile typec_ucsi ledtrig_audio ipmi_msghandler r8169 rfkill typec snd wmi soundcore video i2c_scmi fuse xenfs ip_tables dm_thin_pool dm_persistent_data dm_bio_prison dm_crypt trusted asn1_encoder hid_multitouch amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel gpu_sched i2c_algo_bit drm_ttm_helper ghash_clmulni_intel ttm serio_raw drm_kms_helper cec sdhci_pci cqhci sdhci xhci_pci drm xhci_pci_renesas nvme xhci_hcd ehci_pci mmc_core ehci_hcd nvme_core xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput
> CPU: 3 PID: 455 Comm: kworker/3:2 Tainted: G        W        --------- ---  5.15.0-0.rc7.0.fc32.qubes.x86_64 #1
> Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
> Workqueue:  0x0 (events)
> RIP: e030:__update_blocked_fair+0x49b/0x4b0
> Code: 6b fd ff ff 49 8b 96 48 01 00 00 48 89 90 50 09 00 00 e9 ff fc ff ff 48 c7 c7 10 7a 5e 82 c6 05 f3 35 9e 01 01 e8 1f f3 b2 00 <0f> 0b 41 8b 86 38 01 00 00 e9 c6 fc ff ff 0f 1f 80 00 00 00 00 0f
> RSP: e02b:ffffc900410d7ce0 EFLAGS: 00010082
> RAX: 0000000000000000 RBX: 0000000000000018 RCX: ffff8881406d8a08
> RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8881406d8a00
> RBP: ffff8881406e9800 R08: 0000000000000048 R09: ffffc900410d7c78
> R10: 0000000000000049 R11: 000000002d2d2d2d R12: ffff8881406e9f80
> R13: ffff8881406e9e40 R14: ffff8881406e96c0 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8881406c0000(0000) knlGS:0000000000000000
> CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000782e51820000 CR3: 0000000002810000 CR4: 0000000000050660
> Call Trace:
>  update_blocked_averages+0xa8/0x180
>  newidle_balance+0x175/0x380
>  pick_next_task_fair+0x39/0x3e0
>  pick_next_task+0x4c/0xbd0
>  ? dequeue_task_fair+0xba/0x390
>  __schedule+0x13a/0x570
>  schedule+0x44/0xa0
>  worker_thread+0xc0/0x320
>  ? process_one_work+0x390/0x390
>  kthread+0x10f/0x130
>  ? set_kthread_struct+0x40/0x40
>  ret_from_fork+0x22/0x30
> ---[ end trace b068d3cd1b7f5f4c ]---
> cpu 4 spinlock event irq 85
> [Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW (0x0)
> ACPI: \_SB_.PLTF.C004: Found 3 idle states
> ACPI: FW issue: working around C-state latencies out of order
> CPU4 is up
> installing Xen timer for CPU 5
> cpu 5 spinlock event irq 91
> [Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW (0x0)
> ACPI: \_SB_.PLTF.C005: Found 3 idle states
> ACPI: FW issue: working around C-state latencies out of order
> CPU5 is up
