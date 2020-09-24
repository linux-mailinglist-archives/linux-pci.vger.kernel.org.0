Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A43277227
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 15:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgIXN2j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 09:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbgIXN2i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 09:28:38 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C0692344C;
        Thu, 24 Sep 2020 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600954118;
        bh=1IipRSbhWLSRfEw8Jk9nFBwa6cgG1ZliWjzUE9q9GdM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SmNnlkJH67GdcpPmbO80TyoWT6ckht84GU4BeFncVDy/kI1IYAWPQovrTTWtlMqqN
         nMCz1LtJehPQSH5Grar5eWubFjzMnmvb9BsksldOdrfhnqd2czCEfLxU8+yAGDYicM
         YRc7cEV7wI6PnnSTndsOr5dRta0mJH5jH44CqfRE=
Received: by mail-ot1-f45.google.com with SMTP id 60so3158059otw.3;
        Thu, 24 Sep 2020 06:28:38 -0700 (PDT)
X-Gm-Message-State: AOAM532eWqgZP2ivrWYazz60JgoqZkqq9kliSlYq4hzgKWBvBhM6Kpkh
        VCluTkIgGsHJzp2eD4UUQDWaAhRAXYZqzVBQvg==
X-Google-Smtp-Source: ABdhPJx333FQr3fLvubWM0pHrSJVAM9Gmc+ieB7uq6OQJ2CyoCs/GkXZ7hQ9ksO9nsUuKwj1htuQiWhki5Rf/ma9YqI=
X-Received: by 2002:a9d:6ada:: with SMTP id m26mr3180859otq.192.1600954117510;
 Thu, 24 Sep 2020 06:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200923142607.10c89bd2@xhacker.debian> <CAMj1kXEyQGEu7=-kbDuTDW9_xXkmns1HM2dQMrLn=XL9W88vJw@mail.gmail.com>
In-Reply-To: <CAMj1kXEyQGEu7=-kbDuTDW9_xXkmns1HM2dQMrLn=XL9W88vJw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 24 Sep 2020 07:28:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLkQ_NqrDDJZkm5ef-mf4_Vh0sW1DqQjitz-GzGBNbWhA@mail.gmail.com>
Message-ID: <CAL_JsqLkQ_NqrDDJZkm5ef-mf4_Vh0sW1DqQjitz-GzGBNbWhA@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Move allocate and map page for msi out of dw_pcie_msi_init()
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Thu, Sep 24, 2020 at 5:00 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 23 Sep 2020 at 08:28, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> >
> > Currently, dw_pcie_msi_init() allocates and maps page for msi, then
> > program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
> > may lose power during suspend-to-RAM, so when we resume, we want to
> > redo the latter but not the former. If designware based driver (for
> > example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
> > previous msi page will be leaked.
> >
> > Move the allocate and map msi page from dw_pcie_msi_init() to
> > dw_pcie_host_init() to fix this problem.
> >
> > Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>
> Why do you allocate a page for this in the first place? Isn't
> PCIE_MSI_ADDR_HI:PCIE_MSI_ADDR_LO simply a magic DMA address that
> never gets forwarded across to the CPU side of the host bridge, and
> triggers a SPI instead, which gets handled by reading
> PCIE_MSI_INTR0_STATUS ?

My question too after digging into this some more. I've asked the
question on the thread that further complicated all this changing from
virt_to_phys() to dma_map_page()[1].

> Couldn't you just map the zero page instead?

Why a page even? You could use PCIE_MSI_ADDR_LO address itself even.
Or just an address in the driver data which is what some other drivers
do.

Rob

[1] https://lore.kernel.org/linux-pci/20200923231846.GA1499246@bogus/
