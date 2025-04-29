Return-Path: <linux-pci+bounces-26984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD357AA052C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 10:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DF9189C527
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198E7277818;
	Tue, 29 Apr 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/fHwv04"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5284275101;
	Tue, 29 Apr 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913954; cv=none; b=c0Dp73HrKiDscinCYWMhoI2S8b5mxqlMeMOMjbLPqrzjF0N5OEutnvjhmZ2j4TNjdyg7RqHHGKUu+2x3k0e4HOjWUFoSOsOX8UEwbpabh893RFtmH86M1kRf5uasAnBeNtQ1r93pH7eh1w2hq6m7lbkU0QBOp3hGh+j7tos4WEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913954; c=relaxed/simple;
	bh=Zjw4u7wLH6353sZ37N5PpAxiSpLykF8oyhhhSu57PzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlVzwKRfNPKqqbO63ex6Kkhl+DPywmalQr9FzCqN4mXvzdr28pvNnmlRDGDd4v6fNfcCdisJnJeplXxHmEFgscsBlxym252PLPclDuxJIhYc8hEO1D43RmoNr2k1FDXOVoR8CZyAEylVU+1YgIX9qJQ7ve44Ewq11ouQav74wS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/fHwv04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A226C4CEE3;
	Tue, 29 Apr 2025 08:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745913953;
	bh=Zjw4u7wLH6353sZ37N5PpAxiSpLykF8oyhhhSu57PzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/fHwv04jrQsqZ5wE1lINXsmCvkieF3LNJ33Tzc+N0d1E29VhYcmc3PoWNhNVKzwX
	 esOimQWVJogF4uBYVZydcZo6yGklfDx1k00EimacfauHMgZJe0OrItqeB+C/u5EQng
	 RXoGrQ1LPBPzQYCP47KBGHOiTzpKcIP5OG/S4ibD2krQju2LOQFT1lr6xNCIo7AaG1
	 13Us/DuCBu7U49TdIxlA2cvAsZLy0xxhKrFst5S6PTu1iJY+OXuN93fn3y1MZGPvRp
	 2D3u6lWlfgvIBeuloXtRsKoqhac8mC6SyWNW35kM6F07jY3M5K8JDkZ5XyATrkL7fI
	 ADAcoUA9lFIDA==
Date: Tue, 29 Apr 2025 10:05:48 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: dwc: Standardize link status check to return
 bool
Message-ID: <aBCIXPc24daPPIxY@ryzen>
References: <20250428171027.13237-1-18255117159@163.com>
 <20250428171027.13237-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428171027.13237-2-18255117159@163.com>

Hello Hans,

On Tue, Apr 29, 2025 at 01:10:25AM +0800, Hans Zhang wrote:
> Modify link_up functions across multiple DWC PCIe controllers to return
> bool instead of int. Simplify conditional checks by directly returning
> logical evaluations. This improves code clarity and aligns with PCIe
> status semantics.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 2 +-
>  drivers/pci/controller/dwc/pci-exynos.c       | 4 ++--
>  drivers/pci/controller/dwc/pci-keystone.c     | 5 ++---
>  drivers/pci/controller/dwc/pci-meson.c        | 6 +++---
>  drivers/pci/controller/dwc/pcie-armada8k.c    | 6 +++---
>  drivers/pci/controller/dwc/pcie-designware.c  | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h  | 4 ++--
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
>  drivers/pci/controller/dwc/pcie-histb.c       | 9 +++------
>  drivers/pci/controller/dwc/pcie-keembay.c     | 2 +-
>  drivers/pci/controller/dwc/pcie-kirin.c       | 7 ++-----
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     | 4 ++--
>  drivers/pci/controller/dwc/pcie-qcom.c        | 2 +-
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 2 +-
>  drivers/pci/controller/dwc/pcie-spear13xx.c   | 7 ++-----
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 2 +-
>  drivers/pci/controller/dwc/pcie-uniphier.c    | 2 +-
>  drivers/pci/controller/dwc/pcie-visconti.c    | 2 +-
>  18 files changed, 30 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 33d6bf460ffe..4ef25d14312b 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -118,7 +118,7 @@ static u64 dra7xx_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
>  	return cpu_addr & DRA7XX_CPU_TO_BUS_ADDR;
>  }
>  
> -static int dra7xx_pcie_link_up(struct dw_pcie *pci)
> +static bool dra7xx_pcie_link_up(struct dw_pcie *pci)
>  {
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>  	u32 reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_PHY_CS);
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index ace736b025b1..d4a25d376b11 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -209,12 +209,12 @@ static struct pci_ops exynos_pci_ops = {
>  	.write = exynos_pcie_wr_own_conf,
>  };
>  
> -static int exynos_pcie_link_up(struct dw_pcie *pci)
> +static bool exynos_pcie_link_up(struct dw_pcie *pci)
>  {
>  	struct exynos_pcie *ep = to_exynos_pcie(pci);
>  	u32 val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_RDLH_LINKUP);
>  
> -	return (val & PCIE_ELBI_XMLH_LINKUP);
> +	return !!(val & PCIE_ELBI_XMLH_LINKUP);

!! is not needed here, or in other places.

When assigning to the bool any non-zero value becomes 1.

!! is usually only needed when needing to store an explicit 1 or 0 in an int.


Kind regards,
Niklas

