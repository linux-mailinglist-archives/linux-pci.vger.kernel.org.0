Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F6952E764
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 10:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347054AbiETI3w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 20 May 2022 04:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347014AbiETI3o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 04:29:44 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A2F5E166;
        Fri, 20 May 2022 01:29:43 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id 11so4201836qtp.9;
        Fri, 20 May 2022 01:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vQOf+Td+ygkeVxH/Q4rPVYerZmfW/Jb9XT+06okoXpI=;
        b=3zG89MuHpotbf+Ws6VqTyT4EWHR8D275ghcUJfZobqyP6jxYOYe/lWBA2EwoVMmAD8
         vfZoQq4IyYdRJuNXSfVYYbocrousz+jwPzkk/RN0ivwbLqAfOfudIe4L8W2KBSYS26oF
         bjfmZO8sW/MlD3jk4y77WW+kjXwu6r3vpOOVYZf5ilT/XIvj2sE70kExTIBVsJLZ3QQb
         F/aQokyus9yU2aDW0zglu4PStivKK3hGUSoiZXE+QLIkkY/U7Dn3Giby6mjYEd69up+n
         BZadpuqeMoZj5dg03NT0Zeq7UrJOaD7BV+3E3ZKaa8n7B1/AT4GY8iDMQRfgyUIPBFAz
         hc+Q==
X-Gm-Message-State: AOAM533yeRvGdTI7F5B2tDzrtAk9tNT99Omryo78IkX3Mpv3W9chOwfr
        dNccvF/VlkcvEUCnV2zuSq29wsyTSYLMFg==
X-Google-Smtp-Source: ABdhPJwlZmN9N3HbUeX50IpW7oo4V5w3MCII46HPIX4xlZ3znPCqOSlUCEYOymQ7RxNuUCJu63popQ==
X-Received: by 2002:ac8:58c9:0:b0:2f3:d8f0:185f with SMTP id u9-20020ac858c9000000b002f3d8f0185fmr6798687qta.381.1653035382854;
        Fri, 20 May 2022 01:29:42 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id bs26-20020ac86f1a000000b002f39b99f6bdsm2699378qtb.87.2022.05.20.01.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 01:29:42 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2ff39b44b06so79589747b3.13;
        Fri, 20 May 2022 01:29:42 -0700 (PDT)
X-Received: by 2002:a81:9b0c:0:b0:2f4:c522:7d3c with SMTP id
 s12-20020a819b0c000000b002f4c5227d3cmr8935563ywg.316.1653035382015; Fri, 20
 May 2022 01:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220429134143.628428-1-herve.codina@bootlin.com>
 <20220429134143.628428-4-herve.codina@bootlin.com> <29ba3db6-e5c7-06d3-29d9-918ee5b34555@linaro.org>
 <20220520102329.6b0a58d0@bootlin.com>
In-Reply-To: <20220520102329.6b0a58d0@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 May 2022 10:29:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX6zXbFXo-tojpvrbobkWBe0MsjONEgZJismwFvhZ7SKA@mail.gmail.com>
Message-ID: <CAMuHMdX6zXbFXo-tojpvrbobkWBe0MsjONEgZJismwFvhZ7SKA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
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

On Fri, May 20, 2022 at 10:23 AM Herve Codina <herve.codina@bootlin.com> wrote:

> On Sun, 1 May 2022 10:51:43 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>
> [...]
> > >    resets:
> > >      maxItems: 1
> > > @@ -106,13 +106,45 @@ required:
> > >    - interrupt-map
> > >    - interrupt-map-mask
> > >    - clocks
> > > -  - resets
> > >    - power-domains
> > >    - bus-range
> > >    - "#address-cells"
> > >    - "#size-cells"
> > >    - "#interrupt-cells"
> > >
> > > +if:
> >
> > allOf.
> >
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        enum:
>
> I Have an issue with this allOf.
>
> The yaml has the following structure and so has 2 AllOf:
>   ...
>   allOf:
>   - $ref: /schemas/pci/pci-bus.yaml#
>
>   properties:
>     compatible:
>   ...
>   allOf:
>   - if:
>       properties:
>         compatible:
>           contains:
>   ...
> Is having a 'allOf' for schemas inclusion and a 'allOf' for conditionnal
> parts allowed ?

Just combine them into a single "allOf".
See e.g. Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml.

{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
