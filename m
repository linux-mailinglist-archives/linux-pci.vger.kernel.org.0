Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3041825C47D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 17:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgICPLm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 11:11:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10761 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728794AbgICM3x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Sep 2020 08:29:53 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4FA327C2F37E81201268;
        Thu,  3 Sep 2020 20:29:43 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 20:29:34 +0800
Subject: Re: [PATCH] PCI: exynos: simplify with PTR_ERR_OR_ZERO
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>
References: <1599123916-65530-1-git-send-email-xuwei5@hisilicon.com>
CC:     <linuxarm@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>,
        <salil.mehta@huawei.com>, <shiju.jose@huawei.com>,
        <jinying@hisilicon.com>, <zhangyi.ac@huawei.com>,
        <liguozhu@hisilicon.com>, <tangkunshan@huawei.com>,
        <huangdaode@hisilicon.com>, Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5F50E1AE.2020505@hisilicon.com>
Date:   Thu, 3 Sep 2020 20:29:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1599123916-65530-1-git-send-email-xuwei5@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Sorry for the noise and please ignore it.
I found these kind of changes have been sent and rejected before.

Best Regards,
Wei

On 2020/9/3 17:05, Wei Xu wrote:
> Use PTR_ERR_OR_ZERO to make the code a little bit simpler.
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index 8d82c43..f59f027 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -90,10 +90,7 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
>  		return -ENOMEM;
>  
>  	ep->mem_res->elbi_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(ep->mem_res->elbi_base))
> -		return PTR_ERR(ep->mem_res->elbi_base);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(ep->mem_res->elbi_base);
>  }
>  
>  static int exynos5440_pcie_get_clk_resources(struct exynos_pcie *ep)
> 
