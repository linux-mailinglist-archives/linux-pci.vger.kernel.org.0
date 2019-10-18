Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E624DC1E3
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 11:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389363AbfJRJyM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 05:54:12 -0400
Received: from [217.140.110.172] ([217.140.110.172]:60334 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2389081AbfJRJyM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 05:54:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38B4A494;
        Fri, 18 Oct 2019 02:53:49 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A24F3F6C4;
        Fri, 18 Oct 2019 02:53:47 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:53:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        PCI <linux-pci@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
Message-ID: <20191018095345.GD25918@e121166-lin.cambridge.arm.com>
References: <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
 <88099c4f-4fb4-626e-f66f-3eb8861dfb2c@gmail.com>
 <CAL_JsqLzmk5dfn0Re3y7VjY5ehE29vKLOV-2tM5B_jPbB2YiPQ@mail.gmail.com>
 <06d093b2-dcc2-a01f-fce0-5db0bc47325e@gmail.com>
 <CAMuHMdXjZs6Gvar3o7wXd2-1tkPtpt3qxZLG5vzDfrCG4d9SeQ@mail.gmail.com>
 <ca16e883-27d3-2cd0-7d71-fa9b169dcccd@gmail.com>
 <ccf8a4f9-1758-bafc-797c-714f06810db3@arm.com>
 <6af92fb1-a154-3e03-d239-0417da5a5094@gmail.com>
 <CAL_JsqKEjzO3s=bBf_TxTAXTzLTcX=8ccFXLfowhPOHWzNET9A@mail.gmail.com>
 <5a19fcd3-2071-334a-1c4a-59d07f4a387d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a19fcd3-2071-334a-1c4a-59d07f4a387d@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 17, 2019 at 05:01:26PM +0200, Marek Vasut wrote:

[...]

> > Again, just handling the first N dma-ranges entries and ignoring the
> > rest is not 'configure the controller correctly'.
> 
> It's the best effort thing to do. It's well possible the next generation
> of the controller will have more windows, so could accommodate the whole
> list of ranges.
> 
> Thinking about this further, this patch should be OK either way, if
> there is a DT which defines more DMA ranges than the controller can
> handle, handling some is better than failing outright -- a PCI which
> works with a subset of memory is better than PCI that does not work at all.

OK to sum it up, this patch is there to deal with u-boot adding multiple
dma-ranges to DT. I still do not understand the benefit given that for
DMA masks they are useless as Rob pointed out and ditto for inbound
windows programming (given that AFAICS the PCI controller filters out
any transaction that does not fall within its inbound windows by default
so adding dma-ranges has the net effect of widening the DMA'able address
space rather than limiting it).

In short, what's the benefit of adding more dma-ranges regions to the
DT (and consequently handling them in the kernel) ?

Thanks,
Lorenzo

> >>> And realistically, if the address
> >>> isn't valid then it's not going to make much difference anyway - in
> >>> probably 99% of cases, either the transaction doesn't hit a window and
> >>> the host bridge returns a completer abort, or it does hit a window, the
> >>> AXI side returns DECERR or SLVERR, and the host bridge translates that
> >>> into a completer abort. Consider also that many PCI IPs don't have
> >>> discrete windows and just map the entirety of PCI mem space directly to
> >>> the system PA space.
> >>
> >> And in that 1% of cases, we are OK with failure which could have been
> >> easily prevented if the controller was programmed correctly ? That does
> >> not look like a good thing.
> > 
> > You don't need dma-ranges if you want to handle holes in DRAM. Use
> > memblock to get this information. Then it will work if you boot using
> > UEFI too.
> 
> Do you have any further details about this ?
> 
> > dma-ranges at the PCI bridge should be restrictions in the PCI bridge,
> > not ones somewhere else in the system.
> 
> -- 
> Best regards,
> Marek Vasut
