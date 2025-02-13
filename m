Return-Path: <linux-pci+bounces-21386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB98A3506F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 22:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B285F3A9BDC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 21:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727DA266194;
	Thu, 13 Feb 2025 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6rnflM+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E823A9AC;
	Thu, 13 Feb 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481717; cv=none; b=apl1KCPUrn8KmdRvmRgNzfUeh1MacivHS5rqL45uGcATPA9sr7L0VCKKGIa58SXm/PS6ebIQca/IpMJSkIFWyQrY7k0IafMVUrLIvVgrM2mHVtl2p+cev91icPd/+sxaCUgOIwE+z+tmzYUGeWNWAcbLfb2PlSiq3HgpEMZnEk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481717; c=relaxed/simple;
	bh=24Yt0x6szBYWV3z1QRdGHcFKvazuY392t8ua427mapY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G04xkJUl+4hRojYJ0AQxyTU0oqZLtpj/wPvZd/nbNZrLYw8ySYR6uLtkqxhirhL2qwZxa2X1RQ6ysIDNvmbN3dwvGB38/h0/m5OCQw/W35v5MiC5MH6QGVgfEzOLTm2Sx6uvj3J9PM6afwdFhifcRPfkuJAy+eZJ/6C9+radt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6rnflM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963C3C4CED1;
	Thu, 13 Feb 2025 21:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739481716;
	bh=24Yt0x6szBYWV3z1QRdGHcFKvazuY392t8ua427mapY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F6rnflM+ZR2MGQ5IppUfs5zVBJJXYtlxfCAO4Ql/for7ec9mKs+2V2y1CFiFkpTjA
	 nz5dWPWOYMnCYDz4SNRNxGZYFIB0z7j6nf9XgXoLuf5X0pzUnK8t/gK+KiVTMPEftb
	 Y/kaLQJdZWrE/jkLx4Xn4vh5lgSDzvRVa9uhVH4sQRWneNolSjXY618fVSY7Zko7DJ
	 noehUtSWqgv3ikJQSv/H/leGtbyYXrUbVGvnMQKxk7Mkoz1HKCIHPRCwFmVtgJKLPa
	 c7uCyBu5ddaNrLAwLz+3Tfv0hv/qmk7VqRi6DXqhfFmo3xI7m3ZwT4krRdp/R7UZW1
	 GLBCD1Wcrp52g==
Date: Thu, 13 Feb 2025 15:21:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: bhelgaas@google.com, mika.westerberg@linux.intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Carol Soto <csoto@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Chris Chiu <chris.chiu@canonical.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v2] PCI: Use downstream bridges for distributing resources
Message-ID: <20250213212155.GA129006@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
> Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> Fixes: 7180c1d08639 ("PCI: Distribute available resources for root buses, too")
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

Applied with Mika's Reviewed-by to pci/resource for v6.15, thanks!

> ---
>  drivers/pci/setup-bus.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 23082bc0ca37..a6e653a4f5b1 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2105,8 +2105,7 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
>  		 * in case of root bus.
>  		 */
>  		if (bridge && pci_bridge_resources_not_assigned(dev))
> -			pci_bridge_distribute_available_resources(bridge,
> -								  add_list);
> +			pci_bridge_distribute_available_resources(dev, add_list);
>  		else
>  			pci_root_bus_distribute_available_resources(b, add_list);
>  	}
> -- 
> 2.47.0
> 

