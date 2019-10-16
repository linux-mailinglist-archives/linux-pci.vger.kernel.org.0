Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A35FD9BBF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 22:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437133AbfJPUZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 16:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437132AbfJPUZR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 16:25:17 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27E7221925;
        Wed, 16 Oct 2019 20:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571257516;
        bh=u/lQbBK0D9y384V7sqKF+LSWiN3bMOGEcUVt4GgUVFk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S8HaM970yStTqAtZfxSplcUCHKvSdjCM9VAmQmFF1E61YcJJ/HleTSJWmN74ZeDb+
         BSajjbelqVVInNoYwqnsO0X1SrjmraYNeomz4kjvXKoWZBLp4wkAp/U4rkxzegchPa
         3oV0U9+DAVtVAidyuVMKmCJbL/C+T6/v01d7GMzk=
Received: by mail-qt1-f169.google.com with SMTP id r5so67977qtd.0;
        Wed, 16 Oct 2019 13:25:16 -0700 (PDT)
X-Gm-Message-State: APjAAAX9uLaIdzDqBoLZe1EnJBIpQ6lKJj6IvQIgWICo8arfuIm7wK2X
        riKWiUY6y/oTqriT/+5WvABbkWp2hm21bf+YNw==
X-Google-Smtp-Source: APXvYqwzYar67kr/B0fMQ8jMGkGwzkR3EZpDk6EqYB2Q7LKTgwqqcUtQ5GzGFSi6wSn6tMFPLVwfluMoTIXRQmbwcrc=
X-Received: by 2002:ac8:35ba:: with SMTP id k55mr47628190qtb.110.1571257515296;
 Wed, 16 Oct 2019 13:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190809175741.7066-1-marek.vasut@gmail.com> <20190809175741.7066-2-marek.vasut@gmail.com>
 <20191016150001.GA7457@e121166-lin.cambridge.arm.com> <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
 <20191016152601.GB7457@e121166-lin.cambridge.arm.com> <75fb3519-80eb-fec2-d3eb-cc1b884fef25@gmail.com>
 <20191016161846.GC7457@e121166-lin.cambridge.arm.com> <CAL_JsqL2c-ODMkOo1tAJh8JeF0VRXahCq2zF2fX8dZV8wpQj+Q@mail.gmail.com>
 <c835701d-ff0e-f1b8-af16-fe53febe5519@gmail.com>
In-Reply-To: <c835701d-ff0e-f1b8-af16-fe53febe5519@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 16 Oct 2019 15:25:03 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
Message-ID: <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound dma-ranges
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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

On Wed, Oct 16, 2019 at 1:18 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>
> On 10/16/19 8:12 PM, Rob Herring wrote:
> > On Wed, Oct 16, 2019 at 11:18 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >>
> >> [+RobH, Robin]
> >>
> >> On Wed, Oct 16, 2019 at 05:29:50PM +0200, Marek Vasut wrote:
> >>
> >> [...]
> >>
> >>>>> The firmware provides all the ranges which are available and usable,
> >>>>> that's the hardware description and that should be in the DT.
> >>>>
> >>>> If the HW (given that those dma-ranges are declared for the PCI host
> >>>> controller) can't be programmed to enable those DMA ranges - those
> >>>> ranges are neither available nor usable, ergo DT is broken.
> >>>
> >>> The hardware can be programmed to enable those DMA ranges, just not all
> >>> of them at the same time.
> >>
> >> Ok, we are down to DT bindings interpretation then.
> >>
> >>> It's not the job of the bootloader to guess which ranges might the next
> >>> stage like best.
> >>
> >> By the time this series:
> >>
> >> https://patchwork.ozlabs.org/user/todo/linux-pci/?series=132419
> >>
> >> is merged, your policy will require the host controller driver to
> >> remove the DMA ranges that could not be programmed in the inbound
> >> address decoders from the dma_ranges list, otherwise things will
> >> fall apart.
> >
> > I don't think the above series has too much impact on this. It's my
> > other series dealing with dma masks that's relevant because for dma
> > masks we only ever look at the first dma-ranges entry. We either have
> > to support multiple addresses and sizes per device (the only way to
> > really support any possible dma-ranges), merge entries to single
> > offset/mask or have some way to select which range entry to use.
> >
> > So things are broken to some extent regardless unless MAX_NR_INBOUND_MAPS == 1.
> >
> >>>>> The firmware cannot decide the policy for the next stage (Linux in
> >>>>> this case) on which ranges are better to use for Linux and which are
> >>>>> less good. Linux can then decide which ranges are best suited for it
> >>>>> and ignore the other ones.
> >>>>
> >>>> dma-ranges is a property that is used by other kernel subsystems eg
> >>>> IOMMU other than the RCAR host controller driver. The policy, provided
> >>>> there is one should be shared across them. You can't leave a PCI
> >>>> host controller half-programmed and expect other subsystems (that
> >>>> *expect* those ranges to be DMA'ble) to work.
> >>>>
> >>>> I reiterate my point: if firmware is broken it is better to fail
> >>>> the probe rather than limp on hoping that things will keep on
> >>>> working.
> >>>
> >>> But the firmware is not broken ?
> >>
> >> See above, it depends on how the dma-ranges property is interpreted,
> >> hopefully we can reach consensus in this thread, I won't merge a patch
> >> that can backfire later unless we all agree that what it does is
> >> correct.
> >
> > Defining more dma-ranges entries than the h/w has inbound windows for
> > sounds like a broken DT to me.
> >
> > What exactly does dma-ranges contain in this case? I'm not really
> > visualizing how different clients would pick different dma-ranges
> > entries.
>
> You can have multiple non-continuous DRAM banks for example. And an
> entry for SRAM optionally. Each DRAM bank and/or the SRAM should have a
> separate dma-ranges entry, right ?

Not necessarily. We really only want to define the minimum we have to.
The ideal system is no dma-ranges. Is each bank at a different
relative position compared to the CPU's view of the system. That would
seem doubtful for just DRAM banks. Perhaps DRAM and SRAM could change.

I suppose if your intent is to use inbound windows as a poor man's
IOMMU to prevent accesses to the holes, then yes you would list them
out. But I think that's wrong and difficult to maintain. You'd also
need to deal with reserved-memory regions too.

Rob
