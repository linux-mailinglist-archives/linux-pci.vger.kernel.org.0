Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C273D43CD80
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 17:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242748AbhJ0Pb7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 11:31:59 -0400
Received: from office.oderland.com ([91.201.60.5]:33198 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242747AbhJ0Pby (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 11:31:54 -0400
Received: from [193.180.18.161] (port=35520 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1mfkrl-000gBN-MF; Wed, 27 Oct 2021 17:29:25 +0200
Message-ID: <5b3d4653-0cdf-e098-0a4a-3c5c3ae3977b@oderland.se>
Date:   Wed, 27 Oct 2021 17:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Content-Language: en-US
From:   Josef Johansson <josef@oderland.se>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     boris.ostrovsky@oracle.com, helgaas@kernel.org, jgross@suse.com,
        linux-pci@vger.kernel.org, maz@kernel.org,
        xen-devel@lists.xenproject.org, Jason Andryuk <jandryuk@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <20211025012503.33172-1-jandryuk@gmail.com> <87fssmg8k4.ffs@tglx>
 <87cznqg5k8.ffs@tglx> <d1cc20aa-5c5c-6c7b-2e5d-bc31362ad891@oderland.se>
 <89d6c2f4-4d00-972f-e434-cb1839e78598@oderland.se>
Subject: Re: [PATCH] PCI/MSI: Move non-mask check back into low level
 accessors
In-Reply-To: <89d6c2f4-4d00-972f-e434-cb1839e78598@oderland.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/27/21 14:01, Josef Johansson wrote:
> On 10/27/21 11:54, Josef Johansson wrote:
>> On 10/27/21 11:50, Thomas Gleixner wrote:
>>> The recent rework of PCI/MSI[X] masking moved the non-mask checks from the
>>> low level accessors into the higher level mask/unmask functions.
>>>
>>> This missed the fact that these accessors can be invoked from other places
>>> as well. The missing checks break XEN-PV which sets pci_msi_ignore_mask and
>>> also violates the virtual MSIX and the msi_attrib.maskbit protections.
>>>
>>> Instead of sprinkling checks all over the place, lift them back into the
>>> low level accessor functions. To avoid checking three different conditions
>>> combine them into one property of msi_desc::msi_attrib.
>>>
>>> Reported-by: Josef Johansson <josef@oderland.se>
>>> Fixes: fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask functions")
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Jason Andryuk <jandryuk@gmail.com>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>>> Cc: linux-pci@vger.kernel.org
>>> Cc: xen-devel <xen-devel@lists.xenproject.org>
>>> Cc: Juergen Gross <jgross@suse.com>
>>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>> Cc: David Woodhouse <dwmw2@infradead.org>
>>> ---
>>>  drivers/pci/msi.c   |   26 ++++++++++++++------------
>>>  include/linux/msi.h |    2 +-
>>>  2 files changed, 15 insertions(+), 13 deletions(-)
>>>
>>> --- a/drivers/pci/msi.c
>>> +++ b/drivers/pci/msi.c
>>> @@ -148,6 +148,9 @@ static noinline void pci_msi_update_mask
>>>  	raw_spinlock_t *lock = &desc->dev->msi_lock;
>>>  	unsigned long flags;
>>>  
>>> +	if (!desc->msi_attrib.can_mask)
>>> +		return;
>>> +
>>>  	raw_spin_lock_irqsave(lock, flags);
>>>  	desc->msi_mask &= ~clear;
>>>  	desc->msi_mask |= set;
>>> @@ -181,7 +184,8 @@ static void pci_msix_write_vector_ctrl(s
>>>  {
>>>  	void __iomem *desc_addr = pci_msix_desc_addr(desc);
>>>  
>>> -	writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>>> +	if (desc->msi_attrib.can_mask)
>>> +		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>>>  }
>>>  
>>>  static inline void pci_msix_mask(struct msi_desc *desc)
>>> @@ -200,23 +204,17 @@ static inline void pci_msix_unmask(struc
>>>  
>>>  static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
>>>  {
>>> -	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
>>> -		return;
>>> -
>>>  	if (desc->msi_attrib.is_msix)
>>>  		pci_msix_mask(desc);
>>> -	else if (desc->msi_attrib.maskbit)
>>> +	else
>>>  		pci_msi_mask(desc, mask);
>>>  }
>>>  
>>>  static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
>>>  {
>>> -	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
>>> -		return;
>>> -
>>>  	if (desc->msi_attrib.is_msix)
>>>  		pci_msix_unmask(desc);
>>> -	else if (desc->msi_attrib.maskbit)
>>> +	else
>>>  		pci_msi_unmask(desc, mask);
>>>  }
>>>  
>>> @@ -484,7 +482,8 @@ msi_setup_entry(struct pci_dev *dev, int
>>>  	entry->msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
>>>  	entry->msi_attrib.is_virtual    = 0;
>>>  	entry->msi_attrib.entry_nr	= 0;
>>> -	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
>>> +	entry->msi_attrib.can_mask	= !pci_msi_ignore_mask &&
>>> +					  !!(control & PCI_MSI_FLAGS_MASKBIT);
>>>  	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
>>>  	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
>>>  	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
>>> @@ -495,7 +494,7 @@ msi_setup_entry(struct pci_dev *dev, int
>>>  		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
>>>  
>>>  	/* Save the initial mask status */
>>> -	if (entry->msi_attrib.maskbit)
>>> +	if (entry->msi_attrib.can_mask)
>>>  		pci_read_config_dword(dev, entry->mask_pos, &entry->msi_mask);
>>>  
>>>  out:
>>> @@ -638,10 +637,13 @@ static int msix_setup_entries(struct pci
>>>  		entry->msi_attrib.is_virtual =
>>>  			entry->msi_attrib.entry_nr >= vec_count;
>>>  
>>> +		entry->msi_attrib.can_mask	= !pci_msi_ignore_mask &&
>>> +						  !entry->msi_attrib.is_virtual;
>>> +
>>>  		entry->msi_attrib.default_irq	= dev->irq;
>>>  		entry->mask_base		= base;
>>>  
>>> -		if (!entry->msi_attrib.is_virtual) {
>>> +		if (!entry->msi_attrib.can_mask) {
>>>  			addr = pci_msix_desc_addr(entry);
>>>  			entry->msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>>>  		}
>>> --- a/include/linux/msi.h
>>> +++ b/include/linux/msi.h
>>> @@ -148,7 +148,7 @@ struct msi_desc {
>>>  				u8	is_msix		: 1;
>>>  				u8	multiple	: 3;
>>>  				u8	multi_cap	: 3;
>>> -				u8	maskbit		: 1;
>>> +				u8	can_mask	: 1;
>>>  				u8	is_64		: 1;
>>>  				u8	is_virtual	: 1;
>>>  				u16	entry_nr;
>> Thanks,
>> I'll test this out ASAP.
> I'm adding
>
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 6a5ecee6e567..28d509452958 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -529,10 +529,10 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
>  
>  	/*
>  	 * Checking the first MSI descriptor is sufficient. MSIX supports
> -	 * masking and MSI does so when the maskbit is set.
> +	 * masking and MSI does so when the can_mask is set.
>  	 */
>  	desc = first_msi_entry(dev);
> -	return desc->msi_attrib.is_msix || desc->msi_attrib.maskbit;
> +	return desc->msi_attrib.is_msix || desc->msi_attrib.can_mask;
>  }
>  
>  int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>
Hi Thomas,

With the above added the kernel boots fine and I can even suspend it twice.
Which is with my laptop, a good sign.

You can add Tested-By: josef@oderland.se.

Thanks again!

When I suspend I get errors from Xen, including stacktraces below
if anyone has any clue, if this might be related. I get one each time I
suspend
and the third time amdgpu gives up.

rtc_cmos 00:01: registered as rtc0
rtc_cmos 00:01: setting system clock to 2021-10-27T15:04:35 UTC (1635347075)
rtc_cmos 00:01: no alarms, y3k, 114 bytes nvram
device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
efifb: probing for efifb
efifb: cannot reserve video memory at 0x60000000
------------[ cut here ]------------
ioremap on RAM at 0x0000000060000000 - 0x00000000607e8fff
WARNING: CPU: 7 PID: 1 at arch/x86/mm/ioremap.c:210 __ioremap_caller+0x332/0x350
Modules linked in:
CPU: 7 PID: 1 Comm: swapper/0 Not tainted 5.15.0-0.rc7.0.fc32.qubes.x86_64 #1
Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
RIP: e030:__ioremap_caller+0x332/0x350
Code: e8 c3 ca ff ff 49 09 c6 e9 32 fe ff ff 48 8d 54 24 28 48 8d 74 24 18 48 c7 c7 35 f2 5d 82 c6 05 e8 7b a9 01 01 e8 48 39 be 00 <0f> 0b 45 31 e4 e9 ac fe ff ff e8 ff f5 c3 00 66 66 2e 0f 1f 84 00
RSP: e02b:ffffc9004007bb00 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 00000000007e9000 RCX: ffffffff82915ca8
RDX: c0000000ffffdfff RSI: 0000000000000000 RDI: ffffffff82865ca0
RBP: 0000000060000000 R08: 0000000000000000 R09: ffffc9004007b948
R10: ffffc9004007b940 R11: ffffffff82945ce8 R12: 0000000000000001
R13: 00000000007e9000 R14: 00000000007e9000 R15: ffffffff81c8f772
FS:  0000000000000000(0000) GS:ffff8881407c0000(0000) knlGS:0000000000000000
CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000002810000 CR4: 0000000000050660
Call Trace:
 efifb_probe.cold+0x2e6/0x688
 platform_probe+0x3f/0x90
 call_driver_probe+0x24/0xc0
 really_probe+0x1e7/0x310
 __driver_probe_device+0xfe/0x180
 driver_probe_device+0x1e/0x90
 __device_attach_driver+0x72/0xe0
 ? driver_allows_async_probing+0x50/0x50
 ? driver_allows_async_probing+0x50/0x50
 bus_for_each_drv+0x8f/0xd0
 __device_attach+0xe9/0x1f0
 bus_probe_device+0x8e/0xa0
 device_add+0x3fb/0x630
 platform_device_add+0x102/0x230
 sysfb_init+0xea/0x141
 ? firmware_map_add_early+0xb8/0xb8
 do_one_initcall+0x57/0x200
 do_initcalls+0x109/0x166
 kernel_init_freeable+0x23c/0x2bd
 ? rest_init+0xc0/0xc0
 kernel_init+0x16/0x120
 ret_from_fork+0x22/0x30
---[ end trace b068d3cd1b7f5f49 ]---
efifb: abort, cannot remap video memory 0x7e9000 @ 0x60000000
efi-framebuffer: probe of efi-framebuffer.0 failed with error -5
--
printk: Suspending console(s) (use no_console_suspend to debug)
[drm] free PSP TMR buffer
PM: suspend devices took 0.428 seconds
ACPI: EC: interrupt blocked
ACPI: PM: Preparing to enter system sleep state S3
ACPI: EC: event blocked
ACPI: EC: EC stopped
ACPI: PM: Saving platform NVS memory
Disabling non-boot CPUs ...
------------[ cut here ]------------
WARNING: CPU: 1 PID: 0 at arch/x86/mm/tlb.c:522 switch_mm_irqs_off+0x3c5/0x400
Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer nf_tables nfnetlink vfat fat intel_rapl_msr think_lmi firmware_attributes_class wmi_bmof intel_rapl_common pcspkr uvcvideo videobuf2_vmalloc videobuf2_memops joydev videobuf2_v4l2 sp5100_tco k10temp videobuf2_common i2c_piix4 iwlwifi videodev mc cfg80211 thinkpad_acpi ipmi_devintf ucsi_acpi platform_profile typec_ucsi ledtrig_audio ipmi_msghandler r8169 rfkill typec snd wmi soundcore video i2c_scmi fuse xenfs ip_tables dm_thin_pool dm_persistent_data dm_bio_prison dm_crypt trusted asn1_encoder hid_multitouch amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel gpu_sched i2c_algo_bit drm_ttm_helper ghash_clmulni_intel ttm serio_raw drm_kms_helper cec sdhci_pci cqhci sdhci xhci_pci drm xhci_pci_renesas nvme xhci_hcd ehci_pci mmc_core ehci_hcd nvme_core xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W        --------- ---  5.15.0-0.rc7.0.fc32.qubes.x86_64 #1
Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
RIP: e030:switch_mm_irqs_off+0x3c5/0x400
Code: f0 41 80 65 01 fb ba 01 00 00 00 49 8d b5 60 23 00 00 4c 89 ef 49 c7 85 68 23 00 00 60 1d 08 81 e8 a0 f3 08 00 e9 15 fd ff ff <0f> 0b e8 34 fa ff ff e9 ad fc ff ff 0f 0b e9 31 fe ff ff 0f 0b e9
RSP: e02b:ffffc900400f3eb0 EFLAGS: 00010006
RAX: 00000001336c6000 RBX: ffff888140660000 RCX: 0000000000000040
RDX: ffff8881003027c0 RSI: 0000000000000000 RDI: ffff8881b36c6000
RBP: ffffffff829d91c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000000 R12: ffff888104e88440
R13: ffff8881003027c0 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888140640000(0000) knlGS:0000000000000000
CS:  10000e030 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000060b7d78bf198 CR3: 0000000002810000 CR4: 0000000000050660
Call Trace:
 switch_mm+0x1c/0x30
 idle_task_exit+0x55/0x60
 play_dead_common+0xa/0x20
 xen_pv_play_dead+0xa/0x60
 do_idle+0xd1/0xe0
 cpu_startup_entry+0x19/0x20
 asm_cpu_bringup_and_idle+0x5/0x1000
---[ end trace b068d3cd1b7f5f4b ]---
smpboot: CPU 1 is now offline
smpboot: CPU 2 is now offline
smpboot: CPU 3 is now offline
smpboot: CPU 4 is now offline
smpboot: CPU 5 is now offline
smpboot: CPU 6 is now offline
smpboot: CPU 7 is now offline
ACPI: PM: Low-level resume complete
ACPI: EC: EC started
ACPI: PM: Restoring platform NVS memory
xen_acpi_processor: Uploading Xen processor PM info
xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI CPU1
xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI CPU3
xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI CPU5
xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI CPU7
xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI CPU9
xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI CPU11
--
CPU2 is up
installing Xen timer for CPU 3
cpu 3 spinlock event irq 79
[Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW (0x0)
ACPI: \_SB_.PLTF.C003: Found 3 idle states
ACPI: FW issue: working around C-state latencies out of order
CPU3 is up
------------[ cut here ]------------
cfs_rq->avg.load_avg || cfs_rq->avg.util_avg || cfs_rq->avg.runnable_avg
installing Xen timer for CPU 4
WARNING: CPU: 3 PID: 455 at kernel/sched/fair.c:3339 __update_blocked_fair+0x49b/0x4b0
Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer nf_tables nfnetlink vfat fat intel_rapl_msr think_lmi firmware_attributes_class wmi_bmof intel_rapl_common pcspkr uvcvideo videobuf2_vmalloc videobuf2_memops joydev videobuf2_v4l2 sp5100_tco k10temp videobuf2_common i2c_piix4 iwlwifi videodev mc cfg80211 thinkpad_acpi ipmi_devintf ucsi_acpi platform_profile typec_ucsi ledtrig_audio ipmi_msghandler r8169 rfkill typec snd wmi soundcore video i2c_scmi fuse xenfs ip_tables dm_thin_pool dm_persistent_data dm_bio_prison dm_crypt trusted asn1_encoder hid_multitouch amdgpu crct10dif_pclmul crc32_pclmul crc32c_intel gpu_sched i2c_algo_bit drm_ttm_helper ghash_clmulni_intel ttm serio_raw drm_kms_helper cec sdhci_pci cqhci sdhci xhci_pci drm xhci_pci_renesas nvme xhci_hcd ehci_pci mmc_core ehci_hcd nvme_core xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput
CPU: 3 PID: 455 Comm: kworker/3:2 Tainted: G        W        --------- ---  5.15.0-0.rc7.0.fc32.qubes.x86_64 #1
Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET65W(1.34 ) 06/17/2021
Workqueue:  0x0 (events)
RIP: e030:__update_blocked_fair+0x49b/0x4b0
Code: 6b fd ff ff 49 8b 96 48 01 00 00 48 89 90 50 09 00 00 e9 ff fc ff ff 48 c7 c7 10 7a 5e 82 c6 05 f3 35 9e 01 01 e8 1f f3 b2 00 <0f> 0b 41 8b 86 38 01 00 00 e9 c6 fc ff ff 0f 1f 80 00 00 00 00 0f
RSP: e02b:ffffc900410d7ce0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000018 RCX: ffff8881406d8a08
RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8881406d8a00
RBP: ffff8881406e9800 R08: 0000000000000048 R09: ffffc900410d7c78
R10: 0000000000000049 R11: 000000002d2d2d2d R12: ffff8881406e9f80
R13: ffff8881406e9e40 R14: ffff8881406e96c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881406c0000(0000) knlGS:0000000000000000
CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000782e51820000 CR3: 0000000002810000 CR4: 0000000000050660
Call Trace:
 update_blocked_averages+0xa8/0x180
 newidle_balance+0x175/0x380
 pick_next_task_fair+0x39/0x3e0
 pick_next_task+0x4c/0xbd0
 ? dequeue_task_fair+0xba/0x390
 __schedule+0x13a/0x570
 schedule+0x44/0xa0
 worker_thread+0xc0/0x320
 ? process_one_work+0x390/0x390
 kthread+0x10f/0x130
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
---[ end trace b068d3cd1b7f5f4c ]---
cpu 4 spinlock event irq 85
[Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW (0x0)
ACPI: \_SB_.PLTF.C004: Found 3 idle states
ACPI: FW issue: working around C-state latencies out of order
CPU4 is up
installing Xen timer for CPU 5
cpu 5 spinlock event irq 91
[Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW (0x0)
ACPI: \_SB_.PLTF.C005: Found 3 idle states
ACPI: FW issue: working around C-state latencies out of order
CPU5 is up

