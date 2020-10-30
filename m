Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660F42A061C
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 14:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgJ3NCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 09:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbgJ3NCc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2020 09:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604062949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a35osqcmt16DlkbdzUp+yTNCp5vAOujazLMaPfmO2RU=;
        b=RoVoT3nHMwObt9mEqw9xXm2KluY7gbcrgGsEBRcZH3VUejIcg8beEcCdkZr+dsoKe8eu4d
        pPmMNticW+YvYLG1pzABlWHCZOl51tdZFejD0sQOwDOZ3CPpkV94f3I4bcaPR2egDDF58E
        OR9F1/lPquKNDqT/iTPawrm6i8raS54=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-22Bvnod8PQmGbZE0y2ZnfA-1; Fri, 30 Oct 2020 09:02:27 -0400
X-MC-Unique: 22Bvnod8PQmGbZE0y2ZnfA-1
Received: by mail-qv1-f71.google.com with SMTP id s8so3651476qvv.18
        for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2020 06:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=a35osqcmt16DlkbdzUp+yTNCp5vAOujazLMaPfmO2RU=;
        b=Hxol92vBwzpYrVqlG6kWk3ad1t+5wad3gUQvYSby9fnjaVHYlIMjbMY0bzTfgoBbFP
         Get7XS10xncpY+FdTuZcmq5dzMnyOLfdKlGiHWPQgjxw07NALAac8Qz96z1jaA7y0Kcm
         iYjLcl+VAYfID00vyDxxI7YnLUVHpjP03os0HW6t9RYd/sR9kf5X2NcOfS2ADyAnIp6O
         aIxg/cpU5cPW68przSaNeSusLSFR7dNvSyG7e+HRG5jce6yDVtmsmDOk0O9nNj/bD8LP
         tcT+NR0HJ+mtzPdytUrdoYXwDNYNsYouo1sHyF6gxLmLyvLlrBBcKJgzr1NsMFLomRbZ
         BDew==
X-Gm-Message-State: AOAM533rFlBhTHqE6AIlvL4M47KKacBL/uGOcyFxaQJBNuQqdYjn9htt
        QE6Pj+ErPCD6fjOqGrmccpt2I13rDuSm0AlTkgaDvx9JYg3nKVldLm0sbThMJaxD/SW77IXNPkU
        i1JyvJPS8kjpTlN1nvOw3
X-Received: by 2002:ac8:67d9:: with SMTP id r25mr1922772qtp.21.1604062946562;
        Fri, 30 Oct 2020 06:02:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjFuj8EeWUTb2eFPQYPiLRR/1y98F5g3eC4tiN6OWB1ze2rkMBzyygDyBBc8LFR3x/W7yc6A==
X-Received: by 2002:ac8:67d9:: with SMTP id r25mr1922729qtp.21.1604062946147;
        Fri, 30 Oct 2020 06:02:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h4sm2500985qkl.82.2020.10.30.06.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 06:02:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C5658181AD1; Fri, 30 Oct 2020 14:02:22 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     vtolkm@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20201030112331.meqg6lvultyn6v54@pali>
References: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
 <20201028231626.GA344207@bjorn-Precision-5520>
 <20201030112331.meqg6lvultyn6v54@pali>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 30 Oct 2020 14:02:22 +0100
Message-ID: <87k0v7n9y9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Wednesday 28 October 2020 18:16:26 Bjorn Helgaas wrote:
>> [+cc Pali, Marek, Thomas, Jason]
>>=20
>> On Wed, Oct 28, 2020 at 04:40:00PM +0000, =E2=84=A2=D6=9F=E2=98=BB=D2=87=
=CC=AD =D1=BC =D2=89 =C2=AE wrote:
>> > On 28/10/2020 16:08, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > > Bjorn Helgaas <helgaas@kernel.org> writes:
>> > > > On Wed, Oct 28, 2020 at 02:36:13PM +0100, Toke H=C3=B8iland-J=C3=
=B8rgensen wrote:
>> > > > > Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>> > > > > > Bjorn Helgaas <helgaas@kernel.org> writes:
>> > > > > >=20
>> > > > > > > [+cc vtolkm]
>> > > > > > >=20
>> > > > > > > On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke H=C3=B8iland-=
J=C3=B8rgensen wrote:
>> > > > > > > > Hi everyone
>> > > > > > > >=20
>> > > > > > > > I'm trying to get a mainline kernel to run on my Turris Om=
nia, and am
>> > > > > > > > having some trouble getting the PCI bus to work correctly.=
 Specifically,
>> > > > > > > > I'm running a 5.10-rc1 kernel (torvalds/master as of this =
moment), with
>> > > > > > > > the resource request fix[0] applied on top.
>> > > > > > > >=20
>> > > > > > > > The kernel boots fine, and the patch in [0] makes the PCI =
devices show
>> > > > > > > > up. But I'm still getting initialisation errors like these:
>> > > > > > > >=20
>> > > > > > > > [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0x=
e0000004 !=3D 0xffffffff)
>> > > > > > > > [    1.632714] pci 0000:01:00.0: BAR 0: error updating (hi=
gh 0x000000 !=3D 0xffffffff)
>> > > > > > > > [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0x=
e0200004 !=3D 0xffffffff)
>> > > > > > > > [    1.632750] pci 0000:02:00.0: BAR 0: error updating (hi=
gh 0x000000 !=3D 0xffffffff)
>> > > > > > > >=20
>> > > > > > > > and the WiFi drivers fail to initialise with what appears =
to me to be
>> > > > > > > > errors related to the bus rather than to the drivers thems=
elves:
>> > > > > > > >=20
>> > > > > > > > [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not su=
pported by this driver
>> > > > > > > > [    3.517049] ath: phy0: Unable to initialize hardware; i=
nitialization status: -95
>> > > > > > > > [    3.524473] ath9k 0000:01:00.0: Failed to initialize de=
vice
>> > > > > > > > [    3.530081] ath9k: probe of 0000:01:00.0 failed with er=
ror -95
>> > > > > > > > [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: =
failed with rc=3D134
>> > > > > > > > [    3.543049] pci 0000:00:02.0: enabling device (0140 -> =
0142)
>> > > > > > > > [    3.548735] ath10k_pci 0000:02:00.0: can't change power=
 state from D3hot to D0 (config space inaccessible)
>> > > > > > > > [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up =
device : -110
>> > > > > > > > [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed wi=
th error -110
>> > > > > > > >=20
>> > > > > > > > lspci looks OK, though:
>> > > > > > > >=20
>> > > > > > > > # lspci
>> > > > > > > > 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6=
820 (rev 04)
>> > > > > > > > 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6=
820 (rev 04)
>> > > > > > > > 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6=
820 (rev 04)
>> > > > > > > > 01:00.0 Network controller: Qualcomm Atheros AR9287 Wirele=
ss Network Adapter (PCI-Express) (rev 01)
>> > > > > > > > 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x =
802.11ac Wireless Network Adapter (rev ff)
>> > > > > > > >=20
>> > > > > > > > Does anyone have any clue what could be going on here? Is =
this a bug, or
>> > > > > > > > did I miss something in my config or other initialisation?=
 I've tried
>> > > > > > > > with both the stock u-boot distributed with the board, and=
 with an
>> > > > > > > > upstream u-boot from latest master; doesn't seem to make a=
ny different.
>> > > > > > > Can you try turning off CONFIG_PCIEASPM?  We had a similar r=
ecent
>> > > > > > > report at https://bugzilla.kernel.org/show_bug.cgi?id=3D2098=
33 but I
>> > > > > > > don't think we have a fix yet.
>> > > > > > Yes! Turning that off does indeed help! Thanks a bunch :)
>> > > > > >=20
>> > > > > > You mention that bisecting this would be helpful - I can try t=
hat
>> > > > > > tomorrow; any idea when this was last working?
>> > > > > OK, so I tried to bisect this, but, erm, I couldn't find a worki=
ng
>> > > > > revision to start from? I went all the way back to 4.10 (which i=
s the
>> > > > > first version to include the device tree file for the Omnia), an=
d even
>> > > > > on that, the wireless cards were failing to initialise with ASPM
>> > > > > enabled...
>> > > > I have no personal experience with this device; all I know is that=
 the
>> > > > bugzilla suggests that it worked in v5.4, which isn't much help.
>> > > >=20
>> > > > Possibly the apparent regression was really a .config change, i.e.,
>> > > > CONFIG_PCIEASPM was disabled in the v5.4 kernel vtolkm@ tested and=
 it
>> > > > "worked" but got enabled later and it started failing?
>> > > Yeah, I suspect so. The OpenWrt config disables CONFIG_PCIEASPM by
>> > > default and only turns it on for specific targets. So I guess that i=
t's
>> > > most likely that this has never worked...
>> > >=20
>> > > > Maybe the debug patch below would be worth trying to see if it mak=
es
>> > > > any difference?  If it *does* help, try omitting the first hunk to=
 see
>> > > > if we just need to apply the quirk_enable_clear_retrain_link() qui=
rk.
>> > > Tried, doesn't help...
>> > >=20
>> > > -Toke
>> >=20
>> > Found this patch
>> >=20
>> > https://github.com/openwrt/openwrt/blob/7c0496f29bed87326f1bf591ca25ac=
e82373cfc7/target/linux/mvebu/patches-5.4/405-PCI-aardvark-Improve-link-tra=
ining.patch
>> >=20
>> > that mentions the Compex WLE900VX card, which reading the lspci verbose
>> > output from the bugtracker seems to the device being troubled.
>>=20
>> Interesting.  Indeed, the Compex WLE900VX card seems to have the
>> Qualcomm Atheros QCA9880 on it, and it looks like Toke's system has
>> the same device in it.
>>=20
>> The patch you mention (https://git.kernel.org/linus/43fc679ced18) is
>> for aardvark, so of course doesn't help mvebu.
>>=20
>> PCIe hardware is supposed to automatically negotiate the highest link
>> speed supported by both ends.  But software *is* allowed to set an
>> upper limit (the Target Link Speed in Link Control 2).  If we initiate
>> a retrain and the link doesn't come back up, I wonder if we should try
>> to help the hardware out by using Target Link Speed to limit to a
>> lower speed and attempting another retrain, something like this hacky
>> patch: (please collect the dmesg log if you try this)
>
> My experience with that WLE900VX card, aardvark driver and aspm code:
>
> Link training in GEN2 mode for this card succeed only once after reset.
> Repeated link retraining fails and it fails even when aardvark is
> reconfigured to GEN1 mode. Reset via PERST# signal is required to have
> working link training.
>
> What I did in aardvark driver: Set mode to GEN2, do link training. If
> success read "negotiated link speed" from "Link Control Status Register"
> (for WLE900VX it is 0x1 - GEN1) and set it into aardvark. And then
> retrain link again (for WLE900VX now it would be at GEN1). After that
> card is stable and all future retraining (e.g. from aspm.c) also passes.
>
> If I do not change aardvark mode from GEN2 to GEN1 the second link
> training fails. And if I change mode to GEN1 after this failed link
> training then nothing happen, link training do not success.
>
> So just speculation now... In current setup initialization of card does
> one link training at GEN2. Then aspm.c is called which is doing second
> link retraining at GEN2. And if it fails then below patch issue third
> link retraining at GEN1. If A38x/pci-mvebu has same problem as aardvark
> then second link retraining must be at GEN1 (not GEN2) to workaround
> this issue.
>
> Bjorn, Toke: what about trying to hack aspm.c code to never do link
> retraining at GEN2 speed? And always force GEN1 speed prior link
> training?

Sounds like a plan. I poked around in aspm.c and must confess to being a
bit lost in the soup of registers ;)

So if one of you can cook up a patch, that would be most helpful!

-Toke

