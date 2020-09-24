Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1E527740B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 16:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgIXOdM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 10:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbgIXOdM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 10:33:12 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662542395C;
        Thu, 24 Sep 2020 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600957991;
        bh=B/uhTfVzunXujPjEj63VXhTvDsVqUS39+IuJTTpzLnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S25P0N8OQlsQQHSlmfG7T84VcEHtZ/ascpvBsvkgb89ZbMytA95J+e8/W9NtoYP5j
         h2yVELYME+42hubQ3NeRR/omQoRWjAhLPqM5I8PJTc+5X9RGaTfEG828arxiucDtpY
         5R54KefkuS51+EYIFa0KYFF6pRZTcZEZbkeB3Uz4=
Received: by mail-oi1-f179.google.com with SMTP id w16so3877490oia.2;
        Thu, 24 Sep 2020 07:33:11 -0700 (PDT)
X-Gm-Message-State: AOAM531fP8Kb8XxjCieCJ64R/aW6R238eq/U7e0r2IeHpVz0LmNl98D/
        bvV0HP/A+NL6F9ZrWyHqZ/JnC66A6Vg7nwalqyM=
X-Google-Smtp-Source: ABdhPJzWGXlfnGw7EdMx/W0CoUOjafs5210kunFSE76VI8yC36oCCEksxujY2Heo1SEs/J28Zg+Ch8CDSgoonWzMi4U=
X-Received: by 2002:aca:d845:: with SMTP id p66mr2296944oig.47.1600957990747;
 Thu, 24 Sep 2020 07:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200923142607.10c89bd2@xhacker.debian> <CAMj1kXEyQGEu7=-kbDuTDW9_xXkmns1HM2dQMrLn=XL9W88vJw@mail.gmail.com>
 <CAL_JsqLkQ_NqrDDJZkm5ef-mf4_Vh0sW1DqQjitz-GzGBNbWhA@mail.gmail.com> <CAMj1kXH4aNZkST2QrKUDTPRPVq6Ybm0O0GLTwZiBrt-7hfYfVA@mail.gmail.com>
In-Reply-To: <CAMj1kXH4aNZkST2QrKUDTPRPVq6Ybm0O0GLTwZiBrt-7hfYfVA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 24 Sep 2020 16:32:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH=N8KrZW=_mbyiU=svKfabr8YaqBoA8HSuNKWCDoGMGA@mail.gmail.com>
Message-ID: <CAMj1kXH=N8KrZW=_mbyiU=svKfabr8YaqBoA8HSuNKWCDoGMGA@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Move allocate and map page for msi out of dw_pcie_msi_init()
To:     Rob Herring <robh@kernel.org>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 24 Sep 2020 at 15:45, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 24 Sep 2020 at 15:28, Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Sep 24, 2020 at 5:00 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 23 Sep 2020 at 08:28, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> > > >
> > > > Currently, dw_pcie_msi_init() allocates and maps page for msi, then
> > > > program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
> > > > may lose power during suspend-to-RAM, so when we resume, we want to
> > > > redo the latter but not the former. If designware based driver (for
> > > > example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
> > > > previous msi page will be leaked.
> > > >
> > > > Move the allocate and map msi page from dw_pcie_msi_init() to
> > > > dw_pcie_host_init() to fix this problem.
> > > >
> > > > Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> > > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > >
> > > Why do you allocate a page for this in the first place? Isn't
> > > PCIE_MSI_ADDR_HI:PCIE_MSI_ADDR_LO simply a magic DMA address that
> > > never gets forwarded across to the CPU side of the host bridge, and
> > > triggers a SPI instead, which gets handled by reading
> > > PCIE_MSI_INTR0_STATUS ?
> >
> > My question too after digging into this some more. I've asked the
> > question on the thread that further complicated all this changing from
> > virt_to_phys() to dma_map_page()[1].
> >
> > > Couldn't you just map the zero page instead?
> >
> > Why a page even? You could use PCIE_MSI_ADDR_LO address itself even.
> > Or just an address in the driver data which is what some other drivers
> > do.
> >
>
> PCIE_MSI_ADDR_LO itself could collide with an actual DRAM address if
> any translation is applied on inbound transactions. Using an actual
> DRAM address avoids that.

... although the MSI doorbell register on the GIC, for instance, needs
to be DMA addressable as well, of course.
