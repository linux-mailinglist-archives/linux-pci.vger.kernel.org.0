Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0086744B06C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 16:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbhKIPec (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 10:34:32 -0500
Received: from foss.arm.com ([217.140.110.172]:35248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239216AbhKIPeU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Nov 2021 10:34:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29FF2ED1;
        Tue,  9 Nov 2021 07:31:34 -0800 (PST)
Received: from [10.57.81.233] (unknown [10.57.81.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75C2C3F800;
        Tue,  9 Nov 2021 07:31:32 -0800 (PST)
Message-ID: <19ba9667-a9a0-4242-b28e-ba5c206e1415@arm.com>
Date:   Tue, 9 Nov 2021 15:31:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: How to reduce PCI initialization from 5 s (1.5 s adding them to
 IOMMU groups)
Content-Language: en-GB
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20211105185304.GA936068@bhelgaas>
 <d34f83ad-63a0-8cd1-1246-d0e50c03f42e@molgen.mpg.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <d34f83ad-63a0-8cd1-1246-d0e50c03f42e@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-11-06 10:42, Paul Menzel wrote:
> Dear Bjorn,
> 
> 
> Thank you for your quick reply.
> 
> 
> Am 05.11.21 um 19:53 schrieb Bjorn Helgaas:
>> On Fri, Nov 05, 2021 at 12:56:09PM +0100, Paul Menzel wrote:
> 
>>> On a PowerEdge T440/021KCD, BIOS 2.11.2 04/22/2021, Linux 5.10.70 takes
>>> almost five seconds to initialize PCI. According to the timestamps, 
>>> 1.5 s
>>> are from assigning the PCI devices to the 142 IOMMU groups.
>>>
>>> ```
>>> $ lspci | wc -l
>>> 281
>>> $ dmesg
>>> […]
>>> [    2.918411] PCI: Using host bridge windows from ACPI; if 
>>> necessary, use "pci=nocrs" and report a bug
>>> [    2.933841] ACPI: Enabled 5 GPEs in block 00 to 7F
>>> [    2.973739] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-16])
>>> [    2.980398] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig 
>>> ASPM ClockPM Segments MSI HPX-Type3]
>>> [    2.989457] acpi PNP0A08:00: _OSC: platform does not support [LTR]
>>> [    2.995451] acpi PNP0A08:00: _OSC: OS now controls [PME 
>>> PCIeCapability]
>>> [    3.001394] acpi PNP0A08:00: FADT indicates ASPM is unsupported, 
>>> using BIOS configuration
>>> [    3.010511] PCI host bridge to bus 0000:00
>>> […]
>>> [    6.233508] system 00:05: [io  0x1000-0x10fe] has been reserved
>>> [    6.239420] system 00:05: Plug and Play ACPI device, IDs PNP0c02 
>>> (active)
>>> [    6.239906] pnp: PnP ACPI: found 6 devices
>>
>> For ~280 PCI devices, (6.24-2.92)/280 = 0.012 s/dev.  On my laptop I
>> have about (.66-.37)/36 = 0.008 s/dev (on v5.4), so about the same
>> ballpark.
> 
> Though if it was on average 0.008 s/dev here, around a second could be 
> saved.
> 
> The integrated Matrox G200eW3 graphics controller (102b:0536) and the 
> two Broadcom NetXtreme BCM5720 2-port Gigabit Ethernet PCIe cards 
> (14e4:165f) take 150 ms to be initialized.
> 
>      [    3.454409] pci 0000:03:00.0: [102b:0536] type 00 class 0x030000
>      [    3.460411] pci 0000:03:00.0: reg 0x10: [mem 
> 0x91000000-0x91ffffff pref]
>      [    3.467403] pci 0000:03:00.0: reg 0x14: [mem 0x92808000-0x9280bfff]
>      [    3.473402] pci 0000:03:00.0: reg 0x18: [mem 0x92000000-0x927fffff]
>      [    3.479437] pci 0000:03:00.0: BAR 0: assigned to efifb
> 
> The timestamp in each line differs by around 6 ms. Could printing the 
> messages to the console (VGA) hold this up (line 373 to line 911 makes 
> (6.24 s-2.92 s)/(538 lines) = (3.32 s)/(538 lines) = 6 ms)?
> 
>      [    3.484480] pci 0000:02:00.0: PCI bridge to [bus 03]
>      [    3.489401] pci 0000:02:00.0:   bridge window [mem 
> 0x92000000-0x928fffff]
>      [    3.496398] pci 0000:02:00.0:   bridge window [mem 
> 0x91000000-0x91ffffff 64bit pref]
>      [    3.504446] pci 0000:04:00.0: [14e4:165f] type 00 class 0x020000
>      [    3.510415] pci 0000:04:00.0: reg 0x10: [mem 
> 0x92e30000-0x92e3ffff 64bit pref]
>      [    3.517408] pci 0000:04:00.0: reg 0x18: [mem 
> 0x92e40000-0x92e4ffff 64bit pref]
>      [    3.524407] pci 0000:04:00.0: reg 0x20: [mem 
> 0x92e50000-0x92e5ffff 64bit pref]
>      [    3.532402] pci 0000:04:00.0: reg 0x30: [mem 
> 0xfffc0000-0xffffffff pref]
>      [    3.538483] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
>      [    3.544437] pci 0000:04:00.0: 4.000 Gb/s available PCIe 
> bandwidth, limited by 5.0 GT/s PCIe x1 link at 0000:00:1c.5 (capable of 
> 8.000 Gb/s with 5.0 GT/s PCIe x2 link)
>      [    3.559493] pci 0000:04:00.1: [14e4:165f] type 00 class 0x020000
> 
> Here is a 15 ms delay.
> 
>      [    3.565415] pci 0000:04:00.1: reg 0x10: [mem 
> 0x92e00000-0x92e0ffff 64bit pref]
>      [    3.573407] pci 0000:04:00.1: reg 0x18: [mem 
> 0x92e10000-0x92e1ffff 64bit pref]
>      [    3.580407] pci 0000:04:00.1: reg 0x20: [mem 
> 0x92e20000-0x92e2ffff 64bit pref]
>      [    3.587402] pci 0000:04:00.1: reg 0x30: [mem 
> 0xfffc0000-0xffffffff pref]
>      [    3.594483] pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
>      [    3.600502] pci 0000:00:1c.5: PCI bridge to [bus 04]
> 
> Can the 6 ms – also from your system – be explained by the PCI 
> specification? Seeing how fast PCI nowadays is, 6 ms sounds like a long 
> time. ;-)
> 
>> Faster would always be better, of course.  I assume this is not really
>> a regression?
> 
> Correct, as far as I know of, this is no regression.
> 
>>> [    6.989016] pci 0000:d7:05.0: disabled boot interrupts on device 
>>> [8086:2034]
>>> [    6.996063] PCI: CLS 0 bytes, default 64
>>> [    7.000008] Trying to unpack rootfs image as initramfs...
>>> [    7.065281] Freeing initrd memory: 5136K
> 
> The PCI resource assignment(?) also seems to take 670 ms:
> 
>      [    6.319656] pci 0000:04:00.0: can't claim BAR 6 [mem 
> 0xfffc0000-0xffffffff pref]: no compatible bridge window
>      […]
>      [    6.989016] pci 0000:d7:05.0: disabled boot interrupts on device 
> [8086:2034]
> 
>>> […]
>>> [    7.079098] DMAR: dmar7: Using Queued invalidation
>>> [    7.083983] pci 0000:00:00.0: Adding to iommu group 0
>>> […]
>>> [    8.537808] pci 0000:d7:17.1: Adding to iommu group 141
>>
>> I don't have this iommu stuff turned on and don't know what's
>> happening here.
> 
> There is a lock in `iommu_group_add_device()` in `drivers/iommu/iommu.c`:
> 
>          mutex_lock(&group->mutex);
>          list_add_tail(&device->list, &group->devices);
>          if (group->domain  && !iommu_is_attach_deferred(group->domain, 
> dev))
>                  ret = __iommu_attach_device(group->domain, dev);
>          mutex_unlock(&group->mutex);
> 
> No idea, if it’s related. Unfortunately, it’s a production system, so I 
> can’t do any debugging. (Maybe `initcall_debug` could give some 
> insight.) Maybe the IOMMU developers can explain it without it. Could 
> the IOMMU group assignment be done in parallel?

FWIW I'd expect that locking to be pretty much immaterial - many devices 
are getting their own uncontended groups, and callers of this tend to be 
serialised at a higher level anyway. iommu_probe_device() usually runs 
off the back of the device_add() notifier (where it could be that it's 
the only thing making noise in between something *else* being slow), but 
there is the special case where it gets replayed for all existing 
devices when the IOMMU driver registers itself - at a guess it seems 
like it may well be the latter case you're seeing, but either way 
there's not much to say without figuring out where the time is actually 
being spent (I don't suppose that machine has dynamic ftrace enabled?).

That said, setting up a new group isn't a completely insignificant 
amount of work, and 142 groups seems a lot - I'd have assumed that a 
system of that scale would be the kind of big server kit that takes 
several minutes to boot to the point of even starting the kernel anyway.

Robin.

>>> Is there anything that could be done to reduce the time?
> 
> 
> Kind regards,
> 
> Paul
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
