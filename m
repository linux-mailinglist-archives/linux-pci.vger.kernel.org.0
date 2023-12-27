Return-Path: <linux-pci+bounces-1442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D7381EF82
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 15:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7821F21F47
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 14:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1BA45034;
	Wed, 27 Dec 2023 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlZK7D6u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A7D45033;
	Wed, 27 Dec 2023 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703688272; x=1735224272;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yPPa9rWFM7AX3DTCZjkogOx1t3QAH9aY65kGtm1CcnQ=;
  b=nlZK7D6u/7eEzENB1sGwbGoo8K+iwMmKI73yt6fcaAbMsWdqS50FDsOg
   kZKvkYFAUQcqhibctLDFbf5cPaMOMplZU5ePXrCdN9x6Dcnh1gAM3GQCe
   4CESm80Vzzfnll7dhSO58uNDUaRcqtiSoDJJumO5mjus4EuAJmLY4I/Kq
   xSnw9b7umf3IcxDP/HRgL56t5r0v5t8d6BD7DMz4b2EmttAUWPDbVQANz
   WYqvaZUF4Jwkex9q8mjEKI0enrQFAKmbbjkVSd45473n+vwHMlVuxPNdg
   5B+ILlVU+SOoWzL5Ll7MCBtclNIWxRLxswYxYbG2VNkPvIhlSY1kQs+3z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3738473"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="3738473"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 06:44:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="951514233"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="951514233"
Received: from hrmarapi-mobl1.ger.corp.intel.com ([10.249.35.233])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 06:44:27 -0800
Date: Wed, 27 Dec 2023 16:44:21 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] PCI: Relax bridge window tail sizing rules
In-Reply-To: <ZYWTyQpVXGFqCLZa@smile.fi.intel.com>
Message-ID: <87751a41-2d80-71c1-502b-5286cfd613fa@linux.intel.com>
References: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com> <20231222122901.49538-8-ilpo.jarvinen@linux.intel.com> <ZYWTyQpVXGFqCLZa@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-935243227-1703688270=:2838"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-935243227-1703688270=:2838
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 22 Dec 2023, Andy Shevchenko wrote:

> On Fri, Dec 22, 2023 at 02:29:01PM +0200, Ilpo Järvinen wrote:
> > During remove & rescan cycle, PCI subsystem will recalculate and adjust
> > the bridge window sizing that was initially done by "BIOS". The size
> > calculation is based on the required alignment of the largest resource
> > among the downstream resources as per pbus_size_mem() (unimportant or
> > zero parameters marked with "..."):
> > 
> > 	min_align = calculate_mem_align(aligns, max_order);
> > 	size0 = calculate_memsize(size, ..., min_align);
> > 
> > and then in calculate_memsize():
> > 	size = ALIGN(max(size, ...) + ..., align);
> > 
> > If the original bridge window sizing tried to conserve space, this will
> > lead to massive increase of the required bridge window size when the
> > downstream has a large disparity in BAR sizes. E.g., with 16MiB and
> > 16GiB BARs this results in 32GiB bridge window size even if 16MiB BAR
> > does not require gigabytes of space to fit.
> > 
> > When doing remove & rescan for a bus that contains such a PCI device, a
> > larger bridge window is suddenly required on rescan but when there is a
> > bridge window upstream that is already assigned based on the original
> > size, it cannot be enlarged to the new requirement. This causes the
> > allocation of the bridge window to fail (0x600000000 > 0x400ffffff):
> > 
> > pci 0000:02:01.0: PCI bridge to [bus 03]
> > pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> > pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> > pci 0000:01:00.0: PCI bridge to [bus 02-04]
> > pci 0000:01:00.0:   bridge window [mem 0x40400000-0x406fffff]
> > pci 0000:01:00.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> > ...
> > pci_bus 0000:03: busn_res: [bus 03] is released
> > pci 0000:03:00.0: reg 0x10: [mem 0x6400000000-0x6400ffffff 64bit pref]
> > pci 0000:03:00.0: reg 0x18: [mem 0x6000000000-0x63ffffffff 64bit pref]
> > pci 0000:03:00.0: reg 0x30: [mem 0x40400000-0x405fffff pref]
> > pci 0000:02:01.0: PCI bridge to [bus 03]
> > pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> > pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> > pci 0000:02:01.0: BAR 9: no space for [mem size 0x600000000 64bit pref]
> > pci 0000:02:01.0: BAR 9: failed to assign [mem size 0x600000000 64bit pref]
> > pci 0000:02:01.0: BAR 8: assigned [mem 0x40400000-0x405fffff]
> > pci 0000:03:00.0: BAR 2: no space for [mem size 0x400000000 64bit pref]
> > pci 0000:03:00.0: BAR 2: failed to assign [mem size 0x400000000 64bit pref]
> > pci 0000:03:00.0: BAR 0: no space for [mem size 0x01000000 64bit pref]
> > pci 0000:03:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit pref]
> > pci 0000:03:00.0: BAR 6: assigned [mem 0x40400000-0x405fffff pref]
> > pci 0000:02:01.0: PCI bridge to [bus 03]
> > pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> > 
> > This is a major surprise for users who are suddenly left with a PCIe
> > device that was working fine with the original bridge window sizing.
> > 
> > Even if the already assigned bridge window could be enlarged by
> > reallocation in some cases (something the current code does not attempt
> > to do), it is not possible in general case and the large amount of
> > wasted space at the tail of the bridge window may lead to other
> > resource exhaustion problems on Root Complex level (think of multiple
> > PCIe cards with VFs and BAR size disparity in a single system).
> > 
> > PCI specifications only expect natural alignment for BARs (PCI Express
> > Base Specification, rev. 6.1 sect. 7.5.1.2.1) and minimum of 1MiB
> > alignment for the bridge window (PCI Express Base Specification,
> > rev 6.1 sect. 7.5.1.3). The current bridge window tail alignment rule
> > was introduced in the commit 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI
> > allocation code (alpha, arm, parisc) [2/2]") that only states:
> > "pbus_size_mem: core stuff; tested with randomly generated sets of
> > resources". It does not explain the motivation for the extra tail space
> > allocated that is not truly needed by the downstream resources. As
> > such, it is far from clear if it ever has been required by any HW.
> > 
> > To prevent PCIe cards with BAR size disparity from becoming unusable
> > after remove & rescan cycle, attempt to do a truly minimal allocation
> > for memory resources if needed. First check if the normally calculated
> > bridge window will not fit into an already assigned upstream resource.
> > In such case, try with relaxed bridge window tail sizing rules instead
> > where no extra tail space is requested beyond what the downstream
> > resources require. Only enforce the alignment requirement of the bridge
> > window itself (normally 1MiB).
> > 
> > With this patch, the resources are successfully allocated:
> > 
> > pci 0000:02:01.0: PCI bridge to [bus 03]
> > pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> > pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> > pci 0000:02:01.0: bridge window [mem 0x6000000000-0x6400ffffff 64bit pref] to [bus 03] requires relaxed alignment rules
> > pci 0000:02:01.0: BAR 9: assigned [mem 0x6000000000-0x6400ffffff 64bit pref]
> > pci 0000:02:01.0: BAR 8: assigned [mem 0x40400000-0x405fffff]
> > pci 0000:03:00.0: BAR 2: assigned [mem 0x6000000000-0x63ffffffff 64bit pref]
> > pci 0000:03:00.0: BAR 0: assigned [mem 0x6400000000-0x6400ffffff 64bit pref]
> > pci 0000:03:00.0: BAR 6: assigned [mem 0x40400000-0x405fffff pref]
> > pci 0000:02:01.0: PCI bridge to [bus 03]
> > pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> > pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> > 
> > This patch draws inspiration from the initial investigations and work
> > by Mika Westerberg.

> > +			if (!r || r == &ioport_resource || r == &iomem_resource)
> > +				continue;
> 
> > +			if (!r->parent || (r->flags & mask) != type)
> 
> Thinking more about these checks, r->parent should be NULL for the root
> resources, hence this check basically covers the second part of the above.
>
> But like you said it's a material for a separate investigation.

This new argument, however, is more convincing than the one you presented 
earlier. It is indeed true that even if we'd somehow end up into one of 
those root resources, its ->parent should be NULL (which differentiates 
this code from the other function which doesn't have similar ->parent 
check).

Also, the code has evolved to stop at the Root Port so it's another thing 
which should prevent even reaching that far.

> > +	    pbus_upstream_assigned_limit(bus, mask | IORESOURCE_PREFETCH, type,
> > +					 size0, add_align)) {
> 
> One line?

I don't think so, 101 chars.

-- 
 i.

--8323329-935243227-1703688270=:2838--

