Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622833054EC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 08:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhA0Hpk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 02:45:40 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:35477 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhA0Hoi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2021 02:44:38 -0500
Received: by mail-ot1-f46.google.com with SMTP id 36so847210otp.2;
        Tue, 26 Jan 2021 23:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0dGkBBCOjjdRO5NeNomyXurGTss4C1Z8jAZPD1nTr0=;
        b=D/t6/XpngIhr+dElHpkKgt7I9raIdEFD/aIUvplW60JNP0cGyfm8vB5RupvZjShzK8
         o9tAFA7R1prXP1p4TWSIDLkFG3Ok12Pr731mwn36mh6OTJ6NZINfAlsYeJiYCMn4aPE8
         SoJJP9OWxg7MTI1M8h2hTZq7jAqlg7xGRNqPg+nXVJu12OokR1Tpl3dBANluMPjYMzJd
         ililMEOfD6U8Wqr+uSU3mqavqrZ1scytN5GGfOAR5AYlkG3bSHsoUnzvbhkv3qH3Tz2A
         v3cVkmUc3XEWwej1GhByKCSx44Cwci6TR6WIFhOYA/47d0kdY0MbOWh5Hy40AvsjGOAS
         QW/g==
X-Gm-Message-State: AOAM532/RncdhhlpjY2XqfIjMmv+jhWUhCflVCbduVIUpwgMM/NL5QHn
        KAKKdqvgiH1tZvbdGNoeo4s8OzikM3SJEHe6N+A=
X-Google-Smtp-Source: ABdhPJytEiLX+kMjV4Ea2i2rFfKnTCKJB2DxU0jLTV+BpUesrQ9gHru0x+sIRyJPwSKOmvFMZ1Gze3L0qvmdO0bLsr0=
X-Received: by 2002:a9d:c01:: with SMTP id 1mr6698124otr.107.1611733436883;
 Tue, 26 Jan 2021 23:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc> <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc> <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
 <f706c0e4b684e07635396fcf02f4c9a6@walle.cc> <CAGETcx8_6Hp+MWFOhRohXwdWFSfCc7A=zpb5QYNHZE5zv0bDig@mail.gmail.com>
 <CAMuHMdWvFej-6vkaLM44t7eX2LpkDSXu4_7VH-X-3XRueXTO=A@mail.gmail.com>
 <a24391e62b107040435766fff52bdd31@walle.cc> <CAGETcx8FO+YSM0jwCnDdnvE3NCdjZ=1FSmAZpyaOEOvCgd4SXw@mail.gmail.com>
 <CAMuHMdX8__juNc-Lx8Tu9abMKq-pT=yA4s6D1w4ZeStKOasGpg@mail.gmail.com> <CAGETcx-0G-Y8wT_+BfP5vbi0gW6KonwgoJ6DdqjaGbFkutTGag@mail.gmail.com>
In-Reply-To: <CAGETcx-0G-Y8wT_+BfP5vbi0gW6KonwgoJ6DdqjaGbFkutTGag@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Jan 2021 08:43:45 +0100
Message-ID: <CAMuHMdXMaAtrbQibJh+Z2v5qhe_Tg0hQU9YqxuU0ow_iNO1atg@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Michael Walle <michael@walle.cc>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Roy Zang <roy.zang@nxp.com>, PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Saravana,

On Wed, Jan 27, 2021 at 1:44 AM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Jan 26, 2021 at 12:50 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Jan 25, 2021 at 11:42 PM Saravana Kannan <saravanak@google.com> wrote:
> > > On Mon, Jan 25, 2021 at 11:49 AM Michael Walle <michael@walle.cc> wrote:
> > > > Am 2021-01-21 12:01, schrieb Geert Uytterhoeven:
> > > > > On Thu, Jan 21, 2021 at 1:05 AM Saravana Kannan <saravanak@google.com>
> > > > > wrote:
> > > > >> On Wed, Jan 20, 2021 at 3:53 PM Michael Walle <michael@walle.cc>
> > > > >> wrote:
> > > > >> > Am 2021-01-20 20:47, schrieb Saravana Kannan:
> > > > >> > > On Wed, Jan 20, 2021 at 11:28 AM Michael Walle <michael@walle.cc>
> > > > >> > > wrote:
> > > > >> > >>
> > > > >> > >> [RESEND, fat-fingered the buttons of my mail client and converted
> > > > >> > >> all CCs to BCCs :(]
> > > > >> > >>
> > > > >> > >> Am 2021-01-20 20:02, schrieb Saravana Kannan:
> > > > >> > >> > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
> > > > >> > >> >>
> > > > >> > >> >> On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
> > > > >> > >> >> wrote:
> > > > >> > >> >> >
> > > > >> > >> >> > fw_devlink will defer the probe until all suppliers are ready. We can't
> > > > >> > >> >> > use builtin_platform_driver_probe() because it doesn't retry after probe
> > > > >> > >> >> > deferral. Convert it to builtin_platform_driver().
> > > > >> > >> >>
> > > > >> > >> >> If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> > > > >> > >> >> shouldn't it be fixed or removed?
> > > > >> > >> >
> > > > >> > >> > I was actually thinking about this too. The problem with fixing
> > > > >> > >> > builtin_platform_driver_probe() to behave like
> > > > >> > >> > builtin_platform_driver() is that these probe functions could be
> > > > >> > >> > marked with __init. But there are also only 20 instances of
> > > > >> > >> > builtin_platform_driver_probe() in the kernel:
> > > > >> > >> > $ git grep ^builtin_platform_driver_probe | wc -l
> > > > >> > >> > 20
> > > > >> > >> >
> > > > >> > >> > So it might be easier to just fix them to not use
> > > > >> > >> > builtin_platform_driver_probe().
> > > > >> > >> >
> > > > >> > >> > Michael,
> > > > >> > >> >
> > > > >> > >> > Any chance you'd be willing to help me by converting all these to
> > > > >> > >> > builtin_platform_driver() and delete builtin_platform_driver_probe()?
> > > > >> > >>
> > > > >> > >> If it just moving the probe function to the _driver struct and
> > > > >> > >> remove the __init annotations. I could look into that.
> > > > >> > >
> > > > >> > > Yup. That's pretty much it AFAICT.
> > > > >> > >
> > > > >> > > builtin_platform_driver_probe() also makes sure the driver doesn't ask
> > > > >> > > for async probe, etc. But I doubt anyone is actually setting async
> > > > >> > > flags and still using builtin_platform_driver_probe().
> > > > >> >
> > > > >> > Hasn't module_platform_driver_probe() the same problem? And there
> > > > >> > are ~80 drivers which uses that.
> > > > >>
> > > > >> Yeah. The biggest problem with all of these is the __init markers.
> > > > >> Maybe some familiar with coccinelle can help?
> > > > >
> > > > > And dropping them will increase memory usage.
> > > >
> > > > Although I do have the changes for the builtin_platform_driver_probe()
> > > > ready, I don't think it makes much sense to send these unless we agree
> > > > on the increased memory footprint. While there are just a few
> > > > builtin_platform_driver_probe() and memory increase _might_ be
> > > > negligible, there are many more module_platform_driver_probe().
> > >
> > > While it's good to drop code that'll not be used past kernel init, the
> > > module_platform_driver_probe() is going even more extreme. It doesn't
> > > even allow deferred probe (well before kernel init is done). I don't
> > > think that behavior is right and that's why we should delete it. Also,
> >
> > This construct is typically used for builtin hardware for which the
> > dependencies are registered very early, and thus known to probe at
> > first try (if present).
> >
> > > I doubt if any of these probe functions even take up 4KB of memory.
> >
> > How many 4 KiB pages do you have in a system with 10 MiB of SRAM?
> > How many can you afford to waste?
>
> There are only a few instances of this macro in the kernel. How many

$ git grep -lw builtin_platform_driver_probe | wc -l
21
$ git grep -lw module_platform_driver_probe | wc -l
86

+ the ones that haven't been converted to the above yet:

$ git grep -lw platform_driver_probe | wc -l
58

> of those actually fit the description above? We can probably just
> check the DT?

What do you mean by checking the DT?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
