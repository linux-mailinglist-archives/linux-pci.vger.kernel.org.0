Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8113659A1
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 15:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhDTNQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 09:16:41 -0400
Received: from foss.arm.com ([217.140.110.172]:34694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhDTNQk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 09:16:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CB311478;
        Tue, 20 Apr 2021 06:16:09 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CAF53F792;
        Tue, 20 Apr 2021 06:16:08 -0700 (PDT)
Date:   Tue, 20 Apr 2021 14:16:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kernel-team@android.com, Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] PCI: tegra: Restore MSI enable state on resume
Message-ID: <20210420131605.GB5734@lpieralisi>
References: <20210420130526.531138-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420130526.531138-1-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 20, 2021 at 02:05:26PM +0100, Marc Zyngier wrote:
> When going into suspend, the Tegra MSI controller loses its
> state. Restore the MSI allocation on resume so that PCI devices
> are usable again.
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 973a28677e39 ("PCI: tegra: Convert to MSI domains")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Squashed with the Fixes: commit, updated my pci/msi branch with it
and pushed out.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index eaba7b2fab4a..507b23d43ad1 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -1802,13 +1802,19 @@ static void tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>  {
>  	const struct tegra_pcie_soc *soc = pcie->soc;
>  	struct tegra_msi *msi = &pcie->msi;
> -	u32 reg;
> +	u32 reg, msi_state[INT_PCI_MSI_NR / 32];
> +	int i;
>  
>  	afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
>  	afi_writel(pcie, msi->phys, AFI_MSI_AXI_BAR_ST);
>  	/* this register is in 4K increments */
>  	afi_writel(pcie, 1, AFI_MSI_BAR_SZ);
>  
> +	/* Restore the MSI allocation state */
> +	bitmap_to_arr32(msi_state, msi->used, INT_PCI_MSI_NR);
> +	for (i = 0; i < ARRAY_SIZE(msi_state); i++)
> +		afi_writel(pcie, msi_state[i], AFI_MSI_EN_VEC(i));
> +
>  	/* and unmask the MSI interrupt */
>  	reg = afi_readl(pcie, AFI_INTR_MASK);
>  	reg |= AFI_INTR_MASK_MSI_MASK;
> -- 
> 2.30.2
> 
