Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E5673FBF2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 14:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjF0M1m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjF0M1k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 08:27:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FF81999;
        Tue, 27 Jun 2023 05:27:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso5913875e87.2;
        Tue, 27 Jun 2023 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687868857; x=1690460857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/mJ6hmMqZhxuz4ikK9p02Uw9j7Tjh09y+Fhxu+CmDd0=;
        b=g7/qXappm38Acrg/PZ0xRgRoQ3mCx1qsch84FzZiz0+ESXVwyVvu0z2Enl0IUKaV7q
         htbU0CT+SB72XpCXIx9lbP4XQQLlU17TNyj2kntCazzzgyq9M848oSBjxMchkT4pu7D6
         jX16cc3QTMWWngPQZNfjmA6Ov0RcvBC4lTH/+eNY8EtGfO3vm7P8Ewj30/vqZT1jSbqe
         SghKEgS4XuQ8s9D7h2UWGFi90tL/tO9lGbJkQA9/v/ASX7R0kQA2ESQLQwKsg9XiZqZZ
         D9+heArI2amw08vNLl5A4iZvijcabNbhSpv5EluoNAZf+7hyXoJR7H0PYqj4ryjGNeS0
         o9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687868857; x=1690460857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mJ6hmMqZhxuz4ikK9p02Uw9j7Tjh09y+Fhxu+CmDd0=;
        b=NFVI+/dAgQF4KfXkissMnm/EW8S7K0IeM7Eq26kBazKeuMnSyFSGqdgOR+6LBhWcAR
         RF50pFQPuZioyAuFtW9I2RJWL+n8AyN2sy+Qo9AQZ7b/M/WOvSR/PSGnHpYQyJgnYu50
         ulvceLbt9VBV2J2y0e5ERK+jH9MbUxyad3aYANL9lEILwrhhm3DjSBuiZ8ds1z2JmknO
         wtLftNRHyAYdod+TEbjH3pS1HrznIzmcywUJdoav8PWGT4RrgVpN+6BxEvOA7pSkIYWY
         Rk3VdQ3QJNaU6/vZLxOv2R+JKfWkgCWNY5C0YeMrmD9dBukDd7JAjSmoBCSgIOeyD98+
         d8BQ==
X-Gm-Message-State: AC+VfDzXiO2HEe2PeURwPjbTI+3P0KztemwHISqRg9lvvN8KaJA7NKme
        s5xI2238Tj2JcIRKOOjUNzU=
X-Google-Smtp-Source: ACHHUZ7uudNcbmp+pqAQlJxTbbL5JTe7kns0LAL50bO2FeUNhAtc/IXEvtiJbz5XUijjmrozJAEi1w==
X-Received: by 2002:a19:4355:0:b0:4f8:5635:2cd8 with SMTP id m21-20020a194355000000b004f856352cd8mr16940533lfj.32.1687868856658;
        Tue, 27 Jun 2023 05:27:36 -0700 (PDT)
Received: from mobilestation ([109.194.233.142])
        by smtp.gmail.com with ESMTPSA id y10-20020ac255aa000000b004f842478f9asm1492318lfg.88.2023.06.27.05.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:27:35 -0700 (PDT)
Date:   Tue, 27 Jun 2023 15:27:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Subject: Re: [PATCH v1 1/4] dt-bindings: PCI: dwc: rockchip: Fix
 interrupt-names issue
Message-ID: <n5vgfnqicq3ndgqtcp3yjurbdn76vucj6zyjhlpjbdwoquv2la@5g5kv5gceyd7>
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
 <20230616170022.76107-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616170022.76107-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 16, 2023 at 07:00:19PM +0200, Sebastian Reichel wrote:
> The RK356x (and RK3588) have 5 ganged interrupts. For example the
> "legacy" interrupt combines "inta/intb/intc/intd" with a register
> providing the details.
> 
> Currently the binding is not specifying these interrupts resulting
> in a bunch of errors for all rk356x boards using PCIe.
> 
> Fix this by specifying the interrupts and add them to the example
> to prevent regressions.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml         | 18 ++++++++++++++++++
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml  | 15 ++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index 24c88942e59e..98e45d2d8dfe 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -56,6 +56,17 @@ properties:
>        - const: pclk
>        - const: aux
>  
> +  interrupts:
> +    maxItems: 5
> +
> +  interrupt-names:
> +    items:
> +      - const: sys
> +      - const: pmc
> +      - const: msg
> +      - const: legacy
> +      - const: err
> +
>    msi-map: true
>  
>    num-lanes: true
> @@ -98,6 +109,7 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>      bus {
>          #address-cells = <2>;
> @@ -117,6 +129,12 @@ examples:
>                            "aclk_dbi", "pclk",
>                            "aux";
>              device_type = "pci";
> +            interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "sys", "pmc", "msg", "legacy", "err";
>              linux,pci-domain = <2>;
>              max-link-speed = <2>;
>              msi-map = <0x2000 &its 0x2000 0x1000>;
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index 1a83f0f65f19..9f605eb297f5 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -193,9 +193,22 @@ properties:
>            oneOf:
>              - description: See native "app" IRQ for details
>                enum: [ intr ]

The IRQs below are either combined version of the already defined IRQs
or just the generic DW PCIe IRQs but named differently. Moreover I
don't see kernel using any of them except the "legacy" interrupt. What
about converting the dts files to using the already defined names instead
of extending the already over-diverged DT-bindings?
Rob, Krzysztof?

In anyway in order to prevent from defining the new DW PCIe bindings
compatible with your vendor-specific names please move the aliases to
being under the last entry of the "interrupt-names" items property.
(See the "intr" IRQ name for example or the way the vendor-specific
names are defined in the reg-names property.)

> +        - description: Combined Legacy A/B/C/D interrupt signal.
> +          const: legacy

This is a combined signal of "^int(a|b|c|d)$". So the entry
is supposed to look:
+              - description: See native "int*" IRQ for details
+                const: legacy

> +        - description: Combined System interrupt signal.
> +          const: sys

This seems like the "app" interrupt. So please either convert the dts
file to using the "app" name or move this to being defined in the same
entry as the "intr" name.

> +        - description: Combined Power Management interrupt signal.
> +          const: pmc

This is an alias to the already defined "pme" name. So either convert
the dts file to using "pme" or move this to being in the
vendor-specific list of the "interrupt-names" property:
+              - description: See native "pme" IRQ for details
+                const: pmc

> +        - description: Combined Message Received interrupt signal.
> +          const: msg

ditto but with respect to the "msi" name.

> +        - description: Combined Error interrupt signal.
> +          const: err

ditto but with respect to the "sft_*" name.

> +
>      allOf:
>        - contains:
> -          const: msi
> +          enum:
> +            - msi
> +            - msg

* Please see my suggestion about converting the DTS file instead.

-Serge(y)

>  
>  additionalProperties: true
>  
> -- 
> 2.39.2
> 
