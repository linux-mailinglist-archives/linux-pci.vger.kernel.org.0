Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541D2E24BD
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 22:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391759AbfJWUql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 16:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391748AbfJWUql (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 16:46:41 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B706520650;
        Wed, 23 Oct 2019 20:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571863599;
        bh=pC35TflnyCjFvVvR+rzOGTAEgWBTmYw1/+C59nJ0vY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L8FOHttArRiLUrkM6EhiNXc5yYB11kJE6WmQzxydqdp0wSuEiMysl7FGDQjQd4z1r
         dwQJON7WXJ2Lw2wGuQC7XkchUk8BuPUVBwfQVKFlEWSqwEqcT5WPp8zs5oqPueZa+0
         EUbE5gYd758ixuZYBQaV38eE3oBJyWDA7psVsLGQ=
Date:   Wed, 23 Oct 2019 15:46:38 -0500
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
Message-ID: <20191023204638.GA8868@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023163851.GA2963@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas, Rafael, beginning of thread at
https://lore.kernel.org/r/79827f2f-9b43-4411-1376-b9063b67aee3@huawei.com]

On Wed, Oct 23, 2019 at 09:38:51AM -0700, Matthew Wilcox wrote:
> On Wed, Oct 23, 2019 at 10:15:40AM -0500, Bjorn Helgaas wrote:
> > I don't like being one of a handful of callers of __add_wait_queue(),
> > so I like that solution from that point of view.
> > 
> > The 7ea7e98fd8d0 ("PCI: Block on access to temporarily unavailable pci
> > device") commit log suggests that using __add_wait_queue() is a
> > significant optimization, but I don't know how important that is in
> > practical terms.  Config accesses are never a performance path anyway,
> > so I'd be inclined to use add_wait_queue() unless somebody complains.
> 
> Wow, this has got pretty messy in the umpteen years since I last looked
> at it.
> 
> Some problems I see:
> 
> 1. Commit df65c1bcd9b7b639177a5a15da1b8dc3bee4f5fa (tglx) says:
> 
>     x86/PCI: Select CONFIG_PCI_LOCKLESS_CONFIG
>     
>     All x86 PCI configuration space accessors have either their own
>     serialization or can operate completely lockless (ECAM).
>     
>     Disable the global lock in the generic PCI configuration space accessors.
> 
> The concept behind this patch is broken.  We still need to lock out
> config space accesses when devices are undergoing D-state transitions.
> I would suggest that for the contention case that tglx is concerned about,
> we should have a pci_bus_read_config_unlocked_##size set of functions
> which can be used for devices we know never go into D states.

Host bridges that can't do config accesses atomically, e.g., they have
something like the 0xcf8/0xcfc addr/data ports, need serialization.
CONFIG_PCI_LOCKLESS_CONFIG removes the use of pci_lock for that, and I
think that part makes sense regardless of whether devices can enter D
states.

We *should* prevent config accesses during D-state transitions (per
PCIe r5.0, sec 5.9), but I don't think pci_lock ever did that.
pci_raw_set_power_state() contains delays, but that only prevents
accesses from the caller, not from other threads or from userspace.
I suppose we should also prevent accesses by other threads during
transitions done by ACPI, e.g., _PS0, _PS1, _PS2, _PS3.  AFAICT we
don't do any of that.

It looks like pci_lock currently:

  - Serializes all kernel config accesses system-wide in
    pci_bus_read_config_##size() (unless CONFIG_PCI_LOCKLESS_CONFIG=y).

  - Serializes all userspace config accesses system-wide in
    pci_user_read_config_##size() (this seems unnecessary when
    CONFIG_PCI_LOCKLESS_CONFIG=y).

  - Serializes userspace config accesses with resets of the device via
    the dev->block_cfg_access bit and waitqueue mechanism.

  - Serializes kernel and userspace config accesses with bus->ops
    changes in pci_bus_set_ops() (except that we don't serialize
    kernel config accesses if CONFIG_PCI_LOCKLESS_CONFIG=y, which is
    probably a problem).  But pci_bus_set_ops() is hardly used and I'm
    not sure it's worth keeping it.

> 2. Commit a2e27787f893621c5a6b865acf6b7766f8671328 (jan kiszka)
>    exports pci_lock.  I think this is a mistake; at best there should be
>    accessors for the pci_lock.  But I don't understand why it needs to
>    exclude PCI config space changes throughout pci_check_and_set_intx_mask().
>    Why can it not do:
> 
> -	bus->ops->read(bus, dev->devfn, PCI_COMMAND, 4, &cmd_status_dword);
> +	pci_read_config_dword(dev, PCI_COMMAND, &cmd_status_dword);
> 
> 3. I don't understand why 511dd98ce8cf6dc4f8f2cb32a8af31ce9f4ba4a1
>    changed pci_lock to be a raw spinlock.  The patch description
>    essentially says "We need it for RT" which isn't terribly helpful.
> 
> 4. Finally, getting back to the original problem report here, I wouldn't
>    write this code this way today.  There's no reason not to use the
>    regular add_wait_queue etc.  BUT!  Why are we using this custom locking
>    mechanism?  It pretty much screams to me of an rwsem (reads/writes
>    of config space take it for read; changes to config space accesses
>    (disabling and changing of accessor methods) take it for write.

So maybe the immediate thing is to just convert to add_wait_queue()?

There's a lot we could clean up here, but I think it would take a fair
bit of untangling before we actually solve this panic.

Bjorn
