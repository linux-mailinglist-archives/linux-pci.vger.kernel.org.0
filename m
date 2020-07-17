Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B10622409A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 18:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGQQbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 12:31:19 -0400
Received: from foss.arm.com ([217.140.110.172]:45286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgGQQbS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jul 2020 12:31:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D75312FC;
        Fri, 17 Jul 2020 09:31:17 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82CF33F68F;
        Fri, 17 Jul 2020 09:31:16 -0700 (PDT)
Date:   Fri, 17 Jul 2020 17:31:11 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     m-karicheri2@ti.com, robh@kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1] PCI: dwc: fix a warning about variable 'res' is
 uninitialized
Message-ID: <20200717163111.GA8421@e121166-lin.cambridge.arm.com>
References: <20200717133007.23858-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717133007.23858-1-zhengdejin5@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 17, 2020 at 09:30:07PM +0800, Dejin Zheng wrote:
> The kernel test robot reported a compile warning,
> 
> drivers/pci/controller/dwc/pci-keystone.c:1236:18: warning: variable 'res'
> is uninitialized when used here [-Wuninitialized]
> 
> The commit c59a7d771134b5 ("PCI: dwc: Convert to
> devm_platform_ioremap_resource_byname()") did a wrong conversion for
> keystone driver. the commit use devm_platform_ioremap_resource_byname()
> to replace platform_get_resource_byname() and devm_ioremap_resource().
> but the subsequent code needs to use the variable 'res', which is got by
> platform_get_resource_byname() for resource "app". so revert it.
> 
> Fixes: c59a7d771134b5 ("PCI: dwc: Convert to devm_platform_ioremap_resource_byname()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Squashed in the commit it is fixing, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 5ffc3b40c4f6..00279002102e 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1228,8 +1228,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	if (!pci)
>  		return -ENOMEM;
>  
> -	ks_pcie->va_app_base =
> -		devm_platform_ioremap_resource_byname(pdev, "app");
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> +	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(ks_pcie->va_app_base))
>  		return PTR_ERR(ks_pcie->va_app_base);
>  
> -- 
> 2.25.0
> 
