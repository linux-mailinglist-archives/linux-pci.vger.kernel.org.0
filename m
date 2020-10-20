Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3329360E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 09:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgJTHrg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 03:47:36 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:44715 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgJTHrg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Oct 2020 03:47:36 -0400
Received: by mail-oo1-f67.google.com with SMTP id f26so222506oou.11;
        Tue, 20 Oct 2020 00:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZfRGZ3//s1qcuqLzqM57pzqGS6K3zNVopnM07XfYzI=;
        b=Ll5l6XiFIaIZYY8Y/1w9G2ioC1c09GWeoNWsVSOvVuHhGwJfp//GVbQt49nWaGI5zv
         UNnFZ/yHg0bonyo0ofAyXeV3VVitLmCIggTsEhZ8nzdLRlw29WdqcgawsnYfTlCgN4rt
         bTeYI2Ra2CDyPhvBwhOEYBwbXAnGCst6seDqNCtY60rZHl+psYTEvY8ZERK6aBv4ZeQA
         GKCjNGPr/oTK7xIpH72QmQsMwO1bA7eoMwOp83u5X78zQ8Y2x8j4b//m7DTvwurPh47M
         fFcpwtHhdy7U4VGh7o5G+TT5+9PnuKKCyoWxUxBNrfzcfuB436qP5T0iZkwfY+INTu0w
         Hmgg==
X-Gm-Message-State: AOAM531gBKg+9IlNqCbua00+sZDEwvg6ZghF1cA1YtvQK7/upoIarnBU
        AjnE/16f0J5F3T2ha2FmUJkOvxA/A67PI3PHyCg=
X-Google-Smtp-Source: ABdhPJwdvCyKKO7nBTthcpcBsBiy1BRcZeQBD3CKrwXsAowHIZfetULlAmnj8fyTSNm98oFsijMv/1WlHhdDaQanjcY=
X-Received: by 2002:a4a:5d84:: with SMTP id w126mr907910ooa.1.1603180056753;
 Tue, 20 Oct 2020 00:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201016120431.7062-1-marek.vasut@gmail.com>
In-Reply-To: <20201016120431.7062-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Oct 2020 09:47:25 +0200
Message-ID: <CAMuHMdW3obrfdnt7=oTxrpav2+rXhNhDiJ3fWRP3aF0jZQYNNQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Always allocate MSI addresses in 32bit space
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

On Fri, Oct 16, 2020 at 2:04 PM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> This fixes MSI operation on legacy PCI cards, which cannot issue 64bit MSIs.
> The R-Car controller only has one MSI trigger address instead of two, one
> for 64bit and one for 32bit MSI, set the address to 32bit PCIe space so that
> legacy PCI cards can also trigger MSIs.
>
> Fixes: 290c1fb35860 ("PCI: rcar: Add MSI support for PCIe")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

Seems to work, on both R-Car M2-W and M3-W, as
virt_to_phys((void *)msi->pages) points to RAM below the 4 GiB limit, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -753,7 +753,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
>         }
>
>         /* setup MSI data target */
> -       msi->pages = __get_free_pages(GFP_KERNEL, 0);
> +       msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA32, 0);

BTW, can this fail, especially now this is allocated from a more
limited pool?

>         rcar_pcie_hw_enable_msi(host);
>
>         return 0;

Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
