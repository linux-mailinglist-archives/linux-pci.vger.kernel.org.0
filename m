Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A266278EE57
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 15:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343739AbjHaNQy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 31 Aug 2023 09:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbjHaNQy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 09:16:54 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75E61A4;
        Thu, 31 Aug 2023 06:16:47 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5924093a9b2so9269407b3.2;
        Thu, 31 Aug 2023 06:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487807; x=1694092607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6MTEyfdoHQZ6EY8Gi25XBQur+r3AKr/RULRlZJXzw0=;
        b=G/EpOHNAqKXHayBAJyB3lJ2Pq3cEPRuQoPBg08ntdP65n2JmRDG/GaWfrPq6tDxf3K
         K6KiN/EGZ7Fl6vBbeVRqgxYCUNn0zbSfc/GuHycbBKTUzeeqWgsgZCQfBslWyV5OQ7As
         nMciyBDgantA1LtmWBX1Qr77XrO69fOa+Ks+8NF7+PLTkS+f9HZF/QkvcHi+jRrKgda2
         YNLi0OEpIatj5pCtXHmM+qicx8FzLjy2mbXCoc4UikbPbZGm6DhCdwksrBa38EwuKuTC
         fuYisSurTNlIh0wCwjzu90radNhvmBYaf4vyCdjiULArniPp/L/2UmTlvOVF6hL1Vo7c
         UoIw==
X-Gm-Message-State: AOJu0YxDBp9PMbily5yh6v3I5DpLonGBQonvZoPredqyWDrjSiOXGl97
        R0CG/J91BW29fn5foc/HD+qY2GhxjJn4uA==
X-Google-Smtp-Source: AGHT+IGbfPJnuby4ugpKWFMrgcgGtIRP0dVpllaTdirY/KGnLTXDH13TORn1VXx6RrI7Xgs9pw0N1w==
X-Received: by 2002:a25:cf4e:0:b0:d43:a84f:a6aa with SMTP id f75-20020a25cf4e000000b00d43a84fa6aamr5505417ybg.39.1693487806715;
        Thu, 31 Aug 2023 06:16:46 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id e198-20020a25d3cf000000b00d607f70d762sm305288ybf.32.2023.08.31.06.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 06:16:46 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d746ea563f9so558460276.1;
        Thu, 31 Aug 2023 06:16:46 -0700 (PDT)
X-Received: by 2002:a25:25c4:0:b0:d43:51b3:b5d5 with SMTP id
 l187-20020a2525c4000000b00d4351b3b5d5mr4806452ybl.0.1693487805515; Thu, 31
 Aug 2023 06:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com> <20230825093219.2685912-16-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230825093219.2685912-16-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 31 Aug 2023 15:16:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5NEJFSmL6Ey6TwSaaX4Mj5k3C9_UP0psyijeaLVCEPw@mail.gmail.com>
Message-ID: <CAMuHMdV5NEJFSmL6Ey6TwSaaX4Mj5k3C9_UP0psyijeaLVCEPw@mail.gmail.com>
Subject: Re: [PATCH v20 15/19] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        fancer.lancer@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shimoda-san,

On Fri, Aug 25, 2023 at 3:57 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe endpoint module.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> @@ -0,0 +1,106 @@

> +  resets:
> +    maxItems: 1

Missing reset-names, cfr.
Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml

> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - resets
> +  - power-domains
> +  - clocks
> +  - clock-names

Missing reset-names.

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

<0 0xe65d2800 0 0x0800> does not match your DTS patch
https://lore.kernel.org/linux-renesas-soc/20230828041434.2747699-2-yoshihiro.shimoda.uh@renesas.com

> +                  <0 0xe65d3000 0 0x2000>, <0 0xe65d5000 0 0x1200>,
> +                  <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;
> +            reg-names = "dbi", "dbi2", "atu", "dma", "app", "addr_space";
> +            interrupts = <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;

What about SPI 419, 420, 421?

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

BTW, I think it would be good to make the order of the properties and
in the example match between the host and endpoint bindings, to make
the output of
"diff Documentation/devicetree/bindings/pci/rcar-gen4-pci-{host,ep}.yaml"
as small as possible.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
