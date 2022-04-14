Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7471500C62
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 13:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239489AbiDNLvE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 14 Apr 2022 07:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiDNLvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 07:51:01 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9125B6E55C;
        Thu, 14 Apr 2022 04:48:36 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id s6so3339571qta.1;
        Thu, 14 Apr 2022 04:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u1n9GOW0yI2Xuk8uj5WutPFnUGPTBI0EWcn0eDo3zKI=;
        b=4cWtk7WDrXtMx1JyYIuu65cF0EAkHh5dnddCcaJo7Z5A0YQb0QZVY91yABedymVPfk
         nFhRuK882Lp7iWDQ31IRxMZl9lPk8zfNxgjBnW1tfi+RYO9WNHVHFKkGYrb6bKUcpJpB
         PPi9tw+6i0O4PU3PW6Dzz7e0Fm6X9IbpI2sDaHhgF4wIQDORQKE8O0OK3LKHg20Weccb
         qDNJ08TXCfQUFzk3dYMmCO/aUgEGTupIrJ5KRmIqwlHORhczTZ0ay+1GPmGJuYY8AeVQ
         EC8jMbuED89XdiwCMtczJLNc6iRcW/W84haHYlZa+6DVnfZtxBKYmJdonjpUxC2iIzEu
         E6KA==
X-Gm-Message-State: AOAM5330TzT5VpFbivc96Pl2yCOCNPbtm/oQSIxEiryU/x9J2qiCjk/I
        XucmtqykbUwUlkgL+pJGREnsVS+PSBn6iA==
X-Google-Smtp-Source: ABdhPJz3kQMm7DHNw3fwdn/MIQDSdanb61P6+K6dJ3Cwlw1ivA1XR7XRtjhjiqre+jDKUCZ09pbg9A==
X-Received: by 2002:a05:622a:1f8c:b0:2ef:9ec3:e176 with SMTP id cb12-20020a05622a1f8c00b002ef9ec3e176mr1345650qtb.39.1649936915392;
        Thu, 14 Apr 2022 04:48:35 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 64-20020a370743000000b0069a0cb6e4d5sm849676qkh.81.2022.04.14.04.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 04:48:34 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2ebebe631ccso52425077b3.4;
        Thu, 14 Apr 2022 04:48:34 -0700 (PDT)
X-Received: by 2002:a81:413:0:b0:2ec:31d7:7e60 with SMTP id
 19-20020a810413000000b002ec31d77e60mr1650211ywe.62.1649936914141; Thu, 14 Apr
 2022 04:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220414074011.500533-1-herve.codina@bootlin.com>
 <20220414074011.500533-2-herve.codina@bootlin.com> <CAMuHMdW8q5AjDtTE83yVPfmgnQy02UgLSns33z06WMFBUULWEw@mail.gmail.com>
 <20220414132534.35467781@bootlin.com>
In-Reply-To: <20220414132534.35467781@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 13:48:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUCvJ6rAwnV=w9iFqnm=c0U_BpGiYEw109shsrWAeUJCA@mail.gmail.com>
Message-ID: <CAMuHMdUCvJ6rAwnV=w9iFqnm=c0U_BpGiYEw109shsrWAeUJCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] PCI: rcar-gen2: Add support for clocks
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hervé,

On Thu, Apr 14, 2022 at 1:29 PM Herve Codina <herve.codina@bootlin.com> wrote:
> On Thu, 14 Apr 2022 10:45:54 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Apr 14, 2022 at 9:40 AM Herve Codina <herve.codina@bootlin.com> wrote:
> > > The PCI rcar-gen2 does not call any clk_prepare_enable().
> >
> > Correct, this driver manages the clocks indirectly through Runtime PM.
> >
> > > This lead to an access failure when the driver tries to access
> > > the IP (at least on a RZ/N1D platform).
> >
> > I expect adding
> >
> >     power-domans = <&sysctrl>;
> >
> > to the pci_usb node makes this patch redundant.
>
> Seems not enough.
> I tried what you suggest :
>  - Added 'power-domains = <&systrl>;' to the pci_usb node
>  - Added missing '#power-domain-cells = <0>;' to sysctrl node
>  - Reverted my patch.
>
> The system crashed at boot:

> [    0.832958] Unhandled fault: external abort on non-linefetch (0x1008) at 0x90b5f848

That's indeed a typical symptom of accessing a module's registers
while the module's clock is disabled.

> I also added a trace printk in r9a06g032-clocks.c and
> r9a06g032_attach_dev() was never called.
>
> Did I miss to set something ?

Do you have CONFIG_PM and CONFIG_PM_GENERIC_DOMAINS
enabled?
Apparently ARCH_RZN1 does not select these options yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
