Return-Path: <linux-pci+bounces-26214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2907A93664
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 13:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B828A5930
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574CF270EAD;
	Fri, 18 Apr 2025 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1+xi6fE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F01EA945;
	Fri, 18 Apr 2025 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744975141; cv=none; b=cgpeweE6FqjIpw8oA0wgB/e12Zpqhozj7h1GBSkdDDH0Jv87XBu+fTEjBMO8zby6ElZIQlXajQyhas494XOTuYNMhDHp4tegduWpNyWP+g78wmrTPqvTeXvfimtRrw+CCaHlH4yZn9JhI5hSpd8UpUOZflKq/6jHg59eBQSRqJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744975141; c=relaxed/simple;
	bh=32SDoTi4aOppG1pwoCkguBhvjQmwSM3vk39kPbcX9r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilmQbHbQSak1YTHNGdCp3ykqorNaDsLS4TtAkEM4ZlaU5NhIrh7OKvQkSwpewxcZ6spcEQDPRQsOx1/PcXVAWt9mUh2BR0rkFocWCYsUEBNGlsoaIQTKNKpRzuCOvMbsMxCZ6EHtoeYmZReWD//6RnnScxw1PzBtVs8MaLqTOnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1+xi6fE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89F8C4CEEA;
	Fri, 18 Apr 2025 11:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744975140;
	bh=32SDoTi4aOppG1pwoCkguBhvjQmwSM3vk39kPbcX9r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1+xi6fEAlbNF8LnRY6/TnQX/JzaOKKXaki6c+R72ovNVaziZoTomPTvBC677eim7
	 yNZSWyYBHD8Q9jMLwNaKQQwdZePby+StKw26TPui3H1vzQrZBOCLHXtK0sI5suh9mD
	 69k8duFv37hz0s4XM+YvkNSR3smIYEgYl1dRmTXfCkjsgf36XiWBtrgL69KjoNBmqu
	 NyjoRZbAuuoydX4Zn+NdMNJKclPPGmW6pZG1yL954MeaE+m/B5sxDPg0FdTV8ky+Om
	 TKb/oXef/3LSfDIaEFRiuT18K99KVpRMAp5aNbcJ79bIUxxy5UToezodSLFQJhxNyZ
	 yN44WI03msplw==
Date: Fri, 18 Apr 2025 16:48:55 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <aAI1H05leD2L9Eiy@vaman>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
 <aACzFo2wNYpo4-TN@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aACzFo2wNYpo4-TN@ryzen>

On 17-04-25, 09:51, Niklas Cassel wrote:
> +CC PHY maintainer.
> 
> On Thu, Apr 17, 2025 at 01:16:07PM +0530, Vidya Sagar wrote:
> > Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
> > check, allowing the PCIe controller to be built on Tegra platforms
> > beyond Tegra194. Additionally, ensure compatibility by requiring
> > ARM64 or COMPILE_TEST.
> > 
> > Link: https://patchwork.kernel.org/project/linux-pci/patch/20250128044244.2766334-1-vidyas@nvidia.com/
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> > v3:
> > * Addressed warning from kernel test robot
> > 
> > v2:
> > * Addressed review comments from Niklas Cassel and Manivannan Sadhasivam
> > 
> >  drivers/pci/controller/dwc/Kconfig | 4 ++--
> >  drivers/phy/tegra/Kconfig          | 2 +-

can phy and pci be two different patches?

> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index d9f0386396ed..815b6e0d6a0c 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -226,7 +226,7 @@ config PCIE_TEGRA194
> >  
> >  config PCIE_TEGRA194_HOST
> >  	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
> > -	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> > +	depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
> >  	depends on PCI_MSI
> >  	select PCIE_DW_HOST
> >  	select PHY_TEGRA194_P2U
> > @@ -241,7 +241,7 @@ config PCIE_TEGRA194_HOST
> >  
> >  config PCIE_TEGRA194_EP
> >  	tristate "NVIDIA Tegra194 (and later) PCIe controller (endpoint mode)"
> > -	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> > +	depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
> >  	depends on PCI_ENDPOINT
> >  	select PCIE_DW_EP
> >  	select PHY_TEGRA194_P2U
> > diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
> > index f30cfb42b210..342fb736da4b 100644
> > --- a/drivers/phy/tegra/Kconfig
> > +++ b/drivers/phy/tegra/Kconfig
> > @@ -13,7 +13,7 @@ config PHY_TEGRA_XUSB
> >  
> >  config PHY_TEGRA194_P2U
> >  	tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
> > -	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || COMPILE_TEST
> > +	depends on ARCH_TEGRA || COMPILE_TEST
> >  	select GENERIC_PHY
> >  	help
> >  	  Enable this to support the P2U (PIPE to UPHY) that is part of Tegra 19x
> > -- 
> > 2.25.1
> > 

-- 
~Vinod

