Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1260830299E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 19:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbhAYSJb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 13:09:31 -0500
Received: from foss.arm.com ([217.140.110.172]:54640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731325AbhAYSJR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 13:09:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E93A1FB;
        Mon, 25 Jan 2021 10:08:31 -0800 (PST)
Received: from [10.57.46.25] (unknown [10.57.46.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51D403F66E;
        Mon, 25 Jan 2021 10:08:29 -0800 (PST)
Subject: Re: [RFC PATCH 1/3] PCI: rockchip: provide workaround for bus scan
 crash with optional delay
To:     =?UTF-8?B?SmFyaSBIw6Rtw6Rsw6RpbmVu?= <nuumiofi@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?Q?Oskari_Lemmel=c3=a4?= <oskari@lemmela.net>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20201231125214.25733-2-nuumiofi@gmail.com>
 <20210101173744.GA921848@bjorn-Precision-5520>
 <CA+_S-OqAE5xoV=DFGJ=oOLrdfHEUVQ2d0tSyJ2Cksp5DGmAc7g@mail.gmail.com>
 <CA+_S-Orc8EXHRexYVMfvQ0KSL2HBzWA2xhsPuAqGD7-syjYgrg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f7153e3b-b811-fb46-7cf3-eeee3f947db8@arm.com>
Date:   Mon, 25 Jan 2021 18:08:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CA+_S-Orc8EXHRexYVMfvQ0KSL2HBzWA2xhsPuAqGD7-syjYgrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-01-24 06:39, Jari Hämäläinen wrote:
> On Sat, Jan 2, 2021 at 3:43 PM Jari Hämäläinen <nuumiofi@gmail.com> wrote:
>>
>> On Fri, Jan 1, 2021 at 7:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>
>>> On Thu, Dec 31, 2020 at 02:52:12PM +0200, Jari Hämäläinen wrote:
>>>> Some PCIe devices cause Rockchip PCIe controller to crash in bus scan.
>>>> Crash may be avoided by delaying bus scan by time given from command line
>>>> or from device tree. Needed amount of delay varies from device to device.
>>>> Delay doesn't have to be exact. It just has to be long enough.
>>>
>>> Is this a standard post-reset delay that the rockchip driver is
>>> missing?  Maybe compare with other drivers to see if rockchip is
>>> missing something.
>>>
>>> Is this an erratum in the Rockchip IP?  If so, we should have a
>>> specific description and a citation for it, and a workaround could be
>>> done automatically without DT or command-line switches.
>>
>> Thanks for your reply!
>>
>> This patch was not based on Rockchip erratum or other documentation. It was
>> found by a lucky shot when trying to get Rockchip PCIe working with
>> these devices. I'm sorry for not mentioning that in the first place. In
>> that sense "a hack" would be a better description than "workaround".
>>
>> I'll look at other drivers and see if I can spot anything missing from
>> Rockchip. Designware driver seems like a good place to start. I'm newbie in
>> kernel hacking and even more so with PCIe so pointers are welcome.
>>
> 
> I'm sorry it took quite a while for me to get back to this. Rockchip driver
> is missing explicit delays for keeping PERST asserted and after deasserting
> PERST. It only has the amount of delay caused by code executed between
> PERST assert, deassert and bus scan. I was also unable to find explicit
> delays from other drivers that would be long enough to fix this problem in
> Rockchip driver.
> 
> Some drivers keep PERST asserted for a minimum time and refer to PCIe Card
> Electromechanical Specification's minimum time once REFCLK is stable (100
> us, example in [1]) or minimum time once power is stable (100 ms, example
> in [2]). Some add delay between deassert and link training referring to PCI
> Express Base Specification (100ms, example in [3][4]). I guess these delays
> could be added to Rockchip driver but being too short they don't help with
> the issue. Slow link training could also add some delay before bus scan.
> With RockPro64 training seemed to take about 75 ms.
> 
> PCIe specification seems to be restricted to PCI-SIG members so I don't
> have access to it (or the official version of it and I don't know if
> referencing unofficial ones is allowed here). At least I got a document [5]
> from Oskari referencing the specification and saying:
> 
>    System software must allow 1.0s before it can determine that
>    configuration space accesses have failed (p406 [11]), i.e., an end-point
>    can issue a PCIe retry for up to 1.0s.
> 
> If that is applicable here it's at least very close to maximum delay of my
> observations (1050 ms). If that delay is added to 100ms delay after PERST
> deassert then it would be enough at least with my system. Maybe Rockchip
> controller just doesn't handle retry correctly in this case. RK3399 TRM [6]
> doesn't say anything useful about PCIe so it's hard to say if any
> configuration is missing from the driver regarding this. Dumping known
> registers before and after the delay I added didn't reveal anything to me.

FWIW I think this remains the interesting part. It's already well known 
that RK3399 mishandles at least some unsuccessful completions by sending 
back an external abort (e.g. [1], [2]) - if it does that for UR, it 
seems possible that it might do so for CRS as well. The specific 
behaviour of crashing vs., say, simply failing to detect the endpoint is 
definitely an unfortunate quirk of RK3399, but either way it would be 
good to nail down why we can't get a successful completion response in 
the first place.

Robin.

[1] 
https://lore.kernel.org/linux-rockchip/4d03dd8c-14f9-d1ef-6fd2-095423be3dd3@web.de/
[2] 
https://lore.kernel.org/linux-pci/CAMdYzYoTwjKz4EN8PtD5pZfu3+SX+68JL+dfvmCrSnLL=K6Few@mail.gmail.com/

>>>> The following lists few problematic PCIe devices with delays needed for
>>>> stable bus scan surviving 100 sequential reboots in test loop executed on
>>>> RockPro64 (RK3399 single-board computer):
>>>> - LSI 9201-8i         / SAS2008 chipset [1000:0072]: 725 ms
>>>> - LSI 9302-8i         / SAS3008 chipset [1000:0097]: 575 ms (1)
>>>> - HP H220             / SAS2308 chipset [1000:0087]: 800 ms (2)
>>>> - IBM ServeRAID M5110 / SAS2208 chipset [1000:005b]: 1050 ms (3)
>>>>
>>>>    1) mpt3sas module has soft lockup bug on shutdown but device is usable
>>>>    2) has infrequent crash on mpt3sas module load (2 of 662 reboots in all
>>>>       test sessions with this device crashed on module load)
>>>>    3) megaraid_sas module crashes on load so device remains unusable
>>>>       (bus scan tested with module being blacklisted)
>>>>
>>>> Side effect of delay, if set, is that it slows down system startup by the
>>>> amount of delay.
>>>>
>>>> Log excerpt showing a crash happening always on unpatched kernel with
>>>> problematic PCIe devices listed above rendering them unusable:
>>>
>>> It doesn't seem likely that the devices above are broken since we
>>> don't have problems with them on other systems.  More likely to be
>>> some Rockchip-specific thing, and the devices above are operating
>>> within spec (possibly using more of the allowed post-reset time than
>>> most devices).
>>
>> This seems to be Rockchip-specific indeed. All devices above worked fine on
>> x86-based setup.
>>
>>>> [    1.240649] SError Interrupt on CPU5, code 0xbf000002 -- SError
>>>
>>> We really should know more about what the specific error is.  Most
>>> errors on PCIe should be recoverable and they can happen at any time,
>>> not just at boot-time.
>>>
>>> This patch adds a boot-time delay.  At run-time, if we power-cycle or
>>> reset a device and re-enumerate the bus, we would likely see the same
>>> problem and this patch wouldn't help.
>>
>> I will try to dig deeper into details of this error. Maybe megaraid_sas
>> driver crashing on module load is a manifestation of same problem and could
>> offer a hint or at least another viewpoint to what goes on.
>>
> 
> If I've understood correctly "code 0xbf000002" in the crash means "AXI
> slave error" which in turn doesn't tell me anything. Limiting execution to
> RockPro little cores with "maxcpus=4" parameter makes it crash with
> synchronous abort:
> 
>    [    1.352923] Internal error: synchronous external abort: 96000210 [#1] SMP
>    [    1.353585] Modules linked in:
>    [    1.353892] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
> 5.11.0-rc4-nuumio-rkpcie2-00001-g331febe1a61 #1
>    [    1.354789] Hardware name: Pine64 RockPro64 v2.0 (DT)
>    [    1.355281] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
>    [    1.355869] pc : rockchip_pcie_rd_conf+0x154/0x238
>    [    1.356354] lr : rockchip_pcie_rd_conf+0x194/0x238
>    [    1.356828] sp : ffff80001198b840
>    [    1.357154] x29: ffff80001198b840 x28: 0000000000000000
>    [    1.357682] x27: 0000000000000000 x26: 0000000000000000
>    [    1.358209] x25: ffff80001198b974 x24: 0000000000000000
>    [    1.358736] x23: 0000000000000000 x22: ffff0000f180e800
>    [    1.359262] x21: 0000000000000004 x20: ffff80001198b8c4
>    [    1.359789] x19: ffff800014100000 x18: ffffffffffffffff
>    [    1.360316] x17: 00000000999d7c5f x16: 0000000088cabd3a
>    [    1.360844] x15: ffff8000116d9908 x14: 00000000000000de
>    [    1.361369] x13: ffff80001198b5b0 x12: 00000000ffffffea
>    [    1.361895] x11: ffff8000117d36f8 x10: ffff8000117a36b8
>    [    1.362421] x9 : 0000000001001d87 x8 : 000000000000ea60
>    [    1.362948] x7 : ffff80001198b974 x6 : 0000000000000001
>    [    1.363474] x5 : 0000000000000003 x4 : 0000000000c00008
>    [    1.364001] x3 : ffff800017000000 x2 : 000000000080000a
>    [    1.364527] x1 : ffff800017c00008 x0 : ffff800017c0000c
>    [    1.365055] Call trace:
>    [    1.365298]  rockchip_pcie_rd_conf+0x154/0x238
>    [    1.365741]  pci_bus_read_config_dword+0xa4/0x150
>    [    1.366211]  pci_bus_generic_read_dev_vendor_id+0x30/0x1b0
>    [    1.366758]  pci_bus_read_dev_vendor_id+0x4c/0x78
>    [    1.367228]  pci_scan_single_device+0x80/0x100
>    [    1.367674]  pci_scan_slot+0x38/0x130
>    [    1.368044]  pci_scan_child_bus_extend+0x58/0x348
>    [    1.368513]  pci_scan_bridge_extend+0x304/0x5a0
>    [    1.368965]  pci_scan_child_bus_extend+0x20c/0x348
>    [    1.369443]  pci_scan_root_bus_bridge+0x64/0xf0
>    [    1.369894]  pci_host_probe+0x18/0xc8
>    [    1.370264]  rockchip_pcie_probe+0x4cc/0x4f0
>    [    1.370689]  platform_probe+0x68/0xe0
>    [    1.371057]  really_probe+0x29c/0x4f8
>    [    1.371427]  driver_probe_device+0xfc/0x168
>    [    1.371847]  device_driver_attach+0x74/0x80
>    [    1.372268]  __driver_attach+0xb8/0x168
>    [    1.372654]  bus_for_each_dev+0x7c/0xd8
>    [    1.373038]  driver_attach+0x24/0x30
>    [    1.373399]  bus_add_driver+0x15c/0x240
>    [    1.373784]  driver_register+0x64/0x120
>    [    1.374167]  __platform_driver_register+0x28/0x38
>    [    1.374633]  rockchip_pcie_driver_init+0x1c/0x28
>    [    1.375093]  do_one_initcall+0x60/0x1d8
>    [    1.375478]  kernel_init_freeable+0x244/0x2b0
>    [    1.375914]  kernel_init+0x14/0x118
>    [    1.376268]  ret_from_fork+0x10/0x30
>    [    1.376635] Code: b9000280 52800005 f9400bb3 17ffffd3 (b9400273)
>    [    1.377248] ---[ end trace c049db2b182c197e ]---
> 
>  From that decodecode gives:
> 
>    Code: b9000280 52800005 f9400bb3 17ffffd3 (b9400273)
>    All code
>    ========
>      0:   b9000280        str     w0, [x20]
>      4:   52800005        mov     w5, #0x0                        // #0
>      8:   f9400bb3        ldr     x19, [x29, #16]
>      c:   17ffffd3        b       0xffffffffffffff58
>      10:*  b9400273        ldr     w19, [x19]              <-- trapping
> instruction
> 
>    Code starting with the faulting instruction
>    ===========================================
>      0:   b9400273        ldr     w19, [x19]
> 
> Not being very familiar how these things work I'd guess that's reading from
> remapped PCIe registers.
> 
> I also tried probing PCIe in Uboot and it crashes in similiar way and the
> same bus scan delay workaround works there too. Here's the uboot crash for
> reference:
> 
>    dm_pci_hose_probe_bus: bus = 1/pci_0:0.0
>    pci_uclass_pre_probe, bus=1/pci_0:0.0, parent=pcie@f8000000
>    pci_uclass_post_probe: probing bus 1
>    "Synchronous Abort" handler, esr 0x96000210
>    elr: 000000000022e580 lr : 000000000022e51c (reloc)
>    elr: 00000000f3f6e580 lr : 00000000f3f6e51c
>    x0 : 00000000f8000000 x1 : 0000000000000001
>    x2 : 0000000000000000 x3 : 0000000000100000
>    x4 : 00000000f1f4e6a0 x5 : 0000000000100000
>    x6 : 0000000000000001 x7 : 0000000000000000
>    x8 : 0000000000000000 x9 : 0000000000000008
>    x10: 00000000ffffffd8 x11: 000000000000000d
>    x12: 0000000000000006 x13: 000000000001869f
>    x14: 00000000f1f28150 x15: 0000000000000002
>    x16: 00000000f3f6e4e0 x17: 000000000000001f
>    x18: 00000000f1f37dd0 x19: 00000000f1f27bc0
>    x20: 0000000000000001 x21: 0000000000000000
>    x22: 0000000000010000 x23: 00000000f3fe33b8
>    x24: 0000000000000000 x25: 0000000000010000
>    x26: 00000000f3fc9000 x27: 0000000000000000
>    x28: 00000000f1f4bf60 x29: 00000000f1f27b10
> 
>    Code: 540000c1 350000a5 93407c05 f9400080 (b86068a0)
>    Resetting CPU ...
> 
> Decodecode from Uboot crash:
> 
>    Code: 540000c1 350000a5 93407c05 f9400080 (b86068a0)
>    All code
>    ========
>      0:   540000c1        b.ne    0x18  // b.any
>      4:   350000a5        cbnz    w5, 0x18
>      8:   93407c05        sxtw    x5, w0
>      c:   f9400080        ldr     x0, [x4]
>      10:*  b86068a0        ldr     w0, [x5, x0]            <-- trapping
> instruction
> 
>    Code starting with the faulting instruction
>    ===========================================
>      0:   b86068a0        ldr     w0, [x5, x0]
> 
> If I'm reading it right that's a read from PCIe registers (0xf8000000 +
> 0x00100000). Also, with Uboot and kernel hacked so that Uboot probe just
> initializes PCIe (including PERST reset) but doesn't do bus scan, and
> kernel does not do PERST reset, these cards seem to work. I'd guess this is
> just because there's enough time before kernel does bus scan after the
> reset.
> 
> In addition to all this I also checked the megasas_raid I mentioned in the
> commit log in case it's related. I can't tell if the root cause is the same
> (except maybe RK3399 PCIe controller being just bad). After enabling extra
> debug with ‘dyndbg="file drivers/pci/* +p; drivers/phy/rockchip/* +p' I
> first get this a lot:
> 
>    [   18.068402] rockchip-pcie f8000000.pcie: correctable error
> interrupt received
>    [   18.108403] rockchip-pcie f8000000.pcie: correctable error
> interrupt received
>    [   18.148402] rockchip-pcie f8000000.pcie: correctable error
> interrupt received
> 
> And then:
> 
>    [   32.518481] rockchip-pcie f8000000.pcie: correctable error
> interrupt received
>    [   32.558417] rockchip-pcie f8000000.pcie: correctable error
> interrupt received
>    [   32.608369] Internal error: synchronous external abort: 96000210 [#1] SMP
>    [   32.608395] rockchip-pcie f8000000.pcie: no fatal error interrupt received
>    [   32.608992] Modules linked in: megaraid_sas(+) rockchipdrm
> analogix_dp dw_hdmi cec dw_mipi_dsi drm_kms_helper syscopyarea
> sysfillrect sysimgblt fb_sys_fops drm drm_panel_orientation_quirks
>    [   32.611158] CPU: 2 PID: 305 Comm: systemd-udevd Not tainted
> 5.11.0-rc4-nuumio-rkpcie2-00001-g331febe1a61 #1
>    [   32.612028] Hardware name: Pine64 RockPro64 v2.0 (DT)
>    [   32.612482] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>    [   32.613022] pc : megasas_readl+0x14/0x68 [megaraid_sas]
>    [   32.613545] lr : megasas_read_fw_status_reg_fusion+0x18/0x28 [megaraid_sas]
>    [   32.614203] sp : ffff800011ecb700
>    [   32.614503] x29: ffff800011ecb700 x28: ffff00000564c000
>    [   32.614987] x27: ffff800008f2e000 x26: ffff0000056d1870
>    [   32.615470] x25: 00000000f0000000 x24: 00000000d1b71759
>    [   32.615954] x23: 0000000000001388 x22: ffff800011db7000
>    [   32.616437] x21: 000000000002bf20 x20: ffff0000056d0870
>    [   32.616920] x19: 0000000000000014 x18: ffffffffffffffff
>    [   32.617403] x17: 0000000000000000 x16: 0000000000000000
>    [   32.617886] x15: 0000000000000000 x14: ffff000000681c80
>    [   32.618369] x13: ffff8000e62a8000 x12: 0000000034d4d91d
>    [   32.618852] x11: 0000000000000000 x10: 00000000000009e0
>    [   32.619335] x9 : ffff800011ecb590 x8 : ffff0000f778ac40
>    [   32.619818] x7 : 0000000000000400 x6 : 0000000000000001
>    [   32.620301] x5 : 0000000000000000 x4 : 0000000000000002
>    [   32.620782] x3 : 0000000000000000 x2 : fee376ea43401400
>    [   32.621265] x1 : ffff8000119680b0 x0 : 0000000000000002
>    [   32.621749] Call trace:
>    [   32.621974]  megasas_readl+0x14/0x68 [megaraid_sas]
>    [   32.622450]  wait_and_poll+0x8c/0xf0 [megaraid_sas]
>    [   32.622926]  megasas_issue_polled+0x6c/0x88 [megaraid_sas]
>    [   32.623454]  megasas_get_ctrl_info+0xb0/0x3c8 [megaraid_sas]
>    [   32.623997]  megasas_init_adapter_fusion+0x290/0x678 [megaraid_sas]
>    [   32.624594]  megasas_init_fw+0x4cc/0x1260 [megaraid_sas]
>    [   32.625107]  megasas_probe_one+0x1b8/0x638 [megaraid_sas]
>    [   32.625629]  pci_device_probe+0xbc/0x178
>    [   32.625998]  really_probe+0x29c/0x4f8
>    [   32.626340]  driver_probe_device+0xfc/0x168
>    [   32.626725]  device_driver_attach+0x74/0x80
>    [   32.627110]  __driver_attach+0xb8/0x168
>    [   32.627463]  bus_for_each_dev+0x7c/0xd8
>    [   32.627817]  driver_attach+0x24/0x30
>    [   32.628148]  bus_add_driver+0x15c/0x240
>    [   32.628502]  driver_register+0x64/0x120
>    [   32.628852]  __pci_register_driver+0x44/0x50
>    [   32.629243]  megasas_init+0xf0/0x1000 [megaraid_sas]
>    [   32.629727]  do_one_initcall+0x60/0x1d8
>    [   32.630081]  do_init_module+0x58/0x1f0
>    [   32.630427]  load_module+0x16c0/0x1c18
>    [   32.630772]  __do_sys_finit_module+0xc0/0x128
>    [   32.631168]  __arm64_sys_finit_module+0x20/0x30
>    [   32.631579]  el0_svc_common.constprop.3+0x6c/0x190
>    [   32.632018]  do_el0_svc+0x24/0x90
>    [   32.632326]  el0_svc+0x14/0x20
>    [   32.632611]  el0_sync_handler+0x90/0xb8
>    [   32.632963]  el0_sync+0x158/0x180
>    [   32.633275] Code: d503233f 39760000 7100141f 54000100 (b9400020)
>    [   32.633823] ---[ end trace 3aeff55e34e4d777 ]---
> 
> Decodecode:
> 
>    Code: d503233f 39760000 7100141f 54000100 (b9400020)
>    All code
>    ========
>      0:   d503233f        paciasp
>      4:   39760000        ldrb    w0, [x0, #3456]
>      8:   7100141f        cmp     w0, #0x5
>      c:   54000100        b.eq    0x2c  // b.none
>      10:*  b9400020        ldr     w0, [x1]                <-- trapping
> instruction
> 
>    Code starting with the faulting instruction
>    ===========================================
>      0:   b9400020        ldr     w0, [x1]
> 
> That "rockchip-pcie f8000000.pcie: no fatal error interrupt received" from
> Rockchip driver [7] seems to occur always with this crash. Being a newbie
> with this I can't tell what that means exactly and if the driver should
> react to it. Now it just seems to clear the interrupt but does nothing
> else. Just out of whim I tested if delay in megaraid_sas would help but it
> doesn't.
> 
> There's also an old discussion about this problem where Shawn attached a
> "big hammer" patch that seems to work around this by just ignoring the
> error [8] and that seemed to work too. The patch says in commit log:
> "Native defect prevents this RC far from supporting any response from EP
> which UR filed is set." I take that means Unsupported Request in response
> from the card.
> 
> Any comments about this or more ideas that to try? Taking Shawn's "native
> defect" comment and "big hammer patch" I mentioned above makes me feel that
> there's no pretty way to fix this. Delay could provide a workaround in boot
> if this is just about giving the card time to initialize but any driver
> causing Unsupported Request can still crash later.
> 
> Thanks to Oskari for pointers and ideas what to try.
> 
> [1] https://elixir.bootlin.com/linux/v5.11-rc4/source/drivers/pci/controller/cadence/pci-j721e.c#L420
> [2] https://elixir.bootlin.com/linux/v5.11-rc4/source/drivers/pci/controller/dwc/pcie-tegra194.c#L1302
> [3] https://elixir.bootlin.com/linux/v5.11-rc4/source/drivers/pci/controller/pci-aardvark.c#L256
> [4] https://elixir.bootlin.com/linux/v5.11-rc4/source/drivers/pci/controller/pci-aardvark.c#L334
> [5] https://community.intel.com/cipcp26785/attachments/cipcp26785/programmable-devices/56074/1/cpci_power_on_timing.pdf
> [6] http://opensource.rock-chips.com/images/e/ee/Rockchip_RK3399TRM_V1.4_Part1-20170408.pdf
> [7] https://elixir.bootlin.com/linux/v5.11-rc4/source/drivers/pci/controller/pcie-rockchip-host.c#L494
> [8] https://lore.kernel.org/linux-pci/2a381384-9d47-a7e2-679c-780950cd862d@rock-chips.com/T/#u
> 
> 
> 
>>>> [    1.240653] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.10.2-stable #1
>>>> [    1.240656] Hardware name: Pine64 RockPro64 v2.0 (DT)
>>>> [    1.240659] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
>>>> [    1.240661] pc : rockchip_pcie_rd_conf+0x178/0x268
>>>> [    1.240664] lr : rockchip_pcie_rd_conf+0x1b8/0x268
>>>> [    1.240666] sp : ffff8000119db850
>>>> [    1.240669] x29: ffff8000119db850 x28: 0000000000000000
>>>> [    1.240676] x27: 0000000000000000 x26: 0000000000000000
>>>> [    1.240682] x25: ffff8000119db984 x24: 0000000000000000
>>>> [    1.240688] x23: 0000000000000000 x22: ffff000040ba0b80
>>>> [    1.240694] x21: ffff8000119db8d4 x20: 0000000000000004
>>>> [    1.240700] x19: 0000000000100000 x18: ffffffffffffffff
>>>> [    1.240706] x17: 0000000031cae143 x16: 000000008c75157c
>>>> [    1.240712] x15: ffff800011729908 x14: ffff000040c87a1c
>>>> [    1.240718] x13: ffff000040c87293 x12: 0000000000000038
>>>> [    1.240724] x11: 0000000005f5e0ff x10: 7f7f7f7f7f7f7f7f
>>>> [    1.240729] x9 : 0000000001001d87 x8 : 000000000000ea60
>>>> [    1.240735] x7 : ffff8000119db984 x6 : 0000000000000000
>>>> [    1.240741] x5 : 0000000000000000 x4 : 0000000000c00008
>>>> [    1.240747] x3 : ffff800017000000 x2 : 000000000080000a
>>>> [    1.240753] x1 : 0000000000000000 x0 : ffff800014000000
>>>> [    1.240759] Kernel panic - not syncing: Asynchronous SError Interrupt
>>>> [    1.240763] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.10.2-stable #1
>>>> [    1.240765] Hardware name: Pine64 RockPro64 v2.0 (DT)
>>>> [    1.240768] Call trace:
>>>> [    1.240770]  dump_backtrace+0x0/0x1e8
>>>> [    1.240772]  show_stack+0x18/0x60
>>>> [    1.240775]  dump_stack+0xd8/0x130
>>>> [    1.240777]  panic+0x15c/0x380
>>>> [    1.240779]  add_taint+0x0/0xb0
>>>> [    1.240782]  arm64_serror_panic+0x78/0x88
>>>> [    1.240784]  do_serror+0x3c/0x68
>>>> [    1.240787]  el1_error+0x84/0x104
>>>> [    1.240789]  rockchip_pcie_rd_conf+0x178/0x268
>>>> [    1.240791]  pci_bus_read_config_dword+0xa4/0x150
>>>> [    1.240794]  pci_bus_generic_read_dev_vendor_id+0x30/0x1b0
>>>> [    1.240797]  pci_bus_read_dev_vendor_id+0x4c/0x78
>>>> [    1.240800]  pci_scan_single_device+0x80/0x100
>>>> [    1.240802]  pci_scan_slot+0x38/0x130
>>>> [    1.240805]  pci_scan_child_bus_extend+0x58/0x348
>>>> [    1.240807]  pci_scan_bridge_extend+0x304/0x5a0
>>>> [    1.240810]  pci_scan_child_bus_extend+0x20c/0x348
>>>> [    1.240812]  pci_scan_root_bus_bridge+0x64/0xf0
>>>> [    1.240815]  pci_host_probe+0x18/0xc8
>>>> [    1.240817]  rockchip_pcie_probe+0x34c/0x4b8
>>>> [    1.240820]  platform_drv_probe+0x54/0xa8
>>>> [    1.240822]  really_probe+0x29c/0x4f8
>>>> [    1.240824]  driver_probe_device+0xfc/0x168
>>>> [    1.240827]  device_driver_attach+0x74/0x80
>>>> [    1.240829]  __driver_attach+0xb8/0x168
>>>> [    1.240832]  bus_for_each_dev+0x7c/0xd8
>>>> [    1.240834]  driver_attach+0x24/0x30
>>>> [    1.240837]  bus_add_driver+0x15c/0x240
>>>> [    1.240839]  driver_register+0x64/0x120
>>>> [    1.240841]  __platform_driver_register+0x44/0x50
>>>> [    1.240844]  rockchip_pcie_driver_init+0x1c/0x28
>>>> [    1.240846]  do_one_initcall+0x60/0x1d8
>>>> [    1.240849]  kernel_init_freeable+0x234/0x2b4
>>>> [    1.240851]  kernel_init+0x14/0x118
>>>> [    1.240854]  ret_from_fork+0x10/0x34
>>>> [    1.240878] SMP: stopping secondary CPUs
>>>> [    1.240881] Kernel Offset: disabled
>>>> [    1.240883] CPU features: 0x0240022,2100200c
>>>> [    1.240886] Memory Limit: none
>>>>
>>>> Signed-off-by: Jari Hämäläinen <nuumiofi@gmail.com>
>>>> ---
>>>>   .../admin-guide/kernel-parameters.txt          |  8 ++++++++
>>>>   drivers/pci/controller/pcie-rockchip-host.c    | 18 ++++++++++++++++++
>>>>   drivers/pci/controller/pcie-rockchip.c         |  5 +++++
>>>>   drivers/pci/controller/pcie-rockchip.h         |  2 ++
>>>>   4 files changed, 33 insertions(+)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index c722ec19cd00..fda9bb9c85c3 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -3823,6 +3823,14 @@
>>>>                nomsi   Do not use MSI for native PCIe PME signaling (this makes
>>>>                        all PCIe root ports use INTx for all services).
>>>>
>>>> +     pcie_rockchip_host.bus_scan_delay_ms=
>>>> +                     [PCIE] delay before PCIe bus scan in milliseconds.
>>>> +                     If set to greater than or equal to 0 this parameter will
>>>> +                     override delay set in device tree. Values less than 0
>>>> +                     are ignored. This parameter provides a workaround for
>>>> +                     some devices causing a crash in bus scan.
>>>> +                     Default: -1
>>>> +
>>>>        pcmv=           [HW,PCMCIA] BadgePAD 4
>>>>
>>>>        pd_ignore_unused
>>>> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
>>>> index f1d08a1b1591..14733c92b25c 100644
>>>> --- a/drivers/pci/controller/pcie-rockchip-host.c
>>>> +++ b/drivers/pci/controller/pcie-rockchip-host.c
>>>> @@ -24,6 +24,7 @@
>>>>   #include <linux/kernel.h>
>>>>   #include <linux/mfd/syscon.h>
>>>>   #include <linux/module.h>
>>>> +#include <linux/moduleparam.h>
>>>>   #include <linux/of_address.h>
>>>>   #include <linux/of_device.h>
>>>>   #include <linux/of_pci.h>
>>>> @@ -39,6 +40,9 @@
>>>>   #include "../pci.h"
>>>>   #include "pcie-rockchip.h"
>>>>
>>>> +static int bus_scan_delay_ms = -1;
>>>> +module_param(bus_scan_delay_ms, int, 0444);
>>>> +
>>>>   static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
>>>>   {
>>>>        u32 status;
>>>> @@ -941,6 +945,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>>>        struct device *dev = &pdev->dev;
>>>>        struct pci_host_bridge *bridge;
>>>>        int err;
>>>> +     u32 delay = 0;
>>>>
>>>>        if (!dev->of_node)
>>>>                return -ENODEV;
>>>> @@ -992,6 +997,19 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>>>        bridge->sysdata = rockchip;
>>>>        bridge->ops = &rockchip_pcie_ops;
>>>>
>>>> +     /*
>>>> +      * Work around a crash caused by some devices on bus scan by applying a
>>>> +      * delay if one is given. Prefer command line value over device tree.
>>>> +      */
>>>> +     if (bus_scan_delay_ms >= 0)
>>>> +             delay = bus_scan_delay_ms;
>>>> +     else
>>>> +             delay = rockchip->bus_scan_delay_ms;
>>>> +     if (delay > 0) {
>>>> +             dev_info(dev, "delay bus scan for %u ms\n", delay);
>>>> +             msleep(delay);
>>>> +     }
>>>> +
>>>>        err = pci_host_probe(bridge);
>>>>        if (err < 0)
>>>>                goto err_remove_irq_domain;
>>>> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
>>>> index 904dec0d3a88..2e49e9204894 100644
>>>> --- a/drivers/pci/controller/pcie-rockchip.c
>>>> +++ b/drivers/pci/controller/pcie-rockchip.c
>>>> @@ -149,6 +149,11 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>>>>                return PTR_ERR(rockchip->clk_pcie_pm);
>>>>        }
>>>>
>>>> +     err = of_property_read_u32(node, "rockchip,bus-scan-delay-ms",
>>>> +                                &rockchip->bus_scan_delay_ms);
>>>> +     if (err)
>>>> +             rockchip->bus_scan_delay_ms = 0;
>>>> +
>>>>        return 0;
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(rockchip_pcie_parse_dt);
>>>> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
>>>> index 1650a5087450..18f37820b35b 100644
>>>> --- a/drivers/pci/controller/pcie-rockchip.h
>>>> +++ b/drivers/pci/controller/pcie-rockchip.h
>>>> @@ -300,6 +300,8 @@ struct rockchip_pcie {
>>>>        phys_addr_t msg_bus_addr;
>>>>        bool is_rc;
>>>>        struct resource *mem_res;
>>>> +     /* bus scan delay for crash causing devices' workaround */
>>>> +     u32 bus_scan_delay_ms;
>>>>   };
>>>>
>>>>   static u32 rockchip_pcie_read(struct rockchip_pcie *rockchip, u32 reg)
>>>> --
>>>> 2.29.2
>>>>
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
