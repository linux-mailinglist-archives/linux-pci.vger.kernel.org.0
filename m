Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E282755CC9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 09:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjGQHZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 03:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjGQHZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 03:25:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB81188
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2023 00:25:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99313a34b2dso504372766b.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2023 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689578718; x=1692170718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qs4HLlO4LlybLe7Ah8QKFBkS3q2XJN402rj3Q8OPMEk=;
        b=xfIJggQILuXOIT+qRFvFEx7EeufNsrNzYjtck6y8JtPZ33lKP1JAe6KxnjHPBNRMhR
         XQmYcAQgQaXXavpmqLlpWcgklGnAntEqbxpScnQwFMzlOyfXZLbOWa3qN8GfUAaTtx4O
         bgsWVNRulYggbDsTqq/i3tbpPZroumqSEi8nZmiPPqK9XX0HRX0S6m8puHbJqhF7XkVQ
         n6mA3T/rOamv1a1KNShWgJ5jEuRZJ4BxVd9wQ2Fs2goDUIyN1l8gRv3wFRD7ItBFUjrI
         q0dJD+PvBT9YaeKX/8mU1tyolE70/LypiQRuG/mEas86+T1OApPOybLu0e4drrMYZdpz
         vRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689578718; x=1692170718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs4HLlO4LlybLe7Ah8QKFBkS3q2XJN402rj3Q8OPMEk=;
        b=WopnYodBfYOuGQD8lkp7UKzd04b4HiYkTupLQK8/zZxxBdp4ZnGNw5J51L2P8Jj3Sb
         xLXSKEXOKZ3hCNMnKaX48RPoWw5T/BcaDD7idZEOqdtX85iW/6R1IvqhGJZc5NZWxMdo
         R3/KAs1kSstF7iFPEg93+yDb49iAfd8YwfBC6sFp+r5TkTADG2kj4rjza68vmd6or2yZ
         KOVYppstaKNAqsmZNL0TLJ6mOn+dCRlyIwMUjW7UOZ9S1WSfTma2XgTtlmEKmNJsVv2V
         HsqTcKWLUTzAr2nnWMl+v1X21p3duitCfUoNyPMz7mA7phTKcr2YZ99KbOoadD/JrEQq
         BE1w==
X-Gm-Message-State: ABy/qLaE2d9IlQtTPHGYOnRWxjQB0w9QW/Z9JUlDxKGVGLtLhZE1OYdx
        YK7n/C+TlD22WklVpTelZv+R0Q==
X-Google-Smtp-Source: APBJJlFtMxvLm/eKNB8QByqh/kv+BMVjGXQbcUFa9xlTwZ0reAw5LaF5nWU9p8oXGxISfw4wO7C8Ng==
X-Received: by 2002:a17:907:8f17:b0:98d:d26c:e142 with SMTP id wg23-20020a1709078f1700b0098dd26ce142mr9536118ejc.46.1689578717832;
        Mon, 17 Jul 2023 00:25:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f21-20020a1709064dd500b0098951bb4dc3sm8770472ejw.184.2023.07.17.00.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 00:25:17 -0700 (PDT)
Message-ID: <132e9514-7eb9-8915-6130-5bf656c1aaac@linaro.org>
Date:   Mon, 17 Jul 2023 09:25:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/6] dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe
 PHY
Content-Language: en-US
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <1689311319-22054-1-git-send-email-quic_msarkar@quicinc.com>
 <1689311319-22054-3-git-send-email-quic_msarkar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1689311319-22054-3-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/07/2023 07:08, Mrinmay Sarkar wrote:
> Add devicetree YAML binding for Qualcomm QMP PCIe PHY
> for SA8775p platform.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml      | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index a0407fc..ca55ed9 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -16,6 +16,8 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - qcom,sa8775p-qmp-gen4x2-pcie-phy
> +      - qcom,sa8775p-qmp-gen4x4-pcie-phy
>        - qcom,sc8280xp-qmp-gen3x1-pcie-phy
>        - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>        - qcom,sc8280xp-qmp-gen3x4-pcie-phy
> @@ -30,7 +32,7 @@ properties:
>  
>    clocks:
>      minItems: 5
> -    maxItems: 6
> +    maxItems: 7
>  
>    clock-names:
>      minItems: 5
> @@ -41,6 +43,7 @@ properties:
>        - const: rchng
>        - const: pipe
>        - const: pipediv2
> +      - const: phy_aux
>  
>    power-domains:
>      maxItems: 1
> @@ -141,6 +144,20 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> +              - qcom,sa8775p-qmp-gen4x4-pcie-phy
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 7
> +        clock-names:
> +          minItems: 7
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:

This probably works but is not obvious and easy to read. You have here
if:then:else: block, so else applies to your variant. Change all these
if clauses for clocks into separate clauses per matching variant
(if:then: ... if:then:... if:then:...)

Best regards,
Krzysztof

