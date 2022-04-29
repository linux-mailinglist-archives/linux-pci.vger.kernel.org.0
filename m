Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC77D51444E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 10:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355699AbiD2Igf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 29 Apr 2022 04:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355570AbiD2Ige (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 04:36:34 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E897EC1C99;
        Fri, 29 Apr 2022 01:33:16 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id kc16so3986134qvb.7;
        Fri, 29 Apr 2022 01:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Dc2myncEovGHzMMO5/mLeAdO9IgxIKYmIXSZAmgtDQ=;
        b=NgHHD5WGPQkWz7DDzltjqhJnRStiup6ungM2oUBbUdGf6Z3oZ7lqbpAxVcc5XPzeNf
         7dVlxIxoOvc1VJKiIoBTJKSWkenvxREmWcnOrYo532UaT+QvnwhTsq/Teyr3ex9NeKjo
         Lum9Ewm7f55/L66vMCPmiYzD72WKbBsMETTeXYc852H32RoDayJwKLgEIQ/VaZJJl9aE
         SVWpCY88wZuh8B53+Si9/PGRKmVinzUOt7w15wSPpqSDfmEm2nBM4dkNzg3Gr1t8UrRN
         Kux9wi7CoRbKiEZgjR/SzIsW1VSyODPDhxR/9H3fFffTyVELlwJNhypCBcjaHSoRe2BH
         /Ifg==
X-Gm-Message-State: AOAM530mP/PWJn41/1V+4fuBWktAkudxishKYdIE1hE3d0NHd0MuJhQB
        zSGkOcVzWiv/0o5yTxbyRlO/MNE7MbxSjktO
X-Google-Smtp-Source: ABdhPJzrfrdr+zAZSP5veltfmgQA6G6dJMQRPYHdGMwzd/dt821Vn95p+C1VWWAqT2LYbjPsSUpTig==
X-Received: by 2002:ad4:5c4c:0:b0:456:4d9e:db91 with SMTP id a12-20020ad45c4c000000b004564d9edb91mr10673217qva.37.1651221195797;
        Fri, 29 Apr 2022 01:33:15 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id y126-20020a379684000000b0069f908724b1sm1112016qkd.55.2022.04.29.01.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 01:33:14 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2f7d19cac0bso77680017b3.13;
        Fri, 29 Apr 2022 01:33:14 -0700 (PDT)
X-Received: by 2002:a81:8489:0:b0:2f7:edff:239f with SMTP id
 u131-20020a818489000000b002f7edff239fmr24542183ywf.256.1651221194308; Fri, 29
 Apr 2022 01:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220428151630.586009-1-herve.codina@bootlin.com> <20220428151630.586009-3-herve.codina@bootlin.com>
In-Reply-To: <20220428151630.586009-3-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Apr 2022 10:33:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVHHGv02Lo=STRnbWAyi+bT2mE8igOSZPA6sG7L8uaBAQ@mail.gmail.com>
Message-ID: <CAMuHMdVHHGv02Lo=STRnbWAyi+bT2mE8igOSZPA6sG7L8uaBAQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hervé,

On Thu, Apr 28, 2022 at 5:16 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Add internal PCI bridge support for the r9a06g032 SOC. The Renesas
> RZ/N1D (R9A06G032) internal PCI bridge is compatible with the one
> present in the R-Car Gen2 family.
> Compared to the R-Car Gen2 family, it needs three clocks instead of
> one.
>
> The 'resets' property for the RZ/N1 family is not required since
> there is no reset-controller support yet for the RZ/N1 family.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> +++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml

> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - renesas,pci-rzn1
> +
> +then:
> +  properties:
> +    clocks:
> +      items:
> +        - description: Internal bus clock (AHB) for HOST
> +        - description: Internal bus clock (AHB) Power Management
> +        - description: PCI clock for USB subsystem
> +    clock-names:
> +      items:
> +        - const: usb_hclkh
> +        - const: usb_hclkpm
> +        - const: usb_pciclk

Please drop the "usb_" prefixes.

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
