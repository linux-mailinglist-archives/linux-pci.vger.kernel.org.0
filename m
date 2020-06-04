Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C651EDA0A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 02:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgFDAj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 20:39:59 -0400
Received: from mx.socionext.com ([202.248.49.38]:25906 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgFDAj7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 20:39:59 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 04 Jun 2020 09:39:56 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id B2B3160057;
        Thu,  4 Jun 2020 09:39:56 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 4 Jun 2020 09:39:56 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 380EB4036D;
        Thu,  4 Jun 2020 09:39:56 +0900 (JST)
Received: from [10.213.29.200] (unknown [10.213.29.200])
        by yuzu.css.socionext.com (Postfix) with ESMTP id CDDA5120136;
        Thu,  4 Jun 2020 09:39:55 +0900 (JST)
Subject: Re: [PATCH] PCI: uniphier: Fix some error handling in
 uniphier_pcie_ep_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200603175207.GB18931@mwanda>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <9446f66c-a976-0b04-6866-10c2dca3f2ec@socionext.com>
Date:   Thu, 4 Jun 2020 09:39:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603175207.GB18931@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dan,

On 2020/06/04 2:52, Dan Carpenter wrote:
> This code is checking the wrong variable.  It should be checking
> "clk_gio" instead of "clk".  The "priv->clk" pointer is NULL at this
> point so the condition is false.
> 
> Fixes: 006564dee8253 ("PCI: uniphier: Add Socionext UniPhier Pro5 PCIe endpoint controller driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/pci/controller/dwc/pcie-uniphier-ep.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> index 0f36aa33d2e50..1483559600610 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> @@ -324,8 +324,8 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
>   		return PTR_ERR(priv->base);
>   
>   	priv->clk_gio = devm_clk_get(dev, "gio");
> -	if (IS_ERR(priv->clk))
> -		return PTR_ERR(priv->clk);
> +	if (IS_ERR(priv->clk_gio))
> +		return PTR_ERR(priv->clk_gio);
>   
>   	priv->rst_gio = devm_reset_control_get_shared(dev, "gio");
>   	if (IS_ERR(priv->rst_gio))
> 

Thank you for pointing out.
Certainly this is a wrong check.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thanks,

---
Best Regards
Kunihiko Hayashi
