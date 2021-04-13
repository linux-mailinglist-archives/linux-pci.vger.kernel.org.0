Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B135E3D1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbhDMQZ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 12:25:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:44516 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhDMQZy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 12:25:54 -0400
IronPort-SDR: CZbK+qHSjOoac/DMMh9pOuC/Y8CprwdKaapiTWxiTzz0aFRf+SCxNmzZILyZXkh2lde2ciTti1
 7k693gf9zAXA==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194476078"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="194476078"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 09:17:30 -0700
IronPort-SDR: rJXonS1xuvGYtoAgIL8N7eOlYnpb/rEMy070WU03BR8f6akrq9XlCJ32Co24T8+i3hG9Ur3yc0
 GDkh/qHJGiRA==
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="521652413"
Received: from mdessai-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.135.14])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 09:17:29 -0700
Date:   Tue, 13 Apr 2021 09:17:26 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] cxl/mem: Get rid of @cxlm.base
Message-ID: <20210413161726.tz7rg46krrekk3lp@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
 <20210407222625.320177-5-ben.widawsky@intel.com>
 <20210408182635.00003997@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408182635.00003997@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-04-08 18:26:35, Jonathan Cameron wrote:
> On Wed, 7 Apr 2021 15:26:22 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > @cxlm.base only existed to support holding the base found in the
> > register block mapping code, and pass it along to the register setup
> > code. Now that the register setup function has all logic around managing
> > the registers, from DVSEC to iomapping up to populating our CXL specific
> > information, it is easy to turn the @base values into local variables
> > and remove them from our device driver state.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> Patch is basically fine, but I do wonder if you could avoid the
> nasty casting in and out of __iomem in the error paths.
> 
> It's a common enough idiom though so I'm not htat fussed.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/mem.c | 24 +++++++++++-------------
> >  drivers/cxl/mem.h |  2 --
> >  2 files changed, 11 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 04b4f7445083..60b95c524c3e 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -922,11 +922,10 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev)
> >  	return cxlm;
> >  }
> >  
> > -static int cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32 reg_hi)
> > +static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32 reg_hi)
> >  {
> >  	struct pci_dev *pdev = cxlm->pdev;
> >  	struct device *dev = &pdev->dev;
> > -	void __iomem *regs;
> >  	u64 offset;
> >  	u8 bar;
> >  	int rc;
> > @@ -938,20 +937,18 @@ static int cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32 reg_hi)
> >  	if (pci_resource_len(pdev, bar) < offset) {
> >  		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> >  			&pdev->resource[bar], (unsigned long long)offset);
> > -		return -ENXIO;
> > +		return (void __iomem *)ERR_PTR(-ENXIO);
> >  	}
> >  
> >  	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
> >  	if (rc) {
> >  		dev_err(dev, "failed to map registers\n");
> > -		return rc;
> > +		return (void __iomem *)ERR_PTR(rc);
> 
> The casting is fairly horrible, perhaps just pass in
> a void __iomem ** and pass base back through that?
> 

TIL: IOMEM_ERR_PTR. Would that suffice?

> >  	}
> > -	regs = pcim_iomap_table(pdev)[bar];
> > -
> > -	cxlm->base = regs + offset;
> >  
> >  	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> > -	return 0;
> > +
> > +	return pcim_iomap_table(pdev)[bar] + offset;
> >  }
> >  
> >  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> > @@ -993,7 +990,8 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> >  	struct pci_dev *pdev = cxlm->pdev;
> >  	struct device *dev = &pdev->dev;
> >  	u32 regloc_size, regblocks;
> > -	int rc, regloc, i;
> > +	void __iomem *base;
> > +	int regloc, i;
> >  
> >  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
> >  	if (!regloc) {
> > @@ -1019,9 +1017,9 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> >  		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> >  
> >  		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> > -			rc = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
> > -			if (rc)
> > -				return rc;
> > +			base = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
> > +			if (IS_ERR(base))
> > +				return PTR_ERR(base);
> >  			break;
> >  		}
> >  	}
> > @@ -1031,7 +1029,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> >  		return -ENXIO;
> >  	}
> >  
> > -	cxl_setup_device_regs(dev, cxlm->base, &regs->device_regs);
> > +	cxl_setup_device_regs(dev, base, &regs->device_regs);
> >  
> >  	if (!regs->status || !regs->mbox || !regs->memdev) {
> >  		dev_err(dev, "registers not found: %s%s%s\n",
> > diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> > index 8bad7166adba..bfcfef461b16 100644
> > --- a/drivers/cxl/mem.h
> > +++ b/drivers/cxl/mem.h
> > @@ -49,7 +49,6 @@ struct cxl_memdev {
> >  /**
> >   * struct cxl_mem - A CXL memory device
> >   * @pdev: The PCI device associated with this CXL device.
> > - * @base: IO mappings to the device's MMIO
> >   * @cxlmd: Logical memory device chardev / interface
> >   * @regs: Parsed register blocks
> >   * @payload_size: Size of space for payload
> > @@ -62,7 +61,6 @@ struct cxl_memdev {
> >   */
> >  struct cxl_mem {
> >  	struct pci_dev *pdev;
> > -	void __iomem *base;
> >  	struct cxl_memdev *cxlmd;
> >  
> >  	struct cxl_regs regs;
> 
