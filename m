Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01FB34107E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 23:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhCRWoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 18:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232529AbhCRWoH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 18:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616107446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mw9mO9lVjp1B8Xs/tmqGwxKwU51d1MGWX2UCsHafijw=;
        b=K1qp1OfJ+3R7hkgQCHSNne+qZ2PkQVibcXqWOsbpVVAEXTe6Sirrl9oTfnpwh9zP7E2gnf
        Xk3F+k5e6LQL6/6Wxdbb0f0pIxu2jxu7N2jt1/cm6iENM2/X2OiRabITCoWtbmvbmR9hTq
        6IzJs0WL3LO0ZVzMxMePGPXn0wf8UI0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-3KZ6q0PcPe2xqDXFrUfhpA-1; Thu, 18 Mar 2021 18:44:01 -0400
X-MC-Unique: 3KZ6q0PcPe2xqDXFrUfhpA-1
Received: by mail-ed1-f70.google.com with SMTP id i19so22090040edy.18
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 15:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mw9mO9lVjp1B8Xs/tmqGwxKwU51d1MGWX2UCsHafijw=;
        b=K1UsiPDPZGF1Wxs87+JuWf1Uzp/Gg7FA+tbw7W8idur6MFLhDTH7bueC8GZwM0QAVh
         uSVhM6nDTG98MmrlSf7i2t5GbD36Lob6etwEZythT7fX1hampvkSpQn/fsuYjb7HCUt0
         59kmP33nztjglUOTq9W9Rz/P2UDm2ZKGtrlIs++DDVtw26W27eNq85MQ5wTllXZg99F3
         yB10EYkbeXCQ0q3R28Lwats/5TG6nX4HE0E/S1B6Hfc3Ke18lZbMxKgBxm+17b/b121z
         S/pCqPKZCktodWI8HrOL9dYNY9wwpZFFwWVGXRdcKupECqEDTDj9e/kNek1vnJ8hMRLD
         pDtA==
X-Gm-Message-State: AOAM530tV6ZxigjJj0/wO+qzBqrY4+pAzSZuBiea35asVkpOEG/bC2yn
        ms592e5Ljbu+niXD61qT00HUBjYfBWnwSRr8a/EqPpjuMh3Adv8UQmkWkeVuHzdeUnEkTAeLOM3
        rZiSmN+33JqWGwwc48nMk
X-Received: by 2002:a17:906:a157:: with SMTP id bu23mr885239ejb.491.1616107440284;
        Thu, 18 Mar 2021 15:44:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTZ7SkpW7kcYZVyYdmkHGbm3j55l32e+foFEhHYvl2wB3RwCAMkSaYn82fRytMAps47xt0aw==
X-Received: by 2002:a17:906:a157:: with SMTP id bu23mr885218ejb.491.1616107439908;
        Thu, 18 Mar 2021 15:43:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id lu26sm2610519ejb.33.2021.03.18.15.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 15:43:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 67962181F54; Thu, 18 Mar 2021 23:43:58 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     vtolkm@gmail.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20210316092534.czuondwbg3tqjs6w@pali>
References: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
 <20201028231626.GA344207@bjorn-Precision-5520>
 <20201030112331.meqg6lvultyn6v54@pali> <87k0v7n9y9.fsf@toke.dk>
 <20201030142337.yushrdcuecycfhcu@pali>
 <b9683fc3-bb8d-3dac-4a5d-fe7fbf2f0177@gmail.com> <87zh42lfv6.fsf@toke.dk>
 <20201102152403.4jlmcaqkqeivuypm@pali> <877dr3lpok.fsf@toke.dk>
 <20210315195806.iqdt5wvvkvpmnep7@pali>
 <20210316092534.czuondwbg3tqjs6w@pali>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 18 Mar 2021 23:43:58 +0100
Message-ID: <87h7l8axqp.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Monday 15 March 2021 20:58:06 Pali Roh=C3=A1r wrote:
>> On Monday 02 November 2020 16:54:35 Toke H=C3=B8iland-J=C3=B8rgensen wro=
te:
>> > Pali Roh=C3=A1r <pali@kernel.org> writes:
>> >=20
>> > > On Saturday 31 October 2020 13:49:49 Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> > >> "=E2=84=A2=D6=9F=E2=98=BB=D2=87=CC=AD =D1=BC =D2=89 =C2=AE" <vtolkm=
@googlemail.com> writes:
>> > >>=20
>> > >> > On 30/10/2020 15:23, Pali Roh=C3=A1r wrote:
>> > >> >> On Friday 30 October 2020 14:02:22 Toke H=C3=B8iland-J=C3=B8rgen=
sen wrote:
>> > >> >>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>> > >> >>>> My experience with that WLE900VX card, aardvark driver and asp=
m code:
>> > >> >>>>
>> > >> >>>> Link training in GEN2 mode for this card succeed only once aft=
er reset.
>> > >> >>>> Repeated link retraining fails and it fails even when aardvark=
 is
>> > >> >>>> reconfigured to GEN1 mode. Reset via PERST# signal is required=
 to have
>> > >> >>>> working link training.
>> > >> >>>>
>> > >> >>>> What I did in aardvark driver: Set mode to GEN2, do link train=
ing. If
>> > >> >>>> success read "negotiated link speed" from "Link Control Status=
 Register"
>> > >> >>>> (for WLE900VX it is 0x1 - GEN1) and set it into aardvark. And =
then
>> > >> >>>> retrain link again (for WLE900VX now it would be at GEN1). Aft=
er that
>> > >> >>>> card is stable and all future retraining (e.g. from aspm.c) al=
so passes.
>> > >> >>>>
>> > >> >>>> If I do not change aardvark mode from GEN2 to GEN1 the second =
link
>> > >> >>>> training fails. And if I change mode to GEN1 after this failed=
 link
>> > >> >>>> training then nothing happen, link training do not success.
>> > >> >>>>
>> > >> >>>> So just speculation now... In current setup initialization of =
card does
>> > >> >>>> one link training at GEN2. Then aspm.c is called which is doin=
g second
>> > >> >>>> link retraining at GEN2. And if it fails then below patch issu=
e third
>> > >> >>>> link retraining at GEN1. If A38x/pci-mvebu has same problem as=
 aardvark
>> > >> >>>> then second link retraining must be at GEN1 (not GEN2) to work=
around
>> > >> >>>> this issue.
>> > >> >>>>
>> > >> >>>> Bjorn, Toke: what about trying to hack aspm.c code to never do=
 link
>> > >> >>>> retraining at GEN2 speed? And always force GEN1 speed prior li=
nk
>> > >> >>>> training?
>> > >> >>> Sounds like a plan. I poked around in aspm.c and must confess t=
o being a
>> > >> >>> bit lost in the soup of registers ;)
>> > >> >>>
>> > >> >>> So if one of you can cook up a patch, that would be most helpfu=
l!
>> > >> >> I modified Bjorn's patch, explicitly set tls to 1 and added debu=
g info
>> > >> >> about cls (current link speed, that what is used by aardvark). I=
t is
>> > >> >> untested, I just tried to compile it.
>> > >> >>
>> > >> >> Can try it?
>> > >> >>
>> > >> >> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> > >> >> index 253c30cc1967..f934c0b52f41 100644
>> > >> >> --- a/drivers/pci/pcie/aspm.c
>> > >> >> +++ b/drivers/pci/pcie/aspm.c
>> > >> >> @@ -206,6 +206,27 @@ static bool pcie_retrain_link(struct pcie_l=
ink_state *link)
>> > >> >>   	unsigned long end_jiffies;
>> > >> >>   	u16 reg16;
>> > >> >>=20=20=20
>> > >> >> +	u32 lnkcap2;
>> > >> >> +	u16 lnksta, lnkctl2, cls, tls;
>> > >> >> +
>> > >> >> +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &lnkcap2);
>> > >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &lnksta);
>> > >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
>> > >> >> +	cls =3D lnksta & PCI_EXP_LNKSTA_CLS;
>> > >> >> +	tls =3D lnkctl2 & PCI_EXP_LNKCTL2_TLS;
>> > >> >> +
>> > >> >> +	pci_info(parent, "lnkcap2 %#010x sls %#04x lnksta %#06x cls %#=
03x lnkctl2 %#06x tls %#03x\n",
>> > >> >> +		lnkcap2, (lnkcap2 & 0x3F) >> 1,
>> > >> >> +		lnksta, cls,
>> > >> >> +		lnkctl2, tls);
>> > >> >> +
>> > >> >> +	tls =3D 1;
>> > >> >> +	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
>> > >> >> +					PCI_EXP_LNKCTL2_TLS, tls);
>> > >> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
>> > >> >> +	pci_info(parent, "lnkctl2 %#010x new tls %#03x\n",
>> > >> >> +		lnkctl2, tls);
>> > >> >> +
>> > >> >>   	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
>> > >> >>   	reg16 |=3D PCI_EXP_LNKCTL_RL;
>> > >> >>   	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>> > >> >> @@ -227,6 +248,8 @@ static bool pcie_retrain_link(struct pcie_li=
nk_state *link)
>> > >> >>   			break;
>> > >> >>   		msleep(1);
>> > >> >>   	} while (time_before(jiffies, end_jiffies));
>> > >> >> +	pci_info(parent, "lnksta %#06x new cls %#03x\n",
>> > >> >> +		lnksta, (cls & PCI_EXP_LNKSTA_CLS));
>> > >> >>   	return !(reg16 & PCI_EXP_LNKSTA_LT);
>> > >> >>   }
>> > >> >>=20=20=20
>> > >> >
>> > >> > Still exhibiting the BAR update error, run tested with next--2020=
1030
>> > >>=20
>> > >> Yup, same for me :(
>>=20
>> I'm answering my own question. This code does not work on Omnia because
>> A38x pci-mvebu.c driver is using emulator for PCIe root bridge and it
>> does not implement PCI_EXP_LNKCTL2 and PCI_EXP_LNKCTL2 registers. So
>> code for forcing link speed has no effect on Omnia...
>
> Toke, on A38x PCIe controller it is possible to access PCI_EXP_LNKCTL2
> register. Just access is not exported via emulated root bridge.
>
> Documentation for this PCIe controller is public, so anybody can look at
> register description. See page 571, A.7 PCI Express 2.0 Port 0 Registers
>
> http://web.archive.org/web/20200420191927/https://www.marvell.com/content=
/dam/marvell/en/public-collateral/embedded-processors/marvell-embedded-proc=
essors-armada-38x-functional-specifications-2015-11.pdf
>
> In drivers/pci/controller/pci-mvebu.c you can set a new value for this
> register via function call:
>
>     mvebu_writel(port, val, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
>
> So, could you try to set PCI_EXP_LNKCTL2_TLS bits to gen1 in some hw
> init function, e.g. mvebu_pcie_setup_hw()?
>
>     u32 val =3D mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
>     val &=3D ~PCI_EXP_LNKCTL2_TLS;
>     val |=3D PCI_EXP_LNKCTL2_TLS_2_5GT;
>     mvebu_writel(port, val, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);

I pasted this into the top of mvebu_pcie_setup_hw(), and that indeed
seems to fix things so that all three PCIE devices work even with ASPM
turned on! :)

Do you still need me to test the card on a different machine? Not sure I
have an x86 machine with a mini-PCIe slot handy, but I can go hunting if
needed...

-Toke

