Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331CE28E205
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbgJNOQJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 10:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgJNOQI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Oct 2020 10:16:08 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF3182222F;
        Wed, 14 Oct 2020 14:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602684968;
        bh=lEFm+z5lP4vfNiFXYcQOrHTG8mC4vZkn0A7cetMCOGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sWTZQOHoQ0XQl5JDc3ylIaavsji5I1PCiIK9OTrXfHKnTUPU20xYVPuWKXO6SSL2m
         FY2LRl4ZHEPcsrxXddtTp9LI2MMA3bSBG3C0MGkaUnzD8nM7rrcM+o4FK9HFf1mGZN
         2D5GbozDUmg1GJPXlS0eSo8Z5gffV2xNZVgT0M2k=
Received: by mail-oo1-f43.google.com with SMTP id r7so823585ool.0;
        Wed, 14 Oct 2020 07:16:07 -0700 (PDT)
X-Gm-Message-State: AOAM5322ASbeMl5sF5/chtq5/D+wGHXyaWyKZHhqTK3pyQnY9UZQ5xxy
        soEXvsBv3LSKwMYY2XBLWF/YaAoOhv0EY1C1eg==
X-Google-Smtp-Source: ABdhPJydzle9WG7IZNaonu88f0kCpd5HkO6JxtLNVBDz9LBs3ccGK3Wafzu0TmNBEbdCCx9b9WqUj+T9kSxKQFfF07w=
X-Received: by 2002:a4a:dcc8:: with SMTP id h8mr3661817oou.81.1602684966895;
 Wed, 14 Oct 2020 07:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201009155311.22d3caa5@xhacker.debian> <20201009155505.5a580ef5@xhacker.debian>
 <38a00dde-598f-b6de-ecf3-5d012bd7594a@arm.com>
In-Reply-To: <38a00dde-598f-b6de-ecf3-5d012bd7594a@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Oct 2020 09:15:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLi09RTyiVLcyp1K4MNBggTvs3wqVqihpV2QhuePa3u9w@mail.gmail.com>
Message-ID: <CAL_JsqLi09RTyiVLcyp1K4MNBggTvs3wqVqihpV2QhuePa3u9w@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI: dwc: Fix MSI page leakage in suspend/resume
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 12, 2020 at 6:37 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-10-09 08:55, Jisheng Zhang wrote:
> > Currently, dw_pcie_msi_init() allocates and maps page for msi, then
> > program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
> > may lose power during suspend-to-RAM, so when we resume, we want to
> > redo the latter but not the former. If designware based driver (for
> > example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
> > msi page will be leaked.
> >
> > As pointed out by Rob and Ard, there's no need to allocate a page for
> > the MSI address, we could use an address in the driver data.
> >
> > To avoid map the MSI msg again during resume, we move the map MSI msg
> > from dw_pcie_msi_init() to dw_pcie_host_init().
>
> You should move the unmap there as well. As soon as you know what the
> relevant address would be if you *were* to do DMA to this location, then
> the exercise is complete. Leaving it mapped for the lifetime of the
> device in order to do not-DMA to it seems questionable (and represents
> technically incorrect API usage without at least a sync_for_cpu call
> before any other access to the data).
>
> Another point of note is that using streaming DMA mappings at all is a
> bit fragile (regardless of this change). If the host controller itself
> has a limited DMA mask relative to physical memory (which integrators
> still seem to keep doing...) then you could end up punching your MSI
> hole right in the middle of the SWIOTLB bounce buffer, where it's then
> almost *guaranteed* to interfere with real DMA :(

Couldn't that happen with the current code too? alloc_page() isn't
guaranteed to be DMA'able, right?

> If no DWC users have that problem and the current code is working well
> enough, then I see little reason not to make this partucular change to
> tidy up the implementation, just bear in mind that there's always the
> possibility of having to come back and change it yet again in future to
> make it more robust. I had it in mind that this trick was done with a
> coherent DMA allocation, which would be safe from addressing problems
> but would need to be kept around for the lifetime of the device, but
> maybe that was a different driver :/

Well, we're wasting 4K or 64K of memory and then leaking it is the
main reason to change it.

We just need any address that's not memory which PCI could access. We
could possibly just take the end of (outbound) PCI memory space. Note
that the DWC driver never sets up inbound translations, so it's all
1:1 mapping (though upstream could have some translation).

Rob
