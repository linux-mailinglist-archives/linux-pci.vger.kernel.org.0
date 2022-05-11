Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE0523295
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 14:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiEKMGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 08:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242074AbiEKMGH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 08:06:07 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC92A70F;
        Wed, 11 May 2022 05:06:06 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id a76so2052585qkg.12;
        Wed, 11 May 2022 05:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrwvLhGf2fxkmYD1DrdW1SHeEkV8PyijrK4hUn7/z0I=;
        b=54yYrdGEM7tfCFtD1nFxVhM+UlhRaWGozplxqlPDPMveMR/Nzk/LoSxp1aQRS+gQ77
         Lqri9nnWYwhzKXrkr+gVHINWz0fyQmzylnhzpQWRRF6ad2mX2Dbn+txjFQdJMI3SQDaX
         wJTH6f1sonU8ObzZahfLn1HslBgrVX5no7IvnOUfKTPvwP6oKRrfL8up0WlKzn3l3RRY
         AepdymKjCOwl9ga7gaWTLchmNWf/4WS444BaCTIzHSM0QBxiEgIoIUusvdHFfl/2JuUN
         SruI5NMMEhtKrY9Zsyr77FZIRWkvNBbn24QssuD3zGQH98mMdSzwVaIAE0/WqZsBm8KU
         W/og==
X-Gm-Message-State: AOAM531RQX32jcGtmEhNGPJ5JQA1KM+6nC2hrdTWmM/UN8xjIrK30i6e
        mgD83B2fQfkpYHtRAC4Cet0shwfCyX3vFA==
X-Google-Smtp-Source: ABdhPJyRQnKGOcoLH9YkL8HBo2ODHTw7fJdqGL8GH5r/fQM91ljfiZInY6fw2f2KW/4UlVDuoxym3A==
X-Received: by 2002:a05:620a:40cf:b0:6a0:4c65:bed6 with SMTP id g15-20020a05620a40cf00b006a04c65bed6mr16919840qko.78.1652270765265;
        Wed, 11 May 2022 05:06:05 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id p10-20020ae9f30a000000b0069fc13ce220sm1103435qkg.81.2022.05.11.05.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 05:06:04 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id r1so3559073ybo.7;
        Wed, 11 May 2022 05:06:04 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr22687750ybb.202.1652270764139; Wed, 11
 May 2022 05:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220429134143.628428-1-herve.codina@bootlin.com>
 <20220429134143.628428-5-herve.codina@bootlin.com> <YnuFIfcq1Wg9Nh1L@lpieralisi>
In-Reply-To: <YnuFIfcq1Wg9Nh1L@lpieralisi>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 May 2022 14:05:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV3AWjxLD1YyN6aGttqPQueUqyvLo4PAvjozmobv6c1mA@mail.gmail.com>
Message-ID: <CAMuHMdV3AWjxLD1YyN6aGttqPQueUqyvLo4PAvjozmobv6c1mA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] PCI: rcar-gen2: Add RZ/N1 SOCs family compatible string
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Wed, May 11, 2022 at 12:42 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Apr 29, 2022 at 03:41:40PM +0200, Herve Codina wrote:
> > Add the Renesas RZ/N1 SOCs family support to the Renesas R-Car Gen2
> > PCI bridge driver.
> >
> > The Renesas RZ/N1 SOCs internal PCI bridge is compatible with the one
> > available in the R-Car Gen2 family.
> >
> > Tested with the RZ/N1D (R9A06G032) SOC.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/pci/controller/pci-rcar-gen2.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks!

> I assume this series will be picked up by platforms maintainers.

Usually driver patches are picked by the driver (subsystem) maintainer.
I can pick up the DTS changes once you agree with the DT bindings.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
