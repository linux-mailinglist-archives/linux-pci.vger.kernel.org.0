Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544A7358B5C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhDHR2u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:28:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2812 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhDHR2r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 13:28:47 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGSfX6XQNz6870f;
        Fri,  9 Apr 2021 01:19:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 19:28:34 +0200
Received: from localhost (10.47.93.239) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 18:28:34 +0100
Date:   Thu, 8 Apr 2021 18:27:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] cxl/mem: Move register locator logic into reg setup
Message-ID: <20210408182709.00007f18@Huawei.com>
In-Reply-To: <20210407222625.320177-4-ben.widawsky@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
        <20210407222625.320177-4-ben.widawsky@intel.com>
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

On Wed, 7 Apr 2021 15:26:21 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Start moving code around to ultimately get rid of @cxlm.base. The
> @cxlm.base member serves no purpose other than intermediate storage of
> the offset found in cxl_mem_map_regblock() later used by
> cxl_mem_setup_regs(). Aside from wanting to get rid of this useless
> member, it will help later when adding new register block identifiers.
> 
> While @cxlm.base still exists, it will become trivial to remove it in a
> future patch.
> 
> No functional change is meant to be introduced in this patch.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Seems like a noop refactor to me as you say.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/mem.c | 135 +++++++++++++++++++++++-----------------------
>  1 file changed, 68 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 520edaf233d4..04b4f7445083 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -870,34 +870,6 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode,
>  	return 0;
>  }
>  
> -/**
> - * cxl_mem_setup_regs() - Setup necessary MMIO.
> - * @cxlm: The CXL memory device to communicate with.
> - *
> - * Return: 0 if all necessary registers mapped.
> - *
> - * A memory device is required by spec to implement a certain set of MMIO
> - * regions. The purpose of this function is to enumerate and map those
> - * registers.
> - */
> -static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> -{
> -	struct device *dev = &cxlm->pdev->dev;
> -	struct cxl_regs *regs = &cxlm->regs;
> -
> -	cxl_setup_device_regs(dev, cxlm->base, &regs->device_regs);
> -
> -	if (!regs->status || !regs->mbox || !regs->memdev) {
> -		dev_err(dev, "registers not found: %s%s%s\n",
> -			!regs->status ? "status " : "",
> -			!regs->mbox ? "mbox " : "",
> -			!regs->memdev ? "memdev" : "");
> -		return -ENXIO;
> -	}
> -
> -	return 0;
> -}
> -
>  static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
>  {
>  	const int cap = readl(cxlm->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> @@ -1005,6 +977,73 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  	return 0;
>  }
>  
> +/**
> + * cxl_mem_setup_regs() - Setup necessary MMIO.
> + * @cxlm: The CXL memory device to communicate with.
> + *
> + * Return: 0 if all necessary registers mapped.
> + *
> + * A memory device is required by spec to implement a certain set of MMIO
> + * regions. The purpose of this function is to enumerate and map those
> + * registers.
> + */
> +static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> +{
> +	struct cxl_regs *regs = &cxlm->regs;
> +	struct pci_dev *pdev = cxlm->pdev;
> +	struct device *dev = &pdev->dev;
> +	u32 regloc_size, regblocks;
> +	int rc, regloc, i;
> +
> +	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
> +	if (!regloc) {
> +		dev_err(dev, "register location dvsec not found\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Get the size of the Register Locator DVSEC */
> +	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> +	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> +
> +	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> +	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
> +
> +	for (i = 0; i < regblocks; i++, regloc += 8) {
> +		u32 reg_lo, reg_hi;
> +		u8 reg_type;
> +
> +		/* "register low and high" contain other bits */
> +		pci_read_config_dword(pdev, regloc, &reg_lo);
> +		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> +
> +		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> +
> +		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> +			rc = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
> +			if (rc)
> +				return rc;
> +			break;
> +		}
> +	}
> +
> +	if (i == regblocks) {
> +		dev_err(dev, "Missing register locator for device registers\n");
> +		return -ENXIO;
> +	}
> +
> +	cxl_setup_device_regs(dev, cxlm->base, &regs->device_regs);
> +
> +	if (!regs->status || !regs->mbox || !regs->memdev) {
> +		dev_err(dev, "registers not found: %s%s%s\n",
> +			!regs->status ? "status " : "",
> +			!regs->mbox ? "mbox " : "",
> +			!regs->memdev ? "memdev" : "");
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct cxl_memdev *to_cxl_memdev(struct device *dev)
>  {
>  	return container_of(dev, struct cxl_memdev, dev);
> @@ -1410,10 +1449,8 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
>  
>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> -	struct device *dev = &pdev->dev;
> -	u32 regloc_size, regblocks;
>  	struct cxl_mem *cxlm;
> -	int rc, regloc, i;
> +	int rc;
>  
>  	rc = pcim_enable_device(pdev);
>  	if (rc)
> @@ -1423,42 +1460,6 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(cxlm))
>  		return PTR_ERR(cxlm);
>  
> -	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
> -	if (!regloc) {
> -		dev_err(dev, "register location dvsec not found\n");
> -		return -ENXIO;
> -	}
> -
> -	/* Get the size of the Register Locator DVSEC */
> -	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> -	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> -
> -	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> -	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
> -
> -	for (i = 0; i < regblocks; i++, regloc += 8) {
> -		u32 reg_lo, reg_hi;
> -		u8 reg_type;
> -
> -		/* "register low and high" contain other bits */
> -		pci_read_config_dword(pdev, regloc, &reg_lo);
> -		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> -
> -		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> -
> -		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> -			rc = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
> -			if (rc)
> -				return rc;
> -			break;
> -		}
> -	}
> -
> -	if (i == regblocks) {
> -		dev_err(dev, "Missing register locator for device registers\n");
> -		return -ENXIO;
> -	}
> -
>  	rc = cxl_mem_setup_regs(cxlm);
>  	if (rc)
>  		return rc;

