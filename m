Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1618947DC4C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 01:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhLWAnm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 19:43:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40142 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhLWAnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 19:43:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD620B81EDA
        for <linux-pci@vger.kernel.org>; Thu, 23 Dec 2021 00:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDBFC36AE5;
        Thu, 23 Dec 2021 00:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640220219;
        bh=2S0mN+Mkea1kn3oAbToz7aIe99CuD9vOePs1hvZ6Ly4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VZAPTYY+D3ZyVRhf8b9XbPx+nG8PXtJAkpHGHSgbykg9CSUOGeAOJfdaNmOeMv55/
         akQ1v6GVzSic6ZvHYm22WXvw3JB6NK+7Fo0Bf7Pkky0aEL0gw8oDQX65fzqzUGIT+u
         a5HmfgPUe7K18FWPr6ro1GfhwJ7stukeaAGTiPhZI1uxhFjs9FSp1OfCNGVvMdtC+x
         dER66RnUNisEiInPB8ZuGKtHA+Yc/s8h6hV/zMh1XouGT4lx2RVFWl2o+R1019hw3h
         z6lnM/GJG9X5i2BSP8dT2LIiCHEFesxNqR3m34I9PmL/ecFn3yvxQjzxfGhQ27RhuT
         eHW39fNzIT3oQ==
Date:   Wed, 22 Dec 2021 18:43:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Fan Fei <ffclaire1224@gmail.com>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/13] Unify device * to platform_device *
Message-ID: <20211223004337.GA1222509@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638022048.git.ffclaire1224@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 27, 2021 at 03:11:08PM +0100, Fan Fei wrote:
> Some PCI controller structs contain "device *", while others contain
> "platform_device *". These patches unify "device *dev" to 
> "platform_device *pdev" in 13 controller struct, to make the controller 
> struct more consistent. Consider that PCI controllers interact with 
> platform_device directly, not device, to enumerate the controlled device.

I went through all the controller drivers using a command like this:

  git grep -A4 -E "^struct .*_pci.?\> \{$" drivers/pci/controller/

and found that almost all of them hang onto the "struct device *", not
the "struct platform_device *".  Many of these are buried inside
struct dw_pcie and struct cdns_pcie.

I know I've gone back and forth on this, but I don't think the churn
of converting some of them to keep the "struct platform_device *"
would be worthwhile.

The preceding series that renamed the controller structs made this
exploration quite a bit easier, so I do plan to apply that series.

> Fan Fei (13):
>   PCI: xilinx: Replace device * with platform_device *
>   PCI: mediatek: Replace device * with platform_device *
>   PCI: tegra: Replace device * with platform_device *
>   PCI: xegene: Replace device * with platform_device *
>   PCI: microchip: Replace device * with platform_device *
>   PCI: brcmstb: Replace device * with platform_device *
>   PCI: mediatek-gen3: Replace device * with platform_device *
>   PCI: rcar-gen2: Replace device * with platform_device *
>   PCI: ftpci100: Replace device * with platform_device *
>   PCI: v3-semi: Replace device * with platform_device *
>   PCI: ixp4xx: Replace device * with platform_device *
>   PCI: xilinx-nwl: Replace device * with platform_device *
>   PCI: rcar: Replace device * with platform_device *
> 
>  drivers/pci/controller/pci-ftpci100.c        |  15 +-
>  drivers/pci/controller/pci-ixp4xx.c          |  47 ++--
>  drivers/pci/controller/pci-rcar-gen2.c       |  10 +-
>  drivers/pci/controller/pci-tegra.c           |  85 +++----
>  drivers/pci/controller/pci-v3-semi.c         |  19 +-
>  drivers/pci/controller/pci-xgene.c           | 222 +++++++++----------
>  drivers/pci/controller/pcie-brcmstb.c        |  35 +--
>  drivers/pci/controller/pcie-mediatek-gen3.c  |  36 +--
>  drivers/pci/controller/pcie-mediatek.c       |  31 +--
>  drivers/pci/controller/pcie-microchip-host.c |  18 +-
>  drivers/pci/controller/pcie-rcar-ep.c        |  40 ++--
>  drivers/pci/controller/pcie-rcar-host.c      |  27 +--
>  drivers/pci/controller/pcie-rcar.h           |   2 +-
>  drivers/pci/controller/pcie-xilinx-nwl.c     |  28 +--
>  drivers/pci/controller/pcie-xilinx.c         |  21 +-
>  15 files changed, 328 insertions(+), 308 deletions(-)
> 
> -- 
> 2.25.1
> 
