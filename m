Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B6E44901
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 19:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfFMRM6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 13:12:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:41808 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbfFLWGA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 18:06:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5CM5idM012702;
        Wed, 12 Jun 2019 17:05:45 -0500
Message-ID: <6f98047e67d16e791ec955db3bc1bc995ee9f16e.camel@kernel.crashing.org>
Subject: Re: [PATCH/RESEND] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Date:   Thu, 13 Jun 2019 08:05:44 +1000
In-Reply-To: <20190612102149.GC6506@redmoon>
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
         <20190612102149.GC6506@redmoon>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-06-12 at 11:21 +0100, Lorenzo Pieralisi wrote:

> Hrm. We should probably reassign bus numbers if we reassign resources
> > yes, but then I'd like us to not reassign resources unless we have to
> > :-)
> 
> But for that we can use _DSM #5 returning 0, at least we would
> be consistent.

Yes we should be consistent. My personal preference would be to always
honor FW resources by default regardless of DSM, and have DSM = 1 force
a full reassign instead. In a way, by always reassigning we send the
wrong message to FW folks, that it's ok to be broken bcs Linux will fix
it up..

Do you know how Windows deals with this ?

> Current situation is inconsistent and that bothers me I can put
> together a separate patch and send it as an RFT, there are not
> that many ARM64 PCI ACPI platforms to test it on.

Ok.

 ../..

> >  - pci_read_bridge_bases() is done by pci_bus_claim_resources(), while
> > x86 (and powerpc and others) do it in their pcibios_fixup_bus. That one
> > is interesting... Any reason why we shouldn't unconditionally read the
> > bridges while probing ? Bjorn ?
> 
> I tried and failed miserably:
> 
> https://lore.kernel.org/linux-pci/20150916085850.GA17510@red-moon/

Yes, I see... I think we can revive this if we key it off not
reassigning all resources.

There's a PCI flag PCI_REASSIGN_ALL_RSRC that's currently only use on
powerpc, but it wouldn't be hard to make sure it's set on archs that do
a full reassign. We could then have the generic code key off that.

That said, I'd rather have this be a host bridge flag. I'll look into
it later.

> >  - When allocating bridge resources, there are interesting differences:
> > 
> >   * x86 (and powerpc to some extent): If one has a 0 start or we fail
> > to claim it, x86 will wipe out the resource struct (including flags). I
> > assume that pci_assign_unassign_* will restore bridges when needed but
> > I haven't verified. 
> > 
> >   * pci_bus_claim_resources() is dumber in that regard. It will call
> > pci_claim_bridge_resources() blindly try to claim whatever is there
> > even if res->start is 0. This could be a problem with partially
> > assigned trees. It also doesn't wipe the resource in case of failure to
> > claim which could be a problem going down the tree and letting children
> > attach to the non-claimed resource, thus potentially causing the
> > reassign pass to fail.
> > 
> > The r->start == 0 test is interesting ... the generic claim code will
> > honor IORESOURCE_UNSET but we don't seem to set that generically unless
> > we hit some of the specific pass for explicit resource alignment, or
> > during the reassignment phases.
> > 
> >  - When allocating device resources, the main difference other than the
> > 2 passes is that x86 will "0 base" the resource (r->end -= r->start; r-
> > > start = 0) for later reassignment. The claim path we use won't do
> > 
> > that. Note: none sets IORESOURCE_UNSET... Additionally x86 has some
> > oddball code to save the original FW values and restore them if
> > assignment later fails, which is somewhat odd since there's a conflict
> > but probably helps really broken setups.
> > 
> >  - x86 will not claim ROMs in that pass, it does a 3rd pass just for
> > them (it's common I think to not have room for all the ROMs). It also
> > disables them in config space during the survey.
> > pci_bus_claim_resources() will claim everything and leave ROMs enabled.
> > 
> > So as a somewhat temprary conclusion, I think the main difference here
> > is what happens when claim fails (also the res->start = 0 case which we
> > need to look at more closely) and whether we should make the generic
> > code also "0-base" the resource.
> 
> Oh my, res->start == 0, another can of worms. Honestly I do not know
> what to do on that one mostly because we need to figure out how it
> plays with resource assignment code (and legacy stuff, you know the
> drill).

Yes. We have that funny pcibios_uninitialized_bridge_resource() in
arch/powerpc/kernel/pci-common.c which tries to "guess" whether a
bridge with a 0 res->start means that it's uninitialized or has a
"valid" 0 based resource. Among others, we check if memory decoding is
enabled, etc... If we decide it's really uninitialized we set
IORESOURCE_UNSET, and we rely on that later on.

In an idea world, nobody should create valid 0 based resources, it's
best to stay off the first 1MB of PCI space due to various legacy
concerns anyways but ...

> > The question for me really is, do we want to just "upgrade" (if
> > necessary) pci_bus_claim_resources() and continue having x86 do its own
> > thing for ever, or do we want to consolidate around what is probably
> > the most tested platform when it comes to PCI :-)
> 
> Consolidating is the right thing to do, with the caveats above, there
> are many but you have all my support.
> 
> > And if we consolidate, I think that won't be by changing what x86 does,
> > that code is the result of decades of fiddling to get things right with
> > all sorts of broken BIOSes...
> 
> There is 0 chance to change x86 code (and there is 0 chance to change
> core PCI code with x86 assumptions in it).

I wouldn't say 0 but the bar is high yes.

Cheers,
Ben.


