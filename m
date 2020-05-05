Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1741C53BA
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 12:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgEEKye (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 06:54:34 -0400
Received: from foss.arm.com ([217.140.110.172]:37068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgEEKye (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 06:54:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2470430E;
        Tue,  5 May 2020 03:54:33 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E221B3F305;
        Tue,  5 May 2020 03:54:31 -0700 (PDT)
Date:   Tue, 5 May 2020 11:54:29 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next  v2] PCI: dwc: pci-dra7xx: use
 devm_platform_ioremap_resource_byname()
Message-ID: <20200505105429.GB13446@e121166-lin.cambridge.arm.com>
References: <20200427111044.162618-1-weiyongjun1@huawei.com>
 <20200429015027.134485-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429015027.134485-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 29, 2020 at 01:50:27AM +0000, Wei Yongjun wrote:
> platform_get_resource() may fail and return NULL, so we should better
> check it's return value to avoid a NULL pointer dereference a bit later
> in the code. Fix it to use devm_platform_ioremap_resource_byname()
> instead of calling platform_get_resource_byname() and devm_ioremap().
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> v1 -> v2: use devm_platform_ioremap_resource_byname, suggest by Vignesh
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Applied to pci/dwc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 3b0e58f2de58..6184ebc9392d 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -840,7 +840,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  	struct phy **phy;
>  	struct device_link **link;
>  	void __iomem *base;
> -	struct resource *res;
>  	struct dw_pcie *pci;
>  	struct dra7xx_pcie *dra7xx;
>  	struct device *dev = &pdev->dev;
> @@ -877,10 +876,9 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  		return irq;
>  	}
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
> -	base = devm_ioremap(dev, res->start, resource_size(res));
> -	if (!base)
> -		return -ENOMEM;
> +	base = devm_platform_ioremap_resource_byname(pdev, "ti_conf");
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
>  
>  	phy_count = of_property_count_strings(np, "phy-names");
>  	if (phy_count < 0) {
> 
> 
> 
