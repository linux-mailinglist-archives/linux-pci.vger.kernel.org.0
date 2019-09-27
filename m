Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 761B4C0209
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 11:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfI0JQL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 05:16:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37037 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfI0JQL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 05:16:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id i16so4616146oie.4;
        Fri, 27 Sep 2019 02:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrSMs+vxGV2tpo5fzGvnzPrC4xp2UbLMKgbm5e707os=;
        b=ij59yh9A+IB1qVm63i9fBOd3bL0cDyobVsdJD//tBFeyRWTiiH1OCYN+sDPRpUl0tL
         DlHldTa/c9CXZ1kPSwbL8nkB6xbbJvbgDLmdXqkxndoPx2yuHJ2Ooqq0daOnxyknPDB4
         fi0ONDxY2vf0HiqvM9y/6/RCdBgegT/3c2VifcMRmbx7DLWBh7CYWPqGQBfCwty7VstL
         khP8/bP9NTAc4dENTxbVxnPgHImOeWLQf7f1pWeJ74oUcM76a8V4vJ3FLAadlGbhgcSx
         olV3xDDUEtgEP32cHgLUKN8gmhMKuFAOOh5hbrqZa+9/0QGq8jL5JQDFlhuSn0NaS6Ct
         fcqg==
X-Gm-Message-State: APjAAAUX25KCuz6/kdyWvlbbWGRXm5vOS69QDB5+5o1mgtuMERcULAi9
        HMv1f7NnLW2g6RJhULzYNqL9xKHlOedAfm3Ta7E=
X-Google-Smtp-Source: APXvYqzwRUzhC1kv7YWIlRcwxP2ZhSwoD+vpHKOeORZVMk6BEVywWUAanN0Ycv/YcVYLjOSwRFSwWhMeLqcMJPqG3Xs=
X-Received: by 2002:aca:b654:: with SMTP id g81mr5914865oif.153.1569575769992;
 Fri, 27 Sep 2019 02:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190927002455.13169-1-robh@kernel.org> <20190927002455.13169-4-robh@kernel.org>
In-Reply-To: <20190927002455.13169-4-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Sep 2019 11:15:58 +0200
Message-ID: <CAMuHMdV5Dw2FZcp6K7Kytzxtp7apEQ0FuE1CiOi+R4QVDrhM3A@mail.gmail.com>
Subject: Re: [PATCH 03/11] of: address: Report of_dma_get_range() errors meaningfully
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 27, 2019 at 2:25 AM Rob Herring <robh@kernel.org> wrote:
> From: Robin Murphy <robin.murphy@arm.com>
>
> If we failed to translate a DMA address, at least show the offending
> address rather than the uninitialised contents of the destination
> argument.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/of/address.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 8e354d12fb04..53d2656c2269 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -955,8 +955,8 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
>         dmaaddr = of_read_number(ranges, naddr);
>         *paddr = of_translate_dma_address(np, ranges);
>         if (*paddr == OF_BAD_ADDR) {
> -               pr_err("translation of DMA address(%pad) to CPU address failed node(%pOF)\n",

Yeah, the %pad was wrong on 32-bit without CONFIG_PHYS_ADDR_T_64BIT.

> -                      dma_addr, np);
> +               pr_err("translation of DMA address(%llx) to CPU address failed node(%pOF)\n",
> +                      dmaaddr, np);
>                 ret = -EINVAL;
>                 goto out;
>         }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
