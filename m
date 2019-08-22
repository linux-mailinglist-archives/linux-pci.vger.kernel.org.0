Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4DB49900A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 11:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfHVJyH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 05:54:07 -0400
Received: from foss.arm.com ([217.140.110.172]:42730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbfHVJyG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 05:54:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E723C15A2;
        Thu, 22 Aug 2019 02:54:05 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C79093F246;
        Thu, 22 Aug 2019 02:54:04 -0700 (PDT)
Date:   Thu, 22 Aug 2019 10:54:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI: tegra: Fix the error return code in
 tegra_pcie_dw_probe()
Message-ID: <20190822095400.GA22716@e121166-lin.cambridge.arm.com>
References: <20190822020352.35412-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822020352.35412-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 22, 2019 at 02:03:52AM +0000, Wei Yongjun wrote:
> Fix the error return code in tegra_pcie_dw_probe() by using error code
> instead of PTR_ERR(NULL) which is always 0.
> 
> Fixes: 6404441c8e13 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Squashed in the original commit and re-pushed out my pci/tegra branch,
thank you.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index fc0dbeb31d78..678a6b51c7aa 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1384,7 +1384,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>  						      "appl");
>  	if (!pcie->appl_res) {
>  		dev_err(dev, "Failed to find \"appl\" region\n");
> -		return PTR_ERR(pcie->appl_res);
> +		return -ENODEV;
>  	}
>  
>  	pcie->appl_base = devm_ioremap_resource(dev, pcie->appl_res);
> @@ -1400,7 +1400,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>  
>  	phys = devm_kcalloc(dev, pcie->phy_count, sizeof(*phys), GFP_KERNEL);
>  	if (!phys)
> -		return PTR_ERR(phys);
> +		return -ENOMEM;
>  
>  	for (i = 0; i < pcie->phy_count; i++) {
>  		name = kasprintf(GFP_KERNEL, "p2u-%u", i);
> @@ -1422,7 +1422,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>  	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
>  	if (!dbi_res) {
>  		dev_err(dev, "Failed to find \"dbi\" region\n");
> -		return PTR_ERR(dbi_res);
> +		return -ENODEV;
>  	}
>  	pcie->dbi_res = dbi_res;
>  
> @@ -1437,7 +1437,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>  						   "atu_dma");
>  	if (!atu_dma_res) {
>  		dev_err(dev, "Failed to find \"atu_dma\" region\n");
> -		return PTR_ERR(atu_dma_res);
> +		return -ENODEV;
>  	}
>  	pcie->atu_dma_res = atu_dma_res;
> 
> 
> 
