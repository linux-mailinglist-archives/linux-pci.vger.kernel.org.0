Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9B71DDDA6
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 05:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEVDIG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 23:08:06 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:51196 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgEVDIG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 23:08:06 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 May 2020 23:08:04 EDT
Received: from localhost (unknown [192.168.167.224])
        by lucky1.263xmail.com (Postfix) with ESMTP id 1260BAF778;
        Fri, 22 May 2020 11:00:06 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P11979T139798356420352S1590116403246432_;
        Fri, 22 May 2020 11:00:03 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <1bf8029f95bd2f1e48884df3163eacf3>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Cc:     shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_1/2=5d_PCI=3a_rockchip=3a_Enable_IO_base_a?=
 =?UTF-8?B?bmQgbGltaXQgcmVnaXN0ZXJz44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgt?=
 =?UTF-8?Q?rockchip-bounces+shawn=2elin=3drock-chips=2ecom=40lists=2einfrade?=
 =?UTF-8?B?YWQub3Jn5Luj5Y+R44CR?=
To:     Anand Moon <linux.amoon@gmail.com>
References: <1590023130-137406-1-git-send-email-shawn.lin@rock-chips.com>
 <CANAwSgRXuMQaytB4BXL89JQAmU=XutBXj6iMhfKdZp3JwM9a4g@mail.gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <eb0acd3d-92d0-db00-78e4-8a17033f7f0a@rock-chips.com>
Date:   Fri, 22 May 2020 11:00:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <CANAwSgRXuMQaytB4BXL89JQAmU=XutBXj6iMhfKdZp3JwM9a4g@mail.gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


ÔÚ 2020/5/21 18:51, Anand Moon Ð´µÀ:
> Hi Shawn,
> 
> On Thu, 21 May 2020 at 06:35, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> According to RK3399 user manual, bit 9 in PCIE_RC_BAR_CONF should
>> be set, otherwise accessing to IO base and limit registers would
>> fail.
>>
>> [    0.411318] pci_bus 0000:00: root bus resource [bus 00-1f]
>> [    0.411822] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
>> [    0.412440] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])
>> [    0.413665] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    0.414698] pci 0000:01:00.0: reg 0x10: initial BAR value 0x00000000 invalid
>> [    0.415412] pci 0000:01:00.0: reg 0x18: initial BAR value 0x00000000 invalid
>> [    0.418456] pci 0000:00:00.0: BAR 8: assigned [mem 0xfa000000-0xfa0fffff]
>> [    0.419065] pci 0000:01:00.0: BAR 1: assigned [mem 0xfa000000-0xfa007fff pref]
>> [    0.419728] pci 0000:01:00.0: BAR 6: assigned [mem 0xfa008000-0xfa00ffff pref]
>> [    0.420377] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0100]
>> [    0.420935] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0100]
>> [    0.421526] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0004]
>> [    0.422084] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0004]
>> [    0.422687] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [    0.423135] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
>> [    0.423794] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
>> [    0.424566] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
>> [    0.425182] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
>>
>> 01:00.0 Class 0700: Device 1c00:3853 (rev 10) (prog-if 05)
>>          Subsystem: Device 1c00:3853
>>          Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>          Interrupt: pin A routed to IRQ 230
>>          Region 0: I/O ports at <unassigned> [disabled]
>>          Region 1: Memory at fa000000 (32-bit, prefetchable) [disabled] [size=32K]
>>          Region 2: I/O ports at <unassigned> [disabled]
>>          [virtual] Expansion ROM at fa008000 [disabled] [size=32K]
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
> 
> I have old development board Odroid N1 (RK3399),  It has onboard PCIe
> 2 dual sata bridge.
> I have tested this patch, but I am still getting following log on
> Odroid N1 board.
> Is their any more configuration needed for sata ports ?

Thanks for testing. I made a mistake that it should be bit 19, so
can you try using BIT(19)?

> 
> [    7.444504] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
> [    7.445521] panfrost ff9a0000.gpu: Features: L2:0x07120206
> Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff
> JS:0x7
> [    7.452246] pci 0000:00:00.0: BAR 14: assigned [mem 0xfa000000-0xfa0fffff]
> [    7.460106] panfrost ff9a0000.gpu: shader_present=0xf l2_present=0x1
> [    7.466459] pci 0000:01:00.0: BAR 6: assigned [mem
> 0xfa000000-0xfa00ffff pref]
> [    7.473679] panfrost ff9a0000.gpu: [drm:panfrost_devfreq_init
> [panfrost]] Failed to register cooling device
> [    7.479703] pci 0000:01:00.0: BAR 5: assigned [mem 0xfa010000-0xfa0101ff]
> [    7.487706] [drm] Initialized panfrost 1.1.0 20180908 for
> ff9a0000.gpu on minor 0
> [    7.494343] pci 0000:01:00.0: BAR 4: no space for [io  size 0x0010]
> [    7.494348] pci 0000:01:00.0: BAR 4: failed to assign [io  size 0x0010]
> [    7.494352] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0008]
> [    7.494356] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0008]
> [    7.494360] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0008]
> [    7.494364] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0008]
> [    7.494368] pci 0000:01:00.0: BAR 1: no space for [io  size 0x0004]
> [    7.494372] pci 0000:01:00.0: BAR 1: failed to assign [io  size 0x0004]
> [    7.578910] rockchip-vop ff8f0000.vop: Adding to iommu group 3
> [    7.587074] pci 0000:01:00.0: BAR 3: no space for [io  size 0x0004]
> [    7.594780] rockchip-vop ff900000.vop: Adding to iommu group 4
> [    7.607701] pci 0000:01:00.0: BAR 3: failed to assign [io  size 0x0004]
> 
> # lspci -v
> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI
> Express Root Port (prog-if 00 [Normal decode])
>          Flags: bus master, fast devsel, latency 0, IRQ 237
>          Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>          I/O behind bridge: 00000000-00000fff [size=4K]
>          Memory behind bridge: fa000000-fa0fffff [size=1M]
>          Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
>          Capabilities: [80] Power Management version 3
>          Capabilities: [90] MSI: Enable+ Count=1/1 Maskable+ 64bit+
>          Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
>          Capabilities: [c0] Express Root Port (Slot+), MSI 00
>          Capabilities: [100] Advanced Error Reporting
>          Capabilities: [274] Transaction Processing Hints
>          Kernel driver in use: pcieport
> 
> 01:00.0 IDE interface: ASMedia Technology Inc. ASM1061 SATA IDE
> Controller (rev 02) (prog-if 85 [PCI native mode-only controller,
> supports bus mastering])
>          Subsystem: ASMedia Technology Inc. ASM1061 SATA IDE Controller
>          Flags: bus master, fast devsel, latency 0, IRQ 238
>          I/O ports at <unassigned> [disabled]
>          I/O ports at <unassigned> [disabled]
>          I/O ports at <unassigned> [disabled]
>          I/O ports at <unassigned> [disabled]
>          I/O ports at <unassigned> [disabled]
>          Memory at fa010000 (32-bit, non-prefetchable) [size=512]
>          Expansion ROM at fa000000 [virtual] [disabled] [size=64K]
>          Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
>          Capabilities: [78] Power Management version 3
>          Capabilities: [80] Express Legacy Endpoint, MSI 00
>          Capabilities: [100] Virtual Channel
>          Kernel driver in use: ahci
> 
> Best Regards
> -Anand
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> 
> 


