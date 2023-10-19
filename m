Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567727CF950
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 14:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345688AbjJSMs0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 08:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345472AbjJSMsZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 08:48:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC5211B
        for <linux-pci@vger.kernel.org>; Thu, 19 Oct 2023 05:48:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so456655f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Oct 2023 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697719701; x=1698324501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qFQDquaYrxbOhnZ4aFn7nGgZNpCtXxCsyNZ4tebC/bw=;
        b=rXVceXsF4zOdZv6GwsAskDLofgzX3cXaF8Vk4zVTCpLIN8ZWXMJH8gSPcqe5yunAHg
         2jsS/QSZBDKLuiwpS32GMMtdRN9/Y969qy0QWtyPFjPNfhbP+Yb6NSdKcfh2R0fYh2rS
         tHocg+MDVsXMAAHz/+oIB7RrdHsx2DikpepTDfvAFmfducGgn4ehyjDr3KmZ//LOyMvK
         JiRT67BgtoXcC9bzc1W0Xb2OmCUgkXI4q31ljK1vMq7aYvRsPfvOEoURp00iqRPhOjuc
         HJw/eFd5tu+aQbSF5O+ecSyiL8yXolw1aZDubdG0LOa+ap4MFjn430/8n/EItvEsyE30
         ZKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697719701; x=1698324501;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFQDquaYrxbOhnZ4aFn7nGgZNpCtXxCsyNZ4tebC/bw=;
        b=W0wcsXEqfEVIGIhkOgDAZilCUlQOG0LQyK6RcavmxqsNHe24AgX3n+XO7nAKpwvxJr
         3wwFMydwb7pU6LU05FRhjN1qAmanwXSqF0RO9TcSbyzZQk8NWzPMqw+FenFE6L9GIVDt
         bahgZE0d1SQekXBnA6Ea4TmQ3jSwLMBO6rxydAGSplDA+3Lf91mhXrgyJ3N2XZlCjfyk
         BFTPXUsUZPfdPOfSJL/93CVrHsHDR++NF8yKr2AkJpwN4BBtB4kNe3d9wKDdv6x1xs00
         +Eeaa90cFSpG85+b1pAqJWB+X+d3krVKKZqXhcG7c4egxbTqdSGNlwb58+jqBrp2Ml5/
         OK7A==
X-Gm-Message-State: AOJu0YxyZTDSNhSMOv+crz1tzhrva3+s6nGMD+X0h4B1YYO3sj4D9lmR
        nnOXlxIGHnIzYHnUKUZh0MCdpw==
X-Google-Smtp-Source: AGHT+IFIlFfsK60mBGVm1Umc72MF15R9tIcGFrq3luoIFWuxu+G5Q4MXudqqKlcV9P4gLpkIT/4meQ==
X-Received: by 2002:adf:c685:0:b0:32d:c850:b4ba with SMTP id j5-20020adfc685000000b0032dc850b4bamr1570646wrg.31.1697719701354;
        Thu, 19 Oct 2023 05:48:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id l10-20020a1c790a000000b004063cced50bsm4304072wme.23.2023.10.19.05.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 05:48:20 -0700 (PDT)
Message-ID: <1917c764-9356-4f6e-94d6-1c8a92f4d6a5@linaro.org>
Date:   Thu, 19 Oct 2023 14:48:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: PCI: qcom-ep: Add support for SA8775P
 SoC
Content-Language: en-US
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
References: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
 <1697715430-30820-2-git-send-email-quic_msarkar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1697715430-30820-2-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/10/2023 13:37, Mrinmay Sarkar wrote:
> Add devicetree bindings support for SA8775P SoC. It has DMA register
> space and dma interrupt to support HDMA.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 44 +++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index a223ce0..7485248 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -13,6 +13,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - qcom,sa8775p-pcie-ep
>            - qcom,sdx55-pcie-ep
>            - qcom,sm8450-pcie-ep
>        - items:
> @@ -20,6 +21,7 @@ properties:
>            - const: qcom,sdx55-pcie-ep
>  
>    reg:
> +    minItems: 6
>      items:
>        - description: Qualcomm-specific PARF configuration registers
>        - description: DesignWare PCIe registers
> @@ -27,8 +29,10 @@ properties:
>        - description: Address Translation Unit (ATU) registers
>        - description: Memory region used to map remote RC address space
>        - description: BAR memory region
> +      - description: DMA register space

You need to constrain IO space in all other variants.

>  
>    reg-names:
> +    minItems: 6
>      items:
>        - const: parf
>        - const: dbi
> @@ -36,13 +40,14 @@ properties:
>        - const: atu
>        - const: addr_space
>        - const: mmio
> +      - const: dma
>  
>    clocks:
> -    minItems: 7
> +    minItems: 5
>      maxItems: 8
>  
>    clock-names:
> -    minItems: 7
> +    minItems: 5
>      maxItems: 8
>  
>    qcom,perst-regs:
> @@ -57,14 +62,18 @@ properties:
>            - description: Perst separation enable offset
>  
>    interrupts:
> +    minItems: 2
>      items:
>        - description: PCIe Global interrupt
>        - description: PCIe Doorbell interrupt
> +      - description: DMA interrupt
>  
>    interrupt-names:
> +    minItems: 2
>      items:
>        - const: global
>        - const: doorbell
> +      - const: dma

You need to constrain interrupts in all other variants.

>  
>    reset-gpios:
>      description: GPIO used as PERST# input signal
> @@ -173,6 +182,37 @@ allOf:
>              - const: ddrss_sf_tbu
>              - const: aggre_noc_axi
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sa8775p-pcie-ep
> +    then:
> +      properties:
> +        reg:
> +          minItems: 7

As well:
maxItems: 7
Otherwise any future update will for sure miss this and relax the reg.

> +        reg-names:
> +          minItems: 7

Ditto

> +        clocks:
> +          items:
> +            - description: PCIe Auxiliary clock
> +            - description: PCIe CFG AHB clock
> +            - description: PCIe Master AXI clock
> +            - description: PCIe Slave AXI clock
> +            - description: PCIe Slave Q2A AXI clock
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg
> +            - const: bus_master
> +            - const: bus_slave
> +            - const: slave_q2a
> +        interrupts:
> +          minItems: 3

Ditto

> +        interrupt-names:
> +          minItems: 3

Ditto

> +
>  unevaluatedProperties: false
>  
>  examples:

Best regards,
Krzysztof

