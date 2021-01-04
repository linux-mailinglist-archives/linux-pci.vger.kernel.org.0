Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF852E938C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 11:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhADKpC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 05:45:02 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:33391 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbhADKpC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 05:45:02 -0500
Received: by mail-ot1-f48.google.com with SMTP id b24so25625951otj.0;
        Mon, 04 Jan 2021 02:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWBFzdltaHB2LmhJPr+3aAFk0bHyrG7NJiFKo6m3amQ=;
        b=ODKXDySaK2XmdM22/lB0TxClTZMONoqzf1ndHeNap2odpyH4iFZjuPZdCl6Nk6d7OO
         2Q0Kngc74MYNYMBdOv4rruGg4o5fxqrz6rq/rMAcEFdPYTuZsGbZBwqJGVWa+4KDG6g/
         XEW9PqfEH5JPz/Wzkuvk6C1l+xzi01+Og04TMzYH3eX4quNWDGcxVYmx4GKjWSRM0AtW
         nvPmLd07pMeutHatC0loRc7OBsBAb7aUi1grp+5HCUsphilhHCPXWWWSW4infQ9aI+Bi
         YYmzeiRE7fGlJOsCP6sQ6g1clh9BZOEKx8LJW5WrD9xAD2y8WIfmQULjFb7Si5sferjO
         fHug==
X-Gm-Message-State: AOAM533pxxGpcp/2ta+ICqw829FxZlC+ZjB8fW1Oty4z1p8z2ydz9jqx
        42oWoclHa4ermysmtBMchkb7uPcETvxJBDduK8U=
X-Google-Smtp-Source: ABdhPJxpg8oSaA/PXZWgJ5sADKEXP+Zc/bvWcki5ZqDJMFgEPzbsdusImgckqNgKqbm0G/lCHkPu7UXFhv5w1Uci7+E=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr52177425otc.145.1609757061486;
 Mon, 04 Jan 2021 02:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20201229170848.18482-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201229170848.18482-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Jan 2021 11:44:10 +0100
Message-ID: <CAMuHMdWkZWRo7S_HYTS-vWBR7gVv5Q+h+kO6LH8re7f74igdXg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Drop PCIE_RCAR config option
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 29, 2020 at 6:09 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> All the defconfig files have replaced PCIE_RCAR config option with
> PCIE_RCAR_HOST config option which built the same driver, so we can
> now safely drop PCIE_RCAR config option.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
