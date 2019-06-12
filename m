Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A93E4224F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407999AbfFLKVy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 06:21:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407987AbfFLKVy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 06:21:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70A84337;
        Wed, 12 Jun 2019 03:21:53 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D60F3F246;
        Wed, 12 Jun 2019 03:23:35 -0700 (PDT)
Date:   Wed, 12 Jun 2019 11:21:49 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Subject: Re: [PATCH/RESEND] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
Message-ID: <20190612102149.GC6506@redmoon>
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
 <20190604014945.GE189360@google.com>
 <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
 <20190604124959.GF189360@google.com>
 <e520a4269224ac54798314798a80c080832e68b1.camel@kernel.crashing.org>
 <d53fc77e1e754ddbd9af555ed5b344c5fa523154.camel@kernel.crashing.org>
 <CAKv+Gu_3Nb5mPZgRfx+wQSz+eWM+FSbw_14fHm+u=v2EbuYoGQ@mail.gmail.com>
 <4b956e0679b4b4f4d0f0967522590324d15593fb.camel@kernel.crashing.org>
 <20190611143111.GA11736@redmoon>
 <f1d610d79fbb3a98c9cc80210c64cb21679daf33.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d610d79fbb3a98c9cc80210c64cb21679daf33.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 12, 2019 at 08:09:01AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2019-06-11 at 15:31 +0100, Lorenzo Pieralisi wrote:
> > 
> > True, minus specs update schedule, I can't change that and merging
> > this patch (and firmware thereof) relies on specifications that
> > are intent changes till they become an ECN (~another merge window,
> > so this patch could land at v5.4).
> 
> Hrm... annoying for us but I understand your reasoning.

If we can wait it is better, also because it gives us time to
bring this discussion to completion.

> > The other option is doing what this patch does *without* relying
> > on _DSM #5, we may have regressions unfortunately though.
> 
> We could work around regressions with quirks I suppose. It does make
> sense to assume that if you have ACPI and UEFI, you have a decent PCI
> BAR assignment at boot in the "general case". That said, we need to
> double check first that pci_bus_claim_resources() will not do horrible
> things on partially assigned setups, since there's a real interest in
> doing that in the field.
> 
> > It is kind of orthogonal (but not really), bus numbers assignment
> > is _not_ in line with resource assignment at the moment and I want
> > to change it.
> 
> Hrm. We should probably reassign bus numbers if we reassign resources
> yes, but then I'd like us to not reassign resources unless we have to
> :-)

But for that we can use _DSM #5 returning 0, at least we would
be consistent.

Current situation is inconsistent and that bothers me I can put
together a separate patch and send it as an RFT, there are not
that many ARM64 PCI ACPI platforms to test it on.

> > a stab at patching the kernel so that it reassigns bus numbers by
> > default and toggle that behaviour on _DSM #5 == 0 detection.
> > 
> > I doubt that reassigning bus numbers by default can trigger
> > regressions on existing platforms but the only way to figure
> > it out is by testing it.
> >
> > > My thinking is if we converge everybody toward the x86 method of
> > > doing
> > > a 2 pass survey of existing resources followed by
> > > assign_unassigned,
> > 
> > I am not entirely sure we need a 2-pass survey,
> >
> > pci_bus_claim_resources()
> > 
> > should be enough; if it is not we update it.
> 
> So it's not so much about the 2 passes per-se, though they have value,
> it's more about consolidating archs to do the same thing. Chances that
> we change x86 are nil. But we can change powerpc and arm64 to do like
> x86 and move that code to generic.

Agree on that.

> pci_bus_claim_resources() seems to be a "lightweight" variant of the
> survey done by x86. The main differences I can see are:
> 
>  - The 2 passes thing which we may or may not care about, its main
> purpose is to favor resources that are already enabled by the BIOS in
> case of conflicts as far as I understand.

Yes.

>  - pci_read_bridge_bases() is done by pci_bus_claim_resources(), while
> x86 (and powerpc and others) do it in their pcibios_fixup_bus. That one
> is interesting... Any reason why we shouldn't unconditionally read the
> bridges while probing ? Bjorn ?

I tried and failed miserably:

https://lore.kernel.org/linux-pci/20150916085850.GA17510@red-moon/

>  - When allocating bridge resources, there are interesting differences:
> 
>   * x86 (and powerpc to some extent): If one has a 0 start or we fail
> to claim it, x86 will wipe out the resource struct (including flags). I
> assume that pci_assign_unassign_* will restore bridges when needed but
> I haven't verified. 
> 
>   * pci_bus_claim_resources() is dumber in that regard. It will call
> pci_claim_bridge_resources() blindly try to claim whatever is there
> even if res->start is 0. This could be a problem with partially
> assigned trees. It also doesn't wipe the resource in case of failure to
> claim which could be a problem going down the tree and letting children
> attach to the non-claimed resource, thus potentially causing the
> reassign pass to fail.
> 
> The r->start == 0 test is interesting ... the generic claim code will
> honor IORESOURCE_UNSET but we don't seem to set that generically unless
> we hit some of the specific pass for explicit resource alignment, or
> during the reassignment phases.
> 
>  - When allocating device resources, the main difference other than the
> 2 passes is that x86 will "0 base" the resource (r->end -= r->start; r-
> >start = 0) for later reassignment. The claim path we use won't do
> that. Note: none sets IORESOURCE_UNSET... Additionally x86 has some
> oddball code to save the original FW values and restore them if
> assignment later fails, which is somewhat odd since there's a conflict
> but probably helps really broken setups.
> 
>  - x86 will not claim ROMs in that pass, it does a 3rd pass just for
> them (it's common I think to not have room for all the ROMs). It also
> disables them in config space during the survey.
> pci_bus_claim_resources() will claim everything and leave ROMs enabled.
> 
> So as a somewhat temprary conclusion, I think the main difference here
> is what happens when claim fails (also the res->start = 0 case which we
> need to look at more closely) and whether we should make the generic
> code also "0-base" the resource.

Oh my, res->start == 0, another can of worms. Honestly I do not know
what to do on that one mostly because we need to figure out how it
plays with resource assignment code (and legacy stuff, you know the
drill).

> 
> The question for me really is, do we want to just "upgrade" (if
> necessary) pci_bus_claim_resources() and continue having x86 do its own
> thing for ever, or do we want to consolidate around what is probably
> the most tested platform when it comes to PCI :-)

Consolidating is the right thing to do, with the caveats above, there
are many but you have all my support.

> And if we consolidate, I think that won't be by changing what x86 does,
> that code is the result of decades of fiddling to get things right with
> all sorts of broken BIOSes...

There is 0 chance to change x86 code (and there is 0 chance to change
core PCI code with x86 assumptions in it).

Cheers,
Lorenzo
