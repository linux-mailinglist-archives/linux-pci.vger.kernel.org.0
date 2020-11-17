Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507FF2B6826
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 16:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgKQPAl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 10:00:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2118 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgKQPAl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 10:00:41 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cb8Gd5GrCz67DS4;
        Tue, 17 Nov 2020 22:59:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 17 Nov 2020 16:00:38 +0100
Received: from localhost (10.47.31.177) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 17 Nov
 2020 15:00:37 +0000
Date:   Tue, 17 Nov 2020 15:00:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 4/9] cxl/mem: Map memory device registers
Message-ID: <20201117150029.000018a9@Huawei.com>
In-Reply-To: <20201111054356.793390-5-ben.widawsky@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
        <20201111054356.793390-5-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.177]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 Nov 2020 21:43:51 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> All the necessary bits are initialized in order to find and map the
> register space for CXL Memory Devices. This is accomplished by using the
> Register Locator DVSEC (CXL 2.0 - 8.1.9.1) to determine which PCI BAR to
> use, and how much of an offset from that BAR should be added.
> 
> If the memory device registers are found and mapped a new internal data
> structure tracking device state is allocated.
> 
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

Hmm. That "register offset low" naming in the spec is just designed to confuse
given lots of other things packed in the register.
Perhaps a comment here to say it contains other information?
Also possibly some docs for cxl_mem_create to make the same point there.

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
>  
> -	cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
> -	if (!cxlm)
> -		return -ENOMEM;
> +	pci_set_drvdata(pdev, cxlm);

I could be wrong but don't think this is used yet.  I'd prefer to see
it introduced only when it is.  Makes it easy to match up without
having to search back in earlier patches.

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

As in the QEMU patches, please add a comment on what RBI means
here. It's non obvious even just after you've read through the spec!

> +#define CXL_REGLOG_RBI_COMPONENT 1
> +#define CXL_REGLOG_RBI_VIRT 2
> +#define CXL_REGLOG_RBI_MEMDEV 3
> +#define CXL_REGLOG_IS_MEMDEV(x) ((((x) >> 8) & 0xff) == CXL_REGLOG_RBI_MEMDEV)
> +
>  #endif /* __CXL_PCI_H__ */

