Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B926C30AF0B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 19:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhBASVt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 13:21:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2470 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhBASUu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 13:20:50 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DTx3T1Lrqz67gVh;
        Tue,  2 Feb 2021 02:16:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 1 Feb 2021 19:20:04 +0100
Received: from localhost (10.47.76.76) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Mon, 1 Feb 2021
 18:20:03 +0000
Date:   Mon, 1 Feb 2021 18:19:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     David Rientjes <rientjes@google.com>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <daniel.lll@alibaba-inc.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 02/14] cxl/mem: Map memory device registers
Message-ID: <20210201181918.00000b13@Huawei.com>
In-Reply-To: <20210201164624.bhfufqfalogfazzi@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
        <20210130002438.1872527-3-ben.widawsky@intel.com>
        <792edaa-a11b-41c6-c2a1-2c72a3e4e815@google.com>
        <20210201164624.bhfufqfalogfazzi@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.76.76]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 1 Feb 2021 08:46:24 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> On 21-01-30 15:51:42, David Rientjes wrote:
> > On Fri, 29 Jan 2021, Ben Widawsky wrote:
> >   
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > new file mode 100644
> > > index 000000000000..d81d0ba4617c
> > > --- /dev/null
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -0,0 +1,17 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/* Copyright(c) 2020 Intel Corporation. */
> > > +
> > > +#ifndef __CXL_H__
> > > +#define __CXL_H__
> > > +
> > > +/**
> > > + * struct cxl_mem - A CXL memory device
> > > + * @pdev: The PCI device associated with this CXL device.
> > > + * @regs: IO mappings to the device's MMIO
> > > + */
> > > +struct cxl_mem {
> > > +	struct pci_dev *pdev;
> > > +	void __iomem *regs;
> > > +};
> > > +
> > > +#endif  
> > 
> > Stupid question: can there be more than one CXL.mem capable logical 
> > device?  I only ask to determine if an ordinal is needed to enumerate 
> > multiple LDs.  
> 
> Not a stupid question at all. I admit, I haven't spent much time thinking about
> MLDs. I don't have a solid answer to your question. As I understand it, the
> devices in the virtual hierarchy will appear as individual CXL type 3 device
> components (2.4 in the spec) and transparent to software. A few times I've
> attempted to think about MLDs, get confused, and go do something else. The only
> MLD specificity I know of is the MLD DVSEC (8.1.10), which seems not incredibly
> interesting to me at present (basically, only supporting hot reset).

That's my understanding as well.  If you have an MLD (and hence multiple logical memory
devices) the fact they have multiple logical devices will be nearly invisible to
any given host (will more or less look like an SLD).  Configuration via the
fabric manager API will be invisible to the host other than via hotplug
events when the configuration changes.
Note the MLD DVSEC is only in the fabric manager owned logical device (so Linux
won't see it in the PCI hierarchy).  Note the fabric manager is usually controlled by
a BMC or similar.

Various registers become hardwired to 0 and certain writes are ignored when it's
an MLD logical device rather than an physical device (SLD)

We might want to look at emulating this in QEMU to give us a
platform to verify the spec (particularly to make sure the various hardwired
registers don't cause any problems), but I'd not expect to see anything specific
in kernel support.

Jonathan



> 
> >   
> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > index f4ee9a507ac9..a869c8dc24cc 100644
> > > --- a/drivers/cxl/mem.c
> > > +++ b/drivers/cxl/mem.c
> > > @@ -4,6 +4,58 @@
> > >  #include <linux/pci.h>
> > >  #include <linux/io.h>
> > >  #include "pci.h"
> > > +#include "cxl.h"
> > > +
> > > +/**
> > > + * cxl_mem_create() - Create a new &struct cxl_mem.
> > > + * @pdev: The pci device associated with the new &struct cxl_mem.
> > > + * @reg_lo: Lower 32b of the register locator
> > > + * @reg_hi: Upper 32b of the register locator.
> > > + *
> > > + * Return: The new &struct cxl_mem on success, NULL on failure.
> > > + *
> > > + * Map the BAR for a CXL memory device. This BAR has the memory device's
> > > + * registers for the device as specified in CXL specification.
> > > + */
> > > +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> > > +				      u32 reg_hi)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct cxl_mem *cxlm;
> > > +	void __iomem *regs;
> > > +	u64 offset;
> > > +	u8 bar;
> > > +	int rc;
> > > +
> > > +	offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> > > +	bar = (reg_lo >> CXL_REGLOC_BIR_SHIFT) & CXL_REGLOC_BIR_MASK;
> > > +
> > > +	/* Basic sanity check that BAR is big enough */
> > > +	if (pci_resource_len(pdev, bar) < offset) {
> > > +		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> > > +			&pdev->resource[bar], (unsigned long long)offset);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
> > > +	if (rc != 0) {
> > > +		dev_err(dev, "failed to map registers\n");
> > > +		return NULL;
> > > +	}
> > > +
> > > +	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
> > > +	if (!cxlm) {
> > > +		dev_err(dev, "No memory available\n");
> > > +		return NULL;
> > > +	}
> > > +
> > > +	regs = pcim_iomap_table(pdev)[bar];
> > > +	cxlm->pdev = pdev;
> > > +	cxlm->regs = regs + offset;
> > > +
> > > +	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> > > +	return cxlm;
> > > +}
> > >  
> > >  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> > >  {
> > > @@ -32,15 +84,42 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> > >  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  {
> > >  	struct device *dev = &pdev->dev;
> > > -	int regloc;
> > > +	struct cxl_mem *cxlm;
> > > +	int rc, regloc, i;
> > > +
> > > +	rc = pcim_enable_device(pdev);
> > > +	if (rc)
> > > +		return rc;
> > >  
> > >  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
> > >  	if (!regloc) {
> > >  		dev_err(dev, "register location dvsec not found\n");
> > >  		return -ENXIO;
> > >  	}
> > > +	regloc += 0xc; /* Skip DVSEC + reserved fields */  
> > 
> > Assuming the DVSEC revision number is always 0x0 or there's no value in 
> > storing this in struct cxl_mem for the future.  
> 
> So this logic actually came from Dan originally, so don't take this necessarily
> as the authoritative answer.
> 
> At some point revision id will need to be considered. However, the consortium
> seems to be going to great lengths (kudos) to make all modifications backward
> compatible. As such, we can consider this the driver for rev0 (the only such rev
> in existence today), and when a new rev comes along, figure out how to best
> handle it. However, the expectation is that this code will still work for revN.
> 
> > 
> > Acked-by: David Rientjes <rientjes@google.com>  
> 
> Thanks!

