Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823EE62BED4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 14:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiKPNDA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 08:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiKPNC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 08:02:59 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD42AE52
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 05:02:57 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a29so29369325lfj.9
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 05:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nFImyqcjOCw0VPGt4sM3tOy2kTrCbLPrbHyGVMhwtU=;
        b=IElGtUKfWsETwq7XYWaSaFYsjCaNOE6bA7mNckgqHVfZvqPotujU9CCPPMMCyEO6L3
         3yaoOGxAAMXPg15J44rMU9G3wCInMNhvs68nBoaEvSmuAuvlyedSuqOfYYqM64dYLyZJ
         NWeeYz/MeTYj7EpYnBfqosVV/kajQ3xmBnLJNTphmlDgDw+5oMxzIaMPRxoB0R6b2MUC
         xI6OirpvcBQCrSDYBeDgnXQVIdJaI3b48wykYi+16A4Ii4+Rt2TBiW4Ah7LLM/mVbM34
         79dTUx4oyOS0oA+KQLtWiorNnHQ4vbXwgu+OR2pMfMIbcudxl+KRkuLcpSVlevIHwXIU
         l7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nFImyqcjOCw0VPGt4sM3tOy2kTrCbLPrbHyGVMhwtU=;
        b=crdNzTHJK2pyqrNtScMdfJaJ5W7Xh0ehCCOamWZZMfj2fO7JTDZv1AGkCS/z9ECebb
         Hv3U9dP8YU4Bmv9yfi7eXGh8OKfNeOlQww42n0pS60xJo6iV+MVwFp24sUDO/lRBFuRh
         wTuK6G5ncWU9o8Aw3VJiygpS9M5MFYgz/UNNuQlj4G0BSBbD76pxeGAT+otfCmgSRavT
         49hYYr1HXduODBN1ngYQfkAtRnbEYjDgW0kBnfvLSKYI5+CrDf2c7eJIax111eNMU/Xp
         GKvSGeCw/Mc2O/xPi/FK8QVW77LbaBaT2fl5vUEE5v0Ka6tfR8lPpAkZ66ehjS7wf8gr
         CEKw==
X-Gm-Message-State: ANoB5pmn+BBHteupEqA3K137wi6UUxVV+Q+vKt74p2biBGUqKDs+eK6b
        eZU6B6pXUM140bI9qv3Fna3Xdg==
X-Google-Smtp-Source: AA0mqf6L57yaZbDI7JLgcUwp7oyX1I57dd8iaDteJ1PsHvhCaFEWWDBvj2/9TxT13FHctPmfH8JcSw==
X-Received: by 2002:a05:6512:1398:b0:4b1:df29:b9ee with SMTP id p24-20020a056512139800b004b1df29b9eemr7695595lfa.160.1668603775702;
        Wed, 16 Nov 2022 05:02:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f16-20020a05651c02d000b0027708c94c9bsm2976409ljo.79.2022.11.16.05.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:02:55 -0800 (PST)
Message-ID: <79d783a0-b9cc-9093-6f76-0d50b9b81247@linaro.org>
Date:   Wed, 16 Nov 2022 14:02:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom: Add SM8550 to binding
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kw@linux.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20221116123505.2760397-1-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116123505.2760397-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/11/2022 13:35, Abel Vesa wrote:
> Add the SM8550 platform to the binding.

Subject: Drop redundant, second "binding"

> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 54f07852d279..efa01a8411c4 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -34,6 +34,8 @@ properties:
>        - qcom,pcie-sm8250
>        - qcom,pcie-sm8450-pcie0
>        - qcom,pcie-sm8450-pcie1
> +      - qcom,pcie-sm8550-pcie0
> +      - qcom,pcie-sm8550-pcie1

I am not sure what's the benefit of encoding arbitrary IDs to compatible
just to differentiate by clocks. The devices are basically the same, so
compatible should be the same.

>        - qcom,pcie-ipq6018
>  
>    reg:
> @@ -92,6 +94,10 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  enable-gpios:
> +    description: GPIO controlled connection to ENABLE# signal
> +    maxItems: 1

Does not look like used property...

> +
>    perst-gpios:
>      description: GPIO controlled connection to PERST# signal
>      maxItems: 1
> @@ -187,6 +193,8 @@ allOf:
>                - qcom,pcie-sm8250
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
> +              - qcom,pcie-sm8550-pcie0
> +              - qcom,pcie-sm8550-pcie1
>      then:
>        properties:
>          reg:
> @@ -601,6 +609,92 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sm8550-pcie0
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 11
> +          maxItems: 11
> +        clock-names:
> +          items:
> +            - const: pipe # PIPE clock
> +            - const: pipe_mux # PIPE MUX
> +            - const: phy_pipe # PIPE output clock
> +            - const: ref # REFERENCE clock
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: aggre0 # Aggre NoC PCIe0 AXI clock
> +        interconnects:
> +          maxItems: 1
> +        interconnect-names:
> +          const: icc_path

Keep existing pattern of allOf:if:then or change entire file to a
different style.

Best regards,
Krzysztof

