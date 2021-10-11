Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3D942976E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 21:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhJKTTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 15:19:04 -0400
Received: from office.oderland.com ([91.201.60.5]:58680 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbhJKTTD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 15:19:03 -0400
X-Greylist: delayed 1771 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 15:19:02 EDT
Received: from [193.180.18.161] (port=41080 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1ma0Kf-00C4us-J0; Mon, 11 Oct 2021 20:47:29 +0200
Message-ID: <b023adf9-e21c-59ac-de49-57915c8cede8@oderland.se>
Date:   Mon, 11 Oct 2021 20:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Content-Language: en-US
To:     tglx@linutronix.de
Cc:     maz@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
From:   Josef Johansson <josef@oderland.se>
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION
 (MCP79)
In-Reply-To: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - office.oderland.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oderland.se
X-Get-Message-Sender-Via: office.oderland.com: authenticated_id: josjoh@oderland.se
X-Authenticated-Sender: office.oderland.com: josjoh@oderland.se
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/6/21 10:50, Rui Salvaterra wrote:
> Hi, Thomas,
>
> I'm sorry for reporting this so late in the cycle, I wasn't expecting
> being the only one affected. :)
> "PCI/MSI: Use new mask/unmask functions" broke boot for my ION/Atom
> 330 system. Dmesg shows
>
> failed to IDENTIFY (I/O error, err_mask=0x4)
>
> and the system drops to an initramfs shell. Let me know if you need
> any additional info (DMI dump and/or .config, for example).
>
> Git bisect log follows:
>
> git bisect start
> # good: [7d2a07b769330c34b4deabeed939325c77a7ec2f] Linux 5.14
> git bisect good 7d2a07b769330c34b4deabeed939325c77a7ec2f
> # bad: [6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f] Linux 5.15-rc1
> git bisect bad 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
> # bad: [1b4f3dfb4792f03b139edf10124fcbeb44e608e6] Merge tag
> 'usb-serial-5.15-rc1' of
> https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into
> usb-next
> git bisect bad 1b4f3dfb4792f03b139edf10124fcbeb44e608e6
> # good: [29ce8f9701072fc221d9c38ad952de1a9578f95c] Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> git bisect good 29ce8f9701072fc221d9c38ad952de1a9578f95c
> # bad: [e7c1bbcf0c315c56cd970642214aa1df3d8cf61d] Merge tag
> 'hwmon-for-v5.15' of
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
> git bisect bad e7c1bbcf0c315c56cd970642214aa1df3d8cf61d
> # bad: [679369114e55f422dc593d0628cfde1d04ae59b3] Merge tag
> 'for-5.15/block-2021-08-30' of git://git.kernel.dk/linux-block
> git bisect bad 679369114e55f422dc593d0628cfde1d04ae59b3
> # good: [c7a5238ef68b98130fe36716bb3fa44502f56001] Merge tag
> 's390-5.15-1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
> git bisect good c7a5238ef68b98130fe36716bb3fa44502f56001
> # good: [e5e726f7bb9f711102edea7e5bd511835640e3b4] Merge tag
> 'locking-core-2021-08-30' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good e5e726f7bb9f711102edea7e5bd511835640e3b4
> # good: [158ee7b65653d9f841823c249014c2d0dfdeeb8f] block: mark
> blkdev_fsync static
> git bisect good 158ee7b65653d9f841823c249014c2d0dfdeeb8f
> # bad: [47fb0cfdb7a71a8a0ff8fe1d117363dc81f6ca77] Merge tag
> 'irqchip-5.15' of
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
> irq/core
> git bisect bad 47fb0cfdb7a71a8a0ff8fe1d117363dc81f6ca77
> # good: [4513fb87e1402ad815912ec7f027eb17149f44ee] Merge branch
> irq/misc-5.15 into irq/irqchip-next
> git bisect good 4513fb87e1402ad815912ec7f027eb17149f44ee
> # bad: [88ffe2d0a55a165e55cedad1693f239d47e3e17e] genirq/cpuhotplug:
> Demote debug printk to KERN_DEBUG
> git bisect bad 88ffe2d0a55a165e55cedad1693f239d47e3e17e
> # good: [fcacdfbef5a1633211ebfac1b669a7739f5b553e] PCI/MSI: Provide a
> new set of mask and unmask functions
> git bisect good fcacdfbef5a1633211ebfac1b669a7739f5b553e
> # bad: [91cc470e797828d779cd4c1efbe8519bcb358bae] genirq: Change
> force_irqthreads to a static key
> git bisect bad 91cc470e797828d779cd4c1efbe8519bcb358bae
> # bad: [428e211641ed808b55cdc7d880a0ee349eff354b] genirq/affinity:
> Replace deprecated CPU-hotplug functions.
> git bisect bad 428e211641ed808b55cdc7d880a0ee349eff354b
> # bad: [446a98b19fd6da97a1fb148abb1766ad89c9b767] PCI/MSI: Use new
> mask/unmask functions
> git bisect bad 446a98b19fd6da97a1fb148abb1766ad89c9b767
> # first bad commit: [446a98b19fd6da97a1fb148abb1766ad89c9b767]
> PCI/MSI: Use new mask/unmask functions
>
> Thanks in advance,
> Rui

Hi,

I've got a late regression to this commit as well, but in the GPU area.
The problem arises when booting it as XEN dom0.
My hardware is Lenovo P14s Gen1 AMD Ryzen 7 Pro 4750U.

I'm a bit lost myself, and could use some hints how to fix it.
I should note that this mainly happens when a modeset is done (i think).
If I wait for 5 minutes the lock eventually releases, but I switch in an
out between X
and console it locks again.

kernel: ------------[ cut here ]------------
kernel: WARNING: CPU: 6 PID: 3754 at
drivers/gpu/drm/amd/amdgpu/../display/amdgp
u_dm/amdgpu_dm.c:8630 amdgpu_dm_commit_planes+0x9b4/0x9c0 [amdgpu]
kernel: Modules linked in: nf_tables nfnetlink vfat fat intel_rapl_msr
wmi_bmof
intel_rapl_common pcspkr joydev uvcvideo k10temp sp5100_tco
videobuf2_vmalloc vi
deobuf2_memops i2c_piix4 videobuf2_v4l2 videobuf2_common videodev mc
iwlwifi thi
nkpad_acpi platform_profile ipmi_devintf ledtrig_audio ucsi_acpi
cfg80211 ipmi_m
sghandler r8169 snd typec_ucsi soundcore typec rfkill wmi video amd_pmc
i2c_scmi
 fuse xenfs ip_tables dm_thin_pool dm_persistent_data dm_bio_prison
dm_crypt tru
sted asn1_encoder hid_multitouch amdgpu crct10dif_pclmul iommu_v2
crc32_pclmul c
rc32c_intel gpu_sched i2c_algo_bit drm_ttm_helper ttm drm_kms_helper ccp
cec gha
sh_clmulni_intel sdhci_pci xhci_pci xhci_pci_renesas serio_raw cqhci drm
sdhci x
hci_hcd mmc_core nvme ehci_pci ehci_hcd nvme_core xen_acpi_processor
xen_privcmd
 xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput
kernel: CPU: 6 PID: 3754 Comm: Xorg Tainted: G        W        
5.15.0-1.fc32.qu
bes.x86_64 #1
kernel: Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET61W(1.30
) 12/21/
2020
kernel: RIP: e030:amdgpu_dm_commit_planes+0x9b4/0x9c0 [amdgpu]
kernel: Code: 8b 45 b0 48 c7 c7 4b fc 90 c0 4c 89 55 88 8b b0 f0 03 00
00 e8 6d
cb ca ff 4c 8b 55 88 0f b6 55 ab 49 8b 72 08 e9 2b fa ff ff <0f> 0b e9
fa fe ff
ff e8 40 2f 6e c1 0f 1f 44 00 00 55 b9 27 00 00
kernel: RSP: e02b:ffffc90042d93638 EFLAGS: 00010002
kernel: RAX: ffff888110840210 RBX: 00000000000083c1 RCX: 0000000000000466
kernel: RDX: 0000000000000001 RSI: 0000000000000204 RDI: ffff888110840170
kernel: RBP: ffffc90042d936f8 R08: 0000000000000002 R09: 0000000000000001
kernel: R10: 0000000000000000 R11: ffff88810cb2e118 R12: ffff888110840210
kernel: R13: ffff88810cb2e000 R14: ffff888103d50400 R15: ffff888103bb2c00
kernel: FS:  0000718c6de4da40(0000) GS:ffff888140780000(0000)
knlGS:000000000000
0000
kernel: CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 0000726ada294000 CR3: 0000000103f0e000 CR4: 0000000000050660
kernel: Call Trace:
kernel:  amdgpu_dm_atomic_commit_tail+0xc3e/0x1360 [amdgpu]
kernel:  commit_tail+0x94/0x130 [drm_kms_helper]
kernel:  drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
kernel:  drm_client_modeset_commit_atomic+0x1fc/0x240 [drm]
kernel:  drm_client_modeset_commit_locked+0x53/0x80 [drm]
kernel:  drm_fb_helper_pan_display+0xdc/0x210 [drm_kms_helper]
kernel:  fb_pan_display+0x83/0x100
kernel:  fb_set_var+0x200/0x3b0
kernel:  fbcon_blank+0x186/0x280
kernel:  do_unblank_screen+0xaa/0x150
kernel:  complete_change_console+0x54/0x120
kernel:  vt_ioctl+0x31d/0x5f0
kernel:  tty_ioctl+0x312/0x780
kernel:  __x64_sys_ioctl+0x83/0xb0
kernel:  do_syscall_64+0x3b/0x90
kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
kernel: RIP: 0033:0x718c6e33217b
kernel: Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 00 48 c7
c0 ff ff
ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01
f0 ff ff
73 01 c3 48 8b 0d ed ac 0c 00 f7 d8 64 89 01 48
kernel: RSP: 002b:00007ffd5c6157c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000718c6e33217b
kernel: RDX: 0000000000000001 RSI: 0000000000005605 RDI: 0000000000000014
kernel: RBP: 000057b9b2aa93f4 R08: 0000000000000000 R09: 0000000000000001
kernel: R10: fffffffffffff9ce R11: 0000000000000246 R12: 000057b9b2aa94b0
kernel: R13: 000057b9b2aa94a0 R14: 000057b9b2aa93f0 R15: 00007ffd5c615844
kernel: ---[ end trace 2c3e3998803422cb ]---
kernel: ------------[ cut here ]------------
kernel: WARNING: CPU: 6 PID: 3754 at
drivers/gpu/drm/amd/amdgpu/../display/amdgp
u_dm/amdgpu_dm.c:8217 prepare_flip_isr+0x64/0x70 [amdgpu]
kernel: Modules linked in: nf_tables nfnetlink vfat fat intel_rapl_msr
wmi_bmof
intel_rapl_common pcspkr joydev uvcvideo k10temp sp5100_tco
videobuf2_vmalloc vi
deobuf2_memops i2c_piix4 videobuf2_v4l2 videobuf2_common videodev mc
iwlwifi thi
nkpad_acpi platform_profile ipmi_devintf ledtrig_audio ucsi_acpi
cfg80211 ipmi_m
sghandler r8169 snd typec_ucsi soundcore typec rfkill wmi video amd_pmc
i2c_scmi
 fuse xenfs ip_tables dm_thin_pool dm_persistent_data dm_bio_prison
dm_crypt tru
sted asn1_encoder hid_multitouch amdgpu crct10dif_pclmul iommu_v2
crc32_pclmul c
rc32c_intel gpu_sched i2c_algo_bit drm_ttm_helper ttm drm_kms_helper ccp
cec gha
sh_clmulni_intel sdhci_pci xhci_pci xhci_pci_renesas serio_raw cqhci drm
sdhci x
hci_hcd mmc_core nvme ehci_pci ehci_hcd nvme_core xen_acpi_processor
xen_privcmd
 xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput
kernel: CPU: 6 PID: 3754 Comm: Xorg Tainted: G        W        
5.15.0-1.fc32.qu
bes.x86_64 #1
kernel: Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET61W(1.30
) 12/21/
2020
kernel: RIP: e030:prepare_flip_isr+0x64/0x70 [amdgpu]
kernel: Code: 00 48 c7 80 38 01 00 00 00 00 00 00 66 90 c3 8b 97 f0 03
00 00 48
c7 c6 18 72 8d c0 48 c7 c7 90 5b a7 c0 e9 7e 6e 13 c1 0f 0b <0f> 0b eb
b4 0f 1f
84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 41
kernel: RSP: e02b:ffffc90042d93630 EFLAGS: 00010086
kernel: RAX: 0000000000000001 RBX: 00000000000083c1 RCX: 0000000000000466
kernel: RDX: 0000000000000001 RSI: 0000000000000204 RDI: ffff88810cb2e000
kernel: RBP: ffffc90042d936f8 R08: 0000000000000002 R09: 0000000000000001
kernel: R10: 0000000000000000 R11: ffff88810cb2e118 R12: ffff888110840210
kernel: R13: ffff88810cb2e000 R14: ffff888103d50400 R15: ffff888103bb2c00
kernel: FS:  0000718c6de4da40(0000) GS:ffff888140780000(0000)
knlGS:000000000000
0000
kernel: CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 0000726ada294000 CR3: 0000000103f0e000 CR4: 0000000000050660
kernel: Call Trace:
kernel:  amdgpu_dm_commit_planes+0x8bd/0x9c0 [amdgpu]
kernel:  amdgpu_dm_atomic_commit_tail+0xc3e/0x1360 [amdgpu]
kernel:  commit_tail+0x94/0x130 [drm_kms_helper]
kernel:  drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
kernel:  drm_client_modeset_commit_atomic+0x1fc/0x240 [drm]
kernel:  drm_client_modeset_commit_locked+0x53/0x80 [drm]
kernel:  drm_fb_helper_pan_display+0xdc/0x210 [drm_kms_helper]
kernel:  fb_pan_display+0x83/0x100
kernel:  fb_set_var+0x200/0x3b0
kernel:  fbcon_blank+0x186/0x280
kernel:  do_unblank_screen+0xaa/0x150
kernel:  complete_change_console+0x54/0x120
kernel:  vt_ioctl+0x31d/0x5f0
kernel:  tty_ioctl+0x312/0x780
kernel:  __x64_sys_ioctl+0x83/0xb0
kernel:  do_syscall_64+0x3b/0x90
kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
kernel: RIP: 0033:0x718c6e33217b
kernel: Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 00 48 c7
c0 ff ff
ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01
f0 ff ff
73 01 c3 48 8b 0d ed ac 0c 00 f7 d8 64 89 01 48
kernel: RSP: 002b:00007ffd5c6157c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000718c6e33217b
kernel: RDX: 0000000000000001 RSI: 0000000000005605 RDI: 0000000000000014
kernel: RBP: 000057b9b2aa93f4 R08: 0000000000000000 R09: 0000000000000001
kernel: R10: fffffffffffff9ce R11: 0000000000000246 R12: 000057b9b2aa94b0
kernel: R13: 000057b9b2aa94a0 R14: 000057b9b2aa93f0 R15: 00007ffd5c615844
kernel: ---[ end trace 2c3e3998803422cc ]---

Tested with latest tip, reverting this commit makes it all go away, or
booting with pci=nomsi.

Managed to instruct sysrq to dump locks

kernel: sysrq: Show Locks Held
kernel: Showing all locks held in the system:
kernel: 2 locks held by Xorg/2929:
kernel:  #0: ffffc90042ea7d10 (crtc_ww_class_acquire){+.+.}-{0:0}, at:
drm_mode_setcrtc+0x158/0x780 [drm]
kernel:  #1: ffff888111c00490 (crtc_ww_class_mutex){+.+.}-{3:3}, at:
modeset_lock+0x62/0x1c0 [drm]
kernel: =============================================

More can be read over at freedesktop:
https://gitlab.freedesktop.org/drm/amd/-/issues/1715


Med vänliga hälsningar
Josef Johansson

