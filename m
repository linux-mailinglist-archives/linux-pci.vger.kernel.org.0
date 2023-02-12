Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C47693A2C
	for <lists+linux-pci@lfdr.de>; Sun, 12 Feb 2023 22:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBLVLQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Feb 2023 16:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBLVLP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Feb 2023 16:11:15 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F89B740;
        Sun, 12 Feb 2023 13:11:14 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ml19so27621434ejb.0;
        Sun, 12 Feb 2023 13:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HeM9cfRXOAD3QGvR8kptQ1hoajutwUKn/wZ8gYupzw=;
        b=Hs/OMjWHXYksIdWjuBSH6uZ4Rexlz3ZJBTUc+P9lIgydunASaIVNoG/zhyTSgzTqFu
         5mrXo6tgh+Yf0GqCo5/1oFLXlx2qbY94a2Ckzo2IKGwiDmBjg/9ry4t6RmEqHMbrwuL2
         CskNeGCvvfSmfjfjHIOLqA7Bd868Rs2JjwprtB8KuSgqlFBwml+S8u5JYo/s8zcKh1R4
         5HscUjD1uG7mR5rAjQMU3GkRU9x2+rM3sjr+qtEhypCvzJFsI/PbH9InmutJHS4katrE
         VUrHytGhJtmptXYV+5fjiaSO34FX5pY9H7fpBn2zJ/un6NsHR8hKLCfucrKCyLLazTa/
         jBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HeM9cfRXOAD3QGvR8kptQ1hoajutwUKn/wZ8gYupzw=;
        b=HAlZl/UJGWtdxzUgRQBPxqrJdetbGRi1KA7ZxQ4tuHP53DjgsONP2o5TzE9g+PKEka
         NwPOT5ewkjMe2h0gkfpVMcZWOYJiyAVCRWJZ0vPV93Q5vKidFp4aikJlHOMnZFH7Q59t
         h60VnbWRBFqErrP651KVlllOE4qZcItVGhBgN3Kbtt5b4n4YB2SVDQdZFOcU1hsN2bz3
         NnSaAWgxfsApqtAR+P3BnvipkekVF3CEJ00SwQFsCNevoUi+EwGpRa/q7L1lFTNJrqrM
         zadWCPdlxVHOm6kdsLfbPyf6TBemAOQNd9cGsWW5jyDGC7Z4OP/Ba1DKsyvESgfDxauk
         tNFQ==
X-Gm-Message-State: AO0yUKVRmySyQl0CtjTI2aFdD3fuyFxkQTPwYwpEJN7UZghDi+mTU3GT
        gWwcaMi3+JFOXHTuhLCUc1c=
X-Google-Smtp-Source: AK7set9oOsNR7MaFh1dF9Ha9TMavvsaFpHFqRmQGhTsotAM592oCvGCo1s7XuAYUwxMA+H8a2UtI9Q==
X-Received: by 2002:a17:906:7c10:b0:8af:45d5:426f with SMTP id t16-20020a1709067c1000b008af45d5426fmr8862721ejo.33.1676236272574;
        Sun, 12 Feb 2023 13:11:12 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906c01400b008ae3324c8adsm5797051ejz.214.2023.02.12.13.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 13:11:12 -0800 (PST)
Date:   Mon, 13 Feb 2023 00:11:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, Sergey.Semin@baikalelectronics.ru,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 2/8] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Message-ID: <20230212211109.jsegwlqjru56ypq4@mobilestation>
References: <20230210134917.2909314-1-yoshihiro.shimoda.uh@renesas.com>
 <20230210134917.2909314-3-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210134917.2909314-3-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 10:49:11PM +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe endpoint module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> new file mode 100644
> index 000000000000..4b10d67e4336
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> @@ -0,0 +1,90 @@
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
> +    maxItems: 4
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: atu

> +      - const: appl

Please, use "elbi" or "app" instead. No need in using the
vendor-specific names if there is the generic ones.
(* @Rob, that's why I was insisting in failing the DT-bindings
evaluation for such cases...)
See Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml:98

> +      - const: addr_space
> +
> +  interrupts:
> +    maxItems: 3
> +
> +  interrupt-names:
> +    items:

> +      - const: dma

Are you sure there is a single IRQ line for all eDMA channels?
Judging by the DW PCIe HW manual the eDMA events are signaled by the
wires: edma_int[((CC_NUM_DMA_RD_CHAN+CC_NUM_DMA_WR_CHAN)-1):0]. If you
have a single signal then they must have been combined on the way to
the GIC though... 

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

> +  max-link-speed: true

This prop is determined by the CX_MAX_PCIE_SPEED IP-core synthesize
parameter.

> +
> +  num-lanes: true

This is determined by the CX_NL IP-core synthesize parameter.

Thus you can provide at least the 'maximum' constraint for
the properties above.

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
> +additionalProperties: false

Are you sure that none of the next properties will be ever used in
the R-Car PCIe End-point DT-nodes?
max-functions
max-virtual-functions
phys
phy-names
reset-gpios
snps,enable-cdm-check
dma-coherent
* etc

I am pretty much sure that the reset-gpios (platform-specific),
max-{virtual-}functions (determined by the CX_NFUNC IP-core synthesize
parameter), phys/phy-names (you had a PHYs CSR space in the
DT-bindings example) and dma-coherent properties are relevant for your
device. At the very least the 'max-functions' prop constraint could be
explicitly added to your DT-bindings file. You must be aware of how
many functions the R-Car PCIe EP support, right? The rest of the
properties could be implicitly evaluated by replacing the
"additionalProperties: false" flag with the "unevaluatedProperties:
false" statement.

-Serge(y)

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
> +            reg = <0 0xe65d0000 0 0x1000>, <0 0xe65d1000 0 0x1000>,
> +                  <0 0xe65d3000 0 0x2000>, <0 0xfe000000 0 0x400000>;
> +            reg-names = "dbi", "atu", "appl", "addr_space";
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
