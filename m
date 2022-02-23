Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF05E4C13CF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 14:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbiBWNP6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 08:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiBWNP6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 08:15:58 -0500
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ABAAA007;
        Wed, 23 Feb 2022 05:15:31 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id f12so12161179vkl.2;
        Wed, 23 Feb 2022 05:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hq4Rn/gXQ/nJOJg9RV/mivldVE9GnufDZvVCzaxv+0U=;
        b=zswaUpg7egfkGMUZEX1jm03iUq6l52usepskpDkfFVDJhLMr/ml9GL68faUcluDvts
         gx761TlFFr8zrvi0e3K8Shg1D9V2IStdfUuaqKuh4ghl6CorEpdGw6B7Cwk85dVqz6kl
         4PprbuOry9Zx/WCuBKyFnXovMGobMYz29//ktdjR34dsJAJc3qld02ArXbCK54yMEE62
         k3amHoIgwvxIkTWHnbtHK/ikl+5Ebu1xbJxCYsycGIvAX9aSbdVJ2Zph92EFvgj1bAop
         +QBKs7afM74ffbF4gxVXbtY5fECGMuGGN62cDJKgFht2kL7Kq08JkPDFGhXxgJvP8YP6
         IzXw==
X-Gm-Message-State: AOAM530NoA6O3k4PujXQwVPmI3mzxQzBZt70+d6vH1Pbf8GelLm3hnIr
        ehqOX5x8/YS9cmD/iOYJWRrjhrUGJo5HLg==
X-Google-Smtp-Source: ABdhPJy+OYhf+V8JNvNri/+l22YveMgDuLMcPjcL+VY4qnnPpT0RzqZzWkyFpW67ISugWtDkx1CKZA==
X-Received: by 2002:a05:6122:d9e:b0:331:33da:48e5 with SMTP id bc30-20020a0561220d9e00b0033133da48e5mr12633749vkb.35.1645622130074;
        Wed, 23 Feb 2022 05:15:30 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id b23sm938638uam.3.2022.02.23.05.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 05:15:29 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id e5so3059617vsg.12;
        Wed, 23 Feb 2022 05:15:29 -0800 (PST)
X-Received: by 2002:a67:e10e:0:b0:31b:956b:70cf with SMTP id
 d14-20020a67e10e000000b0031b956b70cfmr11866044vsl.77.1645622129113; Wed, 23
 Feb 2022 05:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20220219034604.603656-1-marek.vasut@gmail.com>
In-Reply-To: <20220219034604.603656-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Feb 2022 14:15:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUvtu=Kuf0YK7Vj0t=zBsHVucWNFBA-brmwE_4giNAMig@mail.gmail.com>
Message-ID: <CAMuHMdUvtu=Kuf0YK7Vj0t=zBsHVucWNFBA-brmwE_4giNAMig@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
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

On Sat, Feb 19, 2022 at 4:46 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> In case the controller is transitioning to L1 in rcar_pcie_config_access(),
> any read/write access to PCIECDR triggers asynchronous external abort. This
> is because the transition to L1 link state must be manually finished by the
> driver. The PCIe IP can transition back from L1 state to L0 on its own.
>
> Avoid triggering the abort in rcar_pcie_config_access() by checking whether
> the controller is in the transition state, and if so, finish the transition
> right away. This prevents a lot of unnecessary exceptions, although not all
> of them.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
