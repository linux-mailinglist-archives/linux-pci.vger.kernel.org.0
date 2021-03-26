Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26DF34ACE7
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 17:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhCZQy4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 12:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230076AbhCZQys (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 12:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616777687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmsTHhXeobNVo10DDcKJnw7Fwe0YAt5oaomvNydhL80=;
        b=Hmnt4pkc04cQNDNEf9lPDXyCTkBTtmdWRqiwMRBgopFwzcekxaxb73OzWSYerGr9V3QmdV
        vjZ2nEYlX7aqjpL+rW1S/AI5UFBro3vYnjcccNnKwMCLwQYFqGgIPmTNftIkeyW2fzPV3f
        xRGxoRf6epgkp29t5Mrmj9grPTOO5RY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-CMy8u8NfPI-HPWHM7XjqiQ-1; Fri, 26 Mar 2021 12:54:43 -0400
X-MC-Unique: CMy8u8NfPI-HPWHM7XjqiQ-1
Received: by mail-ed1-f72.google.com with SMTP id i6so4760855edq.12
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 09:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CmsTHhXeobNVo10DDcKJnw7Fwe0YAt5oaomvNydhL80=;
        b=tu85ZjLVZnQ3uZMWRae/Qfm2rTgvhqoc22/6p7XvpWC/D6mcy2wy9WMFpYhJYBpEDY
         BORD59dRxFO4D3GIVbvifMd8cInZ7EYEBEzvgsNkrx6ZyC8Ul5y9k1uxgimTh6+1BGlD
         qfS8WaFBSnEjBMdIhDksrleBXejCJm9UTusxF/E583Kswj8Dgrwxga4I4+AV/o+fdWR0
         HNNc7NJ85XOPUCfUyeNQr8CQ0qiM7FcfByDP6AEmdz1D6DJ6Yq8BlkjwohVkpDE1lGPr
         dVVRoGkxR9FfoSQ2aywMEcqPP2/Ivrhq+HylPkNuiChhiHGrgInfT+JymHBrKWPbgrUJ
         caXw==
X-Gm-Message-State: AOAM530qGfSvQW4W017Th4BuSAe2T4M9c448twNUXe5vZEKjjOGKxHug
        VqLKBn8KWCEpRg4s+xjvURDvR4CHdg6SXk565ZNkh0td2ZyMGEhcfH2KGxOIUUSUkycdDJn7jpk
        vTxfK9zf2n+KHPnWpihMS
X-Received: by 2002:a17:906:1fd2:: with SMTP id e18mr17020283ejt.49.1616777681180;
        Fri, 26 Mar 2021 09:54:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlK3mRqfgwYQJfjWR8AJ1H1H1IUlTC0ImB6Zkv1zyOvLcYOkXJudyO2uDfcM6+b2YJ/WwwSQ==
X-Received: by 2002:a17:906:1fd2:: with SMTP id e18mr17020200ejt.49.1616777680265;
        Fri, 26 Mar 2021 09:54:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id dg26sm4476434edb.88.2021.03.26.09.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 09:54:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BA0B81801A3; Fri, 26 Mar 2021 17:54:38 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     vtolkm@gmail.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20210326153444.cdccc3e2axqxzejy@pali>
References: <b9683fc3-bb8d-3dac-4a5d-fe7fbf2f0177@gmail.com>
 <87zh42lfv6.fsf@toke.dk> <20201102152403.4jlmcaqkqeivuypm@pali>
 <877dr3lpok.fsf@toke.dk> <20210315195806.iqdt5wvvkvpmnep7@pali>
 <20210316092534.czuondwbg3tqjs6w@pali> <87h7l8axqp.fsf@toke.dk>
 <20210318231629.vhix2cqpt25bgrne@pali>
 <20210326125028.tyqkcc5fvaqbwqkn@pali> <874kgyc4yg.fsf@toke.dk>
 <20210326153444.cdccc3e2axqxzejy@pali>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Mar 2021 17:54:38 +0100
Message-ID: <87o8f5c0tt.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Friday 26 March 2021 16:25:27 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>>=20
>> > On Friday 19 March 2021 00:16:29 Pali Roh=C3=A1r wrote:
>> >> On Thursday 18 March 2021 23:43:58 Toke H=C3=B8iland-J=C3=B8rgensen w=
rote:
>> >> > Pali Roh=C3=A1r <pali@kernel.org> writes:
>> >> >=20
>> >> > > On Monday 15 March 2021 20:58:06 Pali Roh=C3=A1r wrote:
>> >> > >> On Monday 02 November 2020 16:54:35 Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> > >> > Pali Roh=C3=A1r <pali@kernel.org> writes:
>> >> > >> >=20
>> >> > >> > > On Saturday 31 October 2020 13:49:49 Toke H=C3=B8iland-J=C3=
=B8rgensen wrote:
>> >> > >> > >> "=E2=84=A2=D6=9F=E2=98=BB=D2=87=CC=AD =D1=BC =D2=89 =C2=AE"=
 <vtolkm@googlemail.com> writes:
>> >> > >> > >>=20
>> >> > >> > >> > On 30/10/2020 15:23, Pali Roh=C3=A1r wrote:
>> >> > >> > >> >> On Friday 30 October 2020 14:02:22 Toke H=C3=B8iland-J=
=C3=B8rgensen wrote:
>> >> > >> > >> >>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>> >> > >> > >> >>>> My experience with that WLE900VX card, aardvark driver=
 and aspm code:
>> >> > >> > >> >>>>
>> >> > >> > >> >>>> Link training in GEN2 mode for this card succeed only =
once after reset.
>> >> > >> > >> >>>> Repeated link retraining fails and it fails even when =
aardvark is
>> >> > >> > >> >>>> reconfigured to GEN1 mode. Reset via PERST# signal is =
required to have
>> >> > >> > >> >>>> working link training.
>> >> > >> > >> >>>>
>> >> > >> > >> >>>> What I did in aardvark driver: Set mode to GEN2, do li=
nk training. If
>> >> > >> > >> >>>> success read "negotiated link speed" from "Link Contro=
l Status Register"
>> >> > >> > >> >>>> (for WLE900VX it is 0x1 - GEN1) and set it into aardva=
rk. And then
>> >> > >> > >> >>>> retrain link again (for WLE900VX now it would be at GE=
N1). After that
>> >> > >> > >> >>>> card is stable and all future retraining (e.g. from as=
pm.c) also passes.
>> >> > >> > >> >>>>
>> >> > >> > >> >>>> If I do not change aardvark mode from GEN2 to GEN1 the=
 second link
>> >> > >> > >> >>>> training fails. And if I change mode to GEN1 after thi=
s failed link
>> >> > >> > >> >>>> training then nothing happen, link training do not suc=
cess.
>> >> > >> > >> >>>>
>> >> > >> > >> >>>> So just speculation now... In current setup initializa=
tion of card does
>> >> > >> > >> >>>> one link training at GEN2. Then aspm.c is called which=
 is doing second
>> >> > >> > >> >>>> link retraining at GEN2. And if it fails then below pa=
tch issue third
>> >> > >> > >> >>>> link retraining at GEN1. If A38x/pci-mvebu has same pr=
oblem as aardvark
>> >> > >> > >> >>>> then second link retraining must be at GEN1 (not GEN2)=
 to workaround
>> >> > >> > >> >>>> this issue.
>> >> > >> > >> >>>>
>> >> > >> > >> >>>> Bjorn, Toke: what about trying to hack aspm.c code to =
never do link
>> >> > >> > >> >>>> retraining at GEN2 speed? And always force GEN1 speed =
prior link
>> >> > >> > >> >>>> training?
>> >> > >> > >> >>> Sounds like a plan. I poked around in aspm.c and must c=
onfess to being a
>> >> > >> > >> >>> bit lost in the soup of registers ;)
>> >> > >> > >> >>>
>> >> > >> > >> >>> So if one of you can cook up a patch, that would be mos=
t helpful!
>> >> > >> > >> >> I modified Bjorn's patch, explicitly set tls to 1 and ad=
ded debug info
>> >> > >> > >> >> about cls (current link speed, that what is used by aard=
vark). It is
>> >> > >> > >> >> untested, I just tried to compile it.
>> >> > >> > >> >>
>> >> > >> > >> >> Can try it?
>> >> > >> > >> >>
>> >> > >> > >> >> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/=
aspm.c
>> >> > >> > >> >> index 253c30cc1967..f934c0b52f41 100644
>> >> > >> > >> >> --- a/drivers/pci/pcie/aspm.c
>> >> > >> > >> >> +++ b/drivers/pci/pcie/aspm.c
>> >> > >> > >> >> @@ -206,6 +206,27 @@ static bool pcie_retrain_link(struc=
t pcie_link_state *link)
>> >> > >> > >> >>   	unsigned long end_jiffies;
>> >> > >> > >> >>   	u16 reg16;
>> >> > >> > >> >>=20=20=20
>> >> > >> > >> >> +	u32 lnkcap2;
>> >> > >> > >> >> +	u16 lnksta, lnkctl2, cls, tls;
>> >> > >> > >> >> +
>> >> > >> > >> >> +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &l=
nkcap2);
>> >> > >> > >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &lnk=
sta);
>> >> > >> > >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &ln=
kctl2);
>> >> > >> > >> >> +	cls =3D lnksta & PCI_EXP_LNKSTA_CLS;
>> >> > >> > >> >> +	tls =3D lnkctl2 & PCI_EXP_LNKCTL2_TLS;
>> >> > >> > >> >> +
>> >> > >> > >> >> +	pci_info(parent, "lnkcap2 %#010x sls %#04x lnksta %#06=
x cls %#03x lnkctl2 %#06x tls %#03x\n",
>> >> > >> > >> >> +		lnkcap2, (lnkcap2 & 0x3F) >> 1,
>> >> > >> > >> >> +		lnksta, cls,
>> >> > >> > >> >> +		lnkctl2, tls);
>> >> > >> > >> >> +
>> >> > >> > >> >> +	tls =3D 1;
>> >> > >> > >> >> +	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNK=
CTL2,
>> >> > >> > >> >> +					PCI_EXP_LNKCTL2_TLS, tls);
>> >> > >> > >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &ln=
kctl2);
>> >> > >> > >> >> +	pci_info(parent, "lnkctl2 %#010x new tls %#03x\n",
>> >> > >> > >> >> +		lnkctl2, tls);
>> >> > >> > >> >> +
>> >> > >> > >> >>   	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &re=
g16);
>> >> > >> > >> >>   	reg16 |=3D PCI_EXP_LNKCTL_RL;
>> >> > >> > >> >>   	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, re=
g16);
>> >> > >> > >> >> @@ -227,6 +248,8 @@ static bool pcie_retrain_link(struct=
 pcie_link_state *link)
>> >> > >> > >> >>   			break;
>> >> > >> > >> >>   		msleep(1);
>> >> > >> > >> >>   	} while (time_before(jiffies, end_jiffies));
>> >> > >> > >> >> +	pci_info(parent, "lnksta %#06x new cls %#03x\n",
>> >> > >> > >> >> +		lnksta, (cls & PCI_EXP_LNKSTA_CLS));
>> >> > >> > >> >>   	return !(reg16 & PCI_EXP_LNKSTA_LT);
>> >> > >> > >> >>   }
>> >> > >> > >> >>=20=20=20
>> >> > >> > >> >
>> >> > >> > >> > Still exhibiting the BAR update error, run tested with ne=
xt--20201030
>> >> > >> > >>=20
>> >> > >> > >> Yup, same for me :(
>> >> > >>=20
>> >> > >> I'm answering my own question. This code does not work on Omnia =
because
>> >> > >> A38x pci-mvebu.c driver is using emulator for PCIe root bridge a=
nd it
>> >> > >> does not implement PCI_EXP_LNKCTL2 and PCI_EXP_LNKCTL2 registers=
. So
>> >> > >> code for forcing link speed has no effect on Omnia...
>> >> > >
>> >> > > Toke, on A38x PCIe controller it is possible to access PCI_EXP_LN=
KCTL2
>> >> > > register. Just access is not exported via emulated root bridge.
>> >> > >
>> >> > > Documentation for this PCIe controller is public, so anybody can =
look at
>> >> > > register description. See page 571, A.7 PCI Express 2.0 Port 0 Re=
gisters
>> >> > >
>> >> > > http://web.archive.org/web/20200420191927/https://www.marvell.com=
/content/dam/marvell/en/public-collateral/embedded-processors/marvell-embed=
ded-processors-armada-38x-functional-specifications-2015-11.pdf
>> >> > >
>> >> > > In drivers/pci/controller/pci-mvebu.c you can set a new value for=
 this
>> >> > > register via function call:
>> >> > >
>> >> > >     mvebu_writel(port, val, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
>> >> > >
>> >> > > So, could you try to set PCI_EXP_LNKCTL2_TLS bits to gen1 in some=
 hw
>> >> > > init function, e.g. mvebu_pcie_setup_hw()?
>> >> > >
>> >> > >     u32 val =3D mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCT=
L2);
>> >> > >     val &=3D ~PCI_EXP_LNKCTL2_TLS;
>> >> > >     val |=3D PCI_EXP_LNKCTL2_TLS_2_5GT;
>> >> > >     mvebu_writel(port, val, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
>> >> >=20
>> >> > I pasted this into the top of mvebu_pcie_setup_hw(), and that indeed
>> >> > seems to fix things so that all three PCIE devices work even with A=
SPM
>> >> > turned on! :)
>> >>=20
>> >> Perfect! Now I'm sure that it is same issue as in aardvark driver.
>> >>=20
>> >> I will prepare patches for both pci-aardvark.c and pci-mvebu.c to exp=
ort
>> >> PCI_EXP_LNKCTL2 register via emulated bridge. And so aspm.c code would
>> >> be able to use Bjorn or my patch which I have sent last year.
>> >>=20
>> >> Question reminds, if this is issue with QCA wifi chip on that Compex
>> >> card or it is issue with PCIe controllers, now on A38x and A3720 SoC.
>> >> Note that both A38x and A3720 platforms are from Marvell, but they ha=
ve
>> >> different PCIe controllers (so it does not mean that both must have s=
ame
>> >> hw bugs).
>> >
>> > Seems that this is really issue in QCA98xx chips. I have send patch
>> > which adds quirk for these wifi chips:
>> >
>> > https://lore.kernel.org/linux-pci/20210326124326.21163-1-pali@kernel.o=
rg/
>>=20
>> I tried applying that, and while it does fix the ath10k card, it seems
>> to break the ath9k card in the slot next to it.
>
> Ehm, what?

I know, right?! :/

> Patch which I have sent today to mailing list calls quirk code only
> for PCI device id used by QCA98xx cards. For all other cards it is
> noop.

So upon further investigation this seems to be unrelated to the patch.
Meaning that I can't reliably get the ath9k device to work again by
reverting it. And the patch does seem to fix the ath10k device, so I
think that's probably good.

However, the issue with ath9k does seem to be related to ASPM; if I turn
that off in .config, I get the ath9k device back. So we have these
cases:

ASPM disabled:          ath9k, ath10k and mt76 cards all work
ASPM enabled, no patch: only mt76 card works
ASPM enabled + patch:   ath10k and mt76 cards work

So IDK, maybe the ath9k card needs a quirk as well? Or the mvebu board
is just generally flaky?

> Can you send PCI device id of your ath9k card (lspci -nn)? Because all
> my tested ath9k cards have different PCI device id.

[root@omnia-arch ~]# lspci -nn
00:01.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820]=
 (rev 04)
00:02.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820]=
 (rev 04)
00:03.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820]=
 (rev 04)
01:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireless Network=
 Adapter (PCI-Express) [168c:002e] (rev 01)
02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 802.11ac W=
ireless Network Adapter [168c:003c]

>> When booting with the
>> patch applied, I get this in dmesg:
>>=20
>> [    3.556599] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by thi=
s driver
>
> Can you send whole dmesg log? So I can see which new err/info lines are
> printed.

Pasting all three cases below:

ASPM disabled in kernel:
[    2.976258] ahci-mvebu f10a8000.sata: supply ahci not found, using dummy=
 regulator
[    2.983948] ahci-mvebu f10a8000.sata: supply phy not found, using dummy =
regulator
[    2.991502] ahci-mvebu f10a8000.sata: supply target not found, using dum=
my regulator
[    2.999337] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots 2 ports 6 =
Gbps 0x3 impl platform mode
[    3.008418] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp=
 fbs pio slum part sxs=20
[    3.017677] scsi host0: ahci-mvebu
[    3.021317] scsi host1: ahci-mvebu
[    3.024837] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] por=
t 0x100 irq 53
[    3.032784] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] por=
t 0x180 irq 53
[    3.041624] spi-nor spi0.0: s25fl164k (8192 Kbytes)
[    3.046534] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.052918] Creating 2 MTD partitions on "spi0.0":
[    3.057723] 0x000000000000-0x000000100000 : "U-Boot"
[    3.071739] 0x000000100000-0x000000800000 : "Rescue system"
[    3.092049] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for=
 information.
[    3.099901] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason=
@zx2c4.com>. All Rights Reserved.
[    3.110165] libphy: Fixed MDIO Bus: probed
[    3.114489] tun: Universal TUN/TAP device driver, 1.6
[    3.119943] libphy: orion_mdio_bus: probed
[    3.125168] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marv=
ell 88E6176, revision 1
[    3.337489] libphy: mv88e6xxx SMI: probed
[    3.348427] mvneta_bm f10c8000.bm: failed to allocate internal memory
[    3.354912] mvneta_bm: probe of f10c8000.bm failed with error -12
[    3.361844] mvneta f1070000.ethernet eth0: Using hardware mac address d8=
:58:d7:00:4e:98
[    3.370661] mvneta f1030000.ethernet eth1: Using hardware mac address d8=
:58:d7:00:4e:96
[    3.379452] mvneta f1034000.ethernet eth2: Using hardware mac address d8=
:58:d7:00:4e:97
[    3.382747] ata1: SATA link down (SStatus 0 SControl 300)
[    3.387737] pci 0000:00:01.0: enabling device (0140 -> 0142)
[    3.392932] ata2: SATA link down (SStatus 0 SControl 300)
[    3.485413] ath: EEPROM regdomain sanitized
[    3.485417] ath: EEPROM regdomain: 0x64
[    3.485421] ath: EEPROM indicates we should expect a direct regpair map
[    3.485427] ath: Country alpha2 being used: 00
[    3.485431] ath: Regpair used: 0x64
[    3.487037] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[    3.487723] ieee80211 phy0: Atheros AR9287 Rev:2 mem=3D0xf08c0000, irq=
=3D61
[    3.494787] pci 0000:00:02.0: enabling device (0140 -> 0142)
[    3.500670] ath10k_pci 0000:02:00.0: pci irq msi oper_irq_mode 2 irq_mod=
e 0 reset_mode 0
[    3.611778] pci 0000:00:03.0: enabling device (0140 -> 0142)
[    3.617534] mt76x2e 0000:03:00.0: ASIC revision: 76120044
[    3.736545] ath10k_pci 0000:02:00.0: qca988x hw2.0 target 0x4100016c chi=
p_id 0x043202ff sub 0000:0000
[    3.745816] ath10k_pci 0000:02:00.0: kconfig debug 1 debugfs 1 tracing 1=
 dfs 0 testmode 0
[    3.754631] ath10k_pci 0000:02:00.0: firmware ver 10.2.4-1.0-00047 api 5=
 features no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 35bd9258
[    3.799430] ath10k_pci 0000:02:00.0: board_file api 1 bmi_id N/A crc32 b=
ebc7c08
[    4.272133] mt76x2e 0000:03:00.0: ROM patch build: 20141115060606a
[    4.279423] mt76x2e 0000:03:00.0: Firmware Version: 0.0.00
[    4.284936] mt76x2e 0000:03:00.0: Build: 1
[    4.289043] mt76x2e 0000:03:00.0: Build Time: 201507311614____
[    4.311382] mt76x2e 0000:03:00.0: Firmware running!
[    4.316666] ieee80211 phy2: Selected rate control algorithm 'minstrel_ht'
[    4.317581] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.324153] ehci-pci: EHCI PCI platform driver
[    4.328626] ehci-orion: EHCI orion driver
[    4.332765] orion-ehci f1058000.usb: EHCI Host Controller
[    4.338189] orion-ehci f1058000.usb: new USB bus registered, assigned bu=
s number 1
[    4.345840] orion-ehci f1058000.usb: irq 49, io mem 0xf1058000
[    4.381383] orion-ehci f1058000.usb: USB 2.0 started, EHCI 1.00
[    4.387686] hub 1-0:1.0: USB hub found
[    4.391487] hub 1-0:1.0: 1 port detected
[    4.395906] xhci-hcd f10f0000.usb3: xHCI Host Controller
[    4.401243] xhci-hcd f10f0000.usb3: new USB bus registered, assigned bus=
 number 2
[    4.408813] xhci-hcd f10f0000.usb3: hcc params 0x0a000990 hci version 0x=
100 quirks 0x0000000000010010
[    4.418108] xhci-hcd f10f0000.usb3: irq 55, io mem 0xf10f0000
[    4.424246] hub 2-0:1.0: USB hub found
[    4.428022] hub 2-0:1.0: 1 port detected
[    4.432125] xhci-hcd f10f0000.usb3: xHCI Host Controller
[    4.437457] xhci-hcd f10f0000.usb3: new USB bus registered, assigned bus=
 number 3
[    4.444981] xhci-hcd f10f0000.usb3: Host supports USB 3.0 SuperSpeed
[    4.451399] usb usb3: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    4.459764] hub 3-0:1.0: USB hub found
[    4.463554] hub 3-0:1.0: 1 port detected
[    4.467745] xhci-hcd f10f8000.usb3: xHCI Host Controller
[    4.473091] xhci-hcd f10f8000.usb3: new USB bus registered, assigned bus=
 number 4
[    4.480645] xhci-hcd f10f8000.usb3: hcc params 0x0a000990 hci version 0x=
100 quirks 0x0000000000010010
[    4.489931] xhci-hcd f10f8000.usb3: irq 56, io mem 0xf10f8000
[    4.496068] hub 4-0:1.0: USB hub found
[    4.499841] hub 4-0:1.0: 1 port detected
[    4.504872] xhci-hcd f10f8000.usb3: xHCI Host Controller
[    4.510202] xhci-hcd f10f8000.usb3: new USB bus registered, assigned bus=
 number 5
[    4.517734] xhci-hcd f10f8000.usb3: Host supports USB 3.0 SuperSpeed
[    4.524138] usb usb5: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    4.532517] hub 5-0:1.0: USB hub found
[    4.536289] hub 5-0:1.0: 1 port detected
[    4.540478] usbcore: registered new interface driver usb-storage
[    4.547239] armada38x-rtc f10a3800.rtc: registered as rtc0
[    4.552835] armada38x-rtc f10a3800.rtc: setting system clock to 2021-03-=
26T16:20:15 UTC (1616775615)
[    4.562130] i2c /dev entries driver
[    4.565923] i2c i2c-0: Not using recovery: no recover_bus() found
[    4.573058] at24 1-0054: supply vcc not found, using dummy regulator
[    4.580309] at24 1-0054: 8192 byte 24c64 EEPROM, writable, 1 bytes/write
[    4.587074] i2c i2c-0: Added multiplexed i2c bus 1
[    4.592013] i2c i2c-0: Added multiplexed i2c bus 2
[    4.596920] i2c i2c-0: Added multiplexed i2c bus 3
[    4.601835] i2c i2c-0: Added multiplexed i2c bus 4
[    4.606742] i2c i2c-0: Added multiplexed i2c bus 5
[    4.611719] i2c i2c-0: Added multiplexed i2c bus 6
[    4.616636] i2c i2c-0: Added multiplexed i2c bus 7
[    4.621758] pca953x 8-0071: supply vcc not found, using dummy regulator
[    4.628452] pca953x 8-0071: using no AI
[    4.632847] pca953x 8-0071: interrupt support not compiled in
[    4.639217] i2c i2c-0: Added multiplexed i2c bus 8
[    4.644095] pca954x 0-0070: registered 8 multiplexed busses for I2C mux =
pca9547
[    4.653257] orion_wdt: Initial timeout 171 sec
[    4.657949] sdhci: Secure Digital Host Controller Interface driver
[    4.664154] sdhci: Copyright(c) Pierre Ossman
[    4.668629] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.674605] ledtrig-cpu: registered to indicate activity on CPUs
[    4.681575] marvell-cesa f1090000.crypto: CESA device successfully regis=
tered
[    4.688898] usbcore: registered new interface driver usbhid
[    4.694525] usbhid: USB HID core driver
[    4.698475] GACT probability on
[    4.701661] Mirror/redirect action on
[    4.705344] Simple TC action Loaded
[    4.708868] u32 classifier
[    4.709904] mmc0: SDHCI controller on f10d8000.sdhci [f10d8000.sdhci] us=
ing ADMA
[    4.711587]     Performance counters on
[    4.711589]     input device check on
[    4.726537]     Actions configured
[    4.730425] NET: Registered protocol family 10
[    4.735700] Segment Routing with IPv6
[    4.739449] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    4.745712] NET: Registered protocol family 17
[    4.750262] 8021q: 802.1Q VLAN Support v1.8
[    4.754568] ThumbEE CPU extension supported.
[    4.758868] Registering SWP/SWPB emulation handler
[    4.763814] Loading compiled-in X.509 certificates
[    4.769890] Btrfs loaded, crc32c=3Dcrc32c-generic, zoned=3Dno
[    4.776962] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marv=
ell 88E6176, revision 1
[    4.857571] mmc0: new high speed MMC card at address 0001
[    4.863325] mmcblk0: mmc0:0001 H8G4a\x92 7.28 GiB=20
[    4.867990] mmcblk0boot0: mmc0:0001 H8G4a\x92 partition 1 4.00 MiB
[    4.884409] mmcblk0boot1: mmc0:0001 H8G4a\x92 partition 2 4.00 MiB
[    4.896614] mmcblk0rpmb: mmc0:0001 H8G4a\x92 partition 3 4.00 MiB, chard=
ev (250:0)
[    4.905592]  mmcblk0: p1
[    4.962991] libphy: mv88e6xxx SMI: probed
[    4.967796] ath10k_pci 0000:02:00.0: htt-ver 2.1 wmi-op 5 htt-op 2 cal o=
tp max-sta 128 raw 0 hwcrypto 1
[    5.082952] ath: EEPROM regdomain sanitized
[    5.082960] ath: EEPROM regdomain: 0x64
[    5.082964] ath: EEPROM indicates we should expect a direct regpair map
[    5.082970] ath: Country alpha2 being used: 00
[    5.082974] ath: Regpair used: 0x64
[    5.616015] mv88e6085 f1072004.mdio-mii:10 lan0 (uninitialized): PHY [mv=
88e6xxx-1:00] driver [Marvell 88E1540] (irq=3D75)
[    5.651333] mv88e6085 f1072004.mdio-mii:10 lan1 (uninitialized): PHY [mv=
88e6xxx-1:01] driver [Marvell 88E1540] (irq=3D76)
[    5.679855] mv88e6085 f1072004.mdio-mii:10 lan2 (uninitialized): PHY [mv=
88e6xxx-1:02] driver [Marvell 88E1540] (irq=3D77)
[    5.715061] mv88e6085 f1072004.mdio-mii:10 lan3 (uninitialized): PHY [mv=
88e6xxx-1:03] driver [Marvell 88E1540] (irq=3D78)
[    5.745795] mv88e6085 f1072004.mdio-mii:10 lan4 (uninitialized): PHY [mv=
88e6xxx-1:04] driver [Marvell 88E1540] (irq=3D79)
[    5.762566] mv88e6085 f1072004.mdio-mii:10: configuring for fixed/rgmii-=
id link mode
[    5.772960] mv88e6085 f1072004.mdio-mii:10: Link is Up - 1Gbps/Full - fl=
ow control off
[    5.780968] DSA: tree 0 setup
[    5.784683] Waiting 2 sec before mounting root device...
[    5.790133] ath: EEPROM regdomain: 0x80d0
[    5.790138] ath: EEPROM indicates we should expect a country code
[    5.790141] ath: doing EEPROM country->regdmn map search
[    5.790143] ath: country maps to regdmn code: 0x37
[    5.790147] ath: Country alpha2 being used: DK
[    5.790150] ath: Regpair used: 0x37
[    5.790156] ath: regdomain 0x80d0 dynamically updated by user
[    5.790193] ath: EEPROM regdomain: 0x80d0
[    5.790196] ath: EEPROM indicates we should expect a country code
[    5.790199] ath: doing EEPROM country->regdmn map search
[    5.790201] ath: country maps to regdmn code: 0x37
[    5.790204] ath: Country alpha2 being used: DK
[    5.790207] ath: Regpair used: 0x37
[    5.790211] ath: regdomain 0x80d0 dynamically updated by user
[    7.837897] BTRFS: device fsid 448334b8-1b27-4738-8118-9e70b56b1e58 devi=
d 1 transid 13774 /dev/root scanned by swapper/0 (1)
[    7.849813] BTRFS info (device mmcblk0p1): disk space caching is enabled
[    7.856549] BTRFS info (device mmcblk0p1): has skinny extents
[    7.868764] BTRFS info (device mmcblk0p1): enabling ssd optimizations
[    7.877839] VFS: Mounted root (btrfs filesystem) on device 0:13.
[    7.884300] devtmpfs: mounted
[    7.887886] Freeing unused kernel memory: 1024K
[    7.931610] Run /sbin/init as init process
[    7.935718]   with arguments:
[    7.935722]     /sbin/init
[    7.935726]     earlyprintk
[    7.935729]   with environment:
[    7.935731]     HOME=3D/
[    7.935734]     TERM=3Dlinux
[    8.001203] random: fast init done
[    8.361921] systemd[1]: systemd 247.3-1-arch running in system mode. (+P=
AM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GC=
RYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN=
 +PCRE2 default-hierarchy=3Dhybrid)
[    8.384851] systemd[1]: Detected architecture arm.
[    8.512663] systemd[1]: Set hostname to <omnia-arch>.
[    8.701050] systemd-gpt-auto-generator[173]: File system behind root fil=
e system is reported by btrfs to be backed by pseudo-device /dev/root, whic=
h is not a valid userspace accessible device node. Cannot determine correct=
 backing block device.
[    8.724725] systemd[167]: /usr/lib/systemd/system-generators/systemd-gpt=
-auto-generator failed with exit status 1.
[    8.940665] systemd[1]: Queued start job for default target Graphical In=
terface.
[    8.948762] random: systemd: uninitialized urandom read (16 bytes read)
[    8.976192] systemd[1]: Created slice system-getty.slice.
[    9.011489] random: systemd: uninitialized urandom read (16 bytes read)
[    9.019036] systemd[1]: Created slice system-modprobe.slice.
[    9.051479] random: systemd: uninitialized urandom read (16 bytes read)
[    9.058989] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    9.102304] systemd[1]: Created slice User and Session Slice.
[    9.141626] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    9.181591] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    9.221501] systemd[1]: Condition check resulted in Arbitrary Executable=
 File Formats File System Automount Point being skipped.
[    9.233245] systemd[1]: Reached target Local Encrypted Volumes.
[    9.281608] systemd[1]: Reached target Paths.
[    9.311499] systemd[1]: Reached target Remote File Systems.
[    9.351458] systemd[1]: Reached target Slices.
[    9.381494] systemd[1]: Reached target Swap.
[    9.411697] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    9.463054] systemd[1]: Listening on Process Core Dump Socket.
[    9.505727] systemd[1]: Condition check resulted in Journal Audit Socket=
 being skipped.
[    9.515082] systemd[1]: Listening on Journal Socket (/dev/log).
[    9.561786] systemd[1]: Listening on Journal Socket.
[    9.608194] systemd[1]: Listening on Network Service Netlink Socket.
[    9.653001] systemd[1]: Listening on udev Control Socket.
[    9.701707] systemd[1]: Listening on udev Kernel Socket.
[    9.751738] systemd[1]: Condition check resulted in Huge Pages File Syst=
em being skipped.
[    9.760158] systemd[1]: Condition check resulted in POSIX Message Queue =
File System being skipped.
[    9.771842] systemd[1]: Mounting Kernel Debug File System...
[    9.824052] systemd[1]: Mounting Kernel Trace File System...
[    9.864055] systemd[1]: Mounting Temporary Directory (/tmp)...
[    9.901704] systemd[1]: Condition check resulted in Create list of stati=
c device nodes for the current kernel being skipped.
[    9.915840] systemd[1]: Starting Load Kernel Module configfs...
[    9.954174] systemd[1]: Starting Load Kernel Module drm...
[    9.994448] systemd[1]: Starting Load Kernel Module fuse...
[   10.038218] systemd[1]: Condition check resulted in Set Up Additional Bi=
nary Formats being skipped.
[   10.048741] systemd[1]: Condition check resulted in Load Kernel Modules =
being skipped.
[   10.059545] systemd[1]: Starting Remount Root and Kernel File Systems...
[   10.101616] systemd[1]: Condition check resulted in Repartition Root Dis=
k being skipped.
[   10.112555] systemd[1]: Starting Apply Kernel Variables...
[   10.154279] systemd[1]: Starting Coldplug All udev Devices...
[   10.196174] systemd[1]: Mounted Kernel Debug File System.
[   10.232075] systemd[1]: Mounted Kernel Trace File System.
[   10.271750] systemd[1]: Mounted Temporary Directory (/tmp).
[   10.311990] systemd[1]: modprobe@configfs.service: Succeeded.
[   10.318833] systemd[1]: Finished Load Kernel Module configfs.
[   10.356178] systemd[1]: modprobe@drm.service: Succeeded.
[   10.362801] systemd[1]: Finished Load Kernel Module drm.
[   10.402063] systemd[1]: modprobe@fuse.service: Succeeded.
[   10.408508] systemd[1]: Finished Load Kernel Module fuse.
[   10.442754] systemd[1]: Finished Remount Root and Kernel File Systems.
[   10.482774] systemd[1]: Finished Apply Kernel Variables.
[   10.524656] systemd[1]: Condition check resulted in FUSE Control File Sy=
stem being skipped.
[   10.533471] systemd[1]: Condition check resulted in Kernel Configuration=
 File System being skipped.
[   10.542901] systemd[1]: Condition check resulted in First Boot Wizard be=
ing skipped.
[   10.558481] systemd[1]: Condition check resulted in Rebuild Hardware Dat=
abase being skipped.
[   10.569814] systemd[1]: Starting Load/Save Random Seed...
[   10.591724] systemd[1]: Condition check resulted in Create System Users =
being skipped.
[   10.604115] systemd[1]: Starting Create Static Device Nodes in /dev...
[   10.713433] systemd[1]: Finished Create Static Device Nodes in /dev.
[   10.731783] systemd[1]: Reached target Local File Systems (Pre).
[   10.751621] systemd[1]: Condition check resulted in Virtual Machine and =
Container Storage (Compatibility) being skipped.
[   10.762698] systemd[1]: Reached target Local File Systems.
[   10.804744] systemd[1]: Started Entropy Daemon based on the HAVEGE algor=
ithm.
[   10.851807] systemd[1]: Condition check resulted in Rebuild Dynamic Link=
er Cache being skipped.
[   10.864572] systemd[1]: Starting Journal Service...
[   10.885604] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[   10.933455] systemd[1]: Finished Coldplug All udev Devices.
[   11.003259] systemd[1]: Started Journal Service.
[   11.107515] systemd-journald[193]: Received client request to flush runt=
ime journal.
[   12.370305] mvneta f1034000.ethernet eth2: PHY [f1072004.mdio-mii:01] dr=
iver [Marvell 88E1510] (irq=3DPOLL)
[   12.402376] mvneta f1034000.ethernet eth2: configuring for phy/sgmii lin=
k mode
[   12.717844] mvneta f1070000.ethernet eth0: configuring for fixed/rgmii l=
ink mode
[   12.728688] mvneta f1070000.ethernet eth0: Link is Up - 1Gbps/Full - flo=
w control off
[   12.923038] ath9k 0000:01:00.0 wlp1s0: renamed from wlan0
[   13.032064] random: crng init done
[   13.035500] random: 7 urandom warning(s) missed due to ratelimiting
[   13.047961] mt76x2e 0000:03:00.0 wlp3s0: renamed from wlan1
[   13.210519] ath10k_pci 0000:02:00.0 wlp2s0: renamed from wlan2
[   13.259848] BTRFS info (device mmcblk0p1): devid 1 device path /dev/root=
 changed to /dev/mmcblk0p1 scanned by systemd-udevd (200)
[   15.521757] mvneta f1034000.ethernet eth2: Link is Up - 1Gbps/Full - flo=
w control rx/tx
[   15.626452] ath10k_pci 0000:02:00.0: pdev param 0 not supported by firmw=
are
[   15.648452] IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready

ASPM enabled, no patch:
[    1.592272] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.592280] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
[    1.592290] pci 0000:02:00.0: BAR 0: assigned [mem 0xe0200000-0xe03fffff=
 64bit]
[    1.592298] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 !=3D 0xf=
fffffff)
[    1.592305] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 !=3D =
0xffffffff)
[    1.592313] pci 0000:02:00.0: BAR 6: assigned [mem 0xe0400000-0xe040ffff=
 pref]
[    1.592320] pci 0000:00:02.0: PCI bridge to [bus 02]
[    1.592326] pci 0000:00:02.0:   bridge window [mem 0xe0200000-0xe04fffff]
[    1.592336] pci 0000:03:00.0: BAR 0: assigned [mem 0xe0600000-0xe06fffff=
 64bit]
[    1.592349] pci 0000:03:00.0: BAR 6: assigned [mem 0xe0700000-0xe070ffff=
 pref]
[    1.592357] pci 0000:00:03.0: PCI bridge to [bus 03]
[    1.592363] pci 0000:00:03.0:   bridge window [mem 0xe0600000-0xe07fffff]
[    1.592639] mv_xor f1060800.xor: Marvell shared XOR driver
[    1.651773] mv_xor f1060800.xor: Marvell XOR (Descriptor Mode): ( xor cp=
y intr )
[    1.651912] mv_xor f1060900.xor: Marvell shared XOR driver
[    1.711771] mv_xor f1060900.xor: Marvell XOR (Descriptor Mode): ( xor cp=
y intr )
[    1.730234] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.731099] printk: console [ttyS0] disabled
[    1.751190] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq =3D 30, base_=
baud =3D 15625000) is a 16550A
[    3.098634] printk: console [ttyS0] enabled
[    3.123524] f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq =3D 31, base_=
baud =3D 15625000) is a 16550A
[    3.133234] ahci-mvebu f10a8000.sata: supply ahci not found, using dummy=
 regulator
[    3.140900] ahci-mvebu f10a8000.sata: supply phy not found, using dummy =
regulator
[    3.148455] ahci-mvebu f10a8000.sata: supply target not found, using dum=
my regulator
[    3.156311] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots 2 ports 6 =
Gbps 0x3 impl platform mode
[    3.165396] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp=
 fbs pio slum part sxs=20
[    3.174645] scsi host0: ahci-mvebu
[    3.178287] scsi host1: ahci-mvebu
[    3.181806] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] por=
t 0x100 irq 53
[    3.189747] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] por=
t 0x180 irq 53
[    3.198555] spi-nor spi0.0: s25fl164k (8192 Kbytes)
[    3.203487] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.209858] Creating 2 MTD partitions on "spi0.0":
[    3.214668] 0x000000000000-0x000000100000 : "U-Boot"
[    3.231750] 0x000000100000-0x000000800000 : "Rescue system"
[    3.238228] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for=
 information.
[    3.246104] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason=
@zx2c4.com>. All Rights Reserved.
[    3.256368] libphy: Fixed MDIO Bus: probed
[    3.260622] tun: Universal TUN/TAP device driver, 1.6
[    3.266077] libphy: orion_mdio_bus: probed
[    3.271350] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marv=
ell 88E6176, revision 1
[    3.496234] libphy: mv88e6xxx SMI: probed
[    3.507137] mvneta_bm f10c8000.bm: failed to allocate internal memory
[    3.513632] mvneta_bm: probe of f10c8000.bm failed with error -12
[    3.520579] mvneta f1070000.ethernet eth0: Using hardware mac address d8=
:58:d7:00:4e:98
[    3.529438] mvneta f1030000.ethernet eth1: Using hardware mac address d8=
:58:d7:00:4e:96
[    3.532721] ata2: SATA link down (SStatus 0 SControl 300)
[    3.543677] mvneta f1034000.ethernet eth2: Using hardware mac address d8=
:58:d7:00:4e:97
[    3.551400] ata1: SATA link down (SStatus 0 SControl 300)
[    3.551984] pci 0000:00:01.0: enabling device (0140 -> 0142)
[    3.562825] ath9k 0000:01:00.0: enabling device (0000 -> 0002)
[    3.568745] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by this d=
river
[    3.575912] ath: phy0: Unable to initialize hardware; initialization sta=
tus: -95
[    3.583348] ath9k 0000:01:00.0: Failed to initialize device
[    3.588955] ath9k: probe of 0000:01:00.0 failed with error -95
[    3.594889] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed with rc=3D=
134
[    3.601924] pci 0000:00:02.0: enabling device (0140 -> 0142)
[    3.607610] ath10k_pci 0000:02:00.0: can't change power state from D3hot=
 to D0 (config space inaccessible)
[    3.647457] ath10k_pci 0000:02:00.0: failed to wake up device : -110
[    3.653973] ath10k_pci: probe of 0000:02:00.0 failed with error -110
[    3.660490] pci 0000:00:03.0: enabling device (0140 -> 0142)
[    3.666248] mt76x2e 0000:03:00.0: ASIC revision: 76120044
[    4.322137] mt76x2e 0000:03:00.0: ROM patch build: 20141115060606a
[    4.329426] mt76x2e 0000:03:00.0: Firmware Version: 0.0.00
[    4.334938] mt76x2e 0000:03:00.0: Build: 1
[    4.339044] mt76x2e 0000:03:00.0: Build Time: 201507311614____
[    4.361396] mt76x2e 0000:03:00.0: Firmware running!
[    4.366676] ieee80211 phy2: Selected rate control algorithm 'minstrel_ht'
[    4.367557] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.374129] ehci-pci: EHCI PCI platform driver
[    4.378601] ehci-orion: EHCI orion driver
[    4.382735] orion-ehci f1058000.usb: EHCI Host Controller
[    4.388159] orion-ehci f1058000.usb: new USB bus registered, assigned bu=
s number 1
[    4.395807] orion-ehci f1058000.usb: irq 49, io mem 0xf1058000
[    4.431395] orion-ehci f1058000.usb: USB 2.0 started, EHCI 1.00
[    4.437694] hub 1-0:1.0: USB hub found
[    4.441482] hub 1-0:1.0: 1 port detected
[    4.445898] xhci-hcd f10f0000.usb3: xHCI Host Controller
[    4.451233] xhci-hcd f10f0000.usb3: new USB bus registered, assigned bus=
 number 2
[    4.458801] xhci-hcd f10f0000.usb3: hcc params 0x0a000990 hci version 0x=
100 quirks 0x0000000000010010
[    4.468077] xhci-hcd f10f0000.usb3: irq 55, io mem 0xf10f0000
[    4.474214] hub 2-0:1.0: USB hub found
[    4.477988] hub 2-0:1.0: 1 port detected
[    4.482079] xhci-hcd f10f0000.usb3: xHCI Host Controller
[    4.487408] xhci-hcd f10f0000.usb3: new USB bus registered, assigned bus=
 number 3
[    4.494934] xhci-hcd f10f0000.usb3: Host supports USB 3.0 SuperSpeed
[    4.501331] usb usb3: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    4.509702] hub 3-0:1.0: USB hub found
[    4.513483] hub 3-0:1.0: 1 port detected
[    4.517673] xhci-hcd f10f8000.usb3: xHCI Host Controller
[    4.523018] xhci-hcd f10f8000.usb3: new USB bus registered, assigned bus=
 number 4
[    4.530572] xhci-hcd f10f8000.usb3: hcc params 0x0a000990 hci version 0x=
100 quirks 0x0000000000010010
[    4.539846] xhci-hcd f10f8000.usb3: irq 56, io mem 0xf10f8000
[    4.545966] hub 4-0:1.0: USB hub found
[    4.549738] hub 4-0:1.0: 1 port detected
[    4.553885] xhci-hcd f10f8000.usb3: xHCI Host Controller
[    4.559216] xhci-hcd f10f8000.usb3: new USB bus registered, assigned bus=
 number 5
[    4.566739] xhci-hcd f10f8000.usb3: Host supports USB 3.0 SuperSpeed
[    4.573144] usb usb5: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    4.581515] hub 5-0:1.0: USB hub found
[    4.585287] hub 5-0:1.0: 1 port detected
[    4.589465] usbcore: registered new interface driver usb-storage
[    4.596214] armada38x-rtc f10a3800.rtc: registered as rtc0
[    4.601799] armada38x-rtc f10a3800.rtc: setting system clock to 2021-03-=
26T16:11:35 UTC (1616775095)
[    4.611086] i2c /dev entries driver
[    4.614887] i2c i2c-0: Not using recovery: no recover_bus() found
[    4.622023] at24 1-0054: supply vcc not found, using dummy regulator
[    4.629281] at24 1-0054: 8192 byte 24c64 EEPROM, writable, 1 bytes/write
[    4.636062] i2c i2c-0: Added multiplexed i2c bus 1
[    4.640975] i2c i2c-0: Added multiplexed i2c bus 2
[    4.645896] i2c i2c-0: Added multiplexed i2c bus 3
[    4.650800] i2c i2c-0: Added multiplexed i2c bus 4
[    4.655728] i2c i2c-0: Added multiplexed i2c bus 5
[    4.660632] i2c i2c-0: Added multiplexed i2c bus 6
[    4.665602] i2c i2c-0: Added multiplexed i2c bus 7
[    4.670712] pca953x 8-0071: supply vcc not found, using dummy regulator
[    4.677408] pca953x 8-0071: using no AI
[    4.681786] pca953x 8-0071: interrupt support not compiled in
[    4.688149] i2c i2c-0: Added multiplexed i2c bus 8
[    4.693024] pca954x 0-0070: registered 8 multiplexed busses for I2C mux =
pca9547
[    4.701771] orion_wdt: Initial timeout 171 sec
[    4.706487] sdhci: Secure Digital Host Controller Interface driver
[    4.712694] sdhci: Copyright(c) Pierre Ossman
[    4.717166] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.723128] ledtrig-cpu: registered to indicate activity on CPUs
[    4.730073] marvell-cesa f1090000.crypto: CESA device successfully regis=
tered
[    4.737410] usbcore: registered new interface driver usbhid
[    4.743005] usbhid: USB HID core driver
[    4.746954] GACT probability on
[    4.748973] mmc0: SDHCI controller on f10d8000.sdhci [f10d8000.sdhci] us=
ing ADMA
[    4.750110] Mirror/redirect action on
[    4.761224] Simple TC action Loaded
[    4.764778] u32 classifier
[    4.767497]     Performance counters on
[    4.771352]     input device check on
[    4.775050]     Actions configured
[    4.778936] NET: Registered protocol family 10
[    4.784230] Segment Routing with IPv6
[    4.787967] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    4.794228] NET: Registered protocol family 17
[    4.798762] 8021q: 802.1Q VLAN Support v1.8
[    4.803057] ThumbEE CPU extension supported.
[    4.807340] Registering SWP/SWPB emulation handler
[    4.812276] Loading compiled-in X.509 certificates
[    4.818281] Btrfs loaded, crc32c=3Dcrc32c-generic, zoned=3Dno
[    4.825371] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marv=
ell 88E6176, revision 1
[    4.987606] mmc0: new high speed MMC card at address 0001
[    4.992837] libphy: mv88e6xxx SMI: probed
[    4.997259] mmcblk0: mmc0:0001 H8G4a\x92 7.28 GiB=20
[    5.002056] mmcblk0boot0: mmc0:0001 H8G4a\x92 partition 1 4.00 MiB
[    5.008124] mmcblk0boot1: mmc0:0001 H8G4a\x92 partition 2 4.00 MiB
[    5.014160] mmcblk0rpmb: mmc0:0001 H8G4a\x92 partition 3 4.00 MiB, chard=
ev (250:0)
[    5.022894]  mmcblk0: p1
[    5.641653] mv88e6085 f1072004.mdio-mii:10 lan0 (uninitialized): PHY [mv=
88e6xxx-1:00] driver [Marvell 88E1540] (irq=3D73)
[    5.672563] mv88e6085 f1072004.mdio-mii:10 lan1 (uninitialized): PHY [mv=
88e6xxx-1:01] driver [Marvell 88E1540] (irq=3D74)
[    5.705082] mv88e6085 f1072004.mdio-mii:10 lan2 (uninitialized): PHY [mv=
88e6xxx-1:02] driver [Marvell 88E1540] (irq=3D75)
[    5.731373] mv88e6085 f1072004.mdio-mii:10 lan3 (uninitialized): PHY [mv=
88e6xxx-1:03] driver [Marvell 88E1540] (irq=3D76)
[    5.766642] mv88e6085 f1072004.mdio-mii:10 lan4 (uninitialized): PHY [mv=
88e6xxx-1:04] driver [Marvell 88E1540] (irq=3D77)
[    5.783423] mv88e6085 f1072004.mdio-mii:10: configuring for fixed/rgmii-=
id link mode
[    5.793831] mv88e6085 f1072004.mdio-mii:10: Link is Up - 1Gbps/Full - fl=
ow control off
[    5.801848] DSA: tree 0 setup
[    5.805559] Waiting 2 sec before mounting root device...
[    7.837895] BTRFS: device fsid 448334b8-1b27-4738-8118-9e70b56b1e58 devi=
d 1 transid 13732 /dev/root scanned by swapper/0 (1)
[    7.849816] BTRFS info (device mmcblk0p1): disk space caching is enabled
[    7.856552] BTRFS info (device mmcblk0p1): has skinny extents
[    7.868426] BTRFS info (device mmcblk0p1): enabling ssd optimizations
[    7.877500] VFS: Mounted root (btrfs filesystem) on device 0:13.
[    7.883966] devtmpfs: mounted
[    7.887547] Freeing unused kernel memory: 1024K
[    7.931625] Run /sbin/init as init process
[    7.935733]   with arguments:
[    7.935737]     /sbin/init
[    7.935740]     earlyprintk
[    7.935743]   with environment:
[    7.935746]     HOME=3D/
[    7.935749]     TERM=3Dlinux
[    8.048502] random: fast init done
[    8.365030] systemd[1]: systemd 247.3-1-arch running in system mode. (+P=
AM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GC=
RYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN=
 +PCRE2 default-hierarchy=3Dhybrid)
[    8.388024] systemd[1]: Detected architecture arm.
[    8.462658] systemd[1]: Set hostname to <omnia-arch>.
[    8.627786] systemd-gpt-auto-generator[172]: File system behind root fil=
e system is reported by btrfs to be backed by pseudo-device /dev/root, whic=
h is not a valid userspace accessible device node. Cannot determine correct=
 backing block device.
[    8.655604] systemd[166]: /usr/lib/systemd/system-generators/systemd-gpt=
-auto-generator failed with exit status 1.
[    8.881598] systemd[1]: Queued start job for default target Graphical In=
terface.
[    8.889617] random: systemd: uninitialized urandom read (16 bytes read)
[    8.916194] systemd[1]: Created slice system-getty.slice.
[    8.951618] random: systemd: uninitialized urandom read (16 bytes read)
[    8.959166] systemd[1]: Created slice system-modprobe.slice.
[    8.991497] random: systemd: uninitialized urandom read (16 bytes read)
[    8.998988] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    9.032326] systemd[1]: Created slice User and Session Slice.
[    9.071643] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    9.111679] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    9.151521] systemd[1]: Condition check resulted in Arbitrary Executable=
 File Formats File System Automount Point being skipped.
[    9.163271] systemd[1]: Reached target Local Encrypted Volumes.
[    9.201592] systemd[1]: Reached target Paths.
[    9.231508] systemd[1]: Reached target Remote File Systems.
[    9.271473] systemd[1]: Reached target Slices.
[    9.301510] systemd[1]: Reached target Swap.
[    9.331712] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    9.382980] systemd[1]: Listening on Process Core Dump Socket.
[    9.425820] systemd[1]: Condition check resulted in Journal Audit Socket=
 being skipped.
[    9.435158] systemd[1]: Listening on Journal Socket (/dev/log).
[    9.481817] systemd[1]: Listening on Journal Socket.
[    9.518192] systemd[1]: Listening on Network Service Netlink Socket.
[    9.563010] systemd[1]: Listening on udev Control Socket.
[    9.611715] systemd[1]: Listening on udev Kernel Socket.
[    9.661746] systemd[1]: Condition check resulted in Huge Pages File Syst=
em being skipped.
[    9.670165] systemd[1]: Condition check resulted in POSIX Message Queue =
File System being skipped.
[    9.681829] systemd[1]: Mounting Kernel Debug File System...
[    9.724106] systemd[1]: Mounting Kernel Trace File System...
[    9.764065] systemd[1]: Mounting Temporary Directory (/tmp)...
[    9.801730] systemd[1]: Condition check resulted in Create list of stati=
c device nodes for the current kernel being skipped.
[    9.815900] systemd[1]: Starting Load Kernel Module configfs...
[    9.854292] systemd[1]: Starting Load Kernel Module drm...
[    9.894496] systemd[1]: Starting Load Kernel Module fuse...
[    9.938207] systemd[1]: Condition check resulted in Set Up Additional Bi=
nary Formats being skipped.
[    9.948767] systemd[1]: Condition check resulted in Load Kernel Modules =
being skipped.
[    9.959564] systemd[1]: Starting Remount Root and Kernel File Systems...
[   10.001625] systemd[1]: Condition check resulted in Repartition Root Dis=
k being skipped.
[   10.012531] systemd[1]: Starting Apply Kernel Variables...
[   10.054299] systemd[1]: Starting Coldplug All udev Devices...
[   10.106173] systemd[1]: Mounted Kernel Debug File System.
[   10.151975] systemd[1]: Mounted Kernel Trace File System.
[   10.201691] systemd[1]: Mounted Temporary Directory (/tmp).
[   10.242004] systemd[1]: modprobe@configfs.service: Succeeded.
[   10.248810] systemd[1]: Finished Load Kernel Module configfs.
[   10.286193] systemd[1]: modprobe@drm.service: Succeeded.
[   10.292770] systemd[1]: Finished Load Kernel Module drm.
[   10.332207] systemd[1]: modprobe@fuse.service: Succeeded.
[   10.338606] systemd[1]: Finished Load Kernel Module fuse.
[   10.372731] systemd[1]: Finished Remount Root and Kernel File Systems.
[   10.412748] systemd[1]: Finished Apply Kernel Variables.
[   10.464629] systemd[1]: Condition check resulted in FUSE Control File Sy=
stem being skipped.
[   10.473431] systemd[1]: Condition check resulted in Kernel Configuration=
 File System being skipped.
[   10.482779] systemd[1]: Condition check resulted in First Boot Wizard be=
ing skipped.
[   10.498346] systemd[1]: Condition check resulted in Rebuild Hardware Dat=
abase being skipped.
[   10.509666] systemd[1]: Starting Load/Save Random Seed...
[   10.531781] systemd[1]: Condition check resulted in Create System Users =
being skipped.
[   10.543704] systemd[1]: Starting Create Static Device Nodes in /dev...
[   10.722733] systemd[1]: Finished Create Static Device Nodes in /dev.
[   10.773072] systemd[1]: Finished Coldplug All udev Devices.
[   10.811698] systemd[1]: Reached target Local File Systems (Pre).
[   10.851561] systemd[1]: Condition check resulted in Virtual Machine and =
Container Storage (Compatibility) being skipped.
[   10.862560] systemd[1]: Reached target Local File Systems.
[   10.904738] systemd[1]: Started Entropy Daemon based on the HAVEGE algor=
ithm.
[   10.941790] systemd[1]: Condition check resulted in Rebuild Dynamic Link=
er Cache being skipped.
[   10.954403] systemd[1]: Starting Journal Service...
[   11.002108] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[   11.104142] systemd[1]: Started Journal Service.
[   11.205698] systemd-journald[193]: Received client request to flush runt=
ime journal.
[   12.715234] mvneta f1034000.ethernet eth2: PHY [f1072004.mdio-mii:01] dr=
iver [Marvell 88E1510] (irq=3DPOLL)
[   12.742129] mvneta f1034000.ethernet eth2: configuring for phy/sgmii lin=
k mode
[   12.867939] mvneta f1070000.ethernet eth0: configuring for fixed/rgmii l=
ink mode
[   12.888463] mvneta f1070000.ethernet eth0: Link is Up - 1Gbps/Full - flo=
w control off
[   13.003326] mt76x2e 0000:03:00.0 wlp3s0: renamed from wlan0
[   13.110923] random: crng init done
[   13.141526] random: 7 urandom warning(s) missed due to ratelimiting
[   13.320567] BTRFS info (device mmcblk0p1): devid 1 device path /dev/root=
 changed to /dev/mmcblk0p1 scanned by systemd-udevd (199)
[   15.911774] mvneta f1034000.ethernet eth2: Link is Up - 1Gbps/Full - flo=
w control rx/tx
[   15.919818] IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready

ASPM enabled, with patch:
[    1.631901] mv_xor f1060900.xor: Marvell shared XOR driver
[    1.691759] mv_xor f1060900.xor: Marvell XOR (Descriptor Mode): ( xor cp=
y intr )
[    1.710225] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.711090] printk: console [ttyS0] disabled
[    1.731185] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq =3D 30, base_=
baud =3D 15625000) is a 16550A
[    3.086738] printk: console [ttyS0] enabled
[    3.111636] f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq =3D 31, base_=
baud =3D 15625000) is a 16550A
[    3.121337] ahci-mvebu f10a8000.sata: supply ahci not found, using dummy=
 regulator
[    3.129018] ahci-mvebu f10a8000.sata: supply phy not found, using dummy =
regulator
[    3.136573] ahci-mvebu f10a8000.sata: supply target not found, using dum=
my regulator
[    3.144419] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots 2 ports 6 =
Gbps 0x3 impl platform mode
[    3.153514] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp=
 fbs pio slum part sxs=20
[    3.162766] scsi host0: ahci-mvebu
[    3.166400] scsi host1: ahci-mvebu
[    3.169909] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] por=
t 0x100 irq 53
[    3.177861] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] por=
t 0x180 irq 53
[    3.186676] spi-nor spi0.0: s25fl164k (8192 Kbytes)
[    3.191598] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.197969] Creating 2 MTD partitions on "spi0.0":
[    3.202779] 0x000000000000-0x000000100000 : "U-Boot"
[    3.221737] 0x000000100000-0x000000800000 : "Rescue system"
[    3.228225] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for=
 information.
[    3.236100] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason=
@zx2c4.com>. All Rights Reserved.
[    3.246357] libphy: Fixed MDIO Bus: probed
[    3.250614] tun: Universal TUN/TAP device driver, 1.6
[    3.256068] libphy: orion_mdio_bus: probed
[    3.261289] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marv=
ell 88E6176, revision 1
[    3.483904] libphy: mv88e6xxx SMI: probed
[    3.494715] mvneta_bm f10c8000.bm: failed to allocate internal memory
[    3.501206] mvneta_bm: probe of f10c8000.bm failed with error -12
[    3.508159] mvneta f1070000.ethernet eth0: Using hardware mac address d8=
:58:d7:00:4e:98
[    3.516220] ata2: SATA link down (SStatus 0 SControl 300)
[    3.521683] ata1: SATA link down (SStatus 0 SControl 300)
[    3.527904] mvneta f1030000.ethernet eth1: Using hardware mac address d8=
:58:d7:00:4e:96
[    3.536693] mvneta f1034000.ethernet eth2: Using hardware mac address d8=
:58:d7:00:4e:97
[    3.544979] pci 0000:00:01.0: enabling device (0140 -> 0142)
[    3.550664] ath9k 0000:01:00.0: enabling device (0000 -> 0002)
[    3.556599] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by this d=
river
[    3.563783] ath: phy0: Unable to initialize hardware; initialization sta=
tus: -95
[    3.571200] ath9k 0000:01:00.0: Failed to initialize device
[    3.576817] ath9k: probe of 0000:01:00.0 failed with error -95
[    3.583038] pci 0000:00:02.0: enabling device (0140 -> 0142)
[    3.588904] ath10k_pci 0000:02:00.0: pci irq msi oper_irq_mode 2 irq_mod=
e 0 reset_mode 0
[    3.701778] pci 0000:00:03.0: enabling device (0140 -> 0142)
[    3.707530] mt76x2e 0000:03:00.0: ASIC revision: 76120044
[    3.836545] ath10k_pci 0000:02:00.0: qca988x hw2.0 target 0x4100016c chi=
p_id 0x043202ff sub 0000:0000
[    3.845813] ath10k_pci 0000:02:00.0: kconfig debug 1 debugfs 1 tracing 1=
 dfs 0 testmode 0
[    3.854625] ath10k_pci 0000:02:00.0: firmware ver 10.2.4-1.0-00047 api 5=
 features no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 35bd9258
[    3.899415] ath10k_pci 0000:02:00.0: board_file api 1 bmi_id N/A crc32 b=
ebc7c08
[    4.362131] mt76x2e 0000:03:00.0: ROM patch build: 20141115060606a
[    4.369421] mt76x2e 0000:03:00.0: Firmware Version: 0.0.00
[    4.374934] mt76x2e 0000:03:00.0: Build: 1
[    4.379041] mt76x2e 0000:03:00.0: Build Time: 201507311614____
[    4.401383] mt76x2e 0000:03:00.0: Firmware running!
[    4.406664] ieee80211 phy2: Selected rate control algorithm 'minstrel_ht'
[    4.407567] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.414141] ehci-pci: EHCI PCI platform driver
[    4.418614] ehci-orion: EHCI orion driver
[    4.422749] orion-ehci f1058000.usb: EHCI Host Controller
[    4.428172] orion-ehci f1058000.usb: new USB bus registered, assigned bu=
s number 1
[    4.435825] orion-ehci f1058000.usb: irq 49, io mem 0xf1058000
[    4.471384] orion-ehci f1058000.usb: USB 2.0 started, EHCI 1.00
[    4.477701] hub 1-0:1.0: USB hub found
[    4.481498] hub 1-0:1.0: 1 port detected
[    4.485916] xhci-hcd f10f0000.usb3: xHCI Host Controller
[    4.491253] xhci-hcd f10f0000.usb3: new USB bus registered, assigned bus=
 number 2
[    4.498822] xhci-hcd f10f0000.usb3: hcc params 0x0a000990 hci version 0x=
100 quirks 0x0000000000010010
[    4.508116] xhci-hcd f10f0000.usb3: irq 55, io mem 0xf10f0000
[    4.514262] hub 2-0:1.0: USB hub found
[    4.518035] hub 2-0:1.0: 1 port detected
[    4.522138] xhci-hcd f10f0000.usb3: xHCI Host Controller
[    4.527468] xhci-hcd f10f0000.usb3: new USB bus registered, assigned bus=
 number 3
[    4.534993] xhci-hcd f10f0000.usb3: Host supports USB 3.0 SuperSpeed
[    4.541411] usb usb3: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    4.549785] hub 3-0:1.0: USB hub found
[    4.553574] hub 3-0:1.0: 1 port detected
[    4.557768] xhci-hcd f10f8000.usb3: xHCI Host Controller
[    4.563115] xhci-hcd f10f8000.usb3: new USB bus registered, assigned bus=
 number 4
[    4.570665] xhci-hcd f10f8000.usb3: hcc params 0x0a000990 hci version 0x=
100 quirks 0x0000000000010010
[    4.579950] xhci-hcd f10f8000.usb3: irq 56, io mem 0xf10f8000
[    4.586077] hub 4-0:1.0: USB hub found
[    4.589849] hub 4-0:1.0: 1 port detected
[    4.594849] xhci-hcd f10f8000.usb3: xHCI Host Controller
[    4.600178] xhci-hcd f10f8000.usb3: new USB bus registered, assigned bus=
 number 5
[    4.607711] xhci-hcd f10f8000.usb3: Host supports USB 3.0 SuperSpeed
[    4.614117] usb usb5: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    4.622494] hub 5-0:1.0: USB hub found
[    4.626265] hub 5-0:1.0: 1 port detected
[    4.630439] usbcore: registered new interface driver usb-storage
[    4.637200] armada38x-rtc f10a3800.rtc: registered as rtc0
[    4.642796] armada38x-rtc f10a3800.rtc: setting system clock to 2021-03-=
26T15:21:33 UTC (1616772093)
[    4.652088] i2c /dev entries driver
[    4.655879] i2c i2c-0: Not using recovery: no recover_bus() found
[    4.663003] at24 1-0054: supply vcc not found, using dummy regulator
[    4.670261] at24 1-0054: 8192 byte 24c64 EEPROM, writable, 1 bytes/write
[    4.677027] i2c i2c-0: Added multiplexed i2c bus 1
[    4.681962] i2c i2c-0: Added multiplexed i2c bus 2
[    4.686871] i2c i2c-0: Added multiplexed i2c bus 3
[    4.691781] i2c i2c-0: Added multiplexed i2c bus 4
[    4.696685] i2c i2c-0: Added multiplexed i2c bus 5
[    4.701657] i2c i2c-0: Added multiplexed i2c bus 6
[    4.706568] i2c i2c-0: Added multiplexed i2c bus 7
[    4.711692] pca953x 8-0071: supply vcc not found, using dummy regulator
[    4.718379] pca953x 8-0071: using no AI
[    4.722770] pca953x 8-0071: interrupt support not compiled in
[    4.729132] i2c i2c-0: Added multiplexed i2c bus 8
[    4.734009] pca954x 0-0070: registered 8 multiplexed busses for I2C mux =
pca9547
[    4.743152] orion_wdt: Initial timeout 171 sec
[    4.747871] sdhci: Secure Digital Host Controller Interface driver
[    4.754077] sdhci: Copyright(c) Pierre Ossman
[    4.758547] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.764523] ledtrig-cpu: registered to indicate activity on CPUs
[    4.771498] marvell-cesa f1090000.crypto: CESA device successfully regis=
tered
[    4.778822] usbcore: registered new interface driver usbhid
[    4.784448] usbhid: USB HID core driver
[    4.788400] GACT probability on
[    4.791591] Mirror/redirect action on
[    4.795273] Simple TC action Loaded
[    4.798799] u32 classifier
[    4.799815] mmc0: SDHCI controller on f10d8000.sdhci [f10d8000.sdhci] us=
ing ADMA
[    4.801518]     Performance counters on
[    4.801520]     input device check on
[    4.801521]     Actions configured
[    4.801981] NET: Registered protocol family 10
[    4.825094] Segment Routing with IPv6
[    4.828820] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    4.835086] NET: Registered protocol family 17
[    4.839638] 8021q: 802.1Q VLAN Support v1.8
[    4.843942] ThumbEE CPU extension supported.
[    4.848240] Registering SWP/SWPB emulation handler
[    4.853185] Loading compiled-in X.509 certificates
[    4.859289] Btrfs loaded, crc32c=3Dcrc32c-generic, zoned=3Dno
[    4.866364] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marv=
ell 88E6176, revision 1
[    4.947964] mmc0: new high speed MMC card at address 0001
[    4.953701] mmcblk0: mmc0:0001 H8G4a\x92 7.28 GiB=20
[    4.958373] mmcblk0boot0: mmc0:0001 H8G4a\x92 partition 1 4.00 MiB
[    4.974792] mmcblk0boot1: mmc0:0001 H8G4a\x92 partition 2 4.00 MiB
[    4.981468] mmcblk0rpmb: mmc0:0001 H8G4a\x92 partition 3 4.00 MiB, chard=
ev (250:0)
[    4.990436]  mmcblk0: p1
[    5.045869] libphy: mv88e6xxx SMI: probed
[    5.065394] ath10k_pci 0000:02:00.0: htt-ver 2.1 wmi-op 5 htt-op 2 cal o=
tp max-sta 128 raw 0 hwcrypto 1
[    5.182884] ath: EEPROM regdomain sanitized
[    5.182892] ath: EEPROM regdomain: 0x64
[    5.182897] ath: EEPROM indicates we should expect a direct regpair map
[    5.182903] ath: Country alpha2 being used: 00
[    5.182907] ath: Regpair used: 0x64
[    5.697833] mv88e6085 f1072004.mdio-mii:10 lan0 (uninitialized): PHY [mv=
88e6xxx-1:00] driver [Marvell 88E1540] (irq=3D75)
[    5.730170] mv88e6085 f1072004.mdio-mii:10 lan1 (uninitialized): PHY [mv=
88e6xxx-1:01] driver [Marvell 88E1540] (irq=3D76)
[    5.765363] mv88e6085 f1072004.mdio-mii:10 lan2 (uninitialized): PHY [mv=
88e6xxx-1:02] driver [Marvell 88E1540] (irq=3D77)
[    5.798260] mv88e6085 f1072004.mdio-mii:10 lan3 (uninitialized): PHY [mv=
88e6xxx-1:03] driver [Marvell 88E1540] (irq=3D78)
[    5.828978] mv88e6085 f1072004.mdio-mii:10 lan4 (uninitialized): PHY [mv=
88e6xxx-1:04] driver [Marvell 88E1540] (irq=3D79)
[    5.847992] mv88e6085 f1072004.mdio-mii:10: configuring for fixed/rgmii-=
id link mode
[    5.858403] mv88e6085 f1072004.mdio-mii:10: Link is Up - 1Gbps/Full - fl=
ow control off
[    5.866420] DSA: tree 0 setup
[    5.870132] Waiting 2 sec before mounting root device...
[    5.875609] ath: EEPROM regdomain: 0x80d0
[    5.875614] ath: EEPROM indicates we should expect a country code
[    5.875617] ath: doing EEPROM country->regdmn map search
[    5.875620] ath: country maps to regdmn code: 0x37
[    5.875624] ath: Country alpha2 being used: DK
[    5.875627] ath: Regpair used: 0x37
[    5.875633] ath: regdomain 0x80d0 dynamically updated by user
[    7.917893] BTRFS: device fsid 448334b8-1b27-4738-8118-9e70b56b1e58 devi=
d 1 transid 13610 /dev/root scanned by swapper/0 (1)
[    7.929810] BTRFS info (device mmcblk0p1): disk space caching is enabled
[    7.936547] BTRFS info (device mmcblk0p1): has skinny extents
[    7.948767] BTRFS info (device mmcblk0p1): enabling ssd optimizations
[    7.957822] VFS: Mounted root (btrfs filesystem) on device 0:13.
[    7.964279] devtmpfs: mounted
[    7.967862] Freeing unused kernel memory: 1024K
[    8.011610] Run /sbin/init as init process
[    8.015718]   with arguments:
[    8.015722]     /sbin/init
[    8.015725]     earlyprintk
[    8.015728]   with environment:
[    8.015731]     HOME=3D/
[    8.015734]     TERM=3Dlinux
[    8.092110] random: fast init done
[    8.441825] systemd[1]: systemd 247.3-1-arch running in system mode. (+P=
AM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GC=
RYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN=
 +PCRE2 default-hierarchy=3Dhybrid)
[    8.464757] systemd[1]: Detected architecture arm.
[    8.592661] systemd[1]: Set hostname to <omnia-arch>.
[    8.786365] systemd-gpt-auto-generator[173]: File system behind root fil=
e system is reported by btrfs to be backed by pseudo-device /dev/root, whic=
h is not a valid userspace accessible device node. Cannot determine correct=
 backing block device.
[    8.810036] systemd[167]: /usr/lib/systemd/system-generators/systemd-gpt=
-auto-generator failed with exit status 1.
[    9.029889] systemd[1]: Queued start job for default target Graphical In=
terface.
[    9.038220] random: systemd: uninitialized urandom read (16 bytes read)
[    9.065479] systemd[1]: Created slice system-getty.slice.
[    9.101527] random: systemd: uninitialized urandom read (16 bytes read)
[    9.109083] systemd[1]: Created slice system-modprobe.slice.
[    9.141479] random: systemd: uninitialized urandom read (16 bytes read)
[    9.148986] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    9.182292] systemd[1]: Created slice User and Session Slice.
[    9.221625] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    9.261586] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    9.301489] systemd[1]: Condition check resulted in Arbitrary Executable=
 File Formats File System Automount Point being skipped.
[    9.313240] systemd[1]: Reached target Local Encrypted Volumes.
[    9.351600] systemd[1]: Reached target Paths.
[    9.381488] systemd[1]: Reached target Remote File Systems.
[    9.421453] systemd[1]: Reached target Slices.
[    9.451485] systemd[1]: Reached target Swap.
[    9.481688] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    9.532988] systemd[1]: Listening on Process Core Dump Socket.
[    9.575779] systemd[1]: Condition check resulted in Journal Audit Socket=
 being skipped.
[    9.585118] systemd[1]: Listening on Journal Socket (/dev/log).
[    9.621803] systemd[1]: Listening on Journal Socket.
[    9.658182] systemd[1]: Listening on Network Service Netlink Socket.
[    9.692994] systemd[1]: Listening on udev Control Socket.
[    9.731720] systemd[1]: Listening on udev Kernel Socket.
[    9.771747] systemd[1]: Condition check resulted in Huge Pages File Syst=
em being skipped.
[    9.780163] systemd[1]: Condition check resulted in POSIX Message Queue =
File System being skipped.
[    9.791835] systemd[1]: Mounting Kernel Debug File System...
[    9.834096] systemd[1]: Mounting Kernel Trace File System...
[    9.873970] systemd[1]: Mounting Temporary Directory (/tmp)...
[    9.911710] systemd[1]: Condition check resulted in Create list of stati=
c device nodes for the current kernel being skipped.
[    9.925842] systemd[1]: Starting Load Kernel Module configfs...
[    9.964225] systemd[1]: Starting Load Kernel Module drm...
[   10.004524] systemd[1]: Starting Load Kernel Module fuse...
[   10.048219] systemd[1]: Condition check resulted in Set Up Additional Bi=
nary Formats being skipped.
[   10.058755] systemd[1]: Condition check resulted in Load Kernel Modules =
being skipped.
[   10.069469] systemd[1]: Starting Remount Root and Kernel File Systems...
[   10.111602] systemd[1]: Condition check resulted in Repartition Root Dis=
k being skipped.
[   10.122503] systemd[1]: Starting Apply Kernel Variables...
[   10.164228] systemd[1]: Starting Coldplug All udev Devices...
[   10.206094] systemd[1]: Mounted Kernel Debug File System.
[   10.241980] systemd[1]: Mounted Kernel Trace File System.
[   10.281734] systemd[1]: Mounted Temporary Directory (/tmp).
[   10.321996] systemd[1]: modprobe@configfs.service: Succeeded.
[   10.328795] systemd[1]: Finished Load Kernel Module configfs.
[   10.366145] systemd[1]: modprobe@drm.service: Succeeded.
[   10.372733] systemd[1]: Finished Load Kernel Module drm.
[   10.412110] systemd[1]: modprobe@fuse.service: Succeeded.
[   10.418547] systemd[1]: Finished Load Kernel Module fuse.
[   10.452851] systemd[1]: Finished Remount Root and Kernel File Systems.
[   10.492903] systemd[1]: Finished Apply Kernel Variables.
[   10.534693] systemd[1]: Condition check resulted in FUSE Control File Sy=
stem being skipped.
[   10.543506] systemd[1]: Condition check resulted in Kernel Configuration=
 File System being skipped.
[   10.552850] systemd[1]: Condition check resulted in First Boot Wizard be=
ing skipped.
[   10.568407] systemd[1]: Condition check resulted in Rebuild Hardware Dat=
abase being skipped.
[   10.579654] systemd[1]: Starting Load/Save Random Seed...
[   10.601715] systemd[1]: Condition check resulted in Create System Users =
being skipped.
[   10.613507] systemd[1]: Starting Create Static Device Nodes in /dev...
[   10.743498] systemd[1]: Finished Create Static Device Nodes in /dev.
[   10.762086] systemd[1]: Reached target Local File Systems (Pre).
[   10.801636] systemd[1]: Condition check resulted in Virtual Machine and =
Container Storage (Compatibility) being skipped.
[   10.812817] systemd[1]: Reached target Local File Systems.
[   10.854718] systemd[1]: Started Entropy Daemon based on the HAVEGE algor=
ithm.
[   10.891763] systemd[1]: Condition check resulted in Rebuild Dynamic Link=
er Cache being skipped.
[   10.904350] systemd[1]: Starting Journal Service...
[   10.945329] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[   10.993388] systemd[1]: Finished Coldplug All udev Devices.
[   11.039498] systemd[1]: Started Journal Service.
[   11.155201] systemd-journald[193]: Received client request to flush runt=
ime journal.
[   12.440807] mvneta f1034000.ethernet eth2: PHY [f1072004.mdio-mii:01] dr=
iver [Marvell 88E1510] (irq=3DPOLL)
[   12.457437] mvneta f1034000.ethernet eth2: configuring for phy/sgmii lin=
k mode
[   12.536401] mvneta f1070000.ethernet eth0: configuring for fixed/rgmii l=
ink mode
[   12.551575] mvneta f1070000.ethernet eth0: Link is Up - 1Gbps/Full - flo=
w control off
[   12.731311] ath10k_pci 0000:02:00.0 wlp2s0: renamed from wlan1
[   12.893504] BTRFS info (device mmcblk0p1): devid 1 device path /dev/root=
 changed to /dev/mmcblk0p1 scanned by systemd-udevd (202)
[   12.922368] mt76x2e 0000:03:00.0 wlp3s0: renamed from wlan0
[   13.451476] random: crng init done
[   13.454898] random: 7 urandom warning(s) missed due to ratelimiting
[   15.550016] ath10k_pci 0000:02:00.0: pdev param 0 not supported by firmw=
are
[   15.591776] mvneta f1034000.ethernet eth2: Link is Up - 1Gbps/Full - flo=
w control rx/tx
[   15.599825] IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready

>> Could there be some kind of data corruption in play here making the
>> driver think the chip revision is wrong, or something like that? If I
>> boot the same kernel without the patch applied, the ath9k initialisation
>> works fine, but obviously the ath10k is then still broken...
>
> There is something really strange.
>
> Can you add debug log into pcie_change_tls_to_gen1() function to check
> for which card is this function called?

Erm, it looks like it's never called? I added this:

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ea5bdf6107f6..794c682d4bd3 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -198,6 +198,9 @@ static int pcie_change_tls_to_gen1(struct pci_dev *pare=
nt)
        u32 reg32;
        int ret;
=20
+       printk("pcie_change_tls_to_getn1() called for device %x:%x:%x\n",
+              parent->device, parent->subsystem_vendor, parent->subsystem_=
device);
+
        /* Check if link speed can be forced to 2.5 GT/s */
        pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &reg32);
        if (!(reg32 & PCI_EXP_LNKCAP2_SLS_2_5GB)) {

But 'dmesg | grep called' returns nothing...

> Are you testing this new patch with or without changes to
> mvebu_pcie_setup_hw() function?

I applied your patch on top of latest mac80211-next, which right now is
this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/com=
mit/?id=3D4b837ad53be2ab100dfaa99dc73a9443a8a2392d

-Toke

