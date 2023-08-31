Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F2C78EE42
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 15:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245279AbjHaNNP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 31 Aug 2023 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345436AbjHaNNP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 09:13:15 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6A1E5B;
        Thu, 31 Aug 2023 06:12:57 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-592976e5b6dso9045427b3.2;
        Thu, 31 Aug 2023 06:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487576; x=1694092376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKhupgnBTrKusYmY2bRrXeIyXEFCrxRkLVwKo8dWCyY=;
        b=FnkBsZA3ezmOqCBGnup7xk5EHMbGOGuWD4ocxFym/l+nid83kxlLY/QOWM7U4xcLOt
         rt7M5dM29vCI5R1GtbwYFpBJHxk3p2qN80caim3AfJ7+qvC90ytKlMDjUYhVWQqpOEbL
         a1LSwXYJ4+FKTj8z8YsD114YLa8sfvW86ZSAltlp4K7P/izAhgM3QnNt/NV4H46pGjrs
         pj3PYMF/42KYLnIdz6SAJJKcxWvnqf/DUKY/fnYV2YOVZHyo0UYBiVyeHlO4gxk00KcC
         D5xipBnutlnTJKfJbLkpeCPerM9Bdh/Yxockqmz3yc8EQgCtxy7qLidJnh1T4DT0FL5g
         uPMg==
X-Gm-Message-State: AOJu0YzoRGLRy+puW+MN/6hE2WduFkKvHpegITww7Vdeej7jZ0jbHlpx
        qYN7ut8fCYRaOzZCOFYqi78H1UePVHFi6g==
X-Google-Smtp-Source: AGHT+IHhy+nNUqElHja4hiCFONK3G9QOSZniK7gyb60D9Y0fMQ9Q+nqpXZux1NYobendgle33ar+LQ==
X-Received: by 2002:a81:8841:0:b0:592:2bf2:6578 with SMTP id y62-20020a818841000000b005922bf26578mr5181019ywf.46.1693487576586;
        Thu, 31 Aug 2023 06:12:56 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id h3-20020a81b403000000b0058442f46fbfsm397626ywi.44.2023.08.31.06.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 06:12:56 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d7820f9449bso591738276.1;
        Thu, 31 Aug 2023 06:12:55 -0700 (PDT)
X-Received: by 2002:a25:6b07:0:b0:d78:3047:62c6 with SMTP id
 g7-20020a256b07000000b00d78304762c6mr5325236ybc.21.1693487575303; Thu, 31 Aug
 2023 06:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com> <20230825093219.2685912-15-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230825093219.2685912-15-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 31 Aug 2023 15:12:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV7Qxjs+84E_Ht=d2EvBMYwwPxviT-DaT4-2m4Ds_+tdw@mail.gmail.com>
Message-ID: <CAMuHMdV7Qxjs+84E_Ht=d2EvBMYwwPxviT-DaT4-2m4Ds_+tdw@mail.gmail.com>
Subject: Re: [PATCH v20 14/19] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        fancer.lancer@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh@kernel.org>
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

On Fri, Aug 25, 2023 at 3:18 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe host module.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> @@ -0,0 +1,123 @@

> +  resets:
> +    maxItems: 1
> +
> +  resets-names:

reset-names

> +    items:
> +      - const: pwr
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

Missing "reg-names".

> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +  - reset-names
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
> +            reg = <0 0xe65d0000 0 0x1000>, <0 0xe65d2000 0 0x0800>,
> +                  <0 0xe65d3000 0 0x2000>, <0 0xe65d5000 0 0x1200>,
> +                  <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;

The lenght "0x0e00" does not match your DTS patch
https://lore.kernel.org/linux-renesas-soc/20230828041434.2747699-2-yoshihiro.shimoda.uh@renesas.com

> +            reg-names = "dbi", "dbi2", "atu", "dma", "app", "config";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            bus-range = <0x00 0xff>;
> +            device_type = "pci";
> +            ranges = <0x01000000 0 0x00000000 0 0xfe000000 0 0x00400000>,
> +                     <0x02000000 0 0x30000000 0 0x30000000 0 0x10000000>;
> +            dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
> +            interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;

What about SPI 419, 420, 421?

> +            interrupt-names = "msi", "dma", "sft_ce", "app";
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cpg CPG_MOD 624>, <&clkref>;
> +            clock-names = "core", "ref";
> +            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> +            resets = <&cpg 624>;
> +            reset-names = "pwr";
> +            num-lanes = <2>;
> +            snps,enable-cdm-check;
> +            max-link-speed = <4>;
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


> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +  - reset-names
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
> +            reg = <0 0xe65d0000 0 0x1000>, <0 0xe65d2000 0 0x0800>,
> +                  <0 0xe65d3000 0 0x2000>, <0 0xe65d5000 0 0x1200>,
> +                  <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;
> +            reg-names = "dbi", "dbi2", "atu", "dma", "app", "config";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            bus-range = <0x00 0xff>;
> +            device_type = "pci";
> +            ranges = <0x01000000 0 0x00000000 0 0xfe000000 0 0x00400000>,
> +                     <0x02000000 0 0x30000000 0 0x30000000 0 0x10000000>;
> +            dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
> +            interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "msi", "dma", "sft_ce", "app";
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cpg CPG_MOD 624>, <&clkref>;
> +            clock-names = "core", "ref";
> +            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> +            resets = <&cpg 624>;
> +            reset-names = "pwr";
> +            num-lanes = <2>;
> +            snps,enable-cdm-check;
> +            max-link-speed = <4>;
> +        };
> +    };
> --
> 2.25.1
>


--
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
