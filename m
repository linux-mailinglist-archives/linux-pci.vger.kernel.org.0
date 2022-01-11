Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4C48B9D7
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 22:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbiAKVqO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 16:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbiAKVqN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 16:46:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22F6C06173F;
        Tue, 11 Jan 2022 13:46:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6C0CB81D54;
        Tue, 11 Jan 2022 21:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D999C36AE9;
        Tue, 11 Jan 2022 21:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641937570;
        bh=XNEfESj08xbpQ9h2hTKb/Pu9WAZg5VvTWzJOGQNAOC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hrPlCKr2Cgo8R910eadJlHVlOQja6nGt1WhCOdCaXCFbaY87edhU/MmAMX/v1PJsc
         gLQc0SVeHdbiE+O2eRDoMKPl75FAH+9KQyJDGXovCKyCiyadNi8gEHpPonHamnVox+
         G04I153V4JR+wMjH4pxqMpmy15qR5o2IrbvHn9FFW8B65WXFhkGXUhvSFYkIGy6yh3
         hA4WQhIs2poE1DZrZ30e2kEEHb/WlABHuWYKlp5c9+auiqcRV0NWB+f+CloLsF44oi
         sHcF3MxaFbGuuaZJXqMhu2E3SIyauijaeJkHkWIKSXHFM6YfsjF2RAKLje4z0h4GaE
         X5ke9q8yP4zfw==
Date:   Tue, 11 Jan 2022 15:46:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 19/19] PCI: Set bridge map_irq and swizzle_irq to default
 functions
Message-ID: <20220111214608.GA169999@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722022514.1283916-20-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[-cc many, +cc iproc, loongson, tegra maintainers]

On Tue, Jul 21, 2020 at 08:25:14PM -0600, Rob Herring wrote:
> The majority of DT based host drivers use the default .map_irq() and
> .swizzle_irq() functions, so let's initialize the function pointers to
> the default and drop setting them in the host drivers.
> 
> Drivers like iProc which don't support legacy interrupts need to set
> .map_irq() back to NULL.

Probably a dumb question...

This patch removed all the ->swizzle_irq users in drivers/pci/, which
is great -- IIUC swizzling is specified by the PCI-to-PCI Bridge Spec,
r1.2, sec 9.1, and should not be device-specific.  I assume the few
remaining arch/ users (arm and alpha) are either bugs or workarounds
for broken devices.

My question is why we still have a few users of ->map_irq: loongson,
tegra, iproc.  Shouldn't this mapping be described somehow via DT?

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index fc4e38fec928..97433beff6cf 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2709,7 +2709,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  
>  	host->ops = &tegra_pcie_ops;
>  	host->map_irq = tegra_pcie_map_irq;
> -	host->swizzle_irq = pci_common_swizzle;
>  
>  	err = pci_host_probe(host);
>  	if (err < 0) {

> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
> index 7c10c1cb6f65..a956b0c18bd1 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -99,9 +99,10 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  	switch (pcie->type) {
>  	case IPROC_PCIE_PAXC:
>  	case IPROC_PCIE_PAXC_V2:
> +		pcie->map_irq = 0;
>  		break;
>  	default:
> -		pcie->map_irq = of_irq_parse_and_map_pci;
> +		break;
>  	}
>  
>  	ret = iproc_pcie_setup(pcie, &bridge->windows);

> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index e98dafd0fff4..905e93808243 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1526,7 +1526,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  	host->ops = &iproc_pcie_ops;
>  	host->sysdata = pcie;
>  	host->map_irq = pcie->map_irq;
> -	host->swizzle_irq = pci_common_swizzle;
>  
>  	ret = pci_host_probe(host);
>  	if (ret < 0) {

drivers/pci/controller/pci-loongson.c:

  static int loongson_pci_probe(struct platform_device *pdev)
  {
    ...
    bridge->map_irq = loongson_map_irq;

