Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3872F22A259
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 00:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbgGVWaU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 18:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgGVWaU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jul 2020 18:30:20 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB74622B47;
        Wed, 22 Jul 2020 22:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595457020;
        bh=I7/YIfdAMV3E37NnGmsLOOWx8Y9KsMdASXp+fIuCB6Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FAbkgy6sdytJTU9IpGYQFy7pAkblb4fmUS8GeRdQobkppbe5HQIrBbeJzJayZak5C
         d7sO+DFy+vfJNPDZJhdWaE1DKWIxJqRg1CQ/PT5Baxx5rBP3ke+h7YVK9UPNCBXc1Z
         1sEZPtWHIJ9knZnQWkIXTh2Zerhysm6OmYirf0Wk=
Received: by mail-oi1-f171.google.com with SMTP id k22so3324389oib.0;
        Wed, 22 Jul 2020 15:30:19 -0700 (PDT)
X-Gm-Message-State: AOAM532NU+ZpvnrhEuQQ/3xJmGCYq7s7PicredcoK5cIHNqmLZzNUfM1
        DrZ9OrfvhLI6f20KIZDoFDGGcsofydUy/rGK5w==
X-Google-Smtp-Source: ABdhPJyNc7J2Ie/GaUmdtczDpk4TzTx1BaMfBmYiKRVYAxHqT4jh1z08pTVv5GVCvdyCO3JGH5yTevtghczkpAcneRg=
X-Received: by 2002:aca:4844:: with SMTP id v65mr1605683oia.152.1595457019133;
 Wed, 22 Jul 2020 15:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200722110317.4744-1-kishon@ti.com> <20200722110317.4744-2-kishon@ti.com>
In-Reply-To: <20200722110317.4744-2-kishon@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 22 Jul 2020 16:30:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLVnWruxyavw_nRCorXQ2JGihjvMZffqniq8jPaRYPYTA@mail.gmail.com>
Message-ID: <CAL_JsqLVnWruxyavw_nRCorXQ2JGihjvMZffqniq8jPaRYPYTA@mail.gmail.com>
Subject: Re: [PATCH v8 01/15] PCI: cadence: Use "dma-ranges" instead of
 "cdns,no-bar-match-nbits" property
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 22, 2020 at 5:03 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Cadence PCIe core driver (host mode) uses "cdns,no-bar-match-nbits"
> property to configure the number of bits passed through from PCIe
> address to internal address in Inbound Address Translation register.
> This only used the NO MATCH BAR.
>
> However standard PCI dt-binding already defines "dma-ranges" to
> describe the address ranges accessible by PCIe controller. Add support
> in Cadence PCIe host driver to parse dma-ranges and configure the
> inbound regions for BAR0, BAR1 and NO MATCH BAR. Cadence IP specifies
> maximum size for BAR0 as 256GB, maximum size for BAR1 as 2 GB.
>
> This adds support to take the next biggest region in "dma-ranges" and
> find the smallest BAR that each of the regions fit in and if there is
> no BAR big enough to hold the region, split the region to see if it can
> be fitted using multiple BARs.
>
> "dma-ranges" of J721E will be
> dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
> Since there is no BAR which can hold 2^48 size, NO_MATCH_BAR will be
> used here.
>
> Legacy device tree binding compatibility is maintained by retaining
> support for "cdns,no-bar-match-nbits".
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Changes from [1]
> 1) Use list_sort() for sorting the address ranges by size
> 2) Clear CDNS_PCIE_LM_RC_BAR_CFG register before configuring them
>
> [1] -> http://lore.kernel.org/r/20200521080153.5902-1-kishon@ti.com
>  .../controller/cadence/pcie-cadence-host.c    | 251 +++++++++++++++++-
>  drivers/pci/controller/cadence/pcie-cadence.h |  28 +-
>  2 files changed, 262 insertions(+), 17 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
