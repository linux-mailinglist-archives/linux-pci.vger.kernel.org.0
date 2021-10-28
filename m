Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3146D43DA24
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 06:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhJ1EN5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 00:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhJ1EN4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Oct 2021 00:13:56 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0063C061570;
        Wed, 27 Oct 2021 21:11:29 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id s4so9189393uaq.0;
        Wed, 27 Oct 2021 21:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xn8PEIn0HAm5g7c6x+2BgzMv0cNlTzK/SeJ2DFv191s=;
        b=STpsRI6+Bb8KeAqyuiI1+I7dNwJJujec7wkUoOAVQuBRZ/C7QfZyBz59JgQq4GhbYu
         NjYEsNJNFjK4Sx6Q3K3uOV5ctqvxgtzXsBq3mMrzcCRZiiObeD+UP/eGXmNWgcW7YZBD
         rQdmXkQFcIfs1CCzAlVtjY1wwkvmOyT8xC7AkTIbgd1MbUO5P9WiXAHXvq0/UTuVtOoR
         Q9pIh84Yf0rMNJclh8co5E90boxr6Np73XYvChU703VfjMMd5AMVgYm49IXUTSbP/Ppg
         nZvbBJbs05rUz75C9U56IURzVDAOLIs/dFk7GXkIh7KasxEi3CbcmiqVCj67rdlSZJwc
         daCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xn8PEIn0HAm5g7c6x+2BgzMv0cNlTzK/SeJ2DFv191s=;
        b=7w192CusLvChXsceZWfMmI3JLUM0UHY+NYX5L5JmiJMCpLXdxz0G8k+AhoQDVMz38D
         YVYr3fefom7G0RLVVegsseUPa1FSkmo+qJccAbFAkcoYm/GdJ1tIuHM1B0dBGJ2C6Rh4
         zaKy1acdlqqNq34AfOLxWkdleLc+IrHHXZmefBsywQQNZbfkZAD7liuVl/UrqxB0BCGG
         U4wc/5wtaORfjcdVS93ayMawxuOlBVMLmJ8VuaHZkAub677zGpoRJJk0EhnjN7hdGq/r
         QSgED05OQHx+7SYGwJgLCRLIXZyi78BZSA+o3nQAj38x/EwDYpsSKnfKFp3Pxa937G9H
         Np1g==
X-Gm-Message-State: AOAM531Jf+SUVTwaZDIVPzxhRMXJK1xLPOEPE7zxtvY2V2YDlAgb29Yn
        HydTD8wlZ8qz13YVmaLv3CMOfvYNJo40abEF8A0PZjx5UVg=
X-Google-Smtp-Source: ABdhPJwFblgYg4X1L8DosH99640DqXOIO09uy3Cj7pYiyIdsLNYjKJLPnEUlXY/cMqutEFK2vOnKuDsHlwTUwiEzP0o=
X-Received: by 2002:ab0:5925:: with SMTP id n34mr2193803uad.46.1635394289059;
 Wed, 27 Oct 2021 21:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635390750.git.siyanteng@loongson.cn> <112fea0c8c1b65a762ac98412216239160721263.1635390750.git.siyanteng@loongson.cn>
In-Reply-To: <112fea0c8c1b65a762ac98412216239160721263.1635390750.git.siyanteng@loongson.cn>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 28 Oct 2021 06:11:18 +0200
Message-ID: <CAMhs-H9LUQ6Km=sA992LH=+E0MbGuMf9YhM6w2HoyeqE0QbzJQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] MIPS: cm/cpc: export some missing symbols to be
 able to use them from driver code
To:     Yanteng Si <siyanteng01@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Yanteng Si <siyanteng@loongson.cn>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        chenhuacai@kernel.org, sterlingteng@gmail.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 28, 2021 at 6:05 AM Yanteng Si <siyanteng01@gmail.com> wrote:
>
> Since commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
> the MT7621 PCIe host controller driver is built as a module but modpost complains once these
> drivers become modules.
>
> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>
> Let's just export them.
>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  arch/mips/kernel/mips-cm.c  | 5 +++++
>  arch/mips/kernel/mips-cpc.c | 1 +
>  2 files changed, 6 insertions(+)
>

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
