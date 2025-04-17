Return-Path: <linux-pci+bounces-26149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B89EA92C31
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 22:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48877AD0C6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 20:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5022066C6;
	Thu, 17 Apr 2025 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPlsIkXz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818A5205E1C;
	Thu, 17 Apr 2025 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744921235; cv=none; b=NspAClfgM41XcegUbIPwGS3H02Bf6aoOcPTSB8qy54qUzAodJHa13a10JfxvqCf/mGrrdNSJ8uICw4CaQj+GAdxOn2sk8iU7askLvf8gy4FJiFr6I/h6YKIBn86BBe395tpbRfq3AHmYvHoV1q0raNZYgA20dm6Sz/+OI8rwdNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744921235; c=relaxed/simple;
	bh=hvY100uzb9xX8gEMvLRUIfhM7aqZCaTGOOAMn1p1RGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YZM2gNOq6oKe10z/qNd715PXPogOiW3WbtTCPsBdxBOBGXtf8xenL/GHrv43+ZcFD23LaPkqEylN4RprkJen3HTTLDXuRPJ4FB/iWsbTNGjUp6d5bydwGzwCv4VV7VMrns93Th7A3jDfprZzqyIJ146jRmhQ82rfUi9NReiTZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPlsIkXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACEFC4CEE4;
	Thu, 17 Apr 2025 20:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744921235;
	bh=hvY100uzb9xX8gEMvLRUIfhM7aqZCaTGOOAMn1p1RGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bPlsIkXzG4FfBg6C13Wt8Jmrw8vLZJOMWZTnONHbi4Z5mDxMPnN8sAZEQBr4BcDsH
	 N/CYUMKh7YKktQJ1XxsO4X+sdiH8/eKHZwiX0y48wLNXZqVZTIWish9MLbXrU5dNf9
	 mTyKmjustVfni0Yyqw6pQQPcgUhilV1zKR2zn/I1Oy/Ao6qfe8aFFzbsTaULTmLWLK
	 OctCQdrn9ffE9tOMdgZxFE6G1Y02qo95cEaOqdNcE3sQNikDYXGb6bkhcWnIQzp4u1
	 6LSKddOg8QoHkKNEM25UE12UH1hLcYyfk05ewneoXpD7sxKk1pKqW1739bQ/uVzkJ5
	 QN857FwUzVDrw==
Date: Thu, 17 Apr 2025 15:20:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] x86/PCI: Drop 'pci' suffix from intel_mid_pci.c
Message-ID: <20250417202033.GA126135@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407070321.3761063-1-andriy.shevchenko@linux.intel.com>

On Mon, Apr 07, 2025 at 10:03:21AM +0300, Andy Shevchenko wrote:
> CE4100 PCI specific code has no 'pci' suffix in the filename,
> intel_mid_pci.c is the only one that duplicates the folder
> name in its filename, drop that redundancy.
> 
> While at it, group the respective modules in the Makefile.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to pci/misc for v6.16, thanks!

> ---
>  MAINTAINERS                                   | 2 +-
>  arch/x86/pci/Makefile                         | 6 +++---
>  arch/x86/pci/{intel_mid_pci.c => intel_mid.c} | 0
>  3 files changed, 4 insertions(+), 4 deletions(-)
>  rename arch/x86/pci/{intel_mid_pci.c => intel_mid.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96b827049501..1f6514d55b17 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12120,7 +12120,7 @@ M:	Andy Shevchenko <andy@kernel.org>
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported
>  F:	arch/x86/include/asm/intel-mid.h
> -F:	arch/x86/pci/intel_mid_pci.c
> +F:	arch/x86/pci/intel_mid.c
>  F:	arch/x86/platform/intel-mid/
>  F:	drivers/dma/hsu/
>  F:	drivers/extcon/extcon-intel-mrfld.c
> diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
> index 4933fb337983..c1efd5b0d198 100644
> --- a/arch/x86/pci/Makefile
> +++ b/arch/x86/pci/Makefile
> @@ -8,13 +8,13 @@ obj-$(CONFIG_PCI_OLPC)		+= olpc.o
>  obj-$(CONFIG_PCI_XEN)		+= xen.o
>  
>  obj-y				+= fixup.o
> -obj-$(CONFIG_X86_INTEL_CE)      += ce4100.o
>  obj-$(CONFIG_ACPI)		+= acpi.o
>  obj-y				+= legacy.o irq.o
>  
> -obj-$(CONFIG_X86_NUMACHIP)	+= numachip.o
> +obj-$(CONFIG_X86_INTEL_CE)	+= ce4100.o
> +obj-$(CONFIG_X86_INTEL_MID)	+= intel_mid.o
>  
> -obj-$(CONFIG_X86_INTEL_MID)	+= intel_mid_pci.o
> +obj-$(CONFIG_X86_NUMACHIP)	+= numachip.o
>  
>  obj-y				+= common.o early.o
>  obj-y				+= bus_numa.o
> diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid.c
> similarity index 100%
> rename from arch/x86/pci/intel_mid_pci.c
> rename to arch/x86/pci/intel_mid.c
> -- 
> 2.47.2
> 

