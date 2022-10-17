Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF2C6014F9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiJQRZd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 13:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJQRZC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 13:25:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614CF360AC;
        Mon, 17 Oct 2022 10:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B95DB819D6;
        Mon, 17 Oct 2022 17:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C543C433D6;
        Mon, 17 Oct 2022 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027484;
        bh=6BATPQanngco/0fweasySofKyJs7kJxtxF116yKFSxY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YKv4icEW3rp/wVd3e3jMyKd4vIOQSa+EYekRSBWS1N5Wtvqq3EF/LCQLkZBrmax1R
         yxN7O6CzKB0PVfMDfqoBJ/cac7k78Zx2b0xL7VFI9Dy4z7IuGwKuFc9YgorFuE+C7g
         SQKJo6RrqDEgmsRdD9UvpFfEVp6QpEjEGE4EH+LOivQpJXblYYru1yOitjctjNmFGS
         ttJ4K0h3V9gC9+S+2QJnJypnPTox45c6wVb46h/bCj68g+5SPBz+3A5VrOgaFyYwxW
         yrGNkUQH7/R3AgjVSoCktzVJ75IC+vdAi4jYmkYQGiYWI8vgAqELRWJhJIdM5qre9p
         0SYo6c2mnhK7Q==
Date:   Mon, 17 Oct 2022 12:24:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro"
Message-ID: <20221017172442.GA3715354@bhelgaas>
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

Applied with acks from Thierry and Lorenzo to for-linus for v6.1,
thanks!

> ---
>  drivers/pci/controller/pci-tegra.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
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
