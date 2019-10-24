Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B40E3F62
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 00:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbfJXWcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 18:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731152AbfJXWcC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 18:32:02 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895E720578;
        Thu, 24 Oct 2019 22:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571956321;
        bh=w/WNbEhCYReBCGhJK/JvS+wNspAgCCxkJ/ZDpf0dz0Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GCSCdhbiPQVzfrntQjeAbI7xZNmQLoHty2THFOvCOU/jqCmme03KHxZoeanRQs3Sb
         fr8Ua0J9tQuZrpY3riPNv9g0WBxFKyxcEgrfJ+2glj7l2htQathKRt6fgkwyezgxj6
         y466EiCIesFxXuSHTyPNLV0W//vc5pk1j7Oq+CyM=
Date:   Thu, 24 Oct 2019 17:32:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xiang Zheng <zhengxiang9@huawei.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, alex.williamson@redhat.com,
        Wang Haibin <wanghaibin.wang@huawei.com>,
        Guoheyi <guoheyi@huawei.com>,
        yebiaoxiang <yebiaoxiang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Kernel panic while doing vfio-pci hot-plug/unplug test
Message-ID: <20191024223200.GA22495@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024112232.GD2963@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 24, 2019 at 04:22:32AM -0700, Matthew Wilcox wrote:
> On Wed, Oct 23, 2019 at 03:46:38PM -0500, Bjorn Helgaas wrote:
> > [+cc Thomas, Rafael, beginning of thread at
> > https://lore.kernel.org/r/79827f2f-9b43-4411-1376-b9063b67aee3@huawei.com]
> > 
> > On Wed, Oct 23, 2019 at 09:38:51AM -0700, Matthew Wilcox wrote:
> > > On Wed, Oct 23, 2019 at 10:15:40AM -0500, Bjorn Helgaas wrote:
> > > > I don't like being one of a handful of callers of __add_wait_queue(),
> > > > so I like that solution from that point of view.
> > > > 
> > > > The 7ea7e98fd8d0 ("PCI: Block on access to temporarily unavailable pci
> > > > device") commit log suggests that using __add_wait_queue() is a
> > > > significant optimization, but I don't know how important that is in
> > > > practical terms.  Config accesses are never a performance path anyway,
> > > > so I'd be inclined to use add_wait_queue() unless somebody complains.
> > > 
> > > Wow, this has got pretty messy in the umpteen years since I last looked
> > > at it.
> > > 
> > > Some problems I see:
> > > 
> > > 1. Commit df65c1bcd9b7b639177a5a15da1b8dc3bee4f5fa (tglx) says:
> > > 
> > >     x86/PCI: Select CONFIG_PCI_LOCKLESS_CONFIG
> > >     
> > >     All x86 PCI configuration space accessors have either their own
> > >     serialization or can operate completely lockless (ECAM).
> > >     
> > >     Disable the global lock in the generic PCI configuration space accessors.
> > > 
> > > The concept behind this patch is broken.  We still need to lock out
> > > config space accesses when devices are undergoing D-state transitions.
> > > I would suggest that for the contention case that tglx is concerned about,
> > > we should have a pci_bus_read_config_unlocked_##size set of functions
> > > which can be used for devices we know never go into D states.
> > 
> > Host bridges that can't do config accesses atomically, e.g., they have
> > something like the 0xcf8/0xcfc addr/data ports, need serialization.
> > CONFIG_PCI_LOCKLESS_CONFIG removes the use of pci_lock for that, and I
> > think that part makes sense regardless of whether devices can enter D
> > states.
> 
> I disagree.  If a device is in D state, we need to block the access.
> Maybe there needs to be a different mechanism for doing it that's not
> a machine-wide lock, but it needs to happen.

I'm missing something here.  If we're using 0xcf8/0xcfc, we need to
serialize so the address in 0xcf8 is preserved until we do the load or
store to 0xcfc, and x86 does that with pci_config_lock.  If we're
using ECAM, we don't need that serialization.

We might need serialization for some other reason, but not because of
that host bridge config access mechanism.

Config accesses are supposed to work fine in all D states except
D3cold, as long as any upstream bridges are in D0.  At least, I think
that's what the spec says.

> > We *should* prevent config accesses during D-state transitions (per
> > PCIe r5.0, sec 5.9), but I don't think pci_lock ever did that.
> 
> It used to set block_ucfg_access.  Maybe that's been lost; I see
> there are still calls to pci_dev_lock() in pci_reset_function(),
> for example.

You have an incredible memory!  pci_ucfg_wait was renamed to
pci_cfg_wait in 2011 with fb51ccbf217c ("PCI: Rework config space
blocking services").

But even then, I don't see a connection with D-state transitions,
e.g., there's nothing in pci_raw_set_power_state() that calls
pci_dev_lock() or otherwise sets block_cfg_wait.
