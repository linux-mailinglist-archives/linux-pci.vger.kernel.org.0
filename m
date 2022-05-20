Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0931F52EBAE
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 14:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240716AbiETMM0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 20 May 2022 08:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349060AbiETMMZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 08:12:25 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96066153526;
        Fri, 20 May 2022 05:12:24 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id s5so6505508qvo.12;
        Fri, 20 May 2022 05:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=txKFbhPEueIo/aj6c1+wzIrPvMm+5Ur9CFzaUN2DGCU=;
        b=wGmR9+ZDYNEGn2IPBM2LXDNkJeBt0iOS9b3DlbTogKHuauzOoO9sBRexDhFZgX9P6e
         3JTCIbZH22hOW5vJ/oaAG39iLUvj+RYGhp0qOdhaPg6vkPBvuf58CbY2OhmlD/wWQl9c
         IgRL3Tlid5Dnwf8MdK4OTIGFBPcyz/hBiCPtu96NSOOE+b3UhNu/wqv/ZgyqQsAkJ1O1
         VJY/LylhTPYfw49yi5OYcHASMWoFjr/vhV0VKfN5BGTVGWhtYF7O0v+2HennZlNiM0ML
         NXDH3x2LY7vMv2XDy+E6ILLctK/asUoLGu17Hx6lhem7FCGqOKcEZ1kTuUkNqMWwwJT4
         q2xw==
X-Gm-Message-State: AOAM532CxsCPvD0L01CfaqE2552CgjDTnMXtX/HEfywmEEO/oPoE7SAM
        0tMotVS6QJrpF19/LKNQSvDp9+R6GrRV8Q==
X-Google-Smtp-Source: ABdhPJwAOlNx2QwqG6tMwk4V+tBjpJ/rAke1ZNihGpNxbdutNmhrUejVWY5cguWX0t5YuglTSVdB/Q==
X-Received: by 2002:ad4:574f:0:b0:461:df46:af7b with SMTP id q15-20020ad4574f000000b00461df46af7bmr7548074qvx.53.1653048743205;
        Fri, 20 May 2022 05:12:23 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id d23-20020ac84e37000000b002f3ce9c0601sm3077053qtw.3.2022.05.20.05.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 05:12:22 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id a3so13865583ybg.5;
        Fri, 20 May 2022 05:12:22 -0700 (PDT)
X-Received: by 2002:a05:6902:389:b0:633:31c1:d0f7 with SMTP id
 f9-20020a056902038900b0063331c1d0f7mr8926767ybs.543.1653048742167; Fri, 20
 May 2022 05:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220520094155.313784-1-herve.codina@bootlin.com>
In-Reply-To: <20220520094155.313784-1-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 May 2022 14:12:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWc2W1YY=EP49bQ07bO4-WqQh-MbAPr7s153VqSCxmk2w@mail.gmail.com>
Message-ID: <CAMuHMdWc2W1YY=EP49bQ07bO4-WqQh-MbAPr7s153VqSCxmk2w@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] RZN1 USB Host support
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hervé,

On Fri, May 20, 2022 at 11:42 AM Herve Codina <herve.codina@bootlin.com> wrote:
> This series add support for the USB Host controllers available on
> RZN1 (r9a06g032) SOC.
>
> These USB Host controllers are PCI OHCI/EHCI controllers located
> behind a bridge.

Thanks for your series!

> Herve Codina (6):
>   dt-bindings: PCI: pci-rcar-gen2: Convert bindings to json-schema
>   dt-bindings: PCI: renesas,pci-rcar-gen2: Add device tree support for
>     r9a06g032
>   PCI: rcar-gen2: Add RZ/N1 SOCs family compatible string
>   ARM: dts: r9a06g032: Add internal PCI bridge node
>   ARM: dts: r9a06g032: Add USB PHY DT support
>   ARM: dts: r9a06g032: Link the PCI USB devices to the USB PHY

As I had applied v5 of the last 3 patches to renesas-devel, and they
are already present in soc/for-next, there is no need to resend them.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
