Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4FD518125
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiECJlT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 05:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiECJlS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 05:41:18 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD06032052;
        Tue,  3 May 2022 02:37:46 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id h3so8318979qtn.4;
        Tue, 03 May 2022 02:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJS2PbQaE+cZgUG4vlX1mlz4wtA8LAYNn+L6mZu2IK4=;
        b=IkdKWMoXT0EFYliFo4gJNdonVyaOubKyISyZJifOlDW0LHPJ9PGrxDiFT4egHkKXBz
         fz4y2Y7NBWp6wDFkjYurjzfq/vp1D2rrkSlcQX45N1G2sxvfVVzFzRxfNKxlqe3vQgCL
         dqe/7wXUk1W6OZTxzmgNlKWRsm+qsHKaeT4CDqRDMg5teI8Mw7sCcL14pEl+saOF0zFo
         P/7ymh31h++4Y5xKiNs2/vTmM7q/6KqXJoe5lnY7CVyy2z521XP/vTqTNoEppfuhdBAh
         H73BjeSLMT6vToymZdDnR+sjz0+UaOgF1BCNT6h2wf3rodxKUZ/Wbfo6p/TnT+OK8zw/
         RqPA==
X-Gm-Message-State: AOAM5309Ahcjzkla0KuP2y6O0C0ctbFw4hDD22KtcvjRejlfT6dC8q6W
        UEKDeG4kD5KrlLsW/OE34sc/Rm3VqypazA==
X-Google-Smtp-Source: ABdhPJzrZppVyLXFTNKY5hW5T0HmM/K6t//7bK71b2VkBzGFbwCPBlpt0D1+I/SvQ4jZiiNP8u4n7w==
X-Received: by 2002:a05:622a:20a:b0:2f3:aa7d:626d with SMTP id b10-20020a05622a020a00b002f3aa7d626dmr5204636qtx.270.1651570665618;
        Tue, 03 May 2022 02:37:45 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a146600b0069fc13ce217sm5511059qkl.72.2022.05.03.02.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 02:37:44 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2f7d19cac0bso173261257b3.13;
        Tue, 03 May 2022 02:37:44 -0700 (PDT)
X-Received: by 2002:a81:547:0:b0:2f8:6e8:19d7 with SMTP id 68-20020a810547000000b002f806e819d7mr14558872ywf.383.1651570664082;
 Tue, 03 May 2022 02:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220429134143.628428-1-herve.codina@bootlin.com>
 <20220429134143.628428-4-herve.codina@bootlin.com> <29ba3db6-e5c7-06d3-29d9-918ee5b34555@linaro.org>
 <CAMuHMdWN_ni_V+e3QipWH2qKXeNPkEcVpHpb5iBYw1YQSAnCDA@mail.gmail.com>
 <YnA0id1rXlNHNz+N@robh.at.kernel.org> <CAMuHMdWktaRAw8Y6TR93_rH8v4mPR2yt3wGqeXeTA2p_Dh--wA@mail.gmail.com>
 <5a89e9bf-1004-500a-75e1-995732629937@linaro.org>
In-Reply-To: <5a89e9bf-1004-500a-75e1-995732629937@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 May 2022 11:37:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVv-qCTyMQzr8ALCP-UmojZe9=NOrExPieJNV2300yzbQ@mail.gmail.com>
Message-ID: <CAMuHMdVv-qCTyMQzr8ALCP-UmojZe9=NOrExPieJNV2300yzbQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On Tue, May 3, 2022 at 11:29 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 03/05/2022 08:51, Geert Uytterhoeven wrote:
> >>>> This should not be a reason why a property is or is not required. Either
> >>>> this is required for device operation or not. If it is required, should
> >>>> be in the bindings. Otherwise what are you going to do in the future?
> >>>> Add a required property breaking the ABI?
> >>>
> >>> The problem is that there are no bindings for the reset controller
> >>> (actually the reset controller feature of the system-controller) yet.
> >>> Yeah, we can just add #reset-cells = <1> to the system-controller
> >>> device node, but we cannot add the actual resets properties to the
> >>> consumers, until the actual cell values are defined.
> >>
> >> Sounds like you should implement providers first. Or just live with the
> >> warning as a reminder to implement the reset provider?
> >
> > I'd go for the latter. The upstream r9a06g032.dtsi is still under active
> > development. Until very recently, the only device supported was the
> > serial console.
>
> For clocks we use in such cases fixed-clock placeholders or empty
> phandles. Maybe something like that would work here as well?

I don't think that works for resets.
Besides, the driver doesn't need or use the reset anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
