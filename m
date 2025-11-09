Return-Path: <linux-pci+bounces-40648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 659CBC43993
	for <lists+linux-pci@lfdr.de>; Sun, 09 Nov 2025 07:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30D21889BC1
	for <lists+linux-pci@lfdr.de>; Sun,  9 Nov 2025 06:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67496770FE;
	Sun,  9 Nov 2025 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsMdolEI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8E883F;
	Sun,  9 Nov 2025 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762671110; cv=none; b=OT0/Oo72fQ/ghUUK8SDcyQjL9gU+eNuM1ZbD/4KxSikZ2RgqOufOtNjUBMn7QgP2fpqHgn49Z7GrZHniBs+2TWoHrMF2PP7wp0i9Wj/xWmKSZ7+/iPVm4FDYsOSx1qwbkS9+wn4XD/anDLPcHBthGs8//DJYThZytHOEysnetmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762671110; c=relaxed/simple;
	bh=MjDOt2y11QmzHF2gEFJK2lQgeHlq6vkMc5A4XeB0RbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMBIh6NUHdbJunTrL3C7fdQy/wD4DLr57MdMxRQlFmKbpM0/UPVPZ6L2nTQRkCLGoOvdr32leQsOiwczu3x4QbeCh1yGtK40SkNElbTG6ln4adqyZ8JkaE32tfzaAcQZNLIlE3WfupBfKWkhQMJQ3fu4HcrT5zdBt0/ZB+E5lD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsMdolEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBBAC116B1;
	Sun,  9 Nov 2025 06:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762671109;
	bh=MjDOt2y11QmzHF2gEFJK2lQgeHlq6vkMc5A4XeB0RbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsMdolEIRb19jC0QwXU10fbcgYllK8QpXG4ZtQ1RvzQeEswgBQsd5paSLvdSsxOCD
	 rbApSj1I/q0dfl/0kCIDROZpWhMscQDc9VOsS6fHSHMYWENwW3cnkuRPunjvNF+sMQ
	 uaTCZ7AxHQBlOIMQZnTxQvZ0xTyeoRmv3KGnz8QirfXVCNfEmFbYegDOsiSN/dCE+l
	 +wCcu+TYf02hfSC8pP/pzq9Z3x4ARgErD5HvTX43EcIlaz6py6nEMXnxk4Ja9NmOuR
	 ReykoaaBA1tpr16Zuvfqt5SSKu+ensPUI6SP9dzxgWundkTLamXvMHqRsGvGh/Tejf
	 Ysb2jEM3uQ4lw==
Date: Sun, 9 Nov 2025 08:51:39 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave.hansen@linux.intel.com, peterz@infradead.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>, Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH] x86/kaslr: P2PDMA is one of a class of ZONE_DEVICE-KASLR
 collisions
Message-ID: <aRA5-wgo6bm_TA74@kernel.org>
References: <20251108023215.2984031-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108023215.2984031-1-dan.j.williams@intel.com>

On Fri, Nov 07, 2025 at 06:32:15PM -0800, Dan Williams wrote:
> Commit 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
> is too narrow. ZONE_DEVICE, in general, lets any physical address be added
> to the direct-map. I.e. not only ACPI hotplug ranges, CXL Memory Windows,
> or EFI Specific Purpose Memory, but also any PCI MMIO range for the
> CONFIG_DEVICE_PRIVATE and CONFIG_PCI_P2PDMA cases.
> 
> A potential path to recover entropy would be to walk ACPI and determine the
> limits for hotplug and PCI MMIO before kernel_randomize_memory(). On
> smaller systems that could yield some KASLR address bits. This needs
> additional investigation to determine if some limited ACPI table scanning
> can happen this early without an open coded solution like
> arch/x86/boot/compressed/acpi.c needs to deploy.
> 
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
> Fixes: 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/pci/Kconfig |  6 ------
>  mm/Kconfig          | 12 ++++++++----
>  arch/x86/mm/kaslr.c | 10 +++++-----
>  3 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index f94f5d384362..47e466946bed 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -207,12 +207,6 @@ config PCI_P2PDMA
>  	  P2P DMA transactions must be between devices behind the same root
>  	  port.
>  
> -	  Enabling this option will reduce the entropy of x86 KASLR memory
> -	  regions. For example - on a 46 bit system, the entropy goes down
> -	  from 16 bits to 15 bits. The actual reduction in entropy depends
> -	  on the physical address bits, on processor features, kernel config
> -	  (5 level page table) and physical memory present on the system.
> -
>  	  If unsure, say N.
>  
>  config PCI_LABEL
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0e26f4fc8717..d17ebcc1a029 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1128,10 +1128,14 @@ config ZONE_DEVICE
>  	  Device memory hotplug support allows for establishing pmem,
>  	  or other device driver discovered memory regions, in the
>  	  memmap. This allows pfn_to_page() lookups of otherwise
> -	  "device-physical" addresses which is needed for using a DAX
> -	  mapping in an O_DIRECT operation, among other things.
> -
> -	  If FS_DAX is enabled, then say Y.
> +	  "device-physical" addresses which is needed for DAX, PCI_P2PDMA, and
> +	  DEVICE_PRIVATE features among others.
> +
> +	  Enabling this option will reduce the entropy of x86 KASLR memory
> +	  regions. For example - on a 46 bit system, the entropy goes down
> +	  from 16 bits to 15 bits. The actual reduction in entropy depends
> +	  on the physical address bits, on processor features, kernel config
> +	  (5 level page table) and physical memory present on the system.
>  
>  #
>  # Helpers to mirror range of the CPU page tables of a process into device page
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 3c306de52fd4..834641c6049a 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -115,12 +115,12 @@ void __init kernel_randomize_memory(void)
>  
>  	/*
>  	 * Adapt physical memory region size based on available memory,
> -	 * except when CONFIG_PCI_P2PDMA is enabled. P2PDMA exposes the
> -	 * device BAR space assuming the direct map space is large enough
> -	 * for creating a ZONE_DEVICE mapping in the direct map corresponding
> -	 * to the physical BAR address.
> +	 * except when CONFIG_ZONE_DEVICE is enabled. ZONE_DEVICE wants to map
> +	 * any physical address into the direct-map. KASLR wants to reliably
> +	 * steal some physical address bits. Those design choices are in direct
> +	 * conflict.
>  	 */
> -	if (!IS_ENABLED(CONFIG_PCI_P2PDMA) && (memory_tb < kaslr_regions[0].size_tb))
> +	if (!IS_ENABLED(CONFIG_ZONE_DEVICE) && (memory_tb < kaslr_regions[0].size_tb))
>  		kaslr_regions[0].size_tb = memory_tb;

A stupid question, why we adjust virtual kaslr to actual physical memory
size at all rather than always use maximal addressable size?
  
>  	/*
> 
> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
> -- 
> 2.51.0
> 

-- 
Sincerely yours,
Mike.

