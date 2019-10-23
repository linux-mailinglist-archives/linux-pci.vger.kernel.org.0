Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DA0E20C9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 18:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbfJWQiy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 12:38:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733010AbfJWQiy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Oct 2019 12:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g0rPJmNeTmtTxNbr9OQMo3pBMMOXbOS/kJjZ7bJPmkI=; b=nphQWFQTNkKWc5QEe0IdwN48p
        e/VdIDPsCZ/c9RDmnxJUMa9yie4sKXvvh5uKsghz7UEVLbTPSt7HaieuqgIclq78S9N8TcOlNL/On
        mZL9B3uUIx/kyZbqwOP08sMO1ZE2lF/nY7TzlScTyC9fSYg2QIf35ETmp8P89CLwn8wOLrIn427vc
        bKlwsqLVUZYwa7D3ipzUWGPSlB7anlyJfPnFuvW7UZ2PP2IwLsBf7goWrHV1t6pm2qTi3w48p8DB/
        7J3oJUsvc8Lw1ds9p6DAlqqMUpw4lFBDFPnP1py5RsoCR3CZtMqbXckqMUBG+elvZsabhMdFNK9c6
        yu3O+3K9w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNJeu-0001Ny-0e; Wed, 23 Oct 2019 16:38:52 +0000
Date:   Wed, 23 Oct 2019 09:38:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Xiang Zheng <zhengxiang9@huawei.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, alex.williamson@redhat.com,
        Wang Haibin <wanghaibin.wang@huawei.com>,
        Guoheyi <guoheyi@huawei.com>,
        yebiaoxiang <yebiaoxiang@huawei.com>
Subject: Re: Kernel panic while doing vfio-pci hot-plug/unplug test
Message-ID: <20191023163851.GA2963@bombadil.infradead.org>
References: <2e7293dc-eb27-bce3-c209-e0ba15409f16@huawei.com>
 <20191023151540.GA168080@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023151540.GA168080@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 10:15:40AM -0500, Bjorn Helgaas wrote:
> I don't like being one of a handful of callers of __add_wait_queue(),
> so I like that solution from that point of view.
> 
> The 7ea7e98fd8d0 ("PCI: Block on access to temporarily unavailable pci
> device") commit log suggests that using __add_wait_queue() is a
> significant optimization, but I don't know how important that is in
> practical terms.  Config accesses are never a performance path anyway,
> so I'd be inclined to use add_wait_queue() unless somebody complains.

Wow, this has got pretty messy in the umpteen years since I last looked
at it.

Some problems I see:

1. Commit df65c1bcd9b7b639177a5a15da1b8dc3bee4f5fa (tglx) says:

    x86/PCI: Select CONFIG_PCI_LOCKLESS_CONFIG
    
    All x86 PCI configuration space accessors have either their own
    serialization or can operate completely lockless (ECAM).
    
    Disable the global lock in the generic PCI configuration space accessors.

The concept behind this patch is broken.  We still need to lock out
config space accesses when devices are undergoing D-state transitions.
I would suggest that for the contention case that tglx is concerned about,
we should have a pci_bus_read_config_unlocked_##size set of functions
which can be used for devices we know never go into D states.


2. Commit a2e27787f893621c5a6b865acf6b7766f8671328 (jan kiszka)
   exports pci_lock.  I think this is a mistake; at best there should be
   accessors for the pci_lock.  But I don't understand why it needs to
   exclude PCI config space changes throughout pci_check_and_set_intx_mask().
   Why can it not do:

-	bus->ops->read(bus, dev->devfn, PCI_COMMAND, 4, &cmd_status_dword);
+	pci_read_config_dword(dev, PCI_COMMAND, &cmd_status_dword);

3. I don't understand why 511dd98ce8cf6dc4f8f2cb32a8af31ce9f4ba4a1
   changed pci_lock to be a raw spinlock.  The patch description
   essentially says "We need it for RT" which isn't terribly helpful.

4. Finally, getting back to the original problem report here, I wouldn't
   write this code this way today.  There's no reason not to use the
   regular add_wait_queue etc.  BUT!  Why are we using this custom locking
   mechanism?  It pretty much screams to me of an rwsem (reads/writes
   of config space take it for read; changes to config space accesses
   (disabling and changing of accessor methods) take it for write.

