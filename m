Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6371A21E513
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 03:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgGNBaE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 21:30:04 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:42118 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgGNBaE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 21:30:04 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2020 21:30:02 EDT
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id A8A03F1C
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2020 09:23:35 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P8590T140098590988032S1594689814192411_;
        Tue, 14 Jul 2020 09:23:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f9f841f32d9a6b1a29002a599f3737b0>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: xxm@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Cc:     shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Simon Xue <xxm@rock-chips.com>
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_1/2=5d_PCI=3a_rockchip=3a_Enable_IO_base_a?=
 =?UTF-8?B?bmQgbGltaXQgcmVnaXN0ZXJz44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgt?=
 =?UTF-8?Q?rockchip-bounces+shawn=2elin=3drock-chips=2ecom=40lists=2einfrade?=
 =?UTF-8?B?YWQub3Jn5Luj5Y+R44CR?=
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Anand Moon <linux.amoon@gmail.com>
References: <1590023130-137406-1-git-send-email-shawn.lin@rock-chips.com>
 <CANAwSgRXuMQaytB4BXL89JQAmU=XutBXj6iMhfKdZp3JwM9a4g@mail.gmail.com>
 <eb0acd3d-92d0-db00-78e4-8a17033f7f0a@rock-chips.com>
 <CANAwSgSzoc5TaO6ks9kdN7W+xDo1STbtsA0dUpsk8hqP6swkYg@mail.gmail.com>
 <20200708150135.GA4238@e121166-lin.cambridge.arm.com>
 <CANAwSgQO0yNOT6c+Bchfj08w1+aOqKzzTHMmrud-j7-Q=uDFjg@mail.gmail.com>
 <20200713164550.GB29307@e121166-lin.cambridge.arm.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <139e0296-e845-500f-8899-72b0f0b22e8c@rock-chips.com>
Date:   Tue, 14 Jul 2020 09:23:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200713164550.GB29307@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/7/14 0:45, Lorenzo Pieralisi wrote:
> On Thu, Jul 09, 2020 at 09:18:27AM +0530, Anand Moon wrote:
>> hi Lorenzo,
>>
>> On Wed, 8 Jul 2020 at 20:31, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>>>
>>> On Fri, May 22, 2020 at 05:59:14PM +0530, Anand Moon wrote:
>>>> Hi Shawn
>>>>
>>>> On Fri, 22 May 2020 at 08:30, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>>>>
>>>>>
>>>>> 在 2020/5/21 18:51, Anand Moon 写道:
>>>>>> Hi Shawn,
>>>>>>
>>>>>> On Thu, 21 May 2020 at 06:35, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>>>>>>
>>>>>>> According to RK3399 user manual, bit 9 in PCIE_RC_BAR_CONF should
>>>>>>> be set, otherwise accessing to IO base and limit registers would
>>>>>>> fail.
>>>>>>>
>>>>>>> [    0.411318] pci_bus 0000:00: root bus resource [bus 00-1f]
>>>>>>> [    0.411822] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
>>>>>>> [    0.412440] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])
>>>>>>> [    0.413665] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>>>>>>> [    0.414698] pci 0000:01:00.0: reg 0x10: initial BAR value 0x00000000 invalid
>>>>>>> [    0.415412] pci 0000:01:00.0: reg 0x18: initial BAR value 0x00000000 invalid
>>>>>>> [    0.418456] pci 0000:00:00.0: BAR 8: assigned [mem 0xfa000000-0xfa0fffff]
>>>>>>> [    0.419065] pci 0000:01:00.0: BAR 1: assigned [mem 0xfa000000-0xfa007fff pref]
>>>>>>> [    0.419728] pci 0000:01:00.0: BAR 6: assigned [mem 0xfa008000-0xfa00ffff pref]
>>>>>>> [    0.420377] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0100]
>>>>>>> [    0.420935] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0100]
>>>>>>> [    0.421526] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0004]
>>>>>>> [    0.422084] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0004]
>>>>>>> [    0.422687] pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>>>> [    0.423135] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
>>>>>>> [    0.423794] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
>>>>>>> [    0.424566] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
>>>>>>> [    0.425182] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
>>>>>>>
>>>>>>> 01:00.0 Class 0700: Device 1c00:3853 (rev 10) (prog-if 05)
>>>>>>>           Subsystem: Device 1c00:3853
>>>>>>>           Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>>>>>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>>>           Interrupt: pin A routed to IRQ 230
>>>>>>>           Region 0: I/O ports at <unassigned> [disabled]
>>>>>>>           Region 1: Memory at fa000000 (32-bit, prefetchable) [disabled] [size=32K]
>>>>>>>           Region 2: I/O ports at <unassigned> [disabled]
>>>>>>>           [virtual] Expansion ROM at fa008000 [disabled] [size=32K]
>>>>>>>
>>>>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>>>>> ---
>>>>>>
>>>>>> I have old development board Odroid N1 (RK3399),  It has onboard PCIe
>>>>>> 2 dual sata bridge.
>>>>>> I have tested this patch, but I am still getting following log on
>>>>>> Odroid N1 board.
>>>>>> Is their any more configuration needed for sata ports ?
>>>>>
>>>>> Thanks for testing. I made a mistake that it should be bit 19, so
>>>>> can you try using BIT(19)?
>>>>>
>>>>
>>>> Nop enable this bit dose not solve the issue see at my end.
>>>>
>>>> But as per RK3399 TMR  17.6.7.1.45 Root Complex BAR Configuration Register
>>>> their are many bits that are not tuned correctly.
>>>> I tried to set some bit to BAR Configuration register. but it dose not
>>>> work at my end.
>>>> I feel some more core configuration is missing.
>>>> If I have some update I will share it with you.
>>>
>>> What's the status of this discussion and therefore this series ?
>>>
>>> Thanks,
>>> Lorenzo
>>
>> Well I have looked into the RK3399 TRM  (Rockchip RK3399 TRM V1.3 Part2.pdf)
>> There seems to be some core configuration missing, but I could not
>> resolve this on my board.
> 
> So what are we going to do with this series ?

I didn't test it on N1 board so I cannot say what happened there, but I
incline to suspend this series untile I have a sufficient offlist
debugging with Anand.

> 
> Lorenzo
> 
> 


