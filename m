Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE629EA5D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 12:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgJ2LS6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 07:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgJ2LS5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 07:18:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E008DC0613CF
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 04:18:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n15so2345836wrq.2
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 04:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:reply-to:to:cc:references:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=WyL920ofd2vowRUtqKGdBv+LCWhNvtNVkMlCncbQITU=;
        b=n8JJDbkNQGEzD+yui/lk5gZcYWfF4Ill2FRRh/0tp7bytE1AdZvrRurMDat+liR/my
         85a7/BWQcJaewYBieFVOd1JsDyMMBnDkgFPF+kcHe1WnFs582Q2zPRDz48dJ9V4nro3a
         TSLbdF/uI99GvOYaI+V57ozh4181M9goZkEVaHtMiquDVK4Ez2VRktr1bqh19riN/wdY
         I8b27BnaPs2nkj4yGqDobERv4vNaV0J6W0QH54B0fDvIqqfGNpA4/n1KItdcXQnBlE2X
         NC5PiXZNrtxYnvi1FKPjLYZ1g08S/X4iGNFqcHPyIXivOwVpbRB2k5rGhGeaoMpcDsmJ
         KI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=WyL920ofd2vowRUtqKGdBv+LCWhNvtNVkMlCncbQITU=;
        b=pvsdq5fnyChZR/Ld2AabULt6yXSw8cI0xZGnouCHGqPfOKRFhM5QtkGqCXRcObs1FT
         TcLAU/FF59aO/oV7p4APDB2qdohXhz0HC4qBZAbKhBFFk1a+0EBkCfsHFizUCj3KQyCK
         boBtqppSokrXPQQHEfnGmkOBPUHdhB+gPfE/LHQyjnzbyHKCPrSBwDBNgSN49w75luxJ
         iUzD5ZahGX2pgIzaZY2RKH0ChRr6Y5ECFkfIzmZejvRDDaF9/PyzTl2dybuBI7xeX1Hu
         FgbUwjzV6wy0mcmBafUerDgQhe7EtAhd6zM+5ByeOJ8RpjB9BzYOz05Cki4feb7SsCOo
         CgYA==
X-Gm-Message-State: AOAM532UDYV17Ktn6Uf0hTke280NkMNAJSAWSYNnMxS/ewjjYDA5SSkw
        zHRoqaAzGZAr57oTJKM1ymc=
X-Google-Smtp-Source: ABdhPJwUBlxv4azbpAF5T0cvzTxIoEefhQuSymqiRnhQJhCrr77crF4CZEx/r6iCe+fumxFTufxc3g==
X-Received: by 2002:adf:fc83:: with SMTP id g3mr4908586wrr.200.1603970335542;
        Thu, 29 Oct 2020 04:18:55 -0700 (PDT)
Received: from [192.168.43.216] (x590fedf7.dyn.telefonica.de. [89.15.237.247])
        by smtp.gmail.com with UTF8SMTPSA id d129sm3969037wmd.5.2020.10.29.04.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 04:18:54 -0700 (PDT)
From:   "=?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?=" <vtolkm@googlemail.com>
X-Google-Original-From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
References: <20201028231626.GA344207@bjorn-Precision-5520>
 <877dr9mi0g.fsf@toke.dk>
Autocrypt: addr=vtolkm@gmail.com; keydata=
 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
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <0bedff56-cd1d-0507-d9bb-e8f5c86f9509@gmail.com>
Date:   Thu, 29 Oct 2020 11:18:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <877dr9mi0g.fsf@toke.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hmnSbG3MRi5L2Kmpt5VPx1fU9sJ0DNi7L"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hmnSbG3MRi5L2Kmpt5VPx1fU9sJ0DNi7L
Content-Type: multipart/mixed; boundary="TvqYAiPC70PLcZchyLsDHawBtJXVsvlKk";
 protected-headers="v1"
From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?=
 <pali@kernel.org>, =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>
Message-ID: <0bedff56-cd1d-0507-d9bb-e8f5c86f9509@gmail.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
References: <20201028231626.GA344207@bjorn-Precision-5520>
 <877dr9mi0g.fsf@toke.dk>
In-Reply-To: <877dr9mi0g.fsf@toke.dk>

--TvqYAiPC70PLcZchyLsDHawBtJXVsvlKk
Content-Type: multipart/mixed;
 boundary="------------D47E9A8FF1C98BF64EFDE0D7"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------D47E9A8FF1C98BF64EFDE0D7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 29/10/2020 11:41, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
>
>> [+cc Pali, Marek, Thomas, Jason]
>>
>> On Wed, Oct 28, 2020 at 04:40:00PM +0000, =E2=84=A2=D6=9F=E2=98=BB=D2=87=
=CC=AD =D1=BC =D2=89 =C2=AE wrote:
>>> On 28/10/2020 16:08, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Bjorn Helgaas <helgaas@kernel.org> writes:
>>>>> On Wed, Oct 28, 2020 at 02:36:13PM +0100, Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
>>>>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>>>>>> Bjorn Helgaas <helgaas@kernel.org> writes:
>>>>>>>
>>>>>>>> [+cc vtolkm]
>>>>>>>>
>>>>>>>> On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke H=C3=B8iland-J=C3=
=B8rgensen wrote:
>>>>>>>>> Hi everyone
>>>>>>>>>
>>>>>>>>> I'm trying to get a mainline kernel to run on my Turris Omnia, =
and am
>>>>>>>>> having some trouble getting the PCI bus to work correctly. Spec=
ifically,
>>>>>>>>> I'm running a 5.10-rc1 kernel (torvalds/master as of this momen=
t), with
>>>>>>>>> the resource request fix[0] applied on top.
>>>>>>>>>
>>>>>>>>> The kernel boots fine, and the patch in [0] makes the PCI devic=
es show
>>>>>>>>> up. But I'm still getting initialisation errors like these:
>>>>>>>>>
>>>>>>>>> [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000=
004 !=3D 0xffffffff)
>>>>>>>>> [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x=
000000 !=3D 0xffffffff)
>>>>>>>>> [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200=
004 !=3D 0xffffffff)
>>>>>>>>> [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x=
000000 !=3D 0xffffffff)
>>>>>>>>>
>>>>>>>>> and the WiFi drivers fail to initialise with what appears to me=
 to be
>>>>>>>>> errors related to the bus rather than to the drivers themselves=
:
>>>>>>>>>
>>>>>>>>> [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not support=
ed by this driver
>>>>>>>>> [    3.517049] ath: phy0: Unable to initialize hardware; initia=
lization status: -95
>>>>>>>>> [    3.524473] ath9k 0000:01:00.0: Failed to initialize device
>>>>>>>>> [    3.530081] ath9k: probe of 0000:01:00.0 failed with error -=
95
>>>>>>>>> [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: faile=
d with rc=3D134
>>>>>>>>> [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 0142)=

>>>>>>>>> [    3.548735] ath10k_pci 0000:02:00.0: can't change power stat=
e from D3hot to D0 (config space inaccessible)
>>>>>>>>> [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up devic=
e : -110
>>>>>>>>> [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with er=
ror -110
>>>>>>>>>
>>>>>>>>> lspci looks OK, though:
>>>>>>>>>
>>>>>>>>> # lspci
>>>>>>>>> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (=
rev 04)
>>>>>>>>> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (=
rev 04)
>>>>>>>>> 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (=
rev 04)
>>>>>>>>> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Ne=
twork Adapter (PCI-Express) (rev 01)
>>>>>>>>> 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.1=
1ac Wireless Network Adapter (rev ff)
>>>>>>>>>
>>>>>>>>> Does anyone have any clue what could be going on here? Is this =
a bug, or
>>>>>>>>> did I miss something in my config or other initialisation? I've=
 tried
>>>>>>>>> with both the stock u-boot distributed with the board, and with=
 an
>>>>>>>>> upstream u-boot from latest master; doesn't seem to make any di=
fferent.
>>>>>>>> Can you try turning off CONFIG_PCIEASPM?  We had a similar recen=
t
>>>>>>>> report at https://bugzilla.kernel.org/show_bug.cgi?id=3D209833 b=
ut I
>>>>>>>> don't think we have a fix yet.
>>>>>>> Yes! Turning that off does indeed help! Thanks a bunch :)
>>>>>>>
>>>>>>> You mention that bisecting this would be helpful - I can try that=

>>>>>>> tomorrow; any idea when this was last working?
>>>>>> OK, so I tried to bisect this, but, erm, I couldn't find a working=

>>>>>> revision to start from? I went all the way back to 4.10 (which is =
the
>>>>>> first version to include the device tree file for the Omnia), and =
even
>>>>>> on that, the wireless cards were failing to initialise with ASPM
>>>>>> enabled...
>>>>> I have no personal experience with this device; all I know is that =
the
>>>>> bugzilla suggests that it worked in v5.4, which isn't much help.
>>>>>
>>>>> Possibly the apparent regression was really a .config change, i.e.,=

>>>>> CONFIG_PCIEASPM was disabled in the v5.4 kernel vtolkm@ tested and =
it
>>>>> "worked" but got enabled later and it started failing?
>>>> Yeah, I suspect so. The OpenWrt config disables CONFIG_PCIEASPM by
>>>> default and only turns it on for specific targets. So I guess that i=
t's
>>>> most likely that this has never worked...
>>>>
>>>>> Maybe the debug patch below would be worth trying to see if it make=
s
>>>>> any difference?  If it *does* help, try omitting the first hunk to =
see
>>>>> if we just need to apply the quirk_enable_clear_retrain_link() quir=
k.
>>>> Tried, doesn't help...
>>>>
>>>> -Toke
>>> Found this patch
>>>
>>> https://github.com/openwrt/openwrt/blob/7c0496f29bed87326f1bf591ca25a=
ce82373cfc7/target/linux/mvebu/patches-5.4/405-PCI-aardvark-Improve-link-=
training.patch
>>>
>>> that mentions the Compex WLE900VX card, which reading the lspci verbo=
se
>>> output from the bugtracker seems to the device being troubled.
>> Interesting.  Indeed, the Compex WLE900VX card seems to have the
>> Qualcomm Atheros QCA9880 on it, and it looks like Toke's system has
>> the same device in it.
>>
>> The patch you mention (https://git.kernel.org/linus/43fc679ced18) is
>> for aardvark, so of course doesn't help mvebu.
>>
>> PCIe hardware is supposed to automatically negotiate the highest link
>> speed supported by both ends.  But software *is* allowed to set an
>> upper limit (the Target Link Speed in Link Control 2).  If we initiate=

>> a retrain and the link doesn't come back up, I wonder if we should try=

>> to help the hardware out by using Target Link Speed to limit to a
>> lower speed and attempting another retrain, something like this hacky
>> patch: (please collect the dmesg log if you try this)
> Well, I tried it, but don't see any of the 'lnkcap2' output from that
> new function:
>
> [    1.545853] mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> [    1.545878] mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff=
 -> 0x0000080000
> [    1.545894] mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff=
 -> 0x0000040000
> [    1.545907] mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff=
 -> 0x0000044000
> [    1.545920] mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff=
 -> 0x0000048000
> [    1.545933] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ff=
fffffe -> 0x0100000000
> [    1.545945] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ff=
fffffe -> 0x0100000000
> [    1.545958] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ff=
fffffe -> 0x0200000000
> [    1.545970] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ff=
fffffe -> 0x0200000000
> [    1.545982] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ff=
fffffe -> 0x0300000000
> [    1.545994] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ff=
fffffe -> 0x0300000000
> [    1.546006] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ff=
fffffe -> 0x0400000000
> [    1.546014] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ff=
fffffe -> 0x0400000000
> [    1.546181] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> [    1.546190] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    1.546197] pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf10=
81fff] (bus address [0x00080000-0x00081fff])
> [    1.546204] pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf10=
41fff] (bus address [0x00040000-0x00041fff])
> [    1.546210] pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf10=
45fff] (bus address [0x00044000-0x00045fff])
> [    1.546216] pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf10=
49fff] (bus address [0x00048000-0x00049fff])
> [    1.546220] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7f=
fffff]
> [    1.546225] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> [    1.546294] pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
> [    1.546308] pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff p=
ref]
> [    1.546482] pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
> [    1.546495] pci 0000:00:02.0: reg 0x38: [mem 0x00000000-0x000007ff p=
ref]
> [    1.546643] pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
> [    1.546656] pci 0000:00:03.0: reg 0x38: [mem 0x00000000-0x000007ff p=
ref]
> [    1.547379] PCI: bus0: Fast back to back transfers disabled
> [    1.547387] pci 0000:00:01.0: bridge configuration invalid ([bus 00-=
00]), reconfiguring
> [    1.547394] pci 0000:00:02.0: bridge configuration invalid ([bus 00-=
00]), reconfiguring
> [    1.547402] pci 0000:00:03.0: bridge configuration invalid ([bus 00-=
00]), reconfiguring
> [    1.547484] pci 0000:01:00.0: [168c:002e] type 00 class 0x028000
> [    1.547507] pci 0000:01:00.0: reg 0x10: [mem 0xe8000000-0xe800ffff 6=
4bit]
> [    1.547615] pci 0000:01:00.0: supports D1
> [    1.547620] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
> [    1.547730] pci 0000:00:01.0: ASPM: current common clock configurati=
on is inconsistent, reconfiguring
> [    1.631937] PCI: bus2: Fast back to back transfers enabled
> [    1.631945] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to=
 02
> [    1.632655] PCI: bus3: Fast back to back transfers enabled
> [    1.632662] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to=
 03
> [    1.632694] pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00f=
ffff]
> [    1.632702] pci 0000:00:02.0: BAR 8: assigned [mem 0xe0200000-0xe04f=
ffff]
> [    1.632710] pci 0000:00:01.0: BAR 6: assigned [mem 0xe0100000-0xe010=
07ff pref]
> [    1.632718] pci 0000:00:02.0: BAR 6: assigned [mem 0xe0500000-0xe050=
07ff pref]
> [    1.632726] pci 0000:00:03.0: BAR 6: assigned [mem 0xe0600000-0xe060=
07ff pref]
> [    1.632734] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0000000-0xe000=
ffff 64bit]
> [    1.632741] pci 0000:01:00.0: BAR 0: error updating (0xe0000004 !=3D=
 0xffffffff)
> [    1.632746] pci 0000:01:00.0: BAR 0: error updating (high 0x000000 !=
=3D 0xffffffff)
> [    1.632752] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    1.632760] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00f=
ffff]
> [    1.632769] pci 0000:02:00.0: BAR 0: assigned [mem 0xe0200000-0xe03f=
ffff 64bit]
> [    1.632776] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 !=3D=
 0xffffffff)
> [    1.632782] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 !=
=3D 0xffffffff)
> [    1.632788] pci 0000:02:00.0: BAR 6: assigned [mem 0xe0400000-0xe040=
ffff pref]
> [    1.632793] pci 0000:00:02.0: PCI bridge to [bus 02]
> [    1.632800] pci 0000:00:02.0:   bridge window [mem 0xe0200000-0xe04f=
ffff]
> [    1.632807] pci 0000:00:03.0: PCI bridge to [bus 03]
>
> (and then later, still):
> [    3.476364] pci 0000:00:01.0: enabling device (0140 -> 0142)
> [    3.477542] ata1: SATA link down (SStatus 0 SControl 300)
> [    3.482126] ath9k 0000:01:00.0: enabling device (0000 -> 0002)
> [    3.487487] ata2: SATA link down (SStatus 0 SControl 300)
> [    3.493379] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by th=
is driver
> [    3.505891] ath: phy0: Unable to initialize hardware; initialization=
 status: -95
> [    3.513325] ath9k 0000:01:00.0: Failed to initialize device
> [    3.518933] ath9k: probe of 0000:01:00.0 failed with error -95
> [    3.524862] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed with r=
c=3D134
> [    3.531904] pci 0000:00:02.0: enabling device (0140 -> 0142)
> [    3.537590] ath10k_pci 0000:02:00.0: can't change power state from D=
3hot to D0 (config space inaccessible)
> [    3.577436] ath10k_pci 0000:02:00.0: failed to wake up device : -110=

> [    3.583948] ath10k_pci: probe of 0000:02:00.0 failed with error -110=

>
>
> -Toke
>

Same result my end - run tested with next-20201027

N.B. node does not boot anymore with next-20201028, but that that is=20
independent of this patch and apparently another issue.

--------------D47E9A8FF1C98BF64EFDE0D7
Content-Type: application/pgp-keys;
 name="OpenPGP_0x729CFF47A416598B.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0x729CFF47A416598B.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFnci1cBEADV+6MUQB11XNt9PDm/dG33t5n6G5UhCjvkAYwgqwzemL1hE/z4/OfidLLY8=
Zgi
Jy6/Vsxwi6B9BM54RRCLqniD+GKc6vZVzx9mr4M1rYmGmTobXyDVR1cXDJC5khUx9pC++oUDP=
bCs
i8uXqKHCuqNNB7Xx6SrWJkVcY8hMnGg6QvOK7ZDY5JOCWw9UEcdQuUFx9y/ar2xreikE4r3+X=
ZUZ
xqKVkvJS6IvgiOnDtic0gq2u23vlXPXkkrijmVJi7igA4qVRV4aT8vzqyAM0c2NaQk4UcLkaf=
+Wc
5oCz0Xv1ao3VTXqU0eYH5xvAAfYqmfIeqRvakOfIzpuNpWEQKhjn6cQtNtMN4SVGs5Uu09OVq=
TVu
vP7CeZNt3QQ13OJLZ/y4mpikQTFXjlQSkw51tH3VqJE+GJ3lE/Z1Slb/kbc40ZghriZqH8MDL=
MPu
juMuI0ki+3KPpnd6gAiMVcm/ZR9Zay14F6pHP3AfUYxt+wQHbDemPmxPijTrCwK0HmADOg+n5=
jzL
dCXOnZlZgr5EHIzAox8qpybBH6XLwGOfRb1YszH8aeCiE3KOnvSzFJt4tW3bRUAXIsfU9Hau0=
y2Z
d29hs5KT6p3W6Evo41L9YZ2Kh49nEH30LZWU3ef0gJTsk5JADz1qcc2D3w+I2rNvzN7NbT7OL=
CGB
H5BjXmRFLvmR9wARAQABzRB2dG9sa21AZ21haWwuY29twsGUBBMBCAA+FiEEZA5pVNb1NUiO3=
cgJ
cpz/R6QWWYsFAlnci1cCGwMFCQYRI9kFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQcpz/R=
6QW
WYuWoQ//RqAvkxS8SCYeCS9V2ozBBzGl+n4Duk8R/JH9MF31MBSqz6wT1fWSu4sKUIgyvOlHn=
JMQ
HFC5zWfBl3czTcXiKC02SCqw0TyekCrWsCGbNDtAXQ0pVwIrAAjHSHlt1szaZVmA8fW/WAAK/=
cx4
GyMHa7J9Ll2S7fAiIjGCBsWskO9PMaWCmxZ/1CXucMr9q+7CZaDHyIFx4zuzYY06in8H7k+iA=
aCA
uppOlI7/KZ2bgEUB71EgkJog0MGJyTfnztso1E7DHwg/E8TryAr8GPdNDx6L+wcyrAH/30dDp=
WoU
mAURwsCj8o5fu2/b+7bpNt9D0ZipO+swhfBGs16OI0eydgU7tvFlge9fPeJQ618R7h4jLAyA4=
g8X
SwqsDG5pJV4Pp+F6RgJu21U/6C3IdOJLY3ZLXJ1vNsC9Ymj46TuozAqsgJ9c1QMkASCNYqa35=
ag/
to8vBfAcOH5CgpsDaISs+fXPtjZfIE+q7aapvNNrY2cg3d1DzwgiVRPCa3owCGO29biJVIJ/W=
oVC
kLTJbzY0W2T0gB3dGzeL8Wr4GYOaqH9qWq0SvYXLosRoTrAi2heC5sUghTfUnc2mF4iVmyJNp=
mjx
ov/fnAlOcjOrBs2g7LTD9F9eVldb54F49s0RqTPyc6qpygYBHYHql3afpfZgHhHEU62SQ8hrq=
qc/
mrySjlDOwU0EWdyLVwEQAL1H9kXHD02X8DPokRtFyToTdbJshYMsKnpILTQ3UJgUXreTDBUYT=
vBG
oPEhlQVlFNvND6cy08IcdDi0VHl/aLm/oRVJa/AlAXPAad4HnEB0RckuKfoSQoq0UDRmM+DLi=
jgu
oEwSUfwfuk9XGs1arnaLNV+kJvj1O/cvwRDfPiFwYBFfNOO0iDWdVSOCGWirNLUBdpx4hWX0n=
XqH
u0wql8bGInqNPp4Cc36VtCEid6aORhfzkplfmQUchHNblpYOFqdqNX2qQhfrN/nNY5fNhEyu6=
MSe
SdahWYEC0RH17bTX+gmwJ61AwvgS1tsRL4ekzRtquDC4FUGLDrl2EM9FuqW/3Pr0Z8o2afjek=
LPF
G/sEsuDdloBYQG/6bPKbNMnd19db09OzO+GgsiX/A7he0WAKz3fA1WSSY7FH4275islD9v+tL=
RRS
spe4MRmV48tyysmHrzFXRZhrGT+M+qCX5a7KyOKV5o7odBTclI2nbm49a9gaskPQb2na37Wh+=
9/9
+fWdn8MnS1cPbtjQuFGeOnFGoZ2FJ1kZFSW3ZNH/zsUX1LMkI/fA109zy3rOzStZEXgNahfIP=
/uS
qP6N4/RbQY4WmtbURQEXe+CYNfI0Q5dwy9q/95+wzdwSLJMSksJERKVTRE1cvld03oIJEbSvZ=
A50
g1m1jqQJNjG3zHs4aoaxABEBAAHCwXwEGAEIACYWIQRkDmlU1vU1SI7dyAlynP9HpBZZiwUCW=
dyL
VwIbDAUJBhEj2QAKCRBynP9HpBZZi2O1EACpzIUzidoN+jFBPKwD+TD1oWBjwXb2XtJw/ztBx=
/XH
n7diGw8wh0wSpKr8/KtT2boSBLL4CyxWA2h+XO+TYuzyaGzB9gqPB6ghIByXpzdNS/bahaO9E=
dw1
3HWvy7Kn1E/uugrEveFNscx7yVtKXA90E7RYGRnrXuVnZJwjCkS8719+QMEJST6ZUK+Fw5rAI=
YZx
pZk1ZUrDN5VBtRWSSUv/cwkmyVenX+Ix+hDGnPseFtEwuLu/hxtE/Mp2A5M/d/hPININEDVxX=
jRy
PYf1/zLcC+l72dwIyZER2zvRBiwPJhWZi56WfmnoTIVfUeyDfY1IW6OlUbur/r0gpW4sAKNd2=
/70
5wtGd8n/W6jT3nFfsfk8Tw83FpJYjmQCft3r5yQiMcC8jBPXh3QUXKcAGafT8BH5S8tBRyt9i=
hSO
xoCU+/2LUwNVMn8Po/lN5RmXDvbuIeP3EQTMRjTZDOujXzCE64PJCr9Gn6DasIEtjCLSWVIy7=
Hf0
bmxHySkhZyl2u+2uA8kUMQzrZS/dEF5d7EeG69eKRFhs7e1jEgfOoX48q5D9Wwk3kiIe3rAN0=
4w4
cIPBfY9W9tsF8DoP0I3G2hp41r5FYktkVwyktIzrktnJprnpw6pOtFdsFe8hboqTitA8WCmUo=
hYz
6g5W+3igWYa5LWJ8nxCJbQIZaeAoTkFyGw=3D=3D
=3DBH6L
-----END PGP PUBLIC KEY BLOCK-----

--------------D47E9A8FF1C98BF64EFDE0D7--

--TvqYAiPC70PLcZchyLsDHawBtJXVsvlKk--

--hmnSbG3MRi5L2Kmpt5VPx1fU9sJ0DNi7L
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZA5pVNb1NUiO3cgJcpz/R6QWWYsFAl+apRwFAwAAAAAACgkQcpz/R6QWWYtA
KBAAwT0ofD/f+GClyXHtnfD18/OaP360Wpo44T8+OI5n6U16lETxTbJ3U3lnAdhW41mGvJkEmZ6H
/rclyn6ePHWAOQLMpQBtREZQ5tXTgFpXl0YrgZfhZHaicNaLOdbTxkONTdIWIDvz9Gaxv7AQA0oB
A2l/0ag0kkDWfI3RNMY/Nnrc+mivZ7aQEKT4Es3gnGJl6LJiM2nkGAzDHQCtUtw5owtYzU8uY1cN
aXavKSj3psJ8NRocxqwzSu6PBeBb2aZ8W1DCjBOpE3AxvZmmP4TP5IqLM7VDZq5JRY7nTgMVu8VC
VGNcd50z09o1ts9KrVcbP9jkuuzyGNA8PX/wvX0FjEGGKg9qNjMxHjSLof1naJrktBtxZx/oIfe1
3Q2dJFSnJAci5QATsWkK7g3q6+AJ628pp99HCPDdTvgS4KGz66cJQHywz/mTwFh3I/PE77zFTgQU
y41o3tjVBdqAW5io9meGc9ZPYG2Q1kheAhAGUGKEhj4QeKrZCxFOeWWKDNUslwKyWf62EvnVJHlA
x5VFHTRllrMpAI04SfOlVOse9FPVJ6bty4K65GeqFw4jWPOOpd63sD0VfGAkgtIDUhK2fZnRZArl
RTWwr/+SYXlIQhtjuOR8Vqf7x6V5vC2BB9aQRexcBy/TlxVTvQdKzoOREkCTuA3pJN3eAzElxEhQ
/wg=
=hZlu
-----END PGP SIGNATURE-----

--hmnSbG3MRi5L2Kmpt5VPx1fU9sJ0DNi7L--
