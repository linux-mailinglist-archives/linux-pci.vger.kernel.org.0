Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6D27B783D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Oct 2023 08:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjJDG6B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Oct 2023 02:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbjJDG6A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2023 02:58:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99039E
        for <linux-pci@vger.kernel.org>; Tue,  3 Oct 2023 23:57:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99de884ad25so313837766b.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Oct 2023 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696402675; x=1697007475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CF4RDfNCn+9e+cjFufKsFSZHZrUim5RqQgYIMHa5ioI=;
        b=Qb0R4h8tCI4Vnxv7W2d7IbaY1CqGHVIuVfaysp8N2QPt6YDglvqj0b1d0FDFQpIzUN
         0ek7vWPH5nRY0jQewhvBuWGyXcjcrvgsJ6oC321HhJou9PlKB0Nc5N0B4FowM3ZCGuXQ
         J55AXmXzxJSHeHclL8KuXKslmQ8a0fqX5/tvNwsHgJdzG9vh3Pli19tsjDb1otzaycf3
         U0wUB5uGcADGRutwYOp5N8oIdu06zQJJSv9WIChBE3ZPbD0HW73W54s/D3mt7qrSGXFh
         oBSPuhp+lORUumuBd5v9/1Z1E1W6zzufLdiaNIZV80nE3vE942XNRAfjALn9OeF4Zujw
         bF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696402675; x=1697007475;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CF4RDfNCn+9e+cjFufKsFSZHZrUim5RqQgYIMHa5ioI=;
        b=cqVR42HXahm6s36TTJcxYmvH8i6Sqt/ZKB2TsxSq+vwEjp3ETyv8cbMpdiqIYL70Z+
         be2y3/+XAmtQU3XWLVnAnCLmMuWPyJ2g6LFPpakhlza6byUsZ0VUziMelhbDc5BRjQpu
         bu68iMud8xm7YbPB4SUM02Nwfvf5vP0DZu+vrVmiWbGbM9HxuEB3V0UTiWPRTmyRXM4R
         Y0BePOpl2pRFA+++2VTfXV2/WOJLTvzOE3ooHzI3H3Kf/nOW2FCOL0qx+mUzgmiP2EQy
         U3YSqGrsdYh1F76tw5+KXLN0NQmj2d1TgPikrZ5nnp7TNeYiTH1BAVumhlsXrz7Q8VO6
         8F/w==
X-Gm-Message-State: AOJu0YwKPtEMwJHMQFe/PWc2XQRToW7GM22fVCGpkDRAcu6JD45lCYJt
        He2oh8hLv9YGZf3xJlw5nUmJxg==
X-Google-Smtp-Source: AGHT+IGvPWefRX5GARibwaZdS5nMYXVCAuJNaKgUnSAc3Se8Io0NhobmVCEIi+yTOToBHoWkjTTInw==
X-Received: by 2002:a17:906:6a19:b0:9a5:a0c6:9e8e with SMTP id qw25-20020a1709066a1900b009a5a0c69e8emr1576297ejc.31.1696402675070;
        Tue, 03 Oct 2023 23:57:55 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id b25-20020a170906195900b0099cc3c7ace2sm2274362eje.140.2023.10.03.23.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 23:57:54 -0700 (PDT)
Message-ID: <4bc021c1-0198-41a4-aa73-bf0cf0c0420a@linaro.org>
Date:   Wed, 4 Oct 2023 08:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe
 uniphy
Content-Language: en-US
To:     Nitheesh Sekar <quic_nsekar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        mani@kernel.org, p.zabel@pengutronix.de, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, quic_ipkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20231003120846.28626-1-quic_nsekar@quicinc.com>
 <20231003120846.28626-2-quic_nsekar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231003120846.28626-2-quic_nsekar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/10/2023 14:08, Nitheesh Sekar wrote:
> Document the Qualcomm UNIPHY PCIe 28LP present in IPQ5018.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>

Thank you for your patch. There is something to discuss/improve.


> ---
>  .../bindings/phy/qcom,uniphy-pcie-28lp.yaml   | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml
> new file mode 100644
> index 000000000000..6b2574f9532e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,uniphy-pcie-28lp.yaml

Filename should match compatibles and they do not use 28lp.

> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,uniphy-pcie-28lp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm UNIPHY PCIe 28LP PHY driver

Driver as Linux driver? Drop. Describe the hardware instead.

> +
> +maintainers:
> +  - Nitheesh Sekar <quic_nsekar@quicinc.com>
> +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5018-uniphy-pcie-gen2x1
> +      - qcom,ipq5018-uniphy-pcie-gen2x2
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: pipe_clk

Drop _clk... or even drop entire clock-names. Not needed for one entry.

> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +      - const: phy_phy

These are absolutely terrible names. If you have third one, it would be
"phy_phy_phy"? Drop or provide something useful.

> +
> +  "#phy-cells":
> +    const: 0
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1

Best regards,
Krzysztof

