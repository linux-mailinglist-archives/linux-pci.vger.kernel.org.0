Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CFE2FE84C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 12:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbhAULCz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 06:02:55 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43254 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbhAULCl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jan 2021 06:02:41 -0500
Received: by mail-ot1-f47.google.com with SMTP id v1so1186757ott.10;
        Thu, 21 Jan 2021 03:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0t6IbQwZ6aPHm7zibBMR6oc08hDXRFl0UUCk6sC9bM=;
        b=s1JgGhMfGIEorKIkmY1uOCy6rhKZjEN2g/y0mH9xU7LfyBDaqKZx1HJGKIpsnnnCLl
         1dtR+itgXotyc12XJWpqLnO8N0bSGyqqpcEFgKbc1X0xw6mZ38i6hUQJeQAX0dmcTK0Z
         PFaajorVROhs7lPXfqh1UJhZ1XzNSgKbUJyP3aNNZ953EyU9ozoxIUJOTHlC/s5flu2u
         VXh4VBAWiCPsruCtgqdHdL8XhI4d8D9fQSKdtidKQW5CDs2TLI3zFaXBUUQRD0mgV8Mc
         tnXT0l+Dfv0MkdRSzesm754R32j6Ge2zkW2wbd3vpAFghxAt8oPUb9V5fcXSG8ipsPap
         LSww==
X-Gm-Message-State: AOAM531ORADILRmpCOpKYlpHVEntf40KPu3/+wMeSAfboTunr6pUuQo8
        3LBP2hh7fbrtLsx/EhHzLLWUDdKwrEnjTe+EnOU=
X-Google-Smtp-Source: ABdhPJzSbFq2Zg/MF32GZEaX+aMqzCGFlyozhpNYPxHvt5ug1jBRwJ1lgTOfRSPtDNp9bqyOAhcuPvtUBSO1aAA+gxU=
X-Received: by 2002:a9d:c01:: with SMTP id 1mr9868576otr.107.1611226921014;
 Thu, 21 Jan 2021 03:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc> <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc> <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
 <f706c0e4b684e07635396fcf02f4c9a6@walle.cc> <CAGETcx8_6Hp+MWFOhRohXwdWFSfCc7A=zpb5QYNHZE5zv0bDig@mail.gmail.com>
In-Reply-To: <CAGETcx8_6Hp+MWFOhRohXwdWFSfCc7A=zpb5QYNHZE5zv0bDig@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jan 2021 12:01:50 +0100
Message-ID: <CAMuHMdWvFej-6vkaLM44t7eX2LpkDSXu4_7VH-X-3XRueXTO=A@mail.gmail.com>
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

On Thu, Jan 21, 2021 at 1:05 AM Saravana Kannan <saravanak@google.com> wrote:
> On Wed, Jan 20, 2021 at 3:53 PM Michael Walle <michael@walle.cc> wrote:
> > Am 2021-01-20 20:47, schrieb Saravana Kannan:
> > > On Wed, Jan 20, 2021 at 11:28 AM Michael Walle <michael@walle.cc>
> > > wrote:
> > >>
> > >> [RESEND, fat-fingered the buttons of my mail client and converted
> > >> all CCs to BCCs :(]
> > >>
> > >> Am 2021-01-20 20:02, schrieb Saravana Kannan:
> > >> > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
> > >> >>
> > >> >> On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
> > >> >> wrote:
> > >> >> >
> > >> >> > fw_devlink will defer the probe until all suppliers are ready. We can't
> > >> >> > use builtin_platform_driver_probe() because it doesn't retry after probe
> > >> >> > deferral. Convert it to builtin_platform_driver().
> > >> >>
> > >> >> If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> > >> >> shouldn't it be fixed or removed?
> > >> >
> > >> > I was actually thinking about this too. The problem with fixing
> > >> > builtin_platform_driver_probe() to behave like
> > >> > builtin_platform_driver() is that these probe functions could be
> > >> > marked with __init. But there are also only 20 instances of
> > >> > builtin_platform_driver_probe() in the kernel:
> > >> > $ git grep ^builtin_platform_driver_probe | wc -l
> > >> > 20
> > >> >
> > >> > So it might be easier to just fix them to not use
> > >> > builtin_platform_driver_probe().
> > >> >
> > >> > Michael,
> > >> >
> > >> > Any chance you'd be willing to help me by converting all these to
> > >> > builtin_platform_driver() and delete builtin_platform_driver_probe()?
> > >>
> > >> If it just moving the probe function to the _driver struct and
> > >> remove the __init annotations. I could look into that.
> > >
> > > Yup. That's pretty much it AFAICT.
> > >
> > > builtin_platform_driver_probe() also makes sure the driver doesn't ask
> > > for async probe, etc. But I doubt anyone is actually setting async
> > > flags and still using builtin_platform_driver_probe().
> >
> > Hasn't module_platform_driver_probe() the same problem? And there
> > are ~80 drivers which uses that.
>
> Yeah. The biggest problem with all of these is the __init markers.
> Maybe some familiar with coccinelle can help?

And dropping them will increase memory usage.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
