Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F8530AF31
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 19:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhBAS1G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 13:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhBASSJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 13:18:09 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98737C061573
        for <linux-pci@vger.kernel.org>; Mon,  1 Feb 2021 10:17:28 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id t8so20784422ljk.10
        for <linux-pci@vger.kernel.org>; Mon, 01 Feb 2021 10:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4x3fYHzuLloRCVGLydI5lwFq+4xtHyn3FNo/8cAtAGI=;
        b=VOhUnLVQDVMAlONLOlUNKrGCfK/CLXhagq0ZrkVbF7j6qrwxo/YnlI1+GYDRli9tTx
         zFlGjbwfrBIgv+l9JK2fLPh/2di7Xnb3/2dumHsm7har95+WLP5ouzwZo5QLx2BadCZq
         AcV7HUIN2MgSAhFYUN6mPkFLcz/I2N2wPNXrxa+cEcYmiPN/HUCBMUKMg+fmB20X3LGj
         TBGJXelNGYwTrFRYHHztDy0WjJEdUyiZs6TKJtc39EGSqghzo18YHimyoO+PDqQnEnSW
         dqGOImPAlf1vaL+S7/K4A4+kAL68s7b4OHo+6Y6oa+kW2q32SUW7d/ExqGnShPcZXDA4
         w2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4x3fYHzuLloRCVGLydI5lwFq+4xtHyn3FNo/8cAtAGI=;
        b=bnITNSOaGm2Kg5q+6YlxGfzeTcyt/ow2tMrT6uPRIEFsMkYUino0x1K6K5OhihQ5Ar
         jne7WfHxtdNPckyxNmAtCYs9AnNnWNgvNNdSOqr/odrHcdO1V2UXhikl/id7euiGdWdq
         6unkp4mTgJSuFGTpgWWCbP/WbkSDytmA67vnLBLxJoY+k6SAnAy6UkuEhrUMfTGlM0VR
         Uwj1MqpkyLcUBUNWtrba0L+OZwyh+ndoyVCQLWdVDCAn5BNofEkjtzaouOPA31REro+F
         aMlVnTVEnI95iaYKTeTOnoYczfd1iv10FKiVfEpEVJXi+6kmM1oMjv05hPYRfyfPbzBX
         CJ2w==
X-Gm-Message-State: AOAM530gKFwskJzzW+e8zMvrqQ4CU9C0BHjs86sl1zWXLxejv4bk2kSe
        NtF339CtBofCARekhXmKcZoD0tj/hv0=
X-Google-Smtp-Source: ABdhPJxF+g8Z3Msxg8Yl1NOC1bc0gkhpFrc9UTspxzDwyiYCnykihAwkN8LaB/gA4O+h8Em266+FOw==
X-Received: by 2002:a2e:9801:: with SMTP id a1mr7965744ljj.122.1612203447141;
        Mon, 01 Feb 2021 10:17:27 -0800 (PST)
Received: from localhost.localdomain (85-76-10-224-nat.elisa-mobile.fi. [85.76.10.224])
        by smtp.gmail.com with ESMTPSA id g25sm3890569ljj.64.2021.02.01.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:17:26 -0800 (PST)
From:   =?UTF-8?q?Jari=20H=C3=A4m=C3=A4l=C3=A4inen?= <nuumiofi@gmail.com>
To:     shawn.lin@rock-chips.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux.amoon@gmail.com, lorenzo.pieralisi@arm.com,
        xxm@rock-chips.com
Subject: Re: [PATCH 1/2] PCI: rockchip: Enable IO base and limit registers
Date:   Mon,  1 Feb 2021 20:16:55 +0200
Message-Id: <20210201181655.325452-1-nuumiofi@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <139e0296-e845-500f-8899-72b0f0b22e8c@rock-chips.com>
References: <139e0296-e845-500f-8899-72b0f0b22e8c@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On 2020/7/14 0:45, Lorenzo Pieralisi wrote:
>> On Thu, Jul 09, 2020 at 09:18:27AM +0530, Anand Moon wrote:
>>> hi Lorenzo,
>>>
>>> On Wed, 8 Jul 2020 at 20:31, Lorenzo Pieralisi
>>> <lorenzo.pieralisi@arm.com> wrote:
>>>>
>>>> On Fri, May 22, 2020 at 05:59:14PM +0530, Anand Moon wrote:
>>>>> Hi Shawn
>>>>>
>>>>> On Fri, 22 May 2020 at 08:30, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>>>>>
>>>>>>
>>>>>> 在 2020/5/21 18:51, Anand Moon 写道:
>>>>>>> Hi Shawn,
>>>>>>>
>>>>>>> On Thu, 21 May 2020 at 06:35, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>>>>>>>
>>>>>>>> According to RK3399 user manual, bit 9 in PCIE_RC_BAR_CONF should
>>>>>>>> be set, otherwise accessing to IO base and limit registers would
>>>>>>>> fail.
>>>>>>>>
>>>>>>>> [    0.411318] pci_bus 0000:00: root bus resource [bus 00-1f]
>>>>>>>> [    0.411822] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
>>>>>>>> [    0.412440] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])
>>>>>>>> [    0.413665] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>>>>>>>> [    0.414698] pci 0000:01:00.0: reg 0x10: initial BAR value 0x00000000 invalid
>>>>>>>> [    0.415412] pci 0000:01:00.0: reg 0x18: initial BAR value 0x00000000 invalid
>>>>>>>> [    0.418456] pci 0000:00:00.0: BAR 8: assigned [mem 0xfa000000-0xfa0fffff]
>>>>>>>> [    0.419065] pci 0000:01:00.0: BAR 1: assigned [mem 0xfa000000-0xfa007fff pref]
>>>>>>>> [    0.419728] pci 0000:01:00.0: BAR 6: assigned [mem 0xfa008000-0xfa00ffff pref]
>>>>>>>> [    0.420377] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0100]
>>>>>>>> [    0.420935] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0100]
>>>>>>>> [    0.421526] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0004]
>>>>>>>> [    0.422084] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0004]
>>>>>>>> [    0.422687] pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>>>>> [    0.423135] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
>>>>>>>> [    0.423794] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
>>>>>>>> [    0.424566] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
>>>>>>>> [    0.425182] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
>>>>>>>>
>>>>>>>> 01:00.0 Class 0700: Device 1c00:3853 (rev 10) (prog-if 05)
>>>>>>>>           Subsystem: Device 1c00:3853
>>>>>>>>           Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>>>>>>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>>>>           Interrupt: pin A routed to IRQ 230
>>>>>>>>           Region 0: I/O ports at <unassigned> [disabled]
>>>>>>>>           Region 1: Memory at fa000000 (32-bit, prefetchable) [disabled] [size=32K]
>>>>>>>>           Region 2: I/O ports at <unassigned> [disabled]
>>>>>>>>           [virtual] Expansion ROM at fa008000 [disabled] [size=32K]
>>>>>>>>
>>>>>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>>>>>> ---
>>>>>>>
>>>>>>> I have old development board Odroid N1 (RK3399),  It has onboard PCIe
>>>>>>> 2 dual sata bridge.
>>>>>>> I have tested this patch, but I am still getting following log on
>>>>>>> Odroid N1 board.
>>>>>>> Is their any more configuration needed for sata ports ?
>>>>>>
>>>>>> Thanks for testing. I made a mistake that it should be bit 19, so
>>>>>> can you try using BIT(19)?
>>>>>>
>>>>>
>>>>> Nop enable this bit dose not solve the issue see at my end.
>>>>>
>>>>> But as per RK3399 TMR  17.6.7.1.45 Root Complex BAR Configuration Register
>>>>> their are many bits that are not tuned correctly.
>>>>> I tried to set some bit to BAR Configuration register. but it dose not
>>>>> work at my end.
>>>>> I feel some more core configuration is missing.
>>>>> If I have some update I will share it with you.
>>>>
>>>> What's the status of this discussion and therefore this series ?
>>>>
>>>> Thanks,
>>>> Lorenzo
>>>
>>> Well I have looked into the RK3399 TRM  (Rockchip RK3399 TRM V1.3 Part2.pdf)
>>> There seems to be some core configuration missing, but I could not
>>> resolve this on my board.
>> 
>> So what are we going to do with this series ?
> 
> I didn't test it on N1 board so I cannot say what happened there, but I
> incline to suspend this series untile I have a sufficient offlist
> debugging with Anand.
> 
>> 
>> Lorenzo
>> 
>> 

Hello Shawn and all,

Sorry about my previous garbled message. I'm trying to use git send-email
and subject failed badly. Hopefully this one works better.

Is there any news about this series? I happened to stumble upon this while
searching anything PCIe related for my bus scan crash workaround [1].

This series still seems to apply cleanly on v5.11-rc6 so I applied the
BIT(9) to BIT(19) change mentioned earlier and tested it with four SAS
adapter cards and two SATA adapter cards. For all of them this series fixed
"no space for io" in dmesg and "I/O ports at <unassigned> [disabled]" in
lspci output.

Below are few dmesg and lspci -vvnn snippets before and after applying
these patches (SAS cards need bus scan crash workaround too).

LSI SAS2008 before applying patch:

  [    2.664846] pci_bus 0000:00: bus scan returning with max=01
  [    2.665412] pci 0000:00:00.0: BAR 8: assigned [mem 0xfa000000-0xfa0fffff]
  [    2.666083] pci 0000:01:00.0: BAR 6: assigned [mem 0xfa000000-0xfa07ffff pref]
  [    2.666796] pci 0000:01:00.0: BAR 3: assigned [mem 0xfa080000-0xfa0bffff 64bit]
  [    2.667550] pci 0000:01:00.0: BAR 1: assigned [mem 0xfa0c0000-0xfa0c3fff 64bit]
  [    2.668301] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0100]
  [    2.668917] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0100]
  [    2.669565] pci 0000:00:00.0: PCI bridge to [bus 01]
  [    2.670075] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]

  00:00.0 PCI bridge [0604]: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI Express Root Port [1d87:0100] (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0, IRQ 78
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 00000000-00000fff [size=4K]
    Memory behind bridge: fa000000-fa0fffff [size=1M]
  ...
  01:00.0 RAID bus controller [0104]: Broadcom / LSI SAS2008 PCI-Express Fusion-MPT SAS-2 [Falcon] [1000:0072] (rev 03)
    Subsystem: Fujitsu Technology Solutions HBA Ctrl SAS 6G 0/1 [D2607] [1734:1177]
    Flags: bus master, fast devsel, latency 0, IRQ 77
    I/O ports at <unassigned> [disabled]
    Memory at fa0c0000 (64-bit, non-prefetchable) [size=16K]

LSI SAS2008 after applying patch:

  [    2.746453] pci_bus 0000:00: bus scan returning with max=01
  [    2.747021] pci 0000:00:00.0: BAR 8: assigned [mem 0xfa000000-0xfa0fffff]
  [    2.747689] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
  [    2.748294] pci 0000:01:00.0: BAR 6: assigned [mem 0xfa000000-0xfa07ffff pref]
  [    2.749008] pci 0000:01:00.0: BAR 3: assigned [mem 0xfa080000-0xfa0bffff 64bit]
  [    2.749761] pci 0000:01:00.0: BAR 1: assigned [mem 0xfa0c0000-0xfa0c3fff 64bit]
  [    2.750515] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
  [    2.751128] pci 0000:00:00.0: PCI bridge to [bus 01]
  [    2.751638] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
  [    2.752242] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]

  00:00.0 PCI bridge [0604]: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI Express Root Port [1d87:0100] (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0, IRQ 78
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 00001000-00001fff [size=4K]
    Memory behind bridge: fa000000-fa0fffff [size=1M]
  ...
  01:00.0 RAID bus controller [0104]: Broadcom / LSI SAS2008 PCI-Express Fusion-MPT SAS-2 [Falcon] [1000:0072] (rev 03)
    Subsystem: Fujitsu Technology Solutions HBA Ctrl SAS 6G 0/1 [D2607] [1734:1177]
    Flags: bus master, fast devsel, latency 0, IRQ 77
    I/O ports at 1000 [disabled] [size=256]
    Memory at fa0c0000 (64-bit, non-prefetchable) [size=16K]

I haven't yet tested if this change actually makes these card work any
better or worse but I could do more testing if that BIT(9) to BIT(19) is
fixed and this series is otherwise able to get merged.

[1] https://lore.kernel.org/linux-pci/20201231125214.25733-1-nuumiofi@gmail.com/

Regards,
Jari
