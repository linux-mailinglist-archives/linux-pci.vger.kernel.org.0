Return-Path: <linux-pci+bounces-21496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 878B0A36496
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23B3188E733
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7738F268687;
	Fri, 14 Feb 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHn1ZR4o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A943267F4A;
	Fri, 14 Feb 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554194; cv=none; b=F49i2autRiC/Nl1fu6AqrvFzWu4VbhA6WPAg0KwIqNx3KV3E7Ak3SUGJrxaECRiMndLtuU/I+l3wXG8WR8gIlKHHEkzcRcRj1salSyrvrfpztk1OmyXGCX3FzzCa2otbGIYRR1AzalG12jpbKSALSaoSjDOywdvwRlKik9eJz94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554194; c=relaxed/simple;
	bh=ugNKYKj3EZ9GfwxKpe8rqlpyyI0FbYTnmeF24bNSsC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VzvbAP0r6TUBpAtTjxdh3KilSoDDS/yMuKj+ulx1JpP7+ySEk4wdQxLaeny5RAsWMQg6JF5CcaFm056oYHrcFzq1rMPPDrrzPg4i/xyhnCLuWuUGFDfq6rzkZZAgIFFw3S7ZrwDmis5XhKuiQJaSOKuhI6TBVyPuUL4IsTQKfUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHn1ZR4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F4DC4CED1;
	Fri, 14 Feb 2025 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739554194;
	bh=ugNKYKj3EZ9GfwxKpe8rqlpyyI0FbYTnmeF24bNSsC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BHn1ZR4oDyGQrRhyQOKoDk5BDD6j7oC9n0AqMB67Ou3R27KQMyO82eOBcxEVq0LBX
	 zngRtBBvJXrIyiIUYul0MYnxpNx5/N9ZeK7utJ2XeuSArGKTNGOSs8qxF4Gjcf6gDY
	 JPziCAXWn2i9OZ5fF/yJycan4zyhOp1fcNPRTs5wYt5aGXJZeiDrcpuNlTiKi30KOc
	 Pu+mqKCAEdhYoI/xbYjUSipafB5GjhYJHxI/iXP7ZPyULzN/nDkmuwQa0jeCG5L8KT
	 /x+DB9YPGJai5z8dPJlQfWX0fGfO+nYgrSm7Phi2mMZ/mdvDQe7YvbgB2CKH5yKaCf
	 0Vct+rUX4WiXg==
Date: Fri, 14 Feb 2025 11:29:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH 2/2] iommu: Get DT/ACPI parsing into the proper probe path
Message-ID: <20250214172951.GA158443@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2f0ae276fd5a18e1653bae8bb0c51670e35b283.1739486121.git.robin.murphy@arm.com>

On Thu, Feb 13, 2025 at 11:49:00PM +0000, Robin Murphy wrote:
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
> 
> The crux of the matter is that the firmware parsing actually serves two
> distinct purposes; one is identifying the IOMMU instance associated with
> a device so we can check its availability, the second is actually
> telling that instance about the relevant firmware-provided data for the
> device. However the latter also depends on the former, and at the time
> there was no good place to defer and retry that separately from the
> availability check we also wanted for client driver probe.
> 
> Nowadays, though, we have a proper notion of multiple IOMMU instances in
> the core API itself, and each one gets a chance to probe its own devices
> upon registration, so we can finally make that work as intended for
> DT/IORT/VIOT platforms too. All we need is for iommu_probe_device() to
> be able to run the iommu_fwspec machinery currently buried deep in the
> wrong end of {of,acpi}_dma_configure(). Luckily it turns out to be
> surprisingly straightforward to bootstrap this transformation by pretty
> much just calling the same path twice. At client driver probe time,
> dev->driver is obviously set; conversely at device_add(), or a
> subsequent bus_iommu_probe(), any device waiting for an IOMMU really
> should *not* have a driver already, so we can use that as a condition to
> disambiguate the two cases, and avoid recursing back into the IOMMU core
> at the wrong times.
> 
> Obviously this isn't the nicest thing, but for now it gives us a
> functional baseline to then unpick the layers in between without many
> more awkward cross-subsystem patches. There are some minor side-effects
> like dma_range_map potentially being created earlier, and some debug
> prints being repeated, but these aren't significantly detrimental. Let's
> make things work first, then deal with making them nice.
> 
> With the basic flow finally in the right order again, the next step is
> probably turning the bus->dma_configure paths inside-out, since all we
> really need from bus code is its notion of which device and input ID(s)
> to parse the common firmware properties with...
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/arm64/dma.c        |  5 ++++
>  drivers/acpi/scan.c             | 10 +++-----
>  drivers/amba/bus.c              |  2 +-
>  drivers/base/platform.c         |  2 +-
>  drivers/bus/fsl-mc/fsl-mc-bus.c |  2 +-
>  drivers/cdx/cdx.c               |  2 +-
>  drivers/iommu/iommu.c           | 43 ++++++++++++++++++++++++---------
>  drivers/iommu/of_iommu.c        | 10 +++++++-
>  drivers/of/device.c             |  7 +++++-
>  drivers/pci/pci-driver.c        |  2 +-

Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci-driver.c

I assume this will be merged via the IOMMU tree.

>  10 files changed, 60 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
> index 52b2abf88689..f30f138352b7 100644
> --- a/drivers/acpi/arm64/dma.c
> +++ b/drivers/acpi/arm64/dma.c
> @@ -26,6 +26,11 @@ void acpi_arch_dma_setup(struct device *dev)
>  	else
>  		end = (1ULL << 32) - 1;
>  
> +	if (dev->dma_range_map) {
> +		dev_dbg(dev, "dma_range_map already set\n");
> +		return;
> +	}
> +
>  	ret = acpi_dma_get_range(dev, &map);
>  	if (!ret && map) {
>  		end = dma_range_map_max(map);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 9f4efa8f75a6..42b8f1833c3c 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1619,6 +1619,9 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>  {
>  	int err;
>  
> +	if (device_iommu_mapped(dev))
> +		return 0;
> +
>  	/* Serialise to make dev->iommu stable under our potential fwspec */
>  	mutex_lock(&iommu_probe_device_lock);
>  	/* If we already translated the fwspec there is nothing left to do */
> @@ -1632,13 +1635,6 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>  		err = viot_iommu_configure(dev);
>  	mutex_unlock(&iommu_probe_device_lock);
>  
> -	/*
> -	 * If we have reason to believe the IOMMU driver missed the initial
> -	 * iommu_probe_device() call for dev, replay it to get things in order.
> -	 */
> -	if (!err && dev->bus)
> -		err = iommu_probe_device(dev);
> -
>  	return err;
>  }
>  
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 8ef259b4d037..abbb37d4d228 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -364,7 +364,7 @@ static int amba_dma_configure(struct device *dev)
>  		ret = acpi_dma_configure(dev, attr);
>  	}
>  
> -	if (!ret && !drv->driver_managed_dma) {
> +	if (dev->driver && !ret && !drv->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 6f2a33722c52..4c7570d637f9 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1451,7 +1451,7 @@ static int platform_dma_configure(struct device *dev)
>  		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
>  		ret = acpi_dma_configure(dev, attr);
>  	}
> -	if (ret || drv->driver_managed_dma)
> +	if (!dev->driver || ret || drv->driver_managed_dma)
>  		return ret;
>  
>  	ret = iommu_device_use_default_domain(dev);
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index d1f3d327ddd1..fb58833b222a 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -153,7 +153,7 @@ static int fsl_mc_dma_configure(struct device *dev)
>  	else
>  		ret = acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
>  
> -	if (!ret && !mc_drv->driver_managed_dma) {
> +	if (dev->driver && !ret && !mc_drv->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index c573ed2ee71a..d5761b96a412 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -360,7 +360,7 @@ static int cdx_dma_configure(struct device *dev)
>  		return ret;
>  	}
>  
> -	if (!ret && !cdx_drv->driver_managed_dma) {
> +	if (dev->driver && !ret && !cdx_drv->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2486f6d6ef68..89f634d46aad 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -519,17 +519,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  	struct group_device *gdev;
>  	int ret;
>  
> -	/*
> -	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
> -	 * instances with non-NULL fwnodes, and client devices should have been
> -	 * identified with a fwspec by this point. Otherwise, we can currently
> -	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
> -	 * be present, and that any of their registered instances has suitable
> -	 * ops for probing, and thus cheekily co-opt the same mechanism.
> -	 */
> -	ops = iommu_fwspec_ops(dev_iommu_fwspec_get(dev));
> -	if (!ops)
> -		return -ENODEV;
>  	/*
>  	 * Serialise to avoid races between IOMMU drivers registering in
>  	 * parallel and/or the "replay" calls from ACPI/OF code via client
> @@ -539,9 +528,41 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  	 */
>  	lockdep_assert_held(&iommu_probe_device_lock);
>  
> +	/*
> +	 * For FDT-based systems and ACPI IORT/VIOT, the common firmware parsing
> +	 * is buried in the bus dma_configure path. Properly unpicking that is
> +	 * still a fairly big job, so for now just invoke the whole thing. Our
> +	 * bus_iommu_probe() walk may see devices with drivers already bound,
> +	 * but that must mean they're already configured - either probed by
> +	 * another IOMMU, or there was no IOMMU for iommu_fwspec_init() to wait
> +	 * for - so either way we can safely skip this and avoid worrying about
> +	 * those recursing back here thinking they need a replay call.
> +	 */
> +	if (!dev->driver && dev->bus->dma_configure) {
> +		mutex_unlock(&iommu_probe_device_lock);
> +		dev->bus->dma_configure(dev);
> +		mutex_lock(&iommu_probe_device_lock);
> +	}
> +
> +	/*
> +	 * At this point, either valid devices now have a fwspec, or we can
> +	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
> +	 * be present, and that any of their registered instances has suitable
> +	 * ops for probing, and thus cheekily co-opt the same mechanism.
> +	 */
> +	ops = iommu_fwspec_ops(dev_iommu_fwspec_get(dev));
> +	if (!ops)
> +		return -ENODEV;
> +
>  	/* Device is probed already if in a group */
>  	if (dev->iommu_group)
>  		return 0;
> +	/*
> +	 * And if we do now see any replay calls, they would indicate someone
> +	 * misusing the dma_configure path outside bus code.
> +	 */
> +	if (dev_iommu_fwspec_get(dev) && dev->driver)
> +		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
>  
>  	ret = iommu_init_device(dev, ops);
>  	if (ret)
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 97987cd78da9..c9aaf5783b77 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -121,6 +121,9 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>  	if (!master_np)
>  		return -ENODEV;
>  
> +	if (device_iommu_mapped(dev))
> +		return 0;
> +
>  	/* Serialise to make dev->iommu stable under our potential fwspec */
>  	mutex_lock(&iommu_probe_device_lock);
>  	if (dev_iommu_fwspec_get(dev)) {
> @@ -151,7 +154,12 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>  		iommu_fwspec_free(dev);
>  	mutex_unlock(&iommu_probe_device_lock);
>  
> -	if (!err && dev->bus)
> +	/*
> +	 * If we have reason to believe the IOMMU driver missed the initial
> +	 * iommu_probe_device() call for dev, try to fix it up. This should
> +	 * no longer happen unless of_dma_configure() is being misused.
> +	 */
> +	if (!err && dev->driver)
>  		err = iommu_probe_device(dev);
>  
>  	if (err && err != -EPROBE_DEFER)
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index edf3be197265..5053e5d532cc 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -99,6 +99,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>  	bool coherent, set_map = false;
>  	int ret;
>  
> +	if (dev->dma_range_map) {
> +		dev_dbg(dev, "dma_range_map already set\n");
> +		goto skip_map;
> +	}
> +
>  	if (np == dev->of_node)
>  		bus_np = __of_get_dma_parent(np);
>  	else
> @@ -119,7 +124,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>  		end = dma_range_map_max(map);
>  		set_map = true;
>  	}
> -
> +skip_map:
>  	/*
>  	 * If @dev is expected to be DMA-capable then the bus code that created
>  	 * it should have initialised its dma_mask pointer by this point. For
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f57ea36d125d..143b2f2081ea 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1653,7 +1653,7 @@ static int pci_dma_configure(struct device *dev)
>  
>  	pci_put_host_bridge_device(bridge);
>  
> -	if (!ret && !driver->driver_managed_dma) {
> +	if (dev->driver && !ret && !driver->driver_managed_dma) {
>  		ret = iommu_device_use_default_domain(dev);
>  		if (ret)
>  			arch_teardown_dma_ops(dev);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

