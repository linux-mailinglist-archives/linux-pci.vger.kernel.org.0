Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A906992B3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 12:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjBPLHL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 06:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjBPLHJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 06:07:09 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1CD37F19
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 03:07:07 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id he33so4165582ejc.11
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 03:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XtfON9YmhK/54vgAcFs1XoGNiMG/tSNcLmL9ZluKEY=;
        b=xTtIjm+aMf26mPdovCi9L09kIwvE8z/9D/ZIgVDo0CjMWbgGkRpVEkbqaNq9/LFb2U
         HY6jsIAafQ37cZZSt+uegtQyTo6Fq4h2IKtAyXLOh41gpi37gjU0x+XmkmOAvhMHr5ug
         /SZVtkSJ7E8qiF0nTUg6h9vwIgJ3LC3hr9hlBYWKTMp0snLWgXTs+eSKsliGFKaOZcgq
         Vff7AaoxCVd0MqqXOfHXLjWCy/EZbLz/lD8Mav5xSyezIFhxgs5ypS8LqbH/79iGNMcr
         Ltu5XMxQGBheqBUSdTfV148/7BoiuncWJkivuxWaSfYCkt+NqlFpQZplIJDt6iVa6txF
         DgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XtfON9YmhK/54vgAcFs1XoGNiMG/tSNcLmL9ZluKEY=;
        b=1jChtNVKnT1SmvwdulA1pM42SgrBkaRqi0ZCF8+S1tzYABNLbJ+gbN+VHGunwbMYqo
         pMhKaDnLa7PG0qHh6PP4JdAVOkj4pK1M97UiTfQ/iLaKjMPVSZ8LGuF+Y7d8+rvfXZXg
         3x76ZelPLrqW+pqmjsNKjkn6qZ8WFZSzAlVO+4PjePGTXGe2DEioR7xQJ0wE5G0qSP0t
         z95L2G9JZb/bB2PIcOG46z6kbU1K0CFZVCexNKQO64SBRXzXMtXxXN7WwpQ0Bq0KBw8M
         DO8dPxkNe9EwXmIdwf0VEbCc02f5+2wP+OYJ01vAy1oV5A7s6zfGTFtmYjnJZa6TxsWc
         WLAw==
X-Gm-Message-State: AO0yUKXhUU+/Ov9kJwDyOmDk8XG6ePoyGP0/fqwz0qguYIqeF8rAD9t9
        waMz9uwVgEaYA7TOBg6Ro+Mg0O31qe2LVQx/
X-Google-Smtp-Source: AK7set9+/bKi4OtttusS38rCL3Uq4qJh+IzTiwS3GRQZ6Gip9Lt1BDOBFqxhTbtmvnS3mFcQtENeVQ==
X-Received: by 2002:a17:906:40e:b0:87b:dc07:380f with SMTP id d14-20020a170906040e00b0087bdc07380fmr6245015eja.0.1676545626049;
        Thu, 16 Feb 2023 03:07:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ad24-20020a170907259800b0087bdac06a3bsm681976ejc.2.2023.02.16.03.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 03:07:05 -0800 (PST)
Message-ID: <a4bfad9d-b9df-28a5-6bee-5cbbca4dd23f@linaro.org>
Date:   Thu, 16 Feb 2023 12:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 08/16] PCI: samsung: Rename exynos_pcie to samsung_pcie
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
 <CGME20230214121436epcas5p1641de02220bea5edb23bc875b6311270@epcas5p1.samsung.com>
 <20230214121333.1837-9-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214121333.1837-9-shradha.t@samsung.com>
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
> The platform specific structure being used is named
> exynos_pcie. Changing it to samsung_pcie for making it
> generic.
> 
> Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pci-samsung.c | 190 +++++++++++------------
>  1 file changed, 95 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
> index d5adf1017a05..be0177fcd763 100644
> --- a/drivers/pci/controller/dwc/pci-samsung.c
> +++ b/drivers/pci/controller/dwc/pci-samsung.c
> @@ -23,7 +23,7 @@
>  
>  #include "pcie-designware.h"
>  
> -#define to_exynos_pcie(x)	dev_get_drvdata((x)->dev)
> +#define to_samsung_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  /* PCIe APPL registers */
>  #define EXYNOS_PCIE_IRQ_PULSE			0x000
> @@ -51,7 +51,7 @@
>  #define EXYNOS_PCIE_APPL_SLV_ARMISC		0x120
>  #define EXYNOS_PCIE_APPL_SLV_DBI_ENABLE	BIT(21)
>  
> -struct exynos_pcie {
> +struct samsung_pcie {

No, I don't see benefit of this at all. How we call stuff inside driver
is not related whether this is for Tesla or Exynos. We could even call
it "pony". :) Thus renamings just to support new variant of Samsung
device is not a good reason.

Unless all of the old "exynos" names will be soon needed for some
exynos-specific variants?

Best regards,
Krzysztof

