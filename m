Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282B1571745
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 12:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiGLK0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 06:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiGLK0I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 06:26:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0496DADD7C
        for <linux-pci@vger.kernel.org>; Tue, 12 Jul 2022 03:26:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e28so9582194lfj.4
        for <linux-pci@vger.kernel.org>; Tue, 12 Jul 2022 03:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yWy18Lynv1Yzq+NCbZJ0I3w7Y+py7fFlGQHV4YYmBEA=;
        b=YhUrQS7CDO/km6iLR9MKy/Th+0vO3y95kmZmpo9YfWSZCWrtTYqhGUt22TJf0sgNF/
         C+JiOOuBHD21fxx+xrndL2Oi6YlOy+vTCzh4BZ+hEF9CnS0AvbM9RiybI1P5Z6mNJpyC
         mOunPrv+UkIIZ14k9OKlCL0cx21CVlegXaM8bv0AfXrgDNd78ssPwLfSGpbeBp57Pjtc
         mQWG4UQm+xHtL+37DvflFUdlfnDkueQ3S1dHSlfvJ10j/T7f3hANdx6LdvY4iYj2OZLX
         IQ+JQQXwG13HZnxxo5KJ6Fqatq6Qw/fwBQnZMiDG4b47Qa5QpIxFbnK21hnZbv1RgkaP
         /lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yWy18Lynv1Yzq+NCbZJ0I3w7Y+py7fFlGQHV4YYmBEA=;
        b=BO7cZpFx7FIQ8D+ousXR8QHjYYj407N4XNH+aWmRLFNdtiM/s4rddO1TU7/ff+/XTO
         bRUEscNfRZahMhvmWaKfnpZ3GLtFHgSzZJdI+kp/hik3jU21oKObACjuV6MEI7HoN8dr
         EZvM8MqiS/HA9hi/Tqag++0SmBdJWT6r7la9/+HOlY4FFfB6ydAcPBUlZ8gAXNW9A6oe
         67aDidWYygG2dr5egv4eBHbzoS0RmmcfZwA8TMvSRZeJYhFAe1eKNFLpvcyqRPxy8LL0
         HSYlygB4KS7L0UokP6f7aVxZB2KKlJsv7Ke77xn7lvJA7HSQSZx8hvujVB48HKHnMojN
         TFUA==
X-Gm-Message-State: AJIora8Psf/87QPo4h9uBVCmivVDkcdwT4X+eHrsXmmhXMJmBDGDgORX
        7qpxRm42r1BPwai8o+97TS9YMA==
X-Google-Smtp-Source: AGRyM1vwP52r+DOrP+7+sPj3gLT+i3nLFiVYE70VJk0djpZK0MJCR7EkLpOI5uCX9GWZwUWm0oTzKg==
X-Received: by 2002:a05:6512:2030:b0:489:c8bf:3f29 with SMTP id s16-20020a056512203000b00489c8bf3f29mr12284746lfs.274.1657621558363;
        Tue, 12 Jul 2022 03:25:58 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id x3-20020a056512078300b00485e55192a3sm2097839lfr.72.2022.07.12.03.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 03:25:57 -0700 (PDT)
Message-ID: <d28ea0ac-ff1b-5394-4c76-1561353ab7ce@linaro.org>
Date:   Tue, 12 Jul 2022 12:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] dt-bindings: irqchip: imx mu work as msi controller
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, tglx@linutronix.de, maz@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, peng.fan@nxp.com, aisheng.dong@nxp.com,
        jdmason@kudzu.us
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
References: <20220707210238.917477-1-Frank.Li@nxp.com>
 <20220707210238.917477-2-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707210238.917477-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/07/2022 23:02, Frank Li wrote:
> imx mu support generate irq by write a register.
> provide msi controller support so other driver
> can use it by standard msi interface.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../interrupt-controller/fsl,mu-msi.yaml      | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> new file mode 100644
> index 0000000000000..b4ac583f60227
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/fsl,mu-msi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX Messaging Unit (MU)
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description: |
> +  The Messaging Unit module enables two processors within the SoC to
> +  communicate and coordinate by passing messages (e.g. data, status
> +  and control) through the MU interface. The MU also provides the ability
> +  for one processor to signal the other processor using interrupts.
> +
> +  Because the MU manages the messaging between processors, the MU uses
> +  different clocks (from each side of the different peripheral buses).
> +  Therefore, the MU must synchronize the accesses from one side to the
> +  other. The MU accomplishes synchronization using two sets of matching
> +  registers (Processor A-facing, Processor B-facing).
> +
> +  MU can work as msi interrupt controller to do doorbell
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: fsl,imx6sx-mu-msi
> +      - const: fsl,imx7ulp-mu-msi
> +      - const: fsl,imx8ulp-mu-msi
> +      - const: fsl,imx8-mu-msi
> +      - const: fsl,imx8ulp-mu-msi-s4

Use enum

> +      - items:
> +          - const: fsl,imx8ulp-mu-msi

Single item... why?

> +      - items:
> +          - enum:
> +              - fsl,imx7s-mu-msi
> +              - fsl,imx8mq-mu-msi
> +              - fsl,imx8mm-mu-msi
> +              - fsl,imx8mn-mu-msi
> +              - fsl,imx8mp-mu-msi
> +              - fsl,imx8qm-mu-msi

Why qm is here not compatible with qxp? It's already mentioned in
section below.

> +              - fsl,imx8qxp-mu-msi
> +          - const: fsl,imx6sx-mu-msi
> +      - description: MU work as msi controller
> +        items:
> +          - enum:
> +              - fsl,imx8qm-mu-msi
> +              - fsl,imx8qxp-mu-msi
> +          - const: fsl,imx6sx-mu-msi
> +  reg:
> +    maxItems: 2
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2

Instead describe the items.

> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - msi-controller

How this end up here?

Aren't you missing allOf with a reference to msi-controller?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    lsio_mu12: msi@5d270000 {
> +               compatible = "fsl,imx6sx-mu-msi-db";

???

> +               msi-controller;
> +               interrupt-controller;

??? How this appeared here

Also fix your indentation like in example-schema.

> +               reg = <0x5d270000 0x10000>,     /* A side */
> +                     <0x5d300000 0x10000>;     /* B side */
> +               reg-names = "a", "b";
> +               interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
> +               power-domains = <&pd IMX_SC_R_MU_12A>,
> +                               <&pd IMX_SC_R_MU_12B>;

Please do not send untested bindings. It's a waste of our time.

Really two items here? You just said only one is allowed.

> +               power-domain-names = "a", "b";

Sorry, this patch looks really poor. a/b is not a descriptive name and
they are not allowed by your own bindings. Please perform some internal
reviews...

> +    };


Best regards,
Krzysztof
