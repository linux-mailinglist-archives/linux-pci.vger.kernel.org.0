Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2EB3061A4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 18:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhA0ROT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 12:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbhA0RML (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2021 12:12:11 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960C5C06174A
        for <linux-pci@vger.kernel.org>; Wed, 27 Jan 2021 09:11:31 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id k4so2705924ybp.6
        for <linux-pci@vger.kernel.org>; Wed, 27 Jan 2021 09:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCMC9c1Y3UdZlZUZ7gotdft22BvIa2n17Y+bk6uxrpU=;
        b=buF+e6cQQikru+I+wPmZzNHqUP53S5gn9SMSJhpEVq/IXcbgB6FO65hbHfPo5g2lK5
         tUusqRpXb7HvQiCBMvWBMVL5Oid4fmEwGQ/2fQo47okY61Ue2gIUeT/kfiIac7f/Hwyj
         6FFRbPsxZnt7Sma6ev9KJH145i55FdneRppghjcezH8k7lsQBohDAsn1SSjCT2nBwLVL
         eHJ3P7RvYKqs/+NCcq/RDW145cZKVpfugES4mbapMWIaTaMMwD21YwXD8+fYXkgMReNw
         k3RHPl/7T3Z9hcN33LNPPMq/w+APPDTRZPmfjV7r5YSKnh7nEVYr+/9yphZuhauCX4zE
         skMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCMC9c1Y3UdZlZUZ7gotdft22BvIa2n17Y+bk6uxrpU=;
        b=pLR1mHrzn4v6BhU2/4SxjX8IbVuDm332Uff2f1JZqIFsA+jSt/LhcrD/1YI/ZYUdYc
         PE0jRrkkBarmynHX1V+UOrp5Fyn9nYReGQh0IilKuzAMIvcgEqfotmW3MN5A9JuQeqJi
         kKq6nZRtCUv46TNUOJ2nbIgxsMYklIxP2Yz77vXbVqm/p5478qnoCToCFvdU/hi1sxjm
         lgGzvCEbzzg2YViRo7sG5aDkfpTVlRHCbgx/h+fhkwYMwT2Ykw4NpyacC/rUSBj1G9Ug
         FRDcIxSuC6TLCGbADZuZk+MEzQB2oqk0o6pyv1fNEeQpQCKQomhQwmd2G37v2sNY7oII
         sslQ==
X-Gm-Message-State: AOAM533JBSegYA2A+lHqAzAK7UExHa5U5WR8kkvrMqR2P39BAox5NxiF
        d2LNsjjYtqg5jm9DoLIT1ORPrX1zVAdFcWNqLQPNrw==
X-Google-Smtp-Source: ABdhPJxrBQe4Av/shkBNQ8ehUaFA7s4Ekhjqa1UpGiP1H/CtNg0Du0ryBzR8ZDxVbe7g6lqnkfZP88faYZGZi40TLVg=
X-Received: by 2002:a25:8b8b:: with SMTP id j11mr16073043ybl.310.1611767490478;
 Wed, 27 Jan 2021 09:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc> <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc> <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
 <f706c0e4b684e07635396fcf02f4c9a6@walle.cc> <CAGETcx8_6Hp+MWFOhRohXwdWFSfCc7A=zpb5QYNHZE5zv0bDig@mail.gmail.com>
 <CAMuHMdWvFej-6vkaLM44t7eX2LpkDSXu4_7VH-X-3XRueXTO=A@mail.gmail.com>
 <a24391e62b107040435766fff52bdd31@walle.cc> <CAGETcx8FO+YSM0jwCnDdnvE3NCdjZ=1FSmAZpyaOEOvCgd4SXw@mail.gmail.com>
 <CAMuHMdX8__juNc-Lx8Tu9abMKq-pT=yA4s6D1w4ZeStKOasGpg@mail.gmail.com>
 <CAGETcx-0G-Y8wT_+BfP5vbi0gW6KonwgoJ6DdqjaGbFkutTGag@mail.gmail.com>
 <CAMuHMdXMaAtrbQibJh+Z2v5qhe_Tg0hQU9YqxuU0ow_iNO1atg@mail.gmail.com>
 <CAGETcx8=woX_SVckG+gs68KMif-JGoy3a1PQGfonMNBH18Ak6A@mail.gmail.com> <CAMuHMdUpzaRutO+jKffXtGDoy5g2QoXkbO+-tzbEzibNYbhCuA@mail.gmail.com>
In-Reply-To: <CAMuHMdUpzaRutO+jKffXtGDoy5g2QoXkbO+-tzbEzibNYbhCuA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 27 Jan 2021 09:10:54 -0800
Message-ID: <CAGETcx_81qOe2LvX-J_PBZWdouykPoPYdf5=yMVhnjgDxAkgaw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Wed, Jan 27, 2021 at 8:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Wed, Jan 27, 2021 at 5:42 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Tue, Jan 26, 2021 at 11:43 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Wed, Jan 27, 2021 at 1:44 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > On Tue, Jan 26, 2021 at 12:50 AM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:
> > > > > On Mon, Jan 25, 2021 at 11:42 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > > > On Mon, Jan 25, 2021 at 11:49 AM Michael Walle <michael@walle.cc> wrote:
> > > > > > > Am 2021-01-21 12:01, schrieb Geert Uytterhoeven:
> > > > > > > > On Thu, Jan 21, 2021 at 1:05 AM Saravana Kannan <saravanak@google.com>
> > > > > > > > wrote:
> > > > > > > >> On Wed, Jan 20, 2021 at 3:53 PM Michael Walle <michael@walle.cc>
> > > > > > > >> wrote:
> > > > > > > >> > Am 2021-01-20 20:47, schrieb Saravana Kannan:
> > > > > > > >> > > On Wed, Jan 20, 2021 at 11:28 AM Michael Walle <michael@walle.cc>
> > > > > > > >> > > wrote:
> > > > > > > >> > >>
> > > > > > > >> > >> [RESEND, fat-fingered the buttons of my mail client and converted
> > > > > > > >> > >> all CCs to BCCs :(]
> > > > > > > >> > >>
> > > > > > > >> > >> Am 2021-01-20 20:02, schrieb Saravana Kannan:
> > > > > > > >> > >> > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
> > > > > > > >> > >> >>
> > > > > > > >> > >> >> On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
> > > > > > > >> > >> >> wrote:
> > > > > > > >> > >> >> >
> > > > > > > >> > >> >> > fw_devlink will defer the probe until all suppliers are ready. We can't
> > > > > > > >> > >> >> > use builtin_platform_driver_probe() because it doesn't retry after probe
> > > > > > > >> > >> >> > deferral. Convert it to builtin_platform_driver().
> > > > > > > >> > >> >>
> > > > > > > >> > >> >> If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> > > > > > > >> > >> >> shouldn't it be fixed or removed?
> > > > > > > >> > >> >
> > > > > > > >> > >> > I was actually thinking about this too. The problem with fixing
> > > > > > > >> > >> > builtin_platform_driver_probe() to behave like
> > > > > > > >> > >> > builtin_platform_driver() is that these probe functions could be
> > > > > > > >> > >> > marked with __init. But there are also only 20 instances of
> > > > > > > >> > >> > builtin_platform_driver_probe() in the kernel:
> > > > > > > >> > >> > $ git grep ^builtin_platform_driver_probe | wc -l
> > > > > > > >> > >> > 20
> > > > > > > >> > >> >
> > > > > > > >> > >> > So it might be easier to just fix them to not use
> > > > > > > >> > >> > builtin_platform_driver_probe().
> > > > > > > >> > >> >
> > > > > > > >> > >> > Michael,
> > > > > > > >> > >> >
> > > > > > > >> > >> > Any chance you'd be willing to help me by converting all these to
> > > > > > > >> > >> > builtin_platform_driver() and delete builtin_platform_driver_probe()?
> > > > > > > >> > >>
> > > > > > > >> > >> If it just moving the probe function to the _driver struct and
> > > > > > > >> > >> remove the __init annotations. I could look into that.
> > > > > > > >> > >
> > > > > > > >> > > Yup. That's pretty much it AFAICT.
> > > > > > > >> > >
> > > > > > > >> > > builtin_platform_driver_probe() also makes sure the driver doesn't ask
> > > > > > > >> > > for async probe, etc. But I doubt anyone is actually setting async
> > > > > > > >> > > flags and still using builtin_platform_driver_probe().
> > > > > > > >> >
> > > > > > > >> > Hasn't module_platform_driver_probe() the same problem? And there
> > > > > > > >> > are ~80 drivers which uses that.
> > > > > > > >>
> > > > > > > >> Yeah. The biggest problem with all of these is the __init markers.
> > > > > > > >> Maybe some familiar with coccinelle can help?
> > > > > > > >
> > > > > > > > And dropping them will increase memory usage.
> > > > > > >
> > > > > > > Although I do have the changes for the builtin_platform_driver_probe()
> > > > > > > ready, I don't think it makes much sense to send these unless we agree
> > > > > > > on the increased memory footprint. While there are just a few
> > > > > > > builtin_platform_driver_probe() and memory increase _might_ be
> > > > > > > negligible, there are many more module_platform_driver_probe().
> > > > > >
> > > > > > While it's good to drop code that'll not be used past kernel init, the
> > > > > > module_platform_driver_probe() is going even more extreme. It doesn't
> > > > > > even allow deferred probe (well before kernel init is done). I don't
> > > > > > think that behavior is right and that's why we should delete it. Also,
> > > > >
> > > > > This construct is typically used for builtin hardware for which the
> > > > > dependencies are registered very early, and thus known to probe at
> > > > > first try (if present).
> > > > >
> > > > > > I doubt if any of these probe functions even take up 4KB of memory.
> > > > >
> > > > > How many 4 KiB pages do you have in a system with 10 MiB of SRAM?
> > > > > How many can you afford to waste?
> > > >
> > > > There are only a few instances of this macro in the kernel. How many
> > >
> > > $ git grep -lw builtin_platform_driver_probe | wc -l
> > > 21
> > > $ git grep -lw module_platform_driver_probe | wc -l
> > > 86
> > >
> > > + the ones that haven't been converted to the above yet:
> > >
> > > $ git grep -lw platform_driver_probe | wc -l
> > > 58
> > >
> >
> > Yeah, this adds up in terms of the number of places we'd need to fix.
> > But thinking more about it, a couple of points:
> > 1. Not all builtin_platform_driver_probe() are problems for
> > fw_devlink. So we can just fix them as we go if we need to.
> >
> > 2. The problem with builtin_platform_driver_probe() isn't really with
> > the use of __init. It's the fact that it doesn't allow deferred
> > probes. builtin_platform_driver_probe()/platform_driver_probe() could
> > still be fixed up to allow deferred probe until we get to the point
> > where we free the __init section (so at least till late_initcall).
>
> That's intentional: it is used for cases that will (must) never be deferred.
> That's why it's safe to use __init.

So was the usage of builtin_platform_driver_probe() wrong in the
driver Michael fixed? Because, deferring and probing again clearly
works?

Also, "must never be deferred" seems like a weird condition to
enforce. I think the real "rule" is that if it defers, the platform is
not expected to work. But disallowing a probe reattempt seems weird.
What is it going to hurt if it's attempted again? At worst it fails
one more time?

Also, I'd argue that all/most of the "can't defer, but I'm still a
proper struct device" cases are all just patchwork to deal with the
fact we were playing initcall chicken when there was no fw_devlink.
I'm hoping we can move people away from that mindset. And the first
step towards that would be to allow *platform_probe() to allow
deferred probes until late_initcall().


-Saravana
