Return-Path: <linux-pci+bounces-7423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA66A8C4273
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 15:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41ECB1F21CE8
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B8B154C1E;
	Mon, 13 May 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2rJQHgX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE2154C00
	for <linux-pci@vger.kernel.org>; Mon, 13 May 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607977; cv=none; b=Otjc3r9eQTRTV7Oeh60Qt2DxrH0q5nt1acUkkzK6nBdLkAlEDb6JjbmICv3FCX3dgxumjOsoWzpMq3qrwyaruu6EkUymtY62gJRt5iQl8IzIHoiADWZUeoCHLA7xw/aJWPLBH2S+ND628oUfVPNOKbTVAnacv6n6IrN86HCUy5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607977; c=relaxed/simple;
	bh=hhKqe15BWksakQ4Oq6c7Nwxl+Lxd7GxYr0CiHLXW+7Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xvfr5Dr55UeICz1ZXQQqtiT24Lc6d6s5OcqfBueDguWVw/5NFfnbZI4vEt4W5hPNXpxr/Nmvd2pEzJzqkK+xbNh15JO7QUM0s0hI5AxCFwYipRfxUTft31ZjBxhrDlKteGbHIZlat79m3D20UsGiGrblIu7/MIEOrIWMpsQJtQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2rJQHgX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715607976; x=1747143976;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=hhKqe15BWksakQ4Oq6c7Nwxl+Lxd7GxYr0CiHLXW+7Y=;
  b=G2rJQHgXW2sp9CCoVCbB88xvW3GMs1D72bakbqJUHskpOac4pWD5med7
   ffDstV4hQl4htawyop2kV2PcacjV6OZsZXAC52QcGrKPOnZQgt0CamK8p
   5jP3u7r0d1Jp023wMa3oZ0xr8pk535MSn5peLt+ahC5xFTjrQGzMCF7vp
   rab7LomAM/DwX6G71Ln2xDctQ0dw+AqJ55H9RbKCRFxrYTNgaOszSvRzo
   jJKCWQJi53MbF2niFjCUqmgh1utfj9bSXUXDY+tOZjV5ItfDjJPECO9wG
   LwAhFwulU+df6H2x/qWmmA2TnVHri+OsNlfh82hl1bKIzeY0u/bfEU2xS
   A==;
X-CSE-ConnectionGUID: mPqJg5uETrqgiFmEWavO3w==
X-CSE-MsgGUID: nEhmZ6WyQFW+O2Wss44EEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="22688984"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="22688984"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 06:46:15 -0700
X-CSE-ConnectionGUID: JlSDXtdMQa2j3dPqZSihmQ==
X-CSE-MsgGUID: aedbELwpQY6y35RUejmaFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30461993"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.89])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 06:46:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 May 2024 16:46:09 +0300 (EEST)
To: Alex Williamson <alex.williamson@redhat.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, geoff@hostfission.com
Subject: Re: [PATCH] PCI: Release unused bridge resources during resize
In-Reply-To: <20240507213125.804474-1-alex.williamson@redhat.com>
Message-ID: <a16aeae5-9507-3a5d-de04-04eb92aefffc@linux.intel.com>
References: <20240507213125.804474-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <cbee11f7-13ca-b864-2ce1-dd67069a2073@linux.intel.com>

On Tue, 7 May 2024, Alex Williamson wrote:

> Resizing BARs can be blocked when a device in the bridge hierarchy
> itself consumes resources from the resized range.  This scenario is
> common with Intel Arc DG2 GPUs where the following is a typical
> topology:
> 
>  +-[0000:5d]-+-00.0-[5e-61]----00.0-[5f-61]--+-01.0-[60]----00.0  Intel Corporation DG2 [Arc A380]
>                                              \-04.0-[61]----00.0  Intel Corporation DG2 Audio Controller
> 
> Here the system BIOS has provided a large 64bit, prefetchable window:
> 
> pci_bus 0000:5d: root bus resource [mem 0xb000000000-0xbfffffffff window]
> 
> But only a small portion is programmed into the root port aperture:
> 
> pci 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]
> 
> The upstream port then provides the following aperture:
> 
> pci 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> 
> With the missing range found to be consumed by the switch port itself:
> 
> pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]
> 
> The downstream port above the GPU provides the same aperture as upstream:
> 
> pci 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> 
> Which is entirely consumed by the GPU:
> 
> pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> 
> In summary, iomem reports the following:
> 
> b000000000-bfffffffff : PCI Bus 0000:5d
>   bfe0000000-bff07fffff : PCI Bus 0000:5e
>     bfe0000000-bfefffffff : PCI Bus 0000:5f
>       bfe0000000-bfefffffff : PCI Bus 0000:60
>         bfe0000000-bfefffffff : 0000:60:00.0
>     bff0000000-bff07fffff : 0000:5e:00.0
> 
> The GPU at 0000:60:00.0 supports a Resizable BAR:
> 
> 	Capabilities: [420 v1] Physical Resizable BAR
> 		BAR 2: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB 8GB
> 
> However when attempting a resize we get -ENOSPC:
> 
> pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pcieport 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
> pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
> pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
> pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
> pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: can't assign; no space
> pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: failed to assign
> pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
> pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pcieport 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]
> pcieport 0000:5e:00.0: PCI bridge to [bus 5f-61]
> pcieport 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pcieport 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> pcieport 0000:5f:01.0: PCI bridge to [bus 60]
> pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
> pcieport 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: assigned
> 
> In this example we need to resize all the way up to the root port
> aperture, but we refuse to change the root port aperture while resources
> are allocated for the upstream port BAR.
> 
> The solution proposed here builds on the idea in commit 91fa127794ac
> ("PCI: Expose PCIe Resizable BAR support via sysfs") where the BAR can
> be resized while there is no driver attached.  In this case, when there
> is no driver bound to the upstream switch port we'll release resources
> of the bridge which match the reallocation.  Therefore we can achieve
> the below successful resize operation by unbinding 0000:5e:00.0 from the
> pcieport driver before invoking the resource2_resize interface on the
> GPU at 0000:60:00.0.
> 
> pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pci 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]: releasing
> pcieport 0000:5d:00.0: bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]: releasing
> pcieport 0000:5d:00.0: bridge window [mem 0xb000000000-0xb2ffffffff 64bit pref]: assigned
> pci 0000:5e:00.0: bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
> pci 0000:5e:00.0: BAR 0 [mem 0xb200000000-0xb2007fffff 64bit pref]: assigned
> pcieport 0000:5f:01.0: bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
> pci 0000:60:00.0: BAR 2 [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
> pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
> pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
> pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
> pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pcieport 0000:5d:00.0:   bridge window [mem 0xb000000000-0xb2ffffffff 64bit pref]
> pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
> pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
> pcieport 0000:5f:01.0: PCI bridge to [bus 60]
> pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
> pcieport 0000:5f:01.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Yes. Looks another case where an already assigned resource prevents some 
operation from succeeding.

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 909e6a7c3cc3..15fc8e4e84c9 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2226,6 +2226,26 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
>  }
>  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
>  
> +static void pci_release_resource_type(struct pci_dev *pdev, unsigned long type)
> +{
> +	int i;
> +
> +	if (!device_trylock(&pdev->dev))
> +		return;
> +
> +	if (pdev->dev.driver)

Isn't portdrv bound to bridges so how does this ends up working?

-- 
 i.

> +		goto unlock;
> +
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		if (pci_resource_len(pdev, i) &&
> +		    !((pci_resource_flags(pdev, i) ^ type) & PCI_RES_TYPE_MASK))
> +			pci_release_resource(pdev, i);
> +	}
> +
> +unlock:
> +	device_unlock(&pdev->dev);
> +}
> +
>  int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  {
>  	struct pci_dev_resource *dev_res;
> @@ -2260,8 +2280,10 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  
>  			pci_info(bridge, "%s %pR: releasing\n", res_name, res);
>  
> -			if (res->parent)
> +			if (res->parent) {
>  				release_resource(res);
> +				pci_release_resource_type(bridge, type);
> +			}
>  			res->start = 0;
>  			res->end = 0;
>  			break;
> 

