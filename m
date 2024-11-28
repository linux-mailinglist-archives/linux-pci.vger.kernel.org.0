Return-Path: <linux-pci+bounces-17433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E811B9DB501
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 10:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B6C280169
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AFF158527;
	Thu, 28 Nov 2024 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJIXEl5T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88789152E0C;
	Thu, 28 Nov 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787136; cv=none; b=l92AC4TE3khuXRc1d6u3zt0ZFUJ5OUEbXOHNCHnHUArNvBAsWDji1FYwz41Nb80XuwDzmAvkpMSHhdetHblFVixolcZDO/3FYuKmNfO1+6dNSWjhMEIbH/IgbnsT2Pb1Fuffcgzlwbxl9YedBSkWNC0kaqXWhJT4V8cdair6fYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787136; c=relaxed/simple;
	bh=VlIE6RIxvqJFw6Ernh2UFSRcv6fh1+oPso99GrYY9Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWvx4Ri+ROkfqWoE3/D7AocQJ2egJSsSNhIVDDUL8SqiehWZTD2LAkaS9L6HgNjtq/xlpgVcWGZQG6ijpSNhItxiVOb+7IJ7fd0GNAyxHy+n5VQmWjSiZeEBsWlfzVGWXKEhUF6j1O9K+tamgj8q5/P4DT55ZdbVK5P3L7FWosg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJIXEl5T; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732787133; x=1764323133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VlIE6RIxvqJFw6Ernh2UFSRcv6fh1+oPso99GrYY9Kc=;
  b=XJIXEl5TXfRgB11xOHy4lqPlMDQ9ha1h904lM00TATHyzvfmyaqoao/z
   CaR26pPjy98WEProDQyRMRIeKq/3eGYIT/MIZFh/NbJdknzzbd8cs3f7U
   QFsARAjZhed6YnaSYuvNz7uzIfhb0LuXip3Qv2GaFgIWi8NIk5iBExui7
   rOknT1Cop1EwNx9FXYgN3gqqzX56SkjkgHyQo2GcdRfl1zB8PNzHIE+1D
   /JAwLqAkDp0QiwNfytdeWw7lz1uiAn3YXBdsglPuRCQRffeefl04UGlY2
   gBT88nPZegaqaGXrWWBjEmSEj1BYv1fyLaiPOQ8GRMHIwKQOAHbKcnQJY
   w==;
X-CSE-ConnectionGUID: qQ3vmaLcRuaHc4KuXSBrfg==
X-CSE-MsgGUID: yN8ajW8pRA64hMGKCjLgDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="32380305"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="32380305"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 01:45:32 -0800
X-CSE-ConnectionGUID: Wq03iqE9Qf+mw7eAhqfgbg==
X-CSE-MsgGUID: jfPso0SZS6ew3ZFCHSPE/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="96284587"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 28 Nov 2024 01:45:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id A40C01BD; Thu, 28 Nov 2024 11:45:29 +0200 (EET)
Date: Thu, 28 Nov 2024 11:45:29 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Carol Soto <csoto@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Chris Chiu <chris.chiu@canonical.com>,
	"Matthew R . Ochs" <mochs@nvidia.com>, Koba Ko <kobak@nvidia.com>
Subject: Re: [PATCH] PCI: Use downstream bridges for distributing resources
Message-ID: <20241128094529.GT4065732@black.fi.intel.com>
References: <20241128084039.54972-1-kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128084039.54972-1-kaihengf@nvidia.com>

On Thu, Nov 28, 2024 at 04:40:39PM +0800, Kai-Heng Feng wrote:
> Commit 7180c1d08639 ("PCI: Distribute available resources for root
> buses, too") breaks BAR assignment on some devcies:
> [   10.021193] pci 0006:03:00.0: BAR 0 [mem 0x6300c0000000-0x6300c1ffffff 64bit pref]: assigned
> [   10.029880] pci 0006:03:00.1: BAR 0 [mem 0x6300c2000000-0x6300c3ffffff 64bit pref]: assigned
> [   10.038561] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: can't assign; no space
> [   10.047191] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: failed to assign
> [   10.055285] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space
> [   10.064180] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: failed to assign
> [   10.072543] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space
> [   10.081437] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: failed to assign
> 
> The apertures of domain 0006 before the commit:
> 6300c0000000-63ffffffffff : PCI Bus 0006:00
>   6300c0000000-6300c9ffffff : PCI Bus 0006:01
>     6300c0000000-6300c9ffffff : PCI Bus 0006:02
>       6300c0000000-6300c8ffffff : PCI Bus 0006:03
>         6300c0000000-6300c1ffffff : 0006:03:00.0
>           6300c0000000-6300c1ffffff : mlx5_core
>         6300c2000000-6300c3ffffff : 0006:03:00.1
>           6300c2000000-6300c3ffffff : mlx5_core
>         6300c4000000-6300c47fffff : 0006:03:00.2
>         6300c4800000-6300c67fffff : 0006:03:00.0
>         6300c6800000-6300c87fffff : 0006:03:00.1
>       6300c9000000-6300c9bfffff : PCI Bus 0006:04
>         6300c9000000-6300c9bfffff : PCI Bus 0006:05
>           6300c9000000-6300c91fffff : PCI Bus 0006:06
>           6300c9200000-6300c93fffff : PCI Bus 0006:07
>           6300c9400000-6300c95fffff : PCI Bus 0006:08
>           6300c9600000-6300c97fffff : PCI Bus 0006:09
> 
> After the commit:
> 6300c0000000-63ffffffffff : PCI Bus 0006:00
>   6300c0000000-6300c9ffffff : PCI Bus 0006:01
>     6300c0000000-6300c9ffffff : PCI Bus 0006:02
>       6300c0000000-6300c43fffff : PCI Bus 0006:03
>         6300c0000000-6300c1ffffff : 0006:03:00.0
>           6300c0000000-6300c1ffffff : mlx5_core
>         6300c2000000-6300c3ffffff : 0006:03:00.1
>           6300c2000000-6300c3ffffff : mlx5_core
>       6300c4400000-6300c4dfffff : PCI Bus 0006:04
>         6300c4400000-6300c4dfffff : PCI Bus 0006:05
>           6300c4400000-6300c45fffff : PCI Bus 0006:06
>           6300c4600000-6300c47fffff : PCI Bus 0006:07
>           6300c4800000-6300c49fffff : PCI Bus 0006:08
>           6300c4a00000-6300c4bfffff : PCI Bus 0006:09
> 
> We can see that the window of 0006:03 gets shrunken too much and 0006:04
> eats away the window for 0006:03:00.2.
> 
> The offending commit distributes the upstream bridge's resources
> multiple times to every downstream bridges, hence makes the aperture
> smaller than desired because calculation of io_per_b, mmio_per_b and
> mmio_pref_per_b becomes incorrect.
> 
> Instead, distributing downstream bridges' own resources to resolve the
> issue.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219540
> Cc: Carol Soto <csoto@nvidia.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Chris Chiu <chris.chiu@canonical.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> Reviewed-by: Koba Ko <kobak@nvidia.com>
> Fixes: 7180c1d08639 ("PCI: Distribute available resources for root buses, too")
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> ---
>  drivers/pci/setup-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 23082bc0ca37..2db19c17e824 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2105,7 +2105,7 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
>  		 * in case of root bukjijs.
>  		 */
>  		if (bridge && pci_bridge_resources_not_assigned(dev))
> -			pci_bridge_distribute_available_resources(bridge,
> +			pci_bridge_distribute_available_resources(dev,
>  								  add_list);

I think it looks better if you put this into one line instead:

			pci_bridge_distribute_available_resources(dev, add_list);


Otherwise looks good. I wonder if you checked that this still works with
the cases 7180c1d08639 tried to solve? ;-)
>  		else
>  			pci_root_bus_distribute_available_resources(b, add_list);
> -- 
> 2.47.0

