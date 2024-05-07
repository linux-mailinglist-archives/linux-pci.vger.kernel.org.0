Return-Path: <linux-pci+bounces-7170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6FF8BE4B3
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 15:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2311C237BF
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195AE15FA8E;
	Tue,  7 May 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPO4q6Dq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E715F408;
	Tue,  7 May 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089802; cv=none; b=cBvLW0CkR0XKcb3dZelgFpH8G7kv/Fyc5HeBkMxtCnC4lFjidwSfstKR6SB3FJBSANKoME2sQTjNg022J5N+ocscoYnsGGP1nSBRSuwUdZ7NH/mHhIIKSBXuQ6YNHEJ6fHnJJirQsIt+CYCg7pE6+5KPH3ceROjPsZH03MhNdYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089802; c=relaxed/simple;
	bh=Hc/RNhSHcD+jiFZ3nckCqRmYXWrEE8CcqIQTZk2O420=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzNS9Dm9tnYD9RF1K6buVPkIErlqDiSiUhKQrMqCGWToOYwFdj8OYKjKmjmDo6SNEY9yekvcNAihVpHbqlhmYsyZ1NWB5vOXwpHEkGQP30iQiSPQ5ySKQ/sUEzZ+mhF+Xb2bzqsSCUsGWcXdHNJa3PYcs3YNOGh36gNWDuBMt6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPO4q6Dq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715089801; x=1746625801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Hc/RNhSHcD+jiFZ3nckCqRmYXWrEE8CcqIQTZk2O420=;
  b=lPO4q6DqTv+La3L0KmoNPnbHjH9mjcd1qZgz4Ua8zFrrUTaBoXba/XSf
   Onfu/MJ3XGVqELNP0WkzCDly/iNUBaM7yrjc6P1pAlyojCKsaz/C1dJW4
   jr3/J3jejgbYBcALP5JxuKLADjAUM+JJt6hjM9kLHnX6fkUe3OEL7R3NY
   WE0R4UHiKJZLpGTmoJPbPUFB9+2aV1VM16znyHpclKrA/c9Nk5ZDL27Yy
   +HZaF889JItz2cvuCIvix00qOqTEgdRwco49SQiZlohCvFvSdXskTjvXY
   jdJEgrrdsRMjEAMQq1XcCbFAYQ2bt3WL1q71BHwlRxs11R+IZFnAStowX
   g==;
X-CSE-ConnectionGUID: uH1djRypTx2HAzQdA+4hog==
X-CSE-MsgGUID: EkPzERAtTTuypTkrfiU9CA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11009876"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="11009876"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 06:49:56 -0700
X-CSE-ConnectionGUID: /XUIx9WsSy+oT5gg8tWNvw==
X-CSE-MsgGUID: S/gy+mMrSb2BvdjaEjbhbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="29114486"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 06:49:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1s4LCX-000000053NT-2YJH;
	Tue, 07 May 2024 16:49:49 +0300
Date: Tue, 7 May 2024 16:49:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, Lidong Wang <lidong.wang@intel.com>
Subject: Re: [PATCH v3 8/8] PCI: Relax bridge window tail sizing rules
Message-ID: <ZjoxfYEi9mMQnRBh@smile.fi.intel.com>
References: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
 <20240507102523.57320-9-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507102523.57320-9-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 07, 2024 at 01:25:23PM +0300, Ilpo Järvinen wrote:
> During remove & rescan cycle, PCI subsystem will recalculate and adjust
> the bridge window sizing that was initially done by "BIOS". The size
> calculation is based on the required alignment of the largest resource
> among the downstream resources as per pbus_size_mem() (unimportant or
> zero parameters marked with "..."):
> 
> 	min_align = calculate_mem_align(aligns, max_order);
> 	size0 = calculate_memsize(size, ..., min_align);
> 
> inside calculate_memsize(), for the largest alignment:
> 	min_align = align1 >> 1;
> 	...
> 	return min_align;
> 
> and then in calculate_memsize():
> 	return ALIGN(max(size, ...), align);
> 
> If the original bridge window sizing tried to conserve space, this will
> lead to massive increase of the required bridge window size when the
> downstream has a large disparity in BAR sizes. E.g., with 16MiB and
> 16GiB BARs this results in 24GiB bridge window size even if 16MiB BAR
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
> 
> pci 0000:03:00.0: device released
> pci 0000:02:01.0: device released
> pcieport 0000:01:00.0: scanning [bus 02-04] behind bridge, pass 0
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> pci 0000:02:01.0: scanning [bus 03-03] behind bridge, pass 0
> pci 0000:03:00.0: BAR 0 [mem 0x6400000000-0x6400ffffff 64bit pref]
> pci 0000:03:00.0: BAR 2 [mem 0x6000000000-0x63ffffffff 64bit pref]
> pci 0000:03:00.0: ROM [mem 0x40400000-0x405fffff pref]
> 
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0: scanning [bus 03-03] behind bridge, pass 1
> pcieport 0000:01:00.0: scanning [bus 02-04] behind bridge, pass 1
> pci 0000:02:01.0: bridge window [mem size 0x600000000 64bit pref]: can't assign; no space
> pci 0000:02:01.0: bridge window [mem size 0x600000000 64bit pref]: failed to assign
> pci 0000:02:01.0: bridge window [mem 0x40400000-0x405fffff]: assigned
> pci 0000:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; no space
> pci 0000:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
> pci 0000:03:00.0: BAR 0 [mem size 0x01000000 64bit pref]: can't assign; no space
> pci 0000:03:00.0: BAR 0 [mem size 0x01000000 64bit pref]: failed to assign
> pci 0000:03:00.0: ROM [mem 0x40400000-0x405fffff pref]: assigned
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
> pci 0000:02:01.0: scanning [bus 03-03] behind bridge, pass 1
> pcieport 0000:01:00.0: scanning [bus 02-04] behind bridge, pass 1
> pcieport 0000:01:00.0: Assigned bridge window [mem 0x6000000000-0x6400ffffff 64bit pref] to [bus 02-04] cannot fit 0x600000000 required for 0000:02:01.0 bridging to [bus 03]
> pci 0000:02:01.0: bridge window [mem 0x6000000000-0x6400ffffff 64bit pref] to [bus 03] requires relaxed alignment rules
> pcieport 0000:01:00.0: Assigned bridge window [mem 0x40400000-0x406fffff] to [bus 02-04] free space at [mem 0x40400000-0x405fffff]
> pci 0000:02:01.0: bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]: assigned
> pci 0000:02:01.0: bridge window [mem 0x40400000-0x405fffff]: assigned
> pci 0000:03:00.0: BAR 2 [mem 0x6000000000-0x63ffffffff 64bit pref]: assigned
> pci 0000:03:00.0: BAR 0 [mem 0x6400000000-0x6400ffffff 64bit pref]: assigned
> pci 0000:03:00.0: ROM [mem 0x40400000-0x405fffff pref]: assigned
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> 
> This patch draws inspiration from the initial investigations and work
> by Mika Westerberg.

...

> +		min_align = 1ULL << (max_order + __ffs(SZ_1M));

In case of a new version of the series, this can utilise BIT_ULL().

-- 
With Best Regards,
Andy Shevchenko



