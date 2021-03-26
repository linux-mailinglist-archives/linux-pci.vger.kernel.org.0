Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E75F34ADF0
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 18:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhCZRwN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 13:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbhCZRvu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 13:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616781109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bUHfQEVnwJcL+I43j9heU4tQ9gjEiNopTgf2SxdRXaY=;
        b=cyn9siLb/g1L0AWj3yIqFfmbYAQ7d5NIY8h2d8Czr7ovOlX3aacNmN8iIUHjuQ3Y5bvYFZ
        79q9JF+uA/IrS0+p+146hkBw2obMxgvUac1uy6hxVBdYN513b2iIMsqmKIaakN6VyUxNzr
        Ep0DSXJNMFRfkV1GX+kvSZTks/2X038=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-ee3jKgLjNLadT83OxjICdA-1; Fri, 26 Mar 2021 13:51:47 -0400
X-MC-Unique: ee3jKgLjNLadT83OxjICdA-1
Received: by mail-ed1-f71.google.com with SMTP id w16so4816749edc.22
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 10:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bUHfQEVnwJcL+I43j9heU4tQ9gjEiNopTgf2SxdRXaY=;
        b=myNCdZUonUJuvtF3yI0ar+5O8VKrsor7+pS9KZ9j0hXSNCFSd6dOjfyEyITWRvbHNu
         aT01Q18IG1eKqRRLvj2B+BJU9Wgif1o6UtrPWH+b0Z9pMy+11QBWvfgf1ZGXgpu0pbTf
         UccTcwxC6Ll2ocm49yazoXAwL3cW8PRsACT9Qj2UG7X/ixDfd0InhdJ4NPWcNmBefTjw
         /oeznY0s5BimoYN/RhQ/NE/lRkI03KgWx5eZ3uyxN+VJaA9FALsN28PyPQsYOpMOVjTl
         3deUo+QrEYFZLJszV7C0miZqd4hLLMkGLwrOocEMpZp7p/xF94S8nT8mkd5LyVg/lbBz
         3ePw==
X-Gm-Message-State: AOAM532RmjX7QkXmrJBJKibeABe7rWCYhDwT+K7R+opDuw82q3KgISuE
        Za6zmbbL8vRfNxc/Mt4ArcQYcocoejO3yW13ufExHhrLzx8bR0tXmJKcGmy8FHsBMOqmg0G/Iap
        GXSmaEXiljfWQClEjJX0b
X-Received: by 2002:a17:906:6882:: with SMTP id n2mr16488798ejr.50.1616781104866;
        Fri, 26 Mar 2021 10:51:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFsQc8mDN3RnPAV9vd0H3bgN0d999W/IYMPG1GroRhZ5Vl85IVmo1q7aNXsabitkm8BCReSQ==
X-Received: by 2002:a17:906:6882:: with SMTP id n2mr16488772ejr.50.1616781104362;
        Fri, 26 Mar 2021 10:51:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f19sm4593943edu.12.2021.03.26.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 10:51:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C5C4B1801A3; Fri, 26 Mar 2021 18:51:42 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     vtolkm@gmail.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20210326171100.s53mslkjc7tdgs6f@pali>
References: <20201102152403.4jlmcaqkqeivuypm@pali> <877dr3lpok.fsf@toke.dk>
 <20210315195806.iqdt5wvvkvpmnep7@pali>
 <20210316092534.czuondwbg3tqjs6w@pali> <87h7l8axqp.fsf@toke.dk>
 <20210318231629.vhix2cqpt25bgrne@pali>
 <20210326125028.tyqkcc5fvaqbwqkn@pali> <874kgyc4yg.fsf@toke.dk>
 <20210326153444.cdccc3e2axqxzejy@pali> <87o8f5c0tt.fsf@toke.dk>
 <20210326171100.s53mslkjc7tdgs6f@pali>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Mar 2021 18:51:42 +0100
Message-ID: <87ft0hby6p.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Friday 26 March 2021 17:54:38 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>> > On Friday 26 March 2021 16:25:27 Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>> >> Pali Roh=C3=A1r <pali@kernel.org> writes:
>> >> > Seems that this is really issue in QCA98xx chips. I have send patch
>> >> > which adds quirk for these wifi chips:
>> >> >
>> >> > https://lore.kernel.org/linux-pci/20210326124326.21163-1-pali@kerne=
l.org/
>> >>=20
>> >> I tried applying that, and while it does fix the ath10k card, it seems
>> >> to break the ath9k card in the slot next to it.
>> >
>> > Ehm, what?
>>=20
>> I know, right?! :/
>>=20
>> > Patch which I have sent today to mailing list calls quirk code only
>> > for PCI device id used by QCA98xx cards. For all other cards it is
>> > noop.
>>=20
>> So upon further investigation this seems to be unrelated to the patch.
>> Meaning that I can't reliably get the ath9k device to work again by
>> reverting it. And the patch does seem to fix the ath10k device, so I
>> think that's probably good.
>>=20
>> However, the issue with ath9k does seem to be related to ASPM; if I turn
>> that off in .config, I get the ath9k device back.
>
> Ok, perfect. So this my patch is does not break ath9k.

No, doesn't seem like it!

>> So we have these
>> cases:
>>=20
>> ASPM disabled:          ath9k, ath10k and mt76 cards all work
>> ASPM enabled, no patch: only mt76 card works
>> ASPM enabled + patch:   ath10k and mt76 cards work
>>=20
>> So IDK, maybe the ath9k card needs a quirk as well? Or the mvebu board
>> is just generally flaky?
>
> I'm not sure. Maybe ASPM is somehow buggy on ath9k or needs some special
> handling. But issue is not at PCI config space as ath9k driver start
> initialization of this card. Needs also some debugging in ath9k driver
> if it prints that strange "mac chip rev" error.

Well that's just being output because it gets a revision that it doesn't
recognise - which it seems to be just reading from a register:

https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/ath/ath=
9k/hw.c#L255

The value returned is consistent with the value returned just being
0xffffffff. Which from looking at ioread32() is the value being returned
on a failed read. So there's a driver bug there - the check against -EIO
here is obviously nonsensical:

https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/ath/ath=
9k/hw.c#L290

But the underlying cause appears to be that the read from the register
fails, which I suppose is related to something the PCI bus does?

> I think this issue should be handled separately. Could you report it
> also to ath9k mailing list (and CC me)? Maybe other ath developers would
> know some more details.

I'll send a patch for the nonsensical check above, but other than that I
think we're still in PCI land here, or?

>> > Can you send PCI device id of your ath9k card (lspci -nn)? Because all
>> > my tested ath9k cards have different PCI device id.
>>=20
>> [root@omnia-arch ~]# lspci -nn
>> 00:01.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:68=
20] (rev 04)
>> 00:02.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:68=
20] (rev 04)
>> 00:03.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:68=
20] (rev 04)
>> 01:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireless Netw=
ork Adapter (PCI-Express) [168c:002e] (rev 01)
>> 02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 802.11a=
c Wireless Network Adapter [168c:003c]
>
> That is fine. Also all ath9k testing cards have id 0x002e.
>
>> >> When booting with the
>> >> patch applied, I get this in dmesg:
>> >>=20
>> >> [    3.556599] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by =
this driver
>> >
>> > Can you send whole dmesg log? So I can see which new err/info lines are
>> > printed.
>>=20
>> Pasting all three cases below:
> ...
>
> Seem that there is no ASPM related line... But your logs are not
> complete, beginning is missing. So important lines are maybe trimmed.

Ah! Of course - sorry for not noticing that!

Here are the missing bits related to PCIE (pulled off the serial console
- with the patch applied):

[    1.493064] mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
[    1.493094] mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> =
0x0000080000
[    1.493113] mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> =
0x0000040000
[    1.493129] mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> =
0x0000044000
[    1.493144] mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> =
0x0000048000
[    1.493159] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0100000000
[    1.493174] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0100000000
[    1.493189] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0200000000
[    1.493203] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0200000000
[    1.493217] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0300000000
[    1.493231] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0300000000
[    1.493245] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0400000000
[    1.493255] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0400000000
[    1.493426] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
[    1.493435] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.493443] pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081ff=
f] (bus address [0x00080000-0x00081fff])
[    1.493451] pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041ff=
f] (bus address [0x00040000-0x00041fff])
[    1.493458] pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045ff=
f] (bus address [0x00044000-0x00045fff])
[    1.493465] pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049ff=
f] (bus address [0x00048000-0x00049fff])
[    1.493472] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7fffff=
f]
[    1.493478] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
[    1.493548] pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
[    1.493564] pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
[    1.493719] pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
[    1.493734] pci 0000:00:02.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
[    1.493868] pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
[    1.493882] pci 0000:00:03.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
[    1.494660] PCI: bus0: Fast back to back transfers disabled
[    1.494668] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    1.494677] pci 0000:00:02.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    1.494685] pci 0000:00:03.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    1.494765] pci 0000:01:00.0: [168c:002e] type 00 class 0x028000
[    1.494788] pci 0000:01:00.0: reg 0x10: [mem 0xe8000000-0xe800ffff 64bit]
[    1.494901] pci 0000:01:00.0: supports D1
[    1.494907] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
[    1.495020] pci 0000:00:01.0: ASPM: current common clock configuration i=
s inconsistent, reconfiguring
[    1.522129] PCI: bus1: Fast back to back transfers enabled
[    1.522137] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.522226] pci 0000:02:00.0: [168c:003c] type 00 class 0x028000
[    1.522249] pci 0000:02:00.0: reg 0x10: [mem 0xea000000-0xea1fffff 64bit]
[    1.522283] pci 0000:02:00.0: reg 0x30: [mem 0xea200000-0xea20ffff pref]
[    1.522362] pci 0000:02:00.0: supports D1 D2
[    1.522457] pci 0000:00:02.0: ASPM: current common clock configuration i=
s inconsistent, reconfiguring
[    1.522466] pcie_change_tls_to_getn1() called for device 6820:0:0
[    1.522472] pci 0000:00:02.0: ASPM: Bridge does not support changing Lin=
k Speed to 2.5 GT/s
[    1.522477] pci 0000:00:02.0: ASPM: Retrain Link at higher speed is disa=
llowed by quirk
[    1.522482] pci 0000:00:02.0: ASPM: Could not configure common clock
[    1.523241] PCI: bus2: Fast back to back transfers disabled
[    1.523247] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    1.523332] pci 0000:03:00.0: [14c3:7612] type 00 class 0x028000
[    1.523357] pci 0000:03:00.0: reg 0x10: [mem 0xec000000-0xec0fffff 64bit]
[    1.523393] pci 0000:03:00.0: reg 0x30: [mem 0xec100000-0xec10ffff pref]
[    1.523481] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    1.523601] pci 0000:00:03.0: ASPM: current common clock configuration i=
s inconsistent, reconfiguring
[    1.552139] PCI: bus3: Fast back to back transfers disabled
[    1.552147] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    1.552183] pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00fffff]
[    1.552193] pci 0000:00:02.0: BAR 8: assigned [mem 0xe0200000-0xe04fffff]
[    1.552202] pci 0000:00:03.0: BAR 8: assigned [mem 0xe0600000-0xe07fffff]
[    1.552211] pci 0000:00:01.0: BAR 6: assigned [mem 0xe0100000-0xe01007ff=
 pref]
[    1.552221] pci 0000:00:02.0: BAR 6: assigned [mem 0xe0500000-0xe05007ff=
 pref]
[    1.552229] pci 0000:00:03.0: BAR 6: assigned [mem 0xe0800000-0xe08007ff=
 pref]
[    1.552238] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0000000-0xe000ffff=
 64bit]
[    1.552247] pci 0000:01:00.0: BAR 0: error updating (0xe0000004 !=3D 0xf=
fffffff)
[    1.552254] pci 0000:01:00.0: BAR 0: error updating (high 0x000000 !=3D =
0xffffffff)
[    1.552261] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.552269] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
[    1.552279] pci 0000:02:00.0: BAR 0: assigned [mem 0xe0200000-0xe03fffff=
 64bit]
[    1.552293] pci 0000:02:00.0: BAR 6: assigned [mem 0xe0400000-0xe040ffff=
 pref]
[    1.552300] pci 0000:00:02.0: PCI bridge to [bus 02]
[    1.552306] pci 0000:00:02.0:   bridge window [mem 0xe0200000-0xe04fffff]
[    1.552315] pci 0000:03:00.0: BAR 0: assigned [mem 0xe0600000-0xe06fffff=
 64bit]
[    1.552329] pci 0000:03:00.0: BAR 6: assigned [mem 0xe0700000-0xe070ffff=
 pref]
[    1.552335] pci 0000:00:03.0: PCI bridge to [bus 03]
[    1.552342] pci 0000:00:03.0:   bridge window [mem 0xe0600000-0xe07fffff]


>> >> Could there be some kind of data corruption in play here making the
>> >> driver think the chip revision is wrong, or something like that? If I
>> >> boot the same kernel without the patch applied, the ath9k initialisat=
ion
>> >> works fine, but obviously the ath10k is then still broken...
>> >
>> > There is something really strange.
>> >
>> > Can you add debug log into pcie_change_tls_to_gen1() function to check
>> > for which card is this function called?
>>=20
>> Erm, it looks like it's never called? I added this:
>
> Ehm? With patch it must be called otherwise ath10k card would not be
> detected on PCIe bus. And you tested that patch fixes it...

Yeah, that was due to the missing log lines; it's in the output above.

-Toke

