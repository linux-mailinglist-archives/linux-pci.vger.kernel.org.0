Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FFA3AA71E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 00:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhFPW7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 18:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234490AbhFPW7N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 18:59:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F392461164;
        Wed, 16 Jun 2021 22:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623884227;
        bh=pfYtK+pVcBGK1GdSTd83BxjxxxLTgZLZVB15o+wRNhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b6M40KGD2fOVuLvCK5fTxp2CS7TUr0IfjLF0VOw8y5bN1pp61eRHHh0j3eOSCSU7C
         6sQkwBKyl4YqK74uv/hEA/ob8LkUs9whB7OT3+nzEdgQg2yveCzdSBZOCDLq7XF3a6
         QBfI1Adwu7lfwn/ctd24lhF86rnO3WmxggcaxDY4Wr8qxEFyrjPffudy49uqDk0uvv
         hUB8e0SNEKCxJulJadP8zFs27zFSbfFIblHXiwrnzcnC4hzanJdwntVQg8NaR/JMwI
         n7wr2u48WCU1uEwzMc0kqc0lAZZBol6PFg0EJDkTnnMUFeX3gMAFlJEEd9zIjOCLCM
         hoxS+pdu1EpDQ==
Date:   Wed, 16 Jun 2021 17:57:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RFC 1/1] PCI/ACPI: Make acpi_pci_root_validate_resources()
 reject IOMEM resources which start at address 0
Message-ID: <20210616225705.GA3014869@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8065c303-fc11-93f2-64a5-39048b7501fd@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 16, 2021 at 08:43:12PM +0200, Hans de Goede wrote:
> On 6/15/21 10:23 PM, Bjorn Helgaas wrote:
> > On Tue, Jun 15, 2021 at 12:25:55PM +0200, Hans de Goede wrote:

> I've 2 dmesgs from runs both with and without pci=nocrs, the one
> with a clean kernel commandline (no special options) yields:
> 
> [    0.312333] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.312335] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.312336] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.312337] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> [    0.312338] pci_bus 0000:00: root bus resource [bus 00-fe]
> 
> Where as the one with pci=nocrs on the kernel commandline gives:
> 
> [    0.271766] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    0.271767] pci_bus 0000:00: root bus resource [mem 0x00000000-0x7fffffffff]
> [    0.271768] pci_bus 0000:00: root bus resource [bus 00-fe]
> 
> Hmm, so assuming that you are right that pci=nocrs only influences
> the root resources (and I believe you are), and given that the problem is
> that we are getting these errors:
> 
> [    0.655335] pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
> [    0.655337] pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
> [    0.655339] pci 0000:00:15.1: BAR 0: no space for [mem size 0x00001000 64bit]
> [    0.655340] pci 0000:00:15.1: BAR 0: failed to assign [mem size 0x00001000 64bit]
> [    0.655342] pci 0000:00:1f.5: BAR 0: no space for [mem size 0x00001000]
> 
> Instead of getting this:
> 
> [    0.355716] pci 0000:00:15.0: BAR 0: assigned [mem 0x29c000000-0x29c000fff 64bit]
> [    0.355783] pci 0000:00:15.1: BAR 0: assigned [mem 0x29c001000-0x29c001fff 64bit]
> 
> So now I believe that my initial theory for this is probably completely wrong; and
> I wonder if the issue is that the _CRS returned root IOMEM window is big enough
> to exactly hold the BIOS assigned mappings, but it does not have any free space
> allowing the kernel to assign space for the 0000:00:15.0 and 0000:00:15.1
> devices ?
>
> Assuming that that theory is right, how could we work around this problem?
> Or at least do a quick debug patch to confirm that indeed the window is "full" ?

I'd be pretty surprised if the host bridge window actually full --
[mem 0x65400000-0xbfffffff] is a pretty big range and these devices
only need 4K each.

But maybe we aren't smart enough when trying to allocate space.
Places like __pci_bus_size_bridges() and __pci_assign_resource() are
full of assumptions about what PCI BARs can go where, depending on
64bit-ness, prefetchability, etc.

Maybe instrumenting those allocation paths would give some insight.
Possibly we should go ahead and merge some permanent pci_dbg() stuff
there too.

I do note that the working "pci=nocrs" case puts these devices above
4GB.  _CRS only told you about host bridge windows *below* 4GB, and
Linux will never assign space that's outside the windows (except in
the "pci=nocrs" case, of course).

> >> This happens specifically for the designware I2C PCI devices on these
> >> laptops, causing I2C-HID attached touchpads/touchscreens to not work.
> >>
> >> Booting with nocrs on these devices results in the kernel itself
> >> assigning memory to these devices, fixing things:
> > 
> > "pci=nocrs" to help people repro this or try the same workaround
> > elsewhere.
> 
> Not sure what you are trying to say here.

Sorry, I just meant that instead of "Booting with nocrs ...", I'd like
the commit log to say "Booting with 'pci=nocrs' ..." so that
non-expert users reading it will have a bit of a head start on how to
try this themselves.

Bjorn
