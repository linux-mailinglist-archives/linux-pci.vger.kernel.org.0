Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 299514183C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 00:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405570AbfFKWe1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 18:34:27 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36050 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405174AbfFKWe1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2019 18:34:27 -0400
Received: by mail-it1-f195.google.com with SMTP id r135so7518380ith.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2019 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkJzIhPEwFfYs+ROV94xr6LOu0hsr1pDgUpbeMl4/hI=;
        b=hS7DMun1fzAeBo+NDeTcf3ZmY2EvZvSNwA2ToXKtZGruDrJXi2015Z34xieAKmatcV
         iu7P10jt95ZPC5CiAqmjrl8OdE/w4V57Ufw6dAc2/HAUx7pCn2VfopWZRmxrXpMzA6/E
         Z83TyoeXnOX3fsUFOqubE32xdsDzJf/ObLRRvB2ZPUT2ESdZrU1ZM9hnpWyTBUWod7fE
         3pgFuBBVED+JP4ztCDOLjtcoaQQRzi91lmib978ouLwUuI2ltVFdvkH90t+YETRxQ/k1
         Da0LGcH1cc3e7qVsUAVdtlqtj9BgJqogpPj74NRDebjTwMtnce1RcLF9VXcziE94FX+B
         dAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkJzIhPEwFfYs+ROV94xr6LOu0hsr1pDgUpbeMl4/hI=;
        b=TkXnsiRQQzm9vxRbildTIyuabTnSokuBwpVey7ooNVWoPf9uC6dAgivEY1g04u2zY1
         oDxtkC6XAX03U5xmDpUmhIVDf0pCcGPu9YLA55H6ONwxKnk6JTkAI992TOQzHT1YGZWV
         DOyFQylL6hsnw7Y9veJfh5aR3C/D0qc373tu1mkJhPmwR9SwqI/7Qy56p7GUeLk40J3K
         HEoLiiafPMZvjlAiDFP/oIS3B9F/DHAgqfDe6ZPKAv6yPt2EAACdKmfhOG0f/ug6mez+
         NM0rpnjcLewXKkGZ3HNy/bLeptBCBr25sOkwV5QvGx+pAox7RwnPQ5/39HW6PO2EcFmh
         BAFA==
X-Gm-Message-State: APjAAAUZZtzW2WjJrW639sESycI2lyVU0paKYIKw07952g3PwpUkSpl3
        zwFJd3eQJErEnN26rvZOaW8zIWkINfcjekfVVUaFiw==
X-Google-Smtp-Source: APXvYqwyuLmKUPBgv4zNI+6zUL97brCO2JhmEEWQRvTlJT6DkLTsxsn4oV2DTaO4vViBCAz/wwQboNdnzCHQyNXcoTo=
X-Received: by 2002:a24:61c4:: with SMTP id s187mr1777023itc.76.1560292466174;
 Tue, 11 Jun 2019 15:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
 <20190604014945.GE189360@google.com> <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
 <20190604124959.GF189360@google.com> <e520a4269224ac54798314798a80c080832e68b1.camel@kernel.crashing.org>
 <d53fc77e1e754ddbd9af555ed5b344c5fa523154.camel@kernel.crashing.org>
 <CAKv+Gu_3Nb5mPZgRfx+wQSz+eWM+FSbw_14fHm+u=v2EbuYoGQ@mail.gmail.com>
 <4b956e0679b4b4f4d0f0967522590324d15593fb.camel@kernel.crashing.org>
 <20190611143111.GA11736@redmoon> <f1d610d79fbb3a98c9cc80210c64cb21679daf33.camel@kernel.crashing.org>
In-Reply-To: <f1d610d79fbb3a98c9cc80210c64cb21679daf33.camel@kernel.crashing.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 12 Jun 2019 00:34:12 +0200
Message-ID: <CAKv+Gu_bPW8otGWotA7R6HGEvWUuAozF-r1CeZN9fGEiV0iroA@mail.gmail.com>
Subject: Re: [PATCH/RESEND] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

'

On Wed, 12 Jun 2019 at 00:09, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Tue, 2019-06-11 at 15:31 +0100, Lorenzo Pieralisi wrote:
> >
> > True, minus specs update schedule, I can't change that and merging
> > this patch (and firmware thereof) relies on specifications that
> > are intent changes till they become an ECN (~another merge window,
> > so this patch could land at v5.4).
>
> Hrm... annoying for us but I understand your reasoning.
>
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

EDK2 based code is typically very fork heavy, in the sense that,
instead of upstreaming a change, a driver gets forked and changes are
applied locally, which then need to be carried into perpetuity. That
means that 'recent' ports could still display behavior that was
removed from the generic code a long time ago. All the open source
arm64 platforms now use the generic PCI host bridge driver (which is
in charge of the bus enumeration and resource allocation) and so
hopefully, future platforms will not deviate too much from that.

In particular, EDK2 has some PCD tunables for things like PCIe hotplug
and SR-IOV support, which affects the number of spare buses that get
allocated for hotplug capable root ports, and for SR-IOV capable
endpoints.

As Lorenzo mentions, we don't actively reassign bus numbers from
scratch, but I am not sure if that is 100% true. I think you do get
some errors when booting with hotplug capable root ports that don't
have 'pci_hotplug_bus_size' spare bus numbers available.

Also note that EDK2 leaves ROM BARs unassigned.

> > It is kind of orthogonal (but not really), bus numbers assignment
> > is _not_ in line with resource assignment at the moment and I want
> > to change it.
>
> Hrm. We should probably reassign bus numbers if we reassign resources
> yes, but then I'd like us to not reassign resources unless we have to
> :-)
>
> > Since ACPI on ARM64 is still at its inception maybe we should have
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
>
> pci_bus_claim_resources() seems to be a "lightweight" variant of the
> survey done by x86. The main differences I can see are:
>
>  - The 2 passes thing which we may or may not care about, its main
> purpose is to favor resources that are already enabled by the BIOS in
> case of conflicts as far as I understand.
>
>  - pci_read_bridge_bases() is done by pci_bus_claim_resources(), while
> x86 (and powerpc and others) do it in their pcibios_fixup_bus. That one
> is interesting... Any reason why we shouldn't unconditionally read the
> bridges while probing ? Bjorn ?
>
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
>
> The question for me really is, do we want to just "upgrade" (if
> necessary) pci_bus_claim_resources() and continue having x86 do its own
> thing for ever, or do we want to consolidate around what is probably
> the most tested platform when it comes to PCI :-)
>
> And if we consolidate, I think that won't be by changing what x86 does,
> that code is the result of decades of fiddling to get things right with
> all sorts of broken BIOSes...
>
> > > and have that the main generic code path (with added quirks to force a
> > > full assignment and keeping probe_only around but that's easy, we have
> > > that on powerpc and our code is originally based on the x86 one), then
> > > we'll have a much easier time supporting IORESOURCE_PCI_FIXED on
> > > portions of the tree as well (though it also becomes less critical to
> > > do so since we will no longer reallocate unless we have to).
> > >
> > > That said we need to understand what "fixed" means and why we do it.
> >
> > Agree, totally and I want to make it clear how a BAR is fixed in
> > the kernel, there are too many discrepancies in the resource
> > management code already.
> >
> > > IE, If an endpoint somehere has "fixed" BARs for example, that means
> > > all parent bridge must be setup to enclose that range.
> > >
> > > Now our allocator for bridge windows cannot handle that and probably
> > > never will, so we have to rely on the existing window established by
> > > the FW being reasonable and use it. We can still *extend" bridge
> > > windows (and we have code to do that) if necessary but we cannot move
> > > them if they contain a fixed BAR device.
> > >
> > > There is a much bigger discussion to be had around that concept of
> > > fixed device anyway, maybe at Plumbers ? Why is the BAR fixed ? Because
> > > the EFI FB is on it ? Because HW bugs ? Because FW might access it from
> > > SMM or ARM equivalent ? Because ACPI will poke at it based on its
> > > initial address ? etc...
> >
> > Consider a slot booked at LPC PCI uconf for this discussion.
>
> Excellent.
>
> > > Some of the answers to the above questions imply more than the need to
> > > fix the BAR: Does it also mean that disabling access to that BAR, even
> > > temporarily, isn't safe ? However that's what we do today when we
> > > probe, if anything, to do the BAR sizing...
> >
> > Eh, another question that came up already should be debated.
>
> Yup.
>
> > > This isn't a new problem. We had issues like that dating back 15 years
> > > on powerpc for example, where a big ASIC hanging off PCI had all the
> > > Apple gunk including the interrupt controller, which was initialized
> > > from the DT way before PCI probing. If you took an interrupt at the
> > > "wrong" time during BAR sizing, kaboom ! If you had debug printk's in
> > > the wrong place in the PCI probing code, kaboom ! etc....
> > >
> > > If we want to solve that properly in the long run, we'll probably want
> > > ACPI to tell us the BAR sizes and use that instead of doing manual
> > > sizing on such "system" devices. We similarily have ways to "construct"
> > > pci_dev's from the OF tree on sparc64 and powerpc, limiting direct
> > > config access to populate stuff we can't get from FW.
> >
> > https://lore.kernel.org/linux-pci/20190121174225.15835-1-mr.nuke.me@gmail.com/
> >
> > ?
>
> Ah I don't know enough about ACPI yet, on my reading list :-)
>
> Cheers,
> Ben.
>
>
