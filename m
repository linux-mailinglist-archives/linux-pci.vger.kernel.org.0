Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D61F457B2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 10:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfFNIgu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 04:36:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:49850 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbfFNIgu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 04:36:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5E8aWFp002722;
        Fri, 14 Jun 2019 03:36:33 -0500
Message-ID: <d5d3e7b9553438482854c97e09543afb7de23eaa.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 14 Jun 2019 18:36:32 +1000
In-Reply-To: <CAKv+Gu95pQ7_OfLbEXHZ_bhYnqOgTBKCmTgqUY27un-Y708BgQ@mail.gmail.com>
References: <5783e36561bb77a1deb6ba67e5a9824488cc69c6.camel@kernel.crashing.org>
         <20190613190248.GH13533@google.com>
         <e6c7854ae360be513f6f43729ed6d4052e289376.camel@kernel.crashing.org>
         <CAKv+Gu95pQ7_OfLbEXHZ_bhYnqOgTBKCmTgqUY27un-Y708BgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2019-06-14 at 09:42 +0200, Ard Biesheuvel wrote:
> The original purpose was for firmware running on 64-bit hosts to not
> create a PCI resource assignment that was incompatible with the OS
> booting in 32-bit mode.
> 
> So the expectation was that a 32-bit OS would reuse whatever config
> the firmware created, and the 64-bit version would be enlightened to
> understand that it could reassign resource assignments to make better
> use of the available resource windows, but this required a mechanism
> to describe which resources should be left alone by the OS.
> 
> So I don't think anybody cares about that use case anymore, and I have
> no idea how widespread its use was when people did.

Ok. At least my thinkpad happily assigns stuff in 64-bit space. AFAIK
even 32-bit distros can deal with it with PAE no ?

> >   - The "probe only" method. This was created independently on powerpc
> > and some other archs afaik. At least for powerpc, the reason for that
> > is some interesting virtualization cases where we just cannot touch or
> > change or move anything. The effect is to not reassign even what we
> > dont like, and not call pci_assign_unassign_resources().
> > 
> >   - The "reassign everything" method. This is used by almost all
> > embedded patforms accross archs. All arm32, all arm64 today (but we
> > agree that's wrong), all embedded powerpc etc... This is basically
> > meant for us not trusting whatever random uboot or other embedded FW,
> > if any, and do a full from-scratch assignment. There are issues in how
> > that is implemented accross the various platforms/archs, some for
> > example still honor existing bus numbers and some don't, but I doubt
> > it's intentional etc... but that method is there to stay.
> > 
> > Now, the questions are two fold
> > 
> >    - How do we map _DSM #5 to these, at least on arm64, maybe in the
> > long run we can also look at affecting x86, but that's less urgent.
> > 
> >    - How do I ensure the above fixes my Amazon platform ? :-)
> > 
> 
> It would help if you could explain what exactly is wrong with your
> Amazon platform :-)

Linux can't change the switch configuration. I may have mentioned
earlier it has to do with platform sec policies. But that's not totally
relevant, we shoudn't be changing resources anyway since in theory
runtime FW might rely on where some system devices were assigned at
boot. EFI fb is another example of that.

The biggest issue for me right now is that the spec says pretty much at
_DSM #5 = 0 is equivalent to _DSM #5 absent, and Bjorn seems keen on
having it this way, but for arm64, we specifically want to distinguish
those 2 cases.

We want to honor _DSM #5 = 0, and at least initially, leave the rest
alone.

Now, we *also* want to look at switching the rest to the "normal" (for
ACPI platforms at least) mechanism of using what FW setup and fixing up
if necessary, but that's not what the code does today, we know just
switching to pci_bus_claim_resources() will break some platforms, and
we need more testing and possibly quirks to get there, so it's material
for a separate patch.

But in the meantime, I need to differenciate.

Also using "probe_only" for _DSM #5 = 0 isn't a good idea, at least as
implemented today in the rest of the kernel, probe_only also means we
shouldn't assign what was left unassigned. However _DSM #5 allows this.

So we'll need to find some more subtle way to convey these.

Bjorn: At this point, because of all the above, I'm keen on going back
to my original patch (slightly modified Ard's patch), possibly
rewording a thing or two and addressing Lorenzo comment.

We can look at a better and more generic implementation of _DSM #5
including for child nodes after I have consolidated more of the
resource management code.

Looking at the spec (and followup discussions for specs updates), I'm
quite keen on treating _DSM #5 = 1 as "wipe out the resource for that
endpoint/bridge and realloc something better. There are reasons for
that, but we can probably discuss that later.

Cheers,
Ben.


