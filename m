Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9B3358B73
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhDHRf0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:35:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2814 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhDHRfZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 13:35:25 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGSvJ2sfVz686wN;
        Fri,  9 Apr 2021 01:30:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 8 Apr 2021 19:35:11 +0200
Received: from localhost (10.47.93.239) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 18:35:11 +0100
Date:   Thu, 8 Apr 2021 18:33:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] cxl/mem: Create a helper to setup device regs
Message-ID: <20210408183347.00001a17@Huawei.com>
In-Reply-To: <20210407222625.320177-7-ben.widawsky@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
        <20210407222625.320177-7-ben.widawsky@intel.com>
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

On Wed, 7 Apr 2021 15:26:24 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Memory devices have a list of required register regions within the
> register block, but this isn't required of all CXL components or
> devices. To make things more tidy, and allow for easily setting up other
> block types in this loop, the helper is introduced.

Two things in here, the move and allowing it to be missing.
I would call that out explicitly in the patch description.

> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 49f651694cb0..b7342aaf38c4 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -974,6 +974,24 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  	return 0;
>  }
>  
> +static int __cxl_setup_device_regs(struct cxl_mem *cxlm, void __iomem *base)

Naming is a little unusual.   Normally __ would imply unlocked or something
like that, whereas here it's mostly implying more error checks.

I don't immediately have a good idea for a name however...

> +{
> +	struct cxl_regs *regs = &cxlm->regs;
> +	struct pci_dev *pdev = cxlm->pdev;
> +	struct device *dev = &pdev->dev;
> +
> +	cxl_setup_device_regs(dev, base, &regs->device_regs);
> +	if (!regs->status || !regs->mbox || !regs->memdev) {
> +		dev_err(dev, "registers not found: %s%s%s\n",
> +				!regs->status ? "status " : "",
> +				!regs->mbox ? "mbox " : "",
> +				!regs->memdev ? "memdev" : "");
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * cxl_mem_setup_regs() - Setup necessary MMIO.
>   * @cxlm: The CXL memory device to communicate with.
> @@ -986,12 +1004,11 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>   */
>  static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  {
> -	struct cxl_regs *regs = &cxlm->regs;
>  	struct pci_dev *pdev = cxlm->pdev;
>  	struct device *dev = &pdev->dev;
>  	u32 regloc_size, regblocks;
>  	void __iomem *base;
> -	int regloc, i;
> +	int regloc, i, rc;
>  
>  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
>  	if (!regloc) {
> @@ -1021,23 +1038,14 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  			if (IS_ERR(base))
>  				return PTR_ERR(base);
>  
> -			cxl_setup_device_regs(dev, base, &regs->device_regs);
> -			if (!regs->status || !regs->mbox || !regs->memdev) {
> -				dev_err(dev, "registers not found: %s%s%s\n",
> -						!regs->status ? "status " : "",
> -						!regs->mbox ? "mbox " : "",
> -						!regs->memdev ? "memdev" : "");
> -				return -ENXIO;
> -			}
> +			rc = __cxl_setup_device_regs(cxlm, base);
> +			if (rc)
> +				return rc;
> +
>  			break;
>  		}
>  	}
>  
> -	if (i == regblocks) {
> -		dev_err(dev, "Missing register locator for device registers\n");
> -		return -ENXIO;
> -	}
> -
>  	return 0;
>  }
>  

