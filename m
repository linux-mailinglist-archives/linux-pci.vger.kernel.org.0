Return-Path: <linux-pci+bounces-32189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681C3B067B5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 22:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3425646B4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 20:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A7E2727E5;
	Tue, 15 Jul 2025 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/z7rxYX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B717BA1;
	Tue, 15 Jul 2025 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752611316; cv=none; b=eYgrcCSsiI2K42IeEvDOmXpnkfsN9uL7dWjxLcnGjtzGXSYtvFBDF9OH2jlHuXMcCz/WSQzt4tUePRJTZkDed4y7Wq1d1vQk8d541cDCZcuYCuPUX5me63Z/GzlGYx3lDpSwuC6rvM10puongyPWhn9ej0WdGVtxZyERPIm6XDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752611316; c=relaxed/simple;
	bh=wfJw4ZawJHcyOeoZQw3I2gM6CAlT+SrszZtN/nJhL+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NdLyVbAMKZySjvXONx+etD7jWnp0HR52Vv22Cj8DpzN1/D9eadteTay0rJRIatx7LcgbNRoQRl39LiobJ4HdzcPZJGjHZb0gyGREu0gIoqqR/yD67UnYGpq9hmFEgvRPF/b5Q4E6dBXZhQoZuFNoFwag9fYqEalQEXhLMhu7rVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/z7rxYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3DCC4CEE3;
	Tue, 15 Jul 2025 20:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752611316;
	bh=wfJw4ZawJHcyOeoZQw3I2gM6CAlT+SrszZtN/nJhL+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=d/z7rxYXVHulxt/xJx7HKX+5wtc9sE4aJmGooG+0QkVhjlS/Z4Iy6xnWUnpngjBkw
	 qXlryX38/mt39VC8HUOu30Bo2sjRPilczXGGHYFqC2Df328tdocdH0N7WCaWfSIEV2
	 rA4R3C3W9+Vvm/oUi2m7Ttng3nM/w8Ss4r+5LUGivwW2Rr2qpyGKz+dtriv1bl7YIt
	 35g46DlMmD5ydvnKxaVGJ85KtdP/MOXeM6QWtzzBxdEi0dt3BZ/tLiHRWdRfJygib/
	 SsnKgbY8rvjiKwPt7mA0Z9v7ZbUA4pgWCjpa3orwoj8eaDtDiS36Kp4MrTzhe4rJwy
	 e0DscbUsAzS8A==
Date: Tue, 15 Jul 2025 15:28:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH] PCI: Fix driver_managed_dma check
Message-ID: <20250715202834.GA2498403@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425133929.646493-4-robin.murphy@arm.com>

On Fri, Apr 25, 2025 at 02:39:29PM +0100, Robin Murphy wrote:
> Since it's not currently safe to take device_lock() in the IOMMU probe
> path, that can race against really_probe() setting dev->driver before
> attempting to bind. The race itself isn't so bad, since we're only
> concerned with dereferencing dev->driver itself anyway, but sadly my
> attempt to implement the check with minimal churn leads to a kind of
> TOCTOU issue, where dev->driver becomes valid after to_pci_driver(NULL)
> is already computed, and thus the check fails to work as intended.
> 
> Will and I both hit this with the platform bus, but the pattern here is
> the same, so fix it for correctness too.
> 
> Reported-by: Will McVicker <willmcvicker@google.com>
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied to pci/iommu for v6.17, thanks!

> ---
>  drivers/pci/pci-driver.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index c8bd71a739f7..66e3bea7dc1a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1634,7 +1634,7 @@ static int pci_bus_num_vf(struct device *dev)
>   */
>  static int pci_dma_configure(struct device *dev)
>  {
> -	struct pci_driver *driver = to_pci_driver(dev->driver);
> +	const struct device_driver *drv = READ_ONCE(dev->driver);
>  	struct device *bridge;
>  	int ret = 0;
>  
> @@ -1651,8 +1651,8 @@ static int pci_dma_configure(struct device *dev)
>  
>  	pci_put_host_bridge_device(bridge);
>  
> -	/* @driver may not be valid when we're called from the IOMMU layer */
> -	if (!ret && dev->driver && !driver->driver_managed_dma) {
> +	/* @drv may not be valid when we're called from the IOMMU layer */
> +	if (!ret && drv && !to_pci_driver(drv)->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

