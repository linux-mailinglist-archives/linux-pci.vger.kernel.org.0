Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D256C309A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 12:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCULoC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 07:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjCULoB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 07:44:01 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA0937B69;
        Tue, 21 Mar 2023 04:44:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id t14so15173070ljd.5;
        Tue, 21 Mar 2023 04:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679399038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDK2iODbrnq6YMBT3iaeyX6/L7OVDYUqM483wwscgWU=;
        b=Gh11hzeSAUAKPJid7JAGxc/qccHUrZGHz9Sh4sKMqiadjoc7dBXZxPM8Y7gqqGEPHg
         rmVTRNQHYA9hXwvde6wHeabche2Lvu37BxtdBOSCe55yRw7p6du7MI6uW6gwrGaAXFCA
         wVvQwNriQE1QQFz+RRRWYpvUphQHTXJoKGGexD/1vPvIMlr81NAtx4Hf+QsOWQMErKFS
         1REOqwCoBPuvzjGQCIbrmaoLkudx2kEbWpYXwnodDydAmhcVK7yQieDXoyRtwIRKw4Gl
         98wAykqvBEK/3/+Wit/hq7jQXJZT8cvxcHo9N85Vph5UHlDEg6PC1mW78V488VteVcsQ
         GW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679399038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDK2iODbrnq6YMBT3iaeyX6/L7OVDYUqM483wwscgWU=;
        b=ax3fjuIrNtLTde3pUpyurtfLnJ3FNAqRsusHixj9fgVT2wRhkC7Gw3/aK69S/Q9q7R
         I/HYhNB4oC1WO1Z5zOvZrFhPbeBawpjpgaB/psOzjflBxLVOaypFFgCYR/AhsZJqusTH
         +EtzonL/Igm0i2Vgouck9BZ//QJxl+YH5FB9gSJbFNVvaCKIBthGWFAyTPQRlrubPj6Y
         NIdrm8Q78RMU5w2OgJzI51U1NU5B+qejiWSCZCwFL/48skQCtnuO862jv6adHpnHYwQg
         O3EA79Q2DXNUCFjAnRnmaG/mdfYMqCoHpFzRX4dswqnFLK9NeccctQdIge51TQq51uSB
         Nz0Q==
X-Gm-Message-State: AO0yUKXgeVkEhiF6eZKjEG5iEqark+aV+Z0/32wDbLMNbr1OhovGumVo
        Gt/jhbwtNkI0xJPEAzRbYUJK6ylWGz4=
X-Google-Smtp-Source: AK7set/S73W2wIokE855gLh8TE6Yo6ajOelA7I3ecutWdGLYRd1DIcIExGunC4IfrGQOuafYVGtCbw==
X-Received: by 2002:a2e:860c:0:b0:29f:7c5b:8795 with SMTP id a12-20020a2e860c000000b0029f7c5b8795mr497660lji.9.1679399038645;
        Tue, 21 Mar 2023 04:43:58 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id y22-20020a2e3216000000b0029e84187ce2sm647143ljy.139.2023.03.21.04.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 04:43:58 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:43:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, Sergey.Semin@baikalelectronics.ru,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v11 04/13] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Message-ID: <20230321114356.qnecn2kcaoxldka5@mobilestation>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-5-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310123510.675685-5-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 09:35:01PM +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe endpoint module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Looking good now. Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> new file mode 100644
> index 000000000000..12d779a4ce8d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Renesas Electronics Corp.
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
> +    maxItems: 5
> +
> +  reg-names:
> +    items:
> +      - const: dbi
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
> +    maxItems: 1
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
> +            reg = <0 0xe65d0000 0 0x3000>, <0 0xe65d3000 0 0x2000>,
> +                  <0 0xe65d5000 0 0x1200>, <0 0xe65d6200 0 0x0e00>,
> +                  <0 0xfe000000 0 0x400000>;
> +            reg-names = "dbi", "atu", "dma", "app", "addr_space";
> +            interrupts = <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "dma", "sft_ce", "app";
> +            clocks = <&cpg CPG_MOD 624>;
> +            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> +            resets = <&cpg 624>;
> +            num-lanes = <2>;
> +            max-link-speed = <2>;
> +        };
> +    };
> -- 
> 2.25.1
> 
> 
