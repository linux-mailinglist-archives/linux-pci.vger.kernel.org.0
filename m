Return-Path: <linux-pci+bounces-40466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED97DC397B6
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 09:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD803B82FE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 08:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CCE2FDC53;
	Thu,  6 Nov 2025 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IES7uTpy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095562FD7B8;
	Thu,  6 Nov 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416037; cv=none; b=DIbRklVSyXf84gmqr4SW0+wYqwKtk8iTQ9dXn0dFFPqqYRsFHVWIVndLV7utX4T+Ate7pPeAd7RCRF5uDx15HggToyETWvVd9mlygYn+gy43AqofPBzscMFXzMcmDHO3+SV8jAoyQ0bpskZN1HSN9QOFH+caN2kkbQKXgtocjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416037; c=relaxed/simple;
	bh=PLqcEO+B1iuZyJH4xuffVGT1SLh3xxFVImhSKds5ULI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cerdlBNt+xOELXe9YeLmP7NHHZ4pT5vsuAChr+XvZGLxHtQPkm1JqeuYTMnvMwFtsSANEZbi2dptCRIYUCccFXuxeE7Lg+1rs6vrvZpG+bQclzwWd3itkE7QsQZpS2wqReh/+0a05BvcgMJ4oCH+C1+c6vF9eB/laakkgo8aqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IES7uTpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5C6C116B1;
	Thu,  6 Nov 2025 08:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762416036;
	bh=PLqcEO+B1iuZyJH4xuffVGT1SLh3xxFVImhSKds5ULI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IES7uTpyPEkkRiOUjwLcBpEsMO/CcNeHwg7qBFVlLUwYjAXspO4FsbZ5803f4H2ZX
	 ye5+3SajpM3RROc/vFVV7Wbqw3U3E5uLIk/b8vyx4GM+XB9nj42xgBZXk6ffFjMkVE
	 cNixwAF7eXdhI8Lm1x9PNr09vEPKxsxORKLphy0g81x0SJj/zyyn03wAIkBbKjKbrt
	 UanAVNdqm8WZqqhTOV3FiEBI1QbvWq8975fPGkOJfFiVwSiS9QDklFioT8e+E0iDQ+
	 NcXZ79xngaNx+pbWLFLS8go/NrLG68kRDAyuYZdoekR5ZjINljH+Q0srwfZThd99et
	 /NK0JJ4EeSqKg==
Date: Thu, 6 Nov 2025 13:30:18 +0530
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
Message-ID: <grouefwty7ub7xipgxyiph7dumtvoprcdsuq4f6d73pzpqu7pm@rdivadcdcyfy>
References: <20251029080547.1253757-1-s-vadapalli@ti.com>
 <20251029080547.1253757-5-s-vadapalli@ti.com>
 <fkzokskbjklt6atqrpwc46zsjr5ptpuynzhx4kvfurr4h37kae@rwcqljsjvzl6>
 <d65f44cac2d7fb6c4a139065b304cb4ab790acb3.camel@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d65f44cac2d7fb6c4a139065b304cb4ab790acb3.camel@ti.com>

On Thu, Nov 06, 2025 at 12:31:08PM +0530, Siddharth Vadapalli wrote:
> On Wed, 2025-11-05 at 22:53 +0530, Manivannan Sadhasivam wrote:
> > On Wed, Oct 29, 2025 at 01:34:52PM +0530, Siddharth Vadapalli wrote:
> > > The 'pci-keystone.c' driver is the application/glue/wrapper driver for the
> > > Designware PCIe Controllers on TI SoCs. Now that all of the helper APIs
> > > that the 'pci-keystone.c' driver depends upon have been exported for use,
> > > enable support to build the driver as a loadable module.
> > > 
> > > Additionally, the functions marked by the '__init' keyword may be invoked:
> > > a) After a probe deferral
> > > OR
> > > b) During a delayed probe - Delay attributed to driver being built as a
> > >    loadable module
> > > 
> > > In both of the cases mentioned above, the '__init' memory will be freed
> > > before the functions are invoked. This results in an exception of the form:
> > > 
> > > 	Unable to handle kernel paging request at virtual address ...
> > > 	Mem abort info:
> > > 	...
> > > 	pc : ks_pcie_host_init+0x0/0x540
> > > 	lr : dw_pcie_host_init+0x170/0x498
> > > 	...
> > > 	ks_pcie_host_init+0x0/0x540 (P)
> > > 	ks_pcie_probe+0x728/0x84c
> > > 	platform_probe+0x5c/0x98
> > > 	really_probe+0xbc/0x29c
> > > 	__driver_probe_device+0x78/0x12c
> > > 	driver_probe_device+0xd8/0x15c
> > > 	...
> > > 
> > > To address this, introduce a new function namely 'ks_pcie_init()' to
> > > register the 'fault handler' while removing the '__init' keyword from
> > > existing functions.
> > > 
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > ---
> > > 
> > > v4:
> > > https://lore.kernel.org/r/20251022095724.997218-5-s-vadapalli@ti.com/
> > > Changes since v4:
> > > - To fix the build error on ARM32 platforms as reported at:
> > >   https://lore.kernel.org/r/202510281008.jw19XuyP-lkp@intel.com/
> > >   patch 4 in the series has been updated by introducing a new config
> > >   named "PCI_KEYSTONE_TRISTATE" which allows building the driver as
> > >   a loadable module. Additionally, this newly introduced config can
> > >   be enabled only for non-ARM32 platforms. As a result, ARM32 platforms
> > >   continue using the existing PCI_KEYSTONE config which is a bool, while
> > >   ARM64 platforms can use PCI_KEYSTONE_TRISTATE which is a tristate, and
> > >   can optionally enabled loadable module support being enabled by this
> > >   series.
> > > 
> > > Regards,
> > > Siddharth.
> > > 
> > >  drivers/pci/controller/dwc/Kconfig        | 15 +++--
> > >  drivers/pci/controller/dwc/Makefile       |  3 +
> > >  drivers/pci/controller/dwc/pci-keystone.c | 78 +++++++++++++----------
> > >  3 files changed, 59 insertions(+), 37 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > index 349d4657393c..c5bc2f0b1f39 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -482,15 +482,21 @@ config PCI_DRA7XX_EP
> > >  	  to enable device-specific features PCI_DRA7XX_EP must be selected.
> > >  	  This uses the DesignWare core.
> > >  
> > > +# ARM32 platforms use hook_fault_code() and cannot support loadable module.
> > >  config PCI_KEYSTONE
> > >  	bool
> > >  
> > > +# On non-ARM32 platforms, loadable module can be supported.
> > > +config PCI_KEYSTONE_TRISTATE
> > > +	tristate
> > > +
> > >  config PCI_KEYSTONE_HOST
> > > -	bool "TI Keystone PCIe controller (host mode)"
> > > +	tristate "TI Keystone PCIe controller (host mode)"
> > >  	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> > >  	depends on PCI_MSI
> > >  	select PCIE_DW_HOST
> > > -	select PCI_KEYSTONE
> > > +	select PCI_KEYSTONE if ARM
> > > +	select PCI_KEYSTONE_TRISTATE if !ARM
> > 
> > Wouldn't below change work for you?
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 349d4657393c..b1219e7136c9 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -486,8 +486,9 @@ config PCI_KEYSTONE
> >         bool
> >  
> >  config PCI_KEYSTONE_HOST
> > -       bool "TI Keystone PCIe controller (host mode)"
> > +       tristate "TI Keystone PCIe controller (host mode)"
> 
> This doesn't alter the build of the pci-keystone.c driver. From the
> existing Makefile, we have:
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
> implying that it is only CONFIG_PCI_KEYSTONE that determines whether the
> pci-keystone.c driver is built as a loadable module or a built-in module.
> 

Ah, I missed the fact that PCI_KEYSTONE_HOST is just used inside the driver and
not in the Makefile.

> >         depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> > +       default y if ARCH_KEYSTONE
> 
> The default flag only specifies what should be selected by default, but it
> doesn't prevent the user from attempting to built it as a loadable module
> using menuconfig. Building the pci-keystone.c driver as a loadable module
> (CONFIG_PCI_KEYSTONE set to 'm') will cause build errors for ARM32
> platforms due to the presence of hook_fault_code() which is __init code.
> 
> The Kconfig and Makefile changes made by the patch do the following:
> 1. Allow building the pci-keystone.c driver as a loadable module for non-
> ARM32 platforms by introducing the PCI_KEYSTONE_TRISTATE config which is a
> tristate unlike the existing PCI_KEYSTONE config which is a bool.
> 2. Associate PCI_KEYSTONE with ARM32 platforms and associate
> PCI_KEYSTONE_TRISTATE with non-ARM32 platforms to prevent users from
> building the pci-keystone.c driver as a loadable module for ARM32
> platforms.
> 

Ok. I don't have a better solution to this problem. So fine with me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

