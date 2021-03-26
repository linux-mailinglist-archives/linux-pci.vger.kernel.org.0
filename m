Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DCF34AB6C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 16:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCZP0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 11:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230006AbhCZPZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 11:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616772336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37VsQPkd1CRxQEzWgbjMXquIk/ZMfXcaeWuLViJebko=;
        b=D/uZUBj0ZsroTRpq293SOerTbdrWDffYqAJ67JIxsy5COyR6uomIa5PMWEpxy6j7/rTNJG
        1qudQaeTZg8kZ9uz/Q6NQSVvkLwTj1IcRSjQ17HALqCz+oONbEaH467QBX6b27qWQ5noKk
        1ELMX9cUV9TuI8ndy1V+M6ASG+kJQoo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-mWn2dXLHOK-4Z1AqEjDXog-1; Fri, 26 Mar 2021 11:25:31 -0400
X-MC-Unique: mWn2dXLHOK-4Z1AqEjDXog-1
Received: by mail-ed1-f72.google.com with SMTP id p6so4572810edq.21
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 08:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=37VsQPkd1CRxQEzWgbjMXquIk/ZMfXcaeWuLViJebko=;
        b=VpyqzH0drzF+RLOLAfwDlI3FyghiRGxwVSlG8Pm3KxN7PtHl+t293yjOzhOFnpe8tf
         AWc0UeW0GMZptcYUrj+69fxe+g+5v33S1PG3f8e3Gv+W7dm5MBG4VNQHf3kbaUQcy8fe
         XbFT2Sgv2YnxnaAH4mDsviYXCJa0T7aJ6CZbKiANpeSu1njYCSKlJbLMQeYlqrfuGNKt
         +9ajaPkfq98JjH0IJv1EXJDfJbwyt4BHt/lyXKCoZ/HApaizGDawSYRVDYO7HtTd8jBI
         qbtk034p1x5sdANWZlOrpT4xcJcb2h8pjIihVoe9C9qgXt4rXZHvdE/0NVmAlLLMr6zR
         zqgQ==
X-Gm-Message-State: AOAM530fxpvVfVjat/x6kh8w2e/NQQhbMqVsrwZG++JcP9Ou/CaJB3JL
        L8i6qPNbpdJ3ez9QZn2juq2QA312yEZm21ts1hOwPshjNabyWhSbc30ZXV66zvts0hxaXXFCrZ5
        kRNAGwhpXJMjJVjpviq0e
X-Received: by 2002:a05:6402:c8:: with SMTP id i8mr15942012edu.57.1616772330261;
        Fri, 26 Mar 2021 08:25:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnaSBLkcRDiOGM09F3pM/JyZ4ts8zUfX4ETFaa8p0imYuyky/XGZDtF86QENJnVw9u1n/TSg==
X-Received: by 2002:a05:6402:c8:: with SMTP id i8mr15941993edu.57.1616772330075;
        Fri, 26 Mar 2021 08:25:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 90sm4654053edr.69.2021.03.26.08.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:25:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DE18D1801A3; Fri, 26 Mar 2021 16:25:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     vtolkm@gmail.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20210326125028.tyqkcc5fvaqbwqkn@pali>
References: <87k0v7n9y9.fsf@toke.dk> <20201030142337.yushrdcuecycfhcu@pali>
 <b9683fc3-bb8d-3dac-4a5d-fe7fbf2f0177@gmail.com> <87zh42lfv6.fsf@toke.dk>
 <20201102152403.4jlmcaqkqeivuypm@pali> <877dr3lpok.fsf@toke.dk>
 <20210315195806.iqdt5wvvkvpmnep7@pali>
 <20210316092534.czuondwbg3tqjs6w@pali> <87h7l8axqp.fsf@toke.dk>
 <20210318231629.vhix2cqpt25bgrne@pali>
 <20210326125028.tyqkcc5fvaqbwqkn@pali>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Mar 2021 16:25:27 +0100
Message-ID: <874kgyc4yg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Friday 19 March 2021 00:16:29 Pali Roh=C3=A1r wrote:
>> On Thursday 18 March 2021 23:43:58 Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>> > Pali Roh=C3=A1r <pali@kernel.org> writes:
>> >=20
>> > > On Monday 15 March 2021 20:58:06 Pali Roh=C3=A1r wrote:
>> > >> On Monday 02 November 2020 16:54:35 Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> > >> > Pali Roh=C3=A1r <pali@kernel.org> writes:
>> > >> >=20
>> > >> > > On Saturday 31 October 2020 13:49:49 Toke H=C3=B8iland-J=C3=B8r=
gensen wrote:
>> > >> > >> "=E2=84=A2=D6=9F=E2=98=BB=D2=87=CC=AD =D1=BC =D2=89 =C2=AE" <v=
tolkm@googlemail.com> writes:
>> > >> > >>=20
>> > >> > >> > On 30/10/2020 15:23, Pali Roh=C3=A1r wrote:
>> > >> > >> >> On Friday 30 October 2020 14:02:22 Toke H=C3=B8iland-J=C3=
=B8rgensen wrote:
>> > >> > >> >>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>> > >> > >> >>>> My experience with that WLE900VX card, aardvark driver an=
d aspm code:
>> > >> > >> >>>>
>> > >> > >> >>>> Link training in GEN2 mode for this card succeed only onc=
e after reset.
>> > >> > >> >>>> Repeated link retraining fails and it fails even when aar=
dvark is
>> > >> > >> >>>> reconfigured to GEN1 mode. Reset via PERST# signal is req=
uired to have
>> > >> > >> >>>> working link training.
>> > >> > >> >>>>
>> > >> > >> >>>> What I did in aardvark driver: Set mode to GEN2, do link =
training. If
>> > >> > >> >>>> success read "negotiated link speed" from "Link Control S=
tatus Register"
>> > >> > >> >>>> (for WLE900VX it is 0x1 - GEN1) and set it into aardvark.=
 And then
>> > >> > >> >>>> retrain link again (for WLE900VX now it would be at GEN1)=
. After that
>> > >> > >> >>>> card is stable and all future retraining (e.g. from aspm.=
c) also passes.
>> > >> > >> >>>>
>> > >> > >> >>>> If I do not change aardvark mode from GEN2 to GEN1 the se=
cond link
>> > >> > >> >>>> training fails. And if I change mode to GEN1 after this f=
ailed link
>> > >> > >> >>>> training then nothing happen, link training do not succes=
s.
>> > >> > >> >>>>
>> > >> > >> >>>> So just speculation now... In current setup initializatio=
n of card does
>> > >> > >> >>>> one link training at GEN2. Then aspm.c is called which is=
 doing second
>> > >> > >> >>>> link retraining at GEN2. And if it fails then below patch=
 issue third
>> > >> > >> >>>> link retraining at GEN1. If A38x/pci-mvebu has same probl=
em as aardvark
>> > >> > >> >>>> then second link retraining must be at GEN1 (not GEN2) to=
 workaround
>> > >> > >> >>>> this issue.
>> > >> > >> >>>>
>> > >> > >> >>>> Bjorn, Toke: what about trying to hack aspm.c code to nev=
er do link
>> > >> > >> >>>> retraining at GEN2 speed? And always force GEN1 speed pri=
or link
>> > >> > >> >>>> training?
>> > >> > >> >>> Sounds like a plan. I poked around in aspm.c and must conf=
ess to being a
>> > >> > >> >>> bit lost in the soup of registers ;)
>> > >> > >> >>>
>> > >> > >> >>> So if one of you can cook up a patch, that would be most h=
elpful!
>> > >> > >> >> I modified Bjorn's patch, explicitly set tls to 1 and added=
 debug info
>> > >> > >> >> about cls (current link speed, that what is used by aardvar=
k). It is
>> > >> > >> >> untested, I just tried to compile it.
>> > >> > >> >>
>> > >> > >> >> Can try it?
>> > >> > >> >>
>> > >> > >> >> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/asp=
m.c
>> > >> > >> >> index 253c30cc1967..f934c0b52f41 100644
>> > >> > >> >> --- a/drivers/pci/pcie/aspm.c
>> > >> > >> >> +++ b/drivers/pci/pcie/aspm.c
>> > >> > >> >> @@ -206,6 +206,27 @@ static bool pcie_retrain_link(struct p=
cie_link_state *link)
>> > >> > >> >>   	unsigned long end_jiffies;
>> > >> > >> >>   	u16 reg16;
>> > >> > >> >>=20=20=20
>> > >> > >> >> +	u32 lnkcap2;
>> > >> > >> >> +	u16 lnksta, lnkctl2, cls, tls;
>> > >> > >> >> +
>> > >> > >> >> +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &lnkc=
ap2);
>> > >> > >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &lnksta=
);
>> > >> > >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkct=
l2);
>> > >> > >> >> +	cls =3D lnksta & PCI_EXP_LNKSTA_CLS;
>> > >> > >> >> +	tls =3D lnkctl2 & PCI_EXP_LNKCTL2_TLS;
>> > >> > >> >> +
>> > >> > >> >> +	pci_info(parent, "lnkcap2 %#010x sls %#04x lnksta %#06x c=
ls %#03x lnkctl2 %#06x tls %#03x\n",
>> > >> > >> >> +		lnkcap2, (lnkcap2 & 0x3F) >> 1,
>> > >> > >> >> +		lnksta, cls,
>> > >> > >> >> +		lnkctl2, tls);
>> > >> > >> >> +
>> > >> > >> >> +	tls =3D 1;
>> > >> > >> >> +	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL=
2,
>> > >> > >> >> +					PCI_EXP_LNKCTL2_TLS, tls);
>> > >> > >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkct=
l2);
>> > >> > >> >> +	pci_info(parent, "lnkctl2 %#010x new tls %#03x\n",
>> > >> > >> >> +		lnkctl2, tls);
>> > >> > >> >> +
>> > >> > >> >>   	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16=
);
>> > >> > >> >>   	reg16 |=3D PCI_EXP_LNKCTL_RL;
>> > >> > >> >>   	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16=
);
>> > >> > >> >> @@ -227,6 +248,8 @@ static bool pcie_retrain_link(struct pc=
ie_link_state *link)
>> > >> > >> >>   			break;
>> > >> > >> >>   		msleep(1);
>> > >> > >> >>   	} while (time_before(jiffies, end_jiffies));
>> > >> > >> >> +	pci_info(parent, "lnksta %#06x new cls %#03x\n",
>> > >> > >> >> +		lnksta, (cls & PCI_EXP_LNKSTA_CLS));
>> > >> > >> >>   	return !(reg16 & PCI_EXP_LNKSTA_LT);
>> > >> > >> >>   }
>> > >> > >> >>=20=20=20
>> > >> > >> >
>> > >> > >> > Still exhibiting the BAR update error, run tested with next-=
-20201030
>> > >> > >>=20
>> > >> > >> Yup, same for me :(
>> > >>=20
>> > >> I'm answering my own question. This code does not work on Omnia bec=
ause
>> > >> A38x pci-mvebu.c driver is using emulator for PCIe root bridge and =
it
>> > >> does not implement PCI_EXP_LNKCTL2 and PCI_EXP_LNKCTL2 registers. So
>> > >> code for forcing link speed has no effect on Omnia...
>> > >
>> > > Toke, on A38x PCIe controller it is possible to access PCI_EXP_LNKCT=
L2
>> > > register. Just access is not exported via emulated root bridge.
>> > >
>> > > Documentation for this PCIe controller is public, so anybody can loo=
k at
>> > > register description. See page 571, A.7 PCI Express 2.0 Port 0 Regis=
ters
>> > >
>> > > http://web.archive.org/web/20200420191927/https://www.marvell.com/co=
ntent/dam/marvell/en/public-collateral/embedded-processors/marvell-embedded=
-processors-armada-38x-functional-specifications-2015-11.pdf
>> > >
>> > > In drivers/pci/controller/pci-mvebu.c you can set a new value for th=
is
>> > > register via function call:
>> > >
>> > >     mvebu_writel(port, val, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
>> > >
>> > > So, could you try to set PCI_EXP_LNKCTL2_TLS bits to gen1 in some hw
>> > > init function, e.g. mvebu_pcie_setup_hw()?
>> > >
>> > >     u32 val =3D mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
>> > >     val &=3D ~PCI_EXP_LNKCTL2_TLS;
>> > >     val |=3D PCI_EXP_LNKCTL2_TLS_2_5GT;
>> > >     mvebu_writel(port, val, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
>> >=20
>> > I pasted this into the top of mvebu_pcie_setup_hw(), and that indeed
>> > seems to fix things so that all three PCIE devices work even with ASPM
>> > turned on! :)
>>=20
>> Perfect! Now I'm sure that it is same issue as in aardvark driver.
>>=20
>> I will prepare patches for both pci-aardvark.c and pci-mvebu.c to export
>> PCI_EXP_LNKCTL2 register via emulated bridge. And so aspm.c code would
>> be able to use Bjorn or my patch which I have sent last year.
>>=20
>> Question reminds, if this is issue with QCA wifi chip on that Compex
>> card or it is issue with PCIe controllers, now on A38x and A3720 SoC.
>> Note that both A38x and A3720 platforms are from Marvell, but they have
>> different PCIe controllers (so it does not mean that both must have same
>> hw bugs).
>
> Seems that this is really issue in QCA98xx chips. I have send patch
> which adds quirk for these wifi chips:
>
> https://lore.kernel.org/linux-pci/20210326124326.21163-1-pali@kernel.org/

I tried applying that, and while it does fix the ath10k card, it seems
to break the ath9k card in the slot next to it. When booting with the
patch applied, I get this in dmesg:

[    3.556599] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by this d=
river

Could there be some kind of data corruption in play here making the
driver think the chip revision is wrong, or something like that? If I
boot the same kernel without the patch applied, the ath9k initialisation
works fine, but obviously the ath10k is then still broken...

-Toke

