Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3150651446E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 10:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355853AbiD2IoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 04:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351519AbiD2IoM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 04:44:12 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D71413D3A;
        Fri, 29 Apr 2022 01:40:54 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id iy15so4887731qvb.9;
        Fri, 29 Apr 2022 01:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PU2E/5Le16HvKvo3vnDhr9+ZWyGs78k0Vi+3+IQcDE=;
        b=eaAUtLUjPFE2STKx7ZhLb6/eS1097oBNSPl4MXmE1V2wZuhXneJteToOY7GbfgQfPg
         qYUL4iOdoicrNbSRvf5qlJYl0tzbHdAeEfKfFLWrZ9WB+R59jZQbKZCfEn5h+x8llvIS
         O1/XUBBTppS5kgCV0IG5K5Qwx7GIqBoomNPTpOFTZTmI52o14gSyIWCw24kSdsuOErzK
         ehJKOBnK/xUxVQpDXGX34tfu4fD2ljqW+oWmHH0bYZFoveKoIO8vJLmby0l18BJPQ33M
         0HnLeCsguohAtyi4QaNTOufAGvC9H6BEaYCYdxGUqdJgA6j1+k4oupeJELmKBaa9EbsH
         GkdQ==
X-Gm-Message-State: AOAM530VpEtMIGf5wt1XH5CceRIpT/8/QI9TUVbbxZuEitNruty1iK54
        n5KxWIz5E+t+SWpFvhyH9183Ujh7v2YwDyvn
X-Google-Smtp-Source: ABdhPJxu5qZhhLiXLa2ceKikCxhKfKd2hqL/bD9x0Zr40/7nCCOn1BCmPNQifyuAfu/0/IZVTPLhIw==
X-Received: by 2002:a05:6214:5187:b0:456:4067:409c with SMTP id kl7-20020a056214518700b004564067409cmr15102334qvb.121.1651221653058;
        Fri, 29 Apr 2022 01:40:53 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id y189-20020a37afc6000000b0069ede17247csm1151010qke.86.2022.04.29.01.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 01:40:51 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id j2so13360554ybu.0;
        Fri, 29 Apr 2022 01:40:51 -0700 (PDT)
X-Received: by 2002:a25:3492:0:b0:645:6f78:b3b4 with SMTP id
 b140-20020a253492000000b006456f78b3b4mr36206142yba.546.1651221651100; Fri, 29
 Apr 2022 01:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220428151630.586009-1-herve.codina@bootlin.com> <20220428151630.586009-5-herve.codina@bootlin.com>
In-Reply-To: <20220428151630.586009-5-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Apr 2022 10:40:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVHxyQHc3SnXxqQ1WDcJ-6q_ccA4xAVKjAJ=amXk14UeA@mail.gmail.com>
Message-ID: <CAMuHMdVHxyQHc3SnXxqQ1WDcJ-6q_ccA4xAVKjAJ=amXk14UeA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] ARM: dts: r9a06g032: Add internal PCI bridge node
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 28, 2022 at 5:16 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Add the device node for the r9a06g032 internal PCI bridge device.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -93,6 +93,35 @@ sysctrl: system-controller@4000c000 {
>                         clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
>                 };
>
> +               pci_usb: pci@40030000 {
> +                       compatible = "renesas,pci-r9a06g032", "renesas,pci-rzn1";
> +                       device_type = "pci";
> +                       clocks = <&sysctrl R9A06G032_HCLK_USBH>,
> +                                <&sysctrl R9A06G032_HCLK_USBPM>,
> +                                <&sysctrl R9A06G032_CLK_PCI_USB>;
> +                       clock-names = "usb_hclkh", "usb_hclkpm", "usb_pciclk";

With the "usb_" prefixes removed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
