Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFAE511FFC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 20:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbiD0PTW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 27 Apr 2022 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239531AbiD0PSp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 11:18:45 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B30E5839E;
        Wed, 27 Apr 2022 08:15:29 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id kc16so352647qvb.7;
        Wed, 27 Apr 2022 08:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7+G8Cf9crq/FmkHAa1hmIN8g6GY3mjT1aMgwO4UslU4=;
        b=b0OW7JAkegRE3wuNJmjgUNjmYa2T/JOjrT9Es9/UJaOFRkSjzVJVy3FIl8zNDWwTpm
         rUDcvQohwfebUgaj4QXQCZQS+ttDU5ppMLed/h+2mAj8bm03/daj4rgnvL99S5J2oumT
         vfmzhOP7Rr8L5LXJEgizeatZwQatn9qUwZ/fmKaQX86/7/LTuLoebJuYv9GdWQAETiC2
         i3jaZxgsUQWxDgdOtAV5JaMqZAVsX8sjjL07nfg1gnt8ij/5vn+C/GDDzhiLnCZBcRAS
         U3evsAP+JHTM7+WVRAQaOurFcT4jf6QMSXChZ0Jbsw5JuLkWyJgh4gi2xilqvihnFvaB
         7r7Q==
X-Gm-Message-State: AOAM530CRuJzMO1K+YNbs0SuCV0sCb9NZarAfdk6TbdWZf0I0WehIyb3
        H+x7iv94FR4vCQ9GCUWIRWbaA3cywhB9pQ==
X-Google-Smtp-Source: ABdhPJwejfgEkKFhJu6j1wrVsqZANMB8i6Kt9hkHG9474jg0usCHPWjYuZWKGELEiSA3LcqVssHKMQ==
X-Received: by 2002:a05:6214:252b:b0:456:3c2b:c910 with SMTP id gg11-20020a056214252b00b004563c2bc910mr9361804qvb.85.1651072528222;
        Wed, 27 Apr 2022 08:15:28 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id m190-20020a378ac7000000b0069f8d810f16sm890605qkd.85.2022.04.27.08.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 08:15:27 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id e12so3920309ybc.11;
        Wed, 27 Apr 2022 08:15:27 -0700 (PDT)
X-Received: by 2002:a25:9e89:0:b0:63c:ad37:a5de with SMTP id
 p9-20020a259e89000000b0063cad37a5demr26199241ybq.342.1651072527257; Wed, 27
 Apr 2022 08:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120850.769480-1-herve.codina@bootlin.com> <20220422120850.769480-3-herve.codina@bootlin.com>
In-Reply-To: <20220422120850.769480-3-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Apr 2022 17:15:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVB2-Sv1AWFr43erOioui0me5A4TfvazKHp9hTF3gJCwg@mail.gmail.com>
Message-ID: <CAMuHMdVB2-Sv1AWFr43erOioui0me5A4TfvazKHp9hTF3gJCwg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hervé,

On Fri, Apr 22, 2022 at 2:09 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Add internal PCI bridge support for the r9a06g032 SOC. The Renesas
> RZ/N1D (R9A06G032) internal PCI bridge is compatible with the one
> present in the R-Car Gen2 family.
> Compared to the R-Car Gen2 family, it needs three clocks instead of
> one.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> +++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> @@ -113,6 +113,37 @@ required:
>    - "#size-cells"
>    - "#interrupt-cells"
>
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
> +        - const: hclk_usbh
> +        - const: hclk_usbpm
> +        - const: clk_pci_usb

These are the provider names.
I think they should use the consumer names: usb_hclkh, usb_hclkpm,
and usb_pciclk.

The rest looks good to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
