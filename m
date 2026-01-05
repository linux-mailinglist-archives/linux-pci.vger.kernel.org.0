Return-Path: <linux-pci+bounces-43986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B62CF27D7
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 09:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E495306325C
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 08:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9332D0CD;
	Mon,  5 Jan 2026 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeDnVMg3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1332AAD8;
	Mon,  5 Jan 2026 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601445; cv=none; b=DGaiQRECiSBJA/IWiX0ijasaCto/pOGOeIXSmgbs7cEASxkVEqI/L/sip8CwMtsWBuuOxEtF8MCi7A03cv4Vhcy/SIzisvLteQ1DaWb0p6XyCyCaeXG8uTU8zZgUZrEnHnH/Dk0RvgJdFNuoF816bvhm4icYtCmjl6NvppoH3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601445; c=relaxed/simple;
	bh=3Y6F4fQWnPbO0vYy6DJ+KvM5lIHIdCDkbXfmQlit6sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftInKuOdBs2Lv/0f1bBIviiKMwemDh/MgxoaDtwaJZwAUU4s7WTyN6hJ8w8uyMrKio0xg3w9TOj8YaY9mdoWrSAUSTZ+k52d9O4pl2Sw7RhGNpyF2ZUNSydFJJiDebXkHbQIFx3p0SnNOkgDpgPwasrZ0GLoKmLi1fGxplQDH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeDnVMg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CE1C116D0;
	Mon,  5 Jan 2026 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767601443;
	bh=3Y6F4fQWnPbO0vYy6DJ+KvM5lIHIdCDkbXfmQlit6sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KeDnVMg3nxqzQTuy3J8FthdiJAzVxNym5GUPS8eSF/zXDELUXjr/p6tH+ut1aU957
	 reLiqw8+KJuh9SIyQ58fmBWLofFPri60oLsz4fSr581nwh/Rp2N3G0C3AZe8E0TT5W
	 KpIQyG5bFckzXTtCJ8iCqaT8zxx5axkQQhEvjZaJHMmPV7AGLD2oca1e+j3RCfNJ7M
	 VYhU76U0+YGyJobvWkarm/EJo3rp3nTC+MKDpsrvhvf375YqJ6IpS6WURJNZhC+HnR
	 UyxKhLvvjQXMBxX0b3Gp03QorPnU30BlJt9BaR/7+BDtLS7vhqEoys1n6oPzJhHbGS
	 w7ySW4Myk+vpA==
Date: Mon, 5 Jan 2026 13:53:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manikandan K Pillai <mpillai@cadence.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Hans Zhang <hans.zhang@cixtech.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: fix build-time dependencies
Message-ID: <kbzbnp3yxsullapa5y3yqqlvyimjv7xz2sedzazvknttajm5w4@b2rfrcmwaez4>
References: <20251204095530.1033142-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251204095530.1033142-1-arnd@kernel.org>

On Thu, Dec 04, 2025 at 10:55:22AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The split of the the cadence pcie controller driver into three modules
> does not match the Kconfig structure, as the common symbol tries to
> call into the more specific ones. If one is built-in but the other is
> a loadable module, we get one of these link errors:
> 
> arm-linux-gnueabi-ld: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
> pcie-cadence-plat.c:(.text+0x33c): undefined reference to `cdns_pcie_host_setup'
> arm-linux-gnueabi-ld: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
> pcie-cadence-plat.c:(.text+0x264): undefined reference to `cdns_pcie_ep_setup'
> 
> Move the two parts back into a common module to ensure they can always
> link, while keeping the optional parts out of possible.
> 
> Fixes: 611627a4e5e4 ("PCI: cadence: Add module support for platform controller driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> We had discussed this on the list earlier, but I independently ran into
> the problem while build-testing. This was the version that actually ended
> up passing randconfig testing for me.
> ---
>  drivers/pci/controller/cadence/Kconfig  | 15 +++++++++------
>  drivers/pci/controller/cadence/Makefile | 12 +++++++++---
>  2 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 9e651d545973..978ffe9a1da2 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -7,16 +7,14 @@ config PCIE_CADENCE
>  	tristate
>  
>  config PCIE_CADENCE_HOST
> -	tristate
> +	bool
>  	depends on OF
>  	select IRQ_DOMAIN
> -	select PCIE_CADENCE
>  
>  config PCIE_CADENCE_EP
> -	tristate
> +	bool
>  	depends on OF
>  	depends on PCI_ENDPOINT
> -	select PCIE_CADENCE

Atleast PCIE_CADENCE_EP calls the APIs exported by pcie-cadence.c. So shouldn't
this one select PCIE_CADENCE logically?

- Mani

>  
>  config PCIE_CADENCE_PLAT
>  	tristate
> @@ -24,6 +22,7 @@ config PCIE_CADENCE_PLAT
>  config PCIE_CADENCE_PLAT_HOST
>  	tristate "Cadence platform PCIe controller (host mode)"
>  	depends on OF
> +	select PCIE_CADENCE
>  	select PCIE_CADENCE_HOST
>  	select PCIE_CADENCE_PLAT
>  	help
> @@ -35,6 +34,7 @@ config PCIE_CADENCE_PLAT_EP
>  	tristate "Cadence platform PCIe controller (endpoint mode)"
>  	depends on OF
>  	depends on PCI_ENDPOINT
> +	select PCIE_CADENCE
>  	select PCIE_CADENCE_EP
>  	select PCIE_CADENCE_PLAT
>  	help
> @@ -45,6 +45,7 @@ config PCIE_CADENCE_PLAT_EP
>  config PCI_SKY1_HOST
>  	tristate "CIX SKY1 PCIe controller (host mode)"
>  	depends on OF && (ARCH_CIX || COMPILE_TEST)
> +	select PCIE_CADENCE
>  	select PCIE_CADENCE_HOST
>  	select PCI_ECAM
>  	help
> @@ -60,6 +61,7 @@ config PCI_SKY1_HOST
>  config PCIE_SG2042_HOST
>  	tristate "Sophgo SG2042 PCIe controller (host mode)"
>  	depends on OF && (ARCH_SOPHGO || COMPILE_TEST)
> +	select PCIE_CADENCE
>  	select PCIE_CADENCE_HOST
>  	help
>  	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
> @@ -68,14 +70,14 @@ config PCIE_SG2042_HOST
>  
>  config PCI_J721E
>  	tristate
> -	select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
> -	select PCIE_CADENCE_EP if PCI_J721E_EP != n
> +	select PCIE_CADENCE
>  
>  config PCI_J721E_HOST
>  	tristate "TI J721E PCIe controller (host mode)"
>  	depends on ARCH_K3 || COMPILE_TEST
>  	depends on OF
>  	select PCI_J721E
> +	select PCIE_CADENCE_HOST
>  	help
>  	  Say Y here if you want to support the TI J721E PCIe platform
>  	  controller in host mode. TI J721E PCIe controller uses Cadence PCIe
> @@ -87,6 +89,7 @@ config PCI_J721E_EP
>  	depends on OF
>  	depends on PCI_ENDPOINT
>  	select PCI_J721E
> +	select PCIE_CADENCE_EP
>  	help
>  	  Say Y here if you want to support the TI J721E PCIe platform
>  	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index b8ec1cecfaa8..139ac0a0de6f 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -1,11 +1,17 @@
>  # SPDX-License-Identifier: GPL-2.0
>  pcie-cadence-mod-y := pcie-cadence-hpa.o pcie-cadence.o
> +obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
> +
> +ifdef CONFIG_PCIE_CADENCE_HOST
>  pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-cadence-host-hpa.o
> +obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence-host-mod.o
> +endif
> +
> +ifdef CONFIG_PCIE_CADENCE_EP
>  pcie-cadence-ep-mod-y := pcie-cadence-ep.o
> +obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence-ep-mod.o
> +endif
>  
> -obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
> -obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
> -obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>  obj-$(CONFIG_PCI_J721E) += pci-j721e.o
>  obj-$(CONFIG_PCIE_SG2042_HOST) += pcie-sg2042.o
> -- 
> 2.39.5
> 

-- 
மணிவண்ணன் சதாசிவம்

