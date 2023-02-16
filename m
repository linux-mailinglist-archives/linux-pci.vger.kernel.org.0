Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257AA699251
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBPKyj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjBPKyd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:54:33 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D27555E6D
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:54:21 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id lf10so4172447ejc.5
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QI8K5VaPcZDVX01pTM1BIt9n+MIastinOXR0Yd0M3Ns=;
        b=WXzPGozQEHAoWnI1lpMvXFw+Ugjikfz4UPisdi8HsJENaIY/CtxKjJSSaFTlLOzYwa
         /bXY0OL8LwVTwXU5QGl0qKlcdpalrjCHdu8Cxj6SzGHdVjS2rmdPTq0dBjh67+rAVlIc
         rJCQn/LShtJACkLjc8bC1Bv2N+foa3X1ZMNPL/ktu56OP+TBfiiVZ+m1rG9vi+/eeqUK
         Gcai1yavx6l9abE5W7+NJz9ynC4jeSEfyaOTS0fSli6wzGl203iJHyO5V2rQRlEaPKoA
         mdtM5ebNLfVmxT1X15Gdk2WEMmxPlh0fXkrqU6oS3HXZFUGHeNf9rYzIIVhEW87/beAN
         6UUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QI8K5VaPcZDVX01pTM1BIt9n+MIastinOXR0Yd0M3Ns=;
        b=jOeWTBJjmI6uXq0MulWu+UDpb26GGqUU5v52QpdohgERT45ld6uxDeJei5UZ+Dutxs
         v7lFcrsBf2aAe/nl7Hl/3ULz36sJlWg6zacEznFVRBarpMPhx7P2gRac5IrcXhspLJbV
         FKpwBGGq+gLn5kMpkaVKic8z5XxJ3YcYN/8gOVnyMjkOfmTLA1I0UH4u60UWnwQpDXE8
         FNkAWHntd6Hsby+6bXGquP7fVk9Zwvtss2y9glC5uKTTua7j94MLzWNqEm9MPoQwAbXc
         7Yeyu7EwMAqQttTn3nLNGs8wcnAl/V9tk25iaScXb4PhviW45yZKO0PboxxpBdQfuM1b
         FRCg==
X-Gm-Message-State: AO0yUKV5aYhq/lew3gAFrvi8KmPDwPcAigNMcTiWOMYyVDPtpzm3RwBk
        1DfBLYLLdi7hSBqa7nNsBD/nbg==
X-Google-Smtp-Source: AK7set+o2bzX5AwaFF5qCgbb5gZPGOApJ9Hy9hx2HWKBa/1QeqK05TbZr53k40utmIxOIunE7z7y2w==
X-Received: by 2002:a17:906:8502:b0:88b:23bb:e61f with SMTP id i2-20020a170906850200b0088b23bbe61fmr5734558ejx.25.1676544859978;
        Thu, 16 Feb 2023 02:54:19 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id kq16-20020a170906abd000b00889a77458dbsm657273ejb.21.2023.02.16.02.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:54:19 -0800 (PST)
Message-ID: <b40cafa1-396f-e6cd-3240-bc879d5f2c8b@linaro.org>
Date:   Thu, 16 Feb 2023 11:54:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 01/16] dt-bindings: PCI: Rename Exynos PCIe binding to
 Samsung PCIe
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
 <CGME20230214121404epcas5p3bfa6af0151b7f319d418f7c0dbed7c5a@epcas5p3.samsung.com>
 <20230214121333.1837-2-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214121333.1837-2-shradha.t@samsung.com>
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
> The current DT bindings is being used for Exynos5433 SoC only.
> In order to extend this binding for all SoCs manufactured by
> Samsung using DWC PCIe controller, renaming this file to a more
> generic name.

Thank you for your patch. There is something to discuss/improve.

> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  .../pci/{samsung,exynos-pcie.yaml => samsung,pcie.yaml}     | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>  rename Documentation/devicetree/bindings/pci/{samsung,exynos-pcie.yaml => samsung,pcie.yaml} (93%)
> 
> diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
> similarity index 93%
> rename from Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> rename to Documentation/devicetree/bindings/pci/samsung,pcie.yaml
> index f20ed7e709f7..6cd36d9ccba0 100644
> --- a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml

We keep the name rather tied to compatible, not generic. There are no
other compatibles here, so I don't think we should rename it.

Best regards,
Krzysztof

