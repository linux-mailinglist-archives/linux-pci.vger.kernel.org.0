Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B12D57C6F4
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 10:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiGUIzl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 04:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiGUIzi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 04:55:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74292F3AA
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 01:55:36 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id e11so1034044ljl.4
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4GeLyV51uYj8j4S4aBve635E01r+lvLx2pbTjxK4lWY=;
        b=r7/Jn5fBFKJaOhtb44Dkjir5D0my9GI5ryjs+mFVridMBGrA31diU16QC2UbpL167X
         eWcY8H3uvQu/abRABlzE4W9nzhLybMEhXsBOdE58UnvdATo2x6OEIbQqKhZdpU3IPFRs
         OuFHTLK8S75Bpltb/aEvT2UawF69arCPTyn/s7/V7R2GFzZEHjUXqM1Lj6ZVHtKihRFk
         L6sMUxXH+LKkm7F5trbtBIN0gM93PTfJSox5aFPGm5Igsp6ejwaOqGtyDZL+eaFLO406
         pFblBNMt5JH4n1C5KILz8CDIoS9kmWbFwlGYo0UEgw77xnYXHEGzBawWEW4cymTG2oO0
         GEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4GeLyV51uYj8j4S4aBve635E01r+lvLx2pbTjxK4lWY=;
        b=4QjhNiMkLQRASs5fPauA7r4u6W2ynfaoW/7H7rgvhLuwn16GBakcGxOjMl4XzeXaIN
         EQ46f/ppXgurCwbrNJ+3Ydnb0RJnJAyskWQUGAFZtYQCrntuSZmxdh5fplrfS8wsO0K0
         lHUyj80toaRgDvw8kv26YkNZW8FU/MXzoZK76T3Ar0Qh06Ri4+8SLrrAoZwg6WX7D5f0
         nI5wBaas+/gIA4ZHQlRcmhAPquijdWOBDs1FzxAEADldLLEBd0r/Z7PB12TA+uGXnPym
         YCqhebGMzVYuvrLKT9QguhwYQLKojJWTAehad7p5g8L01iyNpa8XIWTwEXAobXXGMMEs
         70pA==
X-Gm-Message-State: AJIora/Ft2F4R2Z/Cr+MzZOSrnC9AqzjHBSLTcm+GfpNCfdDv/ptT1E1
        GtxRZyHbxB+6xDOlVpEYg65bFg==
X-Google-Smtp-Source: AGRyM1t+1EDHj6uDmmwBE6CgTZopBYct95p34fYs4E202hjjQ4LPh6wl3Vozu3ATNCFfiaswEwGWyw==
X-Received: by 2002:a2e:8852:0:b0:25d:4ab5:593b with SMTP id z18-20020a2e8852000000b0025d4ab5593bmr17501577ljj.261.1658393735136;
        Thu, 21 Jul 2022 01:55:35 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id bp25-20020a056512159900b0047f76a935a5sm308444lfb.137.2022.07.21.01.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 01:55:33 -0700 (PDT)
Message-ID: <19ccf775-cc1d-37de-bf4e-7745f0943851@linaro.org>
Date:   Thu, 21 Jul 2022 10:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/5] dt-bindings: pci: Add ARTPEC-8 PCIe controller
Content-Language: en-US
To:     wangseok.lee@samsung.com,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>
Cc:     Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
References: <20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p5>
 <CGME20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p6>
 <20220720055436epcms2p63896ebe4e2131e3844044d0112288570@epcms2p6>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720055436epcms2p63896ebe4e2131e3844044d0112288570@epcms2p6>
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

On 20/07/2022 07:54, Wangseok Lee wrote:
> Add description to support Axis, ARTPEC-8 SoC. ARTPEC-8 is the SoC platform
> of Axis Communications and PCIe controller is designed based on Design-Ware
> PCIe controller.
> 
> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> ---
> v3->v4 :
> -Add missing properties
> 
> v2->v3 :
> -Modify version history to fit the linux commit rule
> -Remove 'Device Tree Bindings' on title
> -Remove clock-names entries
> -Change node name to soc from artpec8 on excamples

Please rebase on newest Linux kernel or linux-next and use
get_maintainers.pl script.

> 
> v1->v2 :
> -'make dt_binding_check' result improvement
> -Add the missing property list
> -Align the indentation of continued lines/entries
> ---
>  .../bindings/pci/axis,artpec8-pcie-ep.yaml         | 138 +++++++++++++++++++
>  .../devicetree/bindings/pci/axis,artpec8-pcie.yaml | 148 +++++++++++++++++++++
>  2 files changed, 286 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
> new file mode 100644
> index 0000000..435e86f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/axis,artpec8-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARTPEC-8 SoC PCIe Controller
> +
> +maintainers:
> +  - Jesper Nilsson <jesper.nilsson@axis.com>
> +
> +description: |+
> +  This PCIe end-point controller is based on the Synopsys DesignWare PCIe IP
> +  and thus inherits all the common properties defined in snps,dw-pcie-ep.yaml.
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> +
> +properties:
> +  compatible:
> +    const: axis,artpec8-pcie-ep
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers.
> +      - description: Data Bus Interface (DBI2) registers.
> +      - description: PCIe address space region.
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: addr_space
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PIPE clock, used by the controller to clock the PIPE
> +      - description: PCIe dbi clock, ungated version
> +      - description: PCIe master clock, ungated version
> +      - description: PCIe slave clock, ungated version
> +
> +  clock-names:
> +    items:
> +      - const: pipe
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +
> +  samsung,fsys-sysreg:
> +    description:
> +      Phandle to system register of fsys block.
> +    $ref: /schemas/types.yaml#/definitions/phandle

Since you wrote this is one register, I expect offset:
https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml#L42


> +
> +  samsung,syscon-phandle:
> +    description:
> +      Phandle to the PMU system controller node.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  samsung,fsys-bus-s:
> +    description:
> +      Phandle to bus-s of fsys block, this register
> +      is additional control sysreg in fsys block and
> +      this is used for pcie slave control setting.
> +    $ref: /schemas/types.yaml#/definitions/phandle

Ditto

> +
> +  samsung,fsys-bus-p:
> +    description:
> +      Phandle to bus-p of fsys block, this register
> +      is additional control sysreg in fsys block and
> +      this is used for pcie dbi control setting.
> +    $ref: /schemas/types.yaml#/definitions/phandle

Ditto

> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    items:
> +      - const: pcie_phy
> +
> +  num-lanes:
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - samsung,fsys-sysreg
> +  - samsung,syscon-phandle
> +  - samsung,syscon-bus-s-fsys

This does not match what you wrote in properties.

Best regards,
Krzysztof
