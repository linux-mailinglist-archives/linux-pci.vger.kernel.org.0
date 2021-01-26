Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B8C303860
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 09:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbhAZIwD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 03:52:03 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39077 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390427AbhAZIvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2021 03:51:06 -0500
Received: by mail-ot1-f49.google.com with SMTP id i30so15537498ota.6;
        Tue, 26 Jan 2021 00:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQS05gAa+WfDRZQbLeXyiyoUlWSeuuqlrJ0M+LF4pGw=;
        b=kSa/7qtt5aHXOir55Yn9tnMtiNUqcBdzhYRFuZSyWVQDhDsnb8c/WNWxUqp0w3pREp
         to5Yu3gs5YAElhZgQdbgAV8KW5CeBC3pyxSa/pmiAe+p5acsQoWpmt6VelV+Nn1fcgL/
         LFF4zDc4abObMqnnkPv6gbCOJs6Bmq7obdtk8brj1ImutIoD8wkK+XJHSMOmJyWqXW1h
         mCIgaRPUTao+nBpOvx4sbR5bMJA0EMtgOHwOiwacLGggXB6fxNP0axNC33O+FOcP3v9K
         GIcQ9Q2sk9ng98EJaMlPusg8fTnLv3Lj90PTHqVNESAXWZLixhA1eVg6fvuT0dudGL2X
         dRBQ==
X-Gm-Message-State: AOAM533Xw2u3K5yz4UZwo/CJMTIb0slPBM028V0iDdqTMu0l5uil9Qpl
        CYwloAjTufzTReBKQPq0DHZe5S6NAaQBqvg7hj0=
X-Google-Smtp-Source: ABdhPJydB/0YI6k0pmQhCEPbC77QKWeRVaG2MIkeegbghOEhRTqm/NdHbTtvjdrHIu5hkpVekXoUN0XUzbHHm5UHQp4=
X-Received: by 2002:a05:6830:15cc:: with SMTP id j12mr3278439otr.145.1611651025336;
 Tue, 26 Jan 2021 00:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc> <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc> <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
 <f706c0e4b684e07635396fcf02f4c9a6@walle.cc> <CAGETcx8_6Hp+MWFOhRohXwdWFSfCc7A=zpb5QYNHZE5zv0bDig@mail.gmail.com>
 <CAMuHMdWvFej-6vkaLM44t7eX2LpkDSXu4_7VH-X-3XRueXTO=A@mail.gmail.com>
 <a24391e62b107040435766fff52bdd31@walle.cc> <CAGETcx8FO+YSM0jwCnDdnvE3NCdjZ=1FSmAZpyaOEOvCgd4SXw@mail.gmail.com>
In-Reply-To: <CAGETcx8FO+YSM0jwCnDdnvE3NCdjZ=1FSmAZpyaOEOvCgd4SXw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Jan 2021 09:50:14 +0100
Message-ID: <CAMuHMdX8__juNc-Lx8Tu9abMKq-pT=yA4s6D1w4ZeStKOasGpg@mail.gmail.com>
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

On Mon, Jan 25, 2021 at 11:42 PM Saravana Kannan <saravanak@google.com> wrote:
> On Mon, Jan 25, 2021 at 11:49 AM Michael Walle <michael@walle.cc> wrote:
> > Am 2021-01-21 12:01, schrieb Geert Uytterhoeven:
> > > On Thu, Jan 21, 2021 at 1:05 AM Saravana Kannan <saravanak@google.com>
> > > wrote:
> > >> On Wed, Jan 20, 2021 at 3:53 PM Michael Walle <michael@walle.cc>
> > >> wrote:
> > >> > Am 2021-01-20 20:47, schrieb Saravana Kannan:
> > >> > > On Wed, Jan 20, 2021 at 11:28 AM Michael Walle <michael@walle.cc>
> > >> > > wrote:
> > >> > >>
> > >> > >> [RESEND, fat-fingered the buttons of my mail client and converted
> > >> > >> all CCs to BCCs :(]
> > >> > >>
> > >> > >> Am 2021-01-20 20:02, schrieb Saravana Kannan:
> > >> > >> > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
> > >> > >> >>
> > >> > >> >> On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
> > >> > >> >> wrote:
> > >> > >> >> >
> > >> > >> >> > fw_devlink will defer the probe until all suppliers are ready. We can't
> > >> > >> >> > use builtin_platform_driver_probe() because it doesn't retry after probe
> > >> > >> >> > deferral. Convert it to builtin_platform_driver().
> > >> > >> >>
> > >> > >> >> If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> > >> > >> >> shouldn't it be fixed or removed?
> > >> > >> >
> > >> > >> > I was actually thinking about this too. The problem with fixing
> > >> > >> > builtin_platform_driver_probe() to behave like
> > >> > >> > builtin_platform_driver() is that these probe functions could be
> > >> > >> > marked with __init. But there are also only 20 instances of
> > >> > >> > builtin_platform_driver_probe() in the kernel:
> > >> > >> > $ git grep ^builtin_platform_driver_probe | wc -l
> > >> > >> > 20
> > >> > >> >
> > >> > >> > So it might be easier to just fix them to not use
> > >> > >> > builtin_platform_driver_probe().
> > >> > >> >
> > >> > >> > Michael,
> > >> > >> >
> > >> > >> > Any chance you'd be willing to help me by converting all these to
> > >> > >> > builtin_platform_driver() and delete builtin_platform_driver_probe()?
> > >> > >>
> > >> > >> If it just moving the probe function to the _driver struct and
> > >> > >> remove the __init annotations. I could look into that.
> > >> > >
> > >> > > Yup. That's pretty much it AFAICT.
> > >> > >
> > >> > > builtin_platform_driver_probe() also makes sure the driver doesn't ask
> > >> > > for async probe, etc. But I doubt anyone is actually setting async
> > >> > > flags and still using builtin_platform_driver_probe().
> > >> >
> > >> > Hasn't module_platform_driver_probe() the same problem? And there
> > >> > are ~80 drivers which uses that.
> > >>
> > >> Yeah. The biggest problem with all of these is the __init markers.
> > >> Maybe some familiar with coccinelle can help?
> > >
> > > And dropping them will increase memory usage.
> >
> > Although I do have the changes for the builtin_platform_driver_probe()
> > ready, I don't think it makes much sense to send these unless we agree
> > on the increased memory footprint. While there are just a few
> > builtin_platform_driver_probe() and memory increase _might_ be
> > negligible, there are many more module_platform_driver_probe().
>
> While it's good to drop code that'll not be used past kernel init, the
> module_platform_driver_probe() is going even more extreme. It doesn't
> even allow deferred probe (well before kernel init is done). I don't
> think that behavior is right and that's why we should delete it. Also,

This construct is typically used for builtin hardware for which the
dependencies are registered very early, and thus known to probe at
first try (if present).

> I doubt if any of these probe functions even take up 4KB of memory.

How many 4 KiB pages do you have in a system with 10 MiB of SRAM?
How many can you afford to waste?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
