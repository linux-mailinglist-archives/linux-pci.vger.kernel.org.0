Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FEF2F3A02
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 20:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436558AbhALTV7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 14:21:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:32787 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436499AbhALTV6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 14:21:58 -0500
IronPort-SDR: i+FGLl+aKkVD7Ve+EsvBELXTUzzTqsvWCBZXPDx2R6N6UTr04/wE3vppT5L+624MZDHrNBAKSA
 w2ngYESttwwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="177320087"
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="177320087"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 11:21:17 -0800
IronPort-SDR: 1KYxMwvB+u61eXMmOhyFEfsdMWR01wyobnrjgl1mL7RSrInV7Ngndilmxdplan3ucA5kOLjyrb
 fAkdwNoUyJIA==
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="397466824"
Received: from reyesjon-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.129.71])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 11:21:16 -0800
Date:   Tue, 12 Jan 2021 11:21:15 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Subject: Re: [RFC PATCH v3 05/16] cxl/mem: Map memory device registers
Message-ID: <20210112192115.vhxjz3cr5vwjshwf@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-6-ben.widawsky@intel.com>
 <20210112191342.00006aad@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112191342.00006aad@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-01-12 19:13:42, Jonathan Cameron wrote:
> On Mon, 11 Jan 2021 14:51:09 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > All the necessary bits are initialized in order to find and map the
> > register space for CXL Memory Devices. This is accomplished by using the
> > Register Locator DVSEC (CXL 2.0 - 8.1.9.1) to determine which PCI BAR to
> > use, and how much of an offset from that BAR should be added.
> > 
> > If the memory device registers are found and mapped a new internal data
> > structure tracking device state is allocated.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> Some issues with managed allocations being manually freed in remove.
> It shouldn't be necessary to do that.
> 
> > ---
> >  drivers/cxl/cxl.h |  17 ++++++++
> >  drivers/cxl/mem.c | 100 +++++++++++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/pci.h |  14 +++++++
> >  3 files changed, 130 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/cxl/cxl.h
> > 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > new file mode 100644
> > index 000000000000..d81d0ba4617c
> > --- /dev/null
> > +++ b/drivers/cxl/cxl.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Copyright(c) 2020 Intel Corporation. */
> > +
> > +#ifndef __CXL_H__
> > +#define __CXL_H__
> > +
> > +/**
> > + * struct cxl_mem - A CXL memory device
> > + * @pdev: The PCI device associated with this CXL device.
> > + * @regs: IO mappings to the device's MMIO
> > + */
> > +struct cxl_mem {
> > +	struct pci_dev *pdev;
> > +	void __iomem *regs;
> > +};
> > +
> > +#endif
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 005404888942..8301db34d2ff 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -5,6 +5,58 @@
> >  #include <linux/io.h>
> >  #include "acpi.h"
> >  #include "pci.h"
> > +#include "cxl.h"
> > +
> > +/**
> > + * cxl_mem_create() - Create a new &struct cxl_mem.
> > + * @pdev: The pci device associated with the new &struct cxl_mem.
> > + * @reg_lo: Lower 32b of the register locator
> > + * @reg_hi: Upper 32b of the register locator.
> > + *
> > + * Return: The new &struct cxl_mem on success, NULL on failure.
> > + *
> > + * Map the BAR for a CXL memory device. This BAR has the memory device's
> > + * registers for the device as specified in CXL specification.
> > + */
> > +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> > +				      u32 reg_hi)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct cxl_mem *cxlm;
> > +	void __iomem *regs;
> > +	u64 offset;
> > +	u8 bar;
> > +	int rc;
> > +
> > +	offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> > +	bar = (reg_lo >> CXL_REGLOC_BIR_SHIFT) & CXL_REGLOC_BIR_MASK;
> > +
> > +	/* Basic sanity check that BAR is big enough */
> > +	if (pci_resource_len(pdev, bar) < offset) {
> > +		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> > +			&pdev->resource[bar], (unsigned long long)offset);
> > +		return NULL;
> > +	}
> > +
> > +	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
> > +	if (rc != 0) {
> > +		dev_err(dev, "failed to map registers\n");
> > +		return NULL;
> > +	}
> > +
> > +	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
> > +	if (!cxlm) {
> > +		dev_err(dev, "No memory available\n");
> > +		return NULL;
> > +	}
> > +
> > +	regs = pcim_iomap_table(pdev)[bar];
> > +	cxlm->pdev = pdev;
> > +	cxlm->regs = regs + offset;
> > +
> > +	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> > +	return cxlm;
> > +}
> >  
> >  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> >  {
> > @@ -33,7 +85,8 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> >  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct device *dev = &pdev->dev;
> > -	int rc, regloc;
> > +	struct cxl_mem *cxlm;
> > +	int rc, regloc, i;
> >  
> >  	rc = cxl_bus_acquire(pdev);
> >  	if (rc != 0) {
> > @@ -41,15 +94,59 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  		return rc;
> >  	}
> >  
> > +	rc = pcim_enable_device(pdev);
> > +	if (rc)
> > +		return rc;
> > +
> >  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
> >  	if (!regloc) {
> >  		dev_err(dev, "register location dvsec not found\n");
> >  		return -ENXIO;
> >  	}
> > +	regloc += 0xc; /* Skip DVSEC + reserved fields */
> > +
> > +	rc = -ENXIO;
> > +	for (i = regloc; i < regloc + 0x24; i += 8) {
> > +		u32 reg_lo, reg_hi;
> > +		u8 reg_type;
> > +
> > +		/* "register low and high" contain other bits */
> > +		pci_read_config_dword(pdev, i, &reg_lo);
> > +		pci_read_config_dword(pdev, i + 4, &reg_hi);
> > +
> > +		reg_type =
> > +			(reg_lo >> CXL_REGLOC_RBI_SHIFT) & CXL_REGLOC_RBI_MASK;
> > +
> > +		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> > +			rc = 0;
> > +			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> > +			if (!cxlm)
> > +				rc = -ENODEV;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (rc)
> > +		return rc;
> >  
> > +	pci_set_drvdata(pdev, cxlm);
> After below cleanup, not needed yet..
> 
> >  	return 0;
> >  }
> >  
> > +static void cxl_mem_remove(struct pci_dev *pdev)
> > +{
> > +	struct cxl_mem *cxlm;
> > +
> > +	cxlm = pci_get_drvdata(pdev);
> > +	if (!cxlm)
> > +		return;
> > +
> > +	kfree(cxlm);
> 
> There is bunch of unwinding here that I'd expect to see in error paths
> for probe but it's not there...  Which made me wonder.
> So pcim_iounmap_regions is a managed interface, why are call it by
> hand?  Same is true of the allocation of cxlm above.  So currently this
> remove isn't doing anything useful.
> 
> > +
> > +	pcim_iounmap_regions(pdev, ~0);
> > +	pci_set_drvdata(pdev, NULL);
> 
> This hasn't been needed for a long time. Example of removal of similar...
> http://patchwork.ozlabs.org/project/netdev/patch/005801ceaec1$6b8d3320$42a79960$%25han@samsung.com/
>  

Thanks. I copy pasted it from a driver that obviously hasn't been updated yet
:-)

The kfree is still necessary though, right? Earlier in development, I just freed
it immediately after creation (this patch is obviously not super useful
functionally, but serves nicely for review).

So we can remove the actual allocation from this patch and move it to later if
you think it makes a big difference. My preference is to just leave it doing the
kfree and call it good.

> > +}
> > +
> >  static const struct pci_device_id cxl_mem_pci_tbl[] = {
> >  	/* PCI class code for CXL.mem Type-3 Devices */
> >  	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> > @@ -62,6 +159,7 @@ static struct pci_driver cxl_mem_driver = {
> >  	.name			= KBUILD_MODNAME,
> >  	.id_table		= cxl_mem_pci_tbl,
> >  	.probe			= cxl_mem_probe,
> > +	.remove			= cxl_mem_remove,
> >  };
> >  
> >  MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > index a8a9935fa90b..df222edb6ac3 100644
> > --- a/drivers/cxl/pci.h
> > +++ b/drivers/cxl/pci.h
> > @@ -17,4 +17,18 @@
> >  
> >  #define PCI_DVSEC_ID_CXL_REGLOC		0x8
> >  
> > +/* BAR Indicator Register (BIR) */
> > +#define CXL_REGLOC_BIR_SHIFT 0
> > +#define CXL_REGLOC_BIR_MASK 0x7
> > +
> > +/* Register Block Identifier (RBI) */
> > +#define CXL_REGLOC_RBI_SHIFT 8
> > +#define CXL_REGLOC_RBI_MASK 0xff
> > +#define CXL_REGLOC_RBI_EMPTY 0
> > +#define CXL_REGLOC_RBI_COMPONENT 1
> > +#define CXL_REGLOC_RBI_VIRT 2
> > +#define CXL_REGLOC_RBI_MEMDEV 3
> > +
> > +#define CXL_REGLOC_ADDR_MASK 0xffff0000
> > +
> >  #endif /* __CXL_PCI_H__ */
> 
