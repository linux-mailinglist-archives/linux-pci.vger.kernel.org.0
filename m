Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC302D98EB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 20:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfJPSNM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 14:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfJPSNL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 14:13:11 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C32721D7A;
        Wed, 16 Oct 2019 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571249590;
        bh=BY+VuvMUkb8ysqC8cdpa2CLescffGaPMHGOSjrsEPXE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tYuhgV6HJ1mAxdk/Oad1XfawD7aPlvC9ohkBwp6PWKhtnXBSxTXto0ocYdNiqcCNZ
         9Nk6/lkPazM2TbrkfTLM4jsqGGQyxcFGU95wT61ZXua01pdjGCtoT3K059aJGofMec
         YNliNvgThPUCazyJ7WvculTkRbMV0cpoHCg3urdM=
Received: by mail-qt1-f182.google.com with SMTP id u40so37445378qth.11;
        Wed, 16 Oct 2019 11:13:10 -0700 (PDT)
X-Gm-Message-State: APjAAAXwllbCMM6Cc+DVZXUrQRzR9rQqKI1PqlEYoPMvmZin+jCe+2Aw
        I1g0paV5VRfoqea++uHUTHiwvkXBi3O3IKmPRg==
X-Google-Smtp-Source: APXvYqy2sCZSuxBPCbz3Ga54d5TWhT+Ze7dsRkGs0H8BtnijPV7jfkAGFPEzWBIRBfIfsu1KgrB4+Ukl/ps1gMHVjKE=
X-Received: by 2002:ac8:19f4:: with SMTP id s49mr46376758qtk.136.1571249589593;
 Wed, 16 Oct 2019 11:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190809175741.7066-1-marek.vasut@gmail.com> <20190809175741.7066-2-marek.vasut@gmail.com>
 <20191016150001.GA7457@e121166-lin.cambridge.arm.com> <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
 <20191016152601.GB7457@e121166-lin.cambridge.arm.com> <75fb3519-80eb-fec2-d3eb-cc1b884fef25@gmail.com>
 <20191016161846.GC7457@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191016161846.GC7457@e121166-lin.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 16 Oct 2019 13:12:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL2c-ODMkOo1tAJh8JeF0VRXahCq2zF2fX8dZV8wpQj+Q@mail.gmail.com>
Message-ID: <CAL_JsqL2c-ODMkOo1tAJh8JeF0VRXahCq2zF2fX8dZV8wpQj+Q@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound dma-ranges
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
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

On Wed, Oct 16, 2019 at 11:18 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> [+RobH, Robin]
>
> On Wed, Oct 16, 2019 at 05:29:50PM +0200, Marek Vasut wrote:
>
> [...]
>
> > >> The firmware provides all the ranges which are available and usable,
> > >> that's the hardware description and that should be in the DT.
> > >
> > > If the HW (given that those dma-ranges are declared for the PCI host
> > > controller) can't be programmed to enable those DMA ranges - those
> > > ranges are neither available nor usable, ergo DT is broken.
> >
> > The hardware can be programmed to enable those DMA ranges, just not all
> > of them at the same time.
>
> Ok, we are down to DT bindings interpretation then.
>
> > It's not the job of the bootloader to guess which ranges might the next
> > stage like best.
>
> By the time this series:
>
> https://patchwork.ozlabs.org/user/todo/linux-pci/?series=132419
>
> is merged, your policy will require the host controller driver to
> remove the DMA ranges that could not be programmed in the inbound
> address decoders from the dma_ranges list, otherwise things will
> fall apart.

I don't think the above series has too much impact on this. It's my
other series dealing with dma masks that's relevant because for dma
masks we only ever look at the first dma-ranges entry. We either have
to support multiple addresses and sizes per device (the only way to
really support any possible dma-ranges), merge entries to single
offset/mask or have some way to select which range entry to use.

So things are broken to some extent regardless unless MAX_NR_INBOUND_MAPS == 1.

> > >> The firmware cannot decide the policy for the next stage (Linux in
> > >> this case) on which ranges are better to use for Linux and which are
> > >> less good. Linux can then decide which ranges are best suited for it
> > >> and ignore the other ones.
> > >
> > > dma-ranges is a property that is used by other kernel subsystems eg
> > > IOMMU other than the RCAR host controller driver. The policy, provided
> > > there is one should be shared across them. You can't leave a PCI
> > > host controller half-programmed and expect other subsystems (that
> > > *expect* those ranges to be DMA'ble) to work.
> > >
> > > I reiterate my point: if firmware is broken it is better to fail
> > > the probe rather than limp on hoping that things will keep on
> > > working.
> >
> > But the firmware is not broken ?
>
> See above, it depends on how the dma-ranges property is interpreted,
> hopefully we can reach consensus in this thread, I won't merge a patch
> that can backfire later unless we all agree that what it does is
> correct.

Defining more dma-ranges entries than the h/w has inbound windows for
sounds like a broken DT to me.

What exactly does dma-ranges contain in this case? I'm not really
visualizing how different clients would pick different dma-ranges
entries.

Rob
