Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C696992C4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 12:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjBPLJc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 06:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjBPLJc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 06:09:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E14224
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 03:09:30 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cq19so2270481edb.5
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 03:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3iiqH06nUTpPWYilgK2IFHj13BbO9uCZQ5Bymri4gs=;
        b=cmzSs1x1uugc4EQOj+4Gw22iLIlzjJkEO/Pz7kDoPraCLYFaLp7LK7gxHRSb4Rhrxj
         PXPCvcsjd1LOKa5sC/+YFMAol7I6Gi6WcmqSSNf3J8Vb8dpJEyEwlHJHLJ7Rkd6wgDV1
         I4GfUatKxHSck7cIL7jhaQAUuxr2hJ6WECjfITXdl9UGxvQwsnHEjiQiah0j4Pa4Fw4P
         WbfM/yLLq093PHgwbM5x+UMEqFPhoXiRlvfneB3BP9THB7DmxbDR0suzmIs8kqazRPBT
         muSRLpK2kvpJWKUtlL5RZ5HSh71t8OJsdD+mOrGnGxaIhAvp598jeJ010eAQwXbzGuMZ
         B4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3iiqH06nUTpPWYilgK2IFHj13BbO9uCZQ5Bymri4gs=;
        b=eO9co0T5Y6yGlvz6BqqYzrQDmmTP/jq+d8EgEB71n/c2mREf/UmLG91DWkkEGot3mP
         Ay0IC1tgMuzbWfPXcF7kEh/FmlYuQjnroOlgbGPbOWrubN4vvB2s8fYERp/SP29kyuuc
         MsHBMTA8X7K9fZz/lSDC5Je3AZ3UU/ekUxrDdqtWUVlcp/cdKJ2KxryxTejDb0HsOAMc
         iTqGyJEjJjLlZ2hzqO1CG9/mvLaFirnsO2EsX5lCxlzF7GL32EFmNmLTWVzPKTC5UjCZ
         VtXSlgWs7WVQuPqAod/tILjtXePySPxJ4dCzlWkqi+7JBu1en86QXq83U2kFtI4N/Ufy
         6CCQ==
X-Gm-Message-State: AO0yUKXCH85FXdOkKNZW5wGbSo0VQoUVwFPDmqlO7oWyp1aXHZSTom+X
        fBCLQuCe7bMHEZhjjp/hZDcE1g==
X-Google-Smtp-Source: AK7set+atTYUvsw9Bi58sXSveqCbuDXNoORblsEZyFSBSAF12mVmwb9zx0f0LjR4QO0iZYzNQH+X0w==
X-Received: by 2002:aa7:d4c1:0:b0:4ad:6fc6:ae9c with SMTP id t1-20020aa7d4c1000000b004ad6fc6ae9cmr466265edr.17.1676545769139;
        Thu, 16 Feb 2023 03:09:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b12-20020a50cccc000000b004acc123cd94sm693183edj.30.2023.02.16.03.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 03:09:28 -0800 (PST)
Message-ID: <a8f0cd74-6094-d24a-b126-ea7737e39a01@linaro.org>
Date:   Thu, 16 Feb 2023 12:09:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 13/16] PCI: samsung: Rename common functions to samsung
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jingoohan1@gmail.com, Sergey.Semin@baikalelectronics.ru,
        lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, tglx@linutronix.de,
        m.szyprowski@samsung.com, jh80.chung@samsung.co,
        pankaj.dubey@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214121333.1837-1-shradha.t@samsung.com>
 <CGME20230214121456epcas5p36603c8d717588699d1b5575229d19114@epcas5p3.samsung.com>
 <20230214121333.1837-14-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214121333.1837-14-shradha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/02/2023 13:13, Shradha Todi wrote:
> Use samsung instead of exynos for all common functions
> like probe/remove/suspend/resume.
> 
> Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pci-samsung.c | 42 ++++++++++++------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
> index 719d284e1552..dc8ec0b546fd 100644
> --- a/drivers/pci/controller/dwc/pci-samsung.c
> +++ b/drivers/pci/controller/dwc/pci-samsung.c
> @@ -60,7 +60,7 @@ struct samsung_pcie {
>  	struct regulator_bulk_data	supplies[2];
>  };
>  
> -static int exynos_pcie_init_clk_resources(struct samsung_pcie *sp)
> +static int samsung_pcie_init_clk_resources(struct samsung_pcie *sp)

Same as before - I don't see here benefit.

>  {
>  	struct device *dev = sp->pci.dev;
>  	int ret;
> @@ -74,7 +74,7 @@ static int exynos_pcie_init_clk_resources(struct samsung_pcie *sp)
>  	return clk_bulk_prepare_enable(sp->clk_cnt, sp->clks);
>  }
>  

(...)

>  
> -static struct platform_driver exynos_pcie_driver = {
> -	.probe		= exynos_pcie_probe,
> -	.remove		= __exit_p(exynos_pcie_remove),
> +static struct platform_driver samsung_pcie_driver = {
> +	.probe		= samsung_pcie_probe,
> +	.remove		= __exit_p(samsung_pcie_remove),
>  	.driver = {
> -		.name	= "exynos-pcie",
> -		.of_match_table = exynos_pcie_of_match,
> -		.pm		= &exynos_pcie_pm_ops,
> +		.name	= "samsung-pcie",

This "name" has some point... but I think it would break now all module
users.

> +		.of_match_table = samsung_pcie_of_match,
> +		.pm		= &samsung_pcie_pm_ops,
>  	},
>  };
> -module_platform_driver(exynos_pcie_driver);
> +module_platform_driver(samsung_pcie_driver);
>  MODULE_LICENSE("GPL v2");
> -MODULE_DEVICE_TABLE(of, exynos_pcie_of_match);
> +MODULE_DEVICE_TABLE(of, samsung_pcie_of_match);

Best regards,
Krzysztof

