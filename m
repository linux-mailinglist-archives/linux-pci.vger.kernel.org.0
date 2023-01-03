Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380C265C6EA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 20:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjACTGr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 14:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbjACTGi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 14:06:38 -0500
Received: from cmx-mtlrgo001.bell.net (mta-mtl-005.bell.net [209.71.208.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF860101;
        Tue,  3 Jan 2023 11:06:35 -0800 (PST)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [70.54.81.87]
X-RG-Env-Sender: matt.fagnani@bell.net
X-RG-Rigid: 63B45E0E0003535D
X-CM-Envelope: MS4xfIJVZzXSdaxMIsmDN2Tql/2qBOZREgNUejClEsUWClD3O7hxHeyERulWREVgYVkojOWJocaZ9enraM1We+8JChSd/TiWyJp85JTIm2hapBKJoGSIisM/
 pscsjYnZwnSPxLAIUMZstXKY+HujsgAr/cIVAialPTNs6rVuOOizl3q99dIUy0Br98iLvCxuXGyHUYYbRxRuogQ3rB133CxxSg7VvxjOTP/pquGm5X2HGK3x
 DXReXr8trXXSNYDbf1uY0Y7pr0vdLcsY/P0yBjTBKnQkjgLQKWyVdTYx3KY9QHuqN1RCnD2szXgwsmCv540LhLnzN/8Fb5crCd7f8ragcnGtL4l6WM8lCUfv
 w4m2w4gKOKDxrD7ebWIPeWKrPo2aQWp4G9avJOhHo6xRtfL/aHYQgSkxccsXq0z2zkBLDfPqCDWtzD0WTCElyng8UmRPtcKH1cvPz8dF8AJsu4o/WHc=
X-CM-Analysis: v=2.4 cv=drYdSXs4 c=1 sm=1 tr=0 ts=63b47cb2
 a=rEiOyTqB/wGhZSr8HftDiA==:117 a=rEiOyTqB/wGhZSr8HftDiA==:17
 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10 a=vTr9H3xdAAAA:8 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=eLVW6mAk8KqIyuiUYYUA:9 a=QEXdDO2ut3YA:10
 a=7PCjnrUJ-F5voXmZD6jJ:22 a=AjGcO6oz07-iQ99wixmX:22
Received: from [192.168.2.10] (70.54.81.87) by cmx-mtlrgo001.bell.net (5.8.807) (authenticated as matt.fagnani@bell.net)
        id 63B45E0E0003535D; Tue, 3 Jan 2023 14:06:26 -0500
Message-ID: <52583644-d875-a454-7288-8b00ea0566ae@bell.net>
Date:   Tue, 3 Jan 2023 14:06:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Firefox/110.0 Thunderbird/110.0a1
Subject: =?UTF-8?Q?Re=3A_=5Bregression=2C_bisected=2C_pci/iommu=5D_Bug=C2=A0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2E2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
From:   Matt Fagnani <matt.fagnani@bell.net>
In-Reply-To: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I reproduced the problem with 6.2-rc1 in a Fedora 37 installation with 
early kdump enabled as described at 
https://fedoraproject.org/wiki/How_to_use_kdump_to_debug_kernel_crashes 
https://github.com/k-hagio/fedora-kexec-tools/blob/master/early-kdump-howto.txt 
I panicked the kernel with sysrq+alt+c. The dmesg saved with kdump 
showed warnings at drivers/pci/ats.c:251 pci_disable_pri+0x75/0x80 and 
at drivers/pci/ats.c:419 pci_disable_pasid+0x45/0x50 involving AMD IOMMU 
and amdgpu functions in the trace. Since those warnings' were
if (WARN_ON(!pdev->pri_enabled)) and if (WARN_ON(!pdev->pasid_enabled)), 
pci_disable_pri and pci_disable_pasid looked like they were called when 
pdev->pri_enabled and pdev->pasid_enabled were both false. A null 
pointer dereference occurred right after that which made amdgpu crash.

[   13.132368] [drm] amdgpu kernel modesetting enabled.
[   13.133766] amdgpu: Topology: Add APU node [0x0:0x0]
[   13.137596] Console: switching to colour dummy device 80x25
[   13.143717] amdgpu 0000:00:01.0: vgaarb: deactivate vga console
[   13.143970] [drm] initializing kernel modesetting (CARRIZO 
0x1002:0x9874 0x103C:0x8332 0xCA).
[   13.144205] [drm] register mmio base: 0xF0400000
[   13.144209] [drm] register mmio size: 262144
[   13.144310] [drm] add ip block number 0 <vi_common>
[   13.144316] [drm] add ip block number 1 <gmc_v8_0>
[   13.144320] [drm] add ip block number 2 <cz_ih>
[   13.144324] [drm] add ip block number 3 <gfx_v8_0>
[   13.144328] [drm] add ip block number 4 <sdma_v3_0>
[   13.144332] [drm] add ip block number 5 <powerplay>
[   13.144336] [drm] add ip block number 6 <dm>
[   13.144340] [drm] add ip block number 7 <uvd_v6_0>
[   13.144343] [drm] add ip block number 8 <vce_v3_0>
[   13.144347] [drm] add ip block number 9 <acp_ip>
[   13.144388] amdgpu 0000:00:01.0: amdgpu: Fetched VBIOS from VFCT
[   13.144397] amdgpu: ATOM BIOS: 113-C75100-031
[   13.144425] [drm] UVD is enabled in physical mode
[   13.144431] [drm] VCE enabled in physical mode
[   13.144435] amdgpu 0000:00:01.0: amdgpu: Trusted Memory Zone (TMZ) 
feature not supported
[   13.144491] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, 
fragment size is 9-bit
[   13.144503] amdgpu 0000:00:01.0: amdgpu: VRAM: 512M 
0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
[   13.144511] amdgpu 0000:00:01.0: amdgpu: GART: 1024M 
0x000000FF00000000 - 0x000000FF3FFFFFFF
[   13.144524] [drm] Detected VRAM RAM=512M, BAR=512M
[   13.144529] [drm] RAM width 64bits UNKNOWN
[   13.144623] [drm] amdgpu: 512M of VRAM memory ready
[   13.144630] [drm] amdgpu: 3572M of GTT memory ready.
[   13.144653] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   13.144705] [drm] PCIE GART of 1024M enabled (table at 
0x000000F400600000).
[   13.158820] amdgpu: hwmgr_sw_init smu backed is smu8_smu
[   13.175036] [drm] Found UVD firmware Version: 1.91 Family ID: 11
[   13.175097] [drm] UVD ENC is disabled
[   13.186675] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
[   13.187879] amdgpu: smu version 27.18.00
[   13.193760] [drm] DM_PPLIB: values for Engine clock
[   13.193773] [drm] DM_PPLIB:     300000
[   13.193776] [drm] DM_PPLIB:     480000
[   13.193779] [drm] DM_PPLIB:     533340
[   13.193781] [drm] DM_PPLIB:     576000
[   13.193784] [drm] DM_PPLIB:     626090
[   13.193786] [drm] DM_PPLIB:     685720
[   13.193788] [drm] DM_PPLIB:     720000
[   13.193791] [drm] DM_PPLIB:     757900
[   13.193793] [drm] DM_PPLIB: Validation clocks:
[   13.193796] [drm] DM_PPLIB:    engine_max_clock: 75790
[   13.193799] [drm] DM_PPLIB:    memory_max_clock: 93300
[   13.193802] [drm] DM_PPLIB:    level           : 8
[   13.193806] [drm] DM_PPLIB: values for Display clock
[   13.193809] [drm] DM_PPLIB:     300000
[   13.193811] [drm] DM_PPLIB:     400000
[   13.193814] [drm] DM_PPLIB:     496560
[   13.193816] [drm] DM_PPLIB:     626090
[   13.193819] [drm] DM_PPLIB:     685720
[   13.193821] [drm] DM_PPLIB:     757900
[   13.193823] [drm] DM_PPLIB:     800000
[   13.193825] [drm] DM_PPLIB:     847060
[   13.193828] [drm] DM_PPLIB: Validation clocks:
[   13.193830] [drm] DM_PPLIB:    engine_max_clock: 75790
[   13.193833] [drm] DM_PPLIB:    memory_max_clock: 93300
[   13.193836] [drm] DM_PPLIB:    level           : 8
[   13.193839] [drm] DM_PPLIB: values for Memory clock
[   13.193842] [drm] DM_PPLIB:     667000
[   13.193844] [drm] DM_PPLIB:     933000
[   13.193847] [drm] DM_PPLIB: Validation clocks:
[   13.193849] [drm] DM_PPLIB:    engine_max_clock: 75790
[   13.193852] [drm] DM_PPLIB:    memory_max_clock: 93300
[   13.193854] [drm] DM_PPLIB:    level           : 8
[   13.193973] [drm] Display Core initialized with v3.2.215!
[   13.309967] [drm] UVD initialized successfully.
[   13.511031] [drm] VCE initialized successfully.
[   13.515217] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[   13.515442] amdgpu: sdma_bitmap: f
[   13.515549] ------------[ cut here ]------------
[   13.515555] WARNING: CPU: 0 PID: 477 at drivers/pci/ats.c:251 
pci_disable_pri+0x75/0x80
[   13.515571] Modules linked in: amdgpu(+) drm_ttm_helper ttm iommu_v2 
hid_logitech_hidpp crct10dif_pclmul drm_buddy crc32_pclmul gpu_sched 
crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel 
sha512_ssse3 drm_display_helper wdat_wdt serio_raw hid_multitouch 
sp5100_tco hid_logitech_dj r8169 cec video wmi scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua fuse dm_multipath
[   13.515620] CPU: 0 PID: 477 Comm: systemd-udevd Kdump: loaded Not 
tainted 6.2.0-0.rc1.14.fc38.x86_64 #1
[   13.515628] Hardware name: HP HP Laptop 15-bw0xx/8332, BIOS F.52 
12/03/2019
[   13.515634] RIP: 0010:pci_disable_pri+0x75/0x80
[   13.515642] Code: 54 24 06 89 ee 48 89 df 83 e2 fe 66 89 54 24 06 0f 
b7 d2 e8 1d e1 fc ff 80 a3 4b 08 00 00 fd 48 83 c4 08 5b 5d e9 2b 8b 69 
00 <0f> 0b eb b6 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90
[   13.515651] RSP: 0018:ffffbaf4407ab8e8 EFLAGS: 00010046
[   13.515658] RAX: 0000000000000000 RBX: ffff90aa00ac4000 RCX: 
0000000000000009
[   13.515663] RDX: 0000000000000000 RSI: 0000000000000014 RDI: 
ffff90aa00ac4000
[   13.515668] RBP: ffff90aa0e0c3810 R08: 0000000000000002 R09: 
0000000000000000
[   13.515673] R10: 0000000000000000 R11: ffffffffade4e430 R12: 
ffff90aa011a8800
[   13.515678] R13: ffff90aa0e0c3800 R14: ffff90aa011a8800 R15: 
ffff90aa0e0c3960
[   13.515683] FS:  00007fabd67feb40(0000) GS:ffff90aaf7400000(0000) 
knlGS:0000000000000000
[   13.515689] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.515695] CR2: 00007f5689ff54c0 CR3: 0000000100f16000 CR4: 
00000000001506f0
[   13.515700] Call Trace:
[   13.515704]  <TASK>
[   13.515710]  amd_iommu_attach_device+0x2e0/0x300
[   13.515719]  __iommu_attach_device+0x1b/0x90
[   13.515727]  iommu_attach_group+0x65/0xa0
[   13.515735]  amd_iommu_init_device+0x16b/0x250 [iommu_v2]
[   13.515747]  kfd_iommu_resume+0x4c/0x1a0 [amdgpu]
[   13.517094]  kgd2kfd_resume_iommu+0x12/0x30 [amdgpu]
[   13.518419]  kgd2kfd_device_init.cold+0x346/0x49a [amdgpu]
[   13.519699]  amdgpu_amdkfd_device_init+0x142/0x1d0 [amdgpu]
[   13.520877]  amdgpu_device_init.cold+0x19f5/0x1e21 [amdgpu]
[   13.522118]  ? _raw_spin_lock_irqsave+0x23/0x50
[   13.522126]  amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
[   13.523386]  amdgpu_pci_probe+0x161/0x370 [amdgpu]
[   13.524516]  local_pci_probe+0x41/0x80
[   13.524525]  pci_device_probe+0xb3/0x220
[   13.524533]  really_probe+0xde/0x380
[   13.524540]  ? pm_runtime_barrier+0x50/0x90
[   13.524546]  __driver_probe_device+0x78/0x170
[   13.524555]  driver_probe_device+0x1f/0x90
[   13.524560]  __driver_attach+0xce/0x1c0
[   13.524565]  ? __pfx___driver_attach+0x10/0x10
[   13.524570]  bus_for_each_dev+0x73/0xa0
[   13.524575]  bus_add_driver+0x1ae/0x200
[   13.524580]  driver_register+0x89/0xe0
[   13.524586]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   13.525819]  do_one_initcall+0x59/0x230
[   13.525828]  do_init_module+0x4a/0x200
[   13.525834]  __do_sys_init_module+0x157/0x180
[   13.525839]  do_syscall_64+0x5b/0x80
[   13.525845]  ? handle_mm_fault+0xff/0x2f0
[   13.525850]  ? do_user_addr_fault+0x1ef/0x690
[   13.525856]  ? exc_page_fault+0x70/0x170
[   13.525860]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   13.525867] RIP: 0033:0x7fabd66cde4e
[   13.525872] Code: 48 8b 0d e5 5f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 
66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b2 5f 0c 00 f7 d8 64 89 01 48
[   13.525878] RSP: 002b:00007ffdd89bc6a8 EFLAGS: 00000246 ORIG_RAX: 
00000000000000af
[   13.525884] RAX: ffffffffffffffda RBX: 0000563e4d23f0a0 RCX: 
00007fabd66cde4e
[   13.525887] RDX: 00007fabd6817453 RSI: 000000000174fb66 RDI: 
00007fabd3bd4010
[   13.525890] RBP: 00007fabd6817453 R08: 0000563e4d237c70 R09: 
00007fabd672f900
[   13.525893] R10: 0000000000000005 R11: 0000000000000246 R12: 
0000000000020000
[   13.525896] R13: 0000563e4d239060 R14: 0000000000000000 R15: 
0000563e4d23e450
[   13.525900]  </TASK>
[   13.525902] ---[ end trace 0000000000000000 ]---
[   13.525964] ------------[ cut here ]------------
[   13.525966] WARNING: CPU: 0 PID: 477 at drivers/pci/ats.c:419 
pci_disable_pasid+0x45/0x50
[   13.525974] Modules linked in: amdgpu(+) drm_ttm_helper ttm iommu_v2 
hid_logitech_hidpp crct10dif_pclmul drm_buddy crc32_pclmul gpu_sched 
crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel 
sha512_ssse3 drm_display_helper wdat_wdt serio_raw hid_multitouch 
sp5100_tco hid_logitech_dj r8169 cec video wmi scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua fuse dm_multipath
[   13.526006] CPU: 0 PID: 477 Comm: systemd-udevd Kdump: loaded 
Tainted: G        W         -------  ---  6.2.0-0.rc1.14.fc38.x86_64 #1
[   13.526012] Hardware name: HP HP Laptop 15-bw0xx/8332, BIOS F.52 
12/03/2019
[   13.526015] RIP: 0010:pci_disable_pasid+0x45/0x50
[   13.526020] Code: 53 48 89 fb 85 f6 75 06 5b e9 67 8c 69 00 83 c6 06 
31 d2 e8 3d e2 fc ff 80 a3 4b 08 00 00 fe 5b e9 50 8c 69 00 e9 4b 8c 69 
00 <0f> 0b e9 44 8c 69 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
[   13.526025] RSP: 0018:ffffbaf4407ab900 EFLAGS: 00010046
[   13.526028] RAX: 0000000000000000 RBX: ffff90aa00ac4000 RCX: 
0000000000000009
[   13.526031] RDX: 0000000000000000 RSI: 0000000000000014 RDI: 
ffff90aa00ac4000
[   13.526034] RBP: ffff90aa0e0c3810 R08: 0000000000000002 R09: 
0000000000000000
[   13.526037] R10: 0000000000000000 R11: ffffffffade4e430 R12: 
ffff90aa011a8800
[   13.526040] R13: ffff90aa0e0c3800 R14: ffff90aa011a8800 R15: 
ffff90aa0e0c3960
[   13.526043] FS:  00007fabd67feb40(0000) GS:ffff90aaf7400000(0000) 
knlGS:0000000000000000
[   13.526047] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.526050] CR2: 00007f5689ff54c0 CR3: 0000000100f16000 CR4: 
00000000001506f0
[   13.526053] Call Trace:
[   13.526056]  <TASK>
[   13.526058]  amd_iommu_attach_device+0x2e8/0x300
[   13.526064]  __iommu_attach_device+0x1b/0x90
[   13.526070]  iommu_attach_group+0x65/0xa0
[   13.526075]  amd_iommu_init_device+0x16b/0x250 [iommu_v2]
[   13.526083]  kfd_iommu_resume+0x4c/0x1a0 [amdgpu]
[   13.527397]  kgd2kfd_resume_iommu+0x12/0x30 [amdgpu]
[   13.528709]  kgd2kfd_device_init.cold+0x346/0x49a [amdgpu]
[   13.529877]  amdgpu_amdkfd_device_init+0x142/0x1d0 [amdgpu]
[   13.531039]  amdgpu_device_init.cold+0x19f5/0x1e21 [amdgpu]
[   13.532322]  ? _raw_spin_lock_irqsave+0x23/0x50
[   13.532333]  amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
[   13.533642]  amdgpu_pci_probe+0x161/0x370 [amdgpu]
[   13.534758]  local_pci_probe+0x41/0x80
[   13.534766]  pci_device_probe+0xb3/0x220
[   13.534771]  really_probe+0xde/0x380
[   13.534776]  ? pm_runtime_barrier+0x50/0x90
[   13.534781]  __driver_probe_device+0x78/0x170
[   13.534785]  driver_probe_device+0x1f/0x90
[   13.534789]  __driver_attach+0xce/0x1c0
[   13.534793]  ? __pfx___driver_attach+0x10/0x10
[   13.534797]  bus_for_each_dev+0x73/0xa0
[   13.534801]  bus_add_driver+0x1ae/0x200
[   13.534805]  driver_register+0x89/0xe0
[   13.534809]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   13.536000]  do_one_initcall+0x59/0x230
[   13.536010]  do_init_module+0x4a/0x200
[   13.536015]  __do_sys_init_module+0x157/0x180
[   13.536020]  do_syscall_64+0x5b/0x80
[   13.536025]  ? handle_mm_fault+0xff/0x2f0
[   13.536030]  ? do_user_addr_fault+0x1ef/0x690
[   13.536036]  ? exc_page_fault+0x70/0x170
[   13.536040]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   13.536047] RIP: 0033:0x7fabd66cde4e
[   13.536051] Code: 48 8b 0d e5 5f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 
66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b2 5f 0c 00 f7 d8 64 89 01 48
[   13.536057] RSP: 002b:00007ffdd89bc6a8 EFLAGS: 00000246 ORIG_RAX: 
00000000000000af
[   13.536063] RAX: ffffffffffffffda RBX: 0000563e4d23f0a0 RCX: 
00007fabd66cde4e
[   13.536066] RDX: 00007fabd6817453 RSI: 000000000174fb66 RDI: 
00007fabd3bd4010
[   13.536069] RBP: 00007fabd6817453 R08: 0000563e4d237c70 R09: 
00007fabd672f900
[   13.536072] R10: 0000000000000005 R11: 0000000000000246 R12: 
0000000000020000
[   13.536075] R13: 0000563e4d239060 R14: 0000000000000000 R15: 
0000563e4d23e450
[   13.536079]  </TASK>
[   13.536081] ---[ end trace 0000000000000000 ]---
[   13.536117] kfd kfd: amdgpu: Failed to resume IOMMU for device 1002:9874
[   13.537198] kfd kfd: amdgpu: device 1002:9874 NOT added due to errors
[   13.537218] amdgpu 0000:00:01.0: amdgpu: SE 1, SH per SE 1, CU per SH 
8, active_cu_number 6
[   13.537481] BUG: kernel NULL pointer dereference, address: 
0000000000000058
[   13.537499] #PF: supervisor read access in kernel mode
[   13.537504] #PF: error_code(0x0000) - not-present page
[   13.537509] PGD 0 P4D 0
[   13.537515] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   13.537522] CPU: 2 PID: 56 Comm: irq/24-AMD-Vi Kdump: loaded Tainted: 
G        W         -------  ---  6.2.0-0.rc1.14.fc38.x86_64 #1
[   13.537530] Hardware name: HP HP Laptop 15-bw0xx/8332, BIOS F.52 
12/03/2019
[   13.537534] RIP: 0010:report_iommu_fault+0x11/0x90
[   13.537548] Code: 0f 0b eb cd 0f 1f 44 00 00 90 90 90 90 90 90 90 90 
90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 55 41 54 41 89 cc 55 48 89 d5 
53 <48> 8b 47 48 48 89 f3 48 85 c0 74 64 4c 8b 47 50 e8 da 3f 57 00 41
[   13.537557] RSP: 0018:ffffbaf4403ebe08 EFLAGS: 00010246
[   13.537562] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[   13.537567] RDX: 000000010e9b0400 RSI: ffff90aa00ac40d0 RDI: 
0000000000000010
[   13.537572] RBP: 000000010e9b0400 R08: ffff90aa011a8800 R09: 
0000000000000050
[   13.537576] R10: ffff90aa00244000 R11: 0000000000000000 R12: 
0000000000000000
[   13.537581] R13: ffff90aa0005b000 R14: 0000000000000008 R15: 
0000000000000000
[   13.537585] FS:  0000000000000000(0000) GS:ffff90aaf7500000(0000) 
knlGS:0000000000000000
[   13.537591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.537596] CR2: 0000000000000058 CR3: 000000010e22c000 CR4: 
00000000001506e0
[   13.537601] Call Trace:
[   13.537607]  <TASK>
[   13.537612]  amd_iommu_int_thread+0x60c/0x760
[   13.537620]  ? __pfx_irq_thread_fn+0x10/0x10
[   13.537627]  irq_thread_fn+0x1f/0x60
[   13.537633]  irq_thread+0xea/0x1a0
[   13.537638]  ? preempt_count_add+0x6a/0xa0
[   13.537647]  ? __pfx_irq_thread_dtor+0x10/0x10
[   13.537652]  ? __pfx_irq_thread+0x10/0x10
[   13.537657]  kthread+0xe9/0x110
[   13.537662]  ? __pfx_kthread+0x10/0x10
[   13.537667]  ret_from_fork+0x2c/0x50
[   13.537676]  </TASK>
[   13.537678] Modules linked in: amdgpu(+) drm_ttm_helper ttm iommu_v2 
hid_logitech_hidpp crct10dif_pclmul drm_buddy crc32_pclmul gpu_sched 
crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel 
sha512_ssse3 drm_display_helper wdat_wdt serio_raw hid_multitouch 
sp5100_tco hid_logitech_dj r8169 cec video wmi scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua fuse dm_multipath
[   13.537723] CR2: 0000000000000058
[   13.537727] ---[ end trace 0000000000000000 ]---
[   13.537731] RIP: 0010:report_iommu_fault+0x11/0x90
[   13.537737] Code: 0f 0b eb cd 0f 1f 44 00 00 90 90 90 90 90 90 90 90 
90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 55 41 54 41 89 cc 55 48 89 d5 
53 <48> 8b 47 48 48 89 f3 48 85 c0 74 64 4c 8b 47 50 e8 da 3f 57 00 41
[   13.537746] RSP: 0018:ffffbaf4403ebe08 EFLAGS: 00010246
[   13.537751] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[   13.537755] RDX: 000000010e9b0400 RSI: ffff90aa00ac40d0 RDI: 
0000000000000010
[   13.537759] RBP: 000000010e9b0400 R08: ffff90aa011a8800 R09: 
0000000000000050
[   13.537764] R10: ffff90aa00244000 R11: 0000000000000000 R12: 
0000000000000000
[   13.537768] R13: ffff90aa0005b000 R14: 0000000000000008 R15: 
0000000000000000
[   13.537773] FS:  0000000000000000(0000) GS:ffff90aaf7500000(0000) 
knlGS:0000000000000000
[   13.537779] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.537783] CR2: 0000000000000058 CR3: 000000010e22c000 CR4: 
00000000001506e0
[   13.537795] genirq: exiting task "irq/24-AMD-Vi" (56) is an active 
IRQ thread (irq 24)
[   13.537808] general protection fault, probably for non-canonical 
address 0x1ee201e8df8948: 0000 [#2] PREEMPT SMP NOPTI
[   13.537815] CPU: 2 PID: 56 Comm: irq/24-AMD-Vi Kdump: loaded Tainted: 
G      D W         -------  ---  6.2.0-0.rc1.14.fc38.x86_64 #1
[   13.537822] Hardware name: HP HP Laptop 15-bw0xx/8332, BIOS F.52 
12/03/2019
[   13.537825] RIP: 0010:__x86_return_thunk+0x0/0x40
[   13.537833] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 
cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 
f6 <c3> cc 0f ae e8 eb f9 cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e
[   13.537840] RSP: 0018:ffffbaf4403ebeb0 EFLAGS: 00010282
[   13.537844] RAX: 001ee201e8df8948 RBX: fff38839e8df8948 RCX: 
0000000000000000
[   13.537848] RDX: 0000000080000000 RSI: ffff90aa00400b68 RDI: 
ffffffffad106b7f
[   13.537852] RBP: ffff90aa00aa0000 R08: ffff90aa00400c50 R09: 
ffffffffaf143f00
[   13.537856] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff90aa00aa0cac
[   13.537859] R13: ffff90aa00938001 R14: 0000000000000000 R15: 
0000000000000000
[   13.537863] FS:  0000000000000000(0000) GS:ffff90aaf7500000(0000) 
knlGS:0000000000000000
[   13.537868] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.537872] CR2: 0000000000000058 CR3: 000000010e22c000 CR4: 
00000000001506e0
[   13.537876] Call Trace:
[   13.537879]  <TASK>
[   13.537882]  ? task_work_run+0x59/0x90
[   13.537888]  ? do_exit+0x31f/0xaf0
[   13.537894]  ? __pfx_irq_thread_dtor+0x10/0x10
[   13.537900]  ? make_task_dead+0x7a/0x80
[   13.537905]  ? rewind_stack_and_make_dead+0x17/0x20
[   13.537912]  </TASK>
[   13.537914] Modules linked in: amdgpu(+) drm_ttm_helper ttm iommu_v2 
hid_logitech_hidpp crct10dif_pclmul drm_buddy crc32_pclmul gpu_sched 
crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel 
sha512_ssse3 drm_display_helper wdat_wdt serio_raw hid_multitouch 
sp5100_tco hid_logitech_dj r8169 cec video wmi scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua fuse dm_multipath
[   13.537946] ---[ end trace 0000000000000000 ]---
[   13.537950] RIP: 0010:report_iommu_fault+0x11/0x90
[   13.537955] Code: 0f 0b eb cd 0f 1f 44 00 00 90 90 90 90 90 90 90 90 
90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 55 41 54 41 89 cc 55 48 89 d5 
53 <48> 8b 47 48 48 89 f3 48 85 c0 74 64 4c 8b 47 50 e8 da 3f 57 00 41
[   13.537962] RSP: 0018:ffffbaf4403ebe08 EFLAGS: 00010246
[   13.537967] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[   13.537971] RDX: 000000010e9b0400 RSI: ffff90aa00ac40d0 RDI: 
0000000000000010
[   13.537974] RBP: 000000010e9b0400 R08: ffff90aa011a8800 R09: 
0000000000000050
[   13.537978] R10: ffff90aa00244000 R11: 0000000000000000 R12: 
0000000000000000
[   13.537982] R13: ffff90aa0005b000 R14: 0000000000000008 R15: 
0000000000000000
[   13.537986] FS:  0000000000000000(0000) GS:ffff90aaf7500000(0000) 
knlGS:0000000000000000
[   13.537991] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.537995] CR2: 0000000000000058 CR3: 000000010e22c000 CR4: 
00000000001506e0
[   13.537999] Fixing recursive fault but reboot is needed!
[   13.538003] check_preemption_disabled: 6 callbacks suppressed
[   13.538005] BUG: using smp_processor_id() in preemptible [00000000] 
code: irq/24-AMD-Vi/56
[   13.538012] caller is __schedule+0x30/0x1390
[   13.538017] CPU: 2 PID: 56 Comm: irq/24-AMD-Vi Kdump: loaded Tainted: 
G      D W         -------  ---  6.2.0-0.rc1.14.fc38.x86_64 #1
[   13.538023] Hardware name: HP HP Laptop 15-bw0xx/8332, BIOS F.52 
12/03/2019
[   13.538027] Call Trace:
[   13.538030]  <TASK>
[   13.538032]  dump_stack_lvl+0x44/0x5c
[   13.538039]  check_preemption_disabled+0xe1/0xf0
[   13.538045]  __schedule+0x30/0x1390
[   13.538049]  ? __wake_up_klogd.part.0+0x56/0x80
[   13.538055]  ? vprintk_emit+0x11d/0x290
[   13.538061]  ? _printk+0x5a/0x60
[   13.538068]  do_task_dead+0x3f/0x50
[   13.538074]  make_task_dead.cold+0x51/0xba
[   13.538080]  rewind_stack_and_make_dead+0x17/0x20
[   13.538085] RIP: 0000:0x0
[   13.538092] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   13.538096] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 
0000000000000000
[   13.538101] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[   13.538105] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[   13.538108] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[   13.538112] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[   13.538116] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[   13.538121]  </TASK>
[   13.538124] BUG: scheduling while atomic: irq/24-AMD-Vi/56/0x00000000
[   13.538128] Modules linked in: amdgpu(+) drm_ttm_helper ttm iommu_v2 
hid_logitech_hidpp crct10dif_pclmul drm_buddy crc32_pclmul gpu_sched 
crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel 
sha512_ssse3 drm_display_helper wdat_wdt serio_raw hid_multitouch 
sp5100_tco hid_logitech_dj r8169 cec video wmi scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua fuse dm_multipath
[   13.538159] Preemption disabled at:
[   13.538160] [<0000000000000000>] 0x0
[   13.538166] CPU: 2 PID: 56 Comm: irq/24-AMD-Vi Kdump: loaded Tainted: 
G      D W         -------  ---  6.2.0-0.rc1.14.fc38.x86_64 #1
[   13.538172] Hardware name: HP HP Laptop 15-bw0xx/8332, BIOS F.52 
12/03/2019
[   13.538175] Call Trace:
[   13.538178]  <TASK>
[   13.538180]  dump_stack_lvl+0x44/0x5c
[   13.538185]  __schedule_bug.cold+0x80/0x8d
[   13.538191]  __schedule+0xf5c/0x1390
[   13.538195]  ? __wake_up_klogd.part.0+0x56/0x80
[   13.538200]  ? vprintk_emit+0x11d/0x290
[   13.538206]  ? _printk+0x5a/0x60
[   13.538211]  do_task_dead+0x3f/0x50
[   13.538216]  make_task_dead.cold+0x51/0xba
[   13.538221]  rewind_stack_and_make_dead+0x17/0x20
[   13.538226] RIP: 0000:0x0
[   13.538231] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   13.538234] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 
0000000000000000
[   13.538240] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[   13.538243] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[   13.538247] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[   13.538251] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[   13.538254] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[   13.538260]  </TASK>

I tried to use the crash program on the core dump but it stopped with an 
error
crash: page excluded: kernel virtual address: ffff90aa0044db60 type: 
"xa_node shift" I attached the full dmesg file vmcore-dmesg.txt at 
https://bugzilla.kernel.org/show_bug.cgi?id=216865#c2
