Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6CC6FEC69
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 09:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbjEKHL4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 11 May 2023 03:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjEKHLz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 03:11:55 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDDC2D51;
        Thu, 11 May 2023 00:11:53 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-55a26b46003so124440107b3.1;
        Thu, 11 May 2023 00:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683789112; x=1686381112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XubI+1BOUm/SMLdlvRJpQb47bFFwKaY8cjy83hRjvc=;
        b=ikZQOsxPeTHNvGfyis2udfksz8hTNJcx+DXDkM7wi8z/pVUthizA10qmIDAe9WXAC1
         flFV72GvvwXvyypbGe3d82gYuZw2zRTlxH7k2rtdWRcjhWr4HURROtMFVqParXZ6Ilt5
         gUDgjtRHczNS3jzhKBQlBtWJmGAS/Y89gkDR+bqNx/tOy+CJE8uSFrj9rTRpehbN9EV5
         pfb4Qi3nuniDT/IcU75Jfq96ZYk0/PoUYbsk5qrniT3AJ72OdJYpiA/BXW1O1NhUlCsg
         4kOp8zj1hEbY9ehh5uVaav6N0U0OHDj0HKqCGZsd/18P0NsJvMUvi6TFZc1SLciAwM8E
         T+XA==
X-Gm-Message-State: AC+VfDzRnXxWo/TwjlFIeLK9fhMKBegqhLKydhdN38jgZDOUpd557hJz
        9gdAW7vuAHs5QjEucWkLWauX0TObbygG3g==
X-Google-Smtp-Source: ACHHUZ6BejJ5wJ5cCWcp1Y7XF7WUJ7upf2iDDwjDWd8jzb6hidJn8OrCcsjod/Ma/LHo36BUd/TCww==
X-Received: by 2002:a81:6587:0:b0:555:cee3:d143 with SMTP id z129-20020a816587000000b00555cee3d143mr20484752ywb.4.1683789112319;
        Thu, 11 May 2023 00:11:52 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id h11-20020a816c0b000000b0054fdc874c8asm4707051ywc.59.2023.05.11.00.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 00:11:51 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-55a26b46003so124439697b3.1;
        Thu, 11 May 2023 00:11:51 -0700 (PDT)
X-Received: by 2002:a81:8843:0:b0:559:cc36:d367 with SMTP id
 y64-20020a818843000000b00559cc36d367mr21260559ywf.6.1683789111034; Thu, 11
 May 2023 00:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230510190252.19030-1-wsa+renesas@sang-engineering.com> <20230510190252.19030-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230510190252.19030-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 May 2023 09:11:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXx5gUez8JoWch4A9qVCfobWG1bO==UXTfvGHryP2y9dg@mail.gmail.com>
Message-ID: <CAMuHMdXx5gUez8JoWch4A9qVCfobWG1bO==UXTfvGHryP2y9dg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: rcar-host: add support for optional regulators
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Wolfram,

On Wed, May 10, 2023 at 9:06 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The KingFisher board has regulators. They just need to be en-/disabled,
> so we can leave the handling to devm. Order variables in reverse-xmas
> while we are here.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Changes since v1:
>
> * use unsigned int for i
> * use reverse-xmas for variable declaration
> * really bail out now on error

Thanks for the update!

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c

> @@ -992,6 +999,15 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>         pcie->dev = dev;
>         platform_set_drvdata(pdev, host);
>
> +       for (i = 0; i < ARRAY_SIZE(rcar_pcie_supplies); i++) {
> +               err = devm_regulator_get_enable_optional(dev, rcar_pcie_supplies[i]);
> +               if (err < 0 && err != -ENODEV) {
> +                       dev_err_probe(dev, err, "error enabling regulator %s\n",
> +                                     rcar_pcie_supplies[i]);
> +                       return err;

dev_err_probe() was designed for daisy-chaining, so please use

    return dev_err_probe(...);

instead.

> +               }
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
