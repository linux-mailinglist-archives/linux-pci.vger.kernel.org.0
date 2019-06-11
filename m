Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982DB3C38A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 07:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391123AbfFKFql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 01:46:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:60815 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391085AbfFKFql (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jun 2019 01:46:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5B5kJLC028760;
        Tue, 11 Jun 2019 00:46:20 -0500
Message-ID: <691ffca7e2cc5a2ea78a98e2c190502e0e14b108.camel@kernel.crashing.org>
Subject: Re: [RFC] ARM64 PCI resource survey issue(s)
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Date:   Tue, 11 Jun 2019 15:46:19 +1000
In-Reply-To: <20190610101129.GC25976@redmoon>
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
         <20190604014945.GE189360@google.com>
         <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
         <20190604124959.GF189360@google.com>
         <e520a4269224ac54798314798a80c080832e68b1.camel@kernel.crashing.org>
         <20190610101129.GC25976@redmoon>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-06-10 at 11:11 +0100, Lorenzo Pieralisi wrote:
> 
> > I agree and I assume the problem stems from BIOSes creating either
> > invalid or incomplete assignments but as I said, I don't know for sure
> > as our platforms dont have that problem.
> 
> The first thing that I would like to agree on is what mechanism the
> kernel has to ensure a BAR resource is not changed by the
> PCI resource assignment mechanism.
> 
> (1) IORESOURCE_PCI_FIXED flag: I have *very* strong feelings that this
>     flag works because x86 kernel code claims all resources on probe
>     (which effectively makes them immutable). It does not work for
>     PCI bridges apertures and I am not sure it works for arches (eg
>     ARM64) that reassign everything, even for *devices*

I'm pretty sure this flag generally doesn't work indeed, see my other
messages on that subject. The only valid use I can see for this flag
honestly is in a context where we do an x86-style claim pass, to
prevent selected resources or bridge windows from being moved or
resized due to conflicts (ie: move the *other* one if there's a
conflict) but it's of very limited value.

> (2) Claiming resources: this basically means assigning a parent to
>     a resource.

Well yes, a claimed resource is immutable, that's a given.

That and of course it's implied that there are no conflicts between
claimed resources and/or the resources have valid existing assigned
values. From my quick look last week, it doesn't seem like
pci_bus_claim_resources() handle those edge cases terribly well.

This is why I'm keen on trying to standardize around the x86 (and
powerpc which is similar) method which deals with these partial
assignments and some broken cases much better.

> Kernel PCI resource assignment code is full of code I do not understand
> and that in my opinion works because of (1). I *tried*, while posting
> ACPI PCI code for ARM64, to do what x86 does:

:-)

> - Claim all resources
> - Reassign the resources that could not be claimed
> 
> This led to:
> 
> a) Spurious dmesg logs (Eg Resources that could not be claimed)
> b) If FW set-up bridge windows, it may lead to reassignment failures
>    if the bridge windows were sized *wrongly* but the kernel still
>    manage to claim them (because they fit in the parent window).
> 
> Hence, we reassign everything on ARM64 on ACPI (except for bus numbers
> and that was, indeed, a mistake).

Hrm... do you have example systems or the ability to give me access to
systems where these problems occur ? The x86 code has some smarts to
deal with BIOSes who didn't quite do the right thing that we might be
able to port over. What I called the "2 pass survey followed by
pci_assign_unassigned_resources". I've implemented something similar
back in the days for powerpc and it served us well there too. I'd like
to give a shot and making this generic and using it on arm64.

> In short, this is a mess and one that I do not have much leeway to fix
> because the PCI resource assignment code is as it is owing to legacy
> that we can't touch unless we want to fix regressions for the next
> year.

Yes and no... We can try to make the x86 method work on arm64 and see
what goes right or wrong. I wouldn't mind adding quirks to recognize
existing broken amd64 firmwares if those really still don't work
properly, if we can help getting future ones better as well.

> And then there is _DSM #5.
> 
> The problem we have is that there is *no* specific way to tell what's
> right or wrong and that's what _DSM #5 is supposed to fix. To implement
> it to the letter it will take lots of work.

Correct but I don't think we need fully "to the letter", it's almost
impossible to support all possible cases of _DSM #5 values at arbitrary
locations in the tree.

> First thing is to answer and agree (1) vs (2) above, aka define what
> an immutable resource is from a kernel point of view, one with a
> parent != NULL OR one with IORESOURCE_PCI_FIXED flag.

Well, I think (2) is a given. The issue however is that a resource
can't be "fixed" in isolation. It's parent need to be sufficiently
"fixed" to enclose that resource, and it's parent parent etc.... This
is why random _DSM #5 on leaf nodes isn't going to fly terribly well if
the FW hasn't already assigned sane windows to bridges.

I think the key here is to try to claim what FW setup iff it doesn't
conflict and looks like it's valid at all (assigned at all), using a
similar kind of 2 pass mechanism as x86 and powrpc that favors already
enabled devices (likely to be used by FW), and (re)assigns everything
else.

I can look at making x86 and powerpc common with reasonable ease as I
wrote a lot of the powerpc code for that. I don't have all the HW at
hand to test anymore but I still know who does :-)

For ARM64, the difficulty is all I have access to at the moment are
Amazon own systems which seem to have a reasonable FW assignment, and
qemu. So I'll need help with testing against the bad guys.

In the meantime, I'm still keen on getting in Ard patch that handles
_DSM #5 at the host bridge level. It will help existing valid use cases
and we are reasonably confident it won't break anything.

Cheers,
Ben.


