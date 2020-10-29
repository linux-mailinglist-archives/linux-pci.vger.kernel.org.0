Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C28329E93B
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 11:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgJ2KoE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 06:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbgJ2KoD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 06:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603968241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1w5Gpzjy9OJiKc8HKq0Vgwq+YBI1qSJZ54svr6KfSc=;
        b=ACtkXWixMumzcCScAKzl1ZWh5P0ttJJ3J5amJBBIa9KRrR3VK3Uaq+W47emnf55fyqtSmt
        h+9ucD7SZGk6XzzKP+vRmJI88DzQzWLrn+Mr1f4gKYImujSmBnWk5jW0JMq+rQfiRVKqO6
        9QUhG5mzC0aE9EzriRQqWHoggFRn3Cw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-9d1YPFGQNUehvFdzlzgugw-1; Thu, 29 Oct 2020 06:41:25 -0400
X-MC-Unique: 9d1YPFGQNUehvFdzlzgugw-1
Received: by mail-qv1-f71.google.com with SMTP id x34so1504961qvx.7
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 03:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=f1w5Gpzjy9OJiKc8HKq0Vgwq+YBI1qSJZ54svr6KfSc=;
        b=gp7YapYmyO0/Y2d3ABJWs3moIXF1LFkTJO1BckxsevLmh1WRE8DPxk+ecQr1x1B7CX
         NoqJG5KG6k/J9EvxqYMF0/MzW5TQ7mQIDA+uqwpIxOGbTdxMJQz/dwZQ0vxoWZ0YgQ2r
         cRVDGjyhnOSUy4f/aFYNJDKNbhWkYFv9g97kULU/othPRnB//YIytlHoHlMK25he+fnd
         5wNcsEgIub+OPkkWU3Y/N5tNzblO1fcxZIg6V+oQyd+tT+uWEJMkLC70487GMEqQOXgL
         lK1R4SOmnZQKt6c2eq9LukgLDD3re+R7FMrZgYcGbPrPcJSr8GkSaoG4gdO+o5hxZkyR
         kjPA==
X-Gm-Message-State: AOAM531ze1eNIh+bFcy8cxjVnUAH/b6Hgbt6lUKKXcPpwzxu4eq5XK7R
        5OdAMQIdHH2+mj6mQZfPWaN0i8BulDbt3GTjR9N+hVX3dKTgOnaU5P979MPriofrTpbEsWuAPgg
        Qxi9FCer9i62aEcfcLWgu
X-Received: by 2002:a0c:e1d1:: with SMTP id v17mr3477117qvl.15.1603968083225;
        Thu, 29 Oct 2020 03:41:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxME3wbNFlY9k7dV9w81fgW9gGUVYKVhjcJ2AsTfq55ejmbRChh984J9vb1CZbcbeweNY00eg==
X-Received: by 2002:a0c:e1d1:: with SMTP id v17mr3477046qvl.15.1603968082675;
        Thu, 29 Oct 2020 03:41:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e1sm931151qkm.35.2020.10.29.03.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:41:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 11A2A181CED; Thu, 29 Oct 2020 11:41:19 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, vtolkm@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20201028231626.GA344207@bjorn-Precision-5520>
References: <20201028231626.GA344207@bjorn-Precision-5520>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 29 Oct 2020 11:41:19 +0100
Message-ID: <877dr9mi0g.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> [+cc Pali, Marek, Thomas, Jason]
>
> On Wed, Oct 28, 2020 at 04:40:00PM +0000, =E2=84=A2=D6=9F=E2=98=BB=D2=87=
=CC=AD =D1=BC =D2=89 =C2=AE wrote:
>> On 28/10/2020 16:08, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > Bjorn Helgaas <helgaas@kernel.org> writes:
>> > > On Wed, Oct 28, 2020 at 02:36:13PM +0100, Toke H=C3=B8iland-J=C3=B8r=
gensen wrote:
>> > > > Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>> > > > > Bjorn Helgaas <helgaas@kernel.org> writes:
>> > > > >=20
>> > > > > > [+cc vtolkm]
>> > > > > >=20
>> > > > > > On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke H=C3=B8iland-J=
=C3=B8rgensen wrote:
>> > > > > > > Hi everyone
>> > > > > > >=20
>> > > > > > > I'm trying to get a mainline kernel to run on my Turris Omni=
a, and am
>> > > > > > > having some trouble getting the PCI bus to work correctly. S=
pecifically,
>> > > > > > > I'm running a 5.10-rc1 kernel (torvalds/master as of this mo=
ment), with
>> > > > > > > the resource request fix[0] applied on top.
>> > > > > > >=20
>> > > > > > > The kernel boots fine, and the patch in [0] makes the PCI de=
vices show
>> > > > > > > up. But I'm still getting initialisation errors like these:
>> > > > > > >=20
>> > > > > > > [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0=
000004 !=3D 0xffffffff)
>> > > > > > > [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high=
 0x000000 !=3D 0xffffffff)
>> > > > > > > [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0=
200004 !=3D 0xffffffff)
>> > > > > > > [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high=
 0x000000 !=3D 0xffffffff)
>> > > > > > >=20
>> > > > > > > and the WiFi drivers fail to initialise with what appears to=
 me to be
>> > > > > > > errors related to the bus rather than to the drivers themsel=
ves:
>> > > > > > >=20
>> > > > > > > [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not supp=
orted by this driver
>> > > > > > > [    3.517049] ath: phy0: Unable to initialize hardware; ini=
tialization status: -95
>> > > > > > > [    3.524473] ath9k 0000:01:00.0: Failed to initialize devi=
ce
>> > > > > > > [    3.530081] ath9k: probe of 0000:01:00.0 failed with erro=
r -95
>> > > > > > > [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: fa=
iled with rc=3D134
>> > > > > > > [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 01=
42)
>> > > > > > > [    3.548735] ath10k_pci 0000:02:00.0: can't change power s=
tate from D3hot to D0 (config space inaccessible)
>> > > > > > > [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up de=
vice : -110
>> > > > > > > [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with=
 error -110
>> > > > > > >=20
>> > > > > > > lspci looks OK, though:
>> > > > > > >=20
>> > > > > > > # lspci
>> > > > > > > 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 682=
0 (rev 04)
>> > > > > > > 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 682=
0 (rev 04)
>> > > > > > > 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 682=
0 (rev 04)
>> > > > > > > 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless=
 Network Adapter (PCI-Express) (rev 01)
>> > > > > > > 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 80=
2.11ac Wireless Network Adapter (rev ff)
>> > > > > > >=20
>> > > > > > > Does anyone have any clue what could be going on here? Is th=
is a bug, or
>> > > > > > > did I miss something in my config or other initialisation? I=
've tried
>> > > > > > > with both the stock u-boot distributed with the board, and w=
ith an
>> > > > > > > upstream u-boot from latest master; doesn't seem to make any=
 different.
>> > > > > > Can you try turning off CONFIG_PCIEASPM?  We had a similar rec=
ent
>> > > > > > report at https://bugzilla.kernel.org/show_bug.cgi?id=3D209833=
 but I
>> > > > > > don't think we have a fix yet.
>> > > > > Yes! Turning that off does indeed help! Thanks a bunch :)
>> > > > >=20
>> > > > > You mention that bisecting this would be helpful - I can try that
>> > > > > tomorrow; any idea when this was last working?
>> > > > OK, so I tried to bisect this, but, erm, I couldn't find a working
>> > > > revision to start from? I went all the way back to 4.10 (which is =
the
>> > > > first version to include the device tree file for the Omnia), and =
even
>> > > > on that, the wireless cards were failing to initialise with ASPM
>> > > > enabled...
>> > > I have no personal experience with this device; all I know is that t=
he
>> > > bugzilla suggests that it worked in v5.4, which isn't much help.
>> > >=20
>> > > Possibly the apparent regression was really a .config change, i.e.,
>> > > CONFIG_PCIEASPM was disabled in the v5.4 kernel vtolkm@ tested and it
>> > > "worked" but got enabled later and it started failing?
>> > Yeah, I suspect so. The OpenWrt config disables CONFIG_PCIEASPM by
>> > default and only turns it on for specific targets. So I guess that it's
>> > most likely that this has never worked...
>> >=20
>> > > Maybe the debug patch below would be worth trying to see if it makes
>> > > any difference?  If it *does* help, try omitting the first hunk to s=
ee
>> > > if we just need to apply the quirk_enable_clear_retrain_link() quirk.
>> > Tried, doesn't help...
>> >=20
>> > -Toke
>>=20
>> Found this patch
>>=20
>> https://github.com/openwrt/openwrt/blob/7c0496f29bed87326f1bf591ca25ace8=
2373cfc7/target/linux/mvebu/patches-5.4/405-PCI-aardvark-Improve-link-train=
ing.patch
>>=20
>> that mentions the Compex WLE900VX card, which reading the lspci verbose
>> output from the bugtracker seems to the device being troubled.
>
> Interesting.  Indeed, the Compex WLE900VX card seems to have the
> Qualcomm Atheros QCA9880 on it, and it looks like Toke's system has
> the same device in it.
>
> The patch you mention (https://git.kernel.org/linus/43fc679ced18) is
> for aardvark, so of course doesn't help mvebu.
>
> PCIe hardware is supposed to automatically negotiate the highest link
> speed supported by both ends.  But software *is* allowed to set an
> upper limit (the Target Link Speed in Link Control 2).  If we initiate
> a retrain and the link doesn't come back up, I wonder if we should try
> to help the hardware out by using Target Link Speed to limit to a
> lower speed and attempting another retrain, something like this hacky
> patch: (please collect the dmesg log if you try this)

Well, I tried it, but don't see any of the 'lnkcap2' output from that
new function:

[    1.545853] mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
[    1.545878] mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> =
0x0000080000
[    1.545894] mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> =
0x0000040000
[    1.545907] mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> =
0x0000044000
[    1.545920] mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> =
0x0000048000
[    1.545933] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0100000000
[    1.545945] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0100000000
[    1.545958] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0200000000
[    1.545970] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0200000000
[    1.545982] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0300000000
[    1.545994] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0300000000
[    1.546006] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0400000000
[    1.546014] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0400000000
[    1.546181] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
[    1.546190] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.546197] pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081ff=
f] (bus address [0x00080000-0x00081fff])
[    1.546204] pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041ff=
f] (bus address [0x00040000-0x00041fff])
[    1.546210] pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045ff=
f] (bus address [0x00044000-0x00045fff])
[    1.546216] pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049ff=
f] (bus address [0x00048000-0x00049fff])
[    1.546220] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7fffff=
f]
[    1.546225] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
[    1.546294] pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
[    1.546308] pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
[    1.546482] pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
[    1.546495] pci 0000:00:02.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
[    1.546643] pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
[    1.546656] pci 0000:00:03.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
[    1.547379] PCI: bus0: Fast back to back transfers disabled
[    1.547387] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    1.547394] pci 0000:00:02.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    1.547402] pci 0000:00:03.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    1.547484] pci 0000:01:00.0: [168c:002e] type 00 class 0x028000
[    1.547507] pci 0000:01:00.0: reg 0x10: [mem 0xe8000000-0xe800ffff 64bit]
[    1.547615] pci 0000:01:00.0: supports D1
[    1.547620] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
[    1.547730] pci 0000:00:01.0: ASPM: current common clock configuration i=
s inconsistent, reconfiguring
[    1.631937] PCI: bus2: Fast back to back transfers enabled
[    1.631945] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    1.632655] PCI: bus3: Fast back to back transfers enabled
[    1.632662] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    1.632694] pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00fffff]
[    1.632702] pci 0000:00:02.0: BAR 8: assigned [mem 0xe0200000-0xe04fffff]
[    1.632710] pci 0000:00:01.0: BAR 6: assigned [mem 0xe0100000-0xe01007ff=
 pref]
[    1.632718] pci 0000:00:02.0: BAR 6: assigned [mem 0xe0500000-0xe05007ff=
 pref]
[    1.632726] pci 0000:00:03.0: BAR 6: assigned [mem 0xe0600000-0xe06007ff=
 pref]
[    1.632734] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0000000-0xe000ffff=
 64bit]
[    1.632741] pci 0000:01:00.0: BAR 0: error updating (0xe0000004 !=3D 0xf=
fffffff)
[    1.632746] pci 0000:01:00.0: BAR 0: error updating (high 0x000000 !=3D =
0xffffffff)
[    1.632752] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.632760] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
[    1.632769] pci 0000:02:00.0: BAR 0: assigned [mem 0xe0200000-0xe03fffff=
 64bit]
[    1.632776] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 !=3D 0xf=
fffffff)
[    1.632782] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 !=3D =
0xffffffff)
[    1.632788] pci 0000:02:00.0: BAR 6: assigned [mem 0xe0400000-0xe040ffff=
 pref]
[    1.632793] pci 0000:00:02.0: PCI bridge to [bus 02]
[    1.632800] pci 0000:00:02.0:   bridge window [mem 0xe0200000-0xe04fffff]
[    1.632807] pci 0000:00:03.0: PCI bridge to [bus 03]

(and then later, still):
[    3.476364] pci 0000:00:01.0: enabling device (0140 -> 0142)
[    3.477542] ata1: SATA link down (SStatus 0 SControl 300)
[    3.482126] ath9k 0000:01:00.0: enabling device (0000 -> 0002)
[    3.487487] ata2: SATA link down (SStatus 0 SControl 300)
[    3.493379] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by this d=
river
[    3.505891] ath: phy0: Unable to initialize hardware; initialization sta=
tus: -95
[    3.513325] ath9k 0000:01:00.0: Failed to initialize device
[    3.518933] ath9k: probe of 0000:01:00.0 failed with error -95
[    3.524862] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed with rc=3D=
134
[    3.531904] pci 0000:00:02.0: enabling device (0140 -> 0142)
[    3.537590] ath10k_pci 0000:02:00.0: can't change power state from D3hot=
 to D0 (config space inaccessible)
[    3.577436] ath10k_pci 0000:02:00.0: failed to wake up device : -110
[    3.583948] ath10k_pci: probe of 0000:02:00.0 failed with error -110


-Toke

