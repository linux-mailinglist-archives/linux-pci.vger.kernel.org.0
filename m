Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3312B2385
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 19:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgKMSRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 13:17:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgKMSRf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 13:17:35 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C539B2074B;
        Fri, 13 Nov 2020 18:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605291454;
        bh=FwNxJBVYLmY0I7UT2gwMeGvnRBxnjf3Vj6esUleM+bE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uuOXqaI5HlGmp9yRBHllON2jZ2TxrmP0ubmXp7A8iJCuQeYBofMwtXDBz/TeAi4WX
         FDYMLLQaenDuEVLjGYoK55MMKKZ/EoSHDpNYsdtUQnXBrkhiFphK3XXn4Ycp3QGUTj
         a+NlQl2PSILp/e0v6nq82qhLq2V9SGqFiQI5gz+U=
Date:   Fri, 13 Nov 2020 12:17:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 4/9] cxl/mem: Map memory device registers
Message-ID: <20201113181732.GA1121121@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111054356.793390-5-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 09:43:51PM -0800, Ben Widawsky wrote:
> All the necessary bits are initialized in order to find and map the
> register space for CXL Memory Devices. This is accomplished by using the
> Register Locator DVSEC (CXL 2.0 - 8.1.9.1) to determine which PCI BAR to
> use, and how much of an offset from that BAR should be added.

"Initialize the necessary bits ..." to use the usual imperative
sentence structure, as you did in the subject.

> If the memory device registers are found and mapped a new internal data
> structure tracking device state is allocated.

"Allocate device state if we find device registers" or similar.

> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.c | 68 +++++++++++++++++++++++++++++++++++++++++++----
>  drivers/cxl/pci.h |  6 +++++
>  2 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index aa7d881fa47b..8d9b9ab6c5ea 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -7,9 +7,49 @@
>  #include "pci.h"
>  
>  struct cxl_mem {
> +	struct pci_dev *pdev;
>  	void __iomem *regs;
>  };
>  
> +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cxl_mem *cxlm;
> +	void __iomem *regs;
> +	u64 offset;
> +	u8 bar;
> +	int rc;
> +
> +	offset = ((u64)reg_hi << 32) | (reg_lo & 0xffff0000);
> +	bar = reg_lo & 0x7;
> +
> +	/* Basic sanity check that BAR is big enough */
> +	if (pci_resource_len(pdev, bar) < offset) {
> +		dev_err(dev, "bar%d: %pr: too small (offset: %#llx)\n",
> +				bar, &pdev->resource[bar], (unsigned long long) offset);

s/bar/BAR/

> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	rc = pcim_iomap_regions(pdev, 1 << bar, pci_name(pdev));
> +	if (rc != 0) {
> +		dev_err(dev, "failed to map registers\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
> +	if (!cxlm) {
> +		dev_err(dev, "No memory available\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	regs = pcim_iomap_table(pdev)[bar];
> +	cxlm->pdev = pdev;
> +	cxlm->regs = regs + offset;
> +
> +	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> +	return cxlm;
> +}
> +
>  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  {
>  	int pos;
> @@ -34,9 +74,9 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  
>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> +	struct cxl_mem *cxlm = ERR_PTR(-ENXIO);
>  	struct device *dev = &pdev->dev;
> -	struct cxl_mem *cxlm;

The order was better before ("dev", then "clxm").  Oh, I suppose this
is a "reverse Christmas tree" thing.

> -	int rc, regloc;
> +	int rc, regloc, i;
>  
>  	rc = cxl_bus_prepared(pdev);
>  	if (rc != 0) {
> @@ -44,15 +84,33 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return rc;
>  	}
>  
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +
>  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
>  	if (!regloc) {
>  		dev_err(dev, "register location dvsec not found\n");
>  		return -ENXIO;
>  	}
> +	regloc += 0xc; /* Skip DVSEC + reserved fields */
> +
> +	for (i = regloc; i < regloc + 0x24; i += 8) {
> +		u32 reg_lo, reg_hi;
> +
> +		pci_read_config_dword(pdev, i, &reg_lo);
> +		pci_read_config_dword(pdev, i + 4, &reg_hi);
> +
> +		if (CXL_REGLOG_IS_MEMDEV(reg_lo)) {
> +			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> +			break;
> +		}
> +	}
> +
> +	if (IS_ERR(cxlm))
> +		return -ENXIO;

I think this would be easier to read if cxl_mem_create() returned NULL
on failure (it prints error messages and we throw away
-ENXIO/-ENOMEM distinction here anyway) so you could do:

  struct cxl_mem *cxlm = NULL;

  for (...) {
    if (...) {
      cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
      break;
    }
  }

  if (!cxlm)
    return -ENXIO;  /* -ENODEV might be more natural? */

> -	cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
> -	if (!cxlm)
> -		return -ENOMEM;
> +	pci_set_drvdata(pdev, cxlm);
>  
>  	return 0;
>  }
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index beb03921e6da..be87f62e9132 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -12,4 +12,10 @@
>  #define PCI_DVSEC_ID_CXL	0x0
>  #define PCI_DVSEC_ID_CXL_REGLOC	0x8
>  
> +#define CXL_REGLOG_RBI_EMPTY 0
> +#define CXL_REGLOG_RBI_COMPONENT 1
> +#define CXL_REGLOG_RBI_VIRT 2
> +#define CXL_REGLOG_RBI_MEMDEV 3

Maybe line these values up.

> +#define CXL_REGLOG_IS_MEMDEV(x) ((((x) >> 8) & 0xff) == CXL_REGLOG_RBI_MEMDEV)

If these are only needed in cxl/mem.c, they could go there.  Do you
expect code outside of drivers/cxl to need these?

>  #endif /* __CXL_PCI_H__ */
> -- 
> 2.29.2
> 
