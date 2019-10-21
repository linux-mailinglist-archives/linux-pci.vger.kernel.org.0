Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF325DE67A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 10:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfJUIcU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 04:32:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37889 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfJUIcU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 04:32:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id d140so6021251oib.5;
        Mon, 21 Oct 2019 01:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJAYpa2bhszyki3uXA9fl9DpxT/CCBElDOsA89p+Fjo=;
        b=i/meOHyGG6/+uKLTscXM0GmIdS1MjxlQXPNJ8oRKhpWErLmPKCEeR1k0lcNLLwNP1y
         v8yrRKsQoSfgHbYG2Py/RO8oOdncP/skAeTr954Kt7wFA415rGpGShpqdiL9HmxIkY39
         xdsZRwzo8J8mzuk11cwdZH/r3F3IbWvTPbFaMucGtLhe2rvndvN7Va8gwExUp2n8v/w7
         O7eTbLIcIBtzcnQ9EI9/5XYPdL8o/Jx3OAK8hH/S1VZgEKg8YeFmJqzbP/8qXFpvwXdR
         Kgw7DRq4NL1EkTHyfIhV/m0HOvNaxfiIGQ5A6Aq/4idFtuTSsAPOpkDDEKbyguwzI7XF
         VllA==
X-Gm-Message-State: APjAAAUwWlFiL/z9gX0OeuB1gXnBxbh/nUE33lw4/XkxJYVpn//16b3H
        SBq0u+QRrWS8nW60Vqv8SycxqmV9Bsz2si5t0u1idlIY
X-Google-Smtp-Source: APXvYqwMGS14UHYlm0ovGK8AzJc3U9hN1hRZvGBuKUtMi9/haSuOYSZlypOsMJWI5fGq9fB4a4WgHynr5Ef/P0mfT64=
X-Received: by 2002:a54:4e89:: with SMTP id c9mr17120098oiy.148.1571646738841;
 Mon, 21 Oct 2019 01:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
 <88099c4f-4fb4-626e-f66f-3eb8861dfb2c@gmail.com> <CAL_JsqLzmk5dfn0Re3y7VjY5ehE29vKLOV-2tM5B_jPbB2YiPQ@mail.gmail.com>
 <06d093b2-dcc2-a01f-fce0-5db0bc47325e@gmail.com> <CAMuHMdXjZs6Gvar3o7wXd2-1tkPtpt3qxZLG5vzDfrCG4d9SeQ@mail.gmail.com>
 <ca16e883-27d3-2cd0-7d71-fa9b169dcccd@gmail.com> <ccf8a4f9-1758-bafc-797c-714f06810db3@arm.com>
 <6af92fb1-a154-3e03-d239-0417da5a5094@gmail.com> <CAL_JsqKEjzO3s=bBf_TxTAXTzLTcX=8ccFXLfowhPOHWzNET9A@mail.gmail.com>
 <5a19fcd3-2071-334a-1c4a-59d07f4a387d@gmail.com> <20191018095345.GD25918@e121166-lin.cambridge.arm.com>
 <fd53f532-9b78-a64e-6d34-bda5a7639586@gmail.com> <ce7d16ab-31b8-0992-b1d7-24f4a652ce5f@arm.com>
 <3f2f3868-676c-edc4-0de1-d42b63186128@gmail.com> <931e7132-b680-3e9a-bb1e-af05811907fc@arm.com>
 <32591ef7-9792-4874-512c-ce3bcc3e9998@gmail.com> <9db05950-cb22-c99d-7544-05e148ef7e1a@arm.com>
 <6ae07b1a-bcfa-e48a-e260-da20d6663afc@gmail.com>
In-Reply-To: <6ae07b1a-bcfa-e48a-e260-da20d6663afc@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Oct 2019 10:32:07 +0200
Message-ID: <CAMuHMdVC_woCNfD8-etah2ADq_uh6rWetBK7O+OtE9xF+7bQ6w@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound dma-ranges
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

On Fri, Oct 18, 2019 at 9:03 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 10/18/19 7:35 PM, Robin Murphy wrote:
> > On 18/10/2019 17:44, Marek Vasut wrote:
> >> On 10/18/19 5:44 PM, Robin Murphy wrote:
> >>> On 18/10/2019 15:26, Marek Vasut wrote:
> >>>> On 10/18/19 2:53 PM, Robin Murphy wrote:
> >>>>> On 18/10/2019 13:22, Marek Vasut wrote:
> >>>>>> On 10/18/19 11:53 AM, Lorenzo Pieralisi wrote:
> >>>>>>> On Thu, Oct 17, 2019 at 05:01:26PM +0200, Marek Vasut wrote:
> >>>>>>>
> >>>>>>> [...]
> >>>>>>>
> >>>>>>>>> Again, just handling the first N dma-ranges entries and
> >>>>>>>>> ignoring the
> >>>>>>>>> rest is not 'configure the controller correctly'.
> >>>>>>>>
> >>>>>>>> It's the best effort thing to do. It's well possible the next
> >>>>>>>> generation
> >>>>>>>> of the controller will have more windows, so could accommodate the
> >>>>>>>> whole
> >>>>>>>> list of ranges.
> >>>>>
> >>>>> In the context of DT describing the platform that doesn't make any
> >>>>> sense. It's like saying it's fine for U-Boot to also describe a
> >>>>> bunch of
> >>>>> non-existent CPUs just because future SoCs might have them. Just
> >>>>> because
> >>>>> the system would probably still boot doesn't mean it's right.
> >>>>
> >>>> It's the exact opposite of what you just described -- the last release
> >>>> of U-Boot currently populates a subset of the DMA ranges, not a
> >>>> superset. The dma-ranges in the Linux DT currently are a superset of
> >>>> available DRAM on the platform.
> >>>
> >>> I'm not talking about the overall coverage of addresses - I've already
> >>> made clear what I think about that - I'm talking about the *number* of
> >>> individual entries. If the DT binding defines that dma-ranges entries
> >>> directly represent bridge windows, then the bootloader for a given
> >>> platform should never generate more entries than that platform has
> >>> actual windows, because to do otherwise would be bogus.
> >>
> >> I have a feeling that's not how Rob defined the dma-ranges in this
> >> discussion though.
> >>
> >>>>>>>> Thinking about this further, this patch should be OK either way, if
> >>>>>>>> there is a DT which defines more DMA ranges than the controller can
> >>>>>>>> handle, handling some is better than failing outright -- a PCI
> >>>>>>>> which
> >>>>>>>> works with a subset of memory is better than PCI that does not work
> >>>>>>>> at all.
> >>>>>>>
> >>>>>>> OK to sum it up, this patch is there to deal with u-boot adding
> >>>>>>> multiple
> >>>>>>> dma-ranges to DT.
> >>>>>>
> >>>>>> Yes, this patch was posted over two months ago, about the same time
> >>>>>> this
> >>>>>> functionality was posted for inclusion in U-Boot. It made it into
> >>>>>> recent
> >>>>>> U-Boot release, but there was no feedback on the Linux patch until
> >>>>>> recently.
> >>>>>>
> >>>>>> U-Boot can be changed for the next release, assuming we agree on
> >>>>>> how it
> >>>>>> should behave.
> >>>>>>
> >>>>>>> I still do not understand the benefit given that for
> >>>>>>> DMA masks they are useless as Rob pointed out and ditto for inbound
> >>>>>>> windows programming (given that AFAICS the PCI controller filters
> >>>>>>> out
> >>>>>>> any transaction that does not fall within its inbound windows by
> >>>>>>> default
> >>>>>>> so adding dma-ranges has the net effect of widening the DMA'able
> >>>>>>> address
> >>>>>>> space rather than limiting it).
> >>>>>>>
> >>>>>>> In short, what's the benefit of adding more dma-ranges regions to
> >>>>>>> the
> >>>>>>> DT (and consequently handling them in the kernel) ?
> >>>>>>
> >>>>>> The benefit is programming the controller inbound windows correctly.
> >>>>>> But if there is a better way to do that, I am open to implement that.
> >>>>>> Are there any suggestions / examples of that ?
> >>>>>
> >>>>> The crucial thing is that once we improve the existing "dma-ranges"
> >>>>> handling in the DMA layer such that it *does* consider multiple
> >>>>> entries
> >>>>> properly, platforms presenting ranges which don't actually exist will
> >>>>> almost certainly start going wrong, and are either going to have to
> >>>>> fix
> >>>>> their broken bootloaders or try to make a case for platform-specific
> >>>>> workarounds in core code.
> >>>> Again, this is exactly the other way around, the dma-ranges
> >>>> populated by
> >>>> U-Boot cover only existing DRAM. The single dma-range in Linux DT
> >>>> covers
> >>>> even the holes without existing DRAM.
> >>>>
> >>>> So even if the Linux dma-ranges handling changes, there should be no
> >>>> problem.
> >>>
> >>> Say you have a single hardware window, and this DT property (1-cell
> >>> numbers for simplicity:
> >>>
> >>>      dma-ranges = <0x00000000 0x00000000 0x80000000>;
> >>>
> >>> Driver reads one entry and programs the window to 2GB@0, DMA setup
> >>> parses the first entry and sets device masks to 0x7fffffff, and
> >>> everything's fine.
> >>>
> >>> Now say we describe the exact same address range this way instead:
> >>>
> >>>      dma-ranges = <0x00000000 0x00000000 0x40000000,
> >>>                0x40000000 0x40000000 0x40000000>;
> >>>
> >>> Driver reads one entry and programs the window to 1GB@0, DMA setup
> >>> parses the first entry and sets device masks to 0x3fffffff, and *today*,
> >>> things are suboptimal but happen to work.
> >>>
> >>> Now say we finally get round to fixing the of_dma code to properly
> >>> generate DMA masks that actually include all usable address bits, a user
> >>> upgrades their kernel package, and reboots with that same DT...
> >>>
> >>> Driver reads one entry and programs the window to 1GB@0, DMA setup
> >>> parses all entries and sets device masks to 0x7fffffff, devices start
> >>> randomly failing or throwing DMA errors half the time, angry user looks
> >>> at the changelog to find that somebody decided their now-corrupted
> >>> filesystem is less important than the fact that hey, at least the
> >>> machine didn't refuse to boot because the DT was obviously wrong. Are
> >>> you sure that shouldn't be a problem?
> >>
> >> I think you picked a rather special case here and arrived as a DMA mask
> >> which just fails in this special case. Such special case doesn't happen
> >> here, and even if it did, I would expect Linux to merge those two ranges
> >> or do something sane ? If the DMA mask is set incorrectly, that's a bug
> >> of the DMA code I would think.
> >
> > The mask is not set incorrectly - DMA masks represent the number of
> > address bits the device (or intermediate interconnect in the case of the
> > bus mask) is capable of driving. Thus when DMA is limited to a specific
> > address range, the masks should be wide enough to cover the topmost
> > address of that range (unless the device's own capability is inherently
> > narrower).
>
> Then the mask should be 0x7fffffff in both cases I'd say.
>
> >> What DMA mask would you get if those two entries had a gap inbetween
> >> them ? E.g.:
> >>
> >>   dma-ranges = <0x00000000 0x00000000 0x20000000,
> >>                 0x40000000 0x40000000 0x20000000>;
> >
> > OK, here's an real non-simplified example
>
> I would really like an answer to the simple example above before we
> start inventing convoluted ones.

I'd say that depends on the actual memory configuration, i.e. does memory
exist in the gap? Does memory exist above 0x5fffffff?

BTW, reading Devicetree Specification, Release v0.2: dma-ranges
describes bus address space translation; it does not describe if the
full address space is backed by physical RAM (see the /memory node).
Hence if there's no memory in the gap, I see no reason to have 2 entries
in dma-ranges, as the translation offsets are the same, so they could be
covered by a single larger entry.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
