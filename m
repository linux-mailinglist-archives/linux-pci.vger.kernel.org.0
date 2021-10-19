Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD20F433F84
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 21:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbhJST76 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 15:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234693AbhJST75 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 15:59:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 457B9611AE;
        Tue, 19 Oct 2021 19:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634673464;
        bh=pkMo2Sv7IK+wY1xa3uKP40G/Dt2Vp6/1qWdddvzz+zM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H+Dt6Y39I0XbmfVc5nEeyvorSyZfPiOb2DwO2J3yHXKkHAYKVVDSj/YOOzR7huBy2
         Nfo8ZfkXcrfqt71bt5tyW29UcV2oG7OFMojYdggBox64/IZa7gmjInoc15dEuJRR69
         4kzB+lD2J2BcN+Puwc93ZOo++PKTIfZvqPnbxilOc632TRhXIAn1FI5VJMfcpl8e8W
         ChZc1Z6Sf0IMnuCeufqpNm42nRiX4it3u1oXb9yUYMl9rq+ykBruvU4hlu+PRmql+R
         n8y7sSDEemfKfwu3i5j1bu1iXacZZTp6+Nq73zqj2bnl0nRH0Ah9eV9z5REwIXcT/W
         AHuvpjfmxuUIQ==
Date:   Tue, 19 Oct 2021 14:57:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Josef Johansson <josef@oderland.se>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jason Andryuk <jandryuk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI/MSI: Re-add checks for skip masking MSI-X on Xen PV
Message-ID: <20211019195742.GA2394472@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <859dbb71-098f-07f2-f063-4874ccc8523b@oderland.se>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Marc]

On Mon, Oct 18, 2021 at 08:22:32AM +0200, Josef Johansson wrote:
> From: Josef Johansson <josef@oderland.se>
> 
> 
> PCI/MSI: Re-add checks for skip masking MSI-X on Xen PV
>     
> 'commit fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
> functions")' introduced functions pci_msi_update_mask() and 
> pci_msix_write_vector_ctrl() that were missing checks for
> pci_msi_ignore_mask that existed in 'commit 446a98b19fd6 ("PCI/MSI: Use
> new mask/unmask functions")'. This patch adds them back since it was
> causing softlocks in amdgpu drivers under Xen.
> 
> As explained in 'commit 1a519dc7a73c ("PCI/MSI: Skip masking MSI-X
> on Xen PV")', when running as Xen PV guest, masking MSI-X is a 
> responsibility of the hypervisor.
> 
> Fixes: fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
> functions")
> Suggested-by: Jason Andryuk <jandryuk@gmail.com>
> Signed-off-by: Josef Johansson <josef@oderland.se>

fcacdfbef5a1 appeared in v5.15-rc1, and we should try to get this
fixed before v5.15.

I could merge it but would like an ack from Thomas since he wrote
fcacdfbef5a1.  He merged fcacdfbef5a1, so I wouldn't complain if the
fix followed the same path.

If I merged it (or if you were to repost it), I would drop the single
quotes around the commit citations and write the commit log in
imperative mood, as you did for the subject
(https://chris.beams.io/posts/git-commit/)

> ---
> 
> This patch solves a major issue with booting 5.15-rc1 under Xen
> with amdgpu drivers. Specifically Lenovo P14s Gen 1, AMD 4750U.
> 
> The softlock below takes about ~2-3 minutes to release, and will
> lock again if I switch between X and console, when staying in
> X I can do things without it softlock.

I don't actually see a softlock mentioned below; am I missing
something?  It's nice to include a couple lines of dmesg log to help
people connect the issue with the fix, but most of the below is not
relevant and can be easily found from the Link: tag.  Also, some of
the lines seem to be wrapped.  They're more useful when not wrapped
because grep can find them.

> I have to note that this is my first commit and PCI/MSI area is
> not my area of expertise. I tried to mimic what was
> obviously missing between the aforementioned commits. There may be
> better ways to solve this problem, or other places to put the checks.
> Should desc->msi_attrib.is_virtual be checked? It is not checked in
> 'commit 1a519dc7a73c ("PCI/MSI: Skip masking MSI-X on Xen PV")'
> 
> I should also note that my original problem with *flip done timeout*
> inside drm during suspend/resume is not solved, but with this patch
> at least the kernel boots properly.
> 
> The kernel is much more stable not running inside Xen, and much 
> more stable running pci=nomsi (under Xen). Are we missing something
> more regarding masking?

It does sound like something else is broken as well, but I have no
idea what that would be.

> The error that occurs is:
> 
> kernel: ------------[ cut here ]------------
> kernel: WARNING: CPU: 6 PID: 3754 at
> drivers/gpu/drm/amd/amdgpu/../display/amdgp
> u_dm/amdgpu_dm.c:8630 amdgpu_dm_commit_planes+0x9b4/0x9c0 [amdgpu]
> kernel: Modules linked in: nf_tables nfnetlink vfat fat intel_rapl_msr wmi_bmof
> intel_rapl_common pcspkr joydev uvcvideo k10temp sp5100_tco videobuf2_vmalloc vi
> deobuf2_memops i2c_piix4 videobuf2_v4l2 videobuf2_common videodev mc iwlwifi thi
> nkpad_acpi platform_profile ipmi_devintf ledtrig_audio ucsi_acpi cfg80211 ipmi_m
> sghandler r8169 snd typec_ucsi soundcore typec rfkill wmi video amd_pmc i2c_scmi
>  fuse xenfs ip_tables dm_thin_pool dm_persistent_data dm_bio_prison dm_crypt tru
> sted asn1_encoder hid_multitouch amdgpu crct10dif_pclmul iommu_v2 crc32_pclmul c
> rc32c_intel gpu_sched i2c_algo_bit drm_ttm_helper ttm drm_kms_helper ccp cec gha
> sh_clmulni_intel sdhci_pci xhci_pci xhci_pci_renesas serio_raw cqhci drm sdhci x
> hci_hcd mmc_core nvme ehci_pci ehci_hcd nvme_core xen_acpi_processor xen_privcmd
>  xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput
> kernel: CPU: 6 PID: 3754 Comm: Xorg Tainted: G   W 5.15.0-1.fc32.qubes.x86_64 #1
> kernel: Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET61W(1.30) 12/21/
> 2020
> kernel: RIP: e030:amdgpu_dm_commit_planes+0x9b4/0x9c0 [amdgpu]
> kernel: Code: 8b 45 b0 48 c7 c7 4b fc 90 c0 4c 89 55 88 8b b0 f0 03 00 00 e8 6d
> cb ca ff 4c 8b 55 88 0f b6 55 ab 49 8b 72 08 e9 2b fa ff ff <0f> 0b e9 fa fe ff
> ff e8 40 2f 6e c1 0f 1f 44 00 00 55 b9 27 00 00
> kernel: RSP: e02b:ffffc90042d93638 EFLAGS: 00010002
> kernel: RAX: ffff888110840210 RBX: 00000000000083c1 RCX: 0000000000000466
> kernel: RDX: 0000000000000001 RSI: 0000000000000204 RDI: ffff888110840170
> kernel: RBP: ffffc90042d936f8 R08: 0000000000000002 R09: 0000000000000001
> kernel: R10: 0000000000000000 R11: ffff88810cb2e118 R12: ffff888110840210
> kernel: R13: ffff88810cb2e000 R14: ffff888103d50400 R15: ffff888103bb2c00
> kernel: FS:  0000718c6de4da40(0000) GS:ffff888140780000(0000)
> knlGS:000000000000
> 0000
> kernel: CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000726ada294000 CR3: 0000000103f0e000 CR4: 0000000000050660
> kernel: Call Trace:
> kernel:  amdgpu_dm_atomic_commit_tail+0xc3e/0x1360 [amdgpu]
> kernel:  commit_tail+0x94/0x130 [drm_kms_helper]
> kernel:  drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
> kernel:  drm_client_modeset_commit_atomic+0x1fc/0x240 [drm]
> kernel:  drm_client_modeset_commit_locked+0x53/0x80 [drm]
> kernel:  drm_fb_helper_pan_display+0xdc/0x210 [drm_kms_helper]
> kernel:  fb_pan_display+0x83/0x100
> kernel:  fb_set_var+0x200/0x3b0
> kernel:  fbcon_blank+0x186/0x280
> kernel:  do_unblank_screen+0xaa/0x150
> kernel:  complete_change_console+0x54/0x120
> kernel:  vt_ioctl+0x31d/0x5f0
> kernel:  tty_ioctl+0x312/0x780
> kernel:  __x64_sys_ioctl+0x83/0xb0
> kernel:  do_syscall_64+0x3b/0x90
> kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
> kernel: RIP: 0033:0x718c6e33217b
> kernel: Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff
> ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff
> 73 01 c3 48 8b 0d ed ac 0c 00 f7 d8 64 89 01 48
> kernel: RSP: 002b:00007ffd5c6157c8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000718c6e33217b
> kernel: RDX: 0000000000000001 RSI: 0000000000005605 RDI: 0000000000000014
> kernel: RBP: 000057b9b2aa93f4 R08: 0000000000000000 R09: 0000000000000001
> kernel: R10: fffffffffffff9ce R11: 0000000000000246 R12: 000057b9b2aa94b0
> kernel: R13: 000057b9b2aa94a0 R14: 000057b9b2aa93f0 R15: 00007ffd5c615844
> kernel: ---[ end trace 2c3e3998803422cb ]---
> kernel: ------------[ cut here ]------------
> kernel: WARNING: CPU: 6 PID: 3754 at
> drivers/gpu/drm/amd/amdgpu/../display/amdgp
> u_dm/amdgpu_dm.c:8217 prepare_flip_isr+0x64/0x70 [amdgpu]
> kernel: Modules linked in: nf_tables nfnetlink vfat fat intel_rapl_msr wmi_bmof
> intel_rapl_common pcspkr joydev uvcvideo k10temp sp5100_tco videobuf2_vmalloc vi
> deobuf2_memops i2c_piix4 videobuf2_v4l2 videobuf2_common videodev mc iwlwifi thi
> nkpad_acpi platform_profile ipmi_devintf ledtrig_audio ucsi_acpi cfg80211 ipmi_m
> sghandler r8169 snd typec_ucsi soundcore typec rfkill wmi video amd_pmc i2c_scmi
>  fuse xenfs ip_tables dm_thin_pool dm_persistent_data dm_bio_prison dm_crypt tru
> sted asn1_encoder hid_multitouch amdgpu crct10dif_pclmul iommu_v2 crc32_pclmul c
> rc32c_intel gpu_sched i2c_algo_bit drm_ttm_helper ttm drm_kms_helper ccp cec gha
> sh_clmulni_intel sdhci_pci xhci_pci xhci_pci_renesas serio_raw cqhci drm sdhci x
> hci_hcd mmc_core nvme ehci_pci ehci_hcd nvme_core xen_acpi_processor xen_privcmd
>  xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput
> kernel: CPU: 6 PID: 3754 Comm: Xorg Tainted: G W 5.15.0-1.fc32.qubes.x86_64 #1
> kernel: Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET61W(1.30) 12/21/
> 2020
> kernel: RIP: e030:prepare_flip_isr+0x64/0x70 [amdgpu]
> kernel: Code: 00 48 c7 80 38 01 00 00 00 00 00 00 66 90 c3 8b 97 f0 03 00 00 48
> c7 c6 18 72 8d c0 48 c7 c7 90 5b a7 c0 e9 7e 6e 13 c1 0f 0b <0f> 0b eb b4 0f 1f
> 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 41
> kernel: RSP: e02b:ffffc90042d93630 EFLAGS: 00010086
> kernel: RAX: 0000000000000001 RBX: 00000000000083c1 RCX: 0000000000000466
> kernel: RDX: 0000000000000001 RSI: 0000000000000204 RDI: ffff88810cb2e000
> kernel: RBP: ffffc90042d936f8 R08: 0000000000000002 R09: 0000000000000001
> kernel: R10: 0000000000000000 R11: ffff88810cb2e118 R12: ffff888110840210
> kernel: R13: ffff88810cb2e000 R14: ffff888103d50400 R15: ffff888103bb2c00
> kernel: FS:  0000718c6de4da40(0000) GS:ffff888140780000(0000) knlGS:000000000000
> 0000
> kernel: CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000726ada294000 CR3: 0000000103f0e000 CR4: 0000000000050660
> kernel: Call Trace:
> kernel:  amdgpu_dm_commit_planes+0x8bd/0x9c0 [amdgpu]
> kernel:  amdgpu_dm_atomic_commit_tail+0xc3e/0x1360 [amdgpu]
> kernel:  commit_tail+0x94/0x130 [drm_kms_helper]
> kernel:  drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
> kernel:  drm_client_modeset_commit_atomic+0x1fc/0x240 [drm]
> kernel:  drm_client_modeset_commit_locked+0x53/0x80 [drm]
> kernel:  drm_fb_helper_pan_display+0xdc/0x210 [drm_kms_helper]
> kernel:  fb_pan_display+0x83/0x100
> kernel:  fb_set_var+0x200/0x3b0
> kernel:  fbcon_blank+0x186/0x280
> kernel:  do_unblank_screen+0xaa/0x150
> kernel:  complete_change_console+0x54/0x120
> kernel:  vt_ioctl+0x31d/0x5f0
> kernel:  tty_ioctl+0x312/0x780
> kernel:  __x64_sys_ioctl+0x83/0xb0
> kernel:  do_syscall_64+0x3b/0x90
> kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
> kernel: RIP: 0033:0x718c6e33217b
> kernel: Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff
> ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff
> 73 01 c3 48 8b 0d ed ac 0c 00 f7 d8 64 89 01 48
> kernel: RSP: 002b:00007ffd5c6157c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000718c6e33217b
> kernel: RDX: 0000000000000001 RSI: 0000000000005605 RDI: 0000000000000014
> kernel: RBP: 000057b9b2aa93f4 R08: 0000000000000000 R09: 0000000000000001
> kernel: R10: fffffffffffff9ce R11: 0000000000000246 R12: 000057b9b2aa94b0
> kernel: R13: 000057b9b2aa94a0 R14: 000057b9b2aa93f0 R15: 00007ffd5c615844
> kernel: ---[ end trace 2c3e3998803422cc ]---
> 
> It is discussed briefly at:
> https://lore.kernel.org/linux-pci/CAKf6xpvGyCKVHsvauP54=0j10fxis4XiiqBNWH+1cpkbtt_QJw@mail.gmail.com/
> 
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 0099a00af361..355b791e382f 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -148,6 +148,9 @@ static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 s
>  	raw_spinlock_t *lock = &desc->dev->msi_lock;
>  	unsigned long flags;
>  
> +	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
> +		return;
> +
>  	raw_spin_lock_irqsave(lock, flags);
>  	desc->msi_mask &= ~clear;
>  	desc->msi_mask |= set;
> @@ -181,6 +184,9 @@ static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
>  {
>  	void __iomem *desc_addr = pci_msix_desc_addr(desc);
>  
> +	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
> +		return;
> +
>  	writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  }
> 
> --
> 2.31.1
> 
