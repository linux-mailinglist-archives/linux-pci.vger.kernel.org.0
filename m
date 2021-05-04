Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA8F372A76
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 14:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhEDM4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 08:56:10 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46005 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhEDM4J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 May 2021 08:56:09 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M6DOg-1lbjmi21H6-006cEz; Tue, 04 May 2021 14:55:12 +0200
Received: by mail-wr1-f51.google.com with SMTP id z6so9318390wrm.4;
        Tue, 04 May 2021 05:55:12 -0700 (PDT)
X-Gm-Message-State: AOAM531W48nm3Ag8t7cdjl4rPgchf1eG25G2SGR1gfA11KwOksbc5xpF
        sC9Ad0/R1d/TWzpn9P8rIpin6eO1LZ7f62zi5Ic=
X-Google-Smtp-Source: ABdhPJxZqrTi9G2DXSNUfIOmCmqJfGfd4U+7J/GInsToAaauVBZoyXZWPBq5UxAt5OfgD6M4yd2UFfVUQfIwtkHJa48=
X-Received: by 2002:adf:d223:: with SMTP id k3mr31387435wrh.99.1620132912222;
 Tue, 04 May 2021 05:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210503211649.4109334-1-linus.walleij@linaro.org> <20210503211649.4109334-4-linus.walleij@linaro.org>
In-Reply-To: <20210503211649.4109334-4-linus.walleij@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 May 2021 14:54:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1ab_hvW_9_vBawhgsV3-W1F-qWm5KJ_ycuHmpVGzzz+Q@mail.gmail.com>
Message-ID: <CAK8P3a1ab_hvW_9_vBawhgsV3-W1F-qWm5KJ_ycuHmpVGzzz+Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: ixp4xx: Add device tree bindings for IXP4xx
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qzArCmDTMSjnriEqWDBFGeByWFbMJePOggUBTIjjF3Oa6HFTh8y
 MKZ6yJ14LLY5bz1jUJzEQ4T5/kVlgv8JngSViPEXql0I9vU8EHXgTeDXpvfad8yb/A6Ty4Z
 cKJ8PaKSNAQT/+DO/awEX4lvBT7I+Fk3Khgl0QmrJavpxPcYtvvC5KCkjR0b8H59mjodX7M
 lo3oTG6DAt6Vs9wf+gkCw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O1HcbgqJuS0=:54abwUlheZv/aDfkIBcz+D
 LeW4s22XP8PvFRlv49sd0VPD9zs+zrGvM7/lcKGSh5mebesL4X6FuZYD8E+n+P9qpVxEhQa+a
 PRymUUfjjTOAT+cPyuD/01mD1DVC9kcgQFCadypFuQRxbQPHARWUt5ssA7c2tfGrpEJrW/JyJ
 QC4dS/inexyCvectwEWlEJyCl4uO2J3EPE1uioo9pNwCUb2ZPzufG3wILDiatJvQIkvFtFK0t
 kVS5mJlZFt5JW15/QhPldM5yq3stobasBQKY0ZZivQrCmboC2JvJzncFRqDEu8LGzadulJh2w
 RQEQUp4d3xzHIP+zdU/YrVFR8HQf3S3XLogxYovBywi4Cbokr3EPmcTBNjnnNkb/eazZPNWmi
 RSMZAoGB47F41rVzs26NLOznGanfHHAN9u0k34YVVydz0MWCAHOaRPVJzRHgnOrFhCp1b9Jav
 8/3+A7mQV239EiOsDxYDfOG2YsV+9bDij79VLpjQbpDrkqvgeHdiK4DflX0iq8Z+9cFXD8Ejz
 Dpny9rg6/maohsbYUeaF0eOWgS26K1DJg3NCcfBKFD4+ojwR/DzYuUIPRERud4rZpjhjDE2Tn
 BmOu7XXVehI3jR0gXnDZM4eB3jHHCmxb9oZIyaWZrEPHkcT0QZRmX49gHWOtDERCX7hc8vHBr
 smPU=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 3, 2021 at 11:16 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> +  compatible:
> +    items:
> +      - enum:
> +          - intel,ixp42x-pci
> +          - intel,ixp43x-pci
> +    description: The two supported variants are ixp42x and ixp43x,
> +      though more variants may exist.

These are still wildcard names, better pick a real soc identifier
such as "ixp425" instead of "ixp42x" in case there are differences
after all.

> +        <0x0800 0 0 1 &gpio0 11 3>, /* INT A on slot 1 is irq 11 */
> +        <0x0800 0 0 2 &gpio0 10 3>, /* INT B on slot 1 is irq 10 */
> +        <0x0800 0 0 3 &gpio0 9  3>, /* INT C on slot 1 is irq 9 */
> +        <0x0800 0 0 4 &gpio0 8  3>, /* INT D on slot 1 is irq 8 */
> +        <0x1000 0 0 1 &gpio0 10 3>, /* INT A on slot 2 is irq 10 */
> +        <0x1000 0 0 2 &gpio0 9  3>, /* INT B on slot 2 is irq 9 */
> +        <0x1000 0 0 3 &gpio0 8  3>, /* INT C on slot 2 is irq 8 */
> +        <0x1000 0 0 4 &gpio0 11 3>, /* INT D on slot 2 is irq 11 */
> +        <0x1800 0 0 1 &gpio0 9  3>, /* INT A on slot 3 is irq 9 */
> +        <0x1800 0 0 2 &gpio0 8  3>, /* INT B on slot 3 is irq 8 */
> +        <0x1800 0 0 3 &gpio0 11 3>, /* INT C on slot 3 is irq 11 */
> +        <0x1800 0 0 4 &gpio0 10 3>; /* INT D on slot 3 is irq 10 */

Is this different from the default swizzling rules? You normally
only have to provide the irqs for the bus once.

       Arnd
