Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6197DC28D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 12:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbfJRKRv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 06:17:51 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41209 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388560AbfJRKRv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2019 06:17:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id g81so4748869oib.8;
        Fri, 18 Oct 2019 03:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEwwsfk1SyiFEq1Fvt999kx3eJMiwdoczC+MTi8SsI0=;
        b=fdoPIsGzObkQpCzuC5dPtHMxNipIrEvRUjsye8ZJgxPs6WK0XUjwNIldFYvZ1hw776
         FLU4iwoJ1pYQOtqgnOlJgujmma5X1e/cJIDZzd+tlXw4J9KceMzquzUS22mZtJb6RXTx
         lvDwzxJNIeG35PN7YDrx2Xoe3mWxFXD1UKbS3m6/YulKmJyehytzakIAXXDzxOtQXrPC
         fDgTiZQjtXGXPSwGrbcjPQQaO+Qt9zutISiLjx1vQwXbGRK7b17kGT7cSfS/Nno938Au
         95udJOVFiji2y1KJnWTQl9YEjxwNtCelDBxh8LI5MWkekqItuaH/pCxQ5UNN/rTeIDr/
         sLDA==
X-Gm-Message-State: APjAAAUQsGYITgAeamyRe3r3VTE+JeAd/nq4sWH4SR3C7vyB4AisAZhY
        72YBPyWHIKWnKK3qPGlZhxX967ajG8Qo29rT188=
X-Google-Smtp-Source: APXvYqySEP5QO8Z4n1gpQC88jztS8lshEglNkce+JQcSV16ojD4EbAnp+iETJp3JI8s4ZXYUtWNtb3AFJk/2Y01VObs=
X-Received: by 2002:aca:230c:: with SMTP id e12mr6899373oie.153.1571393870628;
 Fri, 18 Oct 2019 03:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
 <20191016152601.GB7457@e121166-lin.cambridge.arm.com> <75fb3519-80eb-fec2-d3eb-cc1b884fef25@gmail.com>
 <20191016161846.GC7457@e121166-lin.cambridge.arm.com> <CAL_JsqL2c-ODMkOo1tAJh8JeF0VRXahCq2zF2fX8dZV8wpQj+Q@mail.gmail.com>
 <c835701d-ff0e-f1b8-af16-fe53febe5519@gmail.com> <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
 <88099c4f-4fb4-626e-f66f-3eb8861dfb2c@gmail.com> <CAL_JsqLzmk5dfn0Re3y7VjY5ehE29vKLOV-2tM5B_jPbB2YiPQ@mail.gmail.com>
 <06d093b2-dcc2-a01f-fce0-5db0bc47325e@gmail.com> <20191018100655.GA47056@e119886-lin.cambridge.arm.com>
In-Reply-To: <20191018100655.GA47056@e119886-lin.cambridge.arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Oct 2019 12:17:38 +0200
Message-ID: <CAMuHMdUf6uH_64R9hOgFgmoUYWk_LkCxy9RLzV0Je=TFr-G87w@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound dma-ranges
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On Fri, Oct 18, 2019 at 12:07 PM Andrew Murray <andrew.murray@arm.com> wrote:
> On Thu, Oct 17, 2019 at 12:33:24AM +0200, Marek Vasut wrote:
> > On 10/17/19 12:26 AM, Rob Herring wrote:
> > [...]
> > >>>> You can have multiple non-continuous DRAM banks for example. And an
> > >>>> entry for SRAM optionally. Each DRAM bank and/or the SRAM should have a
> > >>>> separate dma-ranges entry, right ?
> > >>>
> > >>> Not necessarily. We really only want to define the minimum we have to.
> > >>> The ideal system is no dma-ranges. Is each bank at a different
> > >>> relative position compared to the CPU's view of the system. That would
> > >>> seem doubtful for just DRAM banks. Perhaps DRAM and SRAM could change.
> > >>
> > >> Is that a question ? Anyway, yes, there is a bit of DRAM below the 32bit
> > >> boundary and some more above the 32bit boundary. These two banks don't
> > >> need to be continuous. And then you could add the SRAM into the mix.
> > >
> > > Continuous is irrelevant. My question was in more specific terms is
> > > (bank1 addr - bank0 addr) different for CPU's view (i.e phys addr) vs.
> > > PCI host view (i.e. bus addr)? If not, then that is 1 translation and
> > > 1 dma-ranges entry.
> >
> > I don't think it's different in that aspect. Except the bus has this
> > 32bit limitation, where it only sees subset of the DRAM.
> >
> > Why should the DMA ranges incorrectly cover also the DRAM which is not
> > present ?
>
> I think this is where there is a difference in understanding.
>
> If I understand correctly, the job of the dma-ranges property isn't to
> describe *what* ranges the PCI device can access - it's there to describe
> *how*, i.e. the mapping between PCI and CPU-visible memory.
>
> The dma-ranges property is a side-effect of how the busses are wired up
> between the CPU and PCI controller - and so it doesn't matter what is or
> isn't on those buses.
>
> It's the job of other parts of the system to ensure that PCI devices are
> told the correct addresses to write to, e.g. the enumerating software
> referring to a valid CPU visible address correctly translated for the view
> of the PCI device, ATS etc. And any IOMMU to enforce that.

Yep, that's what I thought, too.

> It sounds like there is a 1:1 mapping between CPU and PCI - in which case
> there isn't a reason for a dma-ranges.

There's still the 32-bit limitation: PCI devices can access low 32-bit addresses
only.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
