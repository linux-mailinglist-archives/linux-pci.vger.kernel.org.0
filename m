Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF961EA1B6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 12:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgFAKUZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 06:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgFAKUQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 06:20:16 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFB1C061A0E
        for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2020 03:20:15 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id m23so2282705vko.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2020 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lMjdaOMl5FMJKVoftarptfTaca79+HcA+5NQl+Y+ztk=;
        b=CsjFOV69l903wXmbCoC2swYA1hA0jQQHDkl4FagwOP5P2fAYdfTB8HtXnTgTu3Pl9f
         cyAZohs6eG/eclCSJWQ0gcLbCzaouh05N5+XolimWKj/Zo4mM0z7OHNH0hk66O5PbfPN
         k3CR0cdmX7DORTxZXVwSbO3U8N5dz9buzddzxyML5rgbKA9xM3Voq/WuRsnqjYYFL8Nb
         2f7viNjKd114QDnBPpriB/h9rRM2FabInPry9PITQmmZB5XzRQq/mDNR6nsKMquYD9b4
         4GmdiRAtdL0G6wBdwdhaHiuBrqkGXE83O5eaXUBwxYYSdx1RqwyiTwFwquAviEZusY0k
         bddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lMjdaOMl5FMJKVoftarptfTaca79+HcA+5NQl+Y+ztk=;
        b=deiTm1bw9NsMCVJ97f/hCMUo13mob2bRtPLDOZR6M7vSKBqoZp1e6OidTwuS4jeh00
         tYnABhDkqxeoeWlBi87F2MMkIGwNkH+Z21ejYNk6sqZf6OCGVPkOLDZJzY0kCHoDdqgq
         L40od+C6dOzLzghOVJl4lcL7sG06S6JfHuC0iE5J4CRYbEgmB5KAlvfxKNUR6CXnDz42
         OlCztpdqMC9gA0eDn/SKIikYREZfNsJ5rxiXC40adPwcWmDLxkAxKGiEcL6WgNCfgoA9
         COeCFxHMSgPkvP67+TSAcOdBq3TmQ4gx1nKNRcDnHb8R5yPnofXDoAyTN2zd5KowpooK
         A9/g==
X-Gm-Message-State: AOAM533b1NeS5nTgUXCvghSWFlFFtpNuWEt42m1Nh+vEiowDMTVqhoCT
        o4HXhKY4rtNbZmRweUU85u/zrNS651cvALc2b7RI1g==
X-Google-Smtp-Source: ABdhPJwxct0EL+zyXIst18Ap13874Y1qKvpZtYDdhR3TYN0TPYgWNOu365nkguxU9Mma/sIENZMx04JlwMz401oTbH8=
X-Received: by 2002:a1f:1188:: with SMTP id 130mr13394447vkr.25.1591006814528;
 Mon, 01 Jun 2020 03:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <1587864346-3144-1-git-send-email-rui_feng@realsil.com.cn>
 <20200427061426.GA11270@infradead.org> <2A308283684ECD4B896628E09AF5361E028BCA26@RS-MBS01.realsil.com.cn>
 <CAK8P3a0EY=FOu5j5DG1BzMEoy_6nEy129kniWCjMYDEdO1o_Jw@mail.gmail.com>
 <2A308283684ECD4B896628E09AF5361E028BCB4B@RS-MBS01.realsil.com.cn>
 <CAPDyKFqWAzzHDtCwaUUBVvzxX0cf46V-6RZrZ-jvnxpptNKppA@mail.gmail.com>
 <2A308283684ECD4B896628E09AF5361E59ACDB91@RS-MBS01.realsil.com.cn>
 <CAPDyKFo9X9ghjCeF_kGE2BhB+3QiMAMbD1Qz53saXshxy9odVg@mail.gmail.com> <2A308283684ECD4B896628E09AF5361E59AD1194@RS-MBS01.realsil.com.cn>
In-Reply-To: <2A308283684ECD4B896628E09AF5361E59AD1194@RS-MBS01.realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Jun 2020 12:19:38 +0200
Message-ID: <CAPDyKFp0Ahcx=iJSGeG19ekDa4rykvAnDHrn4PF5pOoONuH0RA@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: Add SD Express mode support for RTS5261
To:     =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+linux-mmc

On Mon, 1 Jun 2020 at 09:34, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.cn> w=
rote:
>
> >
> > On Tue, 19 May 2020 at 11:18, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.=
cn> wrote:
> > >
> > > > On Tue, 28 Apr 2020 at 05:44, =E5=86=AF=E9=94=90 <rui_feng@realsil.=
com.cn> wrote:
> > > > >
> > > > > >
> > > > > > On Mon, Apr 27, 2020 at 11:41 AM =E5=86=AF=E9=94=90 <rui_feng@r=
ealsil.com.cn>
> > > > wrote:
> > > > > > >
> > > > > > >
> > > > > > > > On Sun, Apr 26, 2020 at 09:25:46AM +0800,
> > > > > > > > rui_feng@realsil.com.cn
> > > > > > wrote:
> > > > > > > > > From: Rui Feng <rui_feng@realsil.com.cn>
> > > > > > > > >
> > > > > > > > > RTS5261 support legacy SD mode and SD Express mode.
> > > > > > > > > In SD7.x, SD association introduce SD Express as a new mo=
de.
> > > > > > > > > SD Express mode is distinguished by CMD8.
> > > > > > > > > Therefore, CMD8 has new bit for SD Express.
> > > > > > > > > SD Express is based on PCIe/NVMe.
> > > > > > > > > RTS5261 uses CMD8 to switch to SD Express mode.
> > > > > > > >
> > > > > > > > So how does this bit work?  They way I imagined SD Express
> > > > > > > > to work is that the actual SD Card just shows up as a real
> > > > > > > > PCIe device, similar to say Thunderbolt.
> > > > > > >
> > > > > > > New SD Express card has dual mode. One is SD mode and another
> > > > > > > is PCIe
> > > > > > mode.
> > > > > > > In PCIe mode, it act as a PCIe device and use PCIe protocol
> > > > > > > not Thunderbolt
> > > > > > protocol.
> > > > > >
> > > > > > I think what Christoph was asking about is why you need to issu=
e
> > > > > > any commands at all in SD mode when you want to use PCIe mode
> > instead.
> > > > > > What happens if you load the NVMe dthriver before loading the
> > > > > > rts5261
> > > > driver?
> > > > > >
> > > > > >        Arnd
> > > > > >
> > > > > > ------Please consider the environment before printing this e-ma=
il.
> > > > >
> > > > > RTS5261 support SD mode and PCIe/NVMe mode. The workflow is as
> > follows.
> > > > > 1.RTS5261 work in SD mode.
> > > > > 2.If card is plugged in, Host send CMD8 to ask card's PCIe availa=
bility.
> > > >
> > > > This sounds like the card insert/removal needs to be managed by the
> > > > rtsx_pci_sdmmc driver (mmc).
> > > >
> > > > > 3.If the card has PCIe availability, RTS5261 switch to PCIe/NVMe =
mode.
> > > >
> > > > This switch is done by the mmc driver, but how does the PCIe/NVMe
> > > > driver know when to take over? Isn't there a synchronization point =
needed?
> > > >
> > > > > 4.Mmc driver exit and NVMe driver start working.
> > > >
> > > > Having the mmc driver to exit seems wrong to me. Else how would you
> > > > handle a card being removed and inserted again?
> > > >
> > > > In principle you want the mmc core to fail to detect the card and
> > > > then do a handover, somehow. No?
> > > >
> > > > Although, to make this work there are a couple of problems you need
> > > > to deal with.
> > > >
> > > > 1. If the mmc core doesn't successfully detect a card, it will
> > > > request the mmc host to power off the card. In this situation, you
> > > > want to keep the power to the card, but leave it to be managed by t=
he
> > PCIe/NVMe driver in some way.
> > > >
> > > > 2. During system resume, the mmc core may try to restore power for =
a
> > > > card, especially if it's a removable slot, as to make sure it gets
> > > > detected if someone inserted a card while the system was suspended.
> > > > Not sure if this plays well with the PCIe/NVMe driver's behaviour.
> > > > Again, I think some kind of synchronization is needed.
> > > >
> > > > > 5.If card is unplugged, RTS5261 will switch to SD mode.
> > > >
> > > > Alright, clearly the mmc driver is needed to manage card insert/rem=
oval.
> > > >
> > > > > We should send CMD8 in SD mode to ask card's PCIe availability,
> > > > > and the
> > > > order of NVMe driver and rts5261 driver doesn't matter.
> > > >
> > > > That assumes there's another synchronization mechanism. Maybe there
> > > > is, but I don't understand how.
> > > >
> > > If no card in RTS5261, RTS5261 works in SD mode. If you run command l=
spci,
> > you can see the RTS5261 device.
> >
> > Right.
> >
> > The rtsx_pci_driver (drivers/misc/cardreader/rtsx_pcr.c) has registered=
 itself
> > as a pci driver and been probed successfully, I assume. Then during
> > rtsx_pci_probe() an mfd device is added via mfd_add_devices(), which
> > corresponds to the rtsx_pci_sdmmc
> > (drivers/mmc/host/rtsx_pci_sdmmc.c) platform driver.
> >
> > > When insert a SD Express card, Mmc driver will send CMD8 to ask the
> > > card's PCIe availability, because it's a SD EXPRESS card,
> >
> > Okay, so this will then be a part of the rtsx_pci_sdmmc driver's probe =
sequence.
> > Or more exactly, when rtsx_pci_sdmmc_drv_probe() completes successfully=
, a
> > mmc rescan work becomes scheduled to try to detect an SD/MMC card. Then
> > the CMD8 command is sent...
> >
> > > RTS5261 will switch to NVMe mode, after switch if you run lspci, you =
can see
> > RTS5261 disappeared and a NVMe device replaces RTS5261.
> >
> > Can you elaborate more exactly how this managed?
> >
> > It kind of sounds like the original PCI device is being deleted? How is=
 this
> > managed?
> >
> > In any case, the rtsx_pci_driver's ->remove() callback, rtsx_pci_remove=
(),
> > should be invoked, I assume?
> >
> > That would then lead to that mfd_remove_devices() gets called, which ma=
kes
> > the ->remove() callback of the rtsx_pci_sdmmc driver,
> > rtsx_pci_sdmmc_drv_remove(), to be invoked. Correct?
> >
> Yes, after RTS5261 switch to NVMe mode, rtsx_pci_remove() and rtsx_pci_sd=
mmc_drv_remove() will be invoked.

So, the ->remove() callbacks are invoked because the PCI device that
corresponds to the rtsx_pci_driver is being deleted. Can you explain
who deletes the PCI device and why?

I am not a PCI expert, so apologize for my ignorance - but I really
want to understand how this is supposed to work.

>
> > > In NVMe mode, RTS5261 only provide a bridge between SD Express card a=
nd
> > PCIe. For NVMe driver, just like a new NVMe device is inserted.
> >
> > I don't understand what that means, but I am also not an expert on PCI/=
NVMe.
> > Care to explain more?
> >
> In NVMe mode, SD Express card connect the computer via PCIe.
> IN SD mode, card connect computer via reader.

That didn't make better sense to me, sorry. I do know about the SD
spec and the SD-express card protocol parts. Anyway, let's leave this
for now.

>
> > > Mmc core doesn't successfully detect the card and handover to NVMe
> > > driver. Because of detect the card failed,
> >
> > How do you make sure that the rtsx_pci_sdmmc driver is leaving the card=
 in the
> > correct state for NVMe?
> >
> > For example, the mmc core has a loop re-trying with a lower initializat=
ion
> > frequency for the card (400KHz, 300KHz, 200KHz, 100KHz). This will caus=
e
> > additional requests to the rtsx_pci_sdmmc driver.
> >
> > > Mmc driver will request the RTS5261 to power off the card, but at tha=
t time
> > power off the card will not succeed.
> >
> > Yes, assuming no card was found, the mmc core calls mmc_power_off().
> > Ths leads to the rtsx_pci_sdmmc driver's ->set_ios() callback being inv=
oked,
> > requesting the card to be powered off. I don't see how you are managing=
 this,
> > what am I missing?
> >
> Before power off card and re-trying initialization, rtsx driver sets RTS5=
261 0xFF55 bit4=3D0.
> After set 0xFF55 bit4=3D0, RTS5261 can't receive any CMD from PCIe and pr=
epare for device disappear.
> Therefore, MMC driver can't change card status.

Okay, so beyond that point - any calls to the interface that is
provided from drivers/misc/cardreader/rtsx_pcr will fail, when invoked
by the rtsx_pci_sdmmc driver?

To me, that sounds a bit fragile and it's also relying on a specific
behaviour of the RTS5261 card reader interface. I wonder if this could
be considered as a common behaviour...??

Perhaps it's better to teach the mmc core *more* about SD express
cards. Maybe add a new host ops for dealing with the specific CMD8
command and make the mmc core to "bail out", rather than keep retrying
the initialization. In principle I think the core should accept that
it may have found an SD express card, then abort further communication
with it. At least until the mmc host indicates that a
re-initialization of the card can be done, which could be through a
remove/re-probe, for example.

>
> > As stated above, I assume you the corresponding platform device for
> > rtsx_pci_sdmmc being deleted and thus triggering the
> > rtsx_pci_sdmmc_drv_remove() being called. Correct? If not, how does the
> > driver manage this?
> >
> Yes.
>
> > > When the card is unplugged, RTS5261 will switch to SD mode by itself
> > > and don't need mmc driver to do anything,
> >
> > Okay.
> >
> > So that means the rtsx_pci_sdmmc driver is being probed again?
> >
> Yes.
>
> > > If you run lspci, you can see NVMe device disappeared and RTS5261 app=
eared
> > again.
> >
> > I see.
> >

If you need some help on the mmc core parts, I am willing to help out.
However, first, I would like to get some better understanding of who
and why the PCI device is deleted.

Kind regards
Uffe
