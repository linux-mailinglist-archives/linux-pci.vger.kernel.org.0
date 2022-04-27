Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9157F51207F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 20:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiD0PCa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 11:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiD0PCa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 11:02:30 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF411EAE8;
        Wed, 27 Apr 2022 07:59:19 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id bz24so1311784qtb.2;
        Wed, 27 Apr 2022 07:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/rjfxN9qB9dIcjWXWDFpJ6l3gGV6ETIlBiCqMU15AUo=;
        b=fOuHLcjNDoZZ2jEryAT69GRTzRBajcz+IjVP9HKMublpvapjTsa2zSh9lr9GeJHUQL
         DLsQiyp2txQG3ycGcLzpg+f7oQ+JDx3+TH23qnQYV6HpkhUbdLtpRltmdiaAnv0LB3VT
         cciTms0+2FbHpwuUK4+rkSCm1Q6Sy+rhpKxVQK4OPFSOdHEdY4yY9aE2+IgTfOnMdLA3
         9ZlCrV28EZij62Y+2KN66QzP6ebUW3YEksYO3ZwjHXpfaQalZQHTKtpzei1NYn2LB/3m
         TAB6SN0ePc0T8dSv2TIqpvecC52nW7aMefJf2AcH2SNCDU0Uv+rjgpcabcRhES3kmMQy
         8VRA==
X-Gm-Message-State: AOAM5314r1lqkR0zlr2gaKnTgu/7YBuBIy2vRD+kU/yEu+R4Ik9VfCI2
        zE0/ZJX9jXOXWIeiTYxNk+lyKQlD5aqOaA==
X-Google-Smtp-Source: ABdhPJz92bamSk3aLumZyq4/tocbRsNQp500v0eKEBspexYkUSC3ndxqnTV2mKx7Kvtd/OWJFfM0uQ==
X-Received: by 2002:ac8:7e88:0:b0:2f1:f942:80bd with SMTP id w8-20020ac87e88000000b002f1f94280bdmr19032346qtj.554.1651071558065;
        Wed, 27 Apr 2022 07:59:18 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id t186-20020a372dc3000000b0069ec8a9254esm8280614qkh.73.2022.04.27.07.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 07:59:17 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ec42eae76bso21698427b3.10;
        Wed, 27 Apr 2022 07:59:17 -0700 (PDT)
X-Received: by 2002:a81:4782:0:b0:2eb:1cb1:5441 with SMTP id
 u124-20020a814782000000b002eb1cb15441mr26143387ywa.479.1651071557084; Wed, 27
 Apr 2022 07:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120850.769480-1-herve.codina@bootlin.com> <20220422120850.769480-6-herve.codina@bootlin.com>
In-Reply-To: <20220422120850.769480-6-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Apr 2022 16:59:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV35uR2qHdmsQVxQuU716h-kkDfLs1bLfCGjedW_Bb3fQ@mail.gmail.com>
Message-ID: <CAMuHMdV35uR2qHdmsQVxQuU716h-kkDfLs1bLfCGjedW_Bb3fQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] ARM: dts: r9a06g032: Add missing '#power-domain-cells'
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 22, 2022 at 2:09 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Without '#power-domain-cells' property, power-domains cannot
> be used. This property is noted required in the device-tree
> binding.
>
> Add '#power-domain-cells' as needed.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
