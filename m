Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CAA4340C8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 23:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhJSVug (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 17:50:36 -0400
Received: from office.oderland.com ([91.201.60.5]:58004 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSVuf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Oct 2021 17:50:35 -0400
Received: from [193.180.18.161] (port=58518 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1mcwy4-004Yi8-In; Tue, 19 Oct 2021 23:48:20 +0200
Message-ID: <5f050b30-fa1c-8387-0d6b-a667851b34b0@oderland.se>
Date:   Tue, 19 Oct 2021 23:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jason Andryuk <jandryuk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
References: <20211019202906.GA2397931@bhelgaas>
From:   Josef Johansson <josef@oderland.se>
Subject: [PATCH v2] PCI/MSI: Re-add checks for skip masking MSI-X on Xen PV
In-Reply-To: <20211019202906.GA2397931@bhelgaas>
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

From: Josef Johansson <josef@oderland.se>


PCI/MSI: Re-add checks for skip masking MSI-X on Xen PV
    
commit fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
functions") introduce functions pci_msi_update_mask() and 
pci_msix_write_vector_ctrl() that is missing checks for
pci_msi_ignore_mask that exists in commit 446a98b19fd6 ("PCI/MSI: Use
new mask/unmask functions"). Add them back since it is
causing severe lockups in amdgpu drivers under Xen during boot.

As explained in commit 1a519dc7a73c ("PCI/MSI: Skip masking MSI-X
on Xen PV"), when running as Xen PV guest, masking MSI-X is a 
responsibility of the hypervisor.

Fixes: fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
functions")
Suggested-by: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Josef Johansson <josef@oderland.se>
---

v1
* commit log is not in the correct mood
* commit log has single quotes around the commits
* the information with what led up to the patch is lacking.

v2
* correct the mood
* correct the quotes
* add much more information.

Here I describe the current patch and what led up to it,
more on what led up to it below the first attached dmesg.

This patch solves a major issue with booting 5.15-rc1 under Xen
with amdgpu drivers. Specifically Lenovo P14s Gen 1, AMD 4750U.

During boot around when I unluck the disk the first entry of
'Fence fallback timer expired' occur, the laptop is mostly useless.

After a while the WARN_ON trace shows up and the boot process starts
again, until it again gets stuck. This pattern repeats until X boots,
after that point it's kind of ok to work in.
If I try to switch to console the same process happens.

My solution to this was at first bisecting and finding 
commit 446a98b19fd6 ("PCI/MSI: Use new mask/unmask functions") series,
reverting this commit made the boot fast again with no lockups.

Later on I tried to apply pci=nomsi as a kernel argument and that
worked fine as well, letting me compile the kernel without the revert.

I have to note that this is my first commit and PCI/MSI area is
not my area of expertise. I tried to mimic what was
obviously missing between the aforementioned commits. There may be
better ways to solve this problem, or other places to put the checks.
Should desc->msi_attrib.is_virtual be checked? It is not checked in
'commit 1a519dc7a73c ("PCI/MSI: Skip masking MSI-X on Xen PV")'

If there's anything I can try out, I'd be happy to assist.

The important bits from dmesg, with debug-configs on.

Oct 11 22:32:00 dom0 kernel: Linux version 5.15.0-1.fc32.qubes.x86_64
(user@compiler) (gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1), GNU ld
version 2.34-6.fc32) #14 SMP Mon Oct 11 20:12:00 UTC 2021

Oct 11 22:32:00 dom0 kernel: Command line: placeholder
root=/dev/mapper/qubes_dom0-root ro
rd.luks.uuid=luks-c8f1f8e3-a5e7-4697-b01e-b104f5a0eedb
rd.lvm.lv=qubes_dom0/root rd.lvm.lv=qubes_dom0/swap
plymouth.ignore-serial-consoles rd.driver.pre=btrfs
rd.driver.blacklist=pcspkr

[snip]

Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: [drm] fb0: amdgpu
frame buffer device
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring gfx uses
VM inv eng 0 on hub 0
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.0.0 uses VM inv eng 1 on hub 0
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.1.0 uses VM inv eng 4 on hub 0
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.2.0 uses VM inv eng 5 on hub 0
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.3.0 uses VM inv eng 6 on hub 0
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.0.1 uses VM inv eng 7 on hub 0
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.1.1 uses VM inv eng 8 on hub 0
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.2.1 uses VM inv eng 9 on hub 0
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.3.1 uses VM inv eng 10 on hub 0
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring kiq_2.1.0
uses VM inv eng 11 on hub 0
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring sdma0
uses VM inv eng 0 on hub 1
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring vcn_dec
uses VM inv eng 1 on hub 1
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring vcn_enc0
uses VM inv eng 4 on hub 1
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring vcn_enc1
uses VM inv eng 5 on hub 1
Oct 11 22:32:04 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: ring jpeg_dec
uses VM inv eng 6 on hub 1
Oct 11 22:32:04 dom0 kernel: [drm] Initialized amdgpu 3.42.0 20150101
for 0000:07:00.0 on minor 0

[snip]

Oct 11 22:32:06 dom0 kernel: [drm] Fence fallback timer expired on ring gfx
Oct 11 22:32:07 dom0 kernel: [drm] Fence fallback timer expired on ring
comp_1.0.0
Oct 11 22:32:07 dom0 kernel: [drm] Fence fallback timer expired on ring
comp_1.1.0
Oct 11 22:32:08 dom0 kernel: [drm] Fence fallback timer expired on ring
comp_1.2.0
Oct 11 22:32:08 dom0 kernel: [drm] Fence fallback timer expired on ring
comp_1.3.0
Oct 11 22:32:09 dom0 kernel: [drm] Fence fallback timer expired on ring
comp_1.0.1
Oct 11 22:32:09 dom0 kernel: [drm] Fence fallback timer expired on ring
comp_1.1.1
Oct 11 22:32:10 dom0 kernel: [drm] Fence fallback timer expired on ring
comp_1.2.1
Oct 11 22:32:10 dom0 kernel: [drm] Fence fallback timer expired on ring
comp_1.3.1
Oct 11 22:32:11 dom0 kernel: [drm] Fence fallback timer expired on ring
sdma0
Oct 11 22:32:11 dom0 kernel: [drm] Fence fallback timer expired on ring
vcn_dec
Oct 11 22:32:12 dom0 kernel: [drm] Fence fallback timer expired on ring
vcn_enc0
Oct 11 22:32:12 dom0 kernel: amdgpu 0000:07:00.0: [drm] *ERROR* Sending
link address failed with -5
Oct 11 22:32:12 dom0 kernel: [drm] Fence fallback timer expired on ring
vcn_enc1
Oct 11 22:32:13 dom0 kernel: [drm] Fence fallback timer expired on ring
jpeg_dec
Oct 11 22:32:14 dom0 kernel: [drm:drm_atomic_helper_wait_for_flip_done
[drm_kms_helper]] *ERROR* [CRTC:67:crtc-0] flip_done timed out
[snip]

Oct 11 22:32:37 dom0 kernel: [drm:drm_crtc_commit_wait [drm]] *ERROR*
flip_done timed out
Oct 11 22:32:37 dom0 kernel:
[drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR*
[CRTC:67:crtc-0] commit wait timed out
Oct 11 22:32:47 dom0 kernel: [drm:drm_crtc_commit_wait [drm]] *ERROR*
flip_done timed out
Oct 11 22:32:47 dom0 kernel:
[drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR*
[CONNECTOR:78:eDP-1] commit wait timed out
Oct 11 22:32:57 dom0 kernel: [drm:drm_crtc_commit_wait [drm]] *ERROR*
flip_done timed out
Oct 11 22:32:57 dom0 kernel:
[drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR*
[PLANE:55:plane-3] commit wait timed out
Oct 11 22:32:57 dom0 kernel: ------------[ cut here ]------------
Oct 11 22:32:57 dom0 kernel: WARNING: CPU: 5 PID: 1425 at
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8689
amdgpu_dm_commit_planes+0x98c/0x9a0 [amdgpu]
Oct 11 22:32:57 dom0 kernel: Modules linked in: intel_rapl_msr wmi_bmof
intel_rapl_common pcspkr uvcvideo videobuf2_vmalloc videobuf2_memops
joydev videobuf2_v4l2 k10temp videobuf2_common videodev sp5100_tco mc
i2c_piix4 iwlwifi cfg80211 thinkpad_acpi platform_profile ipmi_devintf
ledtrig_audio ipmi_msghandler snd r8169 ucsi_acpi soundcore typec_ucsi
rfkill typec wmi video i2c_scmi fuse xenfs ip_tables dm_thin_pool
dm_persistent_data dm_bio_prison dm_crypt trusted asn1_encoder
hid_multitouch amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel
gpu_sched i2c_algo_bit drm_ttm_helper sdhci_pci ghash_clmulni_intel ttm
cqhci drm_kms_helper serio_raw cec sdhci ccp xhci_pci xhci_pci_renesas
xhci_hcd drm nvme mmc_core ehci_pci ehci_hcd nvme_core
xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_gntalloc
xen_gntdev xen_evtchn uinput
Oct 11 22:32:57 dom0 kernel: CPU: 5 PID: 1425 Comm: setfont Tainted:
G        W        --------- ---  5.15.0-1.fc32.qubes.x86_64 #14
Oct 11 22:32:57 dom0 kernel: Hardware name: LENOVO
20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
Oct 11 22:32:57 dom0 kernel: RIP:
e030:amdgpu_dm_commit_planes+0x98c/0x9a0 [amdgpu]
Oct 11 22:32:57 dom0 kernel: Code: 8b 45 b0 48 c7 c7 a2 bc 8c c0 4c 89
55 88 8b b0 80 05 00 00 e8 e5 04 be ff 4c 8b 55 88 0f b6 55 ab 49 8b 72
08 e9 53 fa ff ff <0f> 0b e9 e2 fe ff ff e8 78 e4 82 c1 0f 1f 84 00 00
00 00 00 0f 1f
Oct 11 22:32:57 dom0 kernel: RSP: e02b:ffffc900403e7698 EFLAGS: 00010002
Oct 11 22:32:57 dom0 kernel: RAX: ffff888110500210 RBX: 00000000000010ac
RCX: 00000000000021e8
Oct 11 22:32:57 dom0 kernel: RDX: ffff88813f418e40 RSI: ffff888110500450
RDI: ffff88810ddf0f30
Oct 11 22:32:57 dom0 kernel: RBP: ffffc900403e7758 R08: 0000000000000002
R09: 00000000000c04d8
Oct 11 22:32:57 dom0 kernel: R10: 0000000000000000 R11: 0000000000080000
R12: ffff888110500210
Oct 11 22:32:57 dom0 kernel: R13: ffff88810d35e800 R14: ffff88810dee8cc0
R15: ffff88810ddada00
Oct 11 22:32:57 dom0 kernel: FS:  00007005ac91c580(0000)
GS:ffff88813f400000(0000) knlGS:0000000000000000
Oct 11 22:32:57 dom0 kernel: CS:  10000e030 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 11 22:32:57 dom0 kernel: CR2: 000073c449584d48 CR3: 0000000104974000
CR4: 0000000000050660
Oct 11 22:32:57 dom0 kernel: Call Trace:
Oct 11 22:32:57 dom0 kernel:  amdgpu_dm_atomic_commit_tail+0xbb2/0x1200
[amdgpu]
Oct 11 22:32:57 dom0 kernel:  commit_tail+0x94/0x130 [drm_kms_helper]
Oct 11 22:32:57 dom0 kernel:  drm_atomic_helper_commit+0x136/0x160
[drm_kms_helper]
Oct 11 22:32:57 dom0 kernel: 
drm_client_modeset_commit_atomic+0x249/0x290 [drm]
Oct 11 22:32:57 dom0 kernel:  drm_client_modeset_commit_locked+0x58/0x80
[drm]
Oct 11 22:32:57 dom0 kernel:  drm_fb_helper_pan_display+0x9b/0x110
[drm_kms_helper]
Oct 11 22:32:57 dom0 kernel:  fb_pan_display+0x8f/0x110
Oct 11 22:32:57 dom0 kernel:  bit_update_start+0x1a/0x40
Oct 11 22:32:57 dom0 kernel:  fbcon_switch+0x357/0x500
Oct 11 22:32:57 dom0 kernel:  redraw_screen+0xe9/0x230
Oct 11 22:32:57 dom0 kernel:  fbcon_do_set_font+0x170/0x190
Oct 11 22:32:57 dom0 kernel:  con_font_op+0x156/0x250
Oct 11 22:32:57 dom0 kernel:  ? do_anonymous_page+0x1ec/0x3b0
Oct 11 22:32:57 dom0 kernel:  ? _copy_from_user+0x45/0x80
Oct 11 22:32:57 dom0 kernel:  vt_k_ioctl+0x1b7/0x630
Oct 11 22:32:57 dom0 kernel:  vt_ioctl+0x7d/0x660
Oct 11 22:32:57 dom0 kernel:  tty_ioctl+0x354/0x810
Oct 11 22:32:57 dom0 kernel:  ? __lock_release+0x181/0x2d0
Oct 11 22:32:57 dom0 kernel:  ? ktime_get_coarse_real_ts64+0xe/0x50
Oct 11 22:32:57 dom0 kernel:  ?
lockdep_hardirqs_on_prepare.part.0+0xbf/0x140
Oct 11 22:32:57 dom0 kernel:  ?
seqcount_lockdep_reader_access.constprop.0+0x84/0x90
Oct 11 22:32:57 dom0 kernel:  __x64_sys_ioctl+0x83/0xb0
Oct 11 22:32:57 dom0 kernel:  do_syscall_64+0x3b/0x90
Oct 11 22:32:57 dom0 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Oct 11 22:32:57 dom0 kernel: RIP: 0033:0x7005ac84917b
Oct 11 22:32:57 dom0 kernel: Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7
00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8
10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ed ac 0c 00 f7
d8 64 89 01 48
Oct 11 22:32:57 dom0 kernel: RSP: 002b:00007ffc7dee5a78 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
Oct 11 22:32:57 dom0 kernel: RAX: ffffffffffffffda RBX: 0000000000000010
RCX: 00007005ac84917b
Oct 11 22:32:57 dom0 kernel: RDX: 00007ffc7dee5aa0 RSI: 0000000000004b72
RDI: 0000000000000003
Oct 11 22:32:57 dom0 kernel: RBP: 0000000000000200 R08: 0000000000000010
R09: 00007005ac914a40
Oct 11 22:32:57 dom0 kernel: R10: 0000000000000072 R11: 0000000000000246
R12: 0000000000000008
Oct 11 22:32:57 dom0 kernel: R13: 0000558e251606a0 R14: 0000000000000003
R15: 00007ffc7dee5aa0
Oct 11 22:32:57 dom0 kernel: irq event stamp: 13242
Oct 11 22:32:57 dom0 kernel: hardirqs last  enabled at (13241):
[<ffffffff81df81c7>] _raw_spin_unlock_irqrestore+0x37/0x40
Oct 11 22:32:57 dom0 kernel: hardirqs last disabled at (13242):
[<ffffffff81df7fc5>] _raw_spin_lock_irqsave+0x75/0x90
Oct 11 22:32:57 dom0 kernel: softirqs last  enabled at (12464):
[<ffffffff8103b972>] fpu_clone+0x72/0x200
Oct 11 22:32:57 dom0 kernel: softirqs last disabled at (12462):
[<ffffffff8103b905>] fpu_clone+0x5/0x200
Oct 11 22:32:57 dom0 kernel: ---[ end trace 6fec6583c02534af ]---
Oct 11 22:32:57 dom0 kernel: ------------[ cut here ]------------
Oct 11 22:32:57 dom0 kernel: WARNING: CPU: 5 PID: 1425 at
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8276
prepare_flip_isr+0x64/0x70 [amdgpu]
Oct 11 22:32:57 dom0 kernel: Modules linked in: intel_rapl_msr wmi_bmof
intel_rapl_common pcspkr uvcvideo videobuf2_vmalloc videobuf2_memops
joydev videobuf2_v4l2 k10temp videobuf2_common videodev sp5100_tco mc
i2c_piix4 iwlwifi cfg80211 thinkpad_acpi platform_profile ipmi_devintf
ledtrig_audio ipmi_msghandler snd r8169 ucsi_acpi soundcore typec_ucsi
rfkill typec wmi video i2c_scmi fuse xenfs ip_tables dm_thin_pool
dm_persistent_data dm_bio_prison dm_crypt trusted asn1_encoder
hid_multitouch amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel
gpu_sched i2c_algo_bit drm_ttm_helper sdhci_pci ghash_clmulni_intel ttm
cqhci drm_kms_helper serio_raw cec sdhci ccp xhci_pci xhci_pci_renesas
xhci_hcd drm nvme mmc_core ehci_pci ehci_hcd nvme_core
xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_gntalloc
xen_gntdev xen_evtchn uinput
Oct 11 22:32:57 dom0 kernel: CPU: 5 PID: 1425 Comm: setfont Tainted:
G        W        --------- ---  5.15.0-1.fc32.qubes.x86_64 #14
Oct 11 22:32:57 dom0 kernel: Hardware name: LENOVO
20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
Oct 11 22:32:57 dom0 kernel: RIP: e030:prepare_flip_isr+0x64/0x70 [amdgpu]
Oct 11 22:32:57 dom0 kernel: Code: 00 48 c7 80 38 01 00 00 00 00 00 00
66 90 c3 8b 97 80 05 00 00 48 c7 c6 d8 65 89 c0 48 c7 c7 d8 fa a1 c0 e9
0e ed 1f c1 0f 0b <0f> 0b eb b4 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
41 57 41 56 41
Oct 11 22:32:57 dom0 kernel: RSP: e02b:ffffc900403e7690 EFLAGS: 00010082
Oct 11 22:32:57 dom0 kernel: RAX: 0000000000000001 RBX: 00000000000010ac
RCX: 00000000000021e8
Oct 11 22:32:57 dom0 kernel: RDX: ffff88813f418e40 RSI: ffff888110500450
RDI: ffff88810d35e800
Oct 11 22:32:57 dom0 kernel: RBP: ffffc900403e7758 R08: 0000000000000002
R09: 00000000000c04d8
Oct 11 22:32:57 dom0 kernel: R10: 0000000000000000 R11: 0000000000080000
R12: ffff888110500210
Oct 11 22:32:57 dom0 kernel: R13: ffff88810d35e800 R14: ffff88810dee8cc0
R15: ffff88810ddada00
Oct 11 22:32:57 dom0 kernel: FS:  00007005ac91c580(0000)
GS:ffff88813f400000(0000) knlGS:0000000000000000
Oct 11 22:32:57 dom0 kernel: CS:  10000e030 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 11 22:32:57 dom0 kernel: CR2: 000073c449584d48 CR3: 0000000104974000
CR4: 0000000000050660
Oct 11 22:32:57 dom0 kernel: Call Trace:
Oct 11 22:32:57 dom0 kernel:  amdgpu_dm_commit_planes+0x87d/0x9a0 [amdgpu]
Oct 11 22:32:57 dom0 kernel:  amdgpu_dm_atomic_commit_tail+0xbb2/0x1200
[amdgpu]
Oct 11 22:32:57 dom0 kernel:  commit_tail+0x94/0x130 [drm_kms_helper]
Oct 11 22:32:57 dom0 kernel:  drm_atomic_helper_commit+0x136/0x160
[drm_kms_helper]
Oct 11 22:32:57 dom0 kernel: 
drm_client_modeset_commit_atomic+0x249/0x290 [drm]
Oct 11 22:32:57 dom0 kernel:  drm_client_modeset_commit_locked+0x58/0x80
[drm]
Oct 11 22:32:57 dom0 kernel:  drm_fb_helper_pan_display+0x9b/0x110
[drm_kms_helper]
Oct 11 22:32:57 dom0 kernel:  fb_pan_display+0x8f/0x110
Oct 11 22:32:57 dom0 kernel:  bit_update_start+0x1a/0x40
Oct 11 22:32:57 dom0 kernel:  fbcon_switch+0x357/0x500
Oct 11 22:32:57 dom0 kernel:  redraw_screen+0xe9/0x230
Oct 11 22:32:57 dom0 kernel:  fbcon_do_set_font+0x170/0x190
Oct 11 22:32:57 dom0 kernel:  con_font_op+0x156/0x250
Oct 11 22:32:57 dom0 kernel:  ? do_anonymous_page+0x1ec/0x3b0
Oct 11 22:32:57 dom0 kernel:  ? _copy_from_user+0x45/0x80
Oct 11 22:32:57 dom0 kernel:  vt_k_ioctl+0x1b7/0x630
Oct 11 22:32:57 dom0 kernel:  vt_ioctl+0x7d/0x660
Oct 11 22:32:57 dom0 kernel:  tty_ioctl+0x354/0x810
Oct 11 22:32:57 dom0 kernel:  ? __lock_release+0x181/0x2d0
Oct 11 22:32:57 dom0 kernel:  ? ktime_get_coarse_real_ts64+0xe/0x50
Oct 11 22:32:57 dom0 kernel:  ?
lockdep_hardirqs_on_prepare.part.0+0xbf/0x140
Oct 11 22:32:57 dom0 kernel:  ?
seqcount_lockdep_reader_access.constprop.0+0x84/0x90
Oct 11 22:32:57 dom0 kernel:  __x64_sys_ioctl+0x83/0xb0
Oct 11 22:32:57 dom0 kernel:  do_syscall_64+0x3b/0x90
Oct 11 22:32:57 dom0 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Oct 11 22:32:57 dom0 kernel: RIP: 0033:0x7005ac84917b
Oct 11 22:32:57 dom0 kernel: Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7
00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8
10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ed ac 0c 00 f7
d8 64 89 01 48
Oct 11 22:32:57 dom0 kernel: RSP: 002b:00007ffc7dee5a78 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
Oct 11 22:32:57 dom0 kernel: RAX: ffffffffffffffda RBX: 0000000000000010
RCX: 00007005ac84917b
Oct 11 22:32:57 dom0 kernel: RDX: 00007ffc7dee5aa0 RSI: 0000000000004b72
RDI: 0000000000000003
Oct 11 22:32:57 dom0 kernel: RBP: 0000000000000200 R08: 0000000000000010
R09: 00007005ac914a40
Oct 11 22:32:57 dom0 kernel: R10: 0000000000000072 R11: 0000000000000246
R12: 0000000000000008
Oct 11 22:32:57 dom0 kernel: R13: 0000558e251606a0 R14: 0000000000000003
R15: 00007ffc7dee5aa0
Oct 11 22:32:57 dom0 kernel: irq event stamp: 13242
Oct 11 22:32:57 dom0 kernel: hardirqs last  enabled at (13241):
[<ffffffff81df81c7>] _raw_spin_unlock_irqrestore+0x37/0x40
Oct 11 22:32:57 dom0 kernel: hardirqs last disabled at (13242):
[<ffffffff81df7fc5>] _raw_spin_lock_irqsave+0x75/0x90
Oct 11 22:32:57 dom0 kernel: softirqs last  enabled at (12464):
[<ffffffff8103b972>] fpu_clone+0x72/0x200
Oct 11 22:32:57 dom0 kernel: softirqs last disabled at (12462):
[<ffffffff8103b905>] fpu_clone+0x5/0x200
Oct 11 22:32:57 dom0 kernel: ---[ end trace 6fec6583c02534b0 ]---
Oct 11 22:33:07 dom0 kernel: [drm:drm_atomic_helper_wait_for_flip_done
[drm_kms_helper]] *ERROR* [CRTC:67:crtc-0] flip_done timed out
Oct 11 22:33:18 dom0 kernel: [drm:drm_crtc_commit_wait [drm]] *ERROR*
flip_done timed out
Oct 11 22:33:18 dom0 kernel:
[drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR*
[CRTC:67:crtc-0] commit wait timed out
Oct 11 22:33:28 dom0 kernel: [drm:drm_crtc_commit_wait [drm]] *ERROR*
flip_done timed out
Oct 11 22:33:28 dom0 kernel:
[drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR*
[CONNECTOR:78:eDP-1] commit wait timed out
Oct 11 22:33:38 dom0 kernel: [drm:drm_crtc_commit_wait [drm]] *ERROR*
flip_done timed out
Oct 11 22:33:38 dom0 kernel:
[drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR*
[PLANE:55:plane-3] commit wait timed out
Oct 11 22:33:38 dom0 kernel: ------------[ cut here ]------------
Oct 11 22:33:38 dom0 kernel: WARNING: CPU: 5 PID: 1427 at
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8689
amdgpu_dm_commit_planes+0x98c/0x9a0 [amdgpu]
Oct 11 22:33:38 dom0 kernel: Modules linked in: intel_rapl_msr wmi_bmof
intel_rapl_common pcspkr uvcvideo videobuf2_vmalloc videobuf2_memops
joydev videobuf2_v4l2 k10temp videobuf2_common videodev sp5100_tco mc
i2c_piix4 iwlwifi cfg80211 thinkpad_acpi platform_profile ipmi_devintf
ledtrig_audio ipmi_msghandler snd r8169 ucsi_acpi soundcore typec_ucsi
rfkill typec wmi video i2c_scmi fuse xenfs ip_tables dm_thin_pool
dm_persistent_data dm_bio_prison dm_crypt trusted asn1_encoder
hid_multitouch amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel
gpu_sched i2c_algo_bit drm_ttm_helper sdhci_pci ghash_clmulni_intel ttm
cqhci drm_kms_helper serio_raw cec sdhci ccp xhci_pci xhci_pci_renesas
xhci_hcd drm nvme mmc_core ehci_pci ehci_hcd nvme_core
xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_gntalloc
xen_gntdev xen_evtchn uinput
Oct 11 22:33:38 dom0 kernel: CPU: 5 PID: 1427 Comm: setfont Tainted:
G        W        --------- ---  5.15.0-1.fc32.qubes.x86_64 #14
Oct 11 22:33:38 dom0 kernel: Hardware name: LENOVO
20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
Oct 11 22:33:38 dom0 kernel: RIP:
e030:amdgpu_dm_commit_planes+0x98c/0x9a0 [amdgpu]
Oct 11 22:33:38 dom0 kernel: Code: 8b 45 b0 48 c7 c7 a2 bc 8c c0 4c 89
55 88 8b b0 80 05 00 00 e8 e5 04 be ff 4c 8b 55 88 0f b6 55 ab 49 8b 72
08 e9 53 fa ff ff <0f> 0b e9 e2 fe ff ff e8 78 e4 82 c1 0f 1f 84 00 00
00 00 00 0f 1f
Oct 11 22:33:38 dom0 kernel: RSP: e02b:ffffc90041613698 EFLAGS: 00010002
Oct 11 22:33:38 dom0 kernel: RAX: ffff888110500210 RBX: 0000000000001a46
RCX: 00000000000021e8
Oct 11 22:33:38 dom0 kernel: RDX: ffff88813f418e40 RSI: ffff888110500450
RDI: ffff888106330f30
Oct 11 22:33:38 dom0 kernel: RBP: ffffc90041613758 R08: 0000000000000002
R09: 00000000000c04d8
Oct 11 22:33:38 dom0 kernel: R10: 0000000000000000 R11: 0000000000080000
R12: ffff888110500210
Oct 11 22:33:38 dom0 kernel: R13: ffff88810d35e800 R14: ffff88810c39c0c0
R15: ffff88810de78c00
Oct 11 22:33:38 dom0 kernel: FS:  0000723fc3d77580(0000)
GS:ffff88813f400000(0000) knlGS:0000000000000000
Oct 11 22:33:38 dom0 kernel: CS:  10000e030 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 11 22:33:38 dom0 kernel: CR2: 000070eb0f040520 CR3: 000000010aeaa000
CR4: 0000000000050660
Oct 11 22:33:38 dom0 kernel: Call Trace:
Oct 11 22:33:38 dom0 kernel:  amdgpu_dm_atomic_commit_tail+0xbb2/0x1200
[amdgpu]
Oct 11 22:33:38 dom0 kernel:  commit_tail+0x94/0x130 [drm_kms_helper]
Oct 11 22:33:38 dom0 kernel:  drm_atomic_helper_commit+0x136/0x160
[drm_kms_helper]
Oct 11 22:33:38 dom0 kernel: 
drm_client_modeset_commit_atomic+0x249/0x290 [drm]
Oct 11 22:33:38 dom0 kernel:  drm_client_modeset_commit_locked+0x58/0x80
[drm]
Oct 11 22:33:38 dom0 kernel:  drm_fb_helper_pan_display+0x9b/0x110
[drm_kms_helper]
Oct 11 22:33:38 dom0 kernel:  fb_pan_display+0x8f/0x110
Oct 11 22:33:38 dom0 kernel:  bit_update_start+0x1a/0x40
Oct 11 22:33:38 dom0 kernel:  fbcon_switch+0x357/0x500
Oct 11 22:33:38 dom0 kernel:  redraw_screen+0xe9/0x230
Oct 11 22:33:38 dom0 kernel:  fbcon_do_set_font+0x170/0x190
Oct 11 22:33:38 dom0 kernel:  con_font_op+0x156/0x250
Oct 11 22:33:38 dom0 kernel:  ? do_anonymous_page+0x1ec/0x3b0
Oct 11 22:33:38 dom0 kernel:  ? _copy_from_user+0x45/0x80
Oct 11 22:33:38 dom0 kernel:  vt_k_ioctl+0x1b7/0x630
Oct 11 22:33:38 dom0 kernel:  vt_ioctl+0x7d/0x660
Oct 11 22:33:38 dom0 kernel:  tty_ioctl+0x354/0x810
Oct 11 22:33:38 dom0 kernel:  ? __lock_release+0x181/0x2d0
Oct 11 22:33:38 dom0 kernel:  ? ktime_get_coarse_real_ts64+0xe/0x50
Oct 11 22:33:38 dom0 kernel:  ?
lockdep_hardirqs_on_prepare.part.0+0xbf/0x140
Oct 11 22:33:38 dom0 kernel:  ?
seqcount_lockdep_reader_access.constprop.0+0x84/0x90
Oct 11 22:33:38 dom0 kernel:  __x64_sys_ioctl+0x83/0xb0
Oct 11 22:33:38 dom0 kernel:  do_syscall_64+0x3b/0x90
Oct 11 22:33:38 dom0 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Oct 11 22:33:38 dom0 kernel: RIP: 0033:0x723fc3ca417b
Oct 11 22:33:38 dom0 kernel: Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7
00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8
10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ed ac 0c 00 f7
d8 64 89 01 48
Oct 11 22:33:38 dom0 kernel: RSP: 002b:00007ffc0f3b06a8 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
Oct 11 22:33:38 dom0 kernel: RAX: ffffffffffffffda RBX: 0000000000000010
RCX: 0000723fc3ca417b
Oct 11 22:33:38 dom0 kernel: RDX: 00007ffc0f3b06d0 RSI: 0000000000004b72
RDI: 0000000000000003
Oct 11 22:33:38 dom0 kernel: RBP: 0000000000000200 R08: 0000000000000010
R09: 0000723fc3d6fa40
Oct 11 22:33:38 dom0 kernel: R10: 0000000000000072 R11: 0000000000000246
R12: 0000000000000008
Oct 11 22:33:38 dom0 kernel: R13: 00005750656256a0 R14: 0000000000000003
R15: 00007ffc0f3b06d0
Oct 11 22:33:38 dom0 kernel: irq event stamp: 9426
Oct 11 22:33:38 dom0 kernel: hardirqs last  enabled at (9425):
[<ffffffff81df81c7>] _raw_spin_unlock_irqrestore+0x37/0x40
Oct 11 22:33:38 dom0 kernel: hardirqs last disabled at (9426):
[<ffffffff81df7fc5>] _raw_spin_lock_irqsave+0x75/0x90
Oct 11 22:33:38 dom0 kernel: softirqs last  enabled at (8654):
[<ffffffff8103b972>] fpu_clone+0x72/0x200
Oct 11 22:33:38 dom0 kernel: softirqs last disabled at (8652):
[<ffffffff8103b905>] fpu_clone+0x5/0x200
Oct 11 22:33:38 dom0 kernel: ---[ end trace 6fec6583c02534b1 ]---
Oct 11 22:33:38 dom0 kernel: ------------[ cut here ]------------
Oct 11 22:33:38 dom0 kernel: WARNING: CPU: 5 PID: 1427 at
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8276
prepare_flip_isr+0x64/0x70 [amdgpu]
Oct 11 22:33:38 dom0 kernel: Modules linked in: intel_rapl_msr wmi_bmof
intel_rapl_common pcspkr uvcvideo videobuf2_vmalloc videobuf2_memops
joydev videobuf2_v4l2 k10temp videobuf2_common videodev sp5100_tco mc
i2c_piix4 iwlwifi cfg80211 thinkpad_acpi platform_profile ipmi_devintf
ledtrig_audio ipmi_msghandler snd r8169 ucsi_acpi soundcore typec_ucsi
rfkill typec wmi video i2c_scmi fuse xenfs ip_tables dm_thin_pool
dm_persistent_data dm_bio_prison dm_crypt trusted asn1_encoder
hid_multitouch amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel
gpu_sched i2c_algo_bit drm_ttm_helper sdhci_pci ghash_clmulni_intel ttm
cqhci drm_kms_helper serio_raw cec sdhci ccp xhci_pci xhci_pci_renesas
xhci_hcd drm nvme mmc_core ehci_pci ehci_hcd nvme_core
xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_gntalloc
xen_gntdev xen_evtchn uinput
Oct 11 22:33:38 dom0 kernel: CPU: 5 PID: 1427 Comm: setfont Tainted:
G        W        --------- ---  5.15.0-1.fc32.qubes.x86_64 #14
Oct 11 22:33:38 dom0 kernel: Hardware name: LENOVO
20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
Oct 11 22:33:38 dom0 kernel: RIP: e030:prepare_flip_isr+0x64/0x70 [amdgpu]
Oct 11 22:33:38 dom0 kernel: Code: 00 48 c7 80 38 01 00 00 00 00 00 00
66 90 c3 8b 97 80 05 00 00 48 c7 c6 d8 65 89 c0 48 c7 c7 d8 fa a1 c0 e9
0e ed 1f c1 0f 0b <0f> 0b eb b4 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
41 57 41 56 41
Oct 11 22:33:38 dom0 kernel: RSP: e02b:ffffc90041613690 EFLAGS: 00010086
Oct 11 22:33:38 dom0 kernel: RAX: 0000000000000001 RBX: 0000000000001a46
RCX: 00000000000021e8
Oct 11 22:33:38 dom0 kernel: RDX: ffff88813f418e40 RSI: ffff888110500450
RDI: ffff88810d35e800
Oct 11 22:33:38 dom0 kernel: RBP: ffffc90041613758 R08: 0000000000000002
R09: 00000000000c04d8
Oct 11 22:33:38 dom0 kernel: R10: 0000000000000000 R11: 0000000000080000
R12: ffff888110500210
Oct 11 22:33:38 dom0 kernel: R13: ffff88810d35e800 R14: ffff88810c39c0c0
R15: ffff88810de78c00
Oct 11 22:33:38 dom0 kernel: FS:  0000723fc3d77580(0000)
GS:ffff88813f400000(0000) knlGS:0000000000000000
Oct 11 22:33:38 dom0 kernel: CS:  10000e030 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 11 22:33:38 dom0 kernel: CR2: 000070eb0f040520 CR3: 000000010aeaa000
CR4: 0000000000050660
Oct 11 22:33:38 dom0 kernel: Call Trace:
Oct 11 22:33:38 dom0 kernel:  amdgpu_dm_commit_planes+0x87d/0x9a0 [amdgpu]
Oct 11 22:33:38 dom0 kernel:  amdgpu_dm_atomic_commit_tail+0xbb2/0x1200
[amdgpu]
Oct 11 22:33:38 dom0 kernel:  commit_tail+0x94/0x130 [drm_kms_helper]
Oct 11 22:33:38 dom0 kernel:  drm_atomic_helper_commit+0x136/0x160
[drm_kms_helper]
Oct 11 22:33:38 dom0 kernel: 
drm_client_modeset_commit_atomic+0x249/0x290 [drm]
Oct 11 22:33:38 dom0 kernel:  drm_client_modeset_commit_locked+0x58/0x80
[drm]
Oct 11 22:33:38 dom0 kernel:  drm_fb_helper_pan_display+0x9b/0x110
[drm_kms_helper]
Oct 11 22:33:38 dom0 kernel:  fb_pan_display+0x8f/0x110
Oct 11 22:33:38 dom0 kernel:  bit_update_start+0x1a/0x40
Oct 11 22:33:38 dom0 kernel:  fbcon_switch+0x357/0x500
Oct 11 22:33:38 dom0 kernel:  redraw_screen+0xe9/0x230
Oct 11 22:33:38 dom0 kernel:  fbcon_do_set_font+0x170/0x190
Oct 11 22:33:38 dom0 kernel:  con_font_op+0x156/0x250
Oct 11 22:33:38 dom0 kernel:  ? do_anonymous_page+0x1ec/0x3b0
Oct 11 22:33:38 dom0 kernel:  ? _copy_from_user+0x45/0x80
Oct 11 22:33:38 dom0 kernel:  vt_k_ioctl+0x1b7/0x630
Oct 11 22:33:38 dom0 kernel:  vt_ioctl+0x7d/0x660
Oct 11 22:33:38 dom0 kernel:  tty_ioctl+0x354/0x810
Oct 11 22:33:38 dom0 kernel:  ? __lock_release+0x181/0x2d0
Oct 11 22:33:38 dom0 kernel:  ? ktime_get_coarse_real_ts64+0xe/0x50
Oct 11 22:33:38 dom0 kernel:  ?
lockdep_hardirqs_on_prepare.part.0+0xbf/0x140
Oct 11 22:33:38 dom0 kernel:  ?
seqcount_lockdep_reader_access.constprop.0+0x84/0x90
Oct 11 22:33:38 dom0 kernel:  __x64_sys_ioctl+0x83/0xb0
Oct 11 22:33:38 dom0 kernel:  do_syscall_64+0x3b/0x90
Oct 11 22:33:38 dom0 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Oct 11 22:33:38 dom0 kernel: RIP: 0033:0x723fc3ca417b
Oct 11 22:33:38 dom0 kernel: Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7
00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8
10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ed ac 0c 00 f7
d8 64 89 01 48
Oct 11 22:33:38 dom0 kernel: RSP: 002b:00007ffc0f3b06a8 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
Oct 11 22:33:38 dom0 kernel: RAX: ffffffffffffffda RBX: 0000000000000010
RCX: 0000723fc3ca417b
Oct 11 22:33:38 dom0 kernel: RDX: 00007ffc0f3b06d0 RSI: 0000000000004b72
RDI: 0000000000000003
Oct 11 22:33:38 dom0 kernel: RBP: 0000000000000200 R08: 0000000000000010
R09: 0000723fc3d6fa40
Oct 11 22:33:38 dom0 kernel: R10: 0000000000000072 R11: 0000000000000246
R12: 0000000000000008
Oct 11 22:33:38 dom0 kernel: R13: 00005750656256a0 R14: 0000000000000003
R15: 00007ffc0f3b06d0
Oct 11 22:33:38 dom0 kernel: irq event stamp: 9426
Oct 11 22:33:38 dom0 kernel: hardirqs last  enabled at (9425):
[<ffffffff81df81c7>] _raw_spin_unlock_irqrestore+0x37/0x40
Oct 11 22:33:38 dom0 kernel: hardirqs last disabled at (9426):
[<ffffffff81df7fc5>] _raw_spin_lock_irqsave+0x75/0x90
Oct 11 22:33:38 dom0 kernel: softirqs last  enabled at (8654):
[<ffffffff8103b972>] fpu_clone+0x72/0x200
Oct 11 22:33:38 dom0 kernel: softirqs last disabled at (8652):
[<ffffffff8103b905>] fpu_clone+0x5/0x200
Oct 11 22:33:38 dom0 kernel: ---[ end trace 6fec6583c02534b2 ]---
Oct 11 22:33:48 dom0 kernel: [drm:drm_atomic_helper_wait_for_flip_done
[drm_kms_helper]] *ERROR* [CRTC:67:crtc-0] flip_done timed out
Oct 11 22:33:49 dom0 kernel: EXT4-fs (nvme0n1p2): mounted filesystem
with ordered data mode. Opts: discard. Quota mode: none.
Oct 11 22:33:56 dom0 kernel: [drm] Fence fallback timer expired on ring
sdma0
Oct 11 22:33:59 dom0 kernel: usb 6-1: USB disconnect, device number 2
Oct 11 22:34:06 dom0 kernel: [drm:drm_crtc_commit_wait [drm]] *ERROR*
flip_done timed out
Oct 11 22:34:06 dom0 kernel:
[drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR*
[CRTC:67:crtc-0] commit wait timed out
Oct 11 22:34:17 dom0 kernel: [drm:drm_crtc_commit_wait [drm]] *ERROR*
flip_done timed out
Oct 11 22:34:17 dom0 kernel:
[drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR*
[CONNECTOR:78:eDP-1] commit wait timed out
Oct 11 22:34:27 dom0 kernel: [drm:drm_crtc_commit_wait [drm]] *ERROR*
flip_done timed out
Oct 11 22:34:27 dom0 kernel:
[drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR*
[PLANE:55:plane-3] commit wait timed out
Oct 11 22:34:27 dom0 kernel: ------------[ cut here ]------------
Oct 11 22:34:27 dom0 kernel: WARNING: CPU: 7 PID: 2636 at
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8689
amdgpu_dm_commit_planes+0x98c/0x9a0 [amdgpu]
Oct 11 22:34:27 dom0 kernel: Modules linked in: nf_tables nfnetlink vfat
fat intel_rapl_msr wmi_bmof intel_rapl_common pcspkr uvcvideo
videobuf2_vmalloc videobuf2_memops joydev videobuf2_v4l2 k10temp
videobuf2_common videodev sp5100_tco mc i2c_piix4 iwlwifi cfg80211
thinkpad_acpi platform_profile ipmi_devintf ledtrig_audio
ipmi_msghandler snd r8169 ucsi_acpi soundcore typec_ucsi rfkill typec
wmi video i2c_scmi fuse xenfs ip_tables dm_thin_pool dm_persistent_data
dm_bio_prison dm_crypt trusted asn1_encoder hid_multitouch amdgpu
crct10dif_pclmul crc32_pclmul crc32c_intel gpu_sched i2c_algo_bit
drm_ttm_helper sdhci_pci ghash_clmulni_intel ttm cqhci drm_kms_helper
serio_raw cec sdhci ccp xhci_pci xhci_pci_renesas xhci_hcd drm nvme
mmc_core ehci_pci ehci_hcd nvme_core xen_acpi_processor xen_privcmd
xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput
Oct 11 22:34:27 dom0 kernel: CPU: 7 PID: 2636 Comm: Xorg Tainted:
G        W        --------- ---  5.15.0-1.fc32.qubes.x86_64 #14
Oct 11 22:34:27 dom0 kernel: Hardware name: LENOVO
20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
Oct 11 22:34:27 dom0 kernel: RIP:
e030:amdgpu_dm_commit_planes+0x98c/0x9a0 [amdgpu]
Oct 11 22:34:27 dom0 kernel: Code: 8b 45 b0 48 c7 c7 a2 bc 8c c0 4c 89
55 88 8b b0 80 05 00 00 e8 e5 04 be ff 4c 8b 55 88 0f b6 55 ab 49 8b 72
08 e9 53 fa ff ff <0f> 0b e9 e2 fe ff ff e8 78 e4 82 c1 0f 1f 84 00 00
00 00 00 0f 1f
Oct 11 22:34:27 dom0 kernel: RSP: e02b:ffffc90042d8f960 EFLAGS: 00010002
Oct 11 22:34:27 dom0 kernel: RAX: ffff888110500210 RBX: 00000000000025ad
RCX: 00000000000021e8
Oct 11 22:34:27 dom0 kernel: RDX: ffff88813f818e40 RSI: ffff888110500450
RDI: ffff888104cec3f0
Oct 11 22:34:27 dom0 kernel: RBP: ffffc90042d8fa20 R08: 0000000000000002
R09: 00000000000c04d8
Oct 11 22:34:27 dom0 kernel: R10: 0000000000000000 R11: 0000000000080000
R12: ffff888110500210
Oct 11 22:34:27 dom0 kernel: R13: ffff88810d35e800 R14: ffff88810a677cc0
R15: ffff88810a6d5c00
Oct 11 22:34:27 dom0 kernel: FS:  00007f896429fa40(0000)
GS:ffff88813f800000(0000) knlGS:0000000000000000
Oct 11 22:34:27 dom0 kernel: CS:  10000e030 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 11 22:34:27 dom0 kernel: CR2: 00007cc75690e000 CR3: 00000001062e6000
CR4: 0000000000050660
Oct 11 22:34:27 dom0 kernel: Call Trace:
Oct 11 22:34:27 dom0 kernel:  amdgpu_dm_atomic_commit_tail+0xbb2/0x1200
[amdgpu]
Oct 11 22:34:27 dom0 kernel:  commit_tail+0x94/0x130 [drm_kms_helper]
Oct 11 22:34:27 dom0 kernel:  drm_atomic_helper_commit+0x136/0x160
[drm_kms_helper]
Oct 11 22:34:27 dom0 kernel: 
drm_client_modeset_commit_atomic+0x249/0x290 [drm]
Oct 11 22:34:27 dom0 kernel:  drm_client_modeset_commit_locked+0x58/0x80
[drm]
Oct 11 22:34:27 dom0 kernel:  drm_client_modeset_commit+0x24/0x40 [drm]
Oct 11 22:34:27 dom0 kernel:  drm_fb_helper_lastclose+0x45/0x80
[drm_kms_helper]
Oct 11 22:34:27 dom0 kernel:  amdgpu_driver_lastclose_kms+0xa/0x10 [amdgpu]
Oct 11 22:34:27 dom0 kernel:  drm_release+0xe1/0x110 [drm]
Oct 11 22:34:27 dom0 kernel:  __fput+0x9d/0x260
Oct 11 22:34:27 dom0 kernel:  task_work_run+0x5c/0x90
Oct 11 22:34:27 dom0 kernel:  exit_to_user_mode_loop+0x1ce/0x1e0
Oct 11 22:34:27 dom0 kernel:  exit_to_user_mode_prepare+0xe3/0x150
Oct 11 22:34:27 dom0 kernel:  syscall_exit_to_user_mode+0x27/0x60
Oct 11 22:34:27 dom0 kernel:  do_syscall_64+0x48/0x90
Oct 11 22:34:27 dom0 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Oct 11 22:34:27 dom0 kernel: RIP: 0033:0x7f896486ba17
Oct 11 22:34:27 dom0 kernel: Code: 00 00 f7 d8 64 89 02 48 c7 c0 ff ff
ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8
03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c
e8 f3 fb ff ff
Oct 11 22:34:27 dom0 kernel: RSP: 002b:00007fff9083b528 EFLAGS: 00000246
ORIG_RAX: 0000000000000003
Oct 11 22:34:27 dom0 kernel: RAX: 0000000000000000 RBX: 00005f57edbd09f0
RCX: 00007f896486ba17
Oct 11 22:34:27 dom0 kernel: RDX: 00005f57edbb1010 RSI: 00005f57edbd0b60
RDI: 0000000000000014
Oct 11 22:34:27 dom0 kernel: RBP: 0000000000000014 R08: 0000000000000000
R09: 00007f896484fa40
Oct 11 22:34:27 dom0 kernel: R10: 00005f57eba9c302 R11: 0000000000000246
R12: 00005f57edbd0b60
Oct 11 22:34:27 dom0 kernel: R13: 00005f57edbd0a30 R14: 0000000000000000
R15: 0000000000000000
Oct 11 22:34:27 dom0 kernel: irq event stamp: 51614
Oct 11 22:34:27 dom0 kernel: hardirqs last  enabled at (51613):
[<ffffffff81df81c7>] _raw_spin_unlock_irqrestore+0x37/0x40
Oct 11 22:34:27 dom0 kernel: hardirqs last disabled at (51614):
[<ffffffff81df7fc5>] _raw_spin_lock_irqsave+0x75/0x90
Oct 11 22:34:27 dom0 kernel: softirqs last  enabled at (51264):
[<ffffffff820002f9>] __do_softirq+0x2f9/0x428
Oct 11 22:34:27 dom0 kernel: softirqs last disabled at (51257):
[<ffffffff810f50c0>] __irq_exit_rcu+0xd0/0x100
Oct 11 22:34:27 dom0 kernel: ---[ end trace 6fec6583c02534b3 ]---
Oct 11 22:34:27 dom0 kernel: ------------[ cut here ]------------
Oct 11 22:34:27 dom0 kernel: WARNING: CPU: 7 PID: 2636 at
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8276
prepare_flip_isr+0x64/0x70 [amdgpu]
Oct 11 22:34:27 dom0 kernel: Modules linked in: nf_tables nfnetlink vfat
fat intel_rapl_msr wmi_bmof intel_rapl_common pcspkr uvcvideo
videobuf2_vmalloc videobuf2_memops joydev videobuf2_v4l2 k10temp
videobuf2_common videodev sp5100_tco mc i2c_piix4 iwlwifi cfg80211
thinkpad_acpi platform_profile ipmi_devintf ledtrig_audio
ipmi_msghandler snd r8169 ucsi_acpi soundcore typec_ucsi rfkill typec
wmi video i2c_scmi fuse xenfs ip_tables dm_thin_pool dm_persistent_data
dm_bio_prison dm_crypt trusted asn1_encoder hid_multitouch amdgpu
crct10dif_pclmul crc32_pclmul crc32c_intel gpu_sched i2c_algo_bit
drm_ttm_helper sdhci_pci ghash_clmulni_intel ttm cqhci drm_kms_helper
serio_raw cec sdhci ccp xhci_pci xhci_pci_renesas xhci_hcd drm nvme
mmc_core ehci_pci ehci_hcd nvme_core xen_acpi_processor xen_privcmd
xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput
Oct 11 22:34:27 dom0 kernel: CPU: 7 PID: 2636 Comm: Xorg Tainted:
G        W        --------- ---  5.15.0-1.fc32.qubes.x86_64 #14
Oct 11 22:34:27 dom0 kernel: Hardware name: LENOVO
20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
Oct 11 22:34:27 dom0 kernel: RIP: e030:prepare_flip_isr+0x64/0x70 [amdgpu]
Oct 11 22:34:27 dom0 kernel: Code: 00 48 c7 80 38 01 00 00 00 00 00 00
66 90 c3 8b 97 80 05 00 00 48 c7 c6 d8 65 89 c0 48 c7 c7 d8 fa a1 c0 e9
0e ed 1f c1 0f 0b <0f> 0b eb b4 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
41 57 41 56 41
Oct 11 22:34:27 dom0 kernel: RSP: e02b:ffffc90042d8f958 EFLAGS: 00010082
Oct 11 22:34:27 dom0 kernel: RAX: 0000000000000001 RBX: 00000000000025ad
RCX: 00000000000021e8
Oct 11 22:34:27 dom0 kernel: RDX: ffff88813f818e40 RSI: ffff888110500450
RDI: ffff88810d35e800
Oct 11 22:34:27 dom0 kernel: RBP: ffffc90042d8fa20 R08: 0000000000000002
R09: 00000000000c04d8
Oct 11 22:34:27 dom0 kernel: R10: 0000000000000000 R11: 0000000000080000
R12: ffff888110500210
Oct 11 22:34:27 dom0 kernel: R13: ffff88810d35e800 R14: ffff88810a677cc0
R15: ffff88810a6d5c00
Oct 11 22:34:27 dom0 kernel: FS:  00007f896429fa40(0000)
GS:ffff88813f800000(0000) knlGS:0000000000000000
Oct 11 22:34:27 dom0 kernel: CS:  10000e030 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 11 22:34:27 dom0 kernel: CR2: 00007cc75690e000 CR3: 00000001062e6000
CR4: 0000000000050660
Oct 11 22:34:27 dom0 kernel: Call Trace:
Oct 11 22:34:27 dom0 kernel:  amdgpu_dm_commit_planes+0x87d/0x9a0 [amdgpu]
Oct 11 22:34:27 dom0 kernel:  amdgpu_dm_atomic_commit_tail+0xbb2/0x1200
[amdgpu]
Oct 11 22:34:27 dom0 kernel:  commit_tail+0x94/0x130 [drm_kms_helper]
Oct 11 22:34:27 dom0 kernel:  drm_atomic_helper_commit+0x136/0x160
[drm_kms_helper]
Oct 11 22:34:27 dom0 kernel: 
drm_client_modeset_commit_atomic+0x249/0x290 [drm]
Oct 11 22:34:27 dom0 kernel:  drm_client_modeset_commit_locked+0x58/0x80
[drm]
Oct 11 22:34:27 dom0 kernel:  drm_client_modeset_commit+0x24/0x40 [drm]
Oct 11 22:34:27 dom0 kernel:  drm_fb_helper_lastclose+0x45/0x80
[drm_kms_helper]
Oct 11 22:34:27 dom0 kernel:  amdgpu_driver_lastclose_kms+0xa/0x10 [amdgpu]
Oct 11 22:34:27 dom0 kernel:  drm_release+0xe1/0x110 [drm]
Oct 11 22:34:27 dom0 kernel:  __fput+0x9d/0x260
Oct 11 22:34:27 dom0 kernel:  task_work_run+0x5c/0x90
Oct 11 22:34:27 dom0 kernel:  exit_to_user_mode_loop+0x1ce/0x1e0
Oct 11 22:34:27 dom0 kernel:  exit_to_user_mode_prepare+0xe3/0x150
Oct 11 22:34:27 dom0 kernel:  syscall_exit_to_user_mode+0x27/0x60
Oct 11 22:34:27 dom0 kernel:  do_syscall_64+0x48/0x90
Oct 11 22:34:27 dom0 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Oct 11 22:34:27 dom0 kernel: RIP: 0033:0x7f896486ba17
Oct 11 22:34:27 dom0 kernel: Code: 00 00 f7 d8 64 89 02 48 c7 c0 ff ff
ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8
03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c
e8 f3 fb ff ff
Oct 11 22:34:27 dom0 kernel: RSP: 002b:00007fff9083b528 EFLAGS: 00000246
ORIG_RAX: 0000000000000003
Oct 11 22:34:27 dom0 kernel: RAX: 0000000000000000 RBX: 00005f57edbd09f0
RCX: 00007f896486ba17
Oct 11 22:34:27 dom0 kernel: RDX: 00005f57edbb1010 RSI: 00005f57edbd0b60
RDI: 0000000000000014
Oct 11 22:34:27 dom0 kernel: RBP: 0000000000000014 R08: 0000000000000000
R09: 00007f896484fa40
Oct 11 22:34:27 dom0 kernel: R10: 00005f57eba9c302 R11: 0000000000000246
R12: 00005f57edbd0b60
Oct 11 22:34:27 dom0 kernel: R13: 00005f57edbd0a30 R14: 0000000000000000
R15: 0000000000000000
Oct 11 22:34:27 dom0 kernel: irq event stamp: 51614
Oct 11 22:34:27 dom0 kernel: hardirqs last  enabled at (51613):
[<ffffffff81df81c7>] _raw_spin_unlock_irqrestore+0x37/0x40
Oct 11 22:34:27 dom0 kernel: hardirqs last disabled at (51614):
[<ffffffff81df7fc5>] _raw_spin_lock_irqsave+0x75/0x90
Oct 11 22:34:27 dom0 kernel: softirqs last  enabled at (51264):
[<ffffffff820002f9>] __do_softirq+0x2f9/0x428
Oct 11 22:34:27 dom0 kernel: softirqs last disabled at (51257):
[<ffffffff810f50c0>] __irq_exit_rcu+0xd0/0x100
Oct 11 22:34:27 dom0 kernel: ---[ end trace 6fec6583c02534b4 ]---
Oct 11 22:34:37 dom0 kernel: [drm:drm_atomic_helper_wait_for_flip_done
[drm_kms_helper]] *ERROR* [CRTC:67:crtc-0] flip_done timed out
Oct 11 22:34:38 dom0 kernel: [drm] Fence fallback timer expired on ring
sdma0
Oct 11 22:34:48 dom0 kernel: [drm:drm_crtc_commit_wait [drm]] *ERROR*
flip_done timed out
Oct 11 22:34:48 dom0 kernel:
[drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR*
[CRTC:67:crtc-0] commit wait timed out
Oct 11 22:34:58 dom0 kernel: [drm:drm_crtc_commit_wait [drm]] *ERROR*
flip_done timed out
Oct 11 22:34:58 dom0 kernel:
[drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR*
[CONNECTOR:78:eDP-1] commit wait timed out
Oct 11 22:35:08 dom0 kernel: [drm:drm_crtc_commit_wait [drm]] *ERROR*
flip_done timed out
Oct 11 22:35:08 dom0 kernel:
[drm:drm_atomic_helper_wait_for_dependencies [drm_kms_helper]] *ERROR*
[PLANE:55:plane-3] commit wait timed out
Oct 11 22:35:08 dom0 kernel: ------------[ cut here ]------------

Full log with drm.debug=1 can be be found at the original issue
https://gitlab.freedesktop.org/drm/amd/-/issues/1715
https://gitlab.freedesktop.org/drm/amd/uploads/c91af638cb8fb5f3c25130f1edabb47e/dmesg


My original goal was to solve suspend/resume, that is why I'm testing
out v5.15. During that investigation I have found that:
* v5.15-rc2+ with pci=nomsi is quite resilient to crashing amdgpu drivers
* Compiling with CONFIG_HSA_AMD=n makes a difference, I don't believe Xen
  has proper support for HSA anyhow.
* Compiling with CONFIG_AMD_PMC=y makes a difference, apparently qiurks
  are enabled when not compiling as a module.

I did a last honest try with v5.15-rc5 with this patch applied to get more
data and I did find some more. The original problem show itself, but since
amdgpu actually describes their firmware commands now, it became less cryptic.

After this message the screen will be blank, I can still get passed the xscreensaver
but the screen is dead. With pci=nomsi applied I can after suspending the laptop
once more, get the screen back in order. This also occurs without starting X.

Oct 17 22:49:11 dom0 kernel: nvme 0000:01:00.0: saving config space at offset 0x38 (reading 0x0)
Oct 17 22:49:11 dom0 kernel: nvme 0000:01:00.0: saving config space at offset 0x3c (reading 0x1ff)
Oct 17 22:49:11 dom0 kernel: usb 4-4: reset full-speed USB device number 3 using xhci_hcd
Oct 17 22:49:11 dom0 kernel: nvme nvme0: 8/0/0 default/read/poll queues
Oct 17 22:49:11 dom0 kernel: usb 1-2: reset high-speed USB device number 2 using xhci_hcd
Oct 17 22:49:11 dom0 kernel: psmouse serio1: synaptics: queried max coordinates: x [..5678], y [..4694]
Oct 17 22:49:11 dom0 kernel: psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
Oct 17 22:49:11 dom0 kernel: [drm] psp gfx command SETUP_TMR(0x5) failed and response status is (0x0)
Oct 17 22:49:11 dom0 kernel: [drm:psp_hw_start [amdgpu]] *ERROR* PSP load tmr failed!
Oct 17 22:49:11 dom0 kernel: [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
Oct 17 22:49:11 dom0 kernel: [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* resume of IP block <psp> failed -22
Oct 17 22:49:11 dom0 kernel: amdgpu 0000:07:00.0: amdgpu: amdgpu_device_ip_resume failed (-22).
Oct 17 22:49:11 dom0 kernel: PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -22
Oct 17 22:49:11 dom0 kernel: amdgpu 0000:07:00.0: PM: failed to resume async: error -22
Oct 17 22:49:11 dom0 kernel: PM: resume devices took 2.422 seconds
Oct 17 22:49:11 dom0 kernel: OOM killer enabled.
Oct 17 22:49:11 dom0 kernel: Restarting tasks ... done.
Oct 17 22:49:11 dom0 kernel: PM: suspend exit

Since I also had _a lot_ of debug-flags applied I also got this neat deadlock

Oct 17 22:52:07 dom0 kernel: [Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW (0x0)
Oct 17 22:52:07 dom0 kernel: ACPI: \_SB_.PLTF.C002: Found 3 idle states
Oct 17 22:52:07 dom0 kernel: ACPI: FW issue: working around C-state latencies out of order
Oct 17 22:52:07 dom0 kernel: CPU2 is up
Oct 17 22:52:07 dom0 kernel: ------------[ cut here ]------------
Oct 17 22:52:07 dom0 kernel: installing Xen timer for CPU 3
Oct 17 22:52:07 dom0 kernel: 
Oct 17 22:52:07 dom0 kernel: ======================================================
Oct 17 22:52:07 dom0 kernel: WARNING: possible circular locking dependency detected
Oct 17 22:52:07 dom0 kernel: 5.15.0-0.rc5.0.fc32.qubes.x86_64 #1 Tainted: G        W        --------- --- 
Oct 17 22:52:07 dom0 kernel: ------------------------------------------------------
Oct 17 22:52:07 dom0 kernel: kworker/2:0/11917 is trying to acquire lock:
Oct 17 22:52:07 dom0 kernel: ffffffff82962858 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0xf/0x30
Oct 17 22:52:07 dom0 kernel: 
                             but task is already holding lock:
Oct 17 22:52:07 dom0 kernel: ffff8881406ab558 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x1e/0x80
Oct 17 22:52:07 dom0 kernel: 
                             which lock already depends on the new lock.
Oct 17 22:52:07 dom0 kernel: 
                             the existing dependency chain (in reverse order) is:
Oct 17 22:52:07 dom0 kernel: 
                             -> #2 (&rq->__lock){-.-.}-{2:2}:
Oct 17 22:52:07 dom0 kernel:        __lock_acquire+0x3a0/0x6b0
Oct 17 22:52:07 dom0 kernel:        lock_acquire+0xf5/0x300
Oct 17 22:52:07 dom0 kernel:        _raw_spin_lock_nested+0x2a/0x40
Oct 17 22:52:07 dom0 kernel:        raw_spin_rq_lock_nested+0x1e/0x80
Oct 17 22:52:07 dom0 kernel:        task_fork_fair+0x39/0x180
Oct 17 22:52:07 dom0 kernel:        sched_fork+0x115/0x290
Oct 17 22:52:07 dom0 kernel:        copy_process+0xd2e/0x2b80
Oct 17 22:52:07 dom0 kernel:        kernel_clone+0xa4/0x300
Oct 17 22:52:07 dom0 kernel:        kernel_thread+0x55/0x70
Oct 17 22:52:07 dom0 kernel:        rest_init+0x1e/0x280
Oct 17 22:52:07 dom0 kernel:        start_kernel+0x65d/0x69b
Oct 17 22:52:07 dom0 kernel:        xen_start_kernel+0x5fb/0x61c
Oct 17 22:52:07 dom0 kernel:        reset_early_page_tables+0x0/0x9d
Oct 17 22:52:07 dom0 kernel: 
                             -> #1 (&p->pi_lock){-.-.}-{2:2}:
Oct 17 22:52:07 dom0 kernel:        __lock_acquire+0x3a0/0x6b0
Oct 17 22:52:07 dom0 kernel:        lock_acquire+0xf5/0x300
Oct 17 22:52:07 dom0 kernel:        _raw_spin_lock_irqsave+0x48/0x60
Oct 17 22:52:07 dom0 kernel:        try_to_wake_up+0x53/0x5f0
Oct 17 22:52:07 dom0 kernel:        up+0x40/0x60
Oct 17 22:52:07 dom0 kernel:        __up_console_sem+0x56/0x70
Oct 17 22:52:07 dom0 kernel:        console_unlock+0x2ae/0x3c0
Oct 17 22:52:07 dom0 kernel:        vprintk_emit+0x141/0x160
Oct 17 22:52:07 dom0 kernel:        _printk+0x68/0x7f
Oct 17 22:52:07 dom0 kernel:        acpi_register_gsi_xen.cold+0x61/0x81
Oct 17 22:52:07 dom0 kernel:        acpi_pci_irq_enable+0xdd/0x240
Oct 17 22:52:07 dom0 kernel:        do_pci_enable_device+0x8a/0x110
Oct 17 22:52:07 dom0 kernel:        pci_enable_device_flags+0xcf/0x100
Oct 17 22:52:07 dom0 kernel:        nvme_pci_enable+0x28/0x1e0 [nvme]
Oct 17 22:52:07 dom0 kernel:        nvme_reset_work+0x61/0x490 [nvme]
Oct 17 22:52:07 dom0 kernel:        process_one_work+0x294/0x590
Oct 17 22:52:07 dom0 kernel:        worker_thread+0x49/0x310
Oct 17 22:52:07 dom0 kernel:        kthread+0x120/0x140
Oct 17 22:52:07 dom0 kernel:        ret_from_fork+0x22/0x30
Oct 17 22:52:07 dom0 kernel: 
                             -> #0 ((console_sem).lock){-...}-{2:2}:
Oct 17 22:52:07 dom0 kernel:        check_prev_add+0x8f/0xbf0
Oct 17 22:52:07 dom0 kernel:        validate_chain+0x38a/0x420
Oct 17 22:52:07 dom0 kernel:        __lock_acquire+0x3a0/0x6b0
Oct 17 22:52:07 dom0 kernel:        lock_acquire+0xf5/0x300
Oct 17 22:52:07 dom0 kernel:        _raw_spin_lock_irqsave+0x48/0x60
Oct 17 22:52:07 dom0 kernel:        down_trylock+0xf/0x30
Oct 17 22:52:07 dom0 kernel:        __down_trylock_console_sem+0x32/0xa0
Oct 17 22:52:07 dom0 kernel:        console_trylock_spinning+0x13/0x1e0
Oct 17 22:52:07 dom0 kernel:        vprintk_emit+0xa8/0x160
Oct 17 22:52:07 dom0 kernel:        _printk+0x68/0x7f
Oct 17 22:52:07 dom0 kernel:        __warn_printk+0x51/0x93
Oct 17 22:52:07 dom0 kernel:        __update_blocked_fair+0x4f4/0x510
Oct 17 22:52:07 dom0 kernel:        update_blocked_averages+0xe3/0x280
Oct 17 22:52:07 dom0 kernel:        newidle_balance+0x160/0x600
Oct 17 22:52:07 dom0 kernel:        pick_next_task_fair+0x39/0x3f0
Oct 17 22:52:07 dom0 kernel:        pick_next_task+0x4c/0xbb0
Oct 17 22:52:07 dom0 kernel:        __schedule+0x135/0x600
Oct 17 22:52:07 dom0 kernel:        schedule+0x59/0xc0
Oct 17 22:52:07 dom0 kernel:        worker_thread+0xb3/0x310
Oct 17 22:52:07 dom0 kernel:        kthread+0x120/0x140
Oct 17 22:52:07 dom0 kernel:        ret_from_fork+0x22/0x30
Oct 17 22:52:07 dom0 kernel: 
                             other info that might help us debug this:
Oct 17 22:52:07 dom0 kernel: Chain exists of:
                               (console_sem).lock --> &p->pi_lock --> &rq->__lock
Oct 17 22:52:07 dom0 kernel:  Possible unsafe locking scenario:
Oct 17 22:52:07 dom0 kernel:        CPU0                    CPU1
Oct 17 22:52:07 dom0 kernel:        ----                    ----
Oct 17 22:52:07 dom0 kernel:   lock(&rq->__lock);
Oct 17 22:52:07 dom0 kernel:                                lock(&p->pi_lock);
Oct 17 22:52:07 dom0 kernel:                                lock(&rq->__lock);
Oct 17 22:52:07 dom0 kernel:   lock((console_sem).lock);
Oct 17 22:52:07 dom0 kernel: 
                              *** DEADLOCK ***
Oct 17 22:52:07 dom0 kernel: 1 lock held by kworker/2:0/11917:
Oct 17 22:52:07 dom0 kernel:  #0: ffff8881406ab558 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x1e/0x80
Oct 17 22:52:07 dom0 kernel: 
                             stack backtrace:
Oct 17 22:52:07 dom0 kernel: CPU: 2 PID: 11917 Comm: kworker/2:0 Tainted: G        W        --------- ---  5.15.0-0.rc5.0.fc32.qubes.x86_64 #1
Oct 17 22:52:07 dom0 kernel: Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
Oct 17 22:52:07 dom0 kernel: Workqueue:  0x0 (events)
Oct 17 22:52:07 dom0 kernel: Call Trace:
Oct 17 22:52:07 dom0 kernel:  dump_stack_lvl+0x57/0x72
Oct 17 22:52:07 dom0 kernel:  check_noncircular+0x10a/0x120
Oct 17 22:52:07 dom0 kernel:  check_prev_add+0x8f/0xbf0
Oct 17 22:52:07 dom0 kernel:  ? add_chain_cache+0x10d/0x2d0
Oct 17 22:52:07 dom0 kernel:  ? load_balance+0x2b0/0x7f0
Oct 17 22:52:07 dom0 kernel:  validate_chain+0x38a/0x420
Oct 17 22:52:07 dom0 kernel:  __lock_acquire+0x3a0/0x6b0
Oct 17 22:52:07 dom0 kernel:  lock_acquire+0xf5/0x300
Oct 17 22:52:07 dom0 kernel:  ? down_trylock+0xf/0x30
Oct 17 22:52:07 dom0 kernel:  ? vprintk_emit+0xa8/0x160
Oct 17 22:52:07 dom0 kernel:  _raw_spin_lock_irqsave+0x48/0x60
Oct 17 22:52:07 dom0 kernel:  ? down_trylock+0xf/0x30
Oct 17 22:52:07 dom0 kernel:  down_trylock+0xf/0x30
Oct 17 22:52:07 dom0 kernel:  ? vprintk_emit+0xa8/0x160
Oct 17 22:52:07 dom0 kernel:  __down_trylock_console_sem+0x32/0xa0
Oct 17 22:52:07 dom0 kernel:  console_trylock_spinning+0x13/0x1e0
Oct 17 22:52:07 dom0 kernel:  vprintk_emit+0xa8/0x160
Oct 17 22:52:07 dom0 kernel:  _printk+0x68/0x7f
Oct 17 22:52:07 dom0 kernel:  ? lock_is_held_type+0xa5/0x120
Oct 17 22:52:07 dom0 kernel:  __warn_printk+0x51/0x93
Oct 17 22:52:07 dom0 kernel:  ? lock_is_held_type+0xa5/0x120
Oct 17 22:52:07 dom0 kernel:  __update_blocked_fair+0x4f4/0x510
Oct 17 22:52:07 dom0 kernel:  update_blocked_averages+0xe3/0x280
Oct 17 22:52:07 dom0 kernel:  newidle_balance+0x160/0x600
Oct 17 22:52:07 dom0 kernel:  pick_next_task_fair+0x39/0x3f0
Oct 17 22:52:07 dom0 kernel:  pick_next_task+0x4c/0xbb0
Oct 17 22:52:07 dom0 kernel:  ? dequeue_task_fair+0xd1/0x4a0
Oct 17 22:52:07 dom0 kernel:  __schedule+0x135/0x600
Oct 17 22:52:07 dom0 kernel:  schedule+0x59/0xc0
Oct 17 22:52:07 dom0 kernel:  worker_thread+0xb3/0x310
Oct 17 22:52:07 dom0 kernel:  ? process_one_work+0x590/0x590
Oct 17 22:52:07 dom0 kernel:  kthread+0x120/0x140
Oct 17 22:52:07 dom0 kernel:  ? set_kthread_struct+0x40/0x40
Oct 17 22:52:07 dom0 kernel:  ret_from_fork+0x22/0x30
Oct 17 22:52:07 dom0 kernel: cfs_rq->avg.load_avg || cfs_rq->avg.util_avg || cfs_rq->avg.runnable_avg
Oct 17 22:52:07 dom0 kernel: WARNING: CPU: 2 PID: 11917 at kernel/sched/fair.c:3339 __update_blocked_fair+0x4f4/0x510
Oct 17 22:52:07 dom0 kernel: Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer nf_tables nfnetlink vfat fat intel_rapl_msr think_lmi firmware_attributes_class wmi_bmof intel_rapl_common uvcvideo pcspkr videobuf2_vmalloc videobuf2_memops joydev videobuf2_v4l2 videobuf2_common sp5100_tco k10temp i2c_piix4 videodev mc iwlwifi cfg80211 ipmi_devintf ipmi_msghandler thinkpad_acpi platform_profile ledtrig_audio rfkill snd r8169 soundcore video ucsi_acpi i2c_scmi typec_ucsi wmi typec fuse xenfs ip_tables dm_thin_pool dm_persistent_data dm_bio_prison dm_crypt trusted asn1_encoder hid_multitouch amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel gpu_sched i2c_algo_bit serio_raw nvme ehci_pci drm_ttm_helper sdhci_pci ttm cqhci ehci_hcd drm_kms_helper sdhci nvme_core xhci_pci cec xhci_pci_renesas ccp mmc_core drm xhci_hcd xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput
Oct 17 22:52:07 dom0 kernel: CPU: 2 PID: 11917 Comm: kworker/2:0 Tainted: G        W        --------- ---  5.15.0-0.rc5.0.fc32.qubes.x86_64 #1
Oct 17 22:52:07 dom0 kernel: Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
Oct 17 22:52:07 dom0 kernel: Workqueue:  0x0 (events)
Oct 17 22:52:07 dom0 kernel: RIP: e030:__update_blocked_fair+0x4f4/0x510
Oct 17 22:52:07 dom0 kernel: Code: 01 00 00 48 89 90 08 0a 00 00 e9 e6 fc ff ff 45 31 ff e9 70 ff ff ff 48 c7 c7 c8 dc 5f 82 c6 05 a7 5f ab 01 01 e8 73 1c c4 00 <0f> 0b 41 8b 86 78 01 00 00 e9 a5 fc ff ff 66 66 2e 0f 1f 84 00 00
Oct 17 22:52:07 dom0 kernel: RSP: e02b:ffffc90040627cc0 EFLAGS: 00010082
Oct 17 22:52:07 dom0 kernel: RAX: 0000000000000000 RBX: ffff8881406abdb8 RCX: ffff888140698dd8
Oct 17 22:52:07 dom0 kernel: RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff888140698dd0
Oct 17 22:52:07 dom0 kernel: RBP: ffff8881406ab780 R08: 0000000000000001 R09: 0000000000000000
Oct 17 22:52:07 dom0 kernel: R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000010
Oct 17 22:52:07 dom0 kernel: R13: ffff8881406abf38 R14: ffff8881406ab600 R15: 0000011e9f271699
Oct 17 22:52:07 dom0 kernel: FS:  0000000000000000(0000) GS:ffff888140680000(0000) knlGS:0000000000000000
Oct 17 22:52:07 dom0 kernel: CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
Oct 17 22:52:07 dom0 kernel: CR2: 00006300c5f02360 CR3: 0000000002826000 CR4: 0000000000050660
Oct 17 22:52:07 dom0 kernel: Call Trace:
Oct 17 22:52:07 dom0 kernel:  update_blocked_averages+0xe3/0x280
Oct 17 22:52:07 dom0 kernel:  newidle_balance+0x160/0x600
Oct 17 22:52:07 dom0 kernel:  pick_next_task_fair+0x39/0x3f0
Oct 17 22:52:07 dom0 kernel:  pick_next_task+0x4c/0xbb0
Oct 17 22:52:07 dom0 kernel:  ? dequeue_task_fair+0xd1/0x4a0
Oct 17 22:52:07 dom0 kernel:  __schedule+0x135/0x600
Oct 17 22:52:07 dom0 kernel:  schedule+0x59/0xc0
Oct 17 22:52:07 dom0 kernel:  worker_thread+0xb3/0x310
Oct 17 22:52:07 dom0 kernel:  ? process_one_work+0x590/0x590
Oct 17 22:52:07 dom0 kernel:  kthread+0x120/0x140
Oct 17 22:52:07 dom0 kernel:  ? set_kthread_struct+0x40/0x40
Oct 17 22:52:07 dom0 kernel:  ret_from_fork+0x22/0x30
Oct 17 22:52:07 dom0 kernel: irq event stamp: 526
Oct 17 22:52:07 dom0 kernel: hardirqs last  enabled at (525): [<ffffffff81dfd104>] _raw_spin_unlock_irq+0x24/0x40
Oct 17 22:52:07 dom0 kernel: hardirqs last disabled at (526): [<ffffffff81df513a>] __schedule+0x3aa/0x600
Oct 17 22:52:07 dom0 kernel: softirqs last  enabled at (420): [<ffffffff811e69f1>] css_free_rwork_fn+0x71/0x350
Oct 17 22:52:07 dom0 kernel: softirqs last disabled at (418): [<ffffffff811e69d6>] css_free_rwork_fn+0x56/0x350
Oct 17 22:52:07 dom0 kernel: ---[ end trace 276648458889a290 ]---
Oct 17 22:52:07 dom0 kernel: cpu 3 spinlock event irq 79
Oct 17 22:52:07 dom0 kernel: [Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW (0x0)
Oct 17 22:52:07 dom0 kernel: ACPI: \_SB_.PLTF.C003: Found 3 idle states
Oct 17 22:52:07 dom0 kernel: ACPI: FW issue: working around C-state latencies out of order
Oct 17 22:52:07 dom0 kernel: CPU3 is up
Oct 17 22:52:07 dom0 kernel: installing Xen timer for CPU 4
Oct 17 22:52:07 dom0 kernel: cpu 4 spinlock event irq 85
Oct 17 22:52:07 dom0 kernel: [Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW (0x0)
Oct 17 22:52:07 dom0 kernel: ACPI: \_SB_.PLTF.C004: Found 3 idle states
Oct 17 22:52:07 dom0 kernel: ACPI: FW issue: working around C-state latencies out of order
 
Found in full:
https://gitlab.freedesktop.org/drm/amd/uploads/478771dfe18ff303f072fcac9a3da16b/setup-tmr-failed.dmesg


When booting without Xen things just work in v5.15. Here's a fresh lspci and dmesg
from a working boot without Xen:

https://gitlab.freedesktop.org/drm/amd/uploads/81059ddc533de1c7cf21fa98b76f217d/without-xen.lspci
https://gitlab.freedesktop.org/drm/amd/uploads/f3df205cbd9e9e8b769c35f374f20f9d/without-xen.dmesg

Previous mailing list discussion:
https://lore.kernel.org/linux-pci/CAKf6xpvGyCKVHsvauP54=0j10fxis4XiiqBNWH+1cpkbtt_QJw@mail.gmail.com/


diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0099a00af361..355b791e382f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -148,6 +148,9 @@ static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 s
 	raw_spinlock_t *lock = &desc->dev->msi_lock;
 	unsigned long flags;
 
+	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+		return;
+
 	raw_spin_lock_irqsave(lock, flags);
 	desc->msi_mask &= ~clear;
 	desc->msi_mask |= set;
@@ -181,6 +184,9 @@ static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 {
 	void __iomem *desc_addr = pci_msix_desc_addr(desc);
 
+	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+		return;
+
 	writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }

--
2.31.1

