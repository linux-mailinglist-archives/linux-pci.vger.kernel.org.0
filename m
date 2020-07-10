Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF6D21AC34
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 02:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGJAyO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 20:54:14 -0400
Received: from mx.socionext.com ([202.248.49.38]:39525 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgGJAyO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 20:54:14 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 10 Jul 2020 09:54:13 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 4A74D180C09;
        Fri, 10 Jul 2020 09:54:13 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 10 Jul 2020 09:54:13 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 2EDCD1A0507;
        Fri, 10 Jul 2020 09:54:13 +0900 (JST)
Received: from [10.213.31.123] (unknown [10.213.31.123])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 847BE12012F;
        Fri, 10 Jul 2020 09:54:12 +0900 (JST)
Subject: Re: [PATCH v5 6/6] PCI: uniphier: Use
 devm_platform_ioremap_resource_byname()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1592469493-1549-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1592469493-1549-7-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <f7138d4c-be56-5519-fbb2-3c655945f5ff@socionext.com>
Date:   Fri, 10 Jul 2020 09:54:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592469493-1549-7-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

This 6/6 patch has just been covered with the following patch:
https://patchwork.ozlabs.org/project/linux-pci/patch/20200708164013.5076-1-zhengdejin5@gmail.com/

As a result, my other patches conflict with this patch.
I'd like your comments in the patch 2/6, though,
should I rebase to pci/dwc and resend this series without 6/6?

Thank you,

On 2020/06/18 17:38, Kunihiko Hayashi wrote:
> Use devm_platform_ioremap_resource_byname() to simplify the code a bit.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>f
> ---
>   drivers/pci/controller/dwc/pcie-uniphier.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index 8356dd3..233d624 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -456,8 +456,7 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
>   	if (IS_ERR(priv->pci.atu_base))
>   		priv->pci.atu_base = NULL;
>   
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "link");
> -	priv->base = devm_ioremap_resource(dev, res);
> +	priv->base = devm_platform_ioremap_resource_byname(pdev, "link");
>   	if (IS_ERR(priv->base))
>   		return PTR_ERR(priv->base);
>   
> 

---
Best Regards
Kunihiko Hayashi
