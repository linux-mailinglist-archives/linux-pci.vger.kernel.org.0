Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12160629E33
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 16:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiKOP4Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 10:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiKOP4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 10:56:24 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA092CE0A;
        Tue, 15 Nov 2022 07:56:24 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id e15so8974792qts.1;
        Tue, 15 Nov 2022 07:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H013QBKjRovKMY+J7sz4b+GT3yfcFXzKqi34BAfCqyI=;
        b=dLqj0zeDnOpbSJUgLCfH9nDX8IH+iD54WrkNsglQ5M5ZKK7XxfiuZmM0x7gFCf2qLl
         VcOydFOEco+LCbuPn9qPWPpzSoSFBvCHGb43ejOpTZoPFahFT5pf2YEyUkDu4H3FCDNl
         x0o9O77uJ6PhxhiRk6cgZL6m4pTDMu/4btk1UzSm1/4DsnzhNLaicrby5X1s9UB3X0gk
         HkwVFWqBEpgqYnp8HBVGV8sPzDEcw6tQxyKMzz9fEusdZZ/XD3AVmVol21Wd142lZCw3
         nOvJj78tt9uNwVwu3OJJr88VHK0ZSMPboPyod6FpNLFMTi2BTY8AEpx3VHqE9XLE5kBG
         ZWTg==
X-Gm-Message-State: ANoB5pkijuqxPqFUEM3BMjmNkC9/JuUW3YjkUyYxNTzJ/RF4YRH+xEB0
        pogIg3LsEa7zMqXY10jvQe/JlGG3nw5S+w==
X-Google-Smtp-Source: AA0mqf6lkCIgqqSF0MMgnQ+V9B+43oZ+zCgacNhL7a0gLqEmg3SrAqnl/GNWFZeVbb0UNz/mGPtc1w==
X-Received: by 2002:a05:622a:4ccc:b0:3a5:9370:ccf4 with SMTP id fa12-20020a05622a4ccc00b003a59370ccf4mr16769589qtb.376.1668527783115;
        Tue, 15 Nov 2022 07:56:23 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id t19-20020ac865d3000000b003a527d29a41sm7299870qto.75.2022.11.15.07.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 07:56:22 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id i131so17496350ybc.9;
        Tue, 15 Nov 2022 07:56:22 -0800 (PST)
X-Received: by 2002:a25:18c5:0:b0:6de:6183:c5c3 with SMTP id
 188-20020a2518c5000000b006de6183c5c3mr17442157yby.89.1668527781626; Tue, 15
 Nov 2022 07:56:21 -0800 (PST)
MIME-Version: 1.0
References: <20221025191339.667614-1-helgaas@kernel.org> <20221025191339.667614-3-helgaas@kernel.org>
In-Reply-To: <20221025191339.667614-3-helgaas@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Nov 2022 16:56:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVnJZGqwnC0fZTwyb1GT5Nu+4K9LND4CXU96cvYG+qEgg@mail.gmail.com>
Message-ID: <CAMuHMdVnJZGqwnC0fZTwyb1GT5Nu+4K9LND4CXU96cvYG+qEgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Drop controller CONFIG_OF dependencies
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Tue, Oct 25, 2022 at 9:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Many drivers depend on OF interfaces, so they won't be functional if
> CONFIG_OF is not set.  But OF provides stub functions in that case, so drop
> the OF dependencies so we can at least compile-test the drivers.
>
> This means we can compile-test the following drivers even without CONFIG_OF
> enabled (many still require either CONFIG_COMPILE_TEST or the relevant
> arch):
>
>   aardvark
>   al
>   apple
>   brcmstb
>   cadence-host
>   cadence-platform-host
>   cadence-ep
>   dra7xx-host
>   dra7xx-ep
>   dw-rockchip
>   ftpci100
>   hisi
>   intel-gw
>   ixp4xx
>   j721e-host
>   j721e-ep
>   kirin
>   layerscape-host
>   layerscape-ep
>   mediatek
>   microchip-host
>   mobiveil
>   mvebu
>   qcom-host
>   qcom-ep
>   rockchip-host
>   rockchip-ep
>   rockchip-dwc
>   pci-host-generic
>   uniphier-host
>   uniphier-ep
>   v3-semi
>   xilinx
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks for your patch, which is now commit 51dfb612ab3becf9 ("PCI: Drop
controller CONFIG_OF dependencies") in pci/next.

> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -8,7 +8,6 @@ config PCI_MVEBU
>         depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
>         depends on MVEBU_MBUS
>         depends on ARM
> -       depends on OF

This is exactly why we have the COMPILE_TEST symbol.
There is no point in bothering all users who configure kernels with
questions about drivers that won't function anyway due to missing
dependencies, unless the user explicitly wants to do compile-testing.

So all of these should become:

    depends on OF || COMPILE_TEST

>         select PCI_BRIDGE_EMUL
>         help
>          Add support for Marvell EBU PCIe controller. This PCIe controller

> @@ -98,7 +94,6 @@ config PCI_HOST_GENERIC
>
>  config PCIE_XILINX
>         bool "Xilinx AXI PCIe host bridge support"
> -       depends on OF || COMPILE_TEST

This one was fine.

>         depends on PCI_MSI_IRQ_DOMAIN
>         help
>           Say 'Y' here if you want kernel to support the Xilinx AXI PCIe

Thanks in advance for reverting or fixing!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
