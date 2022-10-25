Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE8760D7DA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 01:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJYXZm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 19:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJYXZk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 19:25:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23767CB5C;
        Tue, 25 Oct 2022 16:25:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ECA361BE6;
        Tue, 25 Oct 2022 23:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E2FC433C1;
        Tue, 25 Oct 2022 23:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666740337;
        bh=JI9+G0utVnDISU3eKZ+IFSXABRRbK+KjVSsQJwwU+Lo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=URH91g8mS5F8lgKSVJTZwdFSqTsaEirhrMyXpLE/1JjH0I7JiaE01p5jDLPLhbMCm
         Q6ubwSSAHOqaVtMS8RlD0bJoC5Vie9m7Ptokieonj+zdltycmoVosY+Cff9VjWkM8a
         ul6Xy2vFGmfunP2ytWGsHxmvGl4NDyAbqIUqD2anu5N0JJ8xA5F4a0BjBX26+SKMCs
         W1jSxoqhsZxYAmKo/YDBVKEHp0VGnVnhtfqSl88X5UHoO2iAYbYpFPYhBjaRW03oNj
         ehbK3nsoNDLb7Mepg0K5IAt6yqpUlYeEik7K60k9ABN2f+KiYgOWZRjkc+HzjX1sG+
         kee7PK3CqBO1A==
Date:   Tue, 25 Oct 2022 18:25:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com,
        alison.schofield@intel.com, bwidawsk@kernel.org,
        vishal.l.verma@intel.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221025232535.GA579167@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024133633.00000467@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christoph, beginning of thread https://lore.kernel.org/r/20221018030010.20913-2-dave@stgolabs.net]

On Mon, Oct 24, 2022 at 01:36:33PM +0100, Jonathan Cameron wrote:
> On Sun, 23 Oct 2022 19:08:57 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> > Ira Weiny wrote:
> > > On Sat, Oct 22, 2022 at 03:05:45PM -0700, Dan Williams wrote:  
> > > > Davidlohr Bueso wrote:  
> > > > > Introduce a generic irq table for CXL components/features that can have
> > > > > standard irq support - DOE requires dynamic vector sizing and is not
> > > > > considered here. For now the table is empty.
> > > > > 
> > > > > Create an infrastructure to query the max vectors required for the CXL
> > > > > device. Upon successful allocation, users can plug in their respective isr
> > > > > at any point thereafter, which is supported by a new cxlds->has_irq flag,
> > > > > for example, if the irq setup is not done in the PCI driver, such as
> > > > > the case of the CXL-PMU.
> > > > > 
> > > > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > > > > ---
> > > > >  drivers/cxl/cxlmem.h |  3 ++
> > > > >  drivers/cxl/pci.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++
> > > > >  2 files changed, 75 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > > > index 88e3a8e54b6a..72b69b003302 100644
> > > > > --- a/drivers/cxl/cxlmem.h
> > > > > +++ b/drivers/cxl/cxlmem.h
> > > > > @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
> > > > >   * @info: Cached DVSEC information about the device.
> > > > >   * @serial: PCIe Device Serial Number
> > > > >   * @doe_mbs: PCI DOE mailbox array
> > > > > + * @has_irq: PCIe MSI-X/MSI support
> > > > >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> > > > >   *
> > > > >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > > > > @@ -247,6 +248,8 @@ struct cxl_dev_state {
> > > > >  
> > > > >  	struct xarray doe_mbs;
> > > > >  
> > > > > +	bool has_irq;
> > > > > +
> > > > >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> > > > >  };
> > > > >  
> > > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > > index faeb5d9d7a7a..9c3e95ebaa26 100644
> > > > > --- a/drivers/cxl/pci.c
> > > > > +++ b/drivers/cxl/pci.c
> > > > > @@ -428,6 +428,73 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > > > >  	}
> > > > >  }
> > > > >  
> > > > > +/**
> > > > > + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI-X/MSI irqs.
> > > > > + *
> > > > > + * @name: Name of the device/component generating this interrupt.
> > > > > + * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
> > > > > + *		    feature does not have the Interrupt Supported bit set, then
> > > > > + *		    return -1.
> > > > > + */
> > > > > +struct cxl_irq_cap {
> > > > > +	const char *name;
> > > > > +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);  
> > > > 
> > > > Why is this a callback, why not just have the features populate their
> > > > irq numbers?  
> > > 
> > > I think we have decided to forgo the callback but I'm not sure what you mean by
> > > 'populate their irq numbers'?
> > >   
> > > >   
> > > > > +};
> > > > > +
> > > > > +static const struct cxl_irq_cap cxl_irq_cap_table[] = {
> > > > > +	NULL
> > > > > +};
> > > > > +
> > > > > +static void cxl_pci_free_irq_vectors(void *data)
> > > > > +{
> > > > > +	pci_free_irq_vectors(data);
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Attempt to allocate the largest amount of necessary vectors.
> > > > > + *
> > > > > + * Returns 0 upon a successful allocation of *all* vectors, or a
> > > > > + * negative value otherwise.
> > > > > + */
> > > > > +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> > > > > +{
> > > > > +	struct device *dev = cxlds->dev;
> > > > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > > > +	int rc, i, vectors = -1;
> > > > > +
> > > > > +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
> > > > > +		int irq;
> > > > > +
> > > > > +		if (!cxl_irq_cap_table[i].get_max_msgnum)
> > > > > +			continue;
> > > > > +
> > > > > +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
> > > > > +		vectors = max_t(int, irq, vectors);
> > > > > +	}  
> > > > 
> > > > Forgive me if I have missed something, I only look at interrupt enable
> > > > code once every few years, and the APIs are always a bit different, but
> > > > is this not too early to read the message number? The number is not
> > > > stable until either MSI or MSI-X has been selected below at
> > > > pci_alloc_irq_vectors() time?  
> > >  
> > > Well I keep getting wrapped around the axle on this one too.
> > > 
> > > This all started back when Jonathan originally attempted to
> > > allocate the maximum number of vectors a device _could_
> > > allocate.  But it was recommended that we determine the max
> > > number first then allocate that number.
> > > 
> > > This seems like a chicken and egg issue.  How is the number not
> > > stable before calling pci_alloc_irq_vectors() when you need the
> > > max msg number in that call?  
> > 
> > Are we talking about the same thing? I am talking about the value in the
> > "Interrupt Message Number" field. That depends on whether MSI or MSI-X
> > gets enabled. The number of vectors the device can support is static.
> > 
> > Since CXL is such an a la carte spec I think this is situation to just
> > specify a large number of amx vectors to pci_alloc_irq_vectors() and
> > then find out after the fact if all of the interrupt generators that
> > today's cxl_pci knows about in the device each got their own vector.
> 
> I'd misunderstood how this worked and not read the spec :( I wrongly
> thought portdrv did the query first and allocated the vectors after,
> but that's not the case.  It first allocates max entries, then frees
> them all and then allocates the ones that we find present.  We
> should probably look to do something similar to that though I'm not
> sure even that code is always optimal.
> 
> https://elixir.bootlin.com/linux/v6.1-rc2/source/drivers/pci/pcie/portdrv_core.c#L101
> 
> In short that calls:
> /* Allocate the maximum possible number of MSI/MSI-X vectors */
> nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
> 			PCI_IRQ_MSIX | PCI_IRQ_MSI);
> 
> /* See how many and which Interrupt Message Numbers we actually use */
> nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);
> 
> if (nvec != nr_entries) {
> 	pci_free_irq_vectors(dev);
> 
> 	nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
> 			PCI_IRQ_MSIX | PCI_IRQ_MSI);
> }
> 
> My worry here is that the implicit assumption is that the vectors
> won't move if we reduce the overall number of vectors we are asking
> for...
> 
> However, imagine the case that we have a feature the driver doesn't
> know about that was previously at a higher vector.  After reducing
> the vectors allocated the hardware might decide that feature needs
> its own vector whereas some others can be combined.  Hence we'd end
> up with a less than ideal packing for the features we actually
> support.
> 
> Could do something iterative to solve this if it actually matters
> (increase number of vectors until the layout matches what we get
> with max possible vectors).

Is this cxl code allocating vectors for devices that might also be
claimed by portdrv?  I assume not because that sounds like a problem.

Ugh.  I always feel like the portdrv design must be sub-optimal
because this seems so hard to do cleanly.

pci_alloc_irq_vectors() has a lot of magic inside it and is great for
most drivers, but the PCIe service IRQs are definitely unusual and
maybe it's not the best fit for this situation.

If I understand correctly, Interrupt Message Numbers for all these
PCIe services (hotplug, AER, DPC, etc) are restricted to 0-31 for both
MSI and MSI-X, and the reason we don't just allocate 32 vectors all
the time is to avoid consuming too many IRQs.

The MSI case is ugly because the Interrupt Message Number can change
when we set Multiple Message Enable.  Maybe we can separate it out and
have a less than optimal solution for this case, like allocating one
or two vectors and polling if that's not enough.  I expect most
devices will support MSI-X.

For MSI-X, the vector table is in a BAR, so IIUC there's no resource
pressure until we actually assign an IRQ to a vector.  Would it be
feasible to always allocate vectors 0-31 of the MSI-X Table, and then
selectively allocate IRQs for the services we need, so we might
consume 32 MSI-X vectors but only a handful of IRQs?

Bjorn
