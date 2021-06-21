Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851A03AE937
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 14:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFUMjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 08:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhFUMjf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 08:39:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0C9761001;
        Mon, 21 Jun 2021 12:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624279041;
        bh=b/A/p6M/3d7wdnIFVbh+hkRZqglZBapNfcMjYeMnji8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MLXgUbweR9qK+S8H8IdI/NUk4a6Hy+hGnbV3oRP5FtB3HaGWI/0EAGtW3KN2E9Dua
         mjnPser/4HJdD1pm1aKc8EWbhVvHS836I65hbxOB48mVBL8Wbl7+YFyG2F/mnBj/FP
         iWaDMyJdQLNRGNTalSauM2hgFOz6byZepX9crgyLHtf5AEx87/i9S0USUS2NJ67rgo
         8pali0eTk3f+R5ZV/8zsDvnsa/O4osS0V8uVJzv/gDZU2rEdwLm3ByG01BbhGaOKOX
         Ab9vEIx8yyNrc0dMKWiADHf5vN7/Wkw0SwkziiU/30X8ykxFOMMj9IOPu6apwmXHQl
         lLNiGnO49eqAQ==
Date:   Mon, 21 Jun 2021 07:37:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RFC 1/1] PCI/ACPI: Make acpi_pci_root_validate_resources()
 reject IOMEM resources which start at address 0
Message-ID: <20210621123714.GA3286648@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c55ee3ef-f15e-d043-4cdf-35c1026089ec@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 21, 2021 at 01:49:04PM +0200, Hans de Goede wrote:
> Hi Bjorn,
> 
> On 6/17/21 12:57 AM, Bjorn Helgaas wrote:
> > On Wed, Jun 16, 2021 at 08:43:12PM +0200, Hans de Goede wrote:
> >> On 6/15/21 10:23 PM, Bjorn Helgaas wrote:
> >>> On Tue, Jun 15, 2021 at 12:25:55PM +0200, Hans de Goede wrote:
> > 
> >> I've 2 dmesgs from runs both with and without pci=nocrs, the one
> >> with a clean kernel commandline (no special options) yields:
> >>
> >> [    0.312333] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> >> [    0.312335] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> >> [    0.312336] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> >> [    0.312337] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> >> [    0.312338] pci_bus 0000:00: root bus resource [bus 00-fe]
> >>
> >> Where as the one with pci=nocrs on the kernel commandline gives:
> >>
> >> [    0.271766] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> >> [    0.271767] pci_bus 0000:00: root bus resource [mem 0x00000000-0x7fffffffff]
> >> [    0.271768] pci_bus 0000:00: root bus resource [bus 00-fe]
> >>
> >> Hmm, so assuming that you are right that pci=nocrs only influences
> >> the root resources (and I believe you are), and given that the problem is
> >> that we are getting these errors:
> >>
> >> [    0.655335] pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
> >> [    0.655337] pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
> >> [    0.655339] pci 0000:00:15.1: BAR 0: no space for [mem size 0x00001000 64bit]
> >> [    0.655340] pci 0000:00:15.1: BAR 0: failed to assign [mem size 0x00001000 64bit]
> >> [    0.655342] pci 0000:00:1f.5: BAR 0: no space for [mem size 0x00001000]
> >>
> >> Instead of getting this:
> >>
> >> [    0.355716] pci 0000:00:15.0: BAR 0: assigned [mem 0x29c000000-0x29c000fff 64bit]
> >> [    0.355783] pci 0000:00:15.1: BAR 0: assigned [mem 0x29c001000-0x29c001fff 64bit]
> >>
> >> So now I believe that my initial theory for this is probably completely wrong; and
> >> I wonder if the issue is that the _CRS returned root IOMEM window is big enough
> >> to exactly hold the BIOS assigned mappings, but it does not have any free space
> >> allowing the kernel to assign space for the 0000:00:15.0 and 0000:00:15.1
> >> devices ?
> >>
> >> Assuming that that theory is right, how could we work around this problem?
> >> Or at least do a quick debug patch to confirm that indeed the window is "full" ?
> > 
> > I'd be pretty surprised if the host bridge window actually full --
> > [mem 0x65400000-0xbfffffff] is a pretty big range and these devices
> > only need 4K each.
> 
> Yeah, I just checked and the highest used IOMEM window ends at
> 0x811300ff leaving plenty of space after it for the 2 new windows.
> 
> > But maybe we aren't smart enough when trying to allocate space.
> > Places like __pci_bus_size_bridges() and __pci_assign_resource()
> > are full of assumptions about what PCI BARs can go where,
> > depending on 64bit-ness, prefetchability, etc.
> > 
> > Maybe instrumenting those allocation paths would give some
> > insight.  Possibly we should go ahead and merge some permanent
> > pci_dbg() stuff there too.
> 
> I agree that this seems to be the most likely issue. I've build a
> Fedora kernel pkg with some extra debugging added for the reporter
> to be test.  Since I'm reliant on a debug cycle where I provide a
> kernel and then the reporter comes back with a new debug, and then
> rince-repeat it might be a while before I get back to you on this.
> Hopefully when I do get back I will have figured out what the
> problem is.

Thanks for the update.  It's a real hassle to debug issues in this
code, especially when it's a long repro cycle like this.  I always
wish we could feed the initial config (which I think we should already
know from existing dmesg logging) into some kind of qemu test fixture
so we could reproduce things locally.

Bjorn
