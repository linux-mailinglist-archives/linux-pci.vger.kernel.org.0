Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD3F669252
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 10:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbjAMJIy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 04:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbjAMJIR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 04:08:17 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132482BF8;
        Fri, 13 Jan 2023 01:06:04 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id t7so14460366qvv.3;
        Fri, 13 Jan 2023 01:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rncbaboE5XuNcJEvccSGF4MtmLPzXXPeFYp7DWNYN24=;
        b=Bmwaxm1IT3RQiV0lUIpcCOUMk73Ot1zpdfca+Fx5eTJfJCz7ffXnSw1IXK4O1Sd2G3
         pSGDj+f8kRcn/BzoA3hlLLJFcotKeZSt8VJdGQJaXqbkX8xKMSIsE1GjNgnDf+lsOYLQ
         RzW/vZV4axE73Deq+o3fKdEd+qdb9PenSZY/LXbwa20E4WA8NCi/kE/hIIo2pBO9qTv8
         9amUVOxJcwzeGK0jwUTJuvxyRcCvHOq5GPlKMQIx/FI6yEvRD+2VQ8NFXqCDEUgHPJF3
         s4IHzOdjd09TsDmxAUr7ixE7o1pasCZSB9tps5yQeHTBI/DCAiTjjnDy3P3+G8kWRngU
         nCXQ==
X-Gm-Message-State: AFqh2kpmR3Bg+22rKByUr17rcg+sPsFIdwqXA0OOWasS0tO86E14PsZg
        Z6pd+QVA6XYyeD9q9QE94lxREKOhiOQ/Bw==
X-Google-Smtp-Source: AMrXdXtg7/52GUOJylfV8MsFvnvn5ynIQwHrMPceW6UKz0p7aBtC6K2qnkyElhmDyyTXgNpdFmogBQ==
X-Received: by 2002:a0c:fd87:0:b0:531:bfb3:7eeb with SMTP id p7-20020a0cfd87000000b00531bfb37eebmr12617880qvr.11.1673600722027;
        Fri, 13 Jan 2023 01:05:22 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id de19-20020a05620a371300b006fa16fe93bbsm12411011qkb.15.2023.01.13.01.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 01:05:21 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-4a263c4ddbaso276305977b3.0;
        Fri, 13 Jan 2023 01:05:21 -0800 (PST)
X-Received: by 2002:a81:91cc:0:b0:48d:1334:6e38 with SMTP id
 i195-20020a8191cc000000b0048d13346e38mr494160ywg.316.1673600721025; Fri, 13
 Jan 2023 01:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20230113084516.31888-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230113084516.31888-1-lukas.bulwahn@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Jan 2023 10:05:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX_TPgXO2KYNdD5rRzuE9m6_JxfW-otWzw7r7Wptq_rOQ@mail.gmail.com>
Message-ID: <CAMuHMdX_TPgXO2KYNdD5rRzuE9m6_JxfW-otWzw7r7Wptq_rOQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: avoid defines prefixed with CONFIG
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

On Fri, Jan 13, 2023 at 9:52 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> Defines prefixed with "CONFIG" should be limited to proper Kconfig options,
> that are introduced in a Kconfig file.
>
> Here, a definition for a bitmask to configure the SEND_ENABLE mode is named
> CONFIG_SEND_ENABLE.
>
> Rename this local definition to CONFIGURE_SEND_ENABLE to avoid defines
> prefixed with "CONFIG".
>
> No functional change.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for your patch!

> --- a/drivers/pci/controller/pcie-rcar.h
> +++ b/drivers/pci/controller/pcie-rcar.h
> @@ -11,7 +11,7 @@
>
>  #define PCIECAR                        0x000010
>  #define PCIECCTLR              0x000018
> -#define  CONFIG_SEND_ENABLE    BIT(31)
> +#define  CONFIGURE_SEND_ENABLE BIT(31)

The R-Car Gen3 rev. 2.30 Hardware User's Manual calls the bit "CCIE".

Hence if I would have written the driver, I would have used

    #define PCIECCTLR_CCIE     BIT(31)   /* Configuration Send Enable */

>  #define  TYPE0                 (0 << 8)
>  #define  TYPE1                 BIT(8)
>  #define PCIECDR                        0x000020

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
