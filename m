Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0657600F96
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 14:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJQMzL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 08:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJQMzL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 08:55:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1937E2C100;
        Mon, 17 Oct 2022 05:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDB8A61132;
        Mon, 17 Oct 2022 12:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9459DC433D6;
        Mon, 17 Oct 2022 12:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666011306;
        bh=65c+iKIMeOFlV1mIKTP1pDBxqruYKowQ7aWAbyG0IiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qd10DWUYwgBhsF90KaFcbK19HKzdlMMmoHrBde/XEJ11PUQEkqA8Y5NhzXnySJOB8
         /+1LKRIk5aMcSiVYFkXH+vw2tWZ5dReeyY+cZeaA4zMrAAUN5hWgMd/ENNo+Nr+vA1
         bV8B0SaqqispEK9MiX/hmWyLuWd4iOsONoIQMQM3l1WhM6ymTAvJNx6Bs2wm5gtTsu
         mN+lNc92O7fRtO7hN0z8tz63YWoE/PbDabfqg2EDg+kZ8nOmnlIqWUmFK0orHuvPh+
         32rUBxeRpVUrGzFbqU4NWYGyf+/6+lbGW4vVo4sl7jZ+i7mEpGl4df6LkePnbjHAx2
         pS0itpcHjtz2g==
Date:   Mon, 17 Oct 2022 14:55:00 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>, bhelgaas@google.com
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro"
Message-ID: <Y01QpMYvFVyMNrO3@lpieralisi>
References: <20221017084006.11770-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017084006.11770-1-jonathanh@nvidia.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 17, 2022 at 09:40:06AM +0100, Jon Hunter wrote:
> This reverts commit 8bb7ff12a91429eb76e093b517ae810b146448fe.
> 
> Commit 8bb7ff12a914 ("PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro")
> updated the Tegra PCI driver to use the macro PCI_CONF1_EXT_ADDRESS()
> instead of a local function in the Tegra PCI driver. This is breaking
> PCI for some Tegra platforms because, when calculating the offset value,
> the mask applied to the lower 8-bits changed from 0xff to 0xfc. For now,
> fix this by reverting this commit.
> 
> Fixes: 8bb7ff12a914 ("PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

Bjorn,

can we send it upstream for one of the upcoming -rcX please ?

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 24478ae5a345..8e323e93be91 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -415,6 +415,13 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
>   * address (access to which generates correct config transaction) falls in
>   * this 4 KiB region.
>   */
> +static unsigned int tegra_pcie_conf_offset(u8 bus, unsigned int devfn,
> +					   unsigned int where)
> +{
> +	return ((where & 0xf00) << 16) | (bus << 16) | (PCI_SLOT(devfn) << 11) |
> +	       (PCI_FUNC(devfn) << 8) | (where & 0xff);
> +}
> +
>  static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>  					unsigned int devfn,
>  					int where)
> @@ -436,9 +443,7 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>  		unsigned int offset;
>  		u32 base;
>  
> -		offset = PCI_CONF1_EXT_ADDRESS(bus->number, PCI_SLOT(devfn),
> -					       PCI_FUNC(devfn), where) &
> -			 ~PCI_CONF1_ENABLE;
> +		offset = tegra_pcie_conf_offset(bus->number, devfn, where);
>  
>  		/* move 4 KiB window to offset within the FPCI region */
>  		base = 0xfe100000 + ((offset & ~(SZ_4K - 1)) >> 8);
> -- 
> 2.25.1
> 
