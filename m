Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC414358B54
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhDHR22 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:28:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2810 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhDHR22 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 13:28:28 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGSlG38pqz687DN;
        Fri,  9 Apr 2021 01:23:06 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 19:28:14 +0200
Received: from localhost (10.47.93.239) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 18:28:13 +0100
Date:   Thu, 8 Apr 2021 18:13:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] cxl/mem: Split creation from mapping in probe
Message-ID: <20210408181343.00000244@Huawei.com>
In-Reply-To: <20210407222625.320177-3-ben.widawsky@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
        <20210407222625.320177-3-ben.widawsky@intel.com>
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

On Wed, 7 Apr 2021 15:26:20 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Add a new function specifically for mapping the register blocks and
> offsets within. The new function can be used more generically for other
> register block identifiers.
> 
> No functional change is meant to be introduced in this patch with the
> exception of a dev_err printed when the device register block isn't
> found.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Agreed, this seems to be a noop refactor to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/mem.c | 64 +++++++++++++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 99534260034e..520edaf233d4 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -925,22 +925,40 @@ static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
>  	return 0;
>  }
>  
> -static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> -				      u32 reg_hi)
> +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct cxl_mem *cxlm;
> -	void __iomem *regs;
> -	u64 offset;
> -	u8 bar;
> -	int rc;
>  
>  	cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
>  	if (!cxlm) {
>  		dev_err(dev, "No memory available\n");
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	mutex_init(&cxlm->mbox_mutex);
> +	cxlm->pdev = pdev;
> +	cxlm->enabled_cmds =
> +		devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
> +				   sizeof(unsigned long),
> +				   GFP_KERNEL | __GFP_ZERO);
> +	if (!cxlm->enabled_cmds) {
> +		dev_err(dev, "No memory available for bitmap\n");
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
> +	return cxlm;
> +}
> +
> +static int cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32 reg_hi)
> +{
> +	struct pci_dev *pdev = cxlm->pdev;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *regs;
> +	u64 offset;
> +	u8 bar;
> +	int rc;
> +
>  	offset = ((u64)reg_hi << 32) | FIELD_GET(CXL_REGLOC_ADDR_MASK, reg_lo);
>  	bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
>  
> @@ -948,30 +966,20 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
>  	if (pci_resource_len(pdev, bar) < offset) {
>  		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
>  			&pdev->resource[bar], (unsigned long long)offset);
> -		return NULL;
> +		return -ENXIO;
>  	}
>  
>  	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
>  	if (rc) {
>  		dev_err(dev, "failed to map registers\n");
> -		return NULL;
> +		return rc;
>  	}
>  	regs = pcim_iomap_table(pdev)[bar];
>  
> -	mutex_init(&cxlm->mbox_mutex);
> -	cxlm->pdev = pdev;
>  	cxlm->base = regs + offset;
> -	cxlm->enabled_cmds =
> -		devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
> -				   sizeof(unsigned long),
> -				   GFP_KERNEL | __GFP_ZERO);
> -	if (!cxlm->enabled_cmds) {
> -		dev_err(dev, "No memory available for bitmap\n");
> -		return NULL;
> -	}
>  
>  	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> -	return cxlm;
> +	return 0;
>  }
>  
>  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> @@ -1403,14 +1411,18 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct cxl_mem *cxlm = NULL;
>  	u32 regloc_size, regblocks;
> +	struct cxl_mem *cxlm;
>  	int rc, regloc, i;
>  
>  	rc = pcim_enable_device(pdev);
>  	if (rc)
>  		return rc;
>  
> +	cxlm = cxl_mem_create(pdev);
> +	if (IS_ERR(cxlm))
> +		return PTR_ERR(cxlm);
> +
>  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
>  	if (!regloc) {
>  		dev_err(dev, "register location dvsec not found\n");
> @@ -1435,13 +1447,17 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
>  
>  		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> -			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> +			rc = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
> +			if (rc)
> +				return rc;
>  			break;
>  		}
>  	}
>  
> -	if (!cxlm)
> -		return -ENODEV;
> +	if (i == regblocks) {
> +		dev_err(dev, "Missing register locator for device registers\n");
> +		return -ENXIO;
> +	}
>  
>  	rc = cxl_mem_setup_regs(cxlm);
>  	if (rc)

