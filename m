Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AF91EB77D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 10:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgFBIgy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 04:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgFBIgx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 04:36:53 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCC6C03E97D
        for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2020 01:36:53 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id v6so954428uam.10
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2020 01:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H3Yxpmvf/jSIgS2LxZ4b2NRQSqd0Cs8jFnBdeCalSV4=;
        b=jy5AiYo21Nj8g9MlweO+Mqsyt6anwUeETomK/CRHigeKq9x61noYUPLRhLPYVLLIxQ
         Zxi05WXhVs+Ja+kkTFI7lfb9G4CHRLnQ8RcIKu2Jmpw9MNpOFrAHhgwyr07COj2BJfqM
         iGjQDtcC2tD2hQJZs/j4VoXop25hiy1MbFM0JTZwKuhUUR7ncKxoeW9apvjsxuHX128g
         UEuZ/sAO9tFKVDTme5woXlyyvVF+nqYazQF2YVAZv7wJV76FgvnkYdd2DyLOGDoXO0pu
         xdXG7ZUvAJ29hFu9cqU3lcPQuIsrorGBxZd/xt3Onlhocm3hwruxnwIpPNMUxwLv0fW5
         9+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H3Yxpmvf/jSIgS2LxZ4b2NRQSqd0Cs8jFnBdeCalSV4=;
        b=kSiTMPApYIBKcXQiE4jIweeQikW6/n12s+S/uLvyWPRhyyeaeV3Jq/NaL45YwVQXyf
         icaXlf5hRJ1l1hP4eEP9H7Zw/kPLwKaMDnZ4/yLHtvYi0GcVSHGTdwaYuhZyAMHlis+M
         GO6e5H3WVamVVOIs+0AFHDFiG7t2VZTNOyuRP3Si8Worz6XnJvjA73zxahAVU7NLv9xU
         FI5JlrUsvQ7nSURG+aIbegEqB2noN82FtCjpmf8o10R9mjf2jZ6F2xWQH8MXM9kkEKN4
         BKiQE+vXvUk8RHS1mKXuOjcFXOvyrHiXu5IXGzc8upa+3M38C9rwe/zC5cs8SHfKhUTr
         gKYA==
X-Gm-Message-State: AOAM532EjM6TGpTgiIBdih5Wv6g8YaHIhUSQaKoNJ69RYth8DcfauTRW
        RFrUJZdE/jbpB6GWEHra7eJGLsFcxKT74210wCEFvg==
X-Google-Smtp-Source: ABdhPJymekmfL7pO0Vtb4MHnGLHYk/wBoElXzxSAvhbj+sCV77rPXmv1viK2rXGHyITSf+G6ilqnfhyb6qV/id1CjgM=
X-Received: by 2002:a9f:3701:: with SMTP id z1mr17706819uad.100.1591087009888;
 Tue, 02 Jun 2020 01:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <1587864346-3144-1-git-send-email-rui_feng@realsil.com.cn>
 <20200427061426.GA11270@infradead.org> <2A308283684ECD4B896628E09AF5361E028BCA26@RS-MBS01.realsil.com.cn>
 <CAK8P3a0EY=FOu5j5DG1BzMEoy_6nEy129kniWCjMYDEdO1o_Jw@mail.gmail.com>
 <2A308283684ECD4B896628E09AF5361E028BCB4B@RS-MBS01.realsil.com.cn>
 <CAPDyKFqWAzzHDtCwaUUBVvzxX0cf46V-6RZrZ-jvnxpptNKppA@mail.gmail.com>
 <2A308283684ECD4B896628E09AF5361E59ACDB91@RS-MBS01.realsil.com.cn>
 <CAPDyKFo9X9ghjCeF_kGE2BhB+3QiMAMbD1Qz53saXshxy9odVg@mail.gmail.com>
 <2A308283684ECD4B896628E09AF5361E59AD1194@RS-MBS01.realsil.com.cn>
 <CAPDyKFp0Ahcx=iJSGeG19ekDa4rykvAnDHrn4PF5pOoONuH0RA@mail.gmail.com> <2A308283684ECD4B896628E09AF5361E59AD13F0@RS-MBS01.realsil.com.cn>
In-Reply-To: <2A308283684ECD4B896628E09AF5361E59AD13F0@RS-MBS01.realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Jun 2020 10:36:13 +0200
Message-ID: <CAPDyKFp8gwQtPXJgdtEYQovGdFmah+kR7apFjUf_oMPZd_uU8Q@mail.gmail.com>
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

On Tue, 2 Jun 2020 at 04:41, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.cn> w=
rote:
>
> >
> > +linux-mmc
> >
> > On Mon, 1 Jun 2020 at 09:34, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.c=
n> wrote:
> > >
> > > >
> > > > On Tue, 19 May 2020 at 11:18, =E5=86=AF=E9=94=90 <rui_feng@realsil.=
com.cn> wrote:
> > > > >
> > > > > > On Tue, 28 Apr 2020 at 05:44, =E5=86=AF=E9=94=90 <rui_feng@real=
sil.com.cn> wrote:
> > > > > > >
> > > > > > > >
> > > > > > > > On Mon, Apr 27, 2020 at 11:41 AM =E5=86=AF=E9=94=90
> > > > > > > > <rui_feng@realsil.com.cn>
> > > > > > wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > On Sun, Apr 26, 2020 at 09:25:46AM +0800,
> > > > > > > > > > rui_feng@realsil.com.cn
> > > > > > > > wrote:
> > > > > > > > > > > From: Rui Feng <rui_feng@realsil.com.cn>
> > > > > > > > > > >
> > > > > > > > > > > RTS5261 support legacy SD mode and SD Express mode.
> > > > > > > > > > > In SD7.x, SD association introduce SD Express as a ne=
w mode.
> > > > > > > > > > > SD Express mode is distinguished by CMD8.
> > > > > > > > > > > Therefore, CMD8 has new bit for SD Express.
> > > > > > > > > > > SD Express is based on PCIe/NVMe.
> > > > > > > > > > > RTS5261 uses CMD8 to switch to SD Express mode.
> > > > > > > > > >
> > > > > > > > > > So how does this bit work?  They way I imagined SD
> > > > > > > > > > Express to work is that the actual SD Card just shows u=
p
> > > > > > > > > > as a real PCIe device, similar to say Thunderbolt.
> > > > > > > > >
> > > > > > > > > New SD Express card has dual mode. One is SD mode and
> > > > > > > > > another is PCIe
> > > > > > > > mode.
> > > > > > > > > In PCIe mode, it act as a PCIe device and use PCIe
> > > > > > > > > protocol not Thunderbolt
> > > > > > > > protocol.
> > > > > > > >
> > > > > > > > I think what Christoph was asking about is why you need to
> > > > > > > > issue any commands at all in SD mode when you want to use
> > > > > > > > PCIe mode
> > > > instead.
> > > > > > > > What happens if you load the NVMe dthriver before loading
> > > > > > > > the
> > > > > > > > rts5261
> > > > > > driver?
> > > > > > > >
> > > > > > > >        Arnd
> > > > > > > >
> > > > > > > > ------Please consider the environment before printing this =
e-mail.
> > > > > > >
> > > > > > > RTS5261 support SD mode and PCIe/NVMe mode. The workflow is a=
s
> > > > follows.
> > > > > > > 1.RTS5261 work in SD mode.
> > > > > > > 2.If card is plugged in, Host send CMD8 to ask card's PCIe av=
ailability.
> > > > > >
> > > > > > This sounds like the card insert/removal needs to be managed by
> > > > > > the rtsx_pci_sdmmc driver (mmc).
> > > > > >
> > > > > > > 3.If the card has PCIe availability, RTS5261 switch to PCIe/N=
VMe
> > mode.
> > > > > >
> > > > > > This switch is done by the mmc driver, but how does the
> > > > > > PCIe/NVMe driver know when to take over? Isn't there a
> > synchronization point needed?
> > > > > >
> > > > > > > 4.Mmc driver exit and NVMe driver start working.
> > > > > >
> > > > > > Having the mmc driver to exit seems wrong to me. Else how would
> > > > > > you handle a card being removed and inserted again?
> > > > > >
> > > > > > In principle you want the mmc core to fail to detect the card
> > > > > > and then do a handover, somehow. No?
> > > > > >
> > > > > > Although, to make this work there are a couple of problems you
> > > > > > need to deal with.
> > > > > >
> > > > > > 1. If the mmc core doesn't successfully detect a card, it will
> > > > > > request the mmc host to power off the card. In this situation,
> > > > > > you want to keep the power to the card, but leave it to be
> > > > > > managed by the
> > > > PCIe/NVMe driver in some way.
> > > > > >
> > > > > > 2. During system resume, the mmc core may try to restore power
> > > > > > for a card, especially if it's a removable slot, as to make sur=
e
> > > > > > it gets detected if someone inserted a card while the system wa=
s
> > suspended.
> > > > > > Not sure if this plays well with the PCIe/NVMe driver's behavio=
ur.
> > > > > > Again, I think some kind of synchronization is needed.
> > > > > >
> > > > > > > 5.If card is unplugged, RTS5261 will switch to SD mode.
> > > > > >
> > > > > > Alright, clearly the mmc driver is needed to manage card
> > insert/removal.
> > > > > >
> > > > > > > We should send CMD8 in SD mode to ask card's PCIe
> > > > > > > availability, and the
> > > > > > order of NVMe driver and rts5261 driver doesn't matter.
> > > > > >
> > > > > > That assumes there's another synchronization mechanism. Maybe
> > > > > > there is, but I don't understand how.
> > > > > >
> > > > > If no card in RTS5261, RTS5261 works in SD mode. If you run
> > > > > command lspci,
> > > > you can see the RTS5261 device.
> > > >
> > > > Right.
> > > >
> > > > The rtsx_pci_driver (drivers/misc/cardreader/rtsx_pcr.c) has
> > > > registered itself as a pci driver and been probed successfully, I
> > > > assume. Then during
> > > > rtsx_pci_probe() an mfd device is added via mfd_add_devices(), whic=
h
> > > > corresponds to the rtsx_pci_sdmmc
> > > > (drivers/mmc/host/rtsx_pci_sdmmc.c) platform driver.
> > > >
> > > > > When insert a SD Express card, Mmc driver will send CMD8 to ask
> > > > > the card's PCIe availability, because it's a SD EXPRESS card,
> > > >
> > > > Okay, so this will then be a part of the rtsx_pci_sdmmc driver's pr=
obe
> > sequence.
> > > > Or more exactly, when rtsx_pci_sdmmc_drv_probe() completes
> > > > successfully, a mmc rescan work becomes scheduled to try to detect
> > > > an SD/MMC card. Then the CMD8 command is sent...
> > > >
> > > > > RTS5261 will switch to NVMe mode, after switch if you run lspci,
> > > > > you can see
> > > > RTS5261 disappeared and a NVMe device replaces RTS5261.
> > > >
> > > > Can you elaborate more exactly how this managed?
> > > >
> > > > It kind of sounds like the original PCI device is being deleted? Ho=
w
> > > > is this managed?
> > > >
> > > > In any case, the rtsx_pci_driver's ->remove() callback,
> > > > rtsx_pci_remove(), should be invoked, I assume?
> > > >
> > > > That would then lead to that mfd_remove_devices() gets called, whic=
h
> > > > makes the ->remove() callback of the rtsx_pci_sdmmc driver,
> > > > rtsx_pci_sdmmc_drv_remove(), to be invoked. Correct?
> > > >
> > > Yes, after RTS5261 switch to NVMe mode, rtsx_pci_remove() and
> > rtsx_pci_sdmmc_drv_remove() will be invoked.
> >
> > So, the ->remove() callbacks are invoked because the PCI device that
> > corresponds to the rtsx_pci_driver is being deleted. Can you explain wh=
o
> > deletes the PCI device and why?
> >
> > I am not a PCI expert, so apologize for my ignorance - but I really wan=
t to
> > understand how this is supposed to work.
> >
> Rtsx host driver sets RTS5261 0xFF54 bit0=3D1 and 0xFF55 bit4=3D0, then R=
TS5261 will switch MCU and enter SD EXPRESS mode.
> Because hardware design is involved, sorry I can't explain much more deta=
ils about that.

Okay, so somehow that will trigger the PCI bus to remove the
corresponding PCI device, I guess.

>
> > >
> > > > > In NVMe mode, RTS5261 only provide a bridge between SD Express
> > > > > card and
> > > > PCIe. For NVMe driver, just like a new NVMe device is inserted.
> > > >
> > > > I don't understand what that means, but I am also not an expert on
> > PCI/NVMe.
> > > > Care to explain more?
> > > >
> > > In NVMe mode, SD Express card connect the computer via PCIe.
> > > IN SD mode, card connect computer via reader.
> >
> > That didn't make better sense to me, sorry. I do know about the SD spec=
 and
> > the SD-express card protocol parts. Anyway, let's leave this for now.
> >
> > >
> > > > > Mmc core doesn't successfully detect the card and handover to NVM=
e
> > > > > driver. Because of detect the card failed,
> > > >
> > > > How do you make sure that the rtsx_pci_sdmmc driver is leaving the
> > > > card in the correct state for NVMe?
> > > >
> > > > For example, the mmc core has a loop re-trying with a lower
> > > > initialization frequency for the card (400KHz, 300KHz, 200KHz,
> > > > 100KHz). This will cause additional requests to the rtsx_pci_sdmmc =
driver.
> > > >
> > > > > Mmc driver will request the RTS5261 to power off the card, but at
> > > > > that time
> > > > power off the card will not succeed.
> > > >
> > > > Yes, assuming no card was found, the mmc core calls mmc_power_off()=
.
> > > > Ths leads to the rtsx_pci_sdmmc driver's ->set_ios() callback being
> > > > invoked, requesting the card to be powered off. I don't see how you
> > > > are managing this, what am I missing?
> > > >
> > > Before power off card and re-trying initialization, rtsx driver sets =
RTS5261
> > 0xFF55 bit4=3D0.
> > > After set 0xFF55 bit4=3D0, RTS5261 can't receive any CMD from PCIe an=
d
> > prepare for device disappear.
> > > Therefore, MMC driver can't change card status.
> >
> > Okay, so beyond that point - any calls to the interface that is provide=
d from
> > drivers/misc/cardreader/rtsx_pcr will fail, when invoked by the
> > rtsx_pci_sdmmc driver?
> >
> Yes.
>
> > To me, that sounds a bit fragile and it's also relying on a specific be=
haviour of
> > the RTS5261 card reader interface. I wonder if this could be considered=
 as a
> > common behaviour...??
> >
> It's a feature proposal by realtek not common.

Yes, of course.

>
> > Perhaps it's better to teach the mmc core *more* about SD express cards=
.
> > Maybe add a new host ops for dealing with the specific CMD8 command and
> > make the mmc core to "bail out", rather than keep retrying the initiali=
zation. In
> > principle I think the core should accept that it may have found an SD e=
xpress
> > card, then abort further communication with it. At least until the mmc =
host
> > indicates that a re-initialization of the card can be done, which could=
 be through
> > a remove/re-probe, for example.
> >
> In SD7.x spec host should send CMD8 with bit20=3D1 and bit21=3D1 to ask c=
ard's PCIe availability.
> So the CMD8 is not specific for RTS5261, it's just newly defined in SD7.x=
 spec.

Yes, of course.

So, there are two PCIe modes. 1.8V I/O (mandatory and corresponds to
bit20) and 1.2V I/O (optional and corresponds to bit21). It's
important that the mmc host informs the mmc core about it's
capabilities, so we can set the correct bits when sending CMD8.

What do your host support?

> The mmc core will request host to power off card and has a loop re-trying=
 with different initialization frequency for the card (400KHz, 300KHz, 200K=
Hz,
> 100KHz), if I don't modify mmc core, I can't stop the power off and re-tr=
ying, if I modify mmc core, RTS5261 will become a special case for mmc core=
.
> So make the operation fail is the minimum modification in mmc core for me=
. Do you have any other suggestion?

Along the lines of what I suggested above. I think the mmc core should
stop sending commands beyond the CMD8, if the card responds to support
PCIe.

>
> > >
> > > > As stated above, I assume you the corresponding platform device for
> > > > rtsx_pci_sdmmc being deleted and thus triggering the
> > > > rtsx_pci_sdmmc_drv_remove() being called. Correct? If not, how does
> > > > the driver manage this?
> > > >
> > > Yes.
> > >
> > > > > When the card is unplugged, RTS5261 will switch to SD mode by
> > > > > itself and don't need mmc driver to do anything,
> > > >
> > > > Okay.
> > > >
> > > > So that means the rtsx_pci_sdmmc driver is being probed again?
> > > >
> > > Yes.
> > >
> > > > > If you run lspci, you can see NVMe device disappeared and RTS5261
> > > > > appeared
> > > > again.
> > > >
> > > > I see.
> > > >
> >
> > If you need some help on the mmc core parts, I am willing to help out.
> > However, first, I would like to get some better understanding of who an=
d why
> > the PCI device is deleted.
> >
> Can I stop the re-trying in host driver other than modify mmc core?

We need to modify the core, but let me try to help in regards to that.
I will post some patches within a couple of days and keep you posted.

Let's see how this goes.

> As above, I'm sorry I can't explain much more details about hardware desi=
gn.

Sure, it's okay.

Kind regards
Uffe
