Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A3139078A
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhEYR1Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 13:27:25 -0400
Received: from foss.arm.com ([217.140.110.172]:32900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEYR1Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 13:27:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B6761516;
        Tue, 25 May 2021 10:25:54 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86ACB3F73B;
        Tue, 25 May 2021 10:25:52 -0700 (PDT)
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     Peter Geis <pgwipeout@gmail.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Rob Herring <robh@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com>
 <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com> <87eedxbtkn.fsf@stealth>
 <CAMj1kXE3U+16A6bO0UHG8=sx45DE6u0FtdSnoLDvfGnFJYTDrg@mail.gmail.com>
 <877djnaq11.fsf@stealth>
 <CAMj1kXFk2u=tbTYpa6Vqz5ihATFq61pCDiEbfRgXL_Rw+q_9Fg@mail.gmail.com>
 <CAMdYzYo-vdJvT_MPNTYvdveG3W8na7qMVEZFL4AjyQWqcLZi=Q@mail.gmail.com>
 <CAMj1kXEBePfKDOc6eo9yjZPnVeFimX-zxR+R3As+2pP9XnZkuQ@mail.gmail.com>
 <CAMdYzYrH_M92Pc6AqTgagtATr1TPq7Pdm57hadZeAmMBF2f0nA@mail.gmail.com>
 <CAMj1kXHsGgFedbhW2CiS5gveK3=ZxhXQ5siDeHJyttkOVKBQrQ@mail.gmail.com>
 <CAMdYzYruNYtJ8hwKPBUHPed1-=tV=CWDd_oSQtRmr4BJHp=YxA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <92c5785a-18f6-182a-b51b-9dfc373a5c01@arm.com>
Date:   Tue, 25 May 2021 18:25:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAMdYzYruNYtJ8hwKPBUHPed1-=tV=CWDd_oSQtRmr4BJHp=YxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-05-25 18:01, Peter Geis wrote:
> On Tue, May 25, 2021 at 12:44 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Tue, 25 May 2021 at 18:23, Peter Geis <pgwipeout@gmail.com> wrote:
>>>
>>> On Tue, May 25, 2021 at 11:55 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>
>>>> On Tue, 25 May 2021 at 17:34, Peter Geis <pgwipeout@gmail.com> wrote:
>>>>>
>>>>> On Tue, May 25, 2021 at 9:57 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>>
>>>>>> On Tue, 25 May 2021 at 15:42, Punit Agrawal <punitagrawal@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi Ard,
>>>>>>>
>>>>>>> Ard Biesheuvel <ardb@kernel.org> writes:
>>>>>>>
>>>>>>>> On Sun, 23 May 2021 at 13:06, Punit Agrawal <punitagrawal@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>>>>>>>
>>>>>>>>>> [ +linux-pci for visibility ]
>>>>>>>>>>
>>>>>>>>>> On 2021-05-18 10:09, Alexandru Elisei wrote:
>>>>>>>>>>> After doing a git bisect I was able to trace the following error when booting my
>>>>>>>>>>> rockpro64 v2 (rk3399 SoC) with a PCIE NVME expansion card:
>>>>>>>>>>> [..]
>>>>>>>>>>> [    0.305183] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
>>>>>>>>>>> [    0.305248] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fbdfffff ->
>>>>>>>>>>> 0x00fa000000
>>>>>>>>>>> [    0.305285] rockchip-pcie f8000000.pcie:       IO 0x00fbe00000..0x00fbefffff ->
>>>>>>>>>>> 0x00fbe00000
>>>>>>>>>>> [    0.306201] rockchip-pcie f8000000.pcie: supply vpcie1v8 not found, using dummy
>>>>>>>>>>> regulator
>>>>>>>>>>> [    0.306334] rockchip-pcie f8000000.pcie: supply vpcie0v9 not found, using dummy
>>>>>>>>>>> regulator
>>>>>>>>>>> [    0.373705] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
>>>>>>>>>>> [    0.373730] pci_bus 0000:00: root bus resource [bus 00-1f]
>>>>>>>>>>> [    0.373751] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
>>>>>>>>>>> [    0.373777] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus
>>>>>>>>>>> address [0xfbe00000-0xfbefffff])
>>>>>>>>>>> [    0.373839] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
>>>>>>>>>>> [    0.373973] pci 0000:00:00.0: supports D1
>>>>>>>>>>> [    0.373992] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
>>>>>>>>>>> [    0.378518] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
>>>>>>>>>>> reconfiguring
>>>>>>>>>>> [    0.378765] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
>>>>>>>>>>> [    0.378869] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
>>>>>>>>>>> [    0.379051] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
>>>>>>>>>>> [    0.379661] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by
>>>>>>>>>>> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe
>>>>>>>>>>> x4 link)
>>>>>>>>>>> [    0.393269] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
>>>>>>>>>>> [    0.393311] pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
>>>>>>>>>>> [    0.393333] pci 0000:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
>>>>>>>>>>> [    0.393356] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
>>>>>>>>>>> [    0.393375] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
>>>>>>>>>>> [    0.393397] pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>>>>>>>> [    0.393839] pcieport 0000:00:00.0: PME: Signaling with IRQ 78
>>>>>>>>>>> [    0.394165] pcieport 0000:00:00.0: AER: enabled with IRQ 78
>>>>>>>>>>> [..]
>>>>>>>>>>> to the commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to
>>>>>>>>>>> resource flags for
>>>>>>>>>>> 64-bit memory addresses").
>>>>>>>>>>
>>>>>>>>>> FWFW, my hunch is that the host bridge advertising no 32-bit memory
>>>>>>>>>> resource, only only a single 64-bit non-prefetchable one (even though
>>>>>>>>>> it's entirely below 4GB) might be a bit weird and tripping something
>>>>>>>>>> up in the resource assignment code. It certainly seems like the thing
>>>>>>>>>> most directly related to the offending commit.
>>>>>>>>>>
>>>>>>>>>> I'd be tempted to try fiddling with that in the DT (i.e. changing
>>>>>>>>>> 0x83000000 to 0x82000000 in the PCIe node's "ranges" property) to see
>>>>>>>>>> if it makes any difference. Note that even if it helps, though, I
>>>>>>>>>> don't know whether that's the correct fix or just a bodge around a
>>>>>>>>>> corner-case bug somewhere in the resource code.
>>>>>>>>>
>>>>>>>>>  From digging into this further the failure seems to be due to a mismatch
>>>>>>>>> of flags when allocating resources in pci_bus_alloc_from_region() -
>>>>>>>>>
>>>>>>>>>      if ((res->flags ^ r->flags) & type_mask)
>>>>>>>>>              continue;
>>>>>>>>>
>>>>>>>>> Though I am also not sure why the failure is only being reported on
>>>>>>>>> RK3399 - does a single 64-bit window have anything to do with it?
>>>>>>>>>
>>>>>>>>
>>>>>>>> The NVMe in the example exposes a single 64-bit non-prefetchable BAR.
>>>>>>>> Such BARs can not be allocated in a prefetchable host bridge window
>>>>>>>> (unlike the converse, i.e., allocating a prefetchable BAR in a
>>>>>>>> non-prefetchable host bridge window is fine)
>>>>>>>>
>>>>>>>> 64-bit non-prefetchable host bridge windows cannot be forwarded by PCI
>>>>>>>> to PCI bridges, they simply lack the BAR registers to describe them.
>>>>>>>> Therefore, non-prefetchable endpoint BARs (even 64-bit ones) need to
>>>>>>>> be carved out of a host bridge's non-prefetchable 32-bit window if
>>>>>>>> they need to pass through a bridge.
>>>>>>>
>>>>>>> Thank you for the explanation. I also looked at the PCI-to-PCI Bridge
>>>>>>> spec to understand where some of the limitations are coming from.
>>>>>>>
>>>>>>>> So the error seems to be here that the host bridge's 32-bit
>>>>>>>> non-prefetchable window has the 64-bit attribute set, even though it
>>>>>>>> resides below 4 GB entirely. I suppose that the resource allocation
>>>>>>>> could be made more forgiving (and it was in the past, before commit
>>>>>>>> 9d57e61bf723 was applied). However, I would strongly recommend not
>>>>>>>> deviating from common practice, and just describe the 32-bit
>>>>>>>> addressable non-prefetchable resource window as such.
>>>>>>>
>>>>>>> IIUC, the host bridge's configuration (64-bit on non-prefetchable
>>>>>>> window) is based on what the hardware advertises.
>>>>>>>
>>>>>>
>>>>>> What do you mean by 'what the hardware advertises'? The host bridge is
>>>>>> apparently configured to decode a 32-bit addressable window as MMIO,
>>>>>> and the question is why this window has the 64-bit attribute set in
>>>>>> the DT description.
>>>>>>
>>>>>>> Can you elaborate on what you have in mind to correct the
>>>>>>> non-prefetchable resource window? Are you thinking of adding a quirk
>>>>>>> somewhere to address this?
>>>>>>>
>>>>>>
>>>>>> No. Just fix the DT.
>>>>>
>>>>> Good Morning,
>>>>>
>>>>> I believe Robin is correct that there is more to this.
>>>>> While attempting to work out why dGPUs won't work with the rk356x
>>>>> series PCIe controllers, Christian König from the amd-gpu driver
>>>>> mailing list noticed the gpu was incorrectly allocated a 64bit
>>>>> non-prefetchable BAR which should instead be a 32 non-prefetchable
>>>>> BAR.
>>>>>
>>>>
>>>> This is due to the translation. For some reason, lspci translates the
>>>> BAR values to CPU addresses, but the PCI side addresses are within
>>>> 32-bits.
>>>
>>> The kernel log reports the same thing:
>>> [    6.662141] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0fffffff
>>> 64bit pref]
>>> [    6.662963] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x0001ffff 64bit]
>>>
>>> You are saying this is a display only issue?
>>>
>>
>> Yes. What do the 'root bus resource' log lines say for these regions?
>> Those should give you both the CPU address as well as the bus address.
> 
> [    6.673497] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
> (bus address [0x3f700000-0x3f7fffff])
> [    6.674642] pci_bus 0000:00: root bus resource [mem
> 0x300000000-0x33f6fffff] (bus address [0x00000000-0x3f6fffff])

Assuming RK356x has a similar memory map to other Rockchip SoCs, I 
suspect you may have a larger issue with your mem space window shadowing 
a significant chunk of your RAM.

Robin.

> 
> I tweaked the original Rockchip values to place the non-prefetchable
> memory first with the configuration and io later in this boot.
> 
>>
>>
>>>>
>>>> Are you sure the amdgpu driver can even deal with non-1:1 host bridges?
>>>
>>> I cannot answer this as I'm not an amdgpu dev.
>>>
>>>>
>>>>> The ranges currently set are:
>>>>> ranges = <0x81000000 0x0 0x00800000 0x3 0x00800000 0x0 0x00100000
>>>>> 0x82000000 0x0 0x00900000 0x3 0x00900000 0x0 0x3f700000>;
>>>>>
>>>>
>>>> So you have two ranges here.
>>>
>>> The IO and PCI memory ranges.
>>>
>>> There is a third range, the configuration range, which is defined in
>>> the reg block:
>>> <0x3 0x00000000 0x0 0x800000>
>>> All three are shared in the same 1GB window on the rk356x.
>>>
>>
>> But the reg block is not a resource window, it is a configuration
>> range to program the host bridge.
>>
>>> https://elixir.bootlin.com/linux/v5.13-rc3/source/Documentation/devicetree/bindings/pci/designware-pcie.txt#L12
>>>
>>>>
>>>>> but the final allocation was:
>>>>>
>>>>> lspci -v
>>>>> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3566
>>>>> (rev 01) (prog-if 00 [Normal decode])
>>>>>          Flags: bus master, fast devsel, latency 0, IRQ 96
>>>>>          Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
>>>>>          I/O behind bridge: 00001000-00001fff [size=4K]
>>>>>          Memory behind bridge: 00900000-009fffff [size=1M]
>>>>>          Prefetchable memory behind bridge:
>>>>> 0000000010000000-000000001fffffff [size=256M]
>>>>
>>>> But the host bridge/root port decodes two disjoint regions??
>>>>
>>>>>          Expansion ROM at 300a00000 [virtual] [disabled] [size=64K]
>>>>>          Capabilities: [40] Power Management version 3
>>>>>          Capabilities: [50] MSI: Enable+ Count=1/32 Maskable- 64bit+
>>>>>          Capabilities: [70] Express Root Port (Slot-), MSI 00
>>>>>          Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
>>>>>          Capabilities: [100] Advanced Error Reporting
>>>>>          Capabilities: [148] Secondary PCI Express
>>>>>          Capabilities: [160] L1 PM Substates
>>>>>          Capabilities: [170] Vendor Specific Information: ID=0002 Rev=4
>>>>> Len=100 <?>
>>>>>          Kernel driver in use: pcieport
>>>>>
>>>>> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
>>>>> [AMD/ATI] Turks PRO [Radeon HD 7570] (prog-if 00 [VGA controller])
>>>>>          Subsystem: Dell Turks PRO [Radeon HD 7570]
>>>>>          Flags: bus master, fast devsel, latency 0, IRQ 95
>>>>>          Memory at 310000000 (64-bit, prefetchable) [size=256M]
>>>>>          Memory at 300900000 (64-bit, non-prefetchable) [size=128K]
>>>>>          I/O ports at 1000 [size=256]
>>>>>          Expansion ROM at 300920000 [disabled] [size=128K]
>>>>>          Capabilities: [50] Power Management version 3
>>>>>          Capabilities: [58] Express Legacy Endpoint, MSI 00
>>>>>          Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
>>>>>          Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
>>>>> Len=010 <?>
>>>>>          Capabilities: [150] Advanced Error Reporting
>>>>>          Kernel driver in use: radeon
>>>>>
>>>>> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Turks
>>>>> HDMI Audio [Radeon HD 6500/6600 / 6700M Series]
>>>>>          Subsystem: Dell Turks HDMI Audio [Radeon HD 6500/6600 / 6700M Series]
>>>>>          Flags: bus master, fast devsel, latency 0, IRQ 98
>>>>>          Memory at 300940000 (64-bit, non-prefetchable) [size=16K]
>>>>>          Capabilities: [50] Power Management version 3
>>>>>          Capabilities: [58] Express Legacy Endpoint, MSI 00
>>>>>          Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>>>          Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
>>>>> Len=010 <?>
>>>>>          Capabilities: [150] Advanced Error Reporting
>>>>>          Kernel driver in use: snd_hda_intel
>>>>>
>>>>> This will obviously clobber registers during writes.
>>>>
>>>> I don't follow. Which writes will clobber which registers, and how is
>>>> it obvious?
>>>
>>> Writing a 64 bit word into a 32 bit register will either clobber the
>>> next higher 32 bit register.
>>> Quoting Christian:
>>> "When you program a 32bit BAR as 64bit you overwrite the register behind
>>> the BAR address with the upper 32bits of the 64bit address value.
>>> So even if the allocation fits into 32bits, the extra register write
>>> will certainly put your device into a banana state."
>>>
>>> https://lists.freedesktop.org/archives/amd-gfx/2021-May/064232.html
>>>
>>
>> I seriously doubt that this is what is going on here.
>>
>> lspci -x will give you the bare BAR values - I suspect that those are
>> probably fine.
> 
> lspci -x
> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3566 (rev 01)
> 00: 87 1d 66 35 07 05 10 40 01 00 04 06 00 00 01 00
> 10: 00 00 00 00 00 00 00 00 00 01 ff 00 10 10 00 20
> 20: 00 10 00 10 01 00 f1 0f 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 5f 01 02 00
> 
> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Turks PRO [Radeon HD 7570]
> 00: 02 10 5d 67 07 00 10 20 00 00 00 03 00 00 80 00
> 10: 0c 00 00 00 00 00 00 00 04 00 00 10 00 00 00 00
> 20: 01 10 70 3f 00 00 00 00 00 00 00 00 28 10 20 2b
> 30: 00 00 02 10 50 00 00 00 00 00 00 00 5f 01 00 00
> 
> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Turks
> HDMI Audio [Radeon HD 6500/6600 / 6700M Series]
> 00: 02 10 90 aa 06 00 10 20 00 00 03 04 00 00 80 00
> 10: 04 00 04 10 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 90 aa
> 30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 02 00 00
> 
>>
>>
>>>>
>>>>> Also, if <0x82000000> (32 bit) is changed to <0x83000000> (64 bit),
>>>>> most of the allocations for the dGPU fail due to no valid regions
>>>>> available.
>>>>>
>>>>
>>>> But wasn't the original problem that the resource window was 64-bit to
>>>> begin with? Are you sure we are talking about the same problem here?
>>>
>>> The rk3399 in the original report has a 32MB memory window in the
>>> upper end of the 4GB range.
>>> The rk356x has a similar layout, or it can use a 1GB window available
>>> at <0x3 0x00000000>.
>>> Rockchip's default windows are defined as 64bit.
>>>
>>> The rk3399 doesn't have enough space to reasonably define two windows,
>>> one 32bit, one 64bit, to work around an allocation bug.
>>> These are the defined regions in the rk3399:
>>> ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000>,
>>> <0x81000000 0x0 0xfbe00000 0x0 0xfbe00000 0x0 0x100000>;
>>>
>>
>> All you really need is a 32-bit non-prefetchable resource window: any
>> BAR can be allocated from that. A 64-bit BAR can carry a 32-bit number
>> (just add zeroes at the top), and a prefetchable BAR can happily live
>> in a non-prefetchable window, with a theoretical performance impact if
>> the OS actually does use different memory attributes for the
>> prefetchable window (but I don't think Linux ever handles it this way)
> 
> So is the IO range necessary as well or will it be automatically
> allocated as well?
> 
>>
>>
>>>
>>>>
>>>>
>>>>>>
>>>>>>> I am happy to put something together once I understand the preferred way
>>>>>>> to go about it.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Punit
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> Linux-rockchip mailing list
>>>>>> Linux-rockchip@lists.infradead.org
>>>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
