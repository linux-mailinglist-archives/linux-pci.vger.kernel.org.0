Return-Path: <linux-pci+bounces-40373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437DDC372E8
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 18:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163E1685123
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA423358B3;
	Wed,  5 Nov 2025 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8xESqtB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7A23EAA4;
	Wed,  5 Nov 2025 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363439; cv=none; b=uwAmI/BIpicFyJoS+duzk1UXR01nFXOYqUcbZdmV7n9wAHgxj7CCiNZsEyyrv4h20bsVltP3uBPvsMr+Py2DBBrajJSTeUpwmQvdximtz42QpgtiAAr9UDcQFmokOXWg6DPDybhfBdcJ8m7OVGixqmVPWWzwoNektPaYVuQrfFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363439; c=relaxed/simple;
	bh=zYzES0C46I5oaK/IMxZNYFdLG7G3HDGtdUjOFFV3sZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVnaLK0w76tJRdEbwcCdANzRy5LngQjayE1Qyo3eU8x/t/aNu1F2qKkYhssZMTJzDIAf0CpWBLmP0gP0g4TtYfQCPls27qTX56r9Qk7diI7FFPvJQHbDLmsaEPMlYPLqRnYfjB2O274BJTDEEFoPrZDxV1bYM6p1Cs3FnWt9YV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8xESqtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F78C4CEF8;
	Wed,  5 Nov 2025 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762363438;
	bh=zYzES0C46I5oaK/IMxZNYFdLG7G3HDGtdUjOFFV3sZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8xESqtBwpjaZ4m9f2ZDJN5gPsDifp+UfvU3rzrsSEnf0GikBshBw5nFVFuwF07ck
	 0yBwVY6pmNe9jJeH5oxPaak/+/+HEtErZOVBL1DJnyC0fOcFQs0ygwLPSeu3u03xd5
	 4w0ngjerQEEghhRcnm6x70rCECwLZMn6n5NIp8BCXudGSoXeeOjtOyVOggqmhpUs/g
	 ehWHzELGJtAT9FMLNfUPsYTM6sZqtSYbRFZmEG9QHb2YTdZDrMAzvoOZWhzcrIXnk0
	 EZnAjCx00Jjnj3+Ioa134/nk/7XNVcOWRrmMmmB6+RR8iuCs/ml3MUzfyn1bbfnRSD
	 eLhcmZU6qIgwQ==
Date: Wed, 5 Nov 2025 22:53:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, christian.bruel@foss.st.com, 
	krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com, shradha.t@samsung.com, 
	thippeswamy.havalige@amd.com, inochiama@gmail.com, fan.ni@samsung.com, cassel@kernel.org, 
	kishon@kernel.org, 18255117159@163.com, rongqianfeng@vivo.com, jirislaby@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v5 4/4] PCI: keystone: Add support to build as a loadable
 module
Message-ID: <fkzokskbjklt6atqrpwc46zsjr5ptpuynzhx4kvfurr4h37kae@rwcqljsjvzl6>
References: <20251029080547.1253757-1-s-vadapalli@ti.com>
 <20251029080547.1253757-5-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029080547.1253757-5-s-vadapalli@ti.com>

On Wed, Oct 29, 2025 at 01:34:52PM +0530, Siddharth Vadapalli wrote:
> The 'pci-keystone.c' driver is the application/glue/wrapper driver for the
> Designware PCIe Controllers on TI SoCs. Now that all of the helper APIs
> that the 'pci-keystone.c' driver depends upon have been exported for use,
> enable support to build the driver as a loadable module.
> 
> Additionally, the functions marked by the '__init' keyword may be invoked:
> a) After a probe deferral
> OR
> b) During a delayed probe - Delay attributed to driver being built as a
>    loadable module
> 
> In both of the cases mentioned above, the '__init' memory will be freed
> before the functions are invoked. This results in an exception of the form:
> 
> 	Unable to handle kernel paging request at virtual address ...
> 	Mem abort info:
> 	...
> 	pc : ks_pcie_host_init+0x0/0x540
> 	lr : dw_pcie_host_init+0x170/0x498
> 	...
> 	ks_pcie_host_init+0x0/0x540 (P)
> 	ks_pcie_probe+0x728/0x84c
> 	platform_probe+0x5c/0x98
> 	really_probe+0xbc/0x29c
> 	__driver_probe_device+0x78/0x12c
> 	driver_probe_device+0xd8/0x15c
> 	...
> 
> To address this, introduce a new function namely 'ks_pcie_init()' to
> register the 'fault handler' while removing the '__init' keyword from
> existing functions.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> v4:
> https://lore.kernel.org/r/20251022095724.997218-5-s-vadapalli@ti.com/
> Changes since v4:
> - To fix the build error on ARM32 platforms as reported at:
>   https://lore.kernel.org/r/202510281008.jw19XuyP-lkp@intel.com/
>   patch 4 in the series has been updated by introducing a new config
>   named "PCI_KEYSTONE_TRISTATE" which allows building the driver as
>   a loadable module. Additionally, this newly introduced config can
>   be enabled only for non-ARM32 platforms. As a result, ARM32 platforms
>   continue using the existing PCI_KEYSTONE config which is a bool, while
>   ARM64 platforms can use PCI_KEYSTONE_TRISTATE which is a tristate, and
>   can optionally enabled loadable module support being enabled by this
>   series.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/dwc/Kconfig        | 15 +++--
>  drivers/pci/controller/dwc/Makefile       |  3 +
>  drivers/pci/controller/dwc/pci-keystone.c | 78 +++++++++++++----------
>  3 files changed, 59 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 349d4657393c..c5bc2f0b1f39 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -482,15 +482,21 @@ config PCI_DRA7XX_EP
>  	  to enable device-specific features PCI_DRA7XX_EP must be selected.
>  	  This uses the DesignWare core.
>  
> +# ARM32 platforms use hook_fault_code() and cannot support loadable module.
>  config PCI_KEYSTONE
>  	bool
>  
> +# On non-ARM32 platforms, loadable module can be supported.
> +config PCI_KEYSTONE_TRISTATE
> +	tristate
> +
>  config PCI_KEYSTONE_HOST
> -	bool "TI Keystone PCIe controller (host mode)"
> +	tristate "TI Keystone PCIe controller (host mode)"
>  	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
> -	select PCI_KEYSTONE
> +	select PCI_KEYSTONE if ARM
> +	select PCI_KEYSTONE_TRISTATE if !ARM

Wouldn't below change work for you?

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 349d4657393c..b1219e7136c9 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -486,8 +486,9 @@ config PCI_KEYSTONE
        bool
 
 config PCI_KEYSTONE_HOST
-       bool "TI Keystone PCIe controller (host mode)"
+       tristate "TI Keystone PCIe controller (host mode)"
        depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
+       default y if ARCH_KEYSTONE
        depends on PCI_MSI
        select PCIE_DW_HOST
        select PCI_KEYSTONE

- Mani

-- 
மணிவண்ணன் சதாசிவம்

