Return-Path: <linux-pci+bounces-1051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574228143A8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 09:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC20E1F21C68
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 08:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FDE12E65;
	Fri, 15 Dec 2023 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXhuCC7m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E94431
	for <linux-pci@vger.kernel.org>; Fri, 15 Dec 2023 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so42983966b.1
        for <linux-pci@vger.kernel.org>; Fri, 15 Dec 2023 00:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702629068; x=1703233868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/VHrDXjE8ArwAdQn1IvokNpm8/NuKC38VUGI1HTeeM=;
        b=cXhuCC7mgcBtEQS98n/+ueLLISANGxryEkq2qFYaTvj82k92tSaEpQ3R5kCCpOcekc
         p+9csETM+0JqiOCey9XNrSTm5StnMEU8jvBKzgNPquFnyO4bh0dc3eCoWu49kXrcmsbC
         jxirwOJaZ/Bs1RKjhSyHaB7NTgMQcYOeejF4waBO9ooMrGfSSFJdQF6bYbvuJfzNKFQ1
         w8uRqHeHD98aT3S2KSqX8SSz3r+Z0kKGj+MQVW8MmCZD8DnjZ8cIBec1Maa04Kz4rm8m
         hLzFmqqGOr1veC7PKNaYw1Qb1CNfLQ1+C0Mn93E5YzZ05FbTc2LGJF/cCX5KAR897UKD
         sd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702629068; x=1703233868;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/VHrDXjE8ArwAdQn1IvokNpm8/NuKC38VUGI1HTeeM=;
        b=R6NTUBeK7trCoo482iTf6/qbUd5biPzhTTIh1lpGaql/LJxHy3yy7ZMstg29K1zP9r
         tURJKaEAQz9ZI782nQ2eOpGPms7uOWsqGxXD+p7tXJZWOl4io0sXkOyV6K5sf9XL3fLd
         4fUFJ0xA8s7L8/x7c/jLEmq+ETyYOd5FaGzJMqqPrsuXrWaz0PxsUSckM00DUdQinycs
         6ZJ/BceiW1gW2Zd8uebc/s5zeB51iBaUkj6WAr7ZAk+SI4rcMWQw600czvVt+6Jphjk1
         svPgsPcnnmtvqj5/gBKRtKaOYjgVsqyMRXQVXz5Xfl+L5jvE3VOASQ6xTAjDd3VE4OAB
         rhqg==
X-Gm-Message-State: AOJu0Yw57pKDRpi0/a8fa8UiTlr/xk0PECz9uefP0LSBiTlvXgozdeoY
	0zVFfXbYhb2wBVTiihpW1eIiBg==
X-Google-Smtp-Source: AGHT+IFxogtkGNkNyekbXZYz+76lK+ayuc9eput/RFVQ4EizYhc44pFmoxfBr9gfbbOjeTExBzlt7w==
X-Received: by 2002:a17:906:1084:b0:a22:faec:7d2e with SMTP id u4-20020a170906108400b00a22faec7d2emr1844688eju.113.1702629068426;
        Fri, 15 Dec 2023 00:31:08 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id bn2-20020a170906c0c200b00a23152a543dsm997827ejb.202.2023.12.15.00.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 00:31:08 -0800 (PST)
Message-ID: <c685ca4e-3992-4deb-adfb-da3bbcb59685@linaro.org>
Date: Fri, 15 Dec 2023 09:31:04 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] dt-bindings: phy: qcom,uniphy-pcie: Add ipq5332
 bindings
Content-Language: en-US
To: Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com,
 sboyd@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
 kw@linux.com, vkoul@kernel.org, kishon@kernel.org, mani@kernel.org,
 quic_nsekar@quicinc.com, quic_srichara@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Cc: quic_varada@quicinc.com, quic_devipriy@quicinc.com,
 quic_kathirav@quicinc.com, quic_anusha@quicinc.com
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
 <20231214062847.2215542-6-quic_ipkumar@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231214062847.2215542-6-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/12/2023 07:28, Praveenkumar I wrote:
> Qualcomm IPQ5332 has single-lane and dual-lane PCIe UNIPHY
> with Gen 3 support. This UNIPHY is similar to the one found
> on Qualcomm IPQ5018. Hence add the bindings in qcom,uniphy-pcie.
> 
> Clocks and resets are different for IPQ5332. Update the
> bindings to support both IPQ5018 and IPQ5332.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
> This patch depends on the below series which adds PCIe support in
> Qualcomm IPQ5018
> https://lore.kernel.org/all/20231003120846.28626-1-quic_nsekar@quicinc.com/
> 
>  .../bindings/phy/qcom,uniphy-pcie-28lp.yaml   | 65 +++++++++++++++++--
>  1 file changed, 58 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml
> index 6b2574f9532e..205eaec2291e 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml
> @@ -20,19 +20,20 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 4
>  
>    clock-names:
> -    items:
> -      - const: pipe_clk
> +    minItems: 1
> +    maxItems: 4
>  
>    resets:
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 3
>  
>    reset-names:
> -    items:
> -      - const: phy
> -      - const: phy_phy
> +    minItems: 2
> +    maxItems: 3
>  
>    "#phy-cells":
>      const: 0
> @@ -54,6 +55,56 @@ required:
>    - "#clock-cells"
>    - clock-output-names
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq5018-uniphy-pcie-gen2x1
> +              - qcom,ipq5018-uniphy-pcie-gen2x2
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1

Drop

> +          maxItems: 1
> +        clock-names:
> +          items:
> +            - const: pipe_clk
> +        resets:
> +          minItems: 2

Drop

> +          maxItems: 2
> +        reset-name:

Typo

> +          items:
> +            - const: phy
> +            - const: phy_phy
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq5332-uniphy-pcie-gen3x1
> +              - qcom,ipq5332-uniphy-pcie-gen3x2

There are no such compatibles.

> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +          maxItems: 4
> +        clock-names:
> +          items:
> +            - const: pipe
> +            - const: lane_m
> +            - const: lane_s
> +            - const: phy_ahb
> +        resets:
> +          minItems: 2
> +          maxItems: 2

So where are three items?


> +        reset-name:

Typo

This patch is so confusing, it looks like it does not make any sense.

Best regards,
Krzysztof


