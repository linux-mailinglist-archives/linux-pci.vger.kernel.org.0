Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6120E5FB0
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2019 23:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfJZVGt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Oct 2019 17:06:49 -0400
Received: from foss.arm.com ([217.140.110.172]:50612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbfJZVGt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Oct 2019 17:06:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 763521FB;
        Sat, 26 Oct 2019 14:06:48 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD1AF3F71F;
        Sat, 26 Oct 2019 14:06:47 -0700 (PDT)
Date:   Sat, 26 Oct 2019 22:06:46 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org, Robin.Murphy@arm.com
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
Message-ID: <20191026210645.GB47056@e119886-lin.cambridge.arm.com>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20190816132305.gyyml5r3xsimmoor@verge.net.au>
 <8f1871ed-4820-1985-0090-bb9e2d8803d8@gmail.com>
 <20191021101805.GM47056@e119886-lin.cambridge.arm.com>
 <fef9502f-d51c-b922-afb3-8891267ae6c3@gmail.com>
 <20191026203627.GA47056@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026203627.GA47056@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 26, 2019 at 09:36:28PM +0100, Andrew Murray wrote:
> On Sat, Oct 26, 2019 at 08:03:12PM +0200, Marek Vasut wrote:
> > On 10/21/19 12:18 PM, Andrew Murray wrote:
> > [...]
> > >>>> In case the "dma-ranges" DT property contains either too many ranges
> > >>>> or the range start address is unaligned in such a way that populating
> > >>>> the range into the controller requires multiple entries, a situation
> > >>>> may occur where all ranges cannot be loaded into the controller.
> > >>>>
> > >>>> Currently, the driver refuses to probe in such a situation. Relax this
> > >>>> behavior, load as many ranges as possible and warn if some ranges do
> > >>>> not fit anymore.
> > >>>
> > >>> What is the motivation for relaxing this?
> > >>
> > >> U-Boot can fill the ranges in properly now, the list would be longer in
> > >> such a case and the driver would fail to probe (because the list is
> > >> longer than what the hardware can support).
> > > 
> > > Is this the U-Boot patch you refer to:
> > > 
> > > https://patchwork.ozlabs.org/patch/1129436/
> > 
> > Yes.
> > 
> > > As pci_set_region is called with the same address for PCI and CPU memory
> > > this implies there is a 1:1 mapping - therefore I don't see a need for
> > > multiple mappings for each DRAM bank. (Also if this controller has a
> > > 32 bit limitation, shouldn't this code limit the addresses before calling
> > > pci_set_region?).
> > It would certainly be helpful to know about this dma-ranges detail
> > earlier, this whole thing could've been avoided. Now all I can do is get
> > that patch reverted for the next U-Boot release.
> 
> Yes, I can appreciate the frustration this delay has caused. Though as there
> are now more reviewers for PCI controllers on this list, future patches ought
> to get feedback sooner.
> 
> > 
> > But this still leaves me with one open question -- how do I figure out
> > what to program into the PCI controller inbound windows, so that the
> > controller correctly filters inbound transfers which are targetting
> > nonexisting memory ?
> 
> Your driver should program into the RC->CPU windows, the exact ranges
> described in the dma-ranges. Whilst also respecting the alignment and
> max-size rules your controller has (e.g. the existing upstream logic
> and also the new logic that recalculates the alignment per entry).
> 
> As far as I can tell from looking at your U-Boot patch, I think I'd expect
> a single dma-range to be presented in the DT, that describes
> 0:0xFFFFFFFF => 0:0xFFFFFFFF. This is because 1) I understand your
> controller is limited to 32 bits. And 2) there is a linear mapping between
> PCI and CPU addresses (given that the second and third arguments on
> pci_set_region are both the same).
> 
> As you point out, this range includes lots of things that you don't
> want the RC to touch - such as non-existent memory. This is OK, when
> Linux programs addresses into the various EP's for them to DMA to host
> memory, it uses its own logic to select addresses that are in RAM, the
> purpose of the dma-range is to describe what the CPU RAM address looks
> like from the perspective of the RC (for example if the RC was wired
> with an offset such that made memory writes from the RC made to
> 0x00000000 end up on the system map at 0x80000000, we need to tell Linux
> about this offset. Otherwise when a EP device driver programs a DMA
> address of a RAM buffer at 0x90000000, it'll end up targetting
> 0x110000000. Thankfully our dma-range will tell Linux to apply an offset
> such that the actual address written to the EP is 0x10000000.).

That last sentence should have read "Thankfully our dma-range will tell the
RC to use its address translation such that the actual address written on the
bus by the RC is 0x10000000.)."

Thanks,

Andrew Murray

> 
> In your case the dma-range also serves to describe a limit to the range
> of addresses we can reach.
> 
> Thanks,
> 
> Andrew Murray
> 
> > 
> > -- 
> > Best regards,
> > Marek Vasut
