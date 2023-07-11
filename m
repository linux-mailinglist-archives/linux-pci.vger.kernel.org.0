Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11AE74F98E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 23:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjGKVCi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 17:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjGKVCh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 17:02:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233B719B;
        Tue, 11 Jul 2023 14:02:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so9646467e87.2;
        Tue, 11 Jul 2023 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689109354; x=1691701354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZilgtAPy8wWSgGLAsFq4XIBq5SXQUgWQos6V0+Rs1s=;
        b=CgTC89cg05Te6fIySldVpTiCjdPZQUtOdrFyQg3HUggwj/h0Loi/OqxBSmsWi65Gbb
         177t0ntTfKIHl4c46h24fCaCzE11mi2BlGBO3k2Sk7igXSmAozxQS0UsI6EdCwBXJIoF
         p9i/tLUWMSbS2fA+IEzW/ebepz8u3OV2GGqstp33cdVAr63UWBmiokhmdB6pxv5IxRl/
         umaBXafUUFxHRYsgce4PItlsB7SmczxCROB0VyINoOxeRF8/IC1l2MVoNuH3GeEwEZBE
         nwslJWomOlIImRvm1E1mQ9ZDRAp/6tv6+LNpuqMwsau51YbnpoGz0H5JiUsQVLnacuWn
         LUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689109354; x=1691701354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZilgtAPy8wWSgGLAsFq4XIBq5SXQUgWQos6V0+Rs1s=;
        b=Pz/X8eE0RC1cQ4z8pCavTrDJFDUcozS4xTWO7xuosRaDJiohdp2aWOm68bcjM6g16a
         a16lgGS/cVHpobUdrNshD0wh5rzdec3GcRSw4gUkdvrLSe3smfrjF7PgXVqAjcKi8opE
         9QCUKH3p4FxxtFahL+ufonFBt5f0qOotwLIAhxpMYOhyvEbB5UjKBBtFVN0tseduRa3j
         uabday9HdGEAFNAXtZmIMlEjZsvovRT6bAJD58NTHkm/Yap2/mJ7gUId49B3qiAKEo+B
         B16R01LR+dUnyBF66WvSVViMWvB4vceZmRfC57ozdMfAc1qV/tI+a7SnKWGEyuVnGVNV
         IunA==
X-Gm-Message-State: ABy/qLYXlYDKTuiQmaarNOKOOYvpqTyZANsqdJ4LVd4gTgKx3drCKgRs
        2d68cTV/O98wljwAhNKqJBo=
X-Google-Smtp-Source: APBJJlEr3S3PKMoToFuuwjZWxO20wadh3V8YGM0cTUWHbgfUZ+AyKEVU4GSIWwplfhceC9MsciR5Qg==
X-Received: by 2002:a05:6512:692:b0:4f8:5e11:2cbc with SMTP id t18-20020a056512069200b004f85e112cbcmr15766413lfe.36.1689109354046;
        Tue, 11 Jul 2023 14:02:34 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id w7-20020ac25987000000b004fbb3872190sm444906lfn.113.2023.07.11.14.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:02:33 -0700 (PDT)
Date:   Wed, 12 Jul 2023 00:02:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v17 16/20] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Message-ID: <rk52tz3tmpzg6s7szkh3u44vnr3sncgtb7535fn5alf4fj4dlh@ljmhmtjee3rw>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-17-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705114206.3585188-17-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 08:42:02PM +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe endpoint module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> new file mode 100644
> index 000000000000..4e6be856104c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022-2023 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rcar-gen4-pci-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car Gen4 PCIe Endpoint
> +
> +maintainers:
> +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> +
> +allOf:
> +  - $ref: snps,dw-pcie-ep.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: renesas,r8a779f0-pcie-ep   # R-Car S4-8
> +      - const: renesas,rcar-gen4-pcie-ep  # R-Car Gen4
> +
> +  reg:
> +    maxItems: 6
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: atu
> +      - const: dma
> +      - const: app
> +      - const: addr_space
> +
> +  interrupts:
> +    maxItems: 3
> +
> +  interrupt-names:
> +    items:
> +      - const: dma
> +      - const: sft_ce
> +      - const: app
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: ref
> +
> +  max-functions:
> +    maximum: 2
> +
> +  max-link-speed:
> +    maximum: 4
> +
> +  num-lanes:
> +    maximum: 4
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - resets
> +  - power-domains
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a779f0-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/r8a779f0-sysc.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie0_ep: pcie-ep@e65d0000 {
> +            compatible = "renesas,r8a779f0-pcie-ep", "renesas,rcar-gen4-pcie-ep";

> +            reg = <0 0xe65d0000 0 0x2000>, <0 0xe65d2800 0 0x0800>,
> +                  <0 0xe65d3000 0 0x2000>, <0 0xe65d5000 0 0x1200>,
> +                  <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;
> +            reg-names = "dbi", "dbi2", "atu", "dma", "app", "addr_space";

I'll ask it once again since you didn't address my comment in v16 and
haven't fixed the example node in the bindings:

I see you defining the dbi2 space as <0 _0xe65d2800_ 0 0x0800>. But
sometime before you mentioned that your device has the next CSRs
layout:
! +0x0000 : Function 0 (common address in Root port and Endpoint mode)
  +0x1000 : Function 1 (Endpoint mode only)
  +0x2000 : Shadow register for Function 0
! +0x2800 : Shadow register for Function 1
it means the DT-bindings example node has the dbi space defined for
both functions meanwhile the dbi2 space defined for _function #1_ only
(it's 0xe65d0000 + 0x2800). So AFAICS either you have wrong space
defined in the example node or the node is wrong in your platform DTS
too and you have a malfunction end-point mode. Am I missing something?
In any case based on your End-point driver implementation dbi2 is
supposed to be defined at the 0xe65d2000 base address.

Am I wrong? Could you clarify this?

-Serge(y)

> +            interrupts = <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "dma", "sft_ce", "app";
> +            clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
> +            clock-names = "core", "ref";
> +            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> +            resets = <&cpg 624>;
> +            num-lanes = <2>;
> +            max-link-speed = <4>;
> +            max-functions = /bits/ 8 <2>;
> +        };
> +    };
> -- 
> 2.25.1
> 
