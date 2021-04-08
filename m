Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99773358B56
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhDHR23 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:28:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2811 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhDHR22 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 13:28:28 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGSf93vtcz684Xk;
        Fri,  9 Apr 2021 01:18:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 19:28:15 +0200
Received: from localhost (10.47.93.239) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 18:28:14 +0100
Date:   Thu, 8 Apr 2021 18:26:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] cxl/mem: Get rid of @cxlm.base
Message-ID: <20210408182635.00003997@Huawei.com>
In-Reply-To: <20210407222625.320177-5-ben.widawsky@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
        <20210407222625.320177-5-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.239]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 7 Apr 2021 15:26:22 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> @cxlm.base only existed to support holding the base found in the
> register block mapping code, and pass it along to the register setup
> code. Now that the register setup function has all logic around managing
> the registers, from DVSEC to iomapping up to populating our CXL specific
> information, it is easy to turn the @base values into local variables
> and remove them from our device driver state.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Patch is basically fine, but I do wonder if you could avoid the
nasty casting in and out of __iomem in the error paths.

It's a common enough idiom though so I'm not htat fussed.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/mem.c | 24 +++++++++++-------------
>  drivers/cxl/mem.h |  2 --
>  2 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 04b4f7445083..60b95c524c3e 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -922,11 +922,10 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev)
>  	return cxlm;
>  }
>  
> -static int cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32 reg_hi)
> +static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32 reg_hi)
>  {
>  	struct pci_dev *pdev = cxlm->pdev;
>  	struct device *dev = &pdev->dev;
> -	void __iomem *regs;
>  	u64 offset;
>  	u8 bar;
>  	int rc;
> @@ -938,20 +937,18 @@ static int cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32 reg_hi)
>  	if (pci_resource_len(pdev, bar) < offset) {
>  		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
>  			&pdev->resource[bar], (unsigned long long)offset);
> -		return -ENXIO;
> +		return (void __iomem *)ERR_PTR(-ENXIO);
>  	}
>  
>  	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
>  	if (rc) {
>  		dev_err(dev, "failed to map registers\n");
> -		return rc;
> +		return (void __iomem *)ERR_PTR(rc);

The casting is fairly horrible, perhaps just pass in
a void __iomem ** and pass base back through that?

>  	}
> -	regs = pcim_iomap_table(pdev)[bar];
> -
> -	cxlm->base = regs + offset;
>  
>  	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> -	return 0;
> +
> +	return pcim_iomap_table(pdev)[bar] + offset;
>  }
>  
>  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> @@ -993,7 +990,8 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  	struct pci_dev *pdev = cxlm->pdev;
>  	struct device *dev = &pdev->dev;
>  	u32 regloc_size, regblocks;
> -	int rc, regloc, i;
> +	void __iomem *base;
> +	int regloc, i;
>  
>  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
>  	if (!regloc) {
> @@ -1019,9 +1017,9 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
>  
>  		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> -			rc = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
> -			if (rc)
> -				return rc;
> +			base = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
> +			if (IS_ERR(base))
> +				return PTR_ERR(base);
>  			break;
>  		}
>  	}
> @@ -1031,7 +1029,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  		return -ENXIO;
>  	}
>  
> -	cxl_setup_device_regs(dev, cxlm->base, &regs->device_regs);
> +	cxl_setup_device_regs(dev, base, &regs->device_regs);
>  
>  	if (!regs->status || !regs->mbox || !regs->memdev) {
>  		dev_err(dev, "registers not found: %s%s%s\n",
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index 8bad7166adba..bfcfef461b16 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -49,7 +49,6 @@ struct cxl_memdev {
>  /**
>   * struct cxl_mem - A CXL memory device
>   * @pdev: The PCI device associated with this CXL device.
> - * @base: IO mappings to the device's MMIO
>   * @cxlmd: Logical memory device chardev / interface
>   * @regs: Parsed register blocks
>   * @payload_size: Size of space for payload
> @@ -62,7 +61,6 @@ struct cxl_memdev {
>   */
>  struct cxl_mem {
>  	struct pci_dev *pdev;
> -	void __iomem *base;
>  	struct cxl_memdev *cxlmd;
>  
>  	struct cxl_regs regs;

