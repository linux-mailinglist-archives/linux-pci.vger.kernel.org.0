Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDEE2AFAAA
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 22:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgKKVoG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 16:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVoG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 16:44:06 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42AFC0613D1;
        Wed, 11 Nov 2020 13:44:05 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1kcxuF-0003RF-Um; Wed, 11 Nov 2020 22:43:55 +0100
Date:   Wed, 11 Nov 2020 22:43:55 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ley Foon Tan <ley.foon.tan@intel.com>,
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
Message-ID: <20201111214355.puinncgf3aksxh73@viti.kaiser.cx>
References: <20201110212134.GA692694@bjorn-Precision-5520>
 <20201110214518.GA694359@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110214518.GA694359@bjorn-Precision-5520>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thus wrote Bjorn Helgaas (helgaas@kernel.org):

> [+cc Florian, sorry, I hadn't seen your ack when I sent the below]

> On Tue, Nov 10, 2020 at 03:21:36PM -0600, Bjorn Helgaas wrote:
> > [+cc Nicolas, Jingoo, Gustavo, Toan]

> > On Sun, Nov 08, 2020 at 08:11:40PM +0100, Martin Kaiser wrote:
> > > Replace the two separate calls for removing the irq handler and data with a
> > > single irq_set_chained_handler_and_data() call.

> > This is similar to these:

> >   36f024ed8fc9 ("PCI/MSI: pci-xgene-msi: Consolidate chained IRQ handler install/remove")
> >   5168a73ce32d ("PCI/keystone: Consolidate chained IRQ handler install/remove")
> >   2cf5a03cb29d ("PCI/keystone: Fix race in installing chained IRQ handler")

> > and it seems potentially important that this removes the IRQ handler
> > and data *atomically*, i.e., both are done while holding
> > irq_get_desc_buslock().  

Ok, understood.

> > So I would use this:

> >   PCI: altera-msi: Fix race in installing chained IRQ handler

> >   Fix a race where a pending interrupt could be received and the handler
> >   called before the handler's data has been setup by converting to
> >   irq_set_chained_handler_and_data().

> >   See also 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained
> >   IRQ handler").

> > to make it clear that this is actually a bug fix, not just a cleanup.

Thomas' commit 2cf5a03cb29d fixed a case where the handler was installed.
We're removing the handler here so his commit message doesn't really fit.
Anyway, I'll rewrite the commit message to clarify that this fixes a
race condition.

> > Looks like this should also be done in dw_pcie_free_msi() and

I'll send a patch for this.

> > xgene_msi_hwirq_alloc() at the same time?

This function uses the error status from irq_set_handler_data().
irq_set_chained_handler_and_data() returns no such error status. Is it
ok to drop the error handling?

Thanks,
Martin
