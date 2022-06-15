Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB554C3FB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 10:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242415AbiFOIvA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 04:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiFOIu6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 04:50:58 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B80149CA5;
        Wed, 15 Jun 2022 01:50:58 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id ea7so8341326qvb.12;
        Wed, 15 Jun 2022 01:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CIBiR4jrDrPevxdBVk6nnP7DsfrY0XtCDJOY2IoBbqc=;
        b=fM22/fHuL6a4WM6x0p8XIJGSCWnF/RSdAxd6RFcP9LE/mUf2D8aFFbXWDteQVaml1U
         eS8e4zEsDI9XUxkFnPvZuFugaeupvkE81dwo4QEoxXyCS4dY0TyGR0avgYheEwDZR99M
         WBPs9O3AUd0PTQIQnXAUSOu6r9UI7JGUud/JmdKWEPOzkbCdEE/HKjBW7J9fzCkaie/F
         9cAffaByA1Gd0zBTAih/ffUvBsxMH+RF0340zs1j2T5vrayMOWS2ric89hbxPDLeKgTt
         QxSEHOWhp5dFwkdX04z7NUgAXXT6zu+6JyOdJR+3Kf14P/NLdXTumu4vds/KZGbCnGlX
         dFsw==
X-Gm-Message-State: AOAM5307Xkj+e5hkfZor4CDU/FjvMBfIbBwfgH3dsLrCbRbLtb88Wa+m
        cnGtZ+q8LPJYrSQTNnkwqCwm8iX8YhyXcw==
X-Google-Smtp-Source: ABdhPJxHRGW6aCJUQkZnhM8irpVpgJ2uVPNrtivRJhHUEV044J2et9gPsgXxfmLou91dj0ufaLxgWg==
X-Received: by 2002:a05:622a:1354:b0:305:eb:2829 with SMTP id w20-20020a05622a135400b0030500eb2829mr7776414qtk.215.1655283057146;
        Wed, 15 Jun 2022 01:50:57 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id k4-20020a05620a414400b006a743b360bcsm12540874qko.136.2022.06.15.01.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 01:50:56 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-30fdbe7467cso54359827b3.1;
        Wed, 15 Jun 2022 01:50:56 -0700 (PDT)
X-Received: by 2002:a81:6c46:0:b0:315:bb1:6a21 with SMTP id
 h67-20020a816c46000000b003150bb16a21mr5584078ywc.283.1655283056219; Wed, 15
 Jun 2022 01:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com> <20220613115712.2831386-3-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220613115712.2831386-3-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jun 2022 10:50:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVUJmxJDM-5Y3W0fBdBCK_oim8j-=V63DEZk+EgvnZ0vQ@mail.gmail.com>
Message-ID: <CAMuHMdVUJmxJDM-5Y3W0fBdBCK_oim8j-=V63DEZk+EgvnZ0vQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
> PCIe endpoint module.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml

> +  interrupts:
> +    maxItems: 6
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: err
> +      - const: fatal
> +      - const: nonfatal
> +      - const: lp
> +      - const: vndmsg

Same comment as for the host bindings in [PATCH 1/7].

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
