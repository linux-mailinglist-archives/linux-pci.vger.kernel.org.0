Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3804A170
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 15:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfFRNDQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 09:03:16 -0400
Received: from foss.arm.com ([217.140.110.172]:39962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRNDP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jun 2019 09:03:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 130192B;
        Tue, 18 Jun 2019 06:03:15 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EDAE3F246;
        Tue, 18 Jun 2019 06:03:13 -0700 (PDT)
Date:   Tue, 18 Jun 2019 14:03:08 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v4] PCI: xilinx-nwl: Fix Multi MSI data programming
Message-ID: <20190618130308.GA9002@e121166-lin.cambridge.arm.com>
References: <1560334679-9206-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20190617092108.GA18020@e121166-lin.cambridge.arm.com>
 <CH2PR02MB6453032A01A540F5E9C58402A5EA0@CH2PR02MB6453.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR02MB6453032A01A540F5E9C58402A5EA0@CH2PR02MB6453.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 12:28:02PM +0000, Bharat Kumar Gogada wrote:

[...]

> > Applied to pci/xilinx for v5.3, please have a look and check if the commit log
> > I wrote provides a clear description of the issue.
> > 
> > Lorenzo
> Thanks Lorenzo and Marc.
> Lorenzo, can you please point to link for above commit.

I did already.

Anyway:

https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?h=pci/xilinx&id=46c1bfcfcd873f8754f733e4258121748bcae3a3

> Regards,
> Bharat
> > > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> > > b/drivers/pci/controller/pcie-xilinx-nwl.c
> > > index 81538d7..a9e07b8 100644
> > > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > > @@ -483,15 +483,13 @@ static int nwl_irq_domain_alloc(struct
> > irq_domain *domain, unsigned int virq,
> > >  	int i;
> > >
> > >  	mutex_lock(&msi->lock);
> > > -	bit = bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
> > > -					 nr_irqs, 0);
> > > -	if (bit >= INT_PCI_MSI_NR) {
> > > +	bit = bitmap_find_free_region(msi->bitmap, INT_PCI_MSI_NR,
> > > +				      get_count_order(nr_irqs));
> > > +	if (bit < 0) {
> > >  		mutex_unlock(&msi->lock);
> > >  		return -ENOSPC;
> > >  	}
> > >
> > > -	bitmap_set(msi->bitmap, bit, nr_irqs);
> > > -
> > >  	for (i = 0; i < nr_irqs; i++) {
> > >  		irq_domain_set_info(domain, virq + i, bit + i, &nwl_irq_chip,
> > >  				domain->host_data, handle_simple_irq, @@
> > -509,7 +507,8 @@ static
> > > void nwl_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> > >  	struct nwl_msi *msi = &pcie->msi;
> > >
> > >  	mutex_lock(&msi->lock);
> > > -	bitmap_clear(msi->bitmap, data->hwirq, nr_irqs);
> > > +	bitmap_release_region(msi->bitmap, data->hwirq,
> > > +			      get_count_order(nr_irqs));
> > >  	mutex_unlock(&msi->lock);
> > >  }
> > >
> > > --
> > > 2.7.4
> > >
