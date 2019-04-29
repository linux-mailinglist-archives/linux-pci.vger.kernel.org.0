Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF292DA43
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2019 02:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfD2AwZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Apr 2019 20:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfD2AwZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Apr 2019 20:52:25 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FBB420652;
        Mon, 29 Apr 2019 00:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556499144;
        bh=7pE6K//V7zwBBFvEvP7+1YH5/ewAhy52lw190q/vHDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plDKryjCwm6pPTiowYC6gXLb9oZx4EQURMBHS2uYcTTe+3r6oXNCE57Q1PQJOANgR
         0qMYpdwLBAgOBbCS90agW19vFlrWq2UjeM1qFynopCmfcZIsppM/h9o7CosP2pL1bX
         vrbp2TYINWZiIMjkXKFRnp2saVH7c8Hm7bBO2Ugc=
Date:   Sun, 28 Apr 2019 19:52:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     fred@fredlawl.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH 1/4] PCI: Replace dev_*() printk wrappers with pci_*()
 printk wrappers
Message-ID: <20190429005222.GO14616@google.com>
References: <20190427191304.32502-1-fred@fredlawl.com>
 <20190427191304.32502-2-fred@fredlawl.com>
 <20190429000258.GK14616@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429000258.GK14616@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 28, 2019 at 07:02:58PM -0500, Bjorn Helgaas wrote:
> On Sat, Apr 27, 2019 at 02:13:01PM -0500, fred@fredlawl.com wrote:
> > From: Frederick Lawler <fred@fredlawl.com>
> > 
> > Replace remaining instances of dev_*() printk wrappers with pci_*()
> > printk wrappers. No functional change intended.
> > 
> > Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> > ---
> >  drivers/pci/pcie/aer.c        | 13 ++++++-------
> >  drivers/pci/pcie/aer_inject.c |  4 ++--
> >  drivers/pci/pcie/dpc.c        | 27 ++++++++++++---------------
> >  3 files changed, 20 insertions(+), 24 deletions(-)

> >  	aer_enable_rootport(rpc);
> > -	dev_info(device, "AER enabled with IRQ %d\n", dev->irq);
> > +	pci_info(pdev, "AER enabled with IRQ %d\n", dev->irq);
> 
> And this, and many others below.  *This* patch should only convert
> 
>   - pci_printk(KERN_DEBUG, pdev, ...)
>   + pci_info(pdev, ...)
> 
> and
> 
>   - dev_printk(KERN_DEBUG, pcie_dev, ...)
>   + dev_info(pcie_dev, ...)

Just to clarify, I do *want* both changes, just in separate patches.
So we'd have

  1) Convert KERN_DEBUG uses to pci_info() for pci_dev usage and to
     dev_info() for pcie_device usage.  I think pciehp is probably an
     exception to this; this patch shouldn't touch ctrl_dbg().

  2) Convert "dev_info(pcie_device)" to "pci_info(pci_dev)".  It might
     be worth doing this in separate patches for each service.  If we
     decide they're simple enough to combine, that's trivial for me to
     do.  It's a little more hassle to split things up afterwards.

     In pciehp, if you do this in the ctrl_*() definitions, it will
     make the patch much smaller.

  3) In pciehp, ctrl_dbg() could probably be changed to use pci_dbg()
     so we'd use the standard kernel dynamic debug stuff instead of
     having the pciehp-specific module parameter.

Thanks a lot for working on all this.  I think it will make the user
experience significantly simpler.

Bjorn
