Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6905517DAA
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 08:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiECGzP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 02:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiECGzG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 02:55:06 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A33D18E1E;
        Mon,  2 May 2022 23:51:34 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id v9so2246254qkp.11;
        Mon, 02 May 2022 23:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pr4t1gPb6uklDrXM+exywKisHYkbCy1hPACrniddb9I=;
        b=rjx6ZbeIPjz85RoWHQVqdNk8S4Kg6qG0weXU/9b1PCK5kfm2gErtnirmo4/bcXG5A5
         vhnG7vPUpw/D5Z77up7eXuNevzN2CkmjsHRVFLZQhLKK9VbBtG1ZUkzzYnL3f/yH1Xsm
         6VuGxcE5Dd2c8VNLVokPPuYTo21St55GL7ObC4UWp3ObXbdwRsOC4/WCSdnIK+viDTzh
         +EHkIJ/PyIJZK2bUr7RxXe6JRFlJ87L0r829v0QrxnAz+/pq29obdyzTjv07AE0dmngo
         zP24rGd1jsjnJM+FxniVvkk+mmoceNpdWZnUGM3KG41Zgs557HAG+u5enFyzEhbF+geD
         ufNA==
X-Gm-Message-State: AOAM5301Fm2kfeKbj7Zr9so6tKm5DZdDSL+MIpZeDSnLBPtopTYLhK8B
        IlOPsGMo5oi2thO210gsLVQUUKezJviEVw==
X-Google-Smtp-Source: ABdhPJy5glkxfW3WjzC/QQb5m5JtoZwVxdFfnQ2L1RVxq+rNzeivavGQl34wzQnJANlOWzeEW7ld6A==
X-Received: by 2002:a37:7c8:0:b0:69f:c5f8:85a2 with SMTP id 191-20020a3707c8000000b0069fc5f885a2mr9895845qkh.662.1651560693386;
        Mon, 02 May 2022 23:51:33 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id e12-20020ac845cc000000b002f39b99f6adsm5560386qto.71.2022.05.02.23.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 23:51:32 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2f7d621d1caso169917027b3.11;
        Mon, 02 May 2022 23:51:31 -0700 (PDT)
X-Received: by 2002:a81:9b0c:0:b0:2f4:c522:7d3c with SMTP id
 s12-20020a819b0c000000b002f4c5227d3cmr14127188ywg.316.1651560691618; Mon, 02
 May 2022 23:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220429134143.628428-1-herve.codina@bootlin.com>
 <20220429134143.628428-4-herve.codina@bootlin.com> <29ba3db6-e5c7-06d3-29d9-918ee5b34555@linaro.org>
 <CAMuHMdWN_ni_V+e3QipWH2qKXeNPkEcVpHpb5iBYw1YQSAnCDA@mail.gmail.com> <YnA0id1rXlNHNz+N@robh.at.kernel.org>
In-Reply-To: <YnA0id1rXlNHNz+N@robh.at.kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 May 2022 08:51:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWktaRAw8Y6TR93_rH8v4mPR2yt3wGqeXeTA2p_Dh--wA@mail.gmail.com>
Message-ID: <CAMuHMdWktaRAw8Y6TR93_rH8v4mPR2yt3wGqeXeTA2p_Dh--wA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Mon, May 2, 2022 at 9:44 PM Rob Herring <robh@kernel.org> wrote:
> On Mon, May 02, 2022 at 11:19:19AM +0200, Geert Uytterhoeven wrote:
> > On Sun, May 1, 2022 at 10:51 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > On 29/04/2022 15:41, Herve Codina wrote:
> > > > Add internal PCI bridge support for the r9a06g032 SOC. The Renesas
> > > > RZ/N1D (R9A06G032) internal PCI bridge is compatible with the one
> > > > present in the R-Car Gen2 family.
> > > > Compared to the R-Car Gen2 family, it needs three clocks instead of
> > > > one.
> > > >
> > > > The 'resets' property for the RZ/N1 family is not required since
> > > > there is no reset-controller support yet for the RZ/N1 family.
> > >
> > > This should not be a reason why a property is or is not required. Either
> > > this is required for device operation or not. If it is required, should
> > > be in the bindings. Otherwise what are you going to do in the future?
> > > Add a required property breaking the ABI?
> >
> > The problem is that there are no bindings for the reset controller
> > (actually the reset controller feature of the system-controller) yet.
> > Yeah, we can just add #reset-cells = <1> to the system-controller
> > device node, but we cannot add the actual resets properties to the
> > consumers, until the actual cell values are defined.
>
> Sounds like you should implement providers first. Or just live with the
> warning as a reminder to implement the reset provider?

I'd go for the latter. The upstream r9a06g032.dtsi is still under active
development. Until very recently, the only device supported was the
serial console.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
