Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80C44CCC38
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 04:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbiCDDWK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 22:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbiCDDWJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 22:22:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E96D179A34;
        Thu,  3 Mar 2022 19:21:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9F8FB82744;
        Fri,  4 Mar 2022 03:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F708C340EC;
        Fri,  4 Mar 2022 03:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646364079;
        bh=w1XlXJiLhx+teyx9KXfpnb3GowWshzfFN73zgpAo8GE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BFfiWC3hAjiPRolIkd/+RCTGW6T64WmLuKspVZXe0b6S+cEeKJKeydrSFmLhArZdd
         ftxUdn0g2L1/r6NRowEudcNLcLwUcZOWJ4AWnD+J3OWrOHKQvYoZgWOxWWiKJhvEwl
         AiIfWNxA3/IJQ5KhEMX0lk6MHKpIjgvY1EDTnACaWtB1MXwlzqF9QnFGLO7lLjRYPl
         oZ4TUCKjrM2XY74Dei4tauQjEK4NupFR/iAwGb75XR0qvogiZIdpMGtsR+XtAPv1dP
         phUK9sApSv+1j/Ps8FuztvnXySIHqnEENTNWF4gY8/QWOn4ZjuXqEml0hQOJBatb2/
         cf8f7vzaDNrtw==
Date:   Thu, 3 Mar 2022 21:21:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/PCI: Disable exclusion of E820 reserved addressed
 in some cases
Message-ID: <20220304032117.GA820079@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c6d785-e29a-872e-ddbe-3d9f9b11be8e@redhat.com>
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 03, 2022 at 02:29:30PM +0100, Hans de Goede wrote:
> On 3/3/22 01:40, Bjorn Helgaas wrote:
> > On Mon, Feb 28, 2022 at 11:52:59AM +0100, Hans de Goede wrote:
> > 
> > I know Rafael has already applied this, but I'm still trying to
> > understand this because it looks like a very complicated maintenance
> > problem.
> > 
> >> Some fw has a bug where the PCI bridge window returned by the ACPI
> >> resources partly overlaps with some other address range, causing issues.
> >> To workaround this Linux excludes E820 reserved addresses when allocating
> >> addresses from the PCI bridge window. 2 known examples of such fw bugs are:
> >>
> >> 1. The returned window contains addresses which map to system RAM,
> >> see commit 4dc2287c1805 ("x86: avoid E820 regions when allocating
> >> address space").
> > 
> > Bug report is https://bugzilla.kernel.org/show_bug.cgi?id=16228
> > First dmesg log https://bugzilla.kernel.org/attachment.cgi?id=26811
> > shows:
> > 
> >   BIOS-e820: 00000000bfe4dc00 - 00000000c0000000 (reserved)
> >   pci_root PNP0A03:00: host bridge window [mem 0xbff00000-0xdfffffff]
> >   pci 0000:00:1f.2: no compatible bridge window for [mem 0xff970000-0xff9707ff]
> >   pci 0000:00:1f.2: BAR 5: assigned [mem 0xbff00000-0xbff007ff]
> >   ahci 0000:00:1f.2: controller reset failed (0xffffffff)
> >   ahci 0000:00:1f.2: failed to stop engine (-5)
> > 
> > The problem is that _CRS advertises [mem 0xbff00000-0xdfffffff], and
> > we assigned [mem 0xbff00000-0xbff007ff] to 00:1f.2, but
> > 0xbff00000-0xbfffffff is not usable for PCI devices.  My guess is that
> > it contains host bridge registers, but all we really know is that it
> > doesn't work.
> > 
> > I think the _CRS that includes non-usable space is clearly a BIOS
> > defect.
> > 
> > The fix from 4dc2287c1805 was to avoid that region based on the
> > 0xbfe4dc00-0xc0000000 E820 entry, and the result is in
> > https://bugzilla.kernel.org/attachment.cgi?id=30662:
> > 
> >   BIOS-e820: 00000000bfe4dc00 - 00000000c0000000 (reserved)
> >   pci_root PNP0A03:00: host bridge window [mem 0xbff00000-0xf7ffffff]
> >   pci_root PNP0A03:00: host bridge window [mem 0xff980000-0xff980fff]
> >   pci 0000:00:1f.2: reg 24: [mem 0xff970000-0xff9707ff]   # BAR 5
> >   pci 0000:00:1f.2: no compatible bridge window for [mem 0xff970000-0xff9707ff]
> >   pci 0000:00:1f.2: BAR 5: assigned [mem 0xff980800-0xff980fff]
> > 
> > The patch below doesn't affect this workaround.
> > 
> >> 2. The Lenovo X1 carbon gen 2 BIOS has an overlap between an EFI/E820
> >> reserved range and the ACPI provided PCI bridge window:
> >>  efi: mem46: [MMIO] range=              [0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
> >>  BIOS-e820:                         [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
> >>  pci_bus 0000:00: root bus resource [mem         0xdfa00000-        0xfebfffff window]
> >> If Linux assigns the overlapping 0xdfa00000-0xdfa0ffff range to a PCI BAR
> >> then the system fails to resume after a suspend.
> > 
> > I think this is from https://bugzilla.redhat.com/show_bug.cgi?id=2029207
> 
> Correct.
> 
> > If I understand correctly, the log in comment 23 from Ivan
> > (https://bugzilla.redhat.com/attachment.cgi?id=1859801) is a
> > case where resume doesn't work:
> > 
> >   BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
> >   pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
> >   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfa00000-0xdfbfffff]
> > 
> > And the log in comment 38, also from Ivan,
> > (https://bugzilla.redhat.com/attachment.cgi?id=1861539) is a case
> > where resume *does* work:
> > 
> >   BIOS-e820: [mem 0x00000000dcf00000-0x00000000dfa0ffff] reserved
> >   efi: mem46: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
> >   pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
> >   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff]
> > 
> > _CRS advertises [mem 0xdfa00000-0xfebfffff], but when we assign the
> > 0xdfa00000-0xdfafffff region to the 00:1c.0 MMIO window, resume fails.
> 
> Correct this "when we assign the 0xdfa00000-0xdfafffff region to
> the 00:1c.0 MMIO window, resume fails" is my conclusion too.
> 
> > I don't see a theory about what the root cause is.
> 
> Correct, because I have no theory, I merely observed that:
> 
> 1. 0xdfa00000-0xdfa0ffff (note the 0 between the a and ffff)
> is reserved in the E820 ranges (this was first seen with
> classic BIOS boot, but also reproduces with EFI bootiung)
> 
> 2. If the kernel assigns PCI resources to it despite it being
> reserved the reporter reports resume being broken.
> 
> I indeed do not know the exact cause of this.
> 
> > It's possible this
> > is similar to case 1 above, where _CRS is defective.
> 
> I definitely consider this another case of _CRS being defective
> and it is similar to 1 in that regards, yes.
> 
> > But here we're
> > only assigning the 00:1c.0 MMIO window, and 00:1c.0 is a bridge to
> > [bus 02], and there are no devices on bus 02.  There should be no
> > transactions that use that MMIO window, so it's not clear why this
> > should matter.
> > 
> > If this is a _CRS defect similar to case 1, it's possible there are
> > host bridge registers in 0xdfa00000-0xdfafffff, and BIOS might use
> > those during resume, and assigning that area to the 00:1c.0 MMIO
> > window might interfere with that.  But that's a lot of speculation.
> > 
> > If you have a good Lenovo contact, they might be able to confirm or
> > deny this.
> > 
> > I'm missing some things here that should be obvious; can you help me
> > out?
> > 
> >   - Why did the 4dc2287c1805 workaround not apply here?  The E820
> >     region overlaps the _CRS window just like in case 1, so why did we
> >     assign 0xdfa00000?
> 
> The 4dc2287c1805 workaround does apply here. The problem is that
> my earlier patch which Rafael merged to not honor e820 reservations
> on newer BIOS-es broke suspend/resume since that patch disables
> the 4dc2287c1805 workaround on this machine.

Ah!  That makes sense now, thank you!  So this is merely an example of
a newer machine for which 4dc2287c1805 is important.  It's not a case
where *this* patch is relevant.

> The comment tries to mention this issue as a second case of
> why the 4dc2287c1805 workaround is necessary.
> 
> The goal of this part of the comment is to explain why we
> cannot just disable the 4dc2287c1805 workaround.
> 
> >   - How does this patch work around the problem?  This patch checks if
> >     a host bridge window is completely contained in an EFI MMIO
> >     region, but I don't see such an EFI region here.
> 
> It does not help with case 2 from the comment, since that
> case is already effectively fixed by the 4dc2287c1805 workaround.
> 
> This patch is a replacement for my earlier fix to disable
> the 4dc2287c1805 workaround on newer systems. Since that patch
> was causing the regression reported in the Red Hat 2029207
> the patch to disable the 4dc2287c1805 workaround on newer systems
> has been reverted.
> 
> So this is yet another attempt to fix the case where
> the PCI subsystem cannot assign resources to some PCI
> devices because the entire root bridge window is covered
> by an EFI memtable MMIO entry, which gets translated into
> an e820_table reserved entry.
> 
> What this patch does is identify systems which have the
> problem of the entire root bridge window being covered
> by an EFI memtable MMIO entry and only disable the
> 4dc2287c1805 workaround there.

I think having the entire root bridge window covered by an EFI MMIO
entry is not actually a problem per spec.  My previous response to the
log message applies:

> > This message suggests that marking the host bridge window as MMIO in
> > EFI is a defect, or at least something unusual and worthy of being
> > flagged.  But I think it's perfectly legal.
> > 
> > UEFI v2.8, sec 7.2, says EfiMemoryMappedIO means:
> > 
> >   Used by system firmware to request that a memory-mapped IO region be
> >   mapped by the OS to a virtual address so it can be accessed by EFI
> >   runtime services.

The problem is only that Linux doesn't handle this correctly because
of 4dc2287c1805, which makes it think the entire window is
unavailable.

> The idea here is to only disable arch_remove_reservations()
> taking e820 reservations into account on as narrow a set of
> systems as possible.
> 
> Keeping it enabled on all other systems, including recent
> systems. Since recent systems also benefit from the
> 4dc2287c1805 workaround as the regression from my patch
> to disable it on recent systems has shown us.
> 
> I hope this helps understand things better.

It does, it was very helpful, thanks!

I have an alternate proposal which does basically the same thing
(skipping the 4dc2287c1805 workaround when an E820 entry covers the
entire window), but I think it's slightly simpler.

And more importantly, it adds a little bit of logging and updates the
window itself instead of clipping on every alloc, which I should have
done in 4dc2287c1805 from the beginning, and should make issues easier
to debug.

I'll post it shortly.

Bjorn
