Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1828DDA5F3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 09:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407893AbfJQHGl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 03:06:41 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36646 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390955AbfJQHGl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 03:06:41 -0400
Received: by mail-oi1-f194.google.com with SMTP id k20so1271323oih.3;
        Thu, 17 Oct 2019 00:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoD1gXkj+uPMIphVtiMiHHjtVVnPOV5pbUQpup2Dm88=;
        b=igHSdA4Ffc4Gjzfrwoh93Mvff9d663pIb+CJB+bCvWDlED1V812vOfgG+dXgFC7tWe
         dT4WMexUr5FCYskuyrWLuAIktBFRlrNiLyMvtDOOlB+5k8oaqEKIFz5/xOGccllErEnS
         DXqP/Ld/r6c6nFIoWmVZ7txx39aNOqCC1yp4po3jiZHyK/8CCKZTQdAhejFeKF84jEUu
         6xzVhzSrHrLnyiBS2m1zTK+orbgre4LTbPFFevsDdmI6pG/NwGbWkywSOM87aof81UFg
         5hQSU5HXAIc6Rsh90zSKjIj5q7I01QjZDjy659iLxiJLPnermdE3lgrdyibIZYhKPx4V
         CGcA==
X-Gm-Message-State: APjAAAWaRqnxzF3Y5unmDJJgH9JVgXYqV8d/iXye54wbNrDCiQBLOJE/
        PJ5mOiCcXpojJvzZiM6ToLhKlnnQHJ5yvcmDdWo=
X-Google-Smtp-Source: APXvYqzZmWn3+8+jVAxbGVbbCLoMzjLUyXAtK0iQE7uBrkB/Ncm7aDk4fidFX4vitEUvMniLlyCcchkRFpMM6N14+Ug=
X-Received: by 2002:a05:6808:3b4:: with SMTP id n20mr1852668oie.131.1571295998827;
 Thu, 17 Oct 2019 00:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190809175741.7066-1-marek.vasut@gmail.com> <20190809175741.7066-2-marek.vasut@gmail.com>
 <20191016150001.GA7457@e121166-lin.cambridge.arm.com> <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
 <20191016152601.GB7457@e121166-lin.cambridge.arm.com> <75fb3519-80eb-fec2-d3eb-cc1b884fef25@gmail.com>
 <20191016161846.GC7457@e121166-lin.cambridge.arm.com> <CAL_JsqL2c-ODMkOo1tAJh8JeF0VRXahCq2zF2fX8dZV8wpQj+Q@mail.gmail.com>
 <c835701d-ff0e-f1b8-af16-fe53febe5519@gmail.com> <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
 <88099c4f-4fb4-626e-f66f-3eb8861dfb2c@gmail.com> <CAL_JsqLzmk5dfn0Re3y7VjY5ehE29vKLOV-2tM5B_jPbB2YiPQ@mail.gmail.com>
 <06d093b2-dcc2-a01f-fce0-5db0bc47325e@gmail.com>
In-Reply-To: <06d093b2-dcc2-a01f-fce0-5db0bc47325e@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Oct 2019 09:06:27 +0200
Message-ID: <CAMuHMdXjZs6Gvar3o7wXd2-1tkPtpt3qxZLG5vzDfrCG4d9SeQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound dma-ranges
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
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

Hi Marek,

On Thu, Oct 17, 2019 at 12:33 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 10/17/19 12:26 AM, Rob Herring wrote:
> [...]
> >>>> You can have multiple non-continuous DRAM banks for example. And an
> >>>> entry for SRAM optionally. Each DRAM bank and/or the SRAM should have a
> >>>> separate dma-ranges entry, right ?
> >>>
> >>> Not necessarily. We really only want to define the minimum we have to.
> >>> The ideal system is no dma-ranges. Is each bank at a different
> >>> relative position compared to the CPU's view of the system. That would
> >>> seem doubtful for just DRAM banks. Perhaps DRAM and SRAM could change.
> >>
> >> Is that a question ? Anyway, yes, there is a bit of DRAM below the 32bit
> >> boundary and some more above the 32bit boundary. These two banks don't
> >> need to be continuous. And then you could add the SRAM into the mix.
> >
> > Continuous is irrelevant. My question was in more specific terms is
> > (bank1 addr - bank0 addr) different for CPU's view (i.e phys addr) vs.
> > PCI host view (i.e. bus addr)? If not, then that is 1 translation and
> > 1 dma-ranges entry.
>
> I don't think it's different in that aspect. Except the bus has this
> 32bit limitation, where it only sees subset of the DRAM.
>
> Why should the DMA ranges incorrectly cover also the DRAM which is not
> present ?
>
> >>> I suppose if your intent is to use inbound windows as a poor man's
> >>> IOMMU to prevent accesses to the holes, then yes you would list them
> >>> out. But I think that's wrong and difficult to maintain. You'd also
> >>> need to deal with reserved-memory regions too.
> >>
> >> What's the problem with that? The bootloader has all that information
> >> and can patch the DT correctly. In fact, in my specific case, I have
> >> platform which can be populated with differently sized DRAM, so the
> >> holes are also dynamically calculated ; there is no one DT then, the
> >> bootloader is responsible to generate the dma-ranges accordingly.
> >
> > The problems are it doesn't work:
> >
> > Your dma-mask and offset are not going to be correct.
> >
> > You are running out of inbound windows. Your patch does nothing to
> > solve that. The solution would be merging multiple dma-ranges entries
> > to a single inbound window. We'd have to do that both for dma-mask and
> > inbound windows. The former would also have to figure out which
> > entries apply to setting up dma-mask. I'm simply suggesting just do
> > that up front and avoid any pointless splits.
>
> But then the PCI device can trigger a transaction to non-existent DRAM
> and cause undefined behavior. Surely we do not want that ?

The PCI device will trigger transactions to memory only when instructed
to do so by Linux, right?  Hence if Linux takes into account chosen/memory
and dma-ranges, there is no problem?

> > You are setting up random inbound windows. The bootloader can't assume
> > what order the OS parses dma-ranges, and the OS can't assume what
> > order the bootloader writes the entries.
>
> But the OS can assume the ranges are correct and cover only valid
> memory, right ? That is, memory into which the PCI controller can safely
> access.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
