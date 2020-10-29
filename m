Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912FF29E53B
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 08:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgJ2HzD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 03:55:03 -0400
Received: from chronos.abteam.si ([46.4.99.117]:50837 "EHLO chronos.abteam.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732318AbgJ2HxR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Oct 2020 03:53:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by chronos.abteam.si (Postfix) with ESMTP id D82655D00070;
        Thu, 29 Oct 2020 08:53:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bstnet.org; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:subject:subject; s=default; t=
        1603957988; x=1605772389; bh=PhVtk4Wtk6ySvQBY8qTkhW3+mLI533N7yp+
        E4SmBnhA=; b=AyUkJ73Z+g0EOPAX+z9GRhtkPRzMQcaau+Ulx20WASkwk33aSx3
        oy3qbL9+uhHMUx2pbZaJ9eTlm7gS130YZGIvLoa+qXLvTggKYDzXie5KdcqmygfM
        nBGAjeBKgO7QGCEzohGxFOk1m2ERhHC1F3DAMofSw3+C38+hu4ZnxlV8=
Received: from chronos.abteam.si ([127.0.0.1])
        by localhost (chronos.abteam.si [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iNI_PnwD5JM3; Thu, 29 Oct 2020 08:53:08 +0100 (CET)
Received: from bst-slack.bstnet.org (unknown [IPv6:2a00:ee2:4d00:602:55ba:eee4:b8b8:69b3])
        (Authenticated sender: boris@abteam.si)
        by chronos.abteam.si (Postfix) with ESMTPSA id 472CB5D0005B;
        Thu, 29 Oct 2020 08:53:05 +0100 (CET)
Subject: Re: Kernel 5.9 IOMMU groups regression/change
To:     Rajat Jain <rajatja@google.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <d76b70c1-17f6-60d7-b027-5ecda491101c@bstnet.org>
 <20201028215246.GA351595@bjorn-Precision-5520>
 <CACK8Z6HLPyc_o9kvy09gjm+OQ7DLyvV2wB0boXCthEesra0t-g@mail.gmail.com>
 <CACK8Z6G-nDAk6oNQ0pySUoh4fSmO++XuGVhQcykYgEQ9QCOM4Q@mail.gmail.com>
From:   "Boris V." <borisvk@bstnet.org>
Message-ID: <63e89b35-ad83-98e9-c032-704381e5221e@bstnet.org>
Date:   Thu, 29 Oct 2020 08:53:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CACK8Z6G-nDAk6oNQ0pySUoh4fSmO++XuGVhQcykYgEQ9QCOM4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/10/2020 00:37, Rajat Jain wrote:
> On Wed, Oct 28, 2020 at 3:07 PM Rajat Jain <rajatja@google.com> wrote:
>> On Wed, Oct 28, 2020 at 2:52 PM Bjorn Helgaas <helgaas@kernel.org> wro=
te:
>>> [+cc Rajat, LKML]
>>>
>> Thanks for copying me. (I don't look at mailing lists actively - so
>> missed this). Taking a look at this now.
>>
>> Thanks,
>>
>> Rajat
>>
>>
>>> On Tue, Oct 27, 2020 at 08:31:09PM +0100, Boris V. wrote:
>>>> On 25/10/2020 20:45, Boris V. wrote:
>>>>> With upgrade to kernel 5.9 my VMs stopped working, because some dev=
ices
>>>>> can't be passed through.
>>>>> This is caused by different IOMMU groups and devices being in the s=
ame
>>>>> group.
>>>>>
>>>>> For ex. with kernel 5.8 this are IOMMU groups:
>>>>> IOMMU Group 40:
>>>>>          08:01.0 PCI bridge [0604]: ASMedia Technology Inc. Device
>>>>> [1b21:118f]
>>>>>          09:00.0 Ethernet controller [0200]: Intel Corporation I211
>>>>> Gigabit Network Connection [8086:1539] (rev 03)
>>>>> IOMMU Group 43:
>>>>>          0c:00.0 SATA controller [0106]: ASMedia Technology Inc. AS=
M1062
>>>>> Serial ATA Controller [1b21:0612] (rev 02)
>>>>> IOMMU Group 44:
>>>>>          0d:00.0 USB controller [0c03]: ASMedia Technology Inc. ASM=
1042A
>>>>> USB 3.0 Host Controller [1b21:1142]
>>>>>
>>>>> Ethernet, SATA and USB controller in its own group.
>>>>>
>>>>> And with 5.9, everything is in one group:
>>>>> IOMMU Group 29:
>>>>>          00:1c.0 PCI bridge [0604]: Intel Corporation C610/X99 seri=
es
>>>>> chipset PCI Express Root Port #1 [8086:8d10] (rev d5)
>>>>>          00:1c.3 PCI bridge [0604]: Intel Corporation C610/X99 seri=
es
>>>>> chipset PCI Express Root Port #4 [8086:8d16] (rev d5)
>>>>>          00:1c.4 PCI bridge [0604]: Intel Corporation C610/X99 seri=
es
>>>>> chipset PCI Express Root Port #5 [8086:8d18] (rev d5)
>>>>>          00:1c.6 PCI bridge [0604]: Intel Corporation C610/X99 seri=
es
>>>>> chipset PCI Express Root Port #7 [8086:8d1c] (rev d5)
>>>>>          07:00.0 PCI bridge [0604]: ASMedia Technology Inc. Device
>>>>> [1b21:118f]
>>>>>          08:01.0 PCI bridge [0604]: ASMedia Technology Inc. Device
>>>>> [1b21:118f]
>>>>>          08:03.0 PCI bridge [0604]: ASMedia Technology Inc. Device
>>>>> [1b21:118f]
>>>>>          08:04.0 PCI bridge [0604]: ASMedia Technology Inc. Device
>>>>> [1b21:118f]
>>>>>          09:00.0 Ethernet controller [0200]: Intel Corporation I211
>>>>> Gigabit Network Connection [8086:1539] (rev 03)
>>>>>          0c:00.0 SATA controller [0106]: ASMedia Technology Inc. AS=
M1062
>>>>> Serial ATA Controller [1b21:0612] (rev 02)
>>>>>          0d:00.0 USB controller [0c03]: ASMedia Technology Inc. ASM=
1042A
>>>>> USB 3.0 Host Controller [1b21:1142]
>>>>>
>>>>>
>>>>> This seems to be caused by commit
>>>>> 52fbf5bdeeef415b28b8e6cdade1e48927927f60.
>>>>> commit 52fbf5bdeeef415b28b8e6cdade1e48927927f60
>>>>> Author: Rajat Jain <rajatja@google.com>
>>>>> Date:   Tue Jul 7 15:46:02 2020 -0700
>>>>>
>>>>>      PCI: Cache ACS capability offset in device
>>>>>
>>>>>      Currently the ACS capability is being looked up at a number of
>>>>> places. Read
>>>>>      and store it once at enumeration so that it can be used by all
>>>>> later.  No
>>>>>      functional change intended.
>>>>>
>>>>>      Link:
>>>>> https://lore.kernel.org/r/20200707224604.3737893-2-rajatja@google.c=
om
>>>>>      Signed-off-by: Rajat Jain <rajatja@google.com>
>>>>>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>>
>>>>>   drivers/pci/p2pdma.c |  2 +-
>>>>>   drivers/pci/pci.c    | 20 ++++++++++++++++----
>>>>>   drivers/pci/pci.h    |  2 +-
>>>>>   drivers/pci/probe.c  |  2 +-
>>>>>   drivers/pci/quirks.c |  8 ++++----
>>>>>   include/linux/pci.h  |  1 +
>>>>>   6 files changed, 24 insertions(+), 11 deletions(-)
>>>>>
>>>>>
>>>>> If I revert this commit, I get back old groups.
>>>>>
>>>>> In commit log there is message 'No functional change intended'. But
>>>>> there is functional change.
>>>>>
>>>>> This is Intel Core i7-5930K CPU and X99 chipset. But I see the same
>>>>> thing on other Intel systems (didn't test on AMD).
>>>> Some more info.
>>>> Problem seems to be that pci_dev_specific_enable_acs() is not called
>>>> anymore.
>>>> Before, pci_enable_acs() was called from pci_init_capabilities() and=
 in
>>>> pci_enable_acs(), pci_dev_specific_enable_acs() was called.
>>>> I don't know anything about PCI and this stuff, but I'm guessing tha=
t this
>>>> function enable ACS for some Intel devices.
>>>> But after this commit, pci_acs_init() is called from pci_init_capabi=
lities()
>>>> and if pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS) returns 0,
>>>> pci_enable_acs() and pci_dev_specific_enable_acs() is not called any=
more.
>>>> If I apply for ex. this patch bellow, groups are right again and eve=
rything
>>>> works as before.
>>> Thanks very much for the report and the debugging.  Maybe we can get
>>> this sorted and fixed for v5.10-rc2 or -rc3.
> Thank Boris for reporting and debugging! The problem was because I
> overlooked the fact that some rootports (the ones quirked with
> *_intel_pch_acs_* functions in this case) may not expose a standard
> ACS capability structure, but rather depend on quirks to enable ACS
> for them using non standard registers. Your platform is in this
> category. Can you please send lspci -vvvv and lspci -xxxx for one of
> your rootports to confirm?

Below is lspci output for some root ports:

lspci -vvvv -s 00:01.0
00:01.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI=20
Express Root Port 1 (rev 02) (prog-if 00 [Normal decode])
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+=
 SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- Fast=
B2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Latency: 0, Cache Line Size: =
64 bytes
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IR=
Q 25
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NUMA node: 0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IOMMU group: 13
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D=
04, subordinate=3D04, sec-latency=3D0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O behind bridge: 0000f000-0=
0000fff [disabled]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory behind bridge: fff0000=
0-000fffff [disabled]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Prefetchable memory behind br=
idge:=20
00000000fff00000-00000000000fffff [disabled]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Secondary status: 66MHz- Fast=
B2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- <SERR- <PERR-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BridgeCtl: Parity- SERR+ NoIS=
A- VGA- VGA16+ MAbort- >Reset-=20
FastB2B-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [40] Subsystem:=
 Intel Corporation Xeon E7 v3/Xeon=20
E5 v3/Core i7 PCI Express Root Port 1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [60] MSI: Enabl=
e+ Count=3D1/2 Maskable+ 64bit-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Address: fee00238=C2=A0 Data: 0000
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Masking: 00000002=C2=A0 Pending: 00000000
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [90] Express (v=
2) Root Port (Slot+), MSI 00
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevCap: MaxPayload 256 bytes, PhantFunc 0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtTag=
- RBE+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RlxdOr=
d- ExtTag- PhantFunc- AuxPwr- NoSnoop-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MaxPay=
load 128 bytes, MaxReadReq 128 bytes
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-=20
AuxPwr- TransPend-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkCap: Port #1, Speed 8GT/s, Width x4, ASPM L1, Exit=20
Latency L1 <16us
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ClockP=
M- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk=
+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtSyn=
ch- ClockPM- AutWidDis- BWInt- AutBWInt-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkSta: Speed 2.5GT/s (downgraded), Width x0 (downgrad=
ed)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TrErr-=
 Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-=20
HotPlug- Surprise-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Slot #=
2, PowerLimit 0.000W; Interlock- NoCompl-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt=
-=20
HPIrq- LinkChg-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Contro=
l: AttnInd Off, PwrInd Off, Power- Interlock-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-=20
PresDet- Interlock-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Change=
d: MRL- PresDet+ LinkState-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RootCap: CRSVisible+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-=20
PMEIntEna+ CRSVisible+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: Range BCD, TimeoutDis+=20
NROPrPrP- LTR-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
10BitTagComp- 10BitTagReq- OBFF Not Supported,=20
ExtFmt- EETLPPrefix-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
EmergencyPowerReduction Not Supported,=20
EmergencyPowerReductionInit-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
FRS- LN System CLS Not Supported, TPHComp+=20
ExtTPHComp- ARIFwd+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
=20
LTR- OBFF Disabled, ARIFwd-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
AtomicOpsCtl: ReqEn- EgressBlck-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-=20
Retimer- 2Retimers- DRS-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance-=20
SpeedDis-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Compliance De-emphasis: -6dB
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis Level: -6dB,=20
EqualizationComplete- EqualizationPhase1-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
EqualizationPhase2- EqualizationPhase3-=20
LinkEqualizationRequest-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Retimer- 2Retimers- CrosslinkRes: unsupported
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [e0] Power Mana=
gement version 3
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Status: D3 NoSoftRst+ PME-Enable+ DSel=3D0 DScale=3D0 =
PME-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Vendor=
 Specific Information: ID=3D0002=20
Rev=3D0 Len=3D00c <?>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [110 v1] Access=
 Control Services
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+=20
UpstreamFwd+ EgressCtrl- DirectTrans-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+=20
UpstreamFwd+ EgressCtrl- DirectTrans-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [148 v1] Advanc=
ed Error Reporting
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 UESta:=C2=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-=20
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 UEMsk:=C2=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-=20
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-=20
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 CESta:=C2=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeout=
-=20
AdvNonFatalErr-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 CEMsk:=C2=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeout=
-=20
AdvNonFatalErr+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn=
-=20
ECRCChkCap- ECRCChkEn-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MultHd=
rRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HeaderLog: 00000000 00000000 00000000 00000000
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RootCmd: CERptEn+ NFERptEn+ FERptEn+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [1d0 v1] Vendor=
 Specific Information: ID=3D0003=20
Rev=3D1 Len=3D00a <?>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [250 v1] Second=
ary PCI Express
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LaneErrStat: 0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [280 v1] Vendor=
 Specific Information: ID=3D0005=20
Rev=3D3 Len=3D018 <?>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [300 v1] Vendor=
 Specific Information: ID=3D0008=20
Rev=3D0 Len=3D038 <?>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: pciepor=
t

lspci -xxxx -s 00:01.0
00:01.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI=20
Express Root Port 1 (rev 02)
00: 86 80 02 2f 07 04 10 00 02 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 04 04 00 f0 00 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 12 00
40: 0d 60 00 00 86 80 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 05 90 03 01 38 02 e0 fe 00 00 00 00 02 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 10 e0 42 01 01 80 00 00 0f 00 00 00 43 38 7a 01
a0: 40 00 01 10 00 00 10 00 c0 03 08 00 18 00 01 00
b0: 00 00 00 00 be 13 00 00 00 00 00 00 0e 00 00 00
c0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 01 00 03 c8 0b 01 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
100: 0b 00 01 11 02 00 c0 00 07 31 00 00 00 00 00 00
110: 0d 00 81 14 1f 00 1d 00 00 00 00 00 00 00 00 00
120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
140: 00 00 00 00 00 00 00 00 01 00 01 1d 00 00 00 00
150: 00 00 00 00 30 20 06 00 00 00 00 00 00 20 00 00
160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
170: 00 00 00 00 07 00 00 00 00 00 00 00 00 00 00 00
180: 91 30 18 00 00 00 00 00 40 10 10 e4 20 00 00 00
190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1d0: 0b 00 01 25 03 00 a1 00 00 00 00 00 00 00 00 00
1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
210: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
250: 19 00 01 28 00 00 00 00 00 00 00 00 77 27 77 27
260: 77 27 77 27 77 27 77 27 77 27 77 27 00 00 00 00
270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
280: 0b 00 01 30 05 00 83 01 00 00 00 40 00 00 00 00
290: 00 00 00 00 00 00 00 00 0b 00 01 30 07 00 40 02
2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
300: 0b 00 01 00 08 00 80 03 00 00 00 00 0f 00 00 00
310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
710: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

lspci -vvvv -s 00:01.1
00:01.1 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI=20
Express Root Port 1 (rev 02) (prog-if 00 [Normal decode])
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+=
 SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- Fast=
B2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Latency: 0, Cache Line Size: =
64 bytes
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IR=
Q 26
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NUMA node: 0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IOMMU group: 14
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D=
05, subordinate=3D05, sec-latency=3D0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O behind bridge: 0000f000-0=
0000fff [disabled]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory behind bridge: fb60000=
0-fb6fffff [size=3D1M]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Prefetchable memory behind br=
idge:=20
00000000fff00000-00000000000fffff [disabled]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Secondary status: 66MHz- Fast=
B2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- <SERR- <PERR-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BridgeCtl: Parity- SERR+ NoIS=
A- VGA- VGA16+ MAbort- >Reset-=20
FastB2B-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [40] Subsystem:=
 Intel Corporation Xeon E7 v3/Xeon=20
E5 v3/Core i7 PCI Express Root Port 1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [60] MSI: Enabl=
e+ Count=3D1/2 Maskable+ 64bit-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Address: fee00258=C2=A0 Data: 0000
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Masking: 00000002=C2=A0 Pending: 00000000
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [90] Express (v=
2) Root Port (Slot+), MSI 00
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevCap: MaxPayload 256 bytes, PhantFunc 0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtTag=
- RBE+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RlxdOr=
d- ExtTag- PhantFunc- AuxPwr- NoSnoop-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MaxPay=
load 256 bytes, MaxReadReq 128 bytes
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-=20
AuxPwr- TransPend-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkCap: Port #2, Speed 8GT/s, Width x4, ASPM L1, Exit=20
Latency L1 <16us
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ClockP=
M- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommC=
lk+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtSyn=
ch- ClockPM- AutWidDis- BWInt- AutBWInt-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkSta: Speed 8GT/s (ok), Width x4 (ok)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TrErr-=
 Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-=20
HotPlug- Surprise-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Slot #=
2, PowerLimit 0.000W; Interlock- NoCompl-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt=
-=20
HPIrq- LinkChg-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Contro=
l: AttnInd Off, PwrInd Off, Power- Interlock-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-=20
PresDet+ Interlock-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Change=
d: MRL- PresDet+ LinkState+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RootCap: CRSVisible+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-=20
PMEIntEna+ CRSVisible+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: Range BCD, TimeoutDis+=20
NROPrPrP- LTR-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
10BitTagComp- 10BitTagReq- OBFF Not Supported,=20
ExtFmt- EETLPPrefix-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
EmergencyPowerReduction Not Supported,=20
EmergencyPowerReductionInit-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
FRS- LN System CLS Not Supported, TPHComp+=20
ExtTPHComp- ARIFwd+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
=20
LTR- OBFF Disabled, ARIFwd-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
AtomicOpsCtl: ReqEn- EgressBlck-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-=20
Retimer- 2Retimers- DRS-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance-=20
SpeedDis-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Compliance De-emphasis: -6dB
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis Level: -6dB,=20
EqualizationComplete+ EqualizationPhase1+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
EqualizationPhase2+ EqualizationPhase3+=20
LinkEqualizationRequest-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Retimer- 2Retimers- CrosslinkRes: unsupported
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [e0] Power Mana=
gement version 3
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Vendor=
 Specific Information: ID=3D0002=20
Rev=3D0 Len=3D00c <?>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [110 v1] Access=
 Control Services
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+=20
UpstreamFwd+ EgressCtrl- DirectTrans-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+=20
UpstreamFwd+ EgressCtrl- DirectTrans-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [148 v1] Advanc=
ed Error Reporting
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 UESta:=C2=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-=20
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 UEMsk:=C2=A0 DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-=20
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-=20
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 CESta:=C2=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeout=
-=20
AdvNonFatalErr-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 CEMsk:=C2=A0 RxErr- BadTLP- BadDLLP- Rollover- Timeout=
-=20
AdvNonFatalErr+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn=
-=20
ECRCChkCap- ECRCChkEn-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MultHd=
rRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HeaderLog: 00000000 00000000 00000000 00000000
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RootCmd: CERptEn+ NFERptEn+ FERptEn+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [1d0 v1] Vendor=
 Specific Information: ID=3D0003=20
Rev=3D1 Len=3D00a <?>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [250 v1] Second=
ary PCI Express
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LaneErrStat: 0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [280 v1] Vendor=
 Specific Information: ID=3D0005=20
Rev=3D3 Len=3D018 <?>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [300 v1] Vendor=
 Specific Information: ID=3D0008=20
Rev=3D0 Len=3D038 <?>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: pciepor=
t

lspci -xxxx -s 00:01.1
00:01.1 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI=20
Express Root Port 1 (rev 02)
00: 86 80 03 2f 07 04 10 00 02 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 05 05 00 f0 00 00 00
20: 60 fb 60 fb f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 12 00
40: 0d 60 00 00 86 80 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 05 90 03 01 58 02 e0 fe 00 00 00 00 02 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 10 e0 42 01 01 80 00 00 2f 00 00 00 43 38 7a 02
a0: 42 00 43 b0 00 00 10 00 c0 03 48 01 18 00 01 00
b0: 00 00 00 00 be 13 00 00 00 00 00 00 0e 00 00 00
c0: 03 00 1e 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 01 00 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
100: 0b 00 01 11 02 00 c0 00 07 31 00 00 00 00 00 00
110: 0d 00 81 14 1f 00 1d 00 00 00 00 00 00 00 00 00
120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
140: 00 00 00 00 00 00 00 00 01 00 01 1d 00 00 00 00
150: 00 00 00 00 30 20 06 00 00 00 00 00 00 20 00 00
160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
170: 00 00 00 00 07 00 00 00 00 00 00 00 00 00 00 00
180: 91 30 18 00 00 00 00 00 40 10 10 e4 20 00 00 00
190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1d0: 0b 00 01 25 03 00 a1 00 00 00 00 00 00 00 00 00
1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
210: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
250: 19 00 01 28 00 00 00 00 00 00 00 00 77 27 77 27
260: 77 27 77 27 00 00 00 00 00 00 00 00 00 00 00 00
270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
280: 0b 00 01 30 05 00 83 01 00 00 00 40 00 00 00 00
290: 00 00 00 00 00 00 00 00 0b 00 01 30 07 00 40 02
2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
300: 0b 00 01 00 08 00 80 03 00 00 00 00 0f 00 00 00
310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
710: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


lspci -vvvv -s 00:1c.4
00:1c.4 PCI bridge: Intel Corporation C610/X99 series chipset PCI=20
Express Root Port #5 (rev d5) (prog-if 00 [Normal decode])
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+=
 SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- Fast=
B2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Latency: 0, Cache Line Size: =
64 bytes
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IR=
Q 34
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NUMA node: 0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IOMMU group: 31
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D=
0c, subordinate=3D0c, sec-latency=3D0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O behind bridge: 0000b000-0=
000bfff [size=3D4K]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory behind bridge: fb40000=
0-fb4fffff [size=3D1M]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Prefetchable memory behind br=
idge:=20
00000000fff00000-00000000000fffff [disabled]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Secondary status: 66MHz- Fast=
B2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- <SERR- <PERR-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BridgeCtl: Parity- SERR+ NoIS=
A- VGA- VGA16+ MAbort- >Reset-=20
FastB2B-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [40] Express (v=
2) Root Port (Slot-), MSI 00
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevCap: MaxPayload 128 bytes, PhantFunc 0
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtTag=
- RBE+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RlxdOr=
d- ExtTag- PhantFunc- AuxPwr- NoSnoop-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MaxPay=
load 128 bytes, MaxReadReq 128 bytes
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-=20
AuxPwr+ TransPend-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkCap: Port #5, Speed 5GT/s, Width x2, ASPM L0s L1,=20
Exit Latency L0s <512ns, L1 <16us
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ClockP=
M- Surprise- LLActRep+ BwNot+ ASPMOptComp-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk=
+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ExtSyn=
ch- ClockPM- AutWidDis- BWInt- AutBWInt-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkSta: Speed 5GT/s (ok), Width x1 (downgraded)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TrErr-=
 Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RootCap: CRSVisible-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-=20
PMEIntEna+ CRSVisible-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: Range ABC, TimeoutDis+=20
NROPrPrP- LTR+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
10BitTagComp- 10BitTagReq- OBFF Not Supported,=20
ExtFmt- EETLPPrefix-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
EmergencyPowerReduction Not Supported,=20
EmergencyPowerReductionInit-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
FRS- LN System CLS Not Supported, TPHComp-=20
ExtTPHComp- ARIFwd-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-=
=20
LTR- OBFF Disabled, ARIFwd-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
AtomicOpsCtl: ReqEn- EgressBlck-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-=20
SpeedDis-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance- ComplianceSOS-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Compliance De-emphasis: -6dB
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis Level: -6dB,=20
EqualizationComplete- EqualizationPhase1-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
EqualizationPhase2- EqualizationPhase3-=20
LinkEqualizationRequest-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Retimer- 2Retimers- CrosslinkRes: unsupported
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [80] MSI: Enabl=
e+ Count=3D1/1 Maskable- 64bit-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Address: fee00398=C2=A0 Data: 0000
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [90] Subsystem:=
 ASUSTeK Computer Inc. C610/X99=20
series chipset PCI Express Root Port
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [a0] Power Mana=
gement version 3
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,D3cold+)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 =
PME-
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: pciepor=
t

lspci -xxxx -s 00:1c.4
00:1c.4 PCI bridge: Intel Corporation C610/X99 series chipset PCI=20
Express Root Port #5 (rev d5)
00: 86 80 18 8d 07 04 10 00 d5 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 0c 0c 00 b0 b0 00 00
20: 40 fb 40 fb f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 12 00
40: 10 80 42 00 00 80 00 00 00 00 10 00 22 3c 32 05
50: 40 00 12 70 00 00 04 00 00 00 40 01 08 00 00 00
60: 00 00 00 00 17 08 00 00 00 00 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 01 00 98 03 e0 fe 00 00 00 00 00 00 00 00
90: 0d a0 00 00 43 10 00 86 00 00 00 00 00 00 00 00
a0: 01 00 03 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 01 42 18 00 00 08 80 91 89 00 00 00 00
e0: 00 3f 00 00 00 00 00 00 01 00 00 00 00 00 00 00
f0: 50 00 00 00 40 00 00 00 b1 0f 06 08 00 68 00 05
100: 00 00 00 00 00 00 00 00 00 00 00 00 11 00 06 00
110: 00 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00
120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
310: 00 00 00 00 1b 36 3a 74 00 00 14 14 31 17 42 00
320: 5b 60 09 00 20 20 5a 0a fc 1f 38 33 fb 0f f1 0a
330: 16 00 00 28 bc b5 bc 4a 00 00 00 00 74 4c 85 00
340: 33 0a 33 00 37 0a 37 00 e7 0b 7c 00 31 0e c0 00
350: 33 0e c2 00 01 00 dd 00 41 04 09 00 00 00 00 00
360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400: 00 00 00 00 00 00 00 00 22 14 01 04 00 00 00 00
410: 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00
420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
710: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

>>>> diff -ur linux-5.9.1.orig/drivers/pci/pci.c linux-5.9.1/drivers/pci/=
pci.c
>>>> --- linux-5.9.1.orig/drivers/pci/pci.c  2020-10-17 08:31:22.00000000=
0 +0200
>>>> +++ linux-5.9.1/drivers/pci/pci.c       2020-10-27 19:01:32.65001080=
3 +0100
>>>> @@ -3502,9 +3502,7 @@
>>>>   void pci_acs_init(struct pci_dev *dev)
>>>>   {
>>>>          dev->acs_cap =3D pci_find_ext_capability(dev, PCI_EXT_CAP_I=
D_ACS);
>>>> -
>>>> -       if (dev->acs_cap)
>>>> -               pci_enable_acs(dev);
>>>> +       pci_enable_acs(dev);
>>>>   }
>>>>
>>>>   /**
>>>>
> Ack, yes, this is what needs to be done, and I just sent a patch at
> https://lkml.org/lkml/2020/10/28/693.
>
> Thanks,
>
> Rajat
>

