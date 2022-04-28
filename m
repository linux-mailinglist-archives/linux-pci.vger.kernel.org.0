Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E1A513095
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 12:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiD1KFf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 28 Apr 2022 06:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiD1KFJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 06:05:09 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6B66A404;
        Thu, 28 Apr 2022 02:50:35 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id bz24so3029477qtb.2;
        Thu, 28 Apr 2022 02:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LWvtmkIwZsmHohGNhyLUaGl2hkjSPDsamW5Yc84+fGI=;
        b=PBu0sbZ8agiajAR3ioM2Tv34f1Zrp665lbWusaIBDpVaBVvMI81KpavBnvpSjlbYCe
         5LiLIHkq86mhvEUag/RXnbWPQD4/mlh6DH0r9UH+JiCWOt8zLoLtrX9JaY1R4LdR8T0N
         i2q7LO/40dWeiKWCNm4i0nPsIgoKCEB8QQStmp7awIRlPdp580cOMH/68EhkOv/30DjE
         L/bJssrUa//o5fHSaomOFDTbPjgaXfsnK4FZdAWqa3UPrnrAIH9kYpU+a8nk1ZckFxBA
         0pzdUA8K57u7zHjr35/dKJ26TRTyh9NviDtUA7EhoFHRI8VbUYfAmbKVjgQxxcnCEZf4
         XSJQ==
X-Gm-Message-State: AOAM533LZHjILTrjqMbqvo+Z7WZRZ1GoOH8XfNb8rXPI9nz9v51kTH32
        +hZk8dKqKIwzu44jntUTvp+p9GE/ljs+jA==
X-Google-Smtp-Source: ABdhPJyzeNlwp5FyLinjqqA9yyceyyAAwfUmIYs8Z6GjGAzNVqSvcsB0T3qjvGStABjBQmUJ65F1rQ==
X-Received: by 2002:a05:622a:548:b0:2f3:61ee:781d with SMTP id m8-20020a05622a054800b002f361ee781dmr17134621qtx.373.1651139433887;
        Thu, 28 Apr 2022 02:50:33 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id z8-20020ac87f88000000b002e1cecad0e4sm11543380qtj.33.2022.04.28.02.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:50:33 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id y76so8050359ybe.1;
        Thu, 28 Apr 2022 02:50:33 -0700 (PDT)
X-Received: by 2002:a25:8087:0:b0:641:dd06:577d with SMTP id
 n7-20020a258087000000b00641dd06577dmr29581386ybk.207.1651139432762; Thu, 28
 Apr 2022 02:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120850.769480-1-herve.codina@bootlin.com>
 <20220422120850.769480-7-herve.codina@bootlin.com> <CAMuHMdWfbbQ64CipqoVPEOGhE08HYckhyOaeSi+V7ar+F45PMw@mail.gmail.com>
In-Reply-To: <CAMuHMdWfbbQ64CipqoVPEOGhE08HYckhyOaeSi+V7ar+F45PMw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Apr 2022 11:50:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_CwsmzOHBi0TVBR7KOSqW0tY5=94betF_B40gkHoYxQ@mail.gmail.com>
Message-ID: <CAMuHMdX_CwsmzOHBi0TVBR7KOSqW0tY5=94betF_B40gkHoYxQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hervé,

On Thu, Apr 28, 2022 at 11:49 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > @@ -212,6 +212,35 @@ gic: interrupt-controller@44101000 {
> >                         interrupts =
> >                                 <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> >                 };
> > +
> > +               pci_usb: pci@40030000 {

Please preserve sort order (by unit address).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
