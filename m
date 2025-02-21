Return-Path: <linux-pci+bounces-22048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F4A402F1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA143B457A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 22:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A1B2054EC;
	Fri, 21 Feb 2025 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URoRwvsw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0AE1FC105;
	Fri, 21 Feb 2025 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177795; cv=none; b=rm/e1Yjnxow6nb/1aYosLgTe1RjYqpL3jEOxH5LZPXcwWocMVqWb4ho7gGRs8F+CGTUaD3vKmZmuvzoLZ9g6Yr2QM8ToeVfyMYL8FsFHrfE5UCiHawBytvnatDkSznSEaDhYfDNZu3GARaILk0kJmgTT4n2uRMMXlbmumuiT+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177795; c=relaxed/simple;
	bh=Fj8tGhBrbSTvkWUc4++5vDFrhvKtxM2PKbXkDaHUeDM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OwHv1LcObPgbnI8FNNKOmjlsaosO3BCpV6vohRUstQAF4j3x75Em/A7ORmO5U3EocJNmZTC6AywB/ClgqImwtwcZTPLfDTaIIcPaihVnSdcXnH77qJ50RCP/tkelEjR9N/5ShDiGOcn3Ez4Lya8v34ralYP/vKjcMz7IaCOhyDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URoRwvsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848A4C4CED6;
	Fri, 21 Feb 2025 22:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740177794;
	bh=Fj8tGhBrbSTvkWUc4++5vDFrhvKtxM2PKbXkDaHUeDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=URoRwvswQb3M27ZFvdT4Wkuenin0cVv5/gkSJQblNGmqzm5k1mORFQ+r8Ly747IzQ
	 PlUH9ABs8BK262ogcWeMwhMYzG3ynVHv1K0d8HBsTgEm2vOsbFfA0HTBIBuvWxgfxT
	 oG+j26V7HGLgykMk87OTvGV8ZmblRUuuEhGCc3qmLMOlRY6hbdoBHkFHprVGnXN4yZ
	 aq9hDNuReyAh6HIRatxWSh8ECPc+LrIlqeK/csx5t9/A3Lw3V/tBdGidc38uSpXm91
	 nZEp0l8Ldo12MQI9jAUcaBvgqEG23iHDjJ5DdDyBFC3EMMlhOFftYqM5viGYDQcFVq
	 mSr+vSO3ocZxw==
Date: Fri, 21 Feb 2025 16:43:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	apopple@nvidia.com, jhubbard@nvidia.com, jgg@nvidia.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] x86/kaslr: Revisit entropy when CONFIG_PCI_P2PDMA is
 enabled
Message-ID: <20250221224313.GA369782@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206234234.1912585-1-balbirs@nvidia.com>

On Fri, Feb 07, 2025 at 10:42:34AM +1100, Balbir Singh wrote:
> When CONFIG_PCI_P2PDMA is enabled, it maps the PFN's via a
> ZONE_DEVICE mapping using devm_memremap_pages(). The mapped
> virtual address range corresponds to the pci_resource_start()
> of the BAR address and size corresponding to the BAR length.
> 
> When KASLR is enabled, the direct map range of the kernel is
> reduced to the size of physical memory plus additional padding.
> If the BAR address is beyond this limit, PCI peer to peer DMA
> mappings fail.
> 
> Fix this by not shrinking the size of direct map when CONFIG_PCI_P2PDMA
> is enabled. This reduces the total available entropy, but it's
> better than the current work around of having to disable KASLR
> completely.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/lkml/20250206023201.1481957-1-balbirs@nvidia.com/
> 
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# drivers/pci/Kconfig

> ---
> Changelog v2
>   - Add information about entropy drop when PCI_P2PDMA is
>     selected
> 
> Testing:
> 
>   commit 0483e1fa6e09d ("x86/mm: Implement ASLR for kernel memory regions") mentions the
>   problems that the following problems need to be addressed.
> 
>   1 The three target memory sections are never at the same place between
>     boots.
>   2 The physical memory mapping can use a virtual address not aligned on
>     the PGD page table.
>   3 Have good entropy early at boot before get_random_bytes is available.
>   4 Add optional padding for memory hotplug compatibility.
> 
>   Ran an automated test to ensure that (1) holds true across several
>   iterations of automated reboot testing. 2, 3 and 4 are not impacted
>   by this patch.
> 
>   Manual Testing on a system where the problem reproduces
>   
>   1. With KASLR
> 
>      Hotplug memory [0x240000000000-0x242000000000] exceeds maximum addressable range [0x0-0xaffffffffff]
>      ------------[ cut here ]------------
>   2. With the fixes
> 
>      added peer-to-peer DMA memory 0x240000000000-0x241fffffffff
> 
>      KASLR is still enabled as seen by kaslr_offset() (difference
>      between __START_KERNEL and _stext)
>   3. Without the fixes and KASLR disabled
> 
> 
>  arch/x86/mm/kaslr.c | 10 ++++++++--
>  drivers/pci/Kconfig |  6 ++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 11a93542d198..3c306de52fd4 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -113,8 +113,14 @@ void __init kernel_randomize_memory(void)
>  	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
>  		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
>  
> -	/* Adapt physical memory region size based on available memory */
> -	if (memory_tb < kaslr_regions[0].size_tb)
> +	/*
> +	 * Adapt physical memory region size based on available memory,
> +	 * except when CONFIG_PCI_P2PDMA is enabled. P2PDMA exposes the
> +	 * device BAR space assuming the direct map space is large enough
> +	 * for creating a ZONE_DEVICE mapping in the direct map corresponding
> +	 * to the physical BAR address.
> +	 */
> +	if (!IS_ENABLED(CONFIG_PCI_P2PDMA) && (memory_tb < kaslr_regions[0].size_tb))
>  		kaslr_regions[0].size_tb = memory_tb;
>  
>  	/*
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 2fbd379923fd..5c3054aaec8c 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -203,6 +203,12 @@ config PCI_P2PDMA
>  	  P2P DMA transactions must be between devices behind the same root
>  	  port.
>  
> +	  Enabling this option will reduce the entropy of x86 KASLR memory
> +	  regions. For example - on a 46 bit system, the entropy goes down
> +	  from 16 bits to 15 bits. The actual reduction in entropy depends
> +	  on the physical address bits, on processor features, kernel config
> +	  (5 level page table) and physical memory present on the system.
> +
>  	  If unsure, say N.
>  
>  config PCI_LABEL
> -- 
> 2.48.1
> 

