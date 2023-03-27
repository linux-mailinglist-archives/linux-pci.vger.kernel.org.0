Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AB06C9CD3
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjC0Hwq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 03:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjC0Hwp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 03:52:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB35102
        for <linux-pci@vger.kernel.org>; Mon, 27 Mar 2023 00:52:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn12so32126253edb.4
        for <linux-pci@vger.kernel.org>; Mon, 27 Mar 2023 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679903562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1nsUKjzCSRJ3QxewfOzpoaDxvCQL60FhzqskMDTvRY=;
        b=mW6Kkklp5WlQxHi+FwA6xvgBZDesfxzza7v/KKjXwrrHY9YdKhXB/l3F9czTiiEz2r
         NTfqu6AdyMuGrKKrs8fkHgXdgOt/VwqGzi5BX+f7CujntDaEgS108SFEGai4VFMJLuNX
         6BZDKIdmOxQsmkyQi2jgY5ZRiLpKeMScj4HoGs2Zbg9thSzGXbPx0szDQ+fzhrODrT42
         Kw2/CiVwx62vbhNbw5LHy3AHMWtGF5PuvjCwK+lq+CaDUb227Pp2XCZIda+E6CmsCu7D
         fb66VS2k9/7Hri9KWG1SsAgRpWV1mJ0Ljtux/VYee5xZQtCGwxk3R9k0KGJgflvyZnfh
         janQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679903562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1nsUKjzCSRJ3QxewfOzpoaDxvCQL60FhzqskMDTvRY=;
        b=sTCXuTybNRu6YJfOna0zP3tXWo+4qGhDx7xB/WsA09GjbOL4keo6rPfhJMSO9qdyU9
         y2PR96oY2CDJDyR/ObNOnYzZRYwAqDpWXu/XGcDwwINL8GH+KHBsuAgN8cbJEr395ixe
         iGAnNxPaCyxlsLkpgkLXoEtNbvVklbb8KRyY9K9HE6QWUzsuQr9MBYTTLZba84qfEsQS
         kcc8wTZyb1ScbcB02SO1w91NHil00mBuMDAAOlfGn4vEzoHFHaBz7+JfctvgmiNCRaj0
         aJoQ4bpzR53poNOhk0pJkJNNyXUUL/s0iycATqKo8W67JtOJ+DbNBeQzRNyE6yQgM55k
         yNmQ==
X-Gm-Message-State: AAQBX9cdjdVMHKctIph1cfrbC0HiN9TKidjAB9wDysUHR2WUiLwLnttl
        lx9i7LPoe46y+EPrZ1PLZyWCZg==
X-Google-Smtp-Source: AKy350bG/xOcJXznhNrcbxb2R9hKOzmD00U7Kklxl1F6u5myMQ0+i27iI8rX0Oq2x156EA5Ivve36w==
X-Received: by 2002:a17:906:948d:b0:8b1:264d:6187 with SMTP id t13-20020a170906948d00b008b1264d6187mr10204061ejx.46.1679903561704;
        Mon, 27 Mar 2023 00:52:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:198e:c1a5:309b:d678? ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709062e8700b00933356c681esm12231674eji.150.2023.03.27.00.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:52:41 -0700 (PDT)
Message-ID: <c03075fa-14d4-513e-3ff0-940452697765@linaro.org>
Date:   Mon, 27 Mar 2023 09:52:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 02/12] dt-bindings: PCI: qcom: Document sc8180x
 properties
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-3-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230325122444.249507-3-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/03/2023 13:24, Vinod Koul wrote:
> sc8180x PCIe clocks and resets are different from the common pcie

There is no "common" part for sc8180x in this binding. sc8180x is
customized.

> binding, this warrants the oneOf clause for the clocks and resets

Your subject and commit suggests you are now adding new customization
for SC8180x, but it is already there! Clocks, interrupts, regs etc.
Therefore the commit msg does not fit the contents of the patch. Instead
say that you fix something or change, because of foo and bar.

Otherwise it looks like some old patch rebased onto new kernel so it
does not match at all.

> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 49 ++++++++++++++++++-
>  1 file changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index fb32c43dd12d..d4f837924e7c 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -459,6 +459,33 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sc8180x
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 8
> +          maxItems: 8
> +        clock-names:
> +          items:
> +            - const: pipe # PIPE clock
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ref # REFERENCE clock
> +            - const: tbu # PCIe TBU clock
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -507,7 +534,6 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - qcom,pcie-sc8180x
>                - qcom,pcie-sm8150
>                - qcom,pcie-sm8250
>      then:
> @@ -675,6 +701,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,pcie-sa8540p
> +              - qcom,pcie-sc8180x
>                - qcom,pcie-sc8280xp
>      then:
>        required:
> @@ -717,7 +744,6 @@ allOf:
>              enum:
>                - qcom,pcie-msm8996
>                - qcom,pcie-sc7280
> -              - qcom,pcie-sc8180x
>                - qcom,pcie-sdm845
>                - qcom,pcie-sm8150
>                - qcom,pcie-sm8250
> @@ -746,6 +772,25 @@ allOf:
>                  - const: msi6
>                  - const: msi7
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sc8180x
> +    then:
> +      oneOf:

It's not oneOf.
> +        - properties:
> +            interrupts:
> +              maxItems: 1
> +            interrupt-names:
> +              items:
> +                - const: msi

Why do you even need this here? It's already there.

> +            iommus:
> +              maxItems: 1
> +            iommu-map:
> +              maxItems: 2

And this looks wrong. Drop.
https://lore.kernel.org/all/20230308082424.140224-3-manivannan.sadhasivam@linaro.org/

> +
>    - if:
>        properties:
>          compatible:

Best regards,
Krzysztof

