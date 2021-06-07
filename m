Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556C939E8FF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 23:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFGVUM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 17:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230359AbhFGVUM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 17:20:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 520806109F;
        Mon,  7 Jun 2021 21:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623100700;
        bh=UZGmBdnbVWm8mCbra/+PV/yUR200sqqHIL3AOoDv0y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gzQzcdYz+xeX4q9mlDbN0cWW9+Q4fVemfJFTV5lL9H2HQzUPBhljzBudwAiw6WbT4
         WtszooesSqYWS2WciECSYJ2UX3cDYxTgislr/llrWBkcCV2siLIdu8xhGARNqr1CeN
         6SixUJPDYE9TGLbFTHYoGTEyTOB21ESloUKBQ8R+sseBjnaYRDxv4IC7YPG5b7KhPY
         AAb3svU5eebBB2Nbz8aaYGbHNSJskQWHGNfWzpSn8npRZ1i40u7sgjB9DbQHFloCGC
         rPSAi9xBlNw4fcdOXZA3xKWLWwG/9Oy65FZhlJqOWm4h8fdzj0fecdbQ4CsVqbAn8u
         xQxZPEYwkvI5A==
Received: by pali.im (Postfix)
        id BC6747DF; Mon,  7 Jun 2021 23:18:17 +0200 (CEST)
Date:   Mon, 7 Jun 2021 23:18:17 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Sandor Bodo-Merle <sbodomerle@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/2] PCI: iproc: Support multi-MSI only on uniprocessor
 kernel
Message-ID: <20210607211817.fy2necxy5mxow6rg@pali>
References: <20210606123044.31250-1-sbodomerle@gmail.com>
 <20210606123044.31250-2-sbodomerle@gmail.com>
 <927a977c-5bd5-3df1-c990-d817b0759654@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <927a977c-5bd5-3df1-c990-d817b0759654@broadcom.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 07 June 2021 09:48:21 Ray Jui wrote:
> On 6/6/2021 5:30 AM, Sandor Bodo-Merle wrote:
> > The interrupt affinity scheme used by this driver is incompatible with
> > multi-MSI as it implies moving the doorbell address to that of another MSI
> > group.  This isn't possible for multi-MSI, as all the MSIs must have the
> > same doorbell address. As such it is restricted to systems with a single
> > CPU.
> > 
> > Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> > Reported-by: Marc Zyngier <maz@kernel.org>
> > Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-iproc-msi.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> > index 557d93dcb3bc..81b4effeb130 100644
> > --- a/drivers/pci/controller/pcie-iproc-msi.c
> > +++ b/drivers/pci/controller/pcie-iproc-msi.c
> > @@ -171,7 +171,7 @@ static struct irq_chip iproc_msi_irq_chip = {
> >  
> >  static struct msi_domain_info iproc_msi_domain_info = {
> >  	.flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> > -		MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
> > +		MSI_FLAG_PCI_MSIX,
> >  	.chip = &iproc_msi_irq_chip,
> >  };
> >  
> > @@ -250,6 +250,9 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
> >  	struct iproc_msi *msi = domain->host_data;
> >  	int hwirq, i;
> >  
> > +	if (msi->nr_cpus > 1 && nr_irqs > 1)
> > +		return -EINVAL;
> > +
> 
> This should never happen since the framework would have guarded against
> this. But I guess it does not hurt to have the check here.

Yes, this should not happen, but I suggested to add a comment or assert
or some other way to document this kind of constrain. Lot of times code
is copy+pasted to new drivers and because only this one driver has
.alloc function which is using nr_cpus for allocating msi bitmap, it
really makes sense to document this constrain also explicitly.

> >  	mutex_lock(&msi->bitmap_lock);
> >  
> >  	/*
> > @@ -540,6 +543,9 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
> >  	mutex_init(&msi->bitmap_lock);
> >  	msi->nr_cpus = num_possible_cpus();
> >  
> > +	if (msi->nr_cpus == 1)
> > +		iproc_msi_domain_info.flags |=  MSI_FLAG_MULTI_PCI_MSI;
                                              ^^
Just a small note: there are two spaces instead of just one

Otherwise looks good to me:

Acked-by: Pali Rohár <pali@kernel.org>

> > +
> >  	msi->nr_irqs = of_irq_count(node);
> >  	if (!msi->nr_irqs) {
> >  		dev_err(pcie->dev, "found no MSI GIC interrupt\n");
> > 
> 
> Looks fine to me. Thanks.
> 
> Acked-by: Ray Jui <ray.jui@broadcom.com>
