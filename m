Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F442AFB35
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 23:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgKKWQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 17:16:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgKKWQl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 17:16:41 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82FDB2087D;
        Wed, 11 Nov 2020 22:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605133000;
        bh=FZoIL5kkoczQ08cE+5NFuJQjvnQXcPDad7/rPnvpuM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OyYUE+sWkg5lC/BrEnbRDr2hQEyTSlpTIWkU8rEkXleT/ddF5+m/OqWTY0QE6KkZU
         cZNMhDmrmscHakgy9rXjIJ2IJP2iyPNXu8ebZlLfx+gdXvk6ZDLSFeRU5hIbM2nKMj
         f0R/Fed5vT0l4+pI9H8+OGi9/4xGHbBgyMq88nyY=
Date:   Wed, 11 Nov 2020 16:16:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        rfi@lists.rocketboards.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] PCI: altera-msi: Remove irq handler and data in one go
Message-ID: <20201111221639.GA973514@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111214355.puinncgf3aksxh73@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas for handler/data order question at end]

On Wed, Nov 11, 2020 at 10:43:55PM +0100, Martin Kaiser wrote:
> Thus wrote Bjorn Helgaas (helgaas@kernel.org):
> > On Tue, Nov 10, 2020 at 03:21:36PM -0600, Bjorn Helgaas wrote:
> > > On Sun, Nov 08, 2020 at 08:11:40PM +0100, Martin Kaiser wrote:
> > > > Replace the two separate calls for removing the irq handler and data with a
> > > > single irq_set_chained_handler_and_data() call.
> 
> > > This is similar to these:
> 
> > >   36f024ed8fc9 ("PCI/MSI: pci-xgene-msi: Consolidate chained IRQ handler install/remove")
> > >   5168a73ce32d ("PCI/keystone: Consolidate chained IRQ handler install/remove")
> > >   2cf5a03cb29d ("PCI/keystone: Fix race in installing chained IRQ handler")
> 
> > > and it seems potentially important that this removes the IRQ handler
> > > and data *atomically*, i.e., both are done while holding
> > > irq_get_desc_buslock().  
> 
> Ok, understood.
> 
> > > So I would use this:
> 
> > >   PCI: altera-msi: Fix race in installing chained IRQ handler
> 
> > >   Fix a race where a pending interrupt could be received and the handler
> > >   called before the handler's data has been setup by converting to
> > >   irq_set_chained_handler_and_data().
> 
> > >   See also 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained
> > >   IRQ handler").
> 
> > > to make it clear that this is actually a bug fix, not just a cleanup.
> 
> Thomas' commit 2cf5a03cb29d fixed a case where the handler was installed.
> We're removing the handler here so his commit message doesn't really fit.
> Anyway, I'll rewrite the commit message to clarify that this fixes a
> race condition.

Oh, right, of course, I wasn't paying attention.  The altera case is
removing and doing it in the correct order (removing handler, then
data), so there shouldn't be a race even with the current code.

> > > Looks like this should also be done in dw_pcie_free_msi() and
> 
> I'll send a patch for this.
> 
> > > xgene_msi_hwirq_alloc() at the same time?
> 
> This function uses the error status from irq_set_handler_data().
> irq_set_chained_handler_and_data() returns no such error status. Is it
> ok to drop the error handling?

I'm not an IRQ expert, but I'd say it's OK to drop it.  Of the 40 or
so callers, the only other caller that looks at the error status is
ingenic_intc_of_init().

Thomas, it looks like irq_domain_set_info() and msi_domain_ops_init()
set the handler itself before setting the handler data:

  irq_domain_set_info
    irq_set_chip_and_handler_name(virq, chip, handler, ...)
    irq_set_handler_data(virq, handler_data)

  msi_domain_ops_init
    __irq_set_handler(virq, info->handler, ...)
    if (info->handler_data)
      irq_set_handler_data(virq, info->handler_data)

That looks at least superficially similar to the race you fixed with
2cf5a03cb29d ("PCI/keystone: Fix race in installing chained IRQ
handler").

Should irq_domain_set_info() and msi_domain_ops_init() swap the order,
too?
