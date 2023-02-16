Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F328699131
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjBPK3f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjBPK3c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:29:32 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2110B4DE0C
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:29:30 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id 10so3249243ejc.10
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9siJVZPOFvTKH6qbA3a38sGnlXPDe1LlTNA0o2LihA=;
        b=AOvDsJeMQqZAscWrOwd++yaSB5pWNZLC1DGXNJLb/EmImWJhlUMZh/QkrYMOlg3y/I
         oEXtb+SGVQnabDf8ii3/Tn7mSwJ3zPd0kR1SLHubef7tJuVLg0e3tcxfaY0JiQ4Ipy3H
         uakQnIYX1URDOmbeigKL/+zcyZYnovZNVdeMUVr2oMBRDjuwEqSHOoAdUr1EkIEdTK0C
         kJ7N3abgfqkV/8QjHokp1cHgPeOE2uRrEB5DcrmKkZ6kFO1zmpLU74ch+PrPiBXh8PlH
         qqMHG7SNU0S+sHMEfAmRlKVYLVk0wZsqWSDDGxaRgfcAD4Hz/k1coir4sAMlAOX0atXN
         Ry0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9siJVZPOFvTKH6qbA3a38sGnlXPDe1LlTNA0o2LihA=;
        b=qKfSNTYyMXACebqcmdZDiPQlMD64Op6BJatny6YNr+AVvr54CO3qie4VXjm2Msf9Of
         2DAq5M27qjr/YaAGsRY9SP6m9G5XH4fJXkM96SygXJ4W926f66rbu3JxD1Hg1RXev1Qo
         AvSdNt6eYhTiZjgzWhWl2CuwPv4ye6MNVhxrkzqfqOMkkCCZ/dkit5lzRW+ehCEnwZl1
         HDJFMvsZT2Ga13/93TNKwb5T/hQcFHyvADMGdjLG4FEaB0+CLNPZdrt0EHsoLdzSPOm1
         pUk9jKoS4EF4dqHo/Hqm/nBL4O78QL3a+03Ur8zvi+LtxMwOGMzMyBc+uNo6mAJk0HrZ
         UUCA==
X-Gm-Message-State: AO0yUKXrk9NguWGBE9vYsGPqEbx5nZY60e1SDH2DyJsDobYj7T5yXtgL
        Id3D1it4fphldHqD5VIxmSfDVg==
X-Google-Smtp-Source: AK7set8Py/urVAnDtSVqOAA45n+CZn4wecDP3p27sIw8OB/YpmZIlVwbIdd7aUzHO+JP4miZ6M97dQ==
X-Received: by 2002:a17:906:9f25:b0:8b1:2eef:154c with SMTP id fy37-20020a1709069f2500b008b12eef154cmr1592559ejc.0.1676543368620;
        Thu, 16 Feb 2023 02:29:28 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id lf18-20020a170906ae5200b008af2b5cc1a2sm630463ejb.69.2023.02.16.02.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:29:28 -0800 (PST)
Message-ID: <f883e857-1281-ceae-74ac-72a1f07d6413@linaro.org>
Date:   Thu, 16 Feb 2023 11:29:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/7] dt-bindings: PCI: qcom: Add IPQ9574 specific
 compatible
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, mani@kernel.org, p.zabel@pengutronix.de,
        svarbanov@mm-sol.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-2-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214164135.17039-2-quic_devipriy@quicinc.com>
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

On 14/02/2023 17:41, Devi Priya wrote:
> Document the compatible for IPQ9574
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 72 ++++++++++++++++++-
>  1 file changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 872817d6d2bd..dabdf2684e2d 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -26,6 +26,7 @@ properties:
>            - qcom,pcie-ipq8064-v2
>            - qcom,pcie-ipq8074
>            - qcom,pcie-ipq8074-gen3
> +          - qcom,pcie-ipq9574
>            - qcom,pcie-msm8996
>            - qcom,pcie-qcs404
>            - qcom,pcie-sa8540p
> @@ -44,11 +45,11 @@ properties:
>  
>    reg:
>      minItems: 4
> -    maxItems: 5
> +    maxItems: 6
>  
>    reg-names:
>      minItems: 4
> -    maxItems: 5
> +    maxItems: 6
>  
>    interrupts:
>      minItems: 1
> @@ -105,6 +106,8 @@ properties:
>      items:
>        - const: pciephy
>  
> +  msi-parent: true
> +
>    power-domains:
>      maxItems: 1
>  
> @@ -173,6 +176,27 @@ allOf:
>              - const: parf # Qualcomm specific registers
>              - const: config # PCIe configuration space
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-ipq9574
> +    then:
> +      properties:
> +        reg:
> +          minItems: 5
> +          maxItems: 6
> +        reg-names:
> +          minItems: 5
> +          items:
> +            - const: dbi # DesignWare PCIe registers
> +            - const: elbi # External local bus interface registers
> +            - const: atu # ATU address space
> +            - const: parf # Qualcomm specific registers
> +            - const: config # PCIe configuration space
> +            - const: aggr_noc #PCIe aggr_noc

Why last one is optional? I would assume device either has it or has not.


Best regards,
Krzysztof

