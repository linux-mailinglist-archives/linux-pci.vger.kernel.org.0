Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68F56FD81D
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 09:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbjEJH2H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 10 May 2023 03:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjEJH2A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 03:28:00 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEE77685;
        Wed, 10 May 2023 00:27:59 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-55aa1da9d4aso123011427b3.2;
        Wed, 10 May 2023 00:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683703678; x=1686295678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/M4kBUQ3T71VECB9ErMGjXnIVkB1Yfzf0h7hxHFNps=;
        b=blE96rx1QifM9syqNe7EpWFVYV4LG8z9NHEuPR2xuMrm7QJBBoTpxV6TpZ5lttGrLa
         eq/8AU3LJKnAtHEcfSZyeyIcmNJApSXBMAJXMbpgjjhXNGIufgnY89DfMTVuYXe/7UBR
         ajMjae5p46inKTAcTmRpAzOo3tjEt3r2XEh8TTM24XHcbxHMOzykdHgCwg3wv9dYpDip
         FrCp0hUBUQHb3Flx/OWh1ihUtFHkXCMppafimgD6nYiV2pIYVoNNm0SzVDsoEeSbrKWj
         p0dW5WD46hgxo2BgAcH5XswoxFYZ9+cuXKKUNDPyc3snmTCAV9Rswys3zV4rAeqhlcL8
         qdlw==
X-Gm-Message-State: AC+VfDxo4GuJdhHEiyuRxTA9nvTfIpVBj+mlRvolJDcFB5Xybp9m/8zx
        DMBK2MBiNinFYZSP782KMwfetu4OTinwvw==
X-Google-Smtp-Source: ACHHUZ5JnMefCibY/HE/Hy3rWSTd9jmQve5j9uQ9uqfFULkt7vvfv7yfj1Xd3Q7BS2fbMDyXQoGJkA==
X-Received: by 2002:a81:bf52:0:b0:559:f0ef:aac0 with SMTP id s18-20020a81bf52000000b00559f0efaac0mr17717074ywk.30.1683703677952;
        Wed, 10 May 2023 00:27:57 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id x8-20020a814a08000000b0054f56baf3f2sm3665267ywa.122.2023.05.10.00.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:27:57 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-55a00da4e53so123092807b3.0;
        Wed, 10 May 2023 00:27:57 -0700 (PDT)
X-Received: by 2002:a81:5b54:0:b0:559:f52b:7c5f with SMTP id
 p81-20020a815b54000000b00559f52b7c5fmr17815046ywb.17.1683703677625; Wed, 10
 May 2023 00:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230510065819.3987-1-wsa+renesas@sang-engineering.com> <20230510065819.3987-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230510065819.3987-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 May 2023 09:27:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVHydQUBD6+zyLneuczd-3ixFbcF5z0toxZmhePT+ShSw@mail.gmail.com>
Message-ID: <CAMuHMdVHydQUBD6+zyLneuczd-3ixFbcF5z0toxZmhePT+ShSw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: rcar-host: add support for optional regulators
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Wolfram,

On Wed, May 10, 2023 at 8:59 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The KingFisher board has regulators. They just need to be en-/disabled,
> so we can leave the handling to devm.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Changes since RFC:
> * add 12v regulator
> * add comment about the order of enabling the regulators
> * use a for-loop to iterate over the regulators

Thanks for the update!

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -29,6 +29,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>
>  #include "pcie-rcar.h"
>
> @@ -974,13 +975,18 @@ static const struct of_device_id rcar_pcie_of_match[] = {
>         {},
>  };
>
> +/* Design note 346 from Linear Technology says order is not important */
> +static const char * const rcar_pcie_supplies[] = {
> +       "vpcie12v", "vpcie3v3", "vpcie1v5"
> +};
> +
>  static int rcar_pcie_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct rcar_pcie_host *host;
>         struct rcar_pcie *pcie;
>         u32 data;
> -       int err;
> +       int i, err;

unsigned int i?

>         struct pci_host_bridge *bridge;

The (lack of) reverse-Xmas-tree ordering is hurting my OCD, but that's
not your fault...

> @@ -992,6 +998,13 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>         pcie->dev = dev;
>         platform_set_drvdata(pdev, host);
>
> +       for (i = 0; i < ARRAY_SIZE(rcar_pcie_supplies); i++) {
> +               err = devm_regulator_get_enable_optional(dev, rcar_pcie_supplies[i]);
> +               if (err < 0 && err != -ENODEV)
> +                       dev_err_probe(dev, err, "error enabling regulator %s\n",
> +                                     rcar_pcie_supplies[i]);

Shouldn't this return, and propagate the error code upstream?

> +       }
> +
>         pm_runtime_enable(pcie->dev);
>         err = pm_runtime_get_sync(pcie->dev);
>         if (err < 0) {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
