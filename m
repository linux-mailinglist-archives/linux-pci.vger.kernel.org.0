Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B30E3040
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 13:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437030AbfJXLWf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 07:22:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392847AbfJXLWf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Oct 2019 07:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Eoxo5siLBEjeHmhSrah95Nyw/+aG2YokJoEiTaV0+fg=; b=So9FD3Iaz619Ul2HS5Pan3icl
        NcW4kkYKOEEpYlaZXRKwtwbshbs6jyYpdsySgnRja8aBG6axaYVQ3f1RR1MoIO3GrWpuiTmzCy4yN
        DFGcpEXfAl5prVGQwYxq//wAtqy1ZGkmUOfGJIfx0wbT1DMKRDOZWlEje6pryte+xfefVeNd1dSNa
        w/6VHLuhTBqZy12PZtaEO7h5nPMyWio+3s7xosjIpFqZ/msIOgx1HzC929gzWOeKdT2gSC52VnKt7
        pA1OQ3qOhsu4cjgv9IJTFbvO3rckvjfRxVMQZAmxdLmcA/lch6jDFU44CTcSJd+/QCsZ1QO3BD5c/
        drY+Vo0bQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNbCL-0007oz-0U; Thu, 24 Oct 2019 11:22:33 +0000
Date:   Thu, 24 Oct 2019 04:22:32 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Xiang Zheng <zhengxiang9@huawei.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, alex.williamson@redhat.com,
        Wang Haibin <wanghaibin.wang@huawei.com>,
        Guoheyi <guoheyi@huawei.com>,
        yebiaoxiang <yebiaoxiang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Kernel panic while doing vfio-pci hot-plug/unplug test
Message-ID: <20191024112232.GD2963@bombadil.infradead.org>
References: <20191023163851.GA2963@bombadil.infradead.org>
 <20191023204638.GA8868@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023204638.GA8868@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 03:46:38PM -0500, Bjorn Helgaas wrote:
> [+cc Thomas, Rafael, beginning of thread at
> https://lore.kernel.org/r/79827f2f-9b43-4411-1376-b9063b67aee3@huawei.com]
> 
> On Wed, Oct 23, 2019 at 09:38:51AM -0700, Matthew Wilcox wrote:
> > On Wed, Oct 23, 2019 at 10:15:40AM -0500, Bjorn Helgaas wrote:
> > > I don't like being one of a handful of callers of __add_wait_queue(),
> > > so I like that solution from that point of view.
> > > 
> > > The 7ea7e98fd8d0 ("PCI: Block on access to temporarily unavailable pci
> > > device") commit log suggests that using __add_wait_queue() is a
> > > significant optimization, but I don't know how important that is in
> > > practical terms.  Config accesses are never a performance path anyway,
> > > so I'd be inclined to use add_wait_queue() unless somebody complains.
> > 
> > Wow, this has got pretty messy in the umpteen years since I last looked
> > at it.
> > 
> > Some problems I see:
> > 
> > 1. Commit df65c1bcd9b7b639177a5a15da1b8dc3bee4f5fa (tglx) says:
> > 
> >     x86/PCI: Select CONFIG_PCI_LOCKLESS_CONFIG
> >     
> >     All x86 PCI configuration space accessors have either their own
> >     serialization or can operate completely lockless (ECAM).
> >     
> >     Disable the global lock in the generic PCI configuration space accessors.
> > 
> > The concept behind this patch is broken.  We still need to lock out
> > config space accesses when devices are undergoing D-state transitions.
> > I would suggest that for the contention case that tglx is concerned about,
> > we should have a pci_bus_read_config_unlocked_##size set of functions
> > which can be used for devices we know never go into D states.
> 
> Host bridges that can't do config accesses atomically, e.g., they have
> something like the 0xcf8/0xcfc addr/data ports, need serialization.
> CONFIG_PCI_LOCKLESS_CONFIG removes the use of pci_lock for that, and I
> think that part makes sense regardless of whether devices can enter D
> states.

I disagree.  If a device is in D state, we need to block the access.
Maybe there needs to be a different mechanism for doing it that's not
a machine-wide lock, but it needs to happen.

> We *should* prevent config accesses during D-state transitions (per
> PCIe r5.0, sec 5.9), but I don't think pci_lock ever did that.

It used to set block_ucfg_access.  Maybe that's been lost; I see
there are still calls to pci_dev_lock() in pci_reset_function(),
for example.

> pci_raw_set_power_state() contains delays, but that only prevents
> accesses from the caller, not from other threads or from userspace.
> I suppose we should also prevent accesses by other threads during
> transitions done by ACPI, e.g., _PS0, _PS1, _PS2, _PS3.  AFAICT we
> don't do any of that.
> 
> It looks like pci_lock currently:
> 
>   - Serializes all kernel config accesses system-wide in
>     pci_bus_read_config_##size() (unless CONFIG_PCI_LOCKLESS_CONFIG=y).
> 
>   - Serializes all userspace config accesses system-wide in
>     pci_user_read_config_##size() (this seems unnecessary when
>     CONFIG_PCI_LOCKLESS_CONFIG=y).
> 
>   - Serializes userspace config accesses with resets of the device via
>     the dev->block_cfg_access bit and waitqueue mechanism.
> 
>   - Serializes kernel and userspace config accesses with bus->ops
>     changes in pci_bus_set_ops() (except that we don't serialize
>     kernel config accesses if CONFIG_PCI_LOCKLESS_CONFIG=y, which is
>     probably a problem).  But pci_bus_set_ops() is hardly used and I'm
>     not sure it's worth keeping it.
> 
> > 2. Commit a2e27787f893621c5a6b865acf6b7766f8671328 (jan kiszka)
> >    exports pci_lock.  I think this is a mistake; at best there should be
> >    accessors for the pci_lock.  But I don't understand why it needs to
> >    exclude PCI config space changes throughout pci_check_and_set_intx_mask().
> >    Why can it not do:
> > 
> > -	bus->ops->read(bus, dev->devfn, PCI_COMMAND, 4, &cmd_status_dword);
> > +	pci_read_config_dword(dev, PCI_COMMAND, &cmd_status_dword);
> > 
> > 3. I don't understand why 511dd98ce8cf6dc4f8f2cb32a8af31ce9f4ba4a1
> >    changed pci_lock to be a raw spinlock.  The patch description
> >    essentially says "We need it for RT" which isn't terribly helpful.
> > 
> > 4. Finally, getting back to the original problem report here, I wouldn't
> >    write this code this way today.  There's no reason not to use the
> >    regular add_wait_queue etc.  BUT!  Why are we using this custom locking
> >    mechanism?  It pretty much screams to me of an rwsem (reads/writes
> >    of config space take it for read; changes to config space accesses
> >    (disabling and changing of accessor methods) take it for write.
> 
> So maybe the immediate thing is to just convert to add_wait_queue()?

Isn't that going to run foul of the lock inversion you fixed in
cdcb33f9824429a926b971bf041a6cec238f91ff ?

> There's a lot we could clean up here, but I think it would take a fair
> bit of untangling before we actually solve this panic.

Yes, the mess has spread over many years ;-)
