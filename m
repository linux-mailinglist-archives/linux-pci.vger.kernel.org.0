Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6215B6C307D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 12:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjCULgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 07:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCULgJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 07:36:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D1646166;
        Tue, 21 Mar 2023 04:36:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bi9so18659245lfb.12;
        Tue, 21 Mar 2023 04:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679398566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FSDsONFjGTbQMiv9VRiTDPX+xag6OsgqbV8/gmLcFqE=;
        b=CEg6MHNk6Cm2YFJfNzyVH4AKec9h1hXlMJb+astCOD9KhcSOOKSJHzPa8zgmZL1kDq
         tGMCx1JJVA5p9o+rZhyR1zQDyIzdO55QvV+VHtS2v0pRb34qFpSOazslafDlXSq8ksDc
         FBOhtQ4uGfHA+UOXktMxbFZ4GBSvODES/KsdxbuMdA32h6ztBnxdAUuPCuYV5a4JZxVn
         87eCGh1Oazm6tBhLMpXtU3ryb9hmwjz76OE+J/TyAd7j9flXgvrqfAMOn9T09yHvz0BR
         cdEbwLcxeAN2Nhg88s40jaB78R32BsQdI2elcYDzygLqYCZprIcqZEBf8uJqPt4aNHCQ
         LO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679398566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSDsONFjGTbQMiv9VRiTDPX+xag6OsgqbV8/gmLcFqE=;
        b=YOj8UnBFd4HnVlFuxBHYajUzuiQo3wv34q0OF4F328RPYTFRJ+WziKD/CtJwFwfexY
         PF347G6jvioXtlhomiiXvx0gFrvZI9EqHQMc9pC8khjPdFcMH9oed4iarNa0AMJlcHWI
         e0/fqVU4K2RfqF51fDLpRX1XhzTF1aW9vdiTn0xETAPweIWWKMsMWr1QjS4WrtVoyBD4
         3npzns9BXToDvs6oJ3XbZWiqOO1SaT1JCww8fBJuDs2QWijhCNANvXCNmxHAYoMFCfiT
         9oLBBMGVxgKEVCME1UT1noPApazlFopWeHdpV/dBTEHwklkdUEFZBgjeEtBstPWD8OXq
         KmSw==
X-Gm-Message-State: AO0yUKV3u23E+p3dNqFDVId2oONsMjcvyuKvu8maeLptNvm9840kAr56
        MyA18Wd3kcgQfla0VF3VUqU=
X-Google-Smtp-Source: AK7set9Uzi/wdR6VfHp6dzcHLOpm7xUjMr2M3jb1593yHjNMGmfsaJT53Kdx5Vu3PVF+oKCNyZRsng==
X-Received: by 2002:a05:6512:508:b0:4cb:280b:33c9 with SMTP id o8-20020a056512050800b004cb280b33c9mr699631lfb.24.1679398566069;
        Tue, 21 Mar 2023 04:36:06 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id u1-20020ac248a1000000b004db51387ad6sm2132288lfg.129.2023.03.21.04.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 04:36:05 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:36:03 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, Sergey.Semin@baikalelectronics.ru,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v11 03/13] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Message-ID: <20230321113603.xxdiekhqpv4h777f@mobilestation>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-4-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310123510.675685-4-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 09:35:00PM +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe host module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Looks good.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

> ---
>  .../bindings/pci/rcar-gen4-pci-host.yaml      | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> new file mode 100644
> index 000000000000..d838d7c50410
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car Gen4 PCIe Host
> +
> +maintainers:
> +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> +
> +allOf:
> +  - $ref: snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: renesas,r8a779f0-pcie   # R-Car S4-8
> +      - const: renesas,rcar-gen4-pcie  # R-Car Gen4
> +
> +  reg:
> +    maxItems: 5
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: atu
> +      - const: dma
> +      - const: app
> +      - const: config
> +
> +  interrupts:
> +    maxItems: 4
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: dma
> +      - const: sft_ce

> +      - const: app

Just curious what is this IRQ used for?

-Serge(y)

> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
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
> +  - interrupts
> +  - clocks
> +  - power-domains
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
> +        pcie: pcie@e65d0000 {
> +            compatible = "renesas,r8a779f0-pcie", "renesas,rcar-gen4-pcie";
> +            reg = <0 0xe65d0000 0 0x3000>, <0 0xe65d3000 0 0x2000>,
> +                  <0 0xe65d5000 0 0x1200>, <0 0xe65d6200 0 0x0e00>,
> +                  <0 0xfe000000 0 0x400000>;
> +            reg-names = "dbi", "atu", "dma", "app", "config";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            bus-range = <0x00 0xff>;
> +            device_type = "pci";
> +            ranges = <0x81000000 0 0x00000000 0 0xfe000000 0 0x00400000
> +                      0x82000000 0 0x30000000 0 0x30000000 0 0x10000000>;
> +            dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
> +            interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "msi", "dma", "sft_ce", "app";
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
> +                             0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
> +                             0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
> +                             0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cpg CPG_MOD 624>;
> +            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> +            resets = <&cpg 624>;
> +            num-lanes = <2>;
> +            snps,enable-cdm-check;
> +            max-link-speed = <2>;
> +        };
> +    };
> -- 
> 2.25.1
> 
> 
