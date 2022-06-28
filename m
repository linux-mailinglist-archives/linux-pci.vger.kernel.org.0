Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3037E55DC05
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245569AbiF1HuW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 03:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245504AbiF1HuV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 03:50:21 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E4010EC;
        Tue, 28 Jun 2022 00:50:21 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id n15so18809527qvh.12;
        Tue, 28 Jun 2022 00:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXC8ZZByExp1UKOmIRpJ2BaYGiGLXHy6ZiWwn5gk6hw=;
        b=XXLJAunFf3MBC9TXVUl4Qgc1PePe6ADKX2YFCItjSInZCXUDGIMwoi3ZQXSw2I8912
         xSZpHhGnnXycP+1ano5qXU3u2K/uxZz1NJ3IMh6tusgRkbIzjnZ6Jrtm7+x6LXbdfkwI
         xuXueZtTa7Ab5cOA/v67Rxv6oXCPG+kQ/hZoO6wTd46GYCdxbivYc94gieN5WfSkjPYY
         uW0C/9+xnGu7NRBfCBSmgj0po9aJqHjnJaqNS5pllpF2K+foJaxhjcjLo87mMb9FYNR6
         LRu9lk/Uc1P7LaofS6mBOIBfxnDzqSb5ATlkmsVR5auwIVJkrhPOX6EP/yh3DuY9fLPr
         g6kA==
X-Gm-Message-State: AJIora/EMaqgSiO/SOekY8MPa5TSsplUfJ8Imcb12YGEdRJeAIqs8l30
        nkq+D6vjKnRt/cMWWyoRKmLaP7ZigcUxPA==
X-Google-Smtp-Source: AGRyM1sN2gYuAW6VtkgXYQKQn5+0oE4QwaN3HqKjJnIFND88OuU6zshDdKmloB77/j2yKuFaAN9c1A==
X-Received: by 2002:ad4:5944:0:b0:470:4083:3962 with SMTP id eo4-20020ad45944000000b0047040833962mr1421246qvb.107.1656402620078;
        Tue, 28 Jun 2022 00:50:20 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id bk32-20020a05620a1a2000b006af1d3e8080sm6328367qkb.85.2022.06.28.00.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 00:50:18 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-317710edb9dso108651157b3.0;
        Tue, 28 Jun 2022 00:50:18 -0700 (PDT)
X-Received: by 2002:a81:74c5:0:b0:31b:ca4b:4bc4 with SMTP id
 p188-20020a8174c5000000b0031bca4b4bc4mr9505996ywc.358.1656402618122; Tue, 28
 Jun 2022 00:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220627122417.809615-1-yoshihiro.shimoda.uh@renesas.com> <20220627122417.809615-11-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220627122417.809615-11-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jun 2022 09:50:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW5M7tLaCg_=+mxybEyRVL=1T6FM-M6xshPM7yvXjjqMA@mail.gmail.com>
Message-ID: <CAMuHMdW5M7tLaCg_=+mxybEyRVL=1T6FM-M6xshPM7yvXjjqMA@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] PCI: renesas: Add R-Car Gen4 PCIe Endpoint support
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shimoda-san,

On Mon, Jun 27, 2022 at 2:24 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> Synopsys DesignWare PCIe.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c

> +static int rcar_gen4_pcie_ep_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct rcar_gen4_pcie *rcar;
> +       int err;
> +
> +       rcar = rcar_gen4_pcie_devm_alloc(dev);
> +       if (!rcar)
> +               return -ENOMEM;
> +
> +       err = rcar_gen4_pcie_pm_runtime_enable(dev);
> +       if (err < 0) {
> +               dev_err(dev, "pm_runtime_get_sync failed\n");

The error message doesn't match the function called
(same for patch 9/13).
As this is abstracted, perhaps "failed to enable Runtime PM"?

> +               return err;
> +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
