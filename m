Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361105BE165
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 11:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiITJHs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 05:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiITJHY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 05:07:24 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846436D9EA;
        Tue, 20 Sep 2022 02:05:20 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-12803ac8113so3255045fac.8;
        Tue, 20 Sep 2022 02:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gd/npqLKLd3AnTSH/+RFKBsH5iJOqAjM5MsAjYDhe+E=;
        b=fnnscz7VljZQXX4AixFOtwmwMOrI/KAwQLCKpiQh8OhcYn5izhpN9Zvsty/7viGJOr
         vhXpc+UbScB838RJc351Feaq3UtMF1UHspCiIGfe/TDn/FA5s92Sp1cFpa8LaKJm7yaI
         vKG5ZmYckBkv6lEw5lBv95dMaUZxEwcEMHe7RqlbBiPO2UtNDk/QKUN4QHTnKgJATcbt
         +DhU/ZhBfRtntbS1kAL7iC2fJA5GLoy1KZf8lAehqEK0anz7sX3FFwMsm9CV6Pr8oP9P
         iBfH6d3/ltRzOdhPV46jhSeUIlFVsCjBeZHa8gEUj1+B9lmFPIXWtoG85XbL93JTU8U1
         WUFA==
X-Gm-Message-State: ACrzQf0yjvF9W0GHrSqggifXSOnqB3CNLCUnos4+2aje5k16BEjmcQ3l
        gJWMqILQC5oFQMQa0P6YeMTGjDd6BCOrgw==
X-Google-Smtp-Source: AMsMyM7QLzvaKy5B9ZvgsD8MrO3Uf4lxdYxGoNsNfAzFQTpSDv2Ia8WjBbfwzQiHNJHP4DS1zqqiZQ==
X-Received: by 2002:a05:6870:f20b:b0:12d:29e4:df2e with SMTP id t11-20020a056870f20b00b0012d29e4df2emr1542655oao.262.1663664719430;
        Tue, 20 Sep 2022 02:05:19 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b00118281a1227sm679779oab.39.2022.09.20.02.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 02:05:19 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so1279933otu.7;
        Tue, 20 Sep 2022 02:05:19 -0700 (PDT)
X-Received: by 2002:a0d:dd09:0:b0:344:fca5:9b44 with SMTP id
 g9-20020a0ddd09000000b00344fca59b44mr18154946ywe.358.1663664299984; Tue, 20
 Sep 2022 01:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220503211954.1428919-1-frowand.list@gmail.com>
 <CAMuHMdWhn8cY4usyqao-osEcSCcmkU+NYg21co+GxVfvg5+dhw@mail.gmail.com> <725f870b-b927-352d-85ab-675b91b7c75a@gmail.com>
In-Reply-To: <725f870b-b927-352d-85ab-675b91b7c75a@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Sep 2022 10:58:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX52_pnJPDuYoqOxwxsiC_+Zecg4kyWU94zAg1NRYHyDQ@mail.gmail.com>
Message-ID: <CAMuHMdX52_pnJPDuYoqOxwxsiC_+Zecg4kyWU94zAg1NRYHyDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] of: overlay: rename overlay source files from .dts
 to .dtso
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

Pity you couldn't make it to Dublin. We've been missing you!

On Tue, Jul 19, 2022 at 1:44 AM Frank Rowand <frowand.list@gmail.com> wrote:
> On 7/7/22 02:21, Geert Uytterhoeven wrote:
> > On Tue, May 3, 2022 at 11:20 PM <frowand.list@gmail.com> wrote:
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> In drivers/of/unittest-data/:
> >>    - Rename .dts overlay source files to use .dtso suffix.
> >>    - Add Makefile rule to build .dtbo.o assembly file from overlay
> >>      .dtso source file.
> >>    - Update Makefile to build .dtbo.o objects instead of .dtb.o from
> >>      unittest overlay source files.
> >>
> >> Modify driver/of/unitest.c to use .dtbo.o based symbols instead of
> >> .dtb.o
> >>
> >> Modify scripts/Makefile.lib %.dtbo rule to depend upon %.dtso instead
> >> of %.dts
> >>
> >> Rename .dts overlay source files to use .dtso suffix in:
> >>    arch/arm64/boot/dts/freescale/
> >>    arch/arm64/boot/dts/xilinx/
> >>
> >> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >
> > What is the status of this work?
> > Thanks!
>
> I'll work on this tomorrow after I test your overlay improvement patches.

Any updates? We're again at rc6.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
