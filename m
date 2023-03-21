Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD526C3B0D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCUTyn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjCUTyj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:54:39 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3E21B303;
        Tue, 21 Mar 2023 12:54:34 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id bm2so3129309oib.4;
        Tue, 21 Mar 2023 12:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679428474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzGK/1K3jXeb2RXo8eG0lU4LCzC1yzSP/KWzYe+eVbw=;
        b=ampEM2Qqk1H70egvD3eBZLcrBlFXjpLe550jasdSe+QWVnFdeNtCiqLBJIz/zx7BWx
         2CzQS3JqL1YWryGObLYzuKlpjMTvMyw88VdiYMVCZqpVoYda+321SxO80HceSZdh4QV3
         uHWft12Q8bOwSjCvh+J6lGejWe9UAvLrZEedQqqTNGsp3frw2cqsWnTcu+I0R2rFWOXp
         aA1JpRY/aVcfNn3rfx1zUy+LMr4CcDPg1oRNnCpuMclNODMQEx01fwWd0zBmkIuSUJPl
         CusJXiR7ViMEJ+x9bD8h5mPb0fC47zidv03z7gm+qmmYnBg+lo6OcjA5AIAgzajyizTy
         D7yw==
X-Gm-Message-State: AO0yUKUxvrS9TUkL82xo77MoIULLRvfYRic8hMRD7HPqDKYIeXgom8Cb
        QYLE5TXJTJHdYG/E28n+4w==
X-Google-Smtp-Source: AK7set+KMmtZUupNTDW8y48dmb0Nsic39+Iea4GTnkiEhCiarvZbLd4wCMKv+ZkisvmMY1Q1UFvy2Q==
X-Received: by 2002:a05:6808:19a:b0:383:fb18:aa7d with SMTP id w26-20020a056808019a00b00383fb18aa7dmr156495oic.35.1679428470893;
        Tue, 21 Mar 2023 12:54:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q132-20020acac08a000000b0037fa035f4f3sm5161798oif.53.2023.03.21.12.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:54:30 -0700 (PDT)
Received: (nullmailer pid 1344021 invoked by uid 1000);
        Tue, 21 Mar 2023 19:54:29 -0000
Date:   Tue, 21 Mar 2023 14:54:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [RESEND PATCH v9 1/2] dt-bindings: PCI: qcom: Add SM8550
 compatible
Message-ID: <20230321195429.GA1341884-robh@kernel.org>
References: <20230320144658.1794991-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320144658.1794991-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 20, 2023 at 04:46:57PM +0200, Abel Vesa wrote:
> Add the SM8550 platform to the binding.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> This patch is a resend of the following:
> https://lore.kernel.org/all/20230208180020.2761766-10-abel.vesa@linaro.org/
> 
> No changes since then.
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index fb32c43dd12d..be7b4b805291 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -38,6 +38,7 @@ properties:
>            - qcom,pcie-sm8350
>            - qcom,pcie-sm8450-pcie0
>            - qcom,pcie-sm8450-pcie1
> +          - qcom,pcie-sm8550
>        - items:
>            - const: qcom,pcie-msm8998
>            - const: qcom,pcie-msm8996
> @@ -58,6 +59,12 @@ properties:
>      minItems: 1
>      maxItems: 8
>  
> +  iommus:
> +    maxItems: 1
> +
> +  iommu-map:
> +    maxItems: 2

I think this will conflict with a series from Mani. 'iommus' use is also 
wrong here.

> +
>    # Common definitions for clocks, clock-names and reset.
>    # Platform constraints are described later.
>    clocks:
> @@ -205,6 +212,7 @@ allOf:
>                - qcom,pcie-sm8350
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
> +              - qcom,pcie-sm8550
>      then:
>        properties:
>          reg:
> @@ -639,6 +647,37 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sm8550
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 7
> +          maxItems: 8
> +        clock-names:
> +          minItems: 7
> +          items:
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: noc_aggr # Aggre NoC PCIe AXI clock
> +            - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
> +        resets:
> +          minItems: 1
> +          maxItems: 2
> +        reset-names:
> +          minItems: 1
> +          items:
> +            - const: pci # PCIe core reset
> +            - const: link_down # PCIe link down reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -724,6 +763,7 @@ allOf:
>                - qcom,pcie-sm8350
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
> +              - qcom,pcie-sm8550
>      then:
>        oneOf:
>          - properties:
> -- 
> 2.34.1
> 
