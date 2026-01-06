Return-Path: <linux-pci+bounces-44071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2ECF6323
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 02:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D762303D6B5
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 01:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE83523183B;
	Tue,  6 Jan 2026 01:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHoAErPP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC86B2B9BA;
	Tue,  6 Jan 2026 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661889; cv=none; b=IzdQEYGou1fwuTbUllC6XchZV3XUGhcv2aHlG5F3qlyigeN+HweIGoNfqYMURYSm4Uk0i6Y/HUysISAD7ndt3shmBTjbPAbC+Pg58qpLqHxJW58N2KPxF7j1q+ePSaj6fmO5LZFCjD11gE8EPkKwnjjfJWZzT/9ffQ8RMYkmwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661889; c=relaxed/simple;
	bh=jm8nnelT+Iq43xL+maySEnxe6OspV/EkRGcxzUcVGEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xu6FJkgP2Rdx72ade2bH0u+j0ywlNrWKWOh/L7JqBxjm827nl66eabPjy/JHPlKe/tQiQjrUdPioqHq8fX3vVHKLe+lBZCvC+lt+YTigdp7CMK/yxuNRSc26wjEni0Asw0fcwaWUy4Pb2Jb+D4Y+5bNsKKFbQS+pn4X1byXWv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHoAErPP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767661888; x=1799197888;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jm8nnelT+Iq43xL+maySEnxe6OspV/EkRGcxzUcVGEs=;
  b=bHoAErPPwQneX6ancxWt3cm0h25jVP6JxQYH3UD1di0fT7z3ooYHkEfF
   cEC0McVjt103+7S7xIbwia1hm+qqUMWUoVOtkcpYOLVW5LEIP2Tq2yfih
   SZSj/xyvpCTRDKGiKt2ewm/R8b4FqX+RtOsuFeC/yOeiIEohZPBrNQeUV
   oyO5I573ftLyZlcba4rmMQIb63tMwdiq0U06RKFJkIqGXNX+e9QuOcB+0
   ILQtD3QTp6eW/PdXRLCDAvIXnddhrhG5nTsnRlkinHyhq1JIkiuwangBC
   aEUg5xD/9A6nBwOphjZpZjCrLUVLZOIFbGDhXQ2eMZsQtUNpqifMtB0B5
   A==;
X-CSE-ConnectionGUID: Dv/8Q4xKTHm/Le4uxURe5g==
X-CSE-MsgGUID: w+M/GrPESU+mtzWSmpzenw==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69011396"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="69011396"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 17:11:27 -0800
X-CSE-ConnectionGUID: ZAeGyJRHS5KhCLhzHdp8sg==
X-CSE-MsgGUID: FB5IVjx6RKulu3P0IYcOSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="202772009"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.109.45]) ([10.125.109.45])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 17:11:25 -0800
Message-ID: <0569b41b-0d74-4237-b471-6994ddc42333@intel.com>
Date: Mon, 5 Jan 2026 18:11:23 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kaslr: P2PDMA is one of a class of ZONE_DEVICE-KASLR
 collisions
To: dan.j.williams@intel.com, Dave Hansen <dave.hansen@intel.com>,
 dave.hansen@linux.intel.com, peterz@infradead.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 Balbir Singh <balbirs@nvidia.com>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Andy Lutomirski <luto@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
References: <20251108023215.2984031-1-dan.j.williams@intel.com>
 <2d4fb1ce-176c-404a-852f-987a9481046d@intel.com>
 <692e08b2516d4_261c1100a3@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <692e08b2516d4_261c1100a3@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/1/25 2:29 PM, dan.j.williams@intel.com wrote:
> Dave Hansen wrote:
>> The subject probably wants to be something along the lines of:
>>
>> 	x86/kaslr: Recognize all ZONE_DEVICE users as physaddr consumers
> 
> ...works for me.
> 
>>
>> On 11/7/25 18:32, Dan Williams wrote:
>>> Commit 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
>>> is too narrow. ZONE_DEVICE, in general, lets any physical address be added
>>> to the direct-map. I.e. not only ACPI hotplug ranges, CXL Memory Windows,
>>> or EFI Specific Purpose Memory, but also any PCI MMIO range for the
>>> CONFIG_DEVICE_PRIVATE and CONFIG_PCI_P2PDMA cases.
>>
>> This should probably also mention the fact that:
>>
>> 	config PCI_P2PDMA
>> 		depends on ZONE_DEVICE
>>
>> It would also be nice to point out how the "too narrow" check had an
>> impact on real ZONE_DEVICE but !PCI_P2PDMA users. This isn't just a
>> theoretical problem, right?
> 
> Yasunori filled in a detail [1] that I did not have when creating the
> patch, specifically that when he enountered the CXL collision with KASLR
> he was running on a kernel before commit 7ffb791423c7 ("x86/kaslr:
> Reduce KASLR entropy on most x86 systems").
> 
> Either way, a pre-7ffb791423c7 kernel and a kernel with
> CONFIG_PCI_P2PDMA=n would fail the same way. Yasunori confirmed that
> current kernel with CONFIG_PCI_P2PDMA=y, or this patch solved the
> problem for him.
> 
> See below for a reworked patch with these changes.
> 
> [1]: http://lore.kernel.org/OS9PR01MB124215C4182B59D590049B99390CCA@OS9PR01MB12421.jpnprd01.prod.outlook.com
>>
>>> A potential path to recover entropy would be to walk ACPI and determine the
>>> limits for hotplug and PCI MMIO before kernel_randomize_memory(). On
>>> smaller systems that could yield some KASLR address bits. This needs
>>> additional investigation to determine if some limited ACPI table scanning
>>> can happen this early without an open coded solution like
>>> arch/x86/boot/compressed/acpi.c needs to deploy.
>>
>> Yeah, a more flexible runtime solution would be highly preferred over
>> the existing solution built around config options. But this is really
>> orthogonal to the bug fix here.
>>
>> With the changelog fixes above:
>>
>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>>
>> Oh, and does this need to be cc:stable@?
> 
> Yes, especially because it would create a dependency on 7ffb791423c7
> also being backported and that would have helped Yasunori avoid this
> problem (for CONFIG_PCI_P2PDMA=y builds at least).
> 
> -- >8 --
> From d2f4b9ac915ce35e2ec842548ae1ccb4f1690b04 Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Thu, 6 Nov 2025 15:13:50 -0800
> Subject: [PATCH v2] x86/kaslr: Recognize all ZONE_DEVICE users as physaddr
>  consumers
> 
> Commit 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
> is too narrow. The effect being mitigated in that commit is caused by
> ZONE_DEVICE which PCI_P2PDMA has a dependency. ZONE_DEVICE, in general,
> lets any physical address be added to the direct-map. I.e. not only ACPI
> hotplug ranges, CXL Memory Windows, or EFI Specific Purpose Memory, but
> also any PCI MMIO range for the DEVICE_PRIVATE and PCI_P2PDMA cases. Update
> the mitigation, limit KASLR entropy, to apply in all ZONE_DEVICE=y cases.
> 
> Distro kernels typically have PCI_P2PDMA=y, so the practical exposure of
> this problem is limited to the PCI_P2PDMA=n case.
> 
> A potential path to recover entropy would be to walk ACPI and determine the
> limits for hotplug and PCI MMIO before kernel_randomize_memory(). On
> smaller systems that could yield some KASLR address bits. This needs
> additional investigation to determine if some limited ACPI table scanning
> can happen this early without an open coded solution like
> arch/x86/boot/compressed/acpi.c needs to deploy.
> 
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
> Fixes: 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Balbir Singh <balbirs@nvidia.com>
> Tested-by: Yasunori Goto <y-goto@fujitsu.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Applied to cxl/fixes
269031b15c1433ff39e30fa7ea3ab8f0be9d6ae2

DJ

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
>  
>  	/*


