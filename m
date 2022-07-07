Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C353569B6F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 09:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiGGHWO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 03:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiGGHWN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 03:22:13 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B960220F78;
        Thu,  7 Jul 2022 00:22:12 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id g14so21551183qto.9;
        Thu, 07 Jul 2022 00:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1iXDcNbNDisdpPgJiiBxrCtccde/88C3HCt64upFyM=;
        b=t/OXhX2QQScnmxe7rDqRQ3LMfnYjiLHqzYZ8Wk6s9yicXq6aBPcDArW2+07tPufqKq
         e2lSXpHg1gE+Z6LVrHosagBDjD8h4VZqpStwOUMbFsf4axDEQzFj5PAB6gOGf49ZD5Kc
         f2ktPCj2QFyIH9fVoGlt6/MAPFdF1diAyXjiU1yha4nDeQtkspN6zZXrnd/a3iTsaQiW
         cxU6UiPEDzIq6Hve+K/02BtIu5TXeUIaZXuPM5PJG7j+iZmQcE3rBZ9BcJVf3V8HG+ht
         mJNjypgH5RB0IDkYoc8GxpufKU3shiz+t4yS6C4a7oLO592JHhAy8KLwTOxBTOxAbKck
         7ZGg==
X-Gm-Message-State: AJIora9rozqiPlBh6+Pb5hnipYd6s9wnEwr8/wVGJaxYW27+8SBSqpp2
        6UyHjJDHFjLpR9V29OVkg7VwY56CHzqWdw==
X-Google-Smtp-Source: AGRyM1sndVlcLk0HOKAS9JmW3XCtkJlILpqb8Cf5JVJZ6gl69VLq1XeVBIvtRoLXix1KZuYQrN9f9Q==
X-Received: by 2002:a05:6214:29c4:b0:472:fb62:3a03 with SMTP id gh4-20020a05621429c400b00472fb623a03mr13639555qvb.93.1657178531815;
        Thu, 07 Jul 2022 00:22:11 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id t2-20020ac85302000000b00317cdc1b15bsm24239422qtn.27.2022.07.07.00.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 00:22:11 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31c89111f23so111474497b3.0;
        Thu, 07 Jul 2022 00:22:11 -0700 (PDT)
X-Received: by 2002:a81:5404:0:b0:31c:c24d:94b0 with SMTP id
 i4-20020a815404000000b0031cc24d94b0mr16256568ywb.502.1657178531209; Thu, 07
 Jul 2022 00:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220503211954.1428919-1-frowand.list@gmail.com>
In-Reply-To: <20220503211954.1428919-1-frowand.list@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Jul 2022 09:21:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhn8cY4usyqao-osEcSCcmkU+NYg21co+GxVfvg5+dhw@mail.gmail.com>
Message-ID: <CAMuHMdWhn8cY4usyqao-osEcSCcmkU+NYg21co+GxVfvg5+dhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] of: overlay: rename overlay source files from .dts
 to .dtso
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

On Tue, May 3, 2022 at 11:20 PM <frowand.list@gmail.com> wrote:
> From: Frank Rowand <frank.rowand@sony.com>
>
> In drivers/of/unittest-data/:
>    - Rename .dts overlay source files to use .dtso suffix.
>    - Add Makefile rule to build .dtbo.o assembly file from overlay
>      .dtso source file.
>    - Update Makefile to build .dtbo.o objects instead of .dtb.o from
>      unittest overlay source files.
>
> Modify driver/of/unitest.c to use .dtbo.o based symbols instead of
> .dtb.o
>
> Modify scripts/Makefile.lib %.dtbo rule to depend upon %.dtso instead
> of %.dts
>
> Rename .dts overlay source files to use .dtso suffix in:
>    arch/arm64/boot/dts/freescale/
>    arch/arm64/boot/dts/xilinx/
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

What is the status of this work?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
