Return-Path: <linux-pci+bounces-42765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBA4CAD8A9
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 16:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 008C7301E18B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266FB2264B0;
	Mon,  8 Dec 2025 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8MeFnOh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E943B8D65;
	Mon,  8 Dec 2025 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765206963; cv=none; b=P0JtVJVEGMnzCHDAZyEeZsuNJExc43UZwFWFl+0jnVQtBGwJ7+WsK5iQeaxCTe/fY+YqjyIdw0PNaTAYVAzR9bsMA2c+QL5YSU0vQpR3pygyLcPs4gUURJEppJaSYUxIxWpLZIXwFPQwJE19DArUboArQ4XS0Pghj+c6ujmLb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765206963; c=relaxed/simple;
	bh=EX/r/ZEebjKBLfAsdiGqZ0VQ9J37MhujrEhyYP0o/2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+WlAijD8ipHu/E3kiRjeTQ/CiJEfGmPgmNOa3t+VAz6kQ4LqESKkeOttZJMa8luTarvOZlyBjFpvrRRDuJolgMNAK6wKeRbP1ppr32Du33Z2tpLOh81jgkqelvDy4eDW5kmk5kjPE2CZrUymnKelBnCy3I+NWzla2SoZ+OTTTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8MeFnOh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765206961; x=1796742961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EX/r/ZEebjKBLfAsdiGqZ0VQ9J37MhujrEhyYP0o/2o=;
  b=l8MeFnOheCeBnwABN7WbULkyyTt28MSkSUF0vApNL1q5loYShO5oyYRS
   vgxw255MMSVUdy3vqK3fmTCEEDu+caMtot5NZto+2tO7WobED77st68uq
   FyZWzRgsR40fDZejQ1s42c5LpiM9b48DwI6Qzz+qk1VaP/9sEXt4hxpYR
   Zj3xysfH/MsEQt7/6BMNkb2iR+h5dsJtjgWkdCdqfZm04SK0omzsk4X5E
   tpmmbj1e6RiXIuk5W6ayuKESfaAlKC8Ey6i6J6TzOQHoNl1c+2HSHb54C
   sUfvrJT0Mu32u6MDV+F0kA7S3D6Nmt8Y3lVk/kpFsj/HOp2v9r4XQgOr5
   w==;
X-CSE-ConnectionGUID: CNjWmldLSe+nXLmzn3uMrw==
X-CSE-MsgGUID: lrCi3daYRTemreQPPN4gug==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67080218"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67080218"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 07:15:59 -0800
X-CSE-ConnectionGUID: jMZPeZHeTDyPdyhscUiB5A==
X-CSE-MsgGUID: ghl9avI/R42LAT18i8KDlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="200427605"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 08 Dec 2025 07:15:57 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A920098; Mon, 08 Dec 2025 16:15:55 +0100 (CET)
Date: Mon, 8 Dec 2025 16:15:55 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH 1/1] PCI: Use resource_set_range() that correctly sets
 ->end
Message-ID: <aTbrq7QZMYG0M3ka@black.igk.intel.com>
References: <20251208145654.5294-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251208145654.5294-1-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 08, 2025 at 04:56:54PM +0200, Ilpo Järvinen wrote:
> __pci_read_base() sets resource start and end addresses when resource
> is larger than 4G but pci_bus_addr_t or resource_size_t are not capable
> of representing 64-bit PCI addresses. This creates a problematic
> resource that has non-zero flags but the start and end addresses do not
> yield to resource size of 0 but 1.
> 
> Replace custom resource addresses setup with resource_set_range()
> that correctly sets end address as -1 which results in resource_size()
> returning 0.
> 
> For consistency, also use resource_set_range() in the other branch that
> does size based resource setup.

Since I have been involved in the related discussion and the patch LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



