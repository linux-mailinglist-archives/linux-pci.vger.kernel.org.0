Return-Path: <linux-pci+bounces-17625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971289E334A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 06:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FAD160601
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 05:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C87B1684AE;
	Wed,  4 Dec 2024 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDPCpxNc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB4155398;
	Wed,  4 Dec 2024 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291298; cv=none; b=jpJdmYpE9ezuFBeF1lCiEmzj4VPaN3HspsNlV85mglZ0GpOfOOYrh/lWJfqFrvyfVChgDaur5zTwCYd2QgHhRUoni/nGiB/SfnGczCwQow8WO/IIF9DE01tC4ft6gbZ17MzteZqjTP+xQ1kxS2jE9C8VVT8hcbMtZScZ51QgVmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291298; c=relaxed/simple;
	bh=Hoi5/YmdeLvcI9hXA5NyMgEdnzKFcBJKZwJJ39h2pJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USQjrJJu5NgWfSt2M+2WBJb2ttrpXuhUq4iZvwLRBE8A/FzSLu8SZBg5NV1OR9zAXyKsVivfxc1SLJs5G80qa75l/8INuVVfNPx/8Dk+Uh9cg6UFSJCo/MFyOOlaL2r3Bx4mp8E+FtfRypOwD2C5neaWvQLbMKEeWN9nnOyEDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDPCpxNc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733291295; x=1764827295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hoi5/YmdeLvcI9hXA5NyMgEdnzKFcBJKZwJJ39h2pJU=;
  b=dDPCpxNcw3TuSLoOr7CQO33FA+gNA+JvBrRSFh8G7ZhHpvihqJK2TQo6
   4MgJmARv7sGAlOjFpDMcxTSIVhINXfXxrdeaumAJ7WizxHfZabgPyc9IS
   LCctMkGKTWvLIlOf/QHk7dNigVVSjoUlWrJI8xq83QRr1zVEYC9/h+6sW
   6vceul4JqArbawXBVL/mxZYcndLnAqPg6Jmrz/cF7GiYohLoCH69w0Tx6
   6VUW5LjXU/vLDWkbAZKy/dWBXJMOPJM1f3cFGGKNsWLdc/+TbyxKi77cD
   2xueow/ozU7oH8gmI+Os1A0zvf9EM2tcAEZVcDu8PNmyerQ5FVNiRqLaU
   Q==;
X-CSE-ConnectionGUID: lGs+QmVzTWa2/o8+0AUZNQ==
X-CSE-MsgGUID: wgKGpXqwTOeE7PJdJa9Xzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33414588"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="33414588"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 21:48:14 -0800
X-CSE-ConnectionGUID: si0+KyqoTd+HeF2KRh83tQ==
X-CSE-MsgGUID: 6g9ahGzVQLG1L34DyOiLlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98676943"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 21:48:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 06CFC27C; Wed, 04 Dec 2024 07:48:09 +0200 (EET)
Date: Wed, 4 Dec 2024 07:48:09 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Carol Soto <csoto@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Chris Chiu <chris.chiu@canonical.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v2] PCI: Use downstream bridges for distributing resources
Message-ID: <20241204054809.GD4955@black.fi.intel.com>
References: <20241204022457.51322-1-kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204022457.51322-1-kaihengf@nvidia.com>

On Wed, Dec 04, 2024 at 10:24:57AM +0800, Kai-Heng Feng wrote:
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

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

