Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F68511B8C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 16:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiD0PBc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 11:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiD0PBc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 11:01:32 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F24621B9A7;
        Wed, 27 Apr 2022 07:58:21 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id jt15so1198319qvb.13;
        Wed, 27 Apr 2022 07:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYDURu5i0RHHZqthIe7OlCex9R1+VuC9goSLzQQhWio=;
        b=plx7RuPGLPAFg9ej3yYeUFrYUZAoH7hXKen2nOP0jqTgR+m3GAElQx0l/OfYur/BaM
         M6BreEH9KAx8lqW+bF21T2gJ4+yjIocI9NOde0N7fLQvPi9sMKzPc7U8zkGYucE0bXvi
         a9YlnK3sfRhet4MXXKYqbxTZEUGxtwvRj0vish8WDURfzw+UIo8GxeRdRIV6MM5AAm4D
         7nrEUHet6ksCexFyJNp3TFymiUg2OeDc4H5cWwy80gnvxj9eXsfyqHiHu2PMglzBaNrA
         Ct72RTatEzc+zhnHCPqWbrIu1haEmxtiaC0E35MllOV5Gk+2bj4eL+P1qKyKmmR2x2Qn
         E3fQ==
X-Gm-Message-State: AOAM532D5cURkNNh++xTAe+2Se4jgEMlIrSsbGXppAUqJ8dJcboeUL/N
        /Cke7I9cuOnH7+DDkn0XvRq6hnrRRdkg0A==
X-Google-Smtp-Source: ABdhPJxUntm0ju7CaZ0xtnlpvPcKw2DiDb3xvoyjBtd+EHuURw1W3kbiLgwvjAVEui9dxI6Quy8ngA==
X-Received: by 2002:a0c:80ec:0:b0:444:43ec:a918 with SMTP id 99-20020a0c80ec000000b0044443eca918mr20046658qvb.20.1651071499813;
        Wed, 27 Apr 2022 07:58:19 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id o6-20020ac85a46000000b002f3873e7fb4sm128395qta.77.2022.04.27.07.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 07:58:19 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id v59so3819095ybi.12;
        Wed, 27 Apr 2022 07:58:18 -0700 (PDT)
X-Received: by 2002:a25:8087:0:b0:641:dd06:577d with SMTP id
 n7-20020a258087000000b00641dd06577dmr25921976ybk.207.1651071498652; Wed, 27
 Apr 2022 07:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120850.769480-1-herve.codina@bootlin.com> <20220422120850.769480-5-herve.codina@bootlin.com>
In-Reply-To: <20220422120850.769480-5-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Apr 2022 16:58:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmcBXRxZ_SDLCnimh7GqzkR0_qz178s51EtXsMm39ddg@mail.gmail.com>
Message-ID: <CAMuHMdWmcBXRxZ_SDLCnimh7GqzkR0_qz178s51EtXsMm39ddg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] soc: renesas: rzn1: Select PM and
 PM_GENERIC_DOMAINS configs
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 22, 2022 at 2:09 PM Herve Codina <herve.codina@bootlin.com> wrote:
> PM and PM_GENERIC_DOMAINS configs are required for RZ/N1 SOCs.
> Without these configs, the clocks used by the PCI bridge are not
> enabled and so accessing the devices leads to a kernel crash:
>   [    0.832958] Unhandled fault: external abort on non-linefetch (0x1008) at 0x90b5f848
>
> Select PM and PM_GENERIC_DOMAINS for ARCH_RZN1
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
