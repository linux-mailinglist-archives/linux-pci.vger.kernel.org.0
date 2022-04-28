Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6141D513356
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 14:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346021AbiD1MLR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 08:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346015AbiD1MLQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 08:11:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0095972BD
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 05:08:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gh6so9221358ejb.0
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=W8vavm6FTiaCee3snFJH68JdUWxiifc2ZR26JZUl8es=;
        b=i+TWqXM8bU/Oxxfu0lys7gl8SxgR+MOfjYn1L1BOg+Ez48R/VKe5V+ftF46PJpz7PJ
         awM/1r4Sp3LpmZKXDTD5E3mDWfaOW6Ok367wz7aLa4W5umIvAVbwUc0Q/3pLNZVNBBWi
         C+4zR7UnJ4XSTC9OyhDChHYDWJ2fYc9Z1p1sLzjdhxKY4k6N4P6f9LzikbZNTHtNn7B+
         lWVVMS5BjMwLtX/CpNudZOJTv9pzsXqopPkLzYwMpFIm6CvsLZzdFfJTRvFcSz+PQTmo
         OHmQVAf6LlbTYqti4Eyz3hvyHlojhCnR1atT5vb0GuAX4dFL2AMnWePYxaqwXSR7aIP8
         JPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W8vavm6FTiaCee3snFJH68JdUWxiifc2ZR26JZUl8es=;
        b=e3wnxq07RxFr2s8MlTJK7so73HcMkW1/N5cPZ9XHLQc6K9HiHWtyVU/M/DDKAxF6sb
         0HkxD8vTtW/VROxycdVD7uugwAJHWHWVhDOhRDSJl4ADRWvJo1/ztx0gSSnvo/Q5RSL/
         pxkW5eJ+uaTbT+P66oFTrNPy8orFh+3vZ8wfK9gYtwder9mz23BhSW1BeyTWa90L2oYp
         f/diTOn1eqAvGdhEf7dIrnfF9fbmmeZPsisQEv29rCWIjVFOLEKAA5ymoOEk63+bmIyV
         1Wl08CvTRAMDsXfdGfM7iURpa11EYiPyjuzJEUMNxeQ23X2dFUaXHrNWA3oAZHDjJT/q
         nKfg==
X-Gm-Message-State: AOAM532evXlloAh8DcxhxUycy87AtGt9Hl3PKaPsNcb6BSUtTgIIJKWk
        mTAU0V1m3Usnrxim7McZG+gyGA==
X-Google-Smtp-Source: ABdhPJwoBLzE+BHLtG8W7JqZE91lDHflYD3FKPyPuELUwAh/AWckFXIPV8uSutR7CuPTlpJAWhGmJw==
X-Received: by 2002:a17:907:3d8e:b0:6f3:e16c:2549 with SMTP id he14-20020a1709073d8e00b006f3e16c2549mr2741804ejc.109.1651147680223;
        Thu, 28 Apr 2022 05:08:00 -0700 (PDT)
Received: from [192.168.0.163] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906700a00b006efdb748e8dsm8274074ejj.88.2022.04.28.05.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 05:07:59 -0700 (PDT)
Message-ID: <6bd8eb4e-81eb-7e87-155b-f48b487e16ae@linaro.org>
Date:   Thu, 28 Apr 2022 14:07:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 6/7] dt-bindings: pci/qcom,pcie: support additional MSI
 interrupts
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220428115934.3414641-1-dmitry.baryshkov@linaro.org>
 <20220428115934.3414641-7-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220428115934.3414641-7-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/04/2022 13:59, Dmitry Baryshkov wrote:
> On Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Document mapping of additional interrupts.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 51 ++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 0b69b12b849e..a8f99bca389e 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -43,11 +43,20 @@ properties:
>      maxItems: 5
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 8
>  
>    interrupt-names:
> +    minItems: 1
>      items:
>        - const: msi
> +      - const: msi2
> +      - const: msi3
> +      - const: msi4
> +      - const: msi5
> +      - const: msi6
> +      - const: msi7
> +      - const: msi8
>  
>    # Common definitions for clocks, clock-names and reset.
>    # Platform constraints are described later.
> @@ -623,6 +632,46 @@ allOf:
>          - resets
>          - reset-names
>  
> +    # On newer chipsets support either 1 or 8 msi interrupts
> +    # On older chipsets it's always 1 msi interrupt
> +  - if:
> +      properties:
> +        compatibles:
> +          contains:
> +            enum:
> +              - qcom,pcie-msm8996
> +              - qcom,pcie-sc7280
> +              - qcom,pcie-sc8180x
> +              - qcom,pcie-sdm845
> +              - qcom,pcie-sm8150
> +              - qcom,pcie-sm8250
> +              - qcom,pcie-sm8450-pcie0
> +              - qcom,pcie-sm8450-pcie1
> +    then:
> +      oneOf:
> +        - properties:
> +            interrupts:
> +              minItems: 1

minItems should not be needed here and in places below, because it is
equal to maxItems.

> +              maxItems: 1
> +            interrupt-names:
> +              minItems: 1
> +              maxItems: 1
> +        - properties:
> +            interrupts:
> +              minItems: 8
> +              maxItems: 8
> +            interrupt-names:
> +              minItems: 8
> +              maxItems: 8
> +    else:
> +      properties:
> +        interrupts:
> +          minItems: 1
> +          maxItems: 1
> +        interrupt-names:
> +          minItems: 1
> +          maxItems: 1
> +
>  unevaluatedProperties: false
>  
>  examples:


Best regards,
Krzysztof
