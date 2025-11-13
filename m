Return-Path: <linux-pci+bounces-41160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78360C59858
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95FAD4E9389
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B77C30DD05;
	Thu, 13 Nov 2025 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAeXoZnD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5452FC86C;
	Thu, 13 Nov 2025 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057637; cv=none; b=p+dW7ohmbtTb+b/uIp7tru1O355b3EEDJs03tQsopqZBQUJ3xSY6sKIusC7G4NP1qy/BYdpU0b/HVJF7EjUfTBiYx1RoTGPmhKwi5En4DSv7H79C4oyptmDWZwLF9vLd7inPxKTfim+D3K0ilKMlZm5gi+yoWKu8KNVgBJMKhQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057637; c=relaxed/simple;
	bh=hb/FO4V3eVHR2RnKCICg4vV3cwhuxn5dtsUG3W/ZL3w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FLUFwEKllDYUJ+hMhNWmjcTppz7/N3AyliMnRXQcEf+L/8KDuREe56AkMXX1kWLsDcciZnzV9RgTcV+VA9aolwlkHjyXpevH6NNABribwxNlwUf4+D4sqWTPGjwclCUx+3F/pLDcQr2D6N4RqS9HzrX+IdAjmd9FA3Kf/z4P6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAeXoZnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA55C4CEF8;
	Thu, 13 Nov 2025 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763057636;
	bh=hb/FO4V3eVHR2RnKCICg4vV3cwhuxn5dtsUG3W/ZL3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GAeXoZnD0ky14VG0Muy9qj0XgPiUQdXS28xi+Pffx6l3JTGDimfw4wLQYdkNGJWfL
	 sXR93nMF71w3TAo9+EmnuZlMAxnrWwMHA2m487LyCzfrfuLmzGwvvv85+N7GCzwrQ6
	 zjp9GfUAsoOMJbkfIdnIGw/pEvnnXvnvOVdAkuvfKy4WuQk0zQ7G6KrFG3TANGhVwn
	 J2fmk46Xbt87Zh4EaA6Jz5r0JbBndG1Gid5Wn2gW6DIniz9vh8iImKryaNDpRB2tb4
	 S1H3a+yGue1ulyQDH/0OtQcLxavnbA98/GjK+L98qek+0aXHthH2fdvxjVhc6ullZS
	 X3tfd5X2NPRTg==
Date: Thu, 13 Nov 2025 12:13:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Russell King <linux@armlinux.org.uk>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	christian.bruel@foss.st.com, krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com, shradha.t@samsung.com,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	fan.ni@samsung.com, cassel@kernel.org, kishon@kernel.org,
	18255117159@163.com, rongqianfeng@vivo.com, jirislaby@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v5 4/4] PCI: keystone: Add support to build as a loadable
 module
Message-ID: <20251113181355.GA2293401@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029080547.1253757-5-s-vadapalli@ti.com>

[+to Russell, hook_fault_code() __init-ness]

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
> ...

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

This is kind of a lot of dancing to make keystone built-in on ARM32
because hook_fault_code() is __init, while making it modular
everywhere else.

Is hook_fault_code() __init for some intrinsic reason?  All the
existing callers are __init, so that's one reason.  But could it be
made non-__init?

There are several drivers that use hook_fault_code() and could
potentially be modular (imx6, keystone, ixp4xx, rcar).

Bjorn

