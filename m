Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 862D018C356
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 23:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgCSWww (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 18:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgCSWwv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Mar 2020 18:52:51 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A1D3206D7;
        Thu, 19 Mar 2020 22:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584658370;
        bh=4iJFtuBMo87wnt6wZpaiJ+4GDnysLlZVMy3uErkY7YI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nGS71f+Cp6K/f3h8pftZt6yFGhSxOmsB4UdOy/rTqcDXGOdoeG2TB1pompXBz2RPG
         D4B2TYl48sWzsbD5c6/UvfBsrJVewO3hpPiIX/wn+jvjzwsiiy7HG2zs4TGvg8kWEn
         YvUAD7vrOWbRRddyrmAPj53DST+AXScperyD2M9c=
Date:   Thu, 19 Mar 2020 17:52:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     bjorn@helgaas.com,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v17 06/12] Documentation: PCI: Remove reset_link
 references
Message-ID: <20200319225248.GA12599@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317170654.GA23125@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 17, 2020 at 10:06:54AM -0700, Christoph Hellwig wrote:
> On Tue, Mar 17, 2020 at 11:03:36AM -0500, Bjorn Helgaas wrote:
> > On Tue, Mar 17, 2020 at 10:09 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > On Tue, Mar 17, 2020 at 08:05:50AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> > > > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > >
> > > > > This should be folded into the patch removing the method.
> > > > This is also folded in the mentioned patch.
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=review/edr&id=7a18dc6506f108db3dc40f5cd779bc15270c4183
> > >
> > > I can't find that series anywhere on the list.  What did I miss?
> > 
> > We've still been discussing other issues (access to AER registers,
> > synchronization between EDR and hotplug, etc) in other parts of this
> > thread.  The git branch Sathy pointed to above is my local branch.
> > I'll send it to the list before putting it into -next, but I wanted to
> > make progress on some of these other issues first.
> 
> A few nitpicks:
> 
> PCI/ERR: Update error status after reset_link():
> 
>  - there are two "if (state == pci_channel_io_frozen)"
>    right after each other now, merging them would make the code a little
>    easier to read.

Merged, thanks.

> PCI/DPC: Move DPC data into struct pci_dev:
> 
>  - dpc_rp_extensions probable should be a "bool : 1"

I actually had not seen "bool : 1" used, but you're right, there are
several.  There aren't any in drivers/pci, though, so I'm inclined to
stay consistent with "unsigned int : 1" unless there's an advantage,
and then I'd probably convert all of drivers/pci over.

My rule of thumb has been [1], where Linus suggests "unsigned int
percpu:1", but maybe that should be updated.

> PCI/ERR: Remove service dependency in pcie_do_recovery():
> 
>  - as mentioned to Kuppuswamy the reset_cb is never NULL, and thus
>    a lot of dead code in reset_link can be removed.

Agreed, thanks, I removed that dead code.

>    Also reset_link should be merged into pcie_do_recovery.  That
>    would also enable to call the argument reset_link, which might be
>    a bit more descriptive than reset_cb.

I didn't do this because it sounds like it might be a separate patch.
But maybe Sathy can do this in the next round?

> PCI/DPC: Cache DPC capabilities in pci_init_capabilities():
> 
>  - I think the pci_dpc_init could be cleaned up a bit to:
> 
> 	...
> 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
> 	if (!(cap & PCI_EXP_DPC_CAP_RP_EXT))
> 		return;
> 	pdev->dpc_rp_extensions = true;
> 	pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
> 	...

Nice, thanks!  I made this change, too.

Thanks a lot for reviewing this!

Bjorn


[1] https://lore.kernel.org/linux-arm-kernel/CA+55aFxnePDimkVKVtv3gNmRGcwc8KQ5mHYvUxY8sAQg6yvVYg@mail.gmail.com/
