Return-Path: <linux-pci+bounces-44461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E649ED106E9
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 04:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 108EB30590CF
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 03:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0316275870;
	Mon, 12 Jan 2026 03:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzBVZGMe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B99307ACC;
	Mon, 12 Jan 2026 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768187500; cv=none; b=guYv3vm9l6iewiXpUwijerjlMeMN6D0F4rEElMSoCjXrbcuYFPUCUGbkO7HV+2Mf+IjKNMeECLXHlKmfi3fRNg6F5TYpL5PenGsTClWAptgJk/9jMWSbGJn6KdO677TV1GmkHb00kvcsZzbLqNxAEajjst/hxypfjTm/R9UWirU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768187500; c=relaxed/simple;
	bh=DzY5oWWc+KGbphha6ii6scuU9mo7XBBJd6oc7NYhQCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ0jt5YgdB3YDnqA4IonPmhqiSE1RcP/1n+nB9W5He+tS/jIVz4ipmyMitmUwKG7DDl/gRflJKbC67cWnVW56NIky8SSpw1l7KfrgXtoHzxKta0jV7WJ53pmpwn2Hqvk2xVKdOeJP0F2SDCXcJMj6oWADU4cgFnOwMTpCu5jh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzBVZGMe; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768187500; x=1799723500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DzY5oWWc+KGbphha6ii6scuU9mo7XBBJd6oc7NYhQCM=;
  b=HzBVZGMeA2qs8vxQECNor6287zQHzgWeHARz7M92XQjXuMTjAQKuGAQJ
   xfm2pXn5x21TF4EcofsE33G2qAOxQFg1umNvwb33brunOsTYFkPoyK/n0
   HGOsqxxZCRb9zhJGBJjAHTz04ZxpMeRWDhGzo7PLDRzJHv6Hf9+gsoVVM
   pJydTGTSenwFNtSfEi95cNIObgkO199lF/qtSadf72klGBwBNtt/bvpo7
   sP/Nf5EQTDJGBK8e08n995N16zXPEeyuQd4n2Z0j/p0rt08Ace2J7qIJu
   XM3VXd1K4EtevxgRdqAadoRKpI169VnKd0qgQLv5o4oAAly7GYs7XG7YU
   A==;
X-CSE-ConnectionGUID: W7lIrTofTPabgl9a+jJu1A==
X-CSE-MsgGUID: KDc4VOpyTOug92m7AhwPVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69195458"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69195458"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 19:11:39 -0800
X-CSE-ConnectionGUID: JOhHEdLuRPCHT+EnmqOwkw==
X-CSE-MsgGUID: 688HgPkvQlKgpoX4SWExWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204682058"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jan 2026 19:11:37 -0800
Date: Mon, 12 Jan 2026 10:54:14 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dan.j.williams@intel.com, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/IDE: Fix reading a wrong reg for unused sel
 stream initialization
Message-ID: <aWRiVuxVYDqSxo4I@yilunxu-OptiPlex-7050>
References: <20260111073823.486665-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111073823.486665-1-ming.li@zohomail.com>

On Sun, Jan 11, 2026 at 03:38:23PM +0800, Li Ming wrote:
> During pci_ide_init(), it will write PCI_ID_RESERVED_STREAM_ID into all
> unused selective IDE stream blocks. In a selective IDE stream block, IDE
> stream ID field is in selective IDE stream control register instead of
> selective IDE stream capability register.
> 
> Fixes: 079115370d00 ("PCI/IDE: Initialize an ID for all IDE streams")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/pci/ide.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index f0ef474e1a0d..26f7cc94ec31 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -168,7 +168,7 @@ void pci_ide_init(struct pci_dev *pdev)
>  	for (u16 i = 0; i < nr_streams; i++) {
>  		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
>  
> -		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
> +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CTL, &val);

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

