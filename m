Return-Path: <linux-pci+bounces-26071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89526A915B9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 09:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000093A50AB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 07:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BCC2206AE;
	Thu, 17 Apr 2025 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGAC/9Be"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039E21E0AD;
	Thu, 17 Apr 2025 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876316; cv=none; b=NNy+cQ8dVrHHkVKrETWCfE6KEZvxQ6sLd2Bm0bBZUsnBx3jUjblTbmPSbQ5paVNShlHYMgW8wSWGSj6ODoyY0QPcwiksdtA+V31XpqmtCJmpNWCQ7FgolAkx2V5Ca5FUSbknBscBMOBGz03GCZDBHJaBpYUnECExCtpAt7G6dzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876316; c=relaxed/simple;
	bh=xdQ49OGT7gqtw3dV/HE2bLNsPQs2ZW7i2WkiE6mwXy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BadhkrTPEbjvCT+HeP+VW6h9mPOUZ6aaZM5gXJDmfybFyzUSTvNyUlXITAmj/ef9SYKOsRrG89HOQCNtOhCgCW7BWf7dxSM6hR8f6+XGZenkBc5UTwcGKTD/q3EHT4ae9WUVRE3keooXV14mZHoJWXNZI2QSlOmfCtTa+bb3LaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGAC/9Be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9554CC4CEE4;
	Thu, 17 Apr 2025 07:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744876315;
	bh=xdQ49OGT7gqtw3dV/HE2bLNsPQs2ZW7i2WkiE6mwXy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGAC/9BeXi4Z7H9ixfodAS+ryCXIIXgNBtVNGX0AGqfunukgZWmT2JpzkUF6xg2es
	 4DBrbvQBCyl2uOTHyfN8U7KQgmgdAnibx8sthY5Mf5wMuBnowLeZWu2TdNiJN0GxyN
	 bSf7D3hfx+0OX5jmglG8LpgekcvNJYzBnKAFO1rFK/OFn6kyuZdvzr0u4DT/okqWxi
	 xxS4YJ3dNkI03Gka6EKVjzkDkBwPZmwSK31wk2FUBYuK68OJqRX6JF5w4ueShLLSiJ
	 MrZzKcQ4p9/LILVt5eMeN1grdnG/ppv3kbooN4V9RhA0bfxBo/29E0CMJq+wXVOG0c
	 W4I8LnYTCVQjw==
Date: Thu, 17 Apr 2025 09:51:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH V3] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <aACzFo2wNYpo4-TN@ryzen>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417074607.2281010-1-vidyas@nvidia.com>

+CC PHY maintainer.

On Thu, Apr 17, 2025 at 01:16:07PM +0530, Vidya Sagar wrote:
> Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
> check, allowing the PCIe controller to be built on Tegra platforms
> beyond Tegra194. Additionally, ensure compatibility by requiring
> ARM64 or COMPILE_TEST.
> 
> Link: https://patchwork.kernel.org/project/linux-pci/patch/20250128044244.2766334-1-vidyas@nvidia.com/
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> v3:
> * Addressed warning from kernel test robot
> 
> v2:
> * Addressed review comments from Niklas Cassel and Manivannan Sadhasivam
> 
>  drivers/pci/controller/dwc/Kconfig | 4 ++--
>  drivers/phy/tegra/Kconfig          | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index d9f0386396ed..815b6e0d6a0c 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -226,7 +226,7 @@ config PCIE_TEGRA194
>  
>  config PCIE_TEGRA194_HOST
>  	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
> -	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> +	depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
>  	select PHY_TEGRA194_P2U
> @@ -241,7 +241,7 @@ config PCIE_TEGRA194_HOST
>  
>  config PCIE_TEGRA194_EP
>  	tristate "NVIDIA Tegra194 (and later) PCIe controller (endpoint mode)"
> -	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> +	depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
>  	select PHY_TEGRA194_P2U
> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
> index f30cfb42b210..342fb736da4b 100644
> --- a/drivers/phy/tegra/Kconfig
> +++ b/drivers/phy/tegra/Kconfig
> @@ -13,7 +13,7 @@ config PHY_TEGRA_XUSB
>  
>  config PHY_TEGRA194_P2U
>  	tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
> -	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || COMPILE_TEST
> +	depends on ARCH_TEGRA || COMPILE_TEST
>  	select GENERIC_PHY
>  	help
>  	  Enable this to support the P2U (PIPE to UPHY) that is part of Tegra 19x
> -- 
> 2.25.1
> 

