Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29954DB02B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 16:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403783AbfJQOgW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 10:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfJQOgW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 10:36:22 -0400
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com [209.85.161.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48E2621A4C;
        Thu, 17 Oct 2019 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571322980;
        bh=AG//YUCWsLvuxyKqIU2c00YCMG3tBP/YEO0deworjIc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w3RGGxYOH6lkF34Ys+1f4Gwq9K1k/iSnUDZYwkqxFVUAU/2IIf6SM//nmADwMiuKb
         HvyUtvD732jkTO7fZElWn+tUsUJEqQl16cAhMuNTrIOsgqmcH0UI+vhbwpJFmW1865
         KebLArCPuubB8RZaNQzOYHzCPN/e8Chxcg507S+A=
Received: by mail-yw1-f54.google.com with SMTP id n11so938260ywn.6;
        Thu, 17 Oct 2019 07:36:20 -0700 (PDT)
X-Gm-Message-State: APjAAAWz7bAqKh0+1Li6GsmNMMs9L0iZdlBCRosmHCTMR02Wo1TVbqpb
        R5jErhS5HGRKhgZTJM4pXy5BRnrP6gKFxUkYoA==
X-Google-Smtp-Source: APXvYqwtBM/3RWXCdIJDc+WosVIg15qhdSC2/jDk1PkbVTojGA1ZbOMx8shiHhiTG8x721ZN/ZUfKjqu3GKfxr7pE/s=
X-Received: by 2002:a81:748a:: with SMTP id p132mr2952177ywc.174.1571322979480;
 Thu, 17 Oct 2019 07:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190809175741.7066-1-marek.vasut@gmail.com> <20190809175741.7066-2-marek.vasut@gmail.com>
 <20191016150001.GA7457@e121166-lin.cambridge.arm.com> <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
 <20191016152601.GB7457@e121166-lin.cambridge.arm.com> <75fb3519-80eb-fec2-d3eb-cc1b884fef25@gmail.com>
 <20191016161846.GC7457@e121166-lin.cambridge.arm.com> <CAL_JsqL2c-ODMkOo1tAJh8JeF0VRXahCq2zF2fX8dZV8wpQj+Q@mail.gmail.com>
 <c835701d-ff0e-f1b8-af16-fe53febe5519@gmail.com> <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
 <88099c4f-4fb4-626e-f66f-3eb8861dfb2c@gmail.com> <CAL_JsqLzmk5dfn0Re3y7VjY5ehE29vKLOV-2tM5B_jPbB2YiPQ@mail.gmail.com>
 <06d093b2-dcc2-a01f-fce0-5db0bc47325e@gmail.com> <CAMuHMdXjZs6Gvar3o7wXd2-1tkPtpt3qxZLG5vzDfrCG4d9SeQ@mail.gmail.com>
 <ca16e883-27d3-2cd0-7d71-fa9b169dcccd@gmail.com> <ccf8a4f9-1758-bafc-797c-714f06810db3@arm.com>
 <6af92fb1-a154-3e03-d239-0417da5a5094@gmail.com>
In-Reply-To: <6af92fb1-a154-3e03-d239-0417da5a5094@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Oct 2019 09:36:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKEjzO3s=bBf_TxTAXTzLTcX=8ccFXLfowhPOHWzNET9A@mail.gmail.com>
Message-ID: <CAL_JsqKEjzO3s=bBf_TxTAXTzLTcX=8ccFXLfowhPOHWzNET9A@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound dma-ranges
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 17, 2019 at 9:00 AM Marek Vasut <marek.vasut@gmail.com> wrote:
>
> On 10/17/19 3:06 PM, Robin Murphy wrote:
> > On 17/10/2019 11:55, Marek Vasut wrote:
> >> On 10/17/19 9:06 AM, Geert Uytterhoeven wrote:
> >>
> >> [...]
> >>
> >>>>>>> I suppose if your intent is to use inbound windows as a poor man's
> >>>>>>> IOMMU to prevent accesses to the holes, then yes you would list them
> >>>>>>> out. But I think that's wrong and difficult to maintain. You'd also
> >>>>>>> need to deal with reserved-memory regions too.
> >>>>>>
> >>>>>> What's the problem with that? The bootloader has all that information
> >>>>>> and can patch the DT correctly. In fact, in my specific case, I have
> >>>>>> platform which can be populated with differently sized DRAM, so the
> >>>>>> holes are also dynamically calculated ; there is no one DT then, the
> >>>>>> bootloader is responsible to generate the dma-ranges accordingly.
> >>>>>
> >>>>> The problems are it doesn't work:
> >>>>>
> >>>>> Your dma-mask and offset are not going to be correct.
> >>>>>
> >>>>> You are running out of inbound windows. Your patch does nothing to
> >>>>> solve that. The solution would be merging multiple dma-ranges entries
> >>>>> to a single inbound window. We'd have to do that both for dma-mask and
> >>>>> inbound windows. The former would also have to figure out which
> >>>>> entries apply to setting up dma-mask. I'm simply suggesting just do
> >>>>> that up front and avoid any pointless splits.
> >>>>
> >>>> But then the PCI device can trigger a transaction to non-existent DRAM
> >>>> and cause undefined behavior. Surely we do not want that ?
> >>>
> >>> The PCI device will trigger transactions to memory only when instructed
> >>> to do so by Linux, right?  Hence if Linux takes into account
> >>> chosen/memory
> >>> and dma-ranges, there is no problem?
> >>
> >> Unless of course the remote device initiates a transfer. And if the
> >> controller is programmed such that accesses to the missing DRAM in the
> >> holes are not filtered out by the controller, then the controller will
> >> gladly let the transaction through. Do we really want to let this
> >> happen ?
> >
> > If you've got devices making random unsolicited accesses then who's to
> > say they wouldn't also hit valid windows and corrupt memory? If it's
> > happening at all you've already lost.
>
> Not necessarily. If your controller is programmed correctly with just
> the ranges that are valid, then it will filter out at least the accesses
> outside of valid memory. If it is programmed incorrectly, as you
> suggest, then the accesses will go through, causing undefined behavior.
>
> And note that there is such weird buggy PCI hardware. A slightly
> unrelated example are some of the ath9k, which are generating spurious
> MSIs even if they are in legacy PCI IRQ mode. If the controller is
> configured correctly, even those buggy cards work, because it can filter
> the spurious MSIs out. If not, they do not.

How do those devices work on h/w without inbound window configuration
or they don't?

How do the spurious MSIs only go to invalid addresses and not valid addresses?

> That's why I would prefer to configure the controller correctly, not
> just hope that nothing bad will come out of misconfiguring it slightly.

Again, just handling the first N dma-ranges entries and ignoring the
rest is not 'configure the controller correctly'.

> > And realistically, if the address
> > isn't valid then it's not going to make much difference anyway - in
> > probably 99% of cases, either the transaction doesn't hit a window and
> > the host bridge returns a completer abort, or it does hit a window, the
> > AXI side returns DECERR or SLVERR, and the host bridge translates that
> > into a completer abort. Consider also that many PCI IPs don't have
> > discrete windows and just map the entirety of PCI mem space directly to
> > the system PA space.
>
> And in that 1% of cases, we are OK with failure which could have been
> easily prevented if the controller was programmed correctly ? That does
> not look like a good thing.

You don't need dma-ranges if you want to handle holes in DRAM. Use
memblock to get this information. Then it will work if you boot using
UEFI too.

dma-ranges at the PCI bridge should be restrictions in the PCI bridge,
not ones somewhere else in the system.

Rob
