Return-Path: <linux-pci+bounces-25656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44945A8560D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 10:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D41D57B0F89
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDF0293450;
	Fri, 11 Apr 2025 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDCsGvAQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C728F952;
	Fri, 11 Apr 2025 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744358533; cv=none; b=qCc+3ml0updI1fav7wm1x04isYyPnfK5lLsli9PBA2ui4DUq0Pyfw/D+G/m1mAAHnxNw66MsqNaka0qtRIJqFAHCSuNOZS17fSHISe4EPAg49QUbE2LWj0jVBpfIAtSIGHUFGqL7aXg/of4TFyikG9mHnMi8Cw0G9rNkIQKC28U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744358533; c=relaxed/simple;
	bh=VPv4id2m4TY8Fmb1lSfEPtllue99RBkAXzud15Ip3W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZSKCrcGBvxUzk2KHRjlo4RdShymcSC6V7+Mk6DSzeQJQOzMJKd32zlN9edYV/hPnZh3CLRRaMwtyz2tEVJ1c91dwLy0172Zja/TTi10Kw0RLkajvZb6NML/QUg86i5iakkvwPvea8A6e2Tnn4Q5fbDQo4phmAPQxVftxPtBNRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDCsGvAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A32CC4CEE7;
	Fri, 11 Apr 2025 08:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744358533;
	bh=VPv4id2m4TY8Fmb1lSfEPtllue99RBkAXzud15Ip3W0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDCsGvAQ8EQmSpGiAiVKosUQ9uBt3exxAWyP481bbStxDVQwS4eJ79B8S4NGkCmCT
	 nJ5CsOaHvC/o1FzuDVp1mcnO9Sh9tR70w7Zh6DI9flpFudcf2lWZ6QQNTJQbYhf0Pa
	 FF30ur8SeO40b8O7f+YboIUQ1J1JKUgjcj5vLaUMbfS+HjTXgAN1vxefw1PBlltTvU
	 /FpU8Ohu4m7d5U1Llu9alh0gIOjzReL/k1v01DtP5+IhDrT8dYnPWdSNoBAsGJEZoH
	 PrjkEkNXQin43eFG5My76D+QovQly6n/PzrK0bFhYhnzhKvEcCtcRIXEa0yylqi+mH
	 i+8MUxrk0BvyQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1u39L6-000000004FW-2zsh;
	Fri, 11 Apr 2025 10:02:16 +0200
Date: Fri, 11 Apr 2025 10:02:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <Z_jMiC1uj_MJpKVj@hovoldconsulting.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>

Hi Robin,

On Fri, Feb 28, 2025 at 03:46:33PM +0000, Robin Murphy wrote:
> In hindsight, there were some crucial subtleties overlooked when moving
> {of,acpi}_dma_configure() to driver probe time to allow waiting for
> IOMMU drivers with -EPROBE_DEFER, and these have become an
> ever-increasing source of problems. The IOMMU API has some fundamental
> assumptions that iommu_probe_device() is called for every device added
> to the system, in the order in which they are added. Calling it in a
> random order or not at all dependent on driver binding leads to
> malformed groups, a potential lack of isolation for devices with no
> driver, and all manner of unexpected concurrency and race conditions.
> We've attempted to mitigate the latter with point-fix bodges like
> iommu_probe_device_lock, but it's a losing battle and the time has come
> to bite the bullet and address the true source of the problem instead.

> @@ -426,6 +438,12 @@ static int iommu_init_device(struct device *dev)
>  		ret = -ENODEV;
>  		goto err_free;
>  	}
> +	/*
> +	 * And if we do now see any replay calls, they would indicate someone
> +	 * misusing the dma_configure path outside bus code.
> +	 */
> +	if (dev->driver)
> +		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
>  
>  	if (!try_module_get(ops->owner)) {
>  		ret = -EINVAL;
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e10a68b5ffde..6b989a62def2 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -155,7 +155,12 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>  		dev_iommu_free(dev);
>  	mutex_unlock(&iommu_probe_device_lock);
>  
> -	if (!err && dev->bus)
> +	/*
> +	 * If we're not on the iommu_probe_device() path (as indicated by the
> +	 * initial dev->iommu) then try to simulate it. This should no longer
> +	 * happen unless of_dma_configure() is being misused outside bus code.
> +	 */

This assumption does not hold as there is nothing preventing iommu
driver probe from racing with a client driver probe.

> +	if (!err && dev->bus && !dev_iommu_present)
>  		err = iommu_probe_device(dev);
>  
>  	if (err && err != -EPROBE_DEFER)

I hit the (now moved) dev_WARN() on the ThinkPad T14s where the GPU SMMU
is probed late due to a clock dependency and can end up probing in
parallel with the GPU driver.

[    3.805282] arm-smmu 3da0000.iommu: probing hardware configuration...
[    3.806007] arm-smmu 3da0000.iommu: SMMUv2 with:
[    3.806843] arm-smmu 3da0000.iommu:  stage 1 translation
[    3.807562] arm-smmu 3da0000.iommu:  coherent table walk
[    3.808253] arm-smmu 3da0000.iommu:  stream matching with 24 register groups
[    3.808957] arm-smmu 3da0000.iommu:  22 context banks (0 stage-2 only)
[    3.809651] arm-smmu 3da0000.iommu:  Supported page sizes: 0x61311000
[    3.810339] arm-smmu 3da0000.iommu:  Stage-1: 48-bit VA -> 40-bit IPA
[    3.811130] arm-smmu 3da0000.iommu:  preserved 0 boot mappings

[    3.829042] platform 3d6a000.gmu: Adding to iommu group 8

[    3.992050] ------------[ cut here ]------------
[    3.993045] adreno 3d00000.gpu: late IOMMU probe at driver bind, something fishy here!
[    3.994058] WARNING: CPU: 9 PID: 343 at drivers/iommu/iommu.c:579 __iommu_probe_device+0x2b0/0x4ac

[    4.003272] CPU: 9 UID: 0 PID: 343 Comm: kworker/u50:2 Not tainted 6.15.0-rc1 #109 PREEMPT 
[    4.003276] Hardware name: LENOVO 21N2ZC5PUS/21N2ZC5PUS, BIOS N42ET83W (2.13 ) 10/04/2024

[    4.025943] Call trace:
[    4.025945]  __iommu_probe_device+0x2b0/0x4ac (P)
[    4.030453]  iommu_probe_device+0x38/0x7c
[    4.030455]  of_iommu_configure+0x188/0x26c
[    4.030457]  of_dma_configure_id+0xcc/0x300
[    4.030460]  platform_dma_configure+0x74/0xac
[    4.030462]  really_probe+0x74/0x38c
[    4.030464]  __driver_probe_device+0x7c/0x160
[    4.030465]  driver_probe_device+0x40/0x110
[    4.030467]  __device_attach_driver+0xbc/0x158
[    4.030468]  bus_for_each_drv+0x84/0xe0
[    4.030470]  __device_attach+0xa8/0x1d4
[    4.030472]  device_initial_probe+0x14/0x20
[    4.030473]  bus_probe_device+0xb0/0xb4
[    4.030476]  deferred_probe_work_func+0xa0/0xf4

[    4.030501] ---[ end trace 0000000000000000 ]---
[    4.031269] adreno 3d00000.gpu: Adding to iommu group 9

Johan

