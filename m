Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 040BFDA181
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 00:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfJPW0a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 18:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbfJPW03 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 18:26:29 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 685AD21925;
        Wed, 16 Oct 2019 22:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571264788;
        bh=NO4l/JZzXVd4jodbH3MBzuZnfblJK4K+fcrlboEbjb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ATJ+IaG+hLcfE6aY/nTpUbKlzKs175mbsxcLorhPpeTiCIvow3du9snJFR2rXNGqp
         /3aVCBWmz2pHVXXws900371+TknAr1LHjJK6CyzEsW46p8+fknrUadEy0VrvaS3OqX
         4CRnbO8juEDa8B8heuQ1wF6wrcuySrM/aye0ryFo=
Received: by mail-qt1-f182.google.com with SMTP id v52so506074qtb.8;
        Wed, 16 Oct 2019 15:26:28 -0700 (PDT)
X-Gm-Message-State: APjAAAU58y9T6ydRpz3et6PpwNc7jUM/swTT9kAP8GS46vNygRCyxjWc
        MYAeK/JIvStPlksVC41ustv9xto9xSw0qZPRZQ==
X-Google-Smtp-Source: APXvYqyah6ORYx/EqF9LwWzNPDJU/0drZ1tHJzfF+wXl541gBVWMJoSl0kPCvWwXcu7ZPZHMP6eISsagHw3h8wzID+g=
X-Received: by 2002:ac8:6782:: with SMTP id b2mr458190qtp.143.1571264787528;
 Wed, 16 Oct 2019 15:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190809175741.7066-1-marek.vasut@gmail.com> <20190809175741.7066-2-marek.vasut@gmail.com>
 <20191016150001.GA7457@e121166-lin.cambridge.arm.com> <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
 <20191016152601.GB7457@e121166-lin.cambridge.arm.com> <75fb3519-80eb-fec2-d3eb-cc1b884fef25@gmail.com>
 <20191016161846.GC7457@e121166-lin.cambridge.arm.com> <CAL_JsqL2c-ODMkOo1tAJh8JeF0VRXahCq2zF2fX8dZV8wpQj+Q@mail.gmail.com>
 <c835701d-ff0e-f1b8-af16-fe53febe5519@gmail.com> <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
 <88099c4f-4fb4-626e-f66f-3eb8861dfb2c@gmail.com>
In-Reply-To: <88099c4f-4fb4-626e-f66f-3eb8861dfb2c@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 16 Oct 2019 17:26:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLzmk5dfn0Re3y7VjY5ehE29vKLOV-2tM5B_jPbB2YiPQ@mail.gmail.com>
Message-ID: <CAL_JsqLzmk5dfn0Re3y7VjY5ehE29vKLOV-2tM5B_jPbB2YiPQ@mail.gmail.com>
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

On Wed, Oct 16, 2019 at 4:16 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>
> On 10/16/19 10:25 PM, Rob Herring wrote:
> [...]
> >>>>>>> The firmware cannot decide the policy for the next stage (Linux in
> >>>>>>> this case) on which ranges are better to use for Linux and which are
> >>>>>>> less good. Linux can then decide which ranges are best suited for it
> >>>>>>> and ignore the other ones.
> >>>>>>
> >>>>>> dma-ranges is a property that is used by other kernel subsystems eg
> >>>>>> IOMMU other than the RCAR host controller driver. The policy, provided
> >>>>>> there is one should be shared across them. You can't leave a PCI
> >>>>>> host controller half-programmed and expect other subsystems (that
> >>>>>> *expect* those ranges to be DMA'ble) to work.
> >>>>>>
> >>>>>> I reiterate my point: if firmware is broken it is better to fail
> >>>>>> the probe rather than limp on hoping that things will keep on
> >>>>>> working.
> >>>>>
> >>>>> But the firmware is not broken ?
> >>>>
> >>>> See above, it depends on how the dma-ranges property is interpreted,
> >>>> hopefully we can reach consensus in this thread, I won't merge a patch
> >>>> that can backfire later unless we all agree that what it does is
> >>>> correct.
> >>>
> >>> Defining more dma-ranges entries than the h/w has inbound windows for
> >>> sounds like a broken DT to me.
> >>>
> >>> What exactly does dma-ranges contain in this case? I'm not really
> >>> visualizing how different clients would pick different dma-ranges
> >>> entries.
> >>
> >> You can have multiple non-continuous DRAM banks for example. And an
> >> entry for SRAM optionally. Each DRAM bank and/or the SRAM should have a
> >> separate dma-ranges entry, right ?
> >
> > Not necessarily. We really only want to define the minimum we have to.
> > The ideal system is no dma-ranges. Is each bank at a different
> > relative position compared to the CPU's view of the system. That would
> > seem doubtful for just DRAM banks. Perhaps DRAM and SRAM could change.
>
> Is that a question ? Anyway, yes, there is a bit of DRAM below the 32bit
> boundary and some more above the 32bit boundary. These two banks don't
> need to be continuous. And then you could add the SRAM into the mix.

Continuous is irrelevant. My question was in more specific terms is
(bank1 addr - bank0 addr) different for CPU's view (i.e phys addr) vs.
PCI host view (i.e. bus addr)? If not, then that is 1 translation and
1 dma-ranges entry.

> > I suppose if your intent is to use inbound windows as a poor man's
> > IOMMU to prevent accesses to the holes, then yes you would list them
> > out. But I think that's wrong and difficult to maintain. You'd also
> > need to deal with reserved-memory regions too.
>
> What's the problem with that? The bootloader has all that information
> and can patch the DT correctly. In fact, in my specific case, I have
> platform which can be populated with differently sized DRAM, so the
> holes are also dynamically calculated ; there is no one DT then, the
> bootloader is responsible to generate the dma-ranges accordingly.

The problems are it doesn't work:

Your dma-mask and offset are not going to be correct.

You are running out of inbound windows. Your patch does nothing to
solve that. The solution would be merging multiple dma-ranges entries
to a single inbound window. We'd have to do that both for dma-mask and
inbound windows. The former would also have to figure out which
entries apply to setting up dma-mask. I'm simply suggesting just do
that up front and avoid any pointless splits.

You are setting up random inbound windows. The bootloader can't assume
what order the OS parses dma-ranges, and the OS can't assume what
order the bootloader writes the entries.

Rob
