Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B74834A448
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 10:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCZJ3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 05:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhCZJ2c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 05:28:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11A6B61A2B;
        Fri, 26 Mar 2021 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616750910;
        bh=Mp4Rov7gyKbVHVPla9zE4uiVkHzu622ZTYByfZyJTcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ahlYhvuX6we8xzTLtjZbnnI3x+Eo2J1zB2tpOquazXAO6eiYXo7zxyC4Y7C+GwYF+
         HHJCrjN66zfEXLaWTgWFnsTJCMI/cO0EOXy83Rwn6770snE5e3UJMRFNZrXJGDL5r/
         bvtY3awZ/t5P+gMFO40vIzeXIN08aY+zMnkGuyfM=
Date:   Fri, 26 Mar 2021 10:28:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Allow drivers to claim exclusive access to config
 regions
Message-ID: <YF2pO4E3vsXIy6Dq@kroah.com>
References: <161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YFwzw3VK0okr+taA@kroah.com>
 <CAPcyv4huzgpCvT+MVjpVPRE+ZcxPaqB2jqVMt7nJuP0hpzQ82A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4huzgpCvT+MVjpVPRE+ZcxPaqB2jqVMt7nJuP0hpzQ82A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 25, 2021 at 10:43:41AM -0700, Dan Williams wrote:
> On Wed, Mar 24, 2021 at 11:55 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Mar 24, 2021 at 06:23:54PM -0700, Dan Williams wrote:
> > > The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
> > > configuration cycles. It assumes one initiator at a time is
> > > reading/writing the data registers.
> >
> > That sounds like a horrible protocol for a multi-processor system.
> > Where is it described and who can we go complain to for creating such a
> > mess?
> 
> It appears it was added to the PCIE specification in March of last
> year, I don't attend those meetings. I only learned about it since the
> CXL specification adopted it.

Given that the kernel community can not participate in the PCI spec
process, we rely on the member companies that do work there to at least
create sane things.  Who do I need to go complain to about this
happening, again?

> > > If userspace reads from the response
> > > data payload it may steal data that a kernel driver was expecting to
> > > read. If userspace writes to the request payload it may corrupt the
> > > request a driver was trying to send.
> >
> > Fun!  So you want to keep root in userspace from doing this?  I thought
> > we already do that today?
> 
> The only limitation I found was temporary locking via
> pci_cfg_access_lock(), and some limitations on max config offset, not
> permanent access disable.

Temp locking should be all that is needed, right?  If not then something
really is wrong with the protocol design.

> > > Introduce pci_{request,release}_config_region() for a driver to exclude
> > > the possibility of userspace induced corruption while accessing the DOE
> > > mailbox. Likely there are other configuration state assumptions that a
> > > driver may want to assert are under its exclusive control, so this
> > > capability is not limited to any specific configuration range.
> >
> > As you do not have a user for these functions, it's hard to see how they
> > would be used.  We also really can't add new apis with no in-tree users,
> > so do you have a patch series that requires this functionality
> > somewhere?
> 
> Whoops, I buried the lead here. This is in reaction to / support of
> Jonathan's efforts to use this mailbox to retrieve a blob of memory
> characteristics data from CXL devices called the CDAT [1]. That blob
> is used to populate / extend ACPI SRAT/HMAT/SLIT data for CXL attached
> memory. So while I was reviewing his patches it occurred to me that
> the b0rked nature of this interface relative to pci-sysfs needed to be
> addressed. This should wait to go in with his series.
> 
> [1]: https://lore.kernel.org/linux-acpi/20210310180306.1588376-2-Jonathan.Cameron@huawei.com/

Interesting.  Messy.  Ick.

> > > Since writes are targeted and are already prepared for failure the
> > > entire request is failed. The same can not be done for reads as the
> > > device completely disappears from lspci output if any configuration
> > > register in the request is exclusive. Instead skip the actual
> > > configuration cycle on a per-access basis and return all f's as if the
> > > read had failed.
> >
> > returning all ff is a huge hint to many drivers that the device is gone,
> > not that it just failed.  So what happens to code that thinks that and
> > then tears stuff down as if the device has been removed?
> 
> This is limited to the pci_user_* family of accessors, kernel drivers
> should be unaffected. The protection for kernel drivers colliding is
> the same as request_mem_region() coordination.

So you want to lock out user accesses entirely if a kernel driver is
bound to the device?  I missed that here.  If so, that's a big change
that people are not going to like.

> Userspace drivers will of course be horribly confused, but those
> should not be binding to devices that are claimed by a kernel driver
> in the first place.

I'm not worried about "userspace drivers", I'm worried about tools like
'lspci' and others that like reading PCI device state from userspace at
tiems.

> > Trying to protect drivers from userspace here feels odd, what userspace
> > tools are trying to access these devices while they are under
> > "exclusive" control from the kernel?  lspci not running as root should
> > not be doing anything crazy, but if you want to run it as root,
> > shouldn't you be allowed to access it properly?
> 
> The main concern is unwanted userspace reads. An inopportune "hexdump
> /sys/bus/pci/devices/$device/config" will end up reading the DOE
> payload register and advancing the device state machine surprising the
> kernel iterator that might be reading the payload.
> 
> If root really wants to read that portion of config space it can also
> unload the driver similar to the policy for /dev/mem colliding with
> exclusive device-mmio... although that raises the question how would
> root know. At least for exclusive /dev/mem /proc/iomem can show who is
> claiming that resource.

Yes, root does not know, so this feels really broken from a spec
point-of-view.

> If userspace needs to submit DOE requests then that should probably be
> a proper generic driver to submit requests, not raw pci config access.

True, but again as this is exposed through the "normal" config space,
that is not possible.  Again, broken design :(

> > What hardware has this problem that we need to claim exclusive ownership
> > over that differs from the old hardware we used to have that would do
> > crazy things when reading from from userspace?  We had this problem a
> > long time ago and lived with it, what changed now?
> 
> All I can infer from the comments in drivers/pci/access.c is "bad
> things happens on some devices if you allow reads past a certain
> offset", but no concern for reads for offsets less than
> pdev->cfg_size. I think what's changed is that this is the first time
> Linux has had to worry about an awkward polled I/O data transfer
> protocol over config cycles.

I recall many old PCI devices that didn't like their memory being read
at all, and could cause bus lockups, which is why the userspace tools
would print scary warnings if you really wanted to do this.

Feels like we are back to that mess again.

> To make matters worse there appears to be a proliferation of protocols
> being layered on top of DOE. In addition to CXL Table Access for CDAT
> retrieval [2] I'm aware of CXL Compliance Testing [3], Integrity and
> Data Encryption (IDE) [4], and Component Measurement and
> Authentication (CMA) [5].
> 
> I've not read those, but I worry security_locked_down() may want to
> prevent even root userspace mucking with "security" interfaces. So
> that *might* be a reason to ensure exclusive kernel access beyond the
> basic sanity of the kernel being able to have uninterrupted request /
> response sessions with this mailbox
> 
> [2]: https://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
> [3]: https://www.computeexpresslink.org/download-the-specification
> [4]: https://members.pcisig.com/wg/PCI-SIG/document/15149
> [5]: https://members.pcisig.com/wg/PCI-SIG/document/14236

I have no access to these proposed specs, sorry.

If things are being layered on top of a broken design, well, they get
what they asked for.

How are the "other" operating systems going to handle this mess?  How
did they "sign off" on this crazy thing?

thanks,

greg k-h
