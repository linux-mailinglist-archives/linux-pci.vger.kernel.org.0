Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDDB54C3F5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 10:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345942AbiFOItH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 04:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346716AbiFOItG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 04:49:06 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5637D39160;
        Wed, 15 Jun 2022 01:49:04 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id d23so8276325qke.0;
        Wed, 15 Jun 2022 01:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGIGzc6S7Qj6fmbIVxM1msyTK1VdOrvEVUr+Yr4R/NY=;
        b=WVEZO/Oe6aGNgDXf7qwOSqd+Ba1waRnq0a/G89mmr3WLHf8P8+YHXEGX3wEQ56t/n+
         UXXlTqCDHUl5H4qe30MGt1OqkgGkjDVYWsz9A9u/+w+w8dp3I1KFE2ZT0uaGNAEmFRa6
         jB/oKuGOTsk8X6LPjjNfnpaTF5dIzlcZ95FLcSa/Mwt+nA1LQLF3qPP80ItGip6U72uP
         XC6mEmcNvfK3pzO2kbYYxbxhCY4haPPO1W+2z5GwBdKkU4HF3jJMDKPiLV2iYJDlRozC
         1WN+EQzB7iJsIjcM9lsW3O0g65Nmu+B8UTGDhhnFEZ/dWib6gG36e/dwwadVP819xwAd
         tJ3A==
X-Gm-Message-State: AOAM531vHqesP9dYUKB9q4lUMYdBQ/VNfT5TMcwFQH6HNZYoxbVc+UR5
        mBewV59Pd8i5hkOSci7tAnp9HDkIhGbRHw==
X-Google-Smtp-Source: ABdhPJyL1TV6O7XIcdX57OVQ49tyD4nmnjYLiV2zoRo1yrZsx3EwaVa9UICv5K+kz6fRRqTwQfriww==
X-Received: by 2002:a37:6614:0:b0:6a6:9639:77f3 with SMTP id a20-20020a376614000000b006a6963977f3mr7169874qkc.516.1655282943296;
        Wed, 15 Jun 2022 01:49:03 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id bp6-20020a05620a458600b0069fc13ce1fesm11537006qkb.47.2022.06.15.01.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 01:49:02 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-30ec2aa3b6cso53704247b3.11;
        Wed, 15 Jun 2022 01:49:02 -0700 (PDT)
X-Received: by 2002:a0d:e657:0:b0:314:7e4d:30a9 with SMTP id
 p84-20020a0de657000000b003147e4d30a9mr6032904ywe.316.1655282942201; Wed, 15
 Jun 2022 01:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com> <20220613115712.2831386-2-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220613115712.2831386-2-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jun 2022 10:48:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTq4P33P3MOim1USzQ7MFn_bGAkzf13CHN=VyMPsn3pA@mail.gmail.com>
Message-ID: <CAMuHMdVTq4P33P3MOim1USzQ7MFn_bGAkzf13CHN=VyMPsn3pA@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shimoda-san,

On Mon, Jun 13, 2022 at 1:57 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe host module.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> @@ -0,0 +1,104 @@
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
> +      - const: snps,dw-pcie
> +
> +  interrupts:
> +    maxItems: 6

The R-Car S4 INTC Interrupt Mapping spreadsheet says there are 7.

    items:
      - description: Other Errors
      - description: DMA Event
      - description: Correctable Error
      - description: Fatal Error
      - description: Non-Fatal Error
      - description: Reception of a ERR message from link partner
      - description: Reception of Vendor

> +  interrupt-names:
> +    items:
> +      - const: msi

Missing:

      - const: dma

> +      - const: err

correctable?

> +      - const: fatal
> +      - const: nonfatal
> +      - const: lp
> +      - const: vndmsg

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
