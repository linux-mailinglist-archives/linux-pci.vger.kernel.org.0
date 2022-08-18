Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA9F5986DD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 17:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344137AbiHRPGv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 11:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344008AbiHRPGu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 11:06:50 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC857171C;
        Thu, 18 Aug 2022 08:06:48 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id b2so1385459qvp.1;
        Thu, 18 Aug 2022 08:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=R/U2IBOmuOYUnAlD0g8GnvyYlwS/o8azETiK5CuXS9k=;
        b=ROaOE9iEAYruBmAdM5vowXfkHVssTeEKD565fdHMvL2MBwO3wo9JjPIxnHwuWYD5wT
         RRLt8FmsquxMNbWuAyZ5/X+eEuxZaQV/NpFIk8fKQpaSUUWD9A7BMSHyNV+SCFNm3dni
         WUE64coc6sjNEEO44Uax1K48rGFhfkwvJw05X6BOPrcqI0ubxLK2r8FfrZ9LtcnySaQy
         rDIJySb2DaUvV/M98nhflG4jDxb7R698M2+ySAqwn54OWO5FTcEmVdvYLs6K9jXgGSYf
         506VnNJgz09QcQ277AezUzsnIvBh0feNxClierQgrGce9fNW8MgK/1dTwODj/QUmOaKG
         5sGw==
X-Gm-Message-State: ACgBeo0Kj4lpuIBrxvtY7cyMwdh9b6NCKuTDS0HbeEy/vF25gbpU8vTr
        U+kZDGVTliUfM5vmw2xvyQ==
X-Google-Smtp-Source: AA6agR6gVKIy8t5d6GRbn5GV0AsGrWcjUGteoJZwZZ0GXaadLL065WXo3TvZe22l7DzyPrKRW0hn3Q==
X-Received: by 2002:a0c:c684:0:b0:494:d65c:f495 with SMTP id d4-20020a0cc684000000b00494d65cf495mr3145337qvj.24.1660835207884;
        Thu, 18 Aug 2022 08:06:47 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:5fe0:b4f5:6e22:4704:df60:73a3])
        by smtp.gmail.com with ESMTPSA id dt2-20020a05620a478200b006bb024c5021sm1755015qkb.25.2022.08.18.08.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:06:47 -0700 (PDT)
Received: (nullmailer pid 1870414 invoked by uid 1000);
        Thu, 18 Aug 2022 15:06:45 -0000
Date:   Thu, 18 Aug 2022 09:06:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/6] dt-bindings: PCI: microchip,pcie-host: fix
 missing clocks properties
Message-ID: <20220818150644.GJ1829017-robh@kernel.org>
References: <20220816182547.3454843-1-mail@conchuod.ie>
 <20220816182547.3454843-3-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816182547.3454843-3-mail@conchuod.ie>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 16, 2022 at 07:25:44PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Recent versions of dt-schema warn about unevaluatedProperties:
> arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: pcie@2000000000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'legacy-interrupt-controller', 'microchip,axi-m-atr0' were unexpected)
>         From schema: Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> 
> The clocks are required to enable interfaces between the FPGA fabric
> and the core complex, so add them to the binding.
> 
> Fixes: 6ee6c89aac35 ("dt-bindings: PCI: microchip: Add Microchip PolarFire host binding")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> dt-schema v2022.08 is required to replicate
> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> index edb4f81253c8..6bbde8693ef8 100644
> --- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> @@ -25,6 +25,31 @@ properties:
>        - const: cfg
>        - const: apb
>  
> +  clocks:
> +    description:
> +      Fabric Interface Controllers, FICs, are the interface between the FPGA
> +      fabric and the core complex on PolarFire SoC. The FICs require two clocks,
> +      one from each side of the interface. The "FIC clocks" described by this
> +      property are on the core complex side & communication through a FIC is not
> +      possible unless it's corresponding clock is enabled. A clock must be
> +      enabled for each of the interfaces the root port is connected through.
> +      This could in theory be all 4 interfaces, one interface or any combination
> +      in between.
> +    minItems: 1
> +    items:
> +      - description: FIC0's clock
> +      - description: FIC1's clock
> +      - description: FIC2's clock
> +      - description: FIC3's clock
> +
> +  clock-names:
> +    description:
> +      As any FIC connection combination is possible, the names should match the
> +      order in the clocks property and take the form "ficN" where N is a number
> +      0-3
> +    minItems: 1
> +    maxItems: 4

items:
  pattern: '^fic[0-3]$'

> +
>    interrupts:
>      minItems: 1
>      items:
> -- 
> 2.37.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
