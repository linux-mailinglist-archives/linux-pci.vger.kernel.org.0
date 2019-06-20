Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 218C34D3B2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 18:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfFTQ0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 12:26:46 -0400
Received: from foss.arm.com ([217.140.110.172]:47568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfFTQ0p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 12:26:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B541E2B;
        Thu, 20 Jun 2019 09:26:44 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 604CB3F246;
        Thu, 20 Jun 2019 09:26:43 -0700 (PDT)
Date:   Thu, 20 Jun 2019 17:26:38 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V6 18/27] PCI: tegra: Program AFI_CACHE* registers only
 for Tegra20
Message-ID: <20190620162638.GA18771@e121166-lin.cambridge.arm.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190618180206.4908-19-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618180206.4908-19-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 11:31:57PM +0530, Manikanta Maddireddy wrote:
> Cacheable upstream transactions are supported in Tegra20 and Tegra186 only.
> AFI_CACHE* registers are available in Tegra20 to support cacheable upstream
> transactions. In Tegra186, AFI_AXCACHE register is defined instead of
> AFI_CACHE* to be in line with its MSS design. Therefore, program AFI_CACHE*

What's an MSS ?

Lorenzo

> registers only for Tegra20.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V6: No change
> 
> V5: No change
> 
> V4: No change
> 
> V3: Initialized has_cache_bars variable for each soc data structure.
> 
> V2: Used soc variable for comparision instead of compatible string.
> 
>  drivers/pci/controller/pci-tegra.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 3d9028cecc18..a746d963ca36 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -323,6 +323,7 @@ struct tegra_pcie_soc {
>  	bool program_deskew_time;
>  	bool raw_violation_fixup;
>  	bool update_fc_timer;
> +	bool has_cache_bars;
>  	struct {
>  		struct {
>  			u32 rp_ectl_2_r1;
> @@ -932,11 +933,13 @@ static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
>  	afi_writel(pcie, 0, AFI_AXI_BAR5_SZ);
>  	afi_writel(pcie, 0, AFI_FPCI_BAR5);
>  
> -	/* map all upstream transactions as uncached */
> -	afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
> -	afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
> -	afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
> -	afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
> +	if (pcie->soc->has_cache_bars) {
> +		/* map all upstream transactions as uncached */
> +		afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
> +		afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
> +		afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
> +		afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
> +	}
>  
>  	/* MSI translations are setup only when needed */
>  	afi_writel(pcie, 0, AFI_MSI_FPCI_BAR_ST);
> @@ -2441,6 +2444,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>  	.program_deskew_time = false,
>  	.raw_violation_fixup = false,
>  	.update_fc_timer = false,
> +	.has_cache_bars = true,
>  	.ectl.enable = false,
>  };
>  
> @@ -2469,6 +2473,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>  	.program_deskew_time = false,
>  	.raw_violation_fixup = false,
>  	.update_fc_timer = false,
> +	.has_cache_bars = false,
>  	.ectl.enable = false,
>  };
>  
> @@ -2492,6 +2497,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>  	.program_deskew_time = false,
>  	.raw_violation_fixup = true,
>  	.update_fc_timer = false,
> +	.has_cache_bars = false,
>  	.ectl.enable = false,
>  };
>  
> @@ -2515,6 +2521,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>  	.program_deskew_time = true,
>  	.raw_violation_fixup = false,
>  	.update_fc_timer = true,
> +	.has_cache_bars = false,
>  	.ectl = {
>  		.regs = {
>  			.rp_ectl_2_r1 = 0x0000000f,
> @@ -2555,6 +2562,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
>  	.program_deskew_time = false,
>  	.raw_violation_fixup = false,
>  	.update_fc_timer = false,
> +	.has_cache_bars = false,
>  	.ectl.enable = false,
>  };
>  
> -- 
> 2.17.1
> 
