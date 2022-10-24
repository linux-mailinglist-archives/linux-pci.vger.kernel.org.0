Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EDF60B1D3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiJXQi0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 12:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiJXQiE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 12:38:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974C9C8208;
        Mon, 24 Oct 2022 08:25:44 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MwvcM3MgZz6897v;
        Mon, 24 Oct 2022 20:33:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 24 Oct 2022 14:36:34 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 13:36:34 +0100
Date:   Mon, 24 Oct 2022 13:36:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <bwidawsk@kernel.org>,
        <vishal.l.verma@intel.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221024133633.00000467@huawei.com>
In-Reply-To: <6355f3b933235_1d21294da@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221018030010.20913-1-dave@stgolabs.net>
        <20221018030010.20913-2-dave@stgolabs.net>
        <63546939ea062_1419294f6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
        <Y1XX1tVLQoYmYnSM@iweiny-mobl>
        <6355f3b933235_1d21294da@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 23 Oct 2022 19:08:57 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Ira Weiny wrote:
> > On Sat, Oct 22, 2022 at 03:05:45PM -0700, Dan Williams wrote:  
> > > Davidlohr Bueso wrote:  
> > > > Introduce a generic irq table for CXL components/features that can have
> > > > standard irq support - DOE requires dynamic vector sizing and is not
> > > > considered here. For now the table is empty.
> > > > 
> > > > Create an infrastructure to query the max vectors required for the CXL
> > > > device. Upon successful allocation, users can plug in their respective isr
> > > > at any point thereafter, which is supported by a new cxlds->has_irq flag,
> > > > for example, if the irq setup is not done in the PCI driver, such as
> > > > the case of the CXL-PMU.
> > > > 
> > > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > > > ---
> > > >  drivers/cxl/cxlmem.h |  3 ++
> > > >  drivers/cxl/pci.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 75 insertions(+)
> > > > 
> > > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > > index 88e3a8e54b6a..72b69b003302 100644
> > > > --- a/drivers/cxl/cxlmem.h
> > > > +++ b/drivers/cxl/cxlmem.h
> > > > @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
> > > >   * @info: Cached DVSEC information about the device.
> > > >   * @serial: PCIe Device Serial Number
> > > >   * @doe_mbs: PCI DOE mailbox array
> > > > + * @has_irq: PCIe MSI-X/MSI support
> > > >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> > > >   *
> > > >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > > > @@ -247,6 +248,8 @@ struct cxl_dev_state {
> > > >  
> > > >  	struct xarray doe_mbs;
> > > >  
> > > > +	bool has_irq;
> > > > +
> > > >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> > > >  };
> > > >  
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index faeb5d9d7a7a..9c3e95ebaa26 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -428,6 +428,73 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > > >  	}
> > > >  }
> > > >  
> > > > +/**
> > > > + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI-X/MSI irqs.
> > > > + *
> > > > + * @name: Name of the device/component generating this interrupt.
> > > > + * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
> > > > + *		    feature does not have the Interrupt Supported bit set, then
> > > > + *		    return -1.
> > > > + */
> > > > +struct cxl_irq_cap {
> > > > +	const char *name;
> > > > +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);  
> > > 
> > > Why is this a callback, why not just have the features populate their
> > > irq numbers?  
> > 
> > I think we have decided to forgo the callback but I'm not sure what you mean by
> > 'populate their irq numbers'?
> >   
> > >   
> > > > +};
> > > > +
> > > > +static const struct cxl_irq_cap cxl_irq_cap_table[] = {
> > > > +	NULL
> > > > +};
> > > > +
> > > > +static void cxl_pci_free_irq_vectors(void *data)
> > > > +{
> > > > +	pci_free_irq_vectors(data);
> > > > +}
> > > > +
> > > > +/*
> > > > + * Attempt to allocate the largest amount of necessary vectors.
> > > > + *
> > > > + * Returns 0 upon a successful allocation of *all* vectors, or a
> > > > + * negative value otherwise.
> > > > + */
> > > > +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> > > > +{
> > > > +	struct device *dev = cxlds->dev;
> > > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > > +	int rc, i, vectors = -1;
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
> > > > +		int irq;
> > > > +
> > > > +		if (!cxl_irq_cap_table[i].get_max_msgnum)
> > > > +			continue;
> > > > +
> > > > +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
> > > > +		vectors = max_t(int, irq, vectors);
> > > > +	}  
> > > 
> > > Forgive me if I have missed something, I only look at interrupt enable
> > > code once every few years, and the APIs are always a bit different, but
> > > is this not too early to read the message number? The number is not
> > > stable until either MSI or MSI-X has been selected below at
> > > pci_alloc_irq_vectors() time?  
> >  
> > Well I keep getting wrapped around the axle on this one too.
> > 
> > This all started back when Jonathan originally attempted to allocate the
> > maximum number of vectors a device _could_ allocate.  But it was recommended that
> > we determine the max number first then allocate that number.
> > 
> > This seems like a chicken and egg issue.  How is the number not stable before
> > calling pci_alloc_irq_vectors() when you need the max msg number in that call?  
> 
> Are we talking about the same thing? I am talking about the value in the
> "Interrupt Message Number" field. That depends on whether MSI or MSI-X
> gets enabled. The number of vectors the device can support is static.
> 
> Since CXL is such an a la carte spec I think this is situation to just
> specify a large number of amx vectors to pci_alloc_irq_vectors() and
> then find out after the fact if all of the interrupt generators that
> today's cxl_pci knows about in the device each got their own vector.

I'd misunderstood how this worked and not read the spec :( I wrongly thought portdrv
did the query first and allocated the vectors after, but that's not
the case.  It first allocates max entries, then frees them all and then
allocates the ones that we find present.
We should probably look to do something similar to that though I'm not sure
even that code is always optimal.

https://elixir.bootlin.com/linux/v6.1-rc2/source/drivers/pci/pcie/portdrv_core.c#L101

In short that calls:
/* Allocate the maximum possible number of MSI/MSI-X vectors */
nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
			PCI_IRQ_MSIX | PCI_IRQ_MSI);

/* See how many and which Interrupt Message Numbers we actually use */
nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);

if (nvec != nr_entries) {
	pci_free_irq_vectors(dev);

	nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
			PCI_IRQ_MSIX | PCI_IRQ_MSI);
}

My worry here is that the implicit assumption is that the vectors won't
move if we reduce the overall number of vectors we are asking for...

However, imagine the case that we have a feature the driver doesn't know
about that was previously at a higher vector.  After reducing the vectors
allocated the hardware might decide that feature needs it's own vector whereas
some others can be combined.  Hence we'd end up with a less than ideal packing
for the features we actually support.

Could do something iterative to solve this if it actually matters (increase
number of vectors until the layout matches what we get with max possible vectors).

+CC linux-pci and Bjorn for their take on this.  Maybe I'm over thinking things
and in reality this never happens.

Jonathan
