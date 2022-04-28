Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6372513088
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 12:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiD1KDo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 28 Apr 2022 06:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiD1KDH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 06:03:07 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7BDB6469;
        Thu, 28 Apr 2022 02:49:42 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id e128so3167366qkd.7;
        Thu, 28 Apr 2022 02:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WDmfPpadZf0LBFbdDJYdxQ5ahsqbbrqVM35oCxvqkdU=;
        b=QRLIGin6HvtekZfg3fQ0LDqqEBawaEnOLMqRB1OCg/oStzxRH7zX7rr9IT264MyFeR
         /APy8eq4UB0w4WvVoP9G/cTFNjCx5TVzaGY4eJCkuXGpUzhahIcdwYJAMLqiEFZFVw4P
         c+dnz4DWeapZ3mqRDLdRn7wd6t+owcuL9W8oX7W/oHbONYaXpOp4wAErtqOLmObWYRF5
         Q23gGzZHolU5q1j8h5RAqyDCksU8Wv+FpxY+fM0HAeiTV24sBNtN74GbXuDJRWFyO2Kb
         44AID8aObrAPSUY621a9UQ0DsWV9aIpBw6JgSkXWI1Vx0dZsoUr4FDHYZn5wtMpukRN9
         0qTA==
X-Gm-Message-State: AOAM533gZMxvJHzLQ7s9v1d3gIy+rF42EyZIy5vQS8l/VUw1G8ZavwJe
        L80RR7eJRU7UfIJD8hWFmeoWeehWuV4msg==
X-Google-Smtp-Source: ABdhPJzEgp776Kf5FOKXJ1wlPqwsx9CFCvBqF0vZwU9mVicqmEv42VOJUhleQanhAYqWL2PhOfeCHA==
X-Received: by 2002:a05:620a:1981:b0:507:4a52:f310 with SMTP id bm1-20020a05620a198100b005074a52f310mr19186194qkb.611.1651139381708;
        Thu, 28 Apr 2022 02:49:41 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id r83-20020a37a856000000b0069ed4436a49sm9458658qke.87.2022.04.28.02.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:49:41 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2f7ca2ce255so46509367b3.7;
        Thu, 28 Apr 2022 02:49:41 -0700 (PDT)
X-Received: by 2002:a81:1cd5:0:b0:2f4:c3fc:2174 with SMTP id
 c204-20020a811cd5000000b002f4c3fc2174mr32391381ywc.512.1651139380892; Thu, 28
 Apr 2022 02:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120850.769480-1-herve.codina@bootlin.com> <20220422120850.769480-7-herve.codina@bootlin.com>
In-Reply-To: <20220422120850.769480-7-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Apr 2022 11:49:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWfbbQ64CipqoVPEOGhE08HYckhyOaeSi+V7ar+F45PMw@mail.gmail.com>
Message-ID: <CAMuHMdWfbbQ64CipqoVPEOGhE08HYckhyOaeSi+V7ar+F45PMw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] ARM: dts: r9a06g032: Add internal PCI bridge node
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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

Hi Hervé

On Fri, Apr 22, 2022 at 2:09 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Add the device node for the r9a06g032 internal PCI bridge device.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -212,6 +212,35 @@ gic: interrupt-controller@44101000 {
>                         interrupts =
>                                 <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
>                 };
> +
> +               pci_usb: pci@40030000 {
> +                       compatible = "renesas,pci-r9a06g032", "renesas,pci-rzn1";
> +                       device_type = "pci";
> +                       clocks = <&sysctrl R9A06G032_HCLK_USBH>,
> +                                <&sysctrl R9A06G032_HCLK_USBPM>,
> +                                <&sysctrl R9A06G032_CLK_PCI_USB>;
> +                       clock-names = "hclk_usbh", "hclk_usbpm", "clk_pci_usb";

The clock names need an update, cfr. my comment on the bindings.

The rest LGTM, so with the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
