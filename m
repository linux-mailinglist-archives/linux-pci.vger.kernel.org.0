Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9408E6FB1F1
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 15:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjEHNpk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 8 May 2023 09:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjEHNpi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 09:45:38 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB39348B9;
        Mon,  8 May 2023 06:45:34 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-55a6efe95c9so66378117b3.1;
        Mon, 08 May 2023 06:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683553533; x=1686145533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/+FqXMV4ArCmDq7qgtI4IzpiR25k00ePFNuL3jyw0o=;
        b=QWtmwA20Am7zvIGRO/JfsueTYEN4Sli9cBNjtPMv9gzbEIcf/vBR6iDJdnDwsNynUx
         6WgcRkI7ZDVztWUUVdtJtxR1cRZ2F/Rhcl+iddQ65YHZPldxdwNf4rQBQ4ltLgfEH4+R
         /iMe/c/Hxa3+91u1+4CPIVIvjYgDiQEcJuO2yQU+JQczcIp/uTzkFgh5wdUlwLkd1dy6
         c2A6P6xfawMeAlmscl4BnsboL+q1EcuLxaX7zz8RkOVCml/QAYqzvI/rj9DByB3m01Uv
         Atl+DvL4JPKcQkQYQino1Mddx6tFDjfQ97LV1+xQ9y9yRo+iHAxNS9Oi3pwSINqBH9W0
         msXQ==
X-Gm-Message-State: AC+VfDxdkq9rZJW+njyMa/4LcAYac/fObTqE0ykUi5chW/2No7E5kcZB
        5JksUlUGWVMvC4Ge7xP4iOqna0vSAaOUwQ==
X-Google-Smtp-Source: ACHHUZ4jo1o50IJ8sNJ3FRW+umPGnI4yPX9qE8clMvMkRHHBVLC71T1ZUXb5L9j25JEVR7WaRNTI2w==
X-Received: by 2002:a81:75c6:0:b0:55a:7c68:c0f7 with SMTP id q189-20020a8175c6000000b0055a7c68c0f7mr11143007ywc.7.1683553533343;
        Mon, 08 May 2023 06:45:33 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id y205-20020a0dd6d6000000b0055a6f26fbbasm2545359ywd.38.2023.05.08.06.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 06:45:32 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-559e317eef1so66609437b3.0;
        Mon, 08 May 2023 06:45:32 -0700 (PDT)
X-Received: by 2002:a25:d616:0:b0:b9e:6537:4f3f with SMTP id
 n22-20020a25d616000000b00b9e65374f3fmr10430975ybg.61.1683553531815; Mon, 08
 May 2023 06:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230508104557.47889-1-wsa+renesas@sang-engineering.com> <20230508104557.47889-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230508104557.47889-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 May 2023 15:45:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZUTJmrE==zf2OxaBdQGa-zS2VC7hTtcE9aD+MD7JYDQ@mail.gmail.com>
Message-ID: <CAMuHMdUZUTJmrE==zf2OxaBdQGa-zS2VC7hTtcE9aD+MD7JYDQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] PCI: rcar-host: add support for optional regulators
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

On Mon, May 8, 2023 at 12:47 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The KingFisher board has regulators. They just need to be en-/disabled,
> so we can leave the handling to devm.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c

> @@ -992,6 +993,14 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>         pcie->dev = dev;
>         platform_set_drvdata(pdev, host);
>
> +       err = devm_regulator_get_enable_optional(dev, "vpcie3v3");
> +       if (err < 0 && err != -ENODEV)
> +               dev_err_probe(dev, err, "error enabling 3.3V regulator");
> +
> +       err = devm_regulator_get_enable_optional(dev, "vpcie1v5");
> +       if (err < 0 && err != -ENODEV)
> +               dev_err_probe(dev, err, "error enabling 1.5V regulator");

As per my comment on patch 1/3, I think you want to grab
"vpcie12v0-supply", too.
And perhaps factor out the voltage as a parameter in the error message,
to increase string sharing?

I don't know if PCIe specifies some ordering w.r.t. power supply
enablement.

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
