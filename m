Return-Path: <linux-pci+bounces-38445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BC7BE8143
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 12:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285A9621BDA
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0802D739F;
	Fri, 17 Oct 2025 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrM7th9d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B72D6E5B;
	Fri, 17 Oct 2025 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697192; cv=none; b=EE3ZcAskmrVmCaBaNJjC0mY14q0YXFrK8RbArQxkMd2/SAD20cA5s36nl6E3Cb+aIGNB7x6U8ACBNqeDQjXN7b9y8FMhyUvxsbn/jVCsRzznIxOX4d72CwzLXJWfUHwuGe/+cdWDHrVGxGq24sMPO4lrQ9jywiVZjuelMbQTccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697192; c=relaxed/simple;
	bh=UlVJvvJTFUTe7yzsfT9aVKl3PpSSUeDPxxdIcnrjqZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvbSrSoLWDHi8w9w0Nymy1pCXAaavItrBJmlXtiunMIWe0JDAcyVDAhZ87KsXDm14uZm5QFfV90Ti5wHOiZS/JfXA/12Odo8B+2Fv4EYyyAgVeG+fpTd8jv7BgdV7gN7pcsS7ryQKBrg/FP9PGqcTpDM0h6ZJUy0fSwRhrx+Qrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrM7th9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2B1C4CEE7;
	Fri, 17 Oct 2025 10:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760697192;
	bh=UlVJvvJTFUTe7yzsfT9aVKl3PpSSUeDPxxdIcnrjqZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrM7th9d2+F95CYQjBEYtmy0bQ5YWxqsZ4hUgq1JEFE3JeTQd1vF9mbFJbS48nYnj
	 rxdDRbyK42U4xbWt7Vy0Vugz4m4EAVvCP+ulBlW+1bzCUXgLhd9Bfhk1Y7+Hvcq3rD
	 zXnzIddo/t5lyhXK3+knx7Komubs7O7UAT9encgaoCsSgprPyb2etXOmwjVhxodqEP
	 46dTQLrn3mTIYATsRj8ogGfO3tpgAK6/GsDAlkrWsA67yUdDgrNxUFwpBUkDfxbA1U
	 V7t3ybzrFA8tzsMALp2SKQM2lePmiM2mEhvDbUrmgIWtsvmxwWHvAbY8Vo00qAPQyZ
	 /l6DP9rgxkVRg==
Date: Fri, 17 Oct 2025 16:03:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christian Bruel <christian.bruel@foss.st.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Inochi Amaoto <inochiama@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Mayank Rana <mayank.rana@oss.qualcomm.com>, 
	Nam Cao <namcao@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Shradha Todi <shradha.t@samsung.com>, Thippeswamy Havalige <thippeswamy.havalige@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: controller: Mark controllers which cannot do
 lockless config access with !PCI_LOCKLESS_CONFIG
Message-ID: <mxlpkktc34utdc6tr6apf4g5t3cdq6ckdbsern5s24t2bxlsva@e6e667l2wd2j>
References: <20250925135014.66865-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925135014.66865-1-marek.vasut+renesas@mailbox.org>

On Thu, Sep 25, 2025 at 03:49:45PM +0200, Marek Vasut wrote:
> Add 'depends on !PCI_LOCKLESS_CONFIG' to controllers which cannot do config
> access without PCI subsystem level spinlock.

May I know on what basis you have added the Kconfig dependency? Because, all
non-x86 and um drivers are going to suffer from the race if PCI_LOCKLESS_CONFIG
is selected. But you've only added the dependency to selected drivers.

- Mani

> If PCI_LOCKLESS_CONFIG is ever
> enabled, those controllers would have to be updated accordingly.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Christian Bruel <christian.bruel@foss.st.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Inochi Amaoto <inochiama@gmail.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Mayank Rana <mayank.rana@oss.qualcomm.com>
> Cc: Nam Cao <namcao@linutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Shradha Todi <shradha.t@samsung.com>
> Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> NOTE: I hope I got them all
> ---
>  drivers/pci/controller/Kconfig      | 6 ++++++
>  drivers/pci/controller/dwc/Kconfig  | 5 +++++
>  drivers/pci/controller/plda/Kconfig | 1 +
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 41748d083b933..1a6e937cca929 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -12,6 +12,7 @@ config PCI_AARDVARK
>  	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
>  	depends on OF
>  	depends on PCI_MSI
> +	depends on !PCI_LOCKLESS_CONFIG
>  	select PCI_BRIDGE_EMUL
>  	select IRQ_MSI_LIB
>  	help
> @@ -205,6 +206,7 @@ config PCIE_MEDIATEK_GEN3
>  	tristate "MediaTek Gen3 PCIe controller"
>  	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
>  	depends on PCI_MSI
> +	depends on !PCI_LOCKLESS_CONFIG
>  	select IRQ_MSI_LIB
>  	help
>  	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
> @@ -244,6 +246,7 @@ config PCIE_RCAR_HOST
>  	bool "Renesas R-Car PCIe controller (host mode)"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on PCI_MSI
> +	depends on !PCI_LOCKLESS_CONFIG
>  	select IRQ_MSI_LIB
>  	help
>  	  Say Y here if you want PCIe controller support on R-Car SoCs in host
> @@ -332,6 +335,7 @@ config PCIE_XILINX_DMA_PL
>  	bool "Xilinx DMA PL PCIe host bridge support"
>  	depends on ARCH_ZYNQMP || COMPILE_TEST
>  	depends on PCI_MSI
> +	depends on !PCI_LOCKLESS_CONFIG
>  	select PCI_HOST_COMMON
>  	select IRQ_MSI_LIB
>  	help
> @@ -344,6 +348,7 @@ config PCIE_XILINX_NWL
>  	bool "Xilinx NWL PCIe controller"
>  	depends on ARCH_ZYNQMP || COMPILE_TEST
>  	depends on PCI_MSI
> +	depends on !PCI_LOCKLESS_CONFIG
>  	select IRQ_MSI_LIB
>  	help
>  	 Say 'Y' here if you want kernel support for Xilinx
> @@ -354,6 +359,7 @@ config PCIE_XILINX_NWL
>  config PCIE_XILINX_CPM
>  	bool "Xilinx Versal CPM PCI controller"
>  	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on !PCI_LOCKLESS_CONFIG
>  	select PCI_HOST_COMMON
>  	help
>  	  Say 'Y' here if you want kernel support for the
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 34abc859c1071..8eab27775195f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -2,6 +2,7 @@
>  
>  menu "DesignWare-based PCIe controllers"
>  	depends on PCI
> +	depends on !PCI_LOCKLESS_CONFIG
>  
>  config PCIE_DW
>  	bool
> @@ -322,6 +323,7 @@ config PCIE_RCAR_GEN4_HOST
>  	tristate "Renesas R-Car Gen4 PCIe controller (host mode)"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on PCI_MSI
> +	depends on !PCI_LOCKLESS_CONFIG
>  	select PCIE_DW_HOST
>  	select PCIE_RCAR_GEN4
>  	help
> @@ -390,6 +392,7 @@ config PCIE_UNIPHIER
>  	depends on ARCH_UNIPHIER || COMPILE_TEST
>  	depends on OF && HAS_IOMEM
>  	depends on PCI_MSI
> +	depends on !PCI_LOCKLESS_CONFIG
>  	select PCIE_DW_HOST
>  	help
>  	  Say Y here if you want PCIe host controller support on UniPhier SoCs.
> @@ -410,6 +413,7 @@ config PCIE_SOPHGO_DW
>  	depends on ARCH_SOPHGO || COMPILE_TEST
>  	depends on PCI_MSI
>  	depends on OF
> +	depends on !PCI_LOCKLESS_CONFIG
>  	select PCIE_DW_HOST
>  	help
>  	  Say Y here if you want PCIe host controller support on
> @@ -488,6 +492,7 @@ config PCI_KEYSTONE_HOST
>  	bool "TI Keystone PCIe controller (host mode)"
>  	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>  	depends on PCI_MSI
> +	depends on !PCI_LOCKLESS_CONFIG
>  	select PCIE_DW_HOST
>  	select PCI_KEYSTONE
>  	help
> diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
> index 62120101139cb..2a400678312eb 100644
> --- a/drivers/pci/controller/plda/Kconfig
> +++ b/drivers/pci/controller/plda/Kconfig
> @@ -10,6 +10,7 @@ config PCIE_PLDA_HOST
>  config PCIE_MICROCHIP_HOST
>  	tristate "Microchip AXI PCIe controller"
>  	depends on PCI_MSI && OF
> +	depends on !PCI_LOCKLESS_CONFIG
>  	select PCI_HOST_COMMON
>  	select PCIE_PLDA_HOST
>  	help
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்

