Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F82A2EB2
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 16:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgKBPym (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 10:54:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726385AbgKBPyl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 10:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604332480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=baNTDuDx70k7XjIF3i9X3EY75tEmpoVA8KNG+Qv0Vg4=;
        b=MgB3NGJAFYfmWy3x2CcneR5q7SFQ8WxOmwS5Omb2uNGa7fij7pQdxUYiznKeXMZ9b76AK0
        olojxiHHnQuFEi0tXx6Sh2IwMq8ZjaToynQkYqe5rByFh/7uK1YE8moGygMZ7yIsMg9GzN
        1sLCkdpf1pA5l03YpQDZXKL45yU5618=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-Y4gcp0T1OMaoDGhVAqN_lw-1; Mon, 02 Nov 2020 10:54:38 -0500
X-MC-Unique: Y4gcp0T1OMaoDGhVAqN_lw-1
Received: by mail-qt1-f197.google.com with SMTP id h16so8243190qtr.8
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2020 07:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=baNTDuDx70k7XjIF3i9X3EY75tEmpoVA8KNG+Qv0Vg4=;
        b=GDoSA3k3RanEBlQhzB3XJ+P0CpJ/8zpDX/ps7ADI22y5to0VMTJbAxw13LllKdOIY8
         nW/ypV2MJapcNRQF+tXdoijdNLln2nSjo3k5L+/+t++yfh4u9IwKXzTarmxGVa/1GznZ
         VwZ+/M6xHL3iQr12px8nJfHDVccO10dpnl75e1eFCUAiyN8Q4237LPrHbGBu0+oxmMmf
         LGW7Kn0JJTSy7J8idu02A1TwzkFGFOKitJhdiaCT62qlXm7+mbYCcNfPHcACCjRLh2ei
         s+O3MNw5sUzXwM5gwT9FBiJKZnFekQJjx/rW/pLkKujV2nvKukwPbTdtsiMzdghMQkvr
         NTgQ==
X-Gm-Message-State: AOAM531ys5Q+skrGy3juTwgujrMhyISVOL7gKu7Uc2vHgoV/2wcmagMM
        ypVemzcfhwNyPemqoRwJnFtEvy4UJLwv9cochRel9lznL59IUMooavc0Umn2lNvbpVFFkp/lE3h
        nC6AE+oENUIq71fCEJp4t
X-Received: by 2002:ac8:2bf7:: with SMTP id n52mr15507389qtn.164.1604332478244;
        Mon, 02 Nov 2020 07:54:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxizZfH98b/hy3aHOdoxbAxg+L1hI6MhcKTsry/nP4ffxRAZHd2XgxINLO5+o86Bs+PiBCFw==
X-Received: by 2002:ac8:2bf7:: with SMTP id n52mr15507343qtn.164.1604332477722;
        Mon, 02 Nov 2020 07:54:37 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v206sm1487066qkb.114.2020.11.02.07.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 07:54:36 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 17230181CED; Mon,  2 Nov 2020 16:54:35 +0100 (CET)
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
In-Reply-To: <20201102152403.4jlmcaqkqeivuypm@pali>
References: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
 <20201028231626.GA344207@bjorn-Precision-5520>
 <20201030112331.meqg6lvultyn6v54@pali> <87k0v7n9y9.fsf@toke.dk>
 <20201030142337.yushrdcuecycfhcu@pali>
 <b9683fc3-bb8d-3dac-4a5d-fe7fbf2f0177@gmail.com> <87zh42lfv6.fsf@toke.dk>
 <20201102152403.4jlmcaqkqeivuypm@pali>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 02 Nov 2020 16:54:35 +0100
Message-ID: <877dr3lpok.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Saturday 31 October 2020 13:49:49 Toke H=C3=B8iland-J=C3=B8rgensen wro=
te:
>> "=E2=84=A2=D6=9F=E2=98=BB=D2=87=CC=AD =D1=BC =D2=89 =C2=AE" <vtolkm@goog=
lemail.com> writes:
>>=20
>> > On 30/10/2020 15:23, Pali Roh=C3=A1r wrote:
>> >> On Friday 30 October 2020 14:02:22 Toke H=C3=B8iland-J=C3=B8rgensen w=
rote:
>> >>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>> >>>> My experience with that WLE900VX card, aardvark driver and aspm cod=
e:
>> >>>>
>> >>>> Link training in GEN2 mode for this card succeed only once after re=
set.
>> >>>> Repeated link retraining fails and it fails even when aardvark is
>> >>>> reconfigured to GEN1 mode. Reset via PERST# signal is required to h=
ave
>> >>>> working link training.
>> >>>>
>> >>>> What I did in aardvark driver: Set mode to GEN2, do link training. =
If
>> >>>> success read "negotiated link speed" from "Link Control Status Regi=
ster"
>> >>>> (for WLE900VX it is 0x1 - GEN1) and set it into aardvark. And then
>> >>>> retrain link again (for WLE900VX now it would be at GEN1). After th=
at
>> >>>> card is stable and all future retraining (e.g. from aspm.c) also pa=
sses.
>> >>>>
>> >>>> If I do not change aardvark mode from GEN2 to GEN1 the second link
>> >>>> training fails. And if I change mode to GEN1 after this failed link
>> >>>> training then nothing happen, link training do not success.
>> >>>>
>> >>>> So just speculation now... In current setup initialization of card =
does
>> >>>> one link training at GEN2. Then aspm.c is called which is doing sec=
ond
>> >>>> link retraining at GEN2. And if it fails then below patch issue thi=
rd
>> >>>> link retraining at GEN1. If A38x/pci-mvebu has same problem as aard=
vark
>> >>>> then second link retraining must be at GEN1 (not GEN2) to workaround
>> >>>> this issue.
>> >>>>
>> >>>> Bjorn, Toke: what about trying to hack aspm.c code to never do link
>> >>>> retraining at GEN2 speed? And always force GEN1 speed prior link
>> >>>> training?
>> >>> Sounds like a plan. I poked around in aspm.c and must confess to bei=
ng a
>> >>> bit lost in the soup of registers ;)
>> >>>
>> >>> So if one of you can cook up a patch, that would be most helpful!
>> >> I modified Bjorn's patch, explicitly set tls to 1 and added debug info
>> >> about cls (current link speed, that what is used by aardvark). It is
>> >> untested, I just tried to compile it.
>> >>
>> >> Can try it?
>> >>
>> >> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> >> index 253c30cc1967..f934c0b52f41 100644
>> >> --- a/drivers/pci/pcie/aspm.c
>> >> +++ b/drivers/pci/pcie/aspm.c
>> >> @@ -206,6 +206,27 @@ static bool pcie_retrain_link(struct pcie_link_s=
tate *link)
>> >>   	unsigned long end_jiffies;
>> >>   	u16 reg16;
>> >>=20=20=20
>> >> +	u32 lnkcap2;
>> >> +	u16 lnksta, lnkctl2, cls, tls;
>> >> +
>> >> +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &lnkcap2);
>> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &lnksta);
>> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
>> >> +	cls =3D lnksta & PCI_EXP_LNKSTA_CLS;
>> >> +	tls =3D lnkctl2 & PCI_EXP_LNKCTL2_TLS;
>> >> +
>> >> +	pci_info(parent, "lnkcap2 %#010x sls %#04x lnksta %#06x cls %#03x l=
nkctl2 %#06x tls %#03x\n",
>> >> +		lnkcap2, (lnkcap2 & 0x3F) >> 1,
>> >> +		lnksta, cls,
>> >> +		lnkctl2, tls);
>> >> +
>> >> +	tls =3D 1;
>> >> +	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
>> >> +					PCI_EXP_LNKCTL2_TLS, tls);
>> >> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
>> >> +	pci_info(parent, "lnkctl2 %#010x new tls %#03x\n",
>> >> +		lnkctl2, tls);
>> >> +
>> >>   	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
>> >>   	reg16 |=3D PCI_EXP_LNKCTL_RL;
>> >>   	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>> >> @@ -227,6 +248,8 @@ static bool pcie_retrain_link(struct pcie_link_st=
ate *link)
>> >>   			break;
>> >>   		msleep(1);
>> >>   	} while (time_before(jiffies, end_jiffies));
>> >> +	pci_info(parent, "lnksta %#06x new cls %#03x\n",
>> >> +		lnksta, (cls & PCI_EXP_LNKSTA_CLS));
>> >>   	return !(reg16 & PCI_EXP_LNKSTA_LT);
>> >>   }
>> >>=20=20=20
>> >
>> > Still exhibiting the BAR update error, run tested with next--20201030
>>=20
>> Yup, same for me :(
>
> So then it is different issue and not similar to aardvark one.
>
> Anyway, was ASPM working on some previous kernel version? Or was it
> always broken on Turris Omnia?

I tried bisecting and couldn't find a commit that worked. And OpenWrt by
default builds with ASPM off, so my best guess is that it was always
broken.

However, the two other PCI slots *do* work with ASPM on, as long as
they're both occupied when booting. If I only have one card installed
apart from the dodge WLE900, both of them fail...

> And has somebody other Armada 385 device with mPCIe slots to test if
> ASPM is working? Or any other 32bit Marvell Armada SOC?
>
> I would like to know if this is issue only on Turris Omnia or also on
> other Armada 385 SOC device or even on any other device which uses
> pci-mvebu.c driver.

See above: It does partly work on my Omnia. Is it possible to define a
quirk to just disable it on a per-slot basis for the WLE900 card? Maybe
just doing that and calling it a day would be enough...

-Toke

