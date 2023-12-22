Return-Path: <linux-pci+bounces-1306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F219D81CAE5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 14:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49811C2170C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35B618C2E;
	Fri, 22 Dec 2023 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXsudti+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0983199A4;
	Fri, 22 Dec 2023 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703252949; x=1734788949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RUmyMW3g0k51HPdqDgLk+gSL7qphUXNNNST1JY49vU4=;
  b=AXsudti+FB9MjpWOdt/6LatuZaPoLKURDnLU9ttC+lUfi5NURsiYL1d6
   l2Rqk3Ma8GPAeR3xsyX2z231MQJozLIiSwm8xYY0TPWrDI/EnXbc42pCu
   g561iOVtEWIfvMycXlcLOHsb0b7CR/+K5pb5nc7I75VM/FHhr+PBZf8wp
   pYd7UKS4hw0fvOT5o2FSA17C7U3w/tkIU1y8Af1rchNVp2q727tzYxOy9
   X8/7uljSW8S5X4TEE2Df6rJQaBf4SWSBJ4UQi4g71Sm0rK7xwRGeSdbf6
   Itvks9Cnro2Y3juzAZpLGfipUsVc/zpxDSXt4GZk6lyDqfiF1KCcrF2sP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="462556153"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="462556153"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:49:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="811315380"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="811315380"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:49:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGftZ-00000008AFU-3SUa;
	Fri, 22 Dec 2023 15:48:57 +0200
Date: Fri, 22 Dec 2023 15:48:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] PCI: Relax bridge window tail sizing rules
Message-ID: <ZYWTyQpVXGFqCLZa@smile.fi.intel.com>
References: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
 <20231222122901.49538-8-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231222122901.49538-8-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 02:29:01PM +0200, Ilpo Järvinen wrote:
> During remove & rescan cycle, PCI subsystem will recalculate and adjust
> the bridge window sizing that was initially done by "BIOS". The size
> calculation is based on the required alignment of the largest resource
> among the downstream resources as per pbus_size_mem() (unimportant or
> zero parameters marked with "..."):
> 
> 	min_align = calculate_mem_align(aligns, max_order);
> 	size0 = calculate_memsize(size, ..., min_align);
> 
> and then in calculate_memsize():
> 	size = ALIGN(max(size, ...) + ..., align);
> 
> If the original bridge window sizing tried to conserve space, this will
> lead to massive increase of the required bridge window size when the
> downstream has a large disparity in BAR sizes. E.g., with 16MiB and
> 16GiB BARs this results in 32GiB bridge window size even if 16MiB BAR
> does not require gigabytes of space to fit.
> 
> When doing remove & rescan for a bus that contains such a PCI device, a
> larger bridge window is suddenly required on rescan but when there is a
> bridge window upstream that is already assigned based on the original
> size, it cannot be enlarged to the new requirement. This causes the
> allocation of the bridge window to fail (0x600000000 > 0x400ffffff):
> 
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> pci 0000:01:00.0: PCI bridge to [bus 02-04]
> pci 0000:01:00.0:   bridge window [mem 0x40400000-0x406fffff]
> pci 0000:01:00.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> ...
> pci_bus 0000:03: busn_res: [bus 03] is released
> pci 0000:03:00.0: reg 0x10: [mem 0x6400000000-0x6400ffffff 64bit pref]
> pci 0000:03:00.0: reg 0x18: [mem 0x6000000000-0x63ffffffff 64bit pref]
> pci 0000:03:00.0: reg 0x30: [mem 0x40400000-0x405fffff pref]
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> pci 0000:02:01.0: BAR 9: no space for [mem size 0x600000000 64bit pref]
> pci 0000:02:01.0: BAR 9: failed to assign [mem size 0x600000000 64bit pref]
> pci 0000:02:01.0: BAR 8: assigned [mem 0x40400000-0x405fffff]
> pci 0000:03:00.0: BAR 2: no space for [mem size 0x400000000 64bit pref]
> pci 0000:03:00.0: BAR 2: failed to assign [mem size 0x400000000 64bit pref]
> pci 0000:03:00.0: BAR 0: no space for [mem size 0x01000000 64bit pref]
> pci 0000:03:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit pref]
> pci 0000:03:00.0: BAR 6: assigned [mem 0x40400000-0x405fffff pref]
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> 
> This is a major surprise for users who are suddenly left with a PCIe
> device that was working fine with the original bridge window sizing.
> 
> Even if the already assigned bridge window could be enlarged by
> reallocation in some cases (something the current code does not attempt
> to do), it is not possible in general case and the large amount of
> wasted space at the tail of the bridge window may lead to other
> resource exhaustion problems on Root Complex level (think of multiple
> PCIe cards with VFs and BAR size disparity in a single system).
> 
> PCI specifications only expect natural alignment for BARs (PCI Express
> Base Specification, rev. 6.1 sect. 7.5.1.2.1) and minimum of 1MiB
> alignment for the bridge window (PCI Express Base Specification,
> rev 6.1 sect. 7.5.1.3). The current bridge window tail alignment rule
> was introduced in the commit 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI
> allocation code (alpha, arm, parisc) [2/2]") that only states:
> "pbus_size_mem: core stuff; tested with randomly generated sets of
> resources". It does not explain the motivation for the extra tail space
> allocated that is not truly needed by the downstream resources. As
> such, it is far from clear if it ever has been required by any HW.
> 
> To prevent PCIe cards with BAR size disparity from becoming unusable
> after remove & rescan cycle, attempt to do a truly minimal allocation
> for memory resources if needed. First check if the normally calculated
> bridge window will not fit into an already assigned upstream resource.
> In such case, try with relaxed bridge window tail sizing rules instead
> where no extra tail space is requested beyond what the downstream
> resources require. Only enforce the alignment requirement of the bridge
> window itself (normally 1MiB).
> 
> With this patch, the resources are successfully allocated:
> 
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> pci 0000:02:01.0: bridge window [mem 0x6000000000-0x6400ffffff 64bit pref] to [bus 03] requires relaxed alignment rules
> pci 0000:02:01.0: BAR 9: assigned [mem 0x6000000000-0x6400ffffff 64bit pref]
> pci 0000:02:01.0: BAR 8: assigned [mem 0x40400000-0x405fffff]
> pci 0000:03:00.0: BAR 2: assigned [mem 0x6000000000-0x63ffffffff 64bit pref]
> pci 0000:03:00.0: BAR 0: assigned [mem 0x6400000000-0x6400ffffff 64bit pref]
> pci 0000:03:00.0: BAR 6: assigned [mem 0x40400000-0x405fffff pref]
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> 
> This patch draws inspiration from the initial investigations and work
> by Mika Westerberg.

...

> +	struct resource_constraint constraint = { .max = (resource_size_t)~0ULL,

RESOURCE_SIZE_MAX from limits.h.

> +						  .align = align };

Also I prefer the style

	struct resource_constraint constraint = {
		.max = RESOURCE_SIZE_MAX,
		.align = align,
	};


...

> +			if (!r || r == &ioport_resource || r == &iomem_resource)
> +				continue;

> +			if (!r->parent || (r->flags & mask) != type)

Thinking more about these checks, r->parent should be NULL for the root
resources, hence this check basically covers the second part of the above.

But like you said it's a material for a separate investigation.

> +				continue;

...

> +				pci_dbg(bus->self,
> +					"Assigned bridge window %pR to %pR cannot fit 0x%llx required for %s bridging to %pR\n",
> +					r, &bus->busn_res,

> +					(unsigned long long)size,

Yeah, casting here is a compromise between good looking message and
kernel code.

> +					pci_name(downstream->self),
> +					&downstream->busn_res);
> +			}

...

> +	    pbus_upstream_assigned_limit(bus, mask | IORESOURCE_PREFETCH, type,
> +					 size0, add_align)) {

One line?

...

> +		size0 = calculate_memsize(size, min_size, 0, 0,
> +					  resource_size(b_res), win_align);

One line?

-- 
With Best Regards,
Andy Shevchenko



