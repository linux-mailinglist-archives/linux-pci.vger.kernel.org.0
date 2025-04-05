Return-Path: <linux-pci+bounces-25324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8126A7C9E3
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 17:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3B93B4DFE
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838EE148FE6;
	Sat,  5 Apr 2025 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTrFKitY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203E3FC3;
	Sat,  5 Apr 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743866901; cv=none; b=VZlRKA08FJoitYF8WgzjUCV76dRqHnGYttbeTrXYO1f61JkVK0JN9S9jai3qV+UwrYF02vUUbKMgHDbZ/8+/mK58tAtUqFkgcua1MoQ7M1jcarHLuXaoOUcgkjL2gCwbC6qMFh/5K4qljt4KneITi1Uxdpp0HTUSyC3c+hdFQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743866901; c=relaxed/simple;
	bh=hwc0gZgs6DzIk2bByG1v/PubhTOnOo07HqlUuzp8GiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IoTh5E9qYkEXTAf50a38gjTlXdSle4SDDQif7QMXu8YzSchRE66BH1ifx7MrdJTka7xpYzugRW5ssQNVKYQ4IPYty7f3BshsvVDvd0Fu8TnA8AZvHRFJ0PR4UXAUi1IwZ28M9pNNJT5J7S2sncDzUvsVy4dyxZvG0xdFkUyN4NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTrFKitY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBE2C4CEE4;
	Sat,  5 Apr 2025 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743866900;
	bh=hwc0gZgs6DzIk2bByG1v/PubhTOnOo07HqlUuzp8GiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OTrFKitYqb8JtrDtDIoct+GjsJER0uLO3nnEbDP1rIDz9KvwhboVEbKIcxqX7h2M/
	 yYg+q5J4PpU66PjWpwacjHabHd4AwinZUyCB4Z27tQUvIFtxwHpIG6pZgga+GZRUVM
	 ZBKS9XVah0M2WM7xDyodwRyxu7GbvH0dg1FAlNtbOWLXR3HWfNWa6TKI6KacXnXwrY
	 /UHQ7s/FviT9lnQ+C8HDhU/luXYb1bNKI4IeUsJfxrkQdo896uy8e9GDJAdgQU4ATT
	 bFp61pLZhct5VLI5Fbq3XWu5f76x3JcMfmu5JnnaSaxoK9Rr0n6rvhUfKTKLth/LP2
	 QYvO6MBXpnhNw==
Date: Sat, 5 Apr 2025 10:28:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	thierry.reding@gmail.com, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jonathanh@nvidia.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH] pci: tegra194: Fix debugfs cleanup for !CONFIG_PCIEASPM
Message-ID: <20250405152818.GA107831@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405145459.26800-1-18255117159@163.com>

Follow subject line capitalization convention.

On Sat, Apr 05, 2025 at 10:54:59PM +0800, Hans Zhang wrote:
> When CONFIG_PCIEASPM is disabled, debugfs entries are not created, but
> tegra_pcie_dw_remove() and tegra_pcie_dw_shutdown() unconditionally call
> debugfs_remove_recursive(), leading to potential NULL pointer operations.
> 
> Introduce deinit_debugfs() to wrap debugfs_remove_recursive(), which is
> stubbed for !CONFIG_PCIEASPM. Use this function during removal/shutdown to
> ensure debugfs cleanup only occurs when entries were initialized.
> 
> This prevents kernel warnings and instability when ASPM support is
> disabled.

This looks like there should be a Fixes: tag to connect this to the
commit that introduced the problem.

If this is something that broke with the v6.15 merge window, we should
include this in v6.15 via pci/for-linus.  If this broke earlier, we
would have to decide whether pci/for-linus is still appropriate or a
stable tag.

We did merge some debugfs things for v6.15, but I don't see anything
specific to pcie-tegra194.c, so I'm confused about why this fix would
be in pcie-tegra194.c instead of some more generic place.

> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 5103995cd6c7..d762e733c2d8 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -716,11 +716,20 @@ static void init_debugfs(struct tegra_pcie_dw *pcie)
>  	debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", pcie->debugfs,
>  				    aspm_state_cnt);
>  }
> +
> +static void deinit_debugfs(struct tegra_pcie_dw *pcie)
> +{
> +	if (!pcie->debugfs)
> +		return;
> +
> +	debugfs_remove_recursive(pcie->debugfs);
> +}
>  #else
>  static inline void disable_aspm_l12(struct tegra_pcie_dw *pcie) { return; }
>  static inline void disable_aspm_l11(struct tegra_pcie_dw *pcie) { return; }
>  static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
>  static inline void init_debugfs(struct tegra_pcie_dw *pcie) { return; }
> +static inline void deinit_debugfs(struct tegra_pcie_dw *pcie) { return; }
>  #endif
>  
>  static void tegra_pcie_enable_system_interrupts(struct dw_pcie_rp *pp)
> @@ -2289,7 +2298,7 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
>  		if (!pcie->link_state)
>  			return;
>  
> -		debugfs_remove_recursive(pcie->debugfs);
> +		deinit_debugfs(pcie->debugfs);
>  		tegra_pcie_deinit_controller(pcie);
>  		pm_runtime_put_sync(pcie->dev);
>  	} else {
> @@ -2408,7 +2417,7 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
>  		if (!pcie->link_state)
>  			return;
>  
> -		debugfs_remove_recursive(pcie->debugfs);
> +		deinit_debugfs(pcie->debugfs);
>  		tegra_pcie_downstream_dev_to_D0(pcie);
>  
>  		disable_irq(pcie->pci.pp.irq);
> 
> base-commit: a8662bcd2ff152bfbc751cab20f33053d74d0963
> -- 
> 2.25.1
> 

