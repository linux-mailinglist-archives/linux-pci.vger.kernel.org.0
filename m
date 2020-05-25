Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F98B1E0BCD
	for <lists+linux-pci@lfdr.de>; Mon, 25 May 2020 12:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbgEYK2J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 May 2020 06:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389721AbgEYK2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 May 2020 06:28:08 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E7BC05BD43
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2020 03:28:08 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id b28so7619781vsa.5
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2020 03:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u9FmgI2eqhoebtGwkcoRcMTx910T2B58Vf0ogAnRIS8=;
        b=ueZAhikSW57y5bST4zr2luN3yPnxaIw9iaC1m3u94CBXF76nTBQbRw87kowR4BttgW
         pQvtJ4t0YbHo7B3SZy76NjVvugWaYi1N2q+9FzM4Y6+Ri5gn1WkyEtwUDa66g+wLuuES
         RU7lSfW/kPtb6lxwlDRc8fRgwIABmxFzCXqmspJd69KC7KBzsduSXC7WGeAx8JxyB1A0
         fz0hsMKFH7IWVE8JxaNZdm65hT7oTvJcCts5YsxG/1hhj4FVz8M3vZrWOrQcnjJC+vSQ
         5QC90SRohNHmUv+FwKWRPmuIljKsbBTdR0EWh0ce4Kn+HDZGhHF4mwf5vyBG40U26/S+
         bT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u9FmgI2eqhoebtGwkcoRcMTx910T2B58Vf0ogAnRIS8=;
        b=aJCv0iRdSxo4VPTpXozB3CEl0FL0+6e6nGAeEkgFI2BgnM0+T4x5fX+yrxmpha6v/p
         bEcZrfb6cGdYqzc7kfOI4zrLG2YaeQm+KMtogI7D9pffiTQsXLYtjo0zkTjxnphqaxTg
         vTGaMVGfcHbvpFF8KOEybSKRL9Y/DwDHCrUAX+ZU3TuzAru/H3YhJu830SsKWxGaVWVp
         1rpmvt6YkMZg7iR6GwseRjcy97CzXNMCuUmhCp+OppqZPbd8wwofeHjC/lc2mL31sBON
         QhlbJ2b5Pbb4eJiireZeXYpU5UR0o0mjqp2f23Lj3wkVw8X0qcAEaMFS58alGDRvUdh5
         /cTA==
X-Gm-Message-State: AOAM532yjIGYacabKciVSJQRnOtd43HX3qsxNUI8vFiK1nFEY6JwsUQc
        iR/GqHH/d5i+evYHAAvBaHNn3Oir6df5bKYEBVgh6g==
X-Google-Smtp-Source: ABdhPJzYMaRs6n2PuNzo6z/5Y5t4FVXvCjpFY1FaYqBP5Fgoft2PnzkwAZ0kW3waJOOIJgTUM0Fm4sONxBRf1ffzqwA=
X-Received: by 2002:a67:1486:: with SMTP id 128mr13291744vsu.191.1590402487589;
 Mon, 25 May 2020 03:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <1587864346-3144-1-git-send-email-rui_feng@realsil.com.cn>
 <20200427061426.GA11270@infradead.org> <2A308283684ECD4B896628E09AF5361E028BCA26@RS-MBS01.realsil.com.cn>
 <CAK8P3a0EY=FOu5j5DG1BzMEoy_6nEy129kniWCjMYDEdO1o_Jw@mail.gmail.com>
 <2A308283684ECD4B896628E09AF5361E028BCB4B@RS-MBS01.realsil.com.cn>
 <CAPDyKFqWAzzHDtCwaUUBVvzxX0cf46V-6RZrZ-jvnxpptNKppA@mail.gmail.com> <2A308283684ECD4B896628E09AF5361E59ACDB91@RS-MBS01.realsil.com.cn>
In-Reply-To: <2A308283684ECD4B896628E09AF5361E59ACDB91@RS-MBS01.realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 May 2020 12:27:31 +0200
Message-ID: <CAPDyKFo9X9ghjCeF_kGE2BhB+3QiMAMbD1Qz53saXshxy9odVg@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: Add SD Express mode support for RTS5261
To:     =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 19 May 2020 at 11:18, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.cn> =
wrote:
>
> > On Tue, 28 Apr 2020 at 05:44, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.=
cn> wrote:
> > >
> > > >
> > > > On Mon, Apr 27, 2020 at 11:41 AM =E5=86=AF=E9=94=90 <rui_feng@reals=
il.com.cn>
> > wrote:
> > > > >
> > > > >
> > > > > > On Sun, Apr 26, 2020 at 09:25:46AM +0800,
> > > > > > rui_feng@realsil.com.cn
> > > > wrote:
> > > > > > > From: Rui Feng <rui_feng@realsil.com.cn>
> > > > > > >
> > > > > > > RTS5261 support legacy SD mode and SD Express mode.
> > > > > > > In SD7.x, SD association introduce SD Express as a new mode.
> > > > > > > SD Express mode is distinguished by CMD8.
> > > > > > > Therefore, CMD8 has new bit for SD Express.
> > > > > > > SD Express is based on PCIe/NVMe.
> > > > > > > RTS5261 uses CMD8 to switch to SD Express mode.
> > > > > >
> > > > > > So how does this bit work?  They way I imagined SD Express to
> > > > > > work is that the actual SD Card just shows up as a real PCIe
> > > > > > device, similar to say Thunderbolt.
> > > > >
> > > > > New SD Express card has dual mode. One is SD mode and another is
> > > > > PCIe
> > > > mode.
> > > > > In PCIe mode, it act as a PCIe device and use PCIe protocol not
> > > > > Thunderbolt
> > > > protocol.
> > > >
> > > > I think what Christoph was asking about is why you need to issue an=
y
> > > > commands at all in SD mode when you want to use PCIe mode instead.
> > > > What happens if you load the NVMe dthriver before loading the rts52=
61
> > driver?
> > > >
> > > >        Arnd
> > > >
> > > > ------Please consider the environment before printing this e-mail.
> > >
> > > RTS5261 support SD mode and PCIe/NVMe mode. The workflow is as follow=
s.
> > > 1.RTS5261 work in SD mode.
> > > 2.If card is plugged in, Host send CMD8 to ask card's PCIe availabili=
ty.
> >
> > This sounds like the card insert/removal needs to be managed by the
> > rtsx_pci_sdmmc driver (mmc).
> >
> > > 3.If the card has PCIe availability, RTS5261 switch to PCIe/NVMe mode=
.
> >
> > This switch is done by the mmc driver, but how does the PCIe/NVMe drive=
r
> > know when to take over? Isn't there a synchronization point needed?
> >
> > > 4.Mmc driver exit and NVMe driver start working.
> >
> > Having the mmc driver to exit seems wrong to me. Else how would you han=
dle
> > a card being removed and inserted again?
> >
> > In principle you want the mmc core to fail to detect the card and then =
do a
> > handover, somehow. No?
> >
> > Although, to make this work there are a couple of problems you need to =
deal
> > with.
> >
> > 1. If the mmc core doesn't successfully detect a card, it will request =
the mmc
> > host to power off the card. In this situation, you want to keep the pow=
er to the
> > card, but leave it to be managed by the PCIe/NVMe driver in some way.
> >
> > 2. During system resume, the mmc core may try to restore power for a ca=
rd,
> > especially if it's a removable slot, as to make sure it gets detected i=
f someone
> > inserted a card while the system was suspended.
> > Not sure if this plays well with the PCIe/NVMe driver's behaviour.
> > Again, I think some kind of synchronization is needed.
> >
> > > 5.If card is unplugged, RTS5261 will switch to SD mode.
> >
> > Alright, clearly the mmc driver is needed to manage card insert/removal=
.
> >
> > > We should send CMD8 in SD mode to ask card's PCIe availability, and t=
he
> > order of NVMe driver and rts5261 driver doesn't matter.
> >
> > That assumes there's another synchronization mechanism. Maybe there is,=
 but
> > I don't understand how.
> >
> If no card in RTS5261, RTS5261 works in SD mode. If you run command lspci=
, you can see the RTS5261 device.

Right.

The rtsx_pci_driver (drivers/misc/cardreader/rtsx_pcr.c) has
registered itself as a pci driver and been probed successfully, I
assume. Then during rtsx_pci_probe() an mfd device is added via
mfd_add_devices(), which corresponds to the rtsx_pci_sdmmc
(drivers/mmc/host/rtsx_pci_sdmmc.c) platform driver.

> When insert a SD Express card, Mmc driver will send CMD8 to ask the card'=
s PCIe availability, because it's a SD EXPRESS card,

Okay, so this will then be a part of the rtsx_pci_sdmmc driver's probe
sequence. Or more exactly, when rtsx_pci_sdmmc_drv_probe() completes
successfully, a mmc rescan work becomes scheduled to try to detect an
SD/MMC card. Then the CMD8 command is sent...

> RTS5261 will switch to NVMe mode, after switch if you run lspci, you can =
see RTS5261 disappeared and a NVMe device replaces RTS5261.

Can you elaborate more exactly how this managed?

It kind of sounds like the original PCI device is being deleted? How
is this managed?

In any case, the rtsx_pci_driver's ->remove() callback,
rtsx_pci_remove(), should be invoked, I assume?

That would then lead to that mfd_remove_devices() gets called, which
makes the ->remove() callback of the rtsx_pci_sdmmc driver,
rtsx_pci_sdmmc_drv_remove(), to be invoked. Correct?

> In NVMe mode, RTS5261 only provide a bridge between SD Express card and P=
CIe. For NVMe driver, just like a new NVMe device is inserted.

I don't understand what that means, but I am also not an expert on
PCI/NVMe. Care to explain more?

> Mmc core doesn't successfully detect the card and handover to NVMe driver=
. Because of detect the card failed,

How do you make sure that the rtsx_pci_sdmmc driver is leaving the
card in the correct state for NVMe?

For example, the mmc core has a loop re-trying with a lower
initialization frequency for the card (400KHz, 300KHz, 200KHz,
100KHz). This will cause additional requests to the rtsx_pci_sdmmc
driver.

> Mmc driver will request the RTS5261 to power off the card, but at that ti=
me power off the card will not succeed.

Yes, assuming no card was found, the mmc core calls mmc_power_off().
Ths leads to the rtsx_pci_sdmmc driver's ->set_ios() callback being
invoked, requesting the card to be powered off. I don't see how you
are managing this, what am I missing?

As stated above, I assume you the corresponding platform device for
rtsx_pci_sdmmc being deleted and thus triggering the
rtsx_pci_sdmmc_drv_remove() being called. Correct? If not, how does
the driver manage this?

> When the card is unplugged, RTS5261 will switch to SD mode by itself and =
don't need mmc driver to do anything,

Okay.

So that means the rtsx_pci_sdmmc driver is being probed again?

> If you run lspci, you can see NVMe device disappeared and RTS5261 appeare=
d again.

I see.

Kind regards
Uffe
