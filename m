Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0443C916
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhJ0MCi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 08:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhJ0MCg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 08:02:36 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2347FC061570;
        Wed, 27 Oct 2021 05:00:11 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id o26so4415937uab.5;
        Wed, 27 Oct 2021 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LpfMaUsIwWmMBkvjLoHELPmDG2TU2qiVaI7dHu5QUNU=;
        b=nPO8Yf1eO5Rcpi9Rg+fqHDkOE3qCrqg76UASShd3TLYS9jY/l7yWkUMt5598ZE7XVr
         1zwOJpBrFCFUz8ZTMNoJk6Gv5OgZedWkGRgHgfxapz3PioQFIJWoAcXK3c7xPdNJEFa1
         xwteg19Hi82jiLFmWHxabGitdWttvuoyrX/GUp0Hu3dhIArJDYyGryYP1i+tSwVDOY75
         DnvXCRnLle7IaiwZCUOP0+4HWMtWbAJaLPbdh6opU2nMxMyfRtUgu6/gu/jCTpSdZndL
         LU9zYNAeJJnBXioS1IVE0PBquPgyy1zrV2UDuub13Lf1ORTfPy2fTpGKOIeRl+Q/SJuI
         zYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LpfMaUsIwWmMBkvjLoHELPmDG2TU2qiVaI7dHu5QUNU=;
        b=uf3feNc8XbBjTz48w9zzL+THk6tEoSrjC3O8ntDfwAdaLhga87T5xLBlejaVnGy4rn
         JgIgivvlOyB64aY++XfGLgIDvit4cKPfmAFMZ6KfHP3V2QI3ejj2GqK15cwEfkyv48ma
         HgGiEblx8fVF6Kv+1pGVKPVRmAzfD6zvBRQfysmlLcbqfyXiiwiQj0/1HcWZ+tvSJ+cn
         b+QnOWk/DyK4mnE6fkSFDR1Wt20DvrP9Oki9el9xTikkfI4Gypfykw9ZWWxXM2FAlqNn
         rPGoP2U2c2fVfsJOC3kTpNtxXGnC+d/kLmY/bOBLnwL6HPTOmThRsVIURKc1geQdZxHp
         PXnw==
X-Gm-Message-State: AOAM531Y3Hde8rpTEKFKyZKd1m2J/l9CZdBpolgeZ7FvHCRiGq44EZEj
        8PBmbFNDLiEX2Ti1ze85FMNK2Es7HQdsPbUvU5Y=
X-Google-Smtp-Source: ABdhPJzBo2T3m7VvmKbxfyJ5pPb7UFwA97LM05HVmxPcVIqBFlRDZjw/G4ZpNQJm+qVT3XdfvF9O8AIFN05k38EmyUc=
X-Received: by 2002:ab0:61c4:: with SMTP id m4mr13693262uan.66.1635336010157;
 Wed, 27 Oct 2021 05:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635333327.git.siyanteng@loongson.cn> <50f5f509c15251fb10b0c87304d272e2c89841f0.1635333327.git.siyanteng@loongson.cn>
In-Reply-To: <50f5f509c15251fb10b0c87304d272e2c89841f0.1635333327.git.siyanteng@loongson.cn>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 27 Oct 2021 13:59:58 +0200
Message-ID: <CAMhs-H9MANfLThCC-m9Q5whAgRAbnzXjUpipQdnwRf0iqPwJuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: mt7621: Add MODULE_* macros to MT7621 PCIe host
 controller driver
To:     Yanteng Si <siyanteng01@gmail.com>
Cc:     Yanteng Si <siyanteng@loongson.cn>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        chenhuacai@kernel.org, sterlingteng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Oct 27, 2021 at 1:32 PM Yanteng Si <siyanteng01@gmail.com> wrote:
>
> Since commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
> the MT7621 PCIe host controller driver is built as a module but no MODULE_*() attributes
> were specified, causing a build error due to missing license information.
>
> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
>
> Fix this by adding MODULE attributes to the driver.
>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index b60dfb45ef7b..668b737f86fb 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -598,3 +598,5 @@ static struct platform_driver mt7621_pci_driver = {
>         },
>  };
>  builtin_platform_driver(mt7621_pci_driver);
> +
> +MODULE_LICENSE("GPL v2");

I guess this is needed for COMPILE_TEST scenarios?

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

> \ No newline at end of file
> --
> 2.27.0
>
