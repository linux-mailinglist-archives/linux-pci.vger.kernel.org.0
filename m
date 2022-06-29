Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C0955F6AE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiF2Gd0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiF2GdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:33:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5944A2B187
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 23:33:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e40so20793494eda.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 23:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uEtzjuPdWRp5nN4ODrTO9P43DISR/p8u6Tj+99fvmYg=;
        b=Eqf7+M/Rozoa2hcKD4htdJ59DzLzYsTKK6P9k9pKfoiXFestJGV7MyYpuWjsUqGair
         IgKYC9r19yvRn/ceJ4cRRJUMyT6QcGY7KhBEqyY250LjwoeOtFlgSitJkMJ+DZjP7/z+
         GMX51tjt6vam5ZKSE4rjVz4Y/y76eZ0QsDuXj6C3paf+fHUwo1w1BCzZj6qqtuDbQ0Jq
         o3leItsBxtuIWrjhsdMk+HpAftujRnhkGalVveDeuZdIfEgfDvzV9P5F71mUWbXy46lB
         LD286F17zEI5zCrfLFAMwbpT/T+GwPC/x5SKrqdKtKX55rl5xk7pqIrfqnKESt5xABIk
         Nhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uEtzjuPdWRp5nN4ODrTO9P43DISR/p8u6Tj+99fvmYg=;
        b=y3icA83oexQtV8kN+G3+4fp7Y7nk8hbXbUB8L8VzKUC+Eb3ZyDgkPOfnjxJbHAu11Z
         +dEQgjil5iiaQ1aZpCF9l0w5IQJGdwUYPdiSYDdenqtxl9QRU4+pk4VCzzGQv6XeV7Gh
         xzzPUUuJo/hbZ3IcwSnuWNFAD5dZN62tF72/OwtXcT2+gXxdXmkusugQtplnyKjYrtcB
         ayrDW1ZLBBuwcaqLQ6sY3vwL2h3khJ4lKeqcuNCbB8tICUG1NYjX5qeT4tpbZVOgxVB1
         7K8cZkVFzuVcxeHUi/sW4tvBy4ntKR3TARgQUQP6tGCi+p5H/DIwgIb6HtKO2lp7FM4C
         TSIQ==
X-Gm-Message-State: AJIora/V823J/U+Hl2LH2MH1LFWU7AqYBH6J7eKJAO4CESeJmPxUKMpD
        g84k5rwSvf8+4nljsCW0Tjhl6g==
X-Google-Smtp-Source: AGRyM1tKvhsMukZkWc/oVEQkL2aYx3zGzUcwIOjCgYjLJ+HmZ3D9YrslTZegAyZD5mm9BSEYNKtCCg==
X-Received: by 2002:a05:6402:1459:b0:437:9282:2076 with SMTP id d25-20020a056402145900b0043792822076mr2117591edx.6.1656484401954;
        Tue, 28 Jun 2022 23:33:21 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7c04e000000b00431962fe5d4sm10849901edo.77.2022.06.28.23.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 23:33:20 -0700 (PDT)
Message-ID: <a7b1f595-0d04-4ba7-8bc3-e2cab3315003@linaro.org>
Date:   Wed, 29 Jun 2022 08:33:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V3 04/11] dt-bindings: PCI: tegra234: Add schema for
 tegra234 endpoint mode
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     kishon@ti.com, vkoul@kernel.org, kw@linux.com,
        p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220629060435.25297-1-vidyas@nvidia.com>
 <20220629060435.25297-5-vidyas@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629060435.25297-5-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/06/2022 08:04, Vidya Sagar wrote:
> Add support for PCIe controllers that operate in the endpoint mode
> in tegra234 chipset.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * New patch in this series
> 
>  .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 141 +++++++++++++++++-
>  1 file changed, 136 insertions(+), 5 deletions(-)
> 

All comments from patch #3 apply.

> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> index 4f7cb7fe378e..11778eb92c47 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> @@ -17,6 +17,7 @@ description: |
>    in they can work either in root port mode or endpoint mode but one at a time.
>  
>    On Tegra194, controllers C0, C4 and C5 support endpoint mode.
> +  On Tegra234, controllers C5, C6, C7 and C10 support endpoint mode.
>  
>    Note: On Tegra194's P2972-0000 platform, only C5 controller can be enabled to operate in the
>    endpoint mode because of the way the platform is designed.
> @@ -25,6 +26,7 @@ properties:
>    compatible:
>      enum:
>        - nvidia,tegra194-pcie-ep
> +      - nvidia,tegra234-pcie-ep
>  
>    reg:

(...)

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra234-pcie
> +    then:
> +      properties:
> +        nvidia,bpmp:
> +          items:
> +            - items:
> +                - minimum: 0
> +                  maximum: 0xffffffff
> +                - enum: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
> +
>  unevaluatedProperties: false
>  
>  required:
> @@ -174,6 +245,7 @@ required:
>    - power-domains
>    - reset-gpios
>    - num-lanes
> +  - vddio-pex-ctl-supply

This is unexpected and looks unrelated.


Best regards,
Krzysztof
