Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8F1371E8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 16:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgAJPzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 10:55:24 -0500
Received: from foss.arm.com ([217.140.110.172]:47340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgAJPzY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jan 2020 10:55:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CFD330E;
        Fri, 10 Jan 2020 07:55:23 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E4183F6C4;
        Fri, 10 Jan 2020 07:55:22 -0800 (PST)
Date:   Fri, 10 Jan 2020 15:55:20 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2] PCI: tegra: Fix afi_pex2_ctrl reg offset for Tegra30
Message-ID: <20200110155519.GB29372@e121166-lin.cambridge.arm.com>
References: <20200107081402.213149-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107081402.213149-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 07, 2020 at 09:14:02AM +0100, Marcel Ziswiler wrote:
> Fix AFI_PEX2_CTRL reg offset for Tegra30 by moving it from the Tegra20
> SoC struct where it erroneously got added. This fixes the AFI_PEX2_CTRL
> reg offset being uninitialised subsequently failing to bring up the
> third PCIe port.
> 
> Fixes: adb2653b3d2e ("PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of SoC struct")
> 
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> ---
> 
> Changes in v2:
> - Fix recipient list concerning CC: and To: lines as suggested by
>   Thierry.
> - Fix subject line and commit message to adhere to standard formatting
>   rules as suggested by Thierry.
> - Add Thierry's Acked-by tag.
> - Add standard Fixes tag as suggested by Andrew.
> 
>  drivers/pci/controller/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/tegra, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 090b632965e2..ac93f5a0398e 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2499,7 +2499,6 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>  	.num_ports = 2,
>  	.ports = tegra20_pcie_ports,
>  	.msi_base_shift = 0,
> -	.afi_pex2_ctrl = 0x128,
>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
>  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_DIV10,
>  	.pads_refclk_cfg0 = 0xfa5cfa5c,
> @@ -2528,6 +2527,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>  	.num_ports = 3,
>  	.ports = tegra30_pcie_ports,
>  	.msi_base_shift = 8,
> +	.afi_pex2_ctrl = 0x128,
>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>  	.pads_refclk_cfg0 = 0xfa5cfa5c,
> -- 
> 2.24.1
> 
