Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D946B2B078A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 15:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgKLO1B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 09:27:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLO1A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Nov 2020 09:27:00 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B1462065C;
        Thu, 12 Nov 2020 14:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605191219;
        bh=1IoHlqpsRwY5CT95U1E/+G3sJL3pYss31+rujjdCFjo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gOgejDqqkdm78cAdn75U1X8N2FUHKqdLNQVNGnfvP8TpiZoTC4SdxKtAeU/QD+oQ5
         8Fa+0o9MxbDmYvXA9/NEcyOX9JmKLwjtbYW60gFwnkjA9iPqtmrXTnrKydmKTrWody
         ttSKopvLl3XNUk4yDS8LAiQxjDnbiuNZGmv7uRmo=
Date:   Thu, 12 Nov 2020 08:26:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        rfi@lists.rocketboards.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] PCI: altera-msi: Remove irq handler and data in one go
Message-ID: <20201112142657.GA1011805@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn4in0p9.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 12, 2020 at 02:50:42PM +0100, Thomas Gleixner wrote:
> On Thu, Nov 12 2020 at 12:28, Thomas Gleixner wrote:
> > On Wed, Nov 11 2020 at 16:16, Bjorn Helgaas wrote:
> >> On Wed, Nov 11, 2020 at 10:43:55PM +0100, Martin Kaiser wrote:
> >> Thomas, it looks like irq_domain_set_info() and msi_domain_ops_init()
> >> set the handler itself before setting the handler data:
> >>
> >>   irq_domain_set_info
> >>     irq_set_chip_and_handler_name(virq, chip, handler, ...)
> >>     irq_set_handler_data(virq, handler_data)
> >>
> >>   msi_domain_ops_init
> >>     __irq_set_handler(virq, info->handler, ...)
> >>     if (info->handler_data)
> >>       irq_set_handler_data(virq, info->handler_data)
> >>
> >> That looks at least superficially similar to the race you fixed with
> >> 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained IRQ
> >> handler").
> >>
> >> Should irq_domain_set_info() and msi_domain_ops_init() swap the order,
> >> too?
> >
> > In theory yes. Practically it should not matter because that happens
> > during the allocation way before the interrupt can actually fire.  I'll
> > have a deeper look nevertheless.
> 
> So I had a closer look and the reason why it only matters for the
> chained handler case is that
> 
>    __irq_set_handler(..., is_chained = true, ...)
> 
> starts up the interrupt immediately. So the order for this _must_ be:
> 
>     set_handler_data() -> set_handler()
> 
> For regular interrupts it's really the mapping and allocation code which
> does this long before the interrupt is started up. So the ordering does
> not matter because the handler can't be reached before the full
> setup is finished and the interrupt is actually started up.

If the order truly doesn't matter here, maybe it's worth changing it
to "set data, set handler" to avoid the need for a closer look to
verify correctness and to make it harder to copy and paste to a place
where it *does* matter?

Bjorn
