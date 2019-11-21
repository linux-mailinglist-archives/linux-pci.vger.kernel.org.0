Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA38104888
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 03:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfKUCaT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 21:30:19 -0500
Received: from lucky1.263xmail.com ([211.157.147.134]:37824 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUCaT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 21:30:19 -0500
X-Greylist: delayed 1451 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Nov 2019 21:30:02 EST
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 6263F4AF25;
        Thu, 21 Nov 2019 10:03:27 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-CHECKED: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3858T140196833363712S1574301806819641_;
        Thu, 21 Nov 2019 10:03:27 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c64d177574507ebb0923332d2e7b682f>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 1
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] rk3399-rockpro64 pcie synchronous external abort
To:     Peter Geis <pgwipeout@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <CAMdYzYp7kQdMKzX2RQW0tY2P4Um=CNJW93RPquBmYATRGrxwng@mail.gmail.com>
 <20191112022938.GA89741@google.com>
 <CAMdYzYrYHtiEXwiKxwWcKSV7Re6dG4zTvkKtZxvso+fLBRYbPQ@mail.gmail.com>
 <991e386e-4c4f-fcbd-89a1-1edd82f63ece@arm.com>
 <CAMdYzYri-yroFtvVXdNZH=sNOM7RP_PBHVnmbHuAKmGBZ0GifA@mail.gmail.com>
 <CAMdYzYrc-AJNpnqR6Xw9Np0wuUvS4-u+TCS2WEo78TfyEhCQKg@mail.gmail.com>
 <CAMdYzYow8SuXb_8ow433O_+Wezxb-U08WDUiLxcTKh+1_zBzkQ@mail.gmail.com>
 <CAMdYzYphu1vHEprfry52+vH9Hjp3ZddgY5hk4Xqk2b3v=DU80g@mail.gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <2a381384-9d47-a7e2-679c-780950cd862d@rock-chips.com>
Date:   Thu, 21 Nov 2019 10:03:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAMdYzYphu1vHEprfry52+vH9Hjp3ZddgY5hk4Xqk2b3v=DU80g@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------312F4E2138CF17ED87B089BC"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------312F4E2138CF17ED87B089BC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2019/11/21 8:36, Peter Geis wrote:
> On Tue, Nov 12, 2019 at 8:19 PM Peter Geis <pgwipeout@gmail.com> wrote:
>>
>> On Tue, Nov 12, 2019 at 8:06 PM Peter Geis <pgwipeout@gmail.com> wrote:
>>>
>>> On Tue, Nov 12, 2019 at 2:41 PM Peter Geis <pgwipeout@gmail.com> wrote:
>>>>
>>>> On Tue, Nov 12, 2019 at 2:15 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>>>>
>>>>> On 12/11/2019 3:55 pm, Peter Geis wrote:
>>>>>> On Mon, Nov 11, 2019 at 9:29 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>>
>>>>>>> On Mon, Nov 11, 2019 at 07:30:15PM -0500, Peter Geis wrote:
>>>>>>>> On Mon, Nov 11, 2019 at 7:13 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>>>> On Mon, Nov 04, 2019 at 01:55:40PM -0500, Peter Geis wrote:
>>>>>>>>>> Good Morning,
>>>>>>>>>>
>>>>>>>>>> I'm attempting to debug an issue with the rockpro64 pcie port.
>>>>>>>>>> It would appear that the port does not like various cards, including
>>>>>>>>>> cards of the same make that randomly work or do not work, such as
>>>>>>>>>> Intel i340 based NICs.
>>>>>>>>>> I'm experiencing it with a GTX645 gpu.
>>>>>>>>>>
>>>>>>>>>> This seems to be a long running issue, referenced both at [0], and [1].
>>>>>>>>>> There was an attempt to rectify it, by adding a delay between training
>>>>>>>>>> and probing [2], but that doesn't seem to be the issue here.
>>>>>>>>>> It appears that when we probe further into the card, such as devfn >
>>>>>>>>>> 1, we trigger the bug.
>>>>>>>>>> I've added a print statement that prints the devfn, address, and size
>>>>>>>>>> information, which you can see below.
>>>>>>>>>>
>>>>>>>>>> I've attempted setting the available number of lanes to 1 as well, to
>>>>>>>>>> no difference.
>>>>>>>>>>
>>>>>>>>>> If anyone could point me in the right direction as to where to
>>>>>>>>>> continue debugging, I'd greatly appreciate it.
>>>>>>>>>>
>>>>>>>>>> [0] https://github.com/ayufan-rock64/linux-build/issues/254
>>>>>>>>>> [1] https://github.com/rockchip-linux/kernel/issues/116
>>>>>>>>>> [2] https://github.com/ayufan-rock64/linux-kernel/commit/3cde5c624c9c39aa03251a55c2d26a48b5bdca5b
>>>>>>>>>>
>>>>>>>>>> [  198.491458] rockchip-pcie f8000000.pcie: missing legacy phy; search
>>>>>>>>>> for per-lane PHY
>>>>>>>>>> [  198.492986] rockchip-pcie f8000000.pcie: no vpcie1v8 regulator found
>>>>>>>>>> [  198.493060] rockchip-pcie f8000000.pcie: no vpcie0v9 regulator found
>>>>>>>>>> [  198.550444] rockchip-pcie f8000000.pcie: current link width is x1
>>>>>>>>>> [  198.550458] rockchip-pcie f8000000.pcie: idling lane 1
>>>>>>>>>> [  198.550479] rockchip-pcie f8000000.pcie: idling lane 2
>>>>>>>>>> [  198.550490] rockchip-pcie f8000000.pcie: idling lane 3
>>>>>>>>>> [  198.550608] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
>>>>>>>>>> [  198.550625] rockchip-pcie f8000000.pcie: Parsing ranges property...
>>>>>>>>>> [  198.550656] rockchip-pcie f8000000.pcie:   MEM
>>>>>>>>>> 0xfa000000..0xfbdfffff -> 0xfa000000
>>>>>>>>>> [  198.550676] rockchip-pcie f8000000.pcie:    IO
>>>>>>>>>> 0xfbe00000..0xfbefffff -> 0xfbe00000
>>>>>>>>>> [  198.552908] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
>>>>>>>>>> [  198.552933] pci_bus 0000:00: root bus resource [bus 00-1f]
>>>>>>>>>> [  198.552943] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
>>>>>>>>>> [  198.552954] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
>>>>>>>>>> (bus address [0xfbe00000-0xfbefffff])
>>>>>>>>>> [  198.552965] pci_bus 0000:00: scanning bus
>>>>>>>>>> [  198.554198] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
>>>>>>>>>> [  198.555508] pci 0000:00:00.0: supports D1
>>>>>>>>>> [  198.555516] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
>>>>>>>>>> [  198.556023] pci 0000:00:00.0: PME# disabled
>>>>>>>>>> [  198.561245] pci_bus 0000:00: fixups for bus
>>>>>>>>>> [  198.561269] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
>>>>>>>>>> [  198.561277] pci 0000:00:00.0: bridge configuration invalid ([bus
>>>>>>>>>> 00-00]), reconfiguring
>>>>>>>>>> [  198.566429] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
>>>>>>>>>> [  198.567008] pci_bus 0000:01: scanning bus
>>>>>>>>>> [  198.567171] pci 0000:01:00.0: [10de:11c4] type 00 class 0x030000
>>>>>>>>>> [  198.567420] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00ffffff]
>>>>>>>>>> [  198.567515] pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x07ffffff
>>>>>>>>>> 64bit pref]
>>>>>>>>>> [  198.567608] pci 0000:01:00.0: reg 0x1c: [mem 0x00000000-0x01ffffff
>>>>>>>>>> 64bit pref]
>>>>>>>>>> [  198.567665] pci 0000:01:00.0: reg 0x24: initial BAR value 0x00000000 invalid
>>>>>>>>>> [  198.567673] pci 0000:01:00.0: reg 0x24: [io  size 0x0080]
>>>>>>>>>> [  198.567730] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
>>>>>>>>>> [  198.567815] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
>>>>>>>>>> [  198.569051] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,
>>>>>>>>>> limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 126.016 Gb/s
>>>>>>>>>> with 8 GT/s x16 link)
>>>>>>>>>> [  198.570225] pci 0000:01:00.0: vgaarb: VGA device added:
>>>>>>>>>> decodes=io+mem,owns=none,locks=none
>>>>>>>>>> [  198.570481] pci 0000:01:00.1: [10de:0e0b] type 00 class 0x040300
>>>>>>>>>> [  198.570663] pci 0000:01:00.1: reg 0x10: [mem 0x00000000-0x00003fff]
>>>>>>>>>> [  198.571039] pci 0000:01:00.1: Max Payload Size set to 256 (was 128, max 256)
>>>>>>>>>> <snip>
>>>>>>>>>> [  198.749857] pci_bus 0000:01: read pcie, devfn 1, at 100, size 2
>>>>>>>>>> [  198.750252] pci_bus 0000:01: read pcie, devfn 2, at 0, size 4
>>>>>>>>>> [  198.750881] Internal error: synchronous external abort: 96000210
>>>>>>>>>> [#1] PREEMPT SMP
>>>>>>>>>
>>>>>>>>> Is there really supposed to be a device at 01:00.2?
>>>>>>>>>
>>>>>>>>> Maybe this is just the PCIe Unsupported Request error that we expect
>>>>>>>>> to get when trying to read config space of a device that doesn't
>>>>>>>>> exist.
>>>>>>>>>
>>>>>>>>> On "most" platforms, we just get ~0 data back when that happens, but
>>>>>>>>> I'm not sure that's always the case on arm64.  I think it depends on
>>>>>>>>> how the PCIe host bridge is designed, and there might be some CPU
>>>>>>>>> configuration, too.
>>>>>>>>
>>>>>>>> Yes, this is a GTX645 video card.
>>>>>>>> Nvidia cards usually have two to three devices,
>>>>>>>> The GPU proper, the audio device for the hdmi output, and the i2c controller.
>>>>>>>>
>>>>>>>> I do think that this driver is missing sanity checking on the
>>>>>>>> addressing, since the BRCM driver for the RPI4 doesn't try to
>>>>>>>> enumerate a video card, since it checks if the MMIO space is large
>>>>>>>> enough to fit the BAR before assigning the addresses. See [3]. Also in
>>>>>>>> that thread he was able to increase the address space provided to the
>>>>>>>> BRCM driver and fix the issue, but I don't see how we could do that on
>>>>>>>> the rk3399.
>>>>>>>>
>>>>>>>> pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x07ffffff 64bit pref] is
>>>>>>>> 128 MB, which already exceeds our address space.
>>>>>>>> I think the driver is just overflowing the address space.
>>>>>>>
>>>>>>> If we don't have enough space to assign all the device BARs, I think a
>>>>>>> driver will still be able to claim the device, but when the driver
>>>>>>> calls pci_enable_device(), it should fail.  Lack of address space
>>>>>>> should not cause a PCIe error.
>>>>>>>
>>>>>>> But in this case, none of that matters because we're still enumerating
>>>>>>> devices in pci_scan_root_bus_bridge().  We haven't gotten to the point
>>>>>>> of trying to bind drivers to devices, so the driver isn't involved at
>>>>>>> all yet.
>>>>>> For clarification, the driver I'm referring to is the rk3399-pcie host driver.
>>>>>>>
>>>>>>> The backtrace says we're trying to read the Vendor ID of a device, and
>>>>>>> your debug output suggests we're trying to enumerate 01:00.2.  If you
>>>>>>> put that card in another system, you could find out how many functions
>>>>>>> it has.
>>>>>>>
>>>>>>> Or if you swapped this with other cards where you know the number of
>>>>>>> functions, you could see if the external abort always happens when
>>>>>>> probing for the first unimplemented function.
>>>>>> This card definitely has more than one function.
>>>>>
>>>>> FWIW, random lspci logs I grovelled up off the internet show cards with
>>>>> the same IDs only implementing functions 0 and 1, which does suggest
>>>>> that maybe function 2 really doesn't exist but the card handles
>>>>> unsupported config requests in a way that this particular bridge/root
>>>>> port doesn't quite deal with properly.
>>>>
>>>> Thanks! Is there a sane way we could make the kernel handle this in
>>>> place of the controller?
>>>> (It's apparently based on the designware ip, but it doesn't use their
>>>> driver for some reason)
>>>>
>>>>>
>>>>>> Before my original message I hacked in some code to make the driver
>>>>>> return 0xff when devfn > 1, and the scan passed, but as soon as
>>>>>> nouveau attempted to access the device, the entire kernel exploded.
>>>
>>> This is what happens when probing is prevented from reading above
>>> devfn 1, and nouveau gets a shot.
>>> [   76.658128] SError Interrupt on CPU4, code 0xbf000000 -- SError
>>> [   76.658129] CPU: 4 PID: 1752 Comm: systemd-udevd Not tainted
>>> 5.4.0-rc5-next-20191031-00001-gddbfb17ac1c4-dirty #16
>>> [   76.658130] Hardware name: Pine64 RockPro64 (DT)
>>> [   76.658131] pstate: 60400005 (nZCv daif +PAN -UAO)
>>> [   76.658131] pc : nvkm_device_ctor+0x2cc/0x2e18 [nouveau]
>>> [   76.658132] lr : nvkm_device_ctor+0x2c0/0x2e18 [nouveau]
>>> [   76.658133] sp : ffff800012daf740
>>> [   76.658134] x29: ffff800012daf740 x28: ffff0000c2db9800
>>> [   76.658136] x27: 0000000000000000 x26: ffff0000c7f2e0b0
>>> [   76.658138] x25: 0000000000000000 x24: 0000000000000000
>>> [   76.658139] x23: 0000000000000000 x22: ffff800009e1b1e0
>>> [   76.658141] x21: ffff0000c335b940 x20: ffff800009ede660
>>> [   76.658142] x19: 0000000000000000 x18: 0000000000000001
>>> [   76.658144] x17: 0000000000000000 x16: 0000000000000000
>>> [   76.658145] x15: ffff0000c335bdc0 x14: ffff8000140a0000
>>> [   76.658147] x13: 0000000000110000 x12: 0040000000000001
>>> [   76.658148] x11: ffff0000c12b8180 x10: 0000000000000085
>>> [   76.658150] x9 : ffff800013c00000 x8 : 0000000000110000
>>> [   76.658152] x7 : 0000000000000000 x6 : ffff0000f7ff0008
>>> [   76.658153] x5 : ffff800013d0ffff x4 : ffff800013c00000
>>> [   76.658154] x3 : ffff800013c00004 x2 : 0140000000000000
>>> [   76.658156] x1 : 0000000000000000 x0 : ffff800013c00000
>>> [   76.658158] Kernel panic - not syncing: Asynchronous SError Interrupt
>>> [   76.658159] CPU: 4 PID: 1752 Comm: systemd-udevd Not tainted
>>> 5.4.0-rc5-next-20191031-00001-gddbfb17ac1c4-dirty #16
>>> [   76.658160] Hardware name: Pine64 RockPro64 (DT)
>>> [   76.658161] Call trace:
>>> [   76.658161]  dump_backtrace+0x0/0x148
>>> [   76.658162]  show_stack+0x24/0x30
>>> [   76.658163]  dump_stack+0xa8/0xf0
>>> [   76.658163]  panic+0x160/0x36c
>>> [   76.658164]  nmi_panic+0x94/0x98
>>> [   76.658164]  arm64_serror_panic+0x84/0x90
>>> [   76.658165]  do_serror+0x88/0x140
>>> [   76.658166]  el1_error+0xc4/0x170
>>> [   76.658166]  nvkm_device_ctor+0x2cc/0x2e18 [nouveau]
>>> [   76.658167]  nvkm_device_pci_new+0xf8/0x2c8 [nouveau]
>>> [   76.658168]  nouveau_drm_probe+0x60/0x288 [nouveau]
>>> [   76.658168]  local_pci_probe+0x44/0x98
>>> [   76.658169]  pci_device_probe+0x118/0x1b0
>>> [   76.658170]  really_probe+0xe0/0x320
>>> [   76.658171]  driver_probe_device+0x5c/0xf0
>>> [   76.658171]  device_driver_attach+0x74/0x80
>>> [   76.658172]  __driver_attach+0x64/0xe0
>>> [   76.658173]  bus_for_each_dev+0x80/0xd0
>>> [   76.658173]  driver_attach+0x30/0x40
>>> [   76.658174]  bus_add_driver+0x14c/0x1f0
>>> [   76.658175]  driver_register+0x64/0x110
>>> [   76.658175]  __pci_register_driver+0x58/0x68
>>> [   76.658176]  nouveau_drm_init+0x17c/0x10000 [nouveau]
>>> [   76.658177]  do_one_initcall+0x50/0x298
>>> [   76.658178]  do_init_module+0x88/0x270
>>> [   76.658178]  load_module+0x2068/0x2600
>>> [   76.658179]  __do_sys_finit_module+0xd0/0xe8
>>> [   76.658180]  __arm64_sys_finit_module+0x28/0x38
>>> [   76.658180]  el0_svc_common.constprop.0+0x7c/0x1f0
>>> [   76.658181]  el0_svc_handler+0x34/0xa0
>>> [   76.658182]  el0_svc+0x14/0x40
>>> [   76.658182]  el0_sync_handler+0x118/0x280
>>> [   76.658183]  el0_sync+0x164/0x180
>>> [   76.658248] SMP: stopping secondary CPUs
>>> [   76.658249] Kernel Offset: disabled
>>> [   76.658250] CPU features: 0x10002,2000600c
>>> [   76.658250] Memory Limit: none
>>
>> Last log, I promise.
>> This is what happens when it is locked out of devfn > 1, and nouveau
>> is not available.
>>
>> [    4.199087] vcc3v3_pcie: supplied by vcc12v_dcin
>> [   55.617783] ehci-pci: EHCI PCI platform driver
>> [   55.868935] ohci-pci: OHCI PCI platform driver
>> [   65.426085] rockchip-pcie f8000000.pcie: missing legacy phy; search
>> for per-lane PHY
>> [   65.426645] rockchip-pcie f8000000.pcie: no vpcie1v8 regulator found
>> [   65.426662] rockchip-pcie f8000000.pcie: no vpcie0v9 regulator found
>> [   65.507012] rockchip-pcie f8000000.pcie: current link width is x4
>> [   65.507078] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
>> [   65.507088] rockchip-pcie f8000000.pcie: Parsing ranges property...
>> [   65.507103] rockchip-pcie f8000000.pcie:   MEM
>> 0xfa000000..0xfbdfffff -> 0xfa000000
>> [   65.507112] rockchip-pcie f8000000.pcie:    IO
>> 0xfbe00000..0xfbffffff -> 0xfbe00000
>> [   65.507368] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
>> [   65.507376] pci_bus 0000:00: root bus resource [bus 00-1f]
>> [   65.507382] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
>> [   65.507390] pci_bus 0000:00: root bus resource [io
>> 0x0000-0x1fffff] (bus address [0xfbe00000-0xfbffffff])
>> [   65.507394] pci_bus 0000:00: scanning bus
>> [   65.507423] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
>> [   65.507543] pci 0000:00:00.0: supports D1
>> [   65.507547] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
>> [   65.507555] pci 0000:00:00.0: PME# disabled
>> [   65.511436] pci_bus 0000:00: fixups for bus
>> [   65.511452] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
>> [   65.511457] pci 0000:00:00.0: bridge configuration invalid ([bus
>> 00-00]), reconfiguring
>> [   65.511471] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
>> [   65.511633] pci_bus 0000:01: scanning bus
>> [   65.511739] pci 0000:01:00.0: [10de:11c4] type 00 class 0x030000
>> [   65.512205] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00ffffff]
>> [   65.512274] pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x07ffffff
>> 64bit pref]
>> [   65.512345] pci 0000:01:00.0: reg 0x1c: [mem 0x00000000-0x01ffffff
>> 64bit pref]
>> [   65.512390] pci 0000:01:00.0: reg 0x24: initial BAR value 0x00000000 invalid
>> [   65.512394] pci 0000:01:00.0: reg 0x24: [io  size 0x0080]
>> [   65.512435] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
>> [   65.512485] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
>> [   65.513319] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth,
>> limited by 2.5 GT/s x4 link at 0000:00:00.0 (capable of 126.016 Gb/s
>> with 8 GT/s x16 link)
>> [   65.513568] pci 0000:01:00.0: vgaarb: VGA device added:
>> decodes=io+mem,owns=none,locks=none
>> [   65.513744] pci 0000:01:00.1: [10de:0e0b] type 00 class 0x040300
>> [   65.513900] pci 0000:01:00.1: reg 0x10: [mem 0x00000000-0x00003fff]
>> [   65.514179] pci 0000:01:00.1: Max Payload Size set to 256 (was 128, max 256)
>> [   65.515129] rockchip-pcie f8000000.pcie: phy link changes
>> [   65.527011] pci_bus 0000:01: fixups for bus
>> [   65.527021] pci_bus 0000:01: bus scan returning with max=01
>> [   65.527030] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
>> [   65.527042] pci_bus 0000:00: bus scan returning with max=01
>> [   65.527076] pci 0000:00:00.0: BAR 14: no space for [mem size 0x0c000000]
>> [   65.527081] pci 0000:00:00.0: BAR 14: failed to assign [mem size 0x0c000000]
>> [   65.527091] pci 0000:01:00.0: BAR 1: no space for [mem size
>> 0x08000000 64bit pref]
>> [   65.527095] pci 0000:01:00.0: BAR 1: failed to assign [mem size
>> 0x08000000 64bit pref]
>> [   65.527100] pci 0000:01:00.0: BAR 3: no space for [mem size
>> 0x02000000 64bit pref]
>> [   65.527104] pci 0000:01:00.0: BAR 3: failed to assign [mem size
>> 0x02000000 64bit pref]
>> [   65.527109] pci 0000:01:00.0: BAR 0: no space for [mem size 0x01000000]
>> [   65.527119] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x01000000]
>> [   65.527123] pci 0000:01:00.0: BAR 6: no space for [mem size 0x00080000 pref]
>> [   65.527129] pci 0000:01:00.0: BAR 6: failed to assign [mem size
>> 0x00080000 pref]
>> [   65.527134] pci 0000:01:00.1: BAR 0: no space for [mem size 0x00004000]
>> [   65.527138] pci 0000:01:00.1: BAR 0: failed to assign [mem size 0x00004000]
>> [   65.527142] pci 0000:01:00.0: BAR 5: no space for [io  size 0x0080]
>> [   65.527146] pci 0000:01:00.0: BAR 5: failed to assign [io  size 0x0080]
>> [   65.527152] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [   65.529410] pcieport 0000:00:00.0: assign IRQ: got 238
>> [   65.529454] pcieport 0000:00:00.0: enabling bus mastering
>> [   65.529807] pcieport 0000:00:00.0: PME: Signaling with IRQ 239
>> [   65.530265] pcieport 0000:00:00.0: AER: enabled with IRQ 239
>> [   65.530685] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
> 
> An update to this issue, I purchased a pcie switch and tried testing
> with a few pcie devices I have around.
> Under no circumstances can I get it to read the switch, it aborts
> immediately upon reading the first register.
> Of note is it keeps reporting the following :
> [   64.510788] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
> [   64.510793] pci 0000:00:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [   64.510807] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
> <snip>
> [   64.527368] pci_bus 0000:01: fixups for bus
> [   64.527399] pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 0
> [   64.527404] pci 0000:01:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [   64.527452] pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 1
> [   64.527850] pci_bus 0000:02: scanning bus
> And aborts here.
> 
> Thoughts?

Not having too much time to follow up w/ upstream development, sorry.
I attach a patch based on Linux-next for debugging, but I don't know if
it could work as expected since I can't test it now. But at least it
shows what the problems were.

> 
>>
>>
>>>
>>>
>>>>>>
>>>>>> Another reason I believe the address assignments are overflowing and
>>>>>> corrupting other address assignments is after the external abort, the
>>>>>> entire PCIE controller is inaccessible.
>>>>>> $ lspci
>>>>>> pcilib: Cannot open /sys/bus/pci/devices/0000:01:00.1/config
>>>>>> lspci: Unable to read the standard configuration space header of
>>>>>> device 0000:01:00.1
>>>>>> pcilib: Cannot open /sys/bus/pci/devices/0000:00:00.0/config
>>>>>> lspci: Unable to read the standard configuration space header of
>>>>>> device 0000:00:00.0
>>>>>> pcilib: Cannot open /sys/bus/pci/devices/0000:01:00.0/config
>>>>>> lspci: Unable to read the standard configuration space header of
>>>>>> device 0000:01:00.0
>>>>>>
>>>>>> Attempting to rescan the bus or any other pci function results in a
>>>>>> hung kernel task.
>>>>>
>>>>> You crashed deep in the kernel part-way through the driver's probe
>>>>> routine; don't expect any partly-initialised bits of that driver to
>>>>> actually work. I bet you also can't load/unload modules and do various
>>>>> other things either, because the thread will almost certainly have been
>>>>> holding a bunch of locks, too. It's not worth trying to reason about the
>>>>> state of anything after that kind of unexpected crash ;)
>>>>
>>>> That is observed, but I think it is actually more destructive than that.
>>>> Attempting to do an access after the fact, then performing a soft
>>>> reset results in a spectacular crash when it tries to bring the BIG
>>>> cluster online.
>>>>
>>>> [    0.203160] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
>>>> [    5.355606] CPU4: failed to come online
>>>> [    5.363258] CPU4: failed in unknown state : 0x0
>>>> Unhandled Exception in EL3.
>>>> x30 =           0xUhandled Exception in L3.
>>>> x30 =           UNhandled ExcEption in EL3.
>>>> x30 =   0xUnhandled Excepti2n in EL_.
>>>> x30 =           0xUnhandled Exception in EL3.
>>>> x30 =           lxUnhadled Exception in EL3.
>>>> x30 =           0xUnhandled Excepion in EL3.
>>>> x30 =           0xUnhandled Exception in EL3.
>>>> x30 =   0xUnhandled Eception in EL3.
>>>> x30 =           0xUnhandled Exception in EL3.
>>>> x30 =           0xUnhandled Exception in EL3.x30 =
>>>> 0xUnhandled Exception in EL3.
>>>> x30 =           0xUnhandled Excepton i2 EL3.
>>>> x30 =           0xUnhandUnhandled Exceptionein EL3.lx30 =
>>>>   0xUnhandled Exception in EL3.
>>>> x30 =           0xUnhandled Unhanded Exception in EL3.
>>>> x30 =           0xUnhandled Exceptin in EL3Unhandled Exception inEL3.
>>>> x0 =            0xUnhandled Exception in EL3.
>>>> x30 =           0xUnhandled Exception in EL3.
>>>> x30 =           0xUnhandled Exception in EL.
>>>> x30 =           0xUnhandled Exception in EL3.
>>>> x30 =           0xUnhandled Exception in EL3.
>>>> x30 =           0xUnhandled xception in EL3
>>>> x30 =           0xUnhcndled Exception in EL3.
>>>> x30=            0xUnhandled Excextion in EL3.
>>>> x30 =   0xUnhandled Exception in EL3.
>>>> x30 =           0x[   10.484411] CPU5: failed to come online
>>>> [   10.484807] CPU5: failed in unknown state : 0x0
>>>> [   10.485374] smp: Brought up 1 node, 4 CPUs
>>>>
>>>> It goes on until it tries to do it's first DMA setup, then just hangs.
>>>>>
>>>>>>> If the Root Port (00:00.0) supports AER, you could also dump out the
>>>>>>> status registers from the AER capability and figure out whether it
>>>>>>> logged a PCIe error.  This would be sort of like what
>>>>>>> aer_process_err_devices() does.  A bit of a hassle to do this by hand
>>>>>>> in the exception path, but could be enlightening, just as a debug
>>>>>>> tool.
>>>>>>
>>>>>> Is there a way to handle external synchronous aborts in a device driver?
>>>>>
>>>>> Not easily on arm64 - the closest thing we have is some arch-internal
>>>>> machinery for undefined instruction hooks. You'd have to hack something
>>>>> gruesome into do_sea()...
>>>>>
>>>>> For starters it might be worth enabling all the debug prints in
>>>>> rockchip-pcie to see if there's any error IRQ corresponding to the
>>>>> aborted access.
>>>>
>>>> Debug prints are already enabled, I had to hack in the print to show
>>>> what addresses it was crashing on.
>>>>
>>>> Your explanation was the last piece for me to understand how this all
>>>> works, thanks!
>>>>>
>>>>> Robin.
>>>>>
>>>>>> If so, I'll definitely look into plugging in the aer status functions.
>>>>>>
>>>>>>>
>>>>>>>> [3] https://twitter.com/domipheus/status/1167586160077627393
>>>>>>>>>
>>>>>>>>>> [  198.751581] Modules linked in: drm_panel_orientation_quirks
>>>>>>>>>> pcie_rockchip_host(+) cpufreq_dt sch_fq_codel ip_tables x_tables ipv6
>>>>>>>>>> crc_ccitt nf_defrag_ipv6
>>>>>>>>>> [  198.752861] CPU: 1 PID: 1686 Comm: systemd-udevd Not tainted
>>>>>>>>>> 5.4.0-rc5-next-20191031-00001-gddbfb17ac1c4-dirty #5
>>>>>>>>>> [  198.753791] Hardware name: Pine64 RockPro64 (DT)
>>>>>>>>>> [  198.754215] pstate: 60400085 (nZCv daIf +PAN -UAO)
>>>>>>>>>> [  198.754672] pc : __raw_readl+0x0/0x8 [pcie_rockchip_host]
>>>>>>>>>> [  198.755172] lr : rockchip_pcie_rd_conf+0x140/0x1dc [pcie_rockchip_host]
>>>>>>>>>> [  198.755773] sp : ffff8000132af530
>>>>>>>>>> [  198.756079] x29: ffff8000132af530 x28: 0000000000000000
>>>>>>>>>> [  198.756565] x27: 0000000000000001 x26: 0000000000000000
>>>>>>>>>> [  198.757049] x25: ffff0000c20ac000 x24: 0000000000002000
>>>>>>>>>> [  198.757534] x23: ffff0000c20ae5c0 x22: ffff8000132af5d4
>>>>>>>>>> [  198.758018] x21: 0000000000002000 x20: 0000000000000004
>>>>>>>>>> [  198.758502] x19: 0000000000102000 x18: 0000000000000001
>>>>>>>>>> [  198.758987] x17: 0000000000000000 x16: 0000000000000000
>>>>>>>>>> [  198.759472] x15: ffffffffffffffff x14: ffff80001159bcc8
>>>>>>>>>> [  198.759957] x13: 0000000000000000 x12: ffff800011b2c000
>>>>>>>>>> [  198.760441] x11: ffff8000115bf000 x10: ffff800011310018
>>>>>>>>>> [  198.760926] x9 : 00000000fffb9fff x8 : 0000000000000001
>>>>>>>>>> [  198.761410] x7 : 0000000000000000 x6 : ffff0000f7492548
>>>>>>>>>> [  198.761894] x5 : 0000000000000001 x4 : ffff0000f7492548
>>>>>>>>>> [  198.762379] x3 : 0000000000000000 x2 : 0000000000c00008
>>>>>>>>>> [  198.762863] x1 : ffff80001dc00008 x0 : ffff80001a102000
>>>>>>>>>> [  198.763348] Call trace:
>>>>>>>>>> [  198.763583]  __raw_readl+0x0/0x8 [pcie_rockchip_host]
>>>>>>>>>> [  198.764057]  pci_bus_read_config_dword+0x88/0xd0
>>>>>>>>>> [  198.764484]  pci_bus_generic_read_dev_vendor_id+0x40/0x1b8
>>>>>>>>>> [  198.764982]  pci_bus_read_dev_vendor_id+0x58/0x88
>>>>>>>>>> [  198.765413]  pci_scan_single_device+0x84/0xf8
>>>>>>>>>> [  198.765812]  pci_scan_slot+0x7c/0x120
>>>>>>>>>> [  198.766149]  pci_scan_child_bus_extend+0x68/0x2dc
>>>>>>>>>> [  198.766579]  pci_scan_bridge_extend+0x350/0x588
>>>>>>>>>> [  198.766992]  pci_scan_child_bus_extend+0x21c/0x2dc
>>>>>>>>>> [  198.767430]  pci_scan_child_bus+0x24/0x30
>>>>>>>>>> [  198.767797]  pci_scan_root_bus_bridge+0xc4/0xd0
>>>>>>>>>> [  198.768215]  rockchip_pcie_probe+0x610/0x74c [pcie_rockchip_host]
>>>>>>>>>> [  198.768770]  platform_drv_probe+0x58/0xa8
>>>>>>>>>> [  198.769139]  really_probe+0xe0/0x318
>>>>>>>>>> [  198.769468]  driver_probe_device+0x5c/0xf0
>>>>>>>>>> [  198.769844]  device_driver_attach+0x74/0x80
>>>>>>>>>> [  198.770227]  __driver_attach+0x64/0xe8
>>>>>>>>>> [  198.770572]  bus_for_each_dev+0x84/0xd8
>>>>>>>>>> [  198.770924]  driver_attach+0x30/0x40
>>>>>>>>>> [  198.771253]  bus_add_driver+0x188/0x1e8
>>>>>>>>>> [  198.771605]  driver_register+0x64/0x110
>>>>>>>>>> [  198.771956]  __platform_driver_register+0x54/0x60
>>>>>>>>>> [  198.772388]  rockchip_pcie_driver_init+0x28/0x10000 [pcie_rockchip_host]
>>>>>>>>>> [  198.772998]  do_one_initcall+0x94/0x390
>>>>>>>>>> [  198.773353]  do_init_module+0x88/0x268
>>>>>>>>>> [  198.773697]  load_module+0x1e18/0x2198
>>>>>>>>>> [  198.774043]  __do_sys_finit_module+0xd0/0xe8
>>>>>>>>>> [  198.774435]  __arm64_sys_finit_module+0x28/0x38
>>>>>>>>>> [  198.774858]  el0_svc_common.constprop.3+0xa4/0x1d8
>>>>>>>>>> [  198.775297]  el0_svc_handler+0x34/0xa0
>>>>>>>>>> [  198.775645]  el0_svc+0x14/0x40
>>>>>>>>>> [  198.775928]  el0_sync_handler+0x118/0x290
>>>>>>>>>> [  198.776295]  el0_sync+0x164/0x180
>>>>>>>>>> [  198.776609] Code: bad PC value
>>>>>>>>>> [  198.776897] ---[ end trace 88fc77651b5e2909 ]---
>>>>>>
>>>>>> _______________________________________________
>>>>>> Linux-rockchip mailing list
>>>>>> Linux-rockchip@lists.infradead.org
>>>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>>>>>
> 
> 
> 

--------------312F4E2138CF17ED87B089BC
Content-Type: text/plain; charset=UTF-8;
 name="0001-WFT-PCI-rockchip-play-game-with-unsupported-request-.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-WFT-PCI-rockchip-play-game-with-unsupported-request-.pa";
 filename*1="tch"

RnJvbSBkYTlkYjQ4NzYxNWMzNjg3YTA4MjNjNTRkOGQwNzkwY2JkNGY3OWEyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBz
LmNvbT4KRGF0ZTogVGh1LCAyMSBOb3YgMjAxOSAwOTo0NToxMiArMDgwMApTdWJqZWN0OiBb
UEFUQ0hdIFdGVDogUENJOiByb2NrY2hpcDogcGxheSBnYW1lIHdpdGggdW5zdXBwb3J0ZWQg
cmVxdWVzdCBmcm9tCiBFUAoKTmF0aXZlIGRlZmVjdCBwcmV2ZW50cyB0aGlzIFJDIGZhciBm
cm9tIHN1cHBvcnRpbmcgYW55IHJlc3BvbnNlCmZyb20gRVAgd2hpY2ggVVIgZmlsZWQgaXMg
c2V0LiBUYWtlIGEgYmlnIGhhbW1lciB0byB0YWtlIG92ZXIKU2Vycm9yIGhhbmRsZXIgYW5k
IHdvcmsgYXJvdW5kIGl0LgoKTWF5YmUgQVRGIGlzIHRoZSByaWdodCBwbGFjZSBpbiB0aGUg
ZnV0dXJlIHRvIGNvdmVyIHRoaXMga2luZApvZiBkZWZlY3QsIGJ1dCBhbGwgcmlnaHQsIGZv
ciBBUk0zMiwgaW14NnFfcGNpZV9hYm9ydF9oYW5kbGVyCmFsbW9zdCBoYW5kbGUgdGhlIHNh
bWUgZGVmZWN0LgoKU2lnbmVkLW9mZi1ieTogU2hhd24gTGluIDxzaGF3bi5saW5Acm9jay1j
aGlwcy5jb20+Ci0tLQogYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9zeXN0ZW1fbWlzYy5oICAg
ICAgICB8ICA1ICstCiBhcmNoL2FybTY0L2tlcm5lbC9lbnRyeS5TICAgICAgICAgICAgICAg
ICAgIHwgODYgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0KIGFyY2gvYXJtNjQvbW0v
ZmF1bHQuYyAgICAgICAgICAgICAgICAgICAgICAgfCA0NCArKysrKysrKysrKysrKy0KIGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yb2NrY2hpcC1ob3N0LmMgfCAxNSArKysrKwog
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJvY2tjaGlwLmggICAgICB8ICA0ICsrCiBk
cml2ZXJzL3BjaS9wcm9iZS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDcgKystCiA2
IGZpbGVzIGNoYW5nZWQsIDEzMiBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3N5c3RlbV9taXNjLmggYi9hcmNo
L2FybTY0L2luY2x1ZGUvYXNtL3N5c3RlbV9taXNjLmgKaW5kZXggMWFiNjNjZi4uYjQ1ZTRl
MSAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9zeXN0ZW1fbWlzYy5oCisr
KyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vc3lzdGVtX21pc2MuaApAQCAtMjgsNyArMjgs
MTAgQEAgdm9pZCBhcm02NF9ub3RpZnlfZGllKGNvbnN0IGNoYXIgKnN0ciwgc3RydWN0IHB0
X3JlZ3MgKnJlZ3MsCiB2b2lkIGhvb2tfZGVidWdfZmF1bHRfY29kZShpbnQgbnIsIGludCAo
KmZuKSh1bnNpZ25lZCBsb25nLCB1bnNpZ25lZCBpbnQsCiAJCQkJCSAgICAgc3RydWN0IHB0
X3JlZ3MgKiksCiAJCQkgICBpbnQgc2lnLCBpbnQgY29kZSwgY29uc3QgY2hhciAqbmFtZSk7
Ci0KK3ZvaWQgaG9va19mYXVsdF9jb2RlKGludCBuciwgaW50ICgqZm4pKHVuc2lnbmVkIGxv
bmcsIHVuc2lnbmVkIGludCwKKwkJCXN0cnVjdCBwdF9yZWdzICopLCBpbnQgc2lnLCBpbnQg
Y29kZSwgY29uc3QgY2hhciAqbmFtZSk7Cit2b2lkICpob29rX3NlcnJvcl9oYW5kbGVyKGlu
dCAoKmZuKSh1bnNpZ25lZCBsb25nLCB1bnNpZ25lZCBpbnQsCisJCSAgICAgICAgc3RydWN0
IHB0X3JlZ3MgKikpOwogc3RydWN0IG1tX3N0cnVjdDsKIGV4dGVybiB2b2lkIF9fc2hvd19y
ZWdzKHN0cnVjdCBwdF9yZWdzICopOwogCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tlcm5l
bC9lbnRyeS5TIGIvYXJjaC9hcm02NC9rZXJuZWwvZW50cnkuUwppbmRleCA1ODNmNzFhLi4z
MjFmOWZmIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2tlcm5lbC9lbnRyeS5TCisrKyBiL2Fy
Y2gvYXJtNjQva2VybmVsL2VudHJ5LlMKQEAgLTQ3MSw3ICs0NzEsNyBAQCBFTlRSWSh2ZWN0
b3JzKQogCWtlcm5lbF92ZW50cnkJMSwgc3luY19pbnZhbGlkCQkJLy8gU3luY2hyb25vdXMg
RUwxdAogCWtlcm5lbF92ZW50cnkJMSwgaXJxX2ludmFsaWQJCQkvLyBJUlEgRUwxdAogCWtl
cm5lbF92ZW50cnkJMSwgZmlxX2ludmFsaWQJCQkvLyBGSVEgRUwxdAotCWtlcm5lbF92ZW50
cnkJMSwgZXJyb3JfaW52YWxpZAkJLy8gRXJyb3IgRUwxdAorCWtlcm5lbF92ZW50cnkgICAx
LCBlcnJvciAgICAgICAgICAgICAgICAvLyBFcnJvciBFTDFoCiAKIAlrZXJuZWxfdmVudHJ5
CTEsIHN5bmMJCQkJLy8gU3luY2hyb25vdXMgRUwxaAogCWtlcm5lbF92ZW50cnkJMSwgaXJx
CQkJCS8vIElSUSBFTDFoCkBAIC01NjIsNiArNTYyLDM2IEBAIGVsMV9zeW5jX2ludmFsaWQ6
CiAJaW52X2VudHJ5IDEsIEJBRF9TWU5DCiBFTkRQUk9DKGVsMV9zeW5jX2ludmFsaWQpCiAK
KyAgICAgICAuYWxpZ24gIDYKK2VsMV9lcnJvcjoKKyAgICAgICBrZXJuZWxfZW50cnkgMQor
ICAgICAgIG1ycyAgICAgeDEsIGVzcl9lbDEgICAgICAgICAgICAgICAgICAgICAvLyByZWFk
IHRoZSBzeW5kcm9tZSByZWdpc3RlcgorICAgICAgIGxzciAgICAgeDI0LCB4MSwgI0VTUl9F
THhfRUNfU0hJRlQgICAgICAvLyBleGNlcHRpb24gY2xhc3MKKyAgICAgICBjbXAgICAgIHgy
NCwgI0VTUl9FTHhfRUNfU0VSUk9SICAgICAgICAgLy8gU0Vycm9yIGV4Y2VwdGlvbiBpbiBF
TDEKKyAgICAgICBiLm5lICAgIGVsMV9lcnJvcl9pbnYKK2VsMV9zZXJyOgorICAgICAgIG1y
cyAgICAgeDAsIGZhcl9lbDEKKyAgICAgICBlbmFibGVfZGJnCisgICAgICAgLy8gcmUtZW5h
YmxlIGludGVycnVwdHMgaWYgdGhleSB3ZXJlIGVuYWJsZWQgaW4gdGhlIGFib3J0ZWQgY29u
dGV4dAorICAgICAgIHRibnogICAgeDIzLCAjNywgMWYgICAgICAgICAgICAgICAgICAgICAv
LyBQU1JfSV9CSVQKKyAgICAgICAvL2VuYWJsZV9pcnEKKyAgICAgICBtc3IgICAgIGRhaWZj
bHIsICMyCisxOgorICAgICAgIG1vdiAgICAgeDIsIHNwICAgICAgICAgICAgICAgICAgICAg
ICAgICAvLyBzdHJ1Y3QgcHRfcmVncworICAgICAgIGJsICAgICAgZG9fc2Vycl9hYm9ydAor
CisgICAgICAgLy8gZGlzYWJsZSBpbnRlcnJ1cHRzIGJlZm9yZSBwdWxsaW5nIHByZXNlcnZl
ZCBkYXRhIG9mZiB0aGUgc3RhY2sKKyAgICAgICAvL2Rpc2FibGVfaXJxCisgICAgICAgbXNy
ICAgICBkYWlmc2V0LCAjMgorICAgICAgIGtlcm5lbF9leGl0IDEKK2VsMV9lcnJvcl9pbnY6
CisgICAgICAgZW5hYmxlX2RiZworICAgICAgIG1vdiAgICAgeDAsIHNwCisgICAgICAgbW92
ICAgICB4MiwgeDEKKyAgICAgICBtb3YgICAgIHgxLCAjQkFEX0VSUk9SCisgICAgICAgYiAg
ICAgICBiYWRfbW9kZQorRU5EUFJPQyhlbDFfZXJyb3IpCisKIGVsMV9pcnFfaW52YWxpZDoK
IAlpbnZfZW50cnkgMSwgQkFEX0lSUQogRU5EUFJPQyhlbDFfaXJxX2ludmFsaWQpCkBAIC02
NjcsNiArNjk3LDcgQEAgZWwwX2lycV9jb21wYXQ6CiAJa2VybmVsX2VudHJ5IDAsIDMyCiAJ
YgllbDBfaXJxX25ha2VkCiAKKyAgICAgICAuYWxpZ24gIDYKIGVsMF9lcnJvcl9jb21wYXQ6
CiAJa2VybmVsX2VudHJ5IDAsIDMyCiAJYgllbDBfZXJyb3JfbmFrZWQKQEAgLTY5NywzMCAr
NzI4LDYgQEAgZWwwX2lycV9uYWtlZDoKIAliCXJldF90b191c2VyCiBFTkRQUk9DKGVsMF9p
cnEpCiAKLWVsMV9lcnJvcjoKLQlrZXJuZWxfZW50cnkgMQotCW1ycwl4MSwgZXNyX2VsMQot
CWdpY19wcmlvX2tlbnRyeV9zZXR1cCB0bXA9eDIKLQllbmFibGVfZGJnCi0JbW92CXgwLCBz
cAotCWJsCWRvX3NlcnJvcgotCWtlcm5lbF9leGl0IDEKLUVORFBST0MoZWwxX2Vycm9yKQot
Ci1lbDBfZXJyb3I6Ci0Ja2VybmVsX2VudHJ5IDAKLWVsMF9lcnJvcl9uYWtlZDoKLQltcnMJ
eDI1LCBlc3JfZWwxCi0JZ2ljX3ByaW9fa2VudHJ5X3NldHVwIHRtcD14MgotCWN0X3VzZXJf
ZXhpdF9pcnFvZmYKLQllbmFibGVfZGJnCi0JbW92CXgwLCBzcAotCW1vdgl4MSwgeDI1Ci0J
YmwJZG9fc2Vycm9yCi0JZW5hYmxlX2RhX2YKLQliCXJldF90b191c2VyCi1FTkRQUk9DKGVs
MF9lcnJvcikKLQogLyoKICAqIE9rLCB3ZSBuZWVkIHRvIGRvIGV4dHJhIHByb2Nlc3Npbmcs
IGVudGVyIHRoZSBzbG93IHBhdGguCiAgKi8KQEAgLTg2NSw2ICs4NzIsMzUgQEAgX19lbnRy
eV90cmFtcF9kYXRhX3N0YXJ0OgogI2VuZGlmIC8qIENPTkZJR19SQU5ET01JWkVfQkFTRSAq
LwogI2VuZGlmIC8qIENPTkZJR19VTk1BUF9LRVJORUxfQVRfRUwwICovCiAKKyAgICAgICAu
YWxpZ24gIDYKK2VsMF9lcnJvcjoKKyAgICAgICBrZXJuZWxfZW50cnkgMAorZWwwX2Vycm9y
X25ha2VkOgorICAgICAgIG1ycyAgICAgeDI1LCBlc3JfZWwxICAgICAgICAgICAgICAgICAg
ICAvLyByZWFkIHRoZSBzeW5kcm9tZSByZWdpc3RlcgorICAgICAgIGxzciAgICAgeDI0LCB4
MjUsICNFU1JfRUx4X0VDX1NISUZUICAgICAvLyBleGNlcHRpb24gY2xhc3MKKyAgICAgICBj
bXAgICAgIHgyNCwgI0VTUl9FTHhfRUNfU0VSUk9SICAgICAgICAgLy8gU0Vycm9yIGV4Y2Vw
dGlvbiBpbiBFTDAKKyAgICAgICBiLm5lICAgIGVsMF9lcnJvcl9pbnYKK2VsMF9zZXJyOgor
ICAgICAgIG1ycyAgICAgeDI2LCBmYXJfZWwxCisgICAgICAgLy8gZW5hYmxlIGludGVycnVw
dHMgYmVmb3JlIGNhbGxpbmcgdGhlIG1haW4gaGFuZGxlcgorICAgICAgIG1zciAgICAgZGFp
ZmNsciwgIyg4IHwgMikKKyAgICAgICAvL2N0X3VzZXJfZXhpdAorI2lmZGVmIENPTkZJR19D
T05URVhUX1RSQUNLSU5HCisgICAgICAgICAgICAgICBibCAgICAgIGNvbnRleHRfdHJhY2tp
bmdfdXNlcl9leGl0CisjZW5kaWYKKyAgICAgICBiaWMgICAgIHgwLCB4MjYsICMoMHhmZiA8
PCA1NikKKyAgICAgICBtb3YgICAgIHgxLCB4MjUKKyAgICAgICBtb3YgICAgIHgyLCBzcAor
ICAgICAgIGJsICAgICAgZG9fc2Vycl9hYm9ydAorICAgICAgIGIgICAgICAgcmV0X3RvX3Vz
ZXIKK2VsMF9lcnJvcl9pbnY6CisgICAgICAgZW5hYmxlX2RiZworICAgICAgIG1vdiAgICAg
eDAsIHNwCisgICAgICAgbW92ICAgICB4MSwgI0JBRF9FUlJPUgorICAgICAgIG1vdiAgICAg
eDIsIHgyNQorICAgICAgIGIgICAgICAgYmFkX21vZGUKK0VORFBST0MoZWwwX2Vycm9yKQor
CiAvKgogICogUmVnaXN0ZXIgc3dpdGNoIGZvciBBQXJjaDY0LiBUaGUgY2FsbGVlLXNhdmVk
IHJlZ2lzdGVycyBuZWVkIHRvIGJlIHNhdmVkCiAgKiBhbmQgcmVzdG9yZWQuIE9uIGVudHJ5
OgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9mYXVsdC5jIGIvYXJjaC9hcm02NC9tbS9m
YXVsdC5jCmluZGV4IDA3N2IwMmEuLjVhZGI3ZWYgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQv
bW0vZmF1bHQuYworKysgYi9hcmNoL2FybTY0L21tL2ZhdWx0LmMKQEAgLTQ4LDcgKzQ4LDcg
QEAgc3RydWN0IGZhdWx0X2luZm8gewogCWNvbnN0IGNoYXIgKm5hbWU7CiB9OwogCi1zdGF0
aWMgY29uc3Qgc3RydWN0IGZhdWx0X2luZm8gZmF1bHRfaW5mb1tdOworc3RhdGljIHN0cnVj
dCBmYXVsdF9pbmZvIGZhdWx0X2luZm9bXSBfX3JvX2FmdGVyX2luaXQ7CiBzdGF0aWMgc3Ry
dWN0IGZhdWx0X2luZm8gZGVidWdfZmF1bHRfaW5mb1tdOwogCiBzdGF0aWMgaW5saW5lIGNv
bnN0IHN0cnVjdCBmYXVsdF9pbmZvICplc3JfdG9fZmF1bHRfaW5mbyh1bnNpZ25lZCBpbnQg
ZXNyKQpAQCAtNjYwLDcgKzY2MCw3IEBAIHN0YXRpYyBpbnQgZG9fc2VhKHVuc2lnbmVkIGxv
bmcgYWRkciwgdW5zaWduZWQgaW50IGVzciwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCiAJcmV0
dXJuIDA7CiB9CiAKLXN0YXRpYyBjb25zdCBzdHJ1Y3QgZmF1bHRfaW5mbyBmYXVsdF9pbmZv
W10gPSB7CitzdGF0aWMgc3RydWN0IGZhdWx0X2luZm8gZmF1bHRfaW5mb1tdIF9fcm9fYWZ0
ZXJfaW5pdCA9IHsKIAl7IGRvX2JhZCwJCVNJR0tJTEwsIFNJX0tFUk5FTCwJInR0YnIgYWRk
cmVzcyBzaXplIGZhdWx0Igl9LAogCXsgZG9fYmFkLAkJU0lHS0lMTCwgU0lfS0VSTkVMLAki
bGV2ZWwgMSBhZGRyZXNzIHNpemUgZmF1bHQiCX0sCiAJeyBkb19iYWQsCQlTSUdLSUxMLCBT
SV9LRVJORUwsCSJsZXZlbCAyIGFkZHJlc3Mgc2l6ZSBmYXVsdCIJfSwKQEAgLTcyNyw2ICs3
MjcsNDYgQEAgc3RhdGljIGludCBkb19zZWEodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25l
ZCBpbnQgZXNyLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKIAl7IGRvX2JhZCwJCVNJR0tJTEws
IFNJX0tFUk5FTCwJInVua25vd24gNjMiCQkJfSwKIH07CiAKK3ZvaWQgX19pbml0IGhvb2tf
ZmF1bHRfY29kZShpbnQgbnIsCisgICAgICAgICAgICAgICAgICAgICAgIGludCAoKmZuKSh1
bnNpZ25lZCBsb25nLCB1bnNpZ25lZCBpbnQsIHN0cnVjdCBwdF9yZWdzICopLAorICAgICAg
ICAgICAgICAgICAgICAgICBpbnQgc2lnLCBpbnQgY29kZSwgY29uc3QgY2hhciAqbmFtZSkK
K3sKKyAgICAgICBCVUdfT04obnIgPCAwIHx8IG5yID49IEFSUkFZX1NJWkUoZmF1bHRfaW5m
bykpOworCisgICAgICAgZmF1bHRfaW5mb1tucl0uZm4gICAgICAgPSBmbjsKKyAgICAgICBm
YXVsdF9pbmZvW25yXS5zaWcgICAgICA9IHNpZzsKKyAgICAgICBmYXVsdF9pbmZvW25yXS5j
b2RlICAgICA9IGNvZGU7CisgICAgICAgZmF1bHRfaW5mb1tucl0ubmFtZSAgICAgPSBuYW1l
OworfQorCitzdGF0aWMgaW50ICgqc2Vycm9yX2hhbmRsZXIpKHVuc2lnbmVkIGxvbmcsIHVu
c2lnbmVkIGludCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcHRfcmVn
cyAqKSBfX3JvX2FmdGVyX2luaXQ7CisKK3ZvaWQgKl9faW5pdCBob29rX3NlcnJvcl9oYW5k
bGVyKGludCAoKmZuKSh1bnNpZ25lZCBsb25nLCB1bnNpZ25lZCBpbnQsCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBwdF9yZWdzICopKQoreworICAgICAgIHZv
aWQgKnJldCA9IHNlcnJvcl9oYW5kbGVyOworCisgICAgICAgc2Vycm9yX2hhbmRsZXIgPSBm
bjsKKyAgICAgICByZXR1cm4gcmV0OworfQorCithc21saW5rYWdlIHZvaWQgIGRvX3NlcnJf
YWJvcnQodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBpbnQgZXNyLAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBwdF9yZWdzICpyZWdzKQor
eworCWNvbnN0IHN0cnVjdCBmYXVsdF9pbmZvICppbmY7CisKKwlpbmYgPSBlc3JfdG9fZmF1
bHRfaW5mbyhlc3IpOworICAgICAgIGlmIChzZXJyb3JfaGFuZGxlcikKKyAgICAgICAgICAg
ICAgIGlmICghc2Vycm9yX2hhbmRsZXIoYWRkciwgZXNyLCByZWdzKSkKKyAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuOworCisgICAgICAgcHJfYWxlcnQoIlVuaGFuZGxlZCBTRXJy
b3I6ICgweCUwOHgpIGF0IDB4JTAxNmx4XG4iLCBlc3IsIGFkZHIpOworICAgICAgIF9fc2hv
d19yZWdzKHJlZ3MpOworCisgICAgICAgYXJtNjRfbm90aWZ5X2RpZShpbmYtPm5hbWUsIHJl
Z3MsIGluZi0+c2lnLCBpbmYtPmNvZGUsICh2b2lkIF9fdXNlciAqKWFkZHIsIGVzcik7Cit9
CisKIHZvaWQgZG9fbWVtX2Fib3J0KHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgaW50
IGVzciwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCiB7CiAJY29uc3Qgc3RydWN0IGZhdWx0X2lu
Zm8gKmluZiA9IGVzcl90b19mYXVsdF9pbmZvKGVzcik7CmRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaWUtcm9ja2NoaXAtaG9zdC5jIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wY2llLXJvY2tjaGlwLWhvc3QuYwppbmRleCBlZTgzZjg0Li41YzU1NzhiIDEw
MDY0NAotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtcm9ja2NoaXAtaG9zdC5j
CisrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yb2NrY2hpcC1ob3N0LmMKQEAg
LTk1OCw2ICs5NTgsMTcgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCByb2NrY2hpcF9w
Y2llX3Jlc3VtZV9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJcmV0dXJuIGVycjsKIH0K
IAorI2lmZGVmIENPTkZJR19BUk02NAorc3RhdGljIGludCAoKnNlcnJvcl9jaGFpbikodW5z
aWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBpbnQgZXNyLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBwdF9yZWdzICpyZWdzKTsKK3N0YXRpYyBpbnQgZG9fcm9j
a2NoaXBfcGNpZV9zZXJyb3IodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBpbnQgZXNy
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBwdF9yZWdzICpyZWdz
KQoreworICAgICAgIHByaW50aygiJXM6aGV5IVxuIiwgX19mdW5jX18pOworICAgICAgIHJl
dHVybiAwOworfQorI2VuZGlmCisKIHN0YXRpYyBpbnQgcm9ja2NoaXBfcGNpZV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogewogCXN0cnVjdCByb2NrY2hpcF9wY2ll
ICpyb2NrY2hpcDsKQEAgLTEwMjgsNiArMTAzOSwxMCBAQCBzdGF0aWMgaW50IHJvY2tjaGlw
X3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlicmlkZ2UtPm1h
cF9pcnEgPSBvZl9pcnFfcGFyc2VfYW5kX21hcF9wY2k7CiAJYnJpZGdlLT5zd2l6emxlX2ly
cSA9IHBjaV9jb21tb25fc3dpenpsZTsKIAorICAgICAgICNpZmRlZiBDT05GSUdfQVJNNjQK
KyAgICAgICBzZXJyb3JfY2hhaW4gPSBob29rX3NlcnJvcl9oYW5kbGVyKGRvX3JvY2tjaGlw
X3BjaWVfc2Vycm9yKTsKKyAgICAgICAjZW5kaWYKKwogCWVyciA9IHBjaV9zY2FuX3Jvb3Rf
YnVzX2JyaWRnZShicmlkZ2UpOwogCWlmIChlcnIgPCAwKQogCQlnb3RvIGVycl9yZW1vdmVf
aXJxX2RvbWFpbjsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1y
b2NrY2hpcC5oIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJvY2tjaGlwLmgKaW5k
ZXggZDkwZGZiMy4uYWEwODI5YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2llLXJvY2tjaGlwLmgKKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJv
Y2tjaGlwLmgKQEAgLTEzLDYgKzEzLDEwIEBACiAKICNpbmNsdWRlIDxsaW51eC9rZXJuZWwu
aD4KICNpbmNsdWRlIDxsaW51eC9wY2kuaD4KKyNpZmRlZiBDT05GSUdfQVJNNjQKKyNpbmNs
dWRlIDxhc20vc2lnbmFsLmg+CisjaW5jbHVkZSA8YXNtL3N5c3RlbV9taXNjLmg+CisjZW5k
aWYKIAogLyoKICAqIFRoZSB1cHBlciAxNiBiaXRzIG9mIFBDSUVfQ0xJRU5UX0NPTkZJRyBh
cmUgYSB3cml0ZSBtYXNrIGZvciB0aGUgbG93ZXIgMTYKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL3Byb2JlLmMgYi9kcml2ZXJzL3BjaS9wcm9iZS5jCmluZGV4IDUxMmNiNDMuLjBkMDRi
YzUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL3Byb2JlLmMKKysrIGIvZHJpdmVycy9wY2kv
cHJvYmUuYwpAQCAtMjI1NCw3ICsyMjU0LDEyIEBAIGJvb2wgcGNpX2J1c19yZWFkX2Rldl92
ZW5kb3JfaWQoc3RydWN0IHBjaV9idXMgKmJ1cywgaW50IGRldmZuLCB1MzIgKmwsCiAJICAg
IGJyaWRnZS0+ZGV2aWNlID09IDB4ODBiNSkKIAkJcmV0dXJuIHBjaV9pZHRfYnVzX3F1aXJr
KGJ1cywgZGV2Zm4sIGwsIHRpbWVvdXQpOwogI2VuZGlmCi0KKwkvKgorCSAqIFNvbWUgYnJv
a2VuIHN3aXRjaGVzIG5lZWQgUkMgd3JpdGUgc29tZXRoaW5nIHRvIGl0cyBSTyB2ZW5kZXIg
SUQsCisJICogb3RoZXJ3aXNlIGl0IGtpY2sgYmFjayAweDAgZm9yIGFueSBDRkcgcmVhZC4g
SSBzZWUgaG93IHdpbmRvd3MgKworCSAqIEJJT1MgZW51bWVyYXRlIGl0IGZyb20gYW5hbHl6
ZXIuLi4uIE5lZSBwcm9wZXIgcXVpcmtzIGhlbHAgaGVyZT8KKwkgKiAqLworCXBjaV9idXNf
d3JpdGVfY29uZmlnX2R3b3JkKGJ1cywgZGV2Zm4sIFBDSV9WRU5ET1JfSUQsIDB4MDAyNDAw
MDApOwogCXJldHVybiBwY2lfYnVzX2dlbmVyaWNfcmVhZF9kZXZfdmVuZG9yX2lkKGJ1cywg
ZGV2Zm4sIGwsIHRpbWVvdXQpOwogfQogRVhQT1JUX1NZTUJPTChwY2lfYnVzX3JlYWRfZGV2
X3ZlbmRvcl9pZCk7Ci0tIAoxLjkuMQoK
--------------312F4E2138CF17ED87B089BC--


