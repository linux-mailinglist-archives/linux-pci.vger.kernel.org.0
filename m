Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02622E2BC0
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 10:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438010AbfJXIH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 04:07:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52704 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfJXIH3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Oct 2019 04:07:29 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNY9U-0000HG-T3; Thu, 24 Oct 2019 10:07:25 +0200
Date:   Thu, 24 Oct 2019 10:07:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Xiang Zheng <zhengxiang9@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, alex.williamson@redhat.com,
        Wang Haibin <wanghaibin.wang@huawei.com>,
        Guoheyi <guoheyi@huawei.com>,
        yebiaoxiang <yebiaoxiang@huawei.com>
Subject: Re: Kernel panic while doing vfio-pci hot-plug/unplug test
In-Reply-To: <20191023163851.GA2963@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.21.1910241001250.1852@nanos.tec.linutronix.de>
References: <2e7293dc-eb27-bce3-c209-e0ba15409f16@huawei.com> <20191023151540.GA168080@google.com> <20191023163851.GA2963@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 23 Oct 2019, Matthew Wilcox wrote:
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

I don't think that it's broken. A D-state transition has to make sure that
the rest of stuff which might be touching the config space is
quiescent. pci_lock cannot provide that protection
 
> 
> 2. Commit a2e27787f893621c5a6b865acf6b7766f8671328 (jan kiszka)
>    exports pci_lock.  I think this is a mistake; at best there should be
>    accessors for the pci_lock.  But I don't understand why it needs to
>    exclude PCI config space changes throughout pci_check_and_set_intx_mask().
>    Why can it not do:
> 
> -	bus->ops->read(bus, dev->devfn, PCI_COMMAND, 4, &cmd_status_dword);
> +	pci_read_config_dword(dev, PCI_COMMAND, &cmd_status_dword);

Hmm. Need to look closer on that.
 
> 3. I don't understand why 511dd98ce8cf6dc4f8f2cb32a8af31ce9f4ba4a1
>    changed pci_lock to be a raw spinlock.  The patch description
>    essentially says "We need it for RT" which isn't terribly helpful.

Yes, I could slap myself for writing such a useless changelog. The reason
why it is a raw spinlock is that config space access happens from very low
level contexts, which require to have interrupts disabled even on RT,
e.g. from the guts of the interrupt code.

> 4. Finally, getting back to the original problem report here, I wouldn't
>    write this code this way today.  There's no reason not to use the
>    regular add_wait_queue etc.  BUT!  Why are we using this custom locking
>    mechanism?  It pretty much screams to me of an rwsem (reads/writes
>    of config space take it for read; changes to config space accesses
>    (disabling and changing of accessor methods) take it for write.

You cannot use a RWSEM as low level interrupt code needs to access the
config space with interrupts disabled and raw spinlocks held, e.g. to
fiddle with the interrupt and MSI stuff.

Thanks,

	tglx


    
