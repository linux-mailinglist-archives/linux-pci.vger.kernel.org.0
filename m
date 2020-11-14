Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7C22B2A59
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 02:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKNBMk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 20:12:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:28652 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgKNBMk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 20:12:40 -0500
IronPort-SDR: d1Fg0trnHZjtUCWhJ4KnEsDjbQwx9K/vBc/8STsfB8e33E8R9cE+NBXHK1TEUM8QnZebqxFi8w
 nZtz1NImhYmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="169771008"
X-IronPort-AV: E=Sophos;i="5.77,477,1596524400"; 
   d="scan'208";a="169771008"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 17:12:29 -0800
IronPort-SDR: TOxcS6n/birqnQnMF5D8QddT9bzRX+IhHVHoiUmPiCy5CNF9ViFtuZUhTZeaCR3ZnJami1MbgT
 /Vw/itpJXejA==
X-IronPort-AV: E=Sophos;i="5.77,477,1596524400"; 
   d="scan'208";a="339925602"
Received: from lborges-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.130.38])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 17:12:28 -0800
Date:   Fri, 13 Nov 2020 17:12:25 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 4/9] cxl/mem: Map memory device registers
Message-ID: <20201114011225.lzhrbk3sszw2a7m6@intel.com>
References: <20201111054356.793390-5-ben.widawsky@intel.com>
 <20201113181732.GA1121121@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113181732.GA1121121@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-11-13 12:17:32, Bjorn Helgaas wrote:
> On Tue, Nov 10, 2020 at 09:43:51PM -0800, Ben Widawsky wrote:
> > All the necessary bits are initialized in order to find and map the
> > register space for CXL Memory Devices. This is accomplished by using the
> > Register Locator DVSEC (CXL 2.0 - 8.1.9.1) to determine which PCI BAR to
> > use, and how much of an offset from that BAR should be added.
> 
> "Initialize the necessary bits ..." to use the usual imperative
> sentence structure, as you did in the subject.
> 
> > If the memory device registers are found and mapped a new internal data
> > structure tracking device state is allocated.
> 
> "Allocate device state if we find device registers" or similar.
> 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/mem.c | 68 +++++++++++++++++++++++++++++++++++++++++++----
> >  drivers/cxl/pci.h |  6 +++++
> >  2 files changed, 69 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index aa7d881fa47b..8d9b9ab6c5ea 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -7,9 +7,49 @@
> >  #include "pci.h"
> >  
> >  struct cxl_mem {
> > +	struct pci_dev *pdev;
> >  	void __iomem *regs;
> >  };
> >  
> > +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct cxl_mem *cxlm;
> > +	void __iomem *regs;
> > +	u64 offset;
> > +	u8 bar;
> > +	int rc;
> > +
> > +	offset = ((u64)reg_hi << 32) | (reg_lo & 0xffff0000);
> > +	bar = reg_lo & 0x7;
> > +
> > +	/* Basic sanity check that BAR is big enough */
> > +	if (pci_resource_len(pdev, bar) < offset) {
> > +		dev_err(dev, "bar%d: %pr: too small (offset: %#llx)\n",
> > +				bar, &pdev->resource[bar], (unsigned long long) offset);
> 
> s/bar/BAR/
> 
> > +		return ERR_PTR(-ENXIO);
> > +	}
> > +
> > +	rc = pcim_iomap_regions(pdev, 1 << bar, pci_name(pdev));
> > +	if (rc != 0) {
> > +		dev_err(dev, "failed to map registers\n");
> > +		return ERR_PTR(-ENXIO);
> > +	}
> > +
> > +	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
> > +	if (!cxlm) {
> > +		dev_err(dev, "No memory available\n");
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	regs = pcim_iomap_table(pdev)[bar];
> > +	cxlm->pdev = pdev;
> > +	cxlm->regs = regs + offset;
> > +
> > +	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> > +	return cxlm;
> > +}
> > +
> >  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> >  {
> >  	int pos;
> > @@ -34,9 +74,9 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> >  
> >  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> > +	struct cxl_mem *cxlm = ERR_PTR(-ENXIO);
> >  	struct device *dev = &pdev->dev;
> > -	struct cxl_mem *cxlm;
> 
> The order was better before ("dev", then "clxm").  Oh, I suppose this
> is a "reverse Christmas tree" thing.
> 

I don't actually care either way as long as it's consistent. I tend to do
reverse Christmas tree for no particular reason.

> > -	int rc, regloc;
> > +	int rc, regloc, i;
> >  
> >  	rc = cxl_bus_prepared(pdev);
> >  	if (rc != 0) {
> > @@ -44,15 +84,33 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
> > +	for (i = regloc; i < regloc + 0x24; i += 8) {
> > +		u32 reg_lo, reg_hi;
> > +
> > +		pci_read_config_dword(pdev, i, &reg_lo);
> > +		pci_read_config_dword(pdev, i + 4, &reg_hi);
> > +
> > +		if (CXL_REGLOG_IS_MEMDEV(reg_lo)) {
> > +			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (IS_ERR(cxlm))
> > +		return -ENXIO;
> 
> I think this would be easier to read if cxl_mem_create() returned NULL
> on failure (it prints error messages and we throw away
> -ENXIO/-ENOMEM distinction here anyway) so you could do:
> 
>   struct cxl_mem *cxlm = NULL;
> 
>   for (...) {
>     if (...) {
>       cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
>       break;
>     }
>   }
> 
>   if (!cxlm)
>     return -ENXIO;  /* -ENODEV might be more natural? */
> 

I agree on both counts. Both of these came from Dan, so I will let him explain.

> > -	cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
> > -	if (!cxlm)
> > -		return -ENOMEM;
> > +	pci_set_drvdata(pdev, cxlm);
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > index beb03921e6da..be87f62e9132 100644
> > --- a/drivers/cxl/pci.h
> > +++ b/drivers/cxl/pci.h
> > @@ -12,4 +12,10 @@
> >  #define PCI_DVSEC_ID_CXL	0x0
> >  #define PCI_DVSEC_ID_CXL_REGLOC	0x8
> >  
> > +#define CXL_REGLOG_RBI_EMPTY 0
> > +#define CXL_REGLOG_RBI_COMPONENT 1
> > +#define CXL_REGLOG_RBI_VIRT 2
> > +#define CXL_REGLOG_RBI_MEMDEV 3
> 
> Maybe line these values up.
> 
> > +#define CXL_REGLOG_IS_MEMDEV(x) ((((x) >> 8) & 0xff) == CXL_REGLOG_RBI_MEMDEV)
> 
> If these are only needed in cxl/mem.c, they could go there.  Do you
> expect code outside of drivers/cxl to need these?

Will do.

I'll suck in everything else as they seem like improvements.

> 
> >  #endif /* __CXL_PCI_H__ */
> > -- 
> > 2.29.2
> > 
