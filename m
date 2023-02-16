Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101256992D8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 12:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBPLL4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 06:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPLLz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 06:11:55 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8D183FD
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 03:11:53 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id b2so4226140ejz.9
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 03:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNhqYGj1vLN2v1vRAyqF2Z1mw1XUvACBLxpmP0puvR8=;
        b=AQKhMPfIpqNRBEQiQTqupLYJIPzl6FkSv6NQ3Fri9M5xBtaBlylJ5RwbTz0GLBArQN
         kesQKiEVvQWNQ+/3oTPajBmOOPLknDGR7hJQMbw7wlmr3TZKEtiN+v/mrdQNkBqTQcO2
         jgLwilgOpSwOLBFBUahZs427LfIoryXmcTJbd84L8CQW1Sc4R8vB3KroAEu5qFeKw6WO
         Bj8x0dQiIkYQqm9KTSNyzWIsm3JYEVZ59iLo3sJB9eltLqMYVf693OxQFqSa7eHz2Zzk
         o7LLWKp6stJ9VAzjoZoFanuJ+QMsEAwpyPvXi9T4Y1fmkNUtwnqB1DL8n47eRiwa0qFX
         XFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNhqYGj1vLN2v1vRAyqF2Z1mw1XUvACBLxpmP0puvR8=;
        b=pf/xD7Ukwo33VoIYXo8GSIR4QLFiXJaztiCjfCME04ZynezvlR0v71vpVa0otWyUdM
         Sg0mmRVn8I0jbKBoAdGpIyZ+w1/ZRoRE8cw9sC32gUI22VHVh4VziQnxGOl5ZgUxU9PN
         lG4gm6tJ+rvxZMAjHFvsTx/tOKQg1H/hqcp6pCiSc6WQQG3o89k2KLUKH/wl+dpbnbXQ
         x8f5GOWhxfas5XufTH2OFFIGnyIfJXZ5HmLlxPPevcs96XFGlHyrE4k3XK6WkYtjvhOH
         KnSqmej2mnNhrp42vAaVqjvGZ2Py4/g/+07me2od82jFJhIxxI+7NB7yKhZm1n5khF6t
         XYgQ==
X-Gm-Message-State: AO0yUKWWJWWHPxV+3mnM/AnsHWzyWzOEs4caTEO0oAI5O9d5Xxgm6JHM
        LqYCgYIOLtf6zwS2Xhay10Fc3A==
X-Google-Smtp-Source: AK7set/DH6Dn0+3n9f9oN7LRJsmOT12HOFk4osoy37duY3LEuxFLeBMCEwkXEDq4XLqQZe9Hchgqvw==
X-Received: by 2002:a17:907:2ce4:b0:8b1:22af:b39f with SMTP id hz4-20020a1709072ce400b008b122afb39fmr7188453ejc.13.1676545912107;
        Thu, 16 Feb 2023 03:11:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709066bd300b008b133f9a197sm656548ejs.198.2023.02.16.03.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 03:11:51 -0800 (PST)
Message-ID: <a0c79665-adb9-a846-5a84-d85e0684c25f@linaro.org>
Date:   Thu, 16 Feb 2023 12:11:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 15/16] PCI: samsung: Add structure to hold resource
 operations
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
 <CGME20230214121503epcas5p291dce2b37ec4cdabcfecbf8fbdfcca51@epcas5p2.samsung.com>
 <20230214121333.1837-16-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214121333.1837-16-shradha.t@samsung.com>
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
> Some resources might differ based on platforms and we

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

Wrapping looks a bit short...

> need platform specific functions to initialize or alter
> them. For better code reusibility, making a separate

typo, I think it is: re-usability

> res_ops which will hold all such function pointers or
> other resource specific data.

Are you saying that interrupts differ in different devices?

> 
> This patch includes adding function pointer for IRQ

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> initialization which will help to move common operations for
> host init into the probe sequence.
> 
> Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pci-samsung.c | 26 ++++++++++++++++--------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
> index 47ca2a6a545d..01882f2d06c7 100644
> --- a/drivers/pci/controller/dwc/pci-samsung.c
> +++ b/drivers/pci/controller/dwc/pci-samsung.c
> @@ -55,6 +55,7 @@ struct samsung_pcie_pdata {
>  	struct pci_ops				*pci_ops;
>  	const struct dw_pcie_ops		*dwc_ops;
>  	const struct dw_pcie_host_ops		*host_ops;
> +	const struct samsung_res_ops		*res_ops;
>  };
>  
>  /*
> @@ -77,6 +78,10 @@ struct samsung_pcie {
>  	struct regulator_bulk_data	supplies[2];
>  };
>  
> +struct samsung_res_ops {
> +	int (*irq_init)(struct samsung_pcie *sp, struct platform_device *pdev);
> +};
> +
>  static int samsung_pcie_init_clk_resources(struct samsung_pcie *sp)
>  {
>  	struct device *dev = sp->pci.dev;
> @@ -276,7 +281,7 @@ static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
>  	.host_init = exynos_pcie_host_init,
>  };
>  
> -static int exynos_add_pcie_port(struct samsung_pcie *sp,
> +static int exynos_irq_init(struct samsung_pcie *sp,
>  				       struct platform_device *pdev)
>  {
>  	struct dw_pcie *pci = &sp->pci;
> @@ -295,15 +300,8 @@ static int exynos_add_pcie_port(struct samsung_pcie *sp,
>  		return ret;
>  	}
>  
> -	pp->ops = &exynos_pcie_host_ops;
>  	pp->msi_irq[0] = -ENODEV;
>  
> -	ret = dw_pcie_host_init(pp);
> -	if (ret) {
> -		dev_err(dev, "failed to initialize host\n");
> -		return ret;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -314,6 +312,10 @@ static const struct dw_pcie_ops exynos_dw_pcie_ops = {
>  	.start_link = exynos_pcie_start_link,
>  };
>  
> +static const struct samsung_res_ops exynos_res_ops_data = {
> +	.irq_init		= exynos_irq_init,
> +};
> +
>  static int samsung_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -357,7 +359,12 @@ static int samsung_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sp);
>  
> -	ret = exynos_add_pcie_port(sp, pdev);
> +	if (pdata->res_ops->irq_init)
> +		pdata->res_ops->irq_init(sp, pdev);

Check return value and handle errors.

> +
> +	sp->pci.pp.ops = pdata->host_ops;
> +
> +	ret = dw_pcie_host_init(&sp->pci.pp);
>  	if (ret < 0)
>  		goto fail_probe;
>  
> @@ -428,6 +435,7 @@ static const struct samsung_pcie_pdata exynos_5433_pcie_rc_pdata = {
>  	.dwc_ops		= &exynos_dw_pcie_ops,
>  	.pci_ops		= &exynos_pci_ops,
>  	.host_ops		= &exynos_pcie_host_ops,
> +	.res_ops		= &exynos_res_ops_data,
>  };
>  
>  static const struct of_device_id samsung_pcie_of_match[] = {

Best regards,
Krzysztof

