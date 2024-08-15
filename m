Return-Path: <linux-pci+bounces-11691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E7A952C65
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 12:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3EF1C20AEB
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB77419DFB6;
	Thu, 15 Aug 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8ZqxBwN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088A19D8B5;
	Thu, 15 Aug 2024 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715974; cv=none; b=EG6LtjXoWQ6yBfQbICTs4E8M9AW/LOZ+Ilhym8ai3o0C3GOaWkSVvsXWqexF7lBQRmQ1HgVxe7d8JWZCCT5SLY3WERPQyE9qL2elP5N4gwfIy9QOQmjw4F1VRXc9VW7DbZJd8kEIzhKQAtqjrDLXa1h3U9TyfYBaAsQezPsjfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715974; c=relaxed/simple;
	bh=kR7uFMzTAJftsV7EYZDT5fFJOneOJeUgTv4KZf2z4go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpcfLaJ0SCZoRNLdIW2LSSW9sqILTYbQ9ZQF/ykKVipWiuXAf+53A2UQ6LeQJ/+U+xH/1tQZ/xZOGXTdgzLZD0dSF+HptRv9KJlaJHFRy2d5GXU3Gc6gO+9FeOm2OeArw5XzqgPXvzsGdqslU9PbJIqKKTInzIQ+LDBs8RAk43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8ZqxBwN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723715972; x=1755251972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kR7uFMzTAJftsV7EYZDT5fFJOneOJeUgTv4KZf2z4go=;
  b=g8ZqxBwNQWvEEsbFWv6Ve+4M7q8np6rrapX70gRUVu6zAK0X1CIcFugU
   Jpq4LJjWzyc47jMopq27LD/k6XvIKOtpC8UZxzkUDPbyQt5/YAhNcPf2J
   4DqCFiIuQxTET4KYn1SHy9rkS7f+CVKamj6tgG31TidZ8wi0W48BnuF9q
   WyHALPUOsQmDrwmYxgFtzAD6N7LUL2XpTf2CY36pQloM2C592k7unMSf6
   OzLkOS2JjioTeRZCTkoih24VW6BoaUrw+7/mnbMs6YP/vcMqTMMYNrCbq
   /eRwk311s68EmyIYBSRz4/GuqWtTH1tWSR6oJ2yEa5O5MdcvBnyRZc7pO
   g==;
X-CSE-ConnectionGUID: g+zWGZMXTJaznzV9yG6Vnw==
X-CSE-MsgGUID: ShortkHDR7OEHlmJgRppgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="24869076"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="24869076"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 02:59:31 -0700
X-CSE-ConnectionGUID: OjrbtLP3SvSgra1xuNJEGQ==
X-CSE-MsgGUID: SFLO8QrWS7aAIcYrBGpnvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="60063263"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 15 Aug 2024 02:59:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 51EAE2AA; Thu, 15 Aug 2024 12:59:28 +0300 (EEST)
Date: Thu, 15 Aug 2024 12:59:28 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <20240815095928.GE1532424@black.fi.intel.com>
References: <20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org>

Hi Esther,

On Thu, Aug 08, 2024 at 05:02:16PM +0000, Esther Shimanovich wrote:
> Some computers with CPUs that lack Thunderbolt features use discrete
> Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
> chips are located within the chassis; between the root port labeled
> ExternalFacingPort and the USB-C port.
> 
> These Thunderbolt PCIe devices should be labeled as fixed and trusted,
> as they are built into the computer. Otherwise, security policies that
> rely on those flags may have unintended results, such as preventing
> USB-C ports from enumerating.
> 
> Detect the above scenario through the process of elimination.
> 
> 1) Integrated Thunderbolt host controllers already have Thunderbolt
>    implemented, so anything outside their external facing root port is
>    removable and untrusted.
> 
>    Detect them using the following properties:
> 
>      - Most integrated host controllers have the usb4-host-interface
>        ACPI property, as described here:
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> 
>      - Integrated Thunderbolt PCIe root ports before Alder Lake do not
>        have the usb4-host-interface ACPI property. Identify those with
>        their PCI IDs instead.
> 
> 2) If a root port does not have integrated Thunderbolt capabilities, but
>    has the ExternalFacingPort ACPI property, that means the manufacturer
>    has opted to use a discrete Thunderbolt host controller that is
>    built into the computer.
> 
>    This host controller can be identified by virtue of being located
>    directly below an external-facing root port that lacks integrated
>    Thunderbolt. Label it as trusted and fixed.
> 
>    Everything downstream from it is untrusted and removable.

I now managed to test this on my test systems:

  - Intel Alder Lake-S with Maple Ridge discrete controller
  - Intel Raptor Lake-Hx with Barlow Ridge discrete controller
  - Intel Meteor Lake-P with integrated controller

I connected various devices and the "untrusted" is always set properly.
For example here is from the Alder Lake-S system. The related PCIe
devices are:

  0000:00:1d.0 PCI bridge: Intel Corporation Alder Lake-S PCH PCI Express Root Port #9 (rev 11)
  0000:02:00.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Maple Ridge 4C 2020] (rev 02)
  0000:03:00.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Maple Ridge 4C 2020] (rev 02)
  0000:03:01.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Maple Ridge 4C 2020] (rev 02)
  0000:03:02.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Maple Ridge 4C 2020] (rev 02)
  0000:03:03.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Maple Ridge 4C 2020] (rev 02)
  0000:04:00.0 USB controller: Intel Corporation Thunderbolt 4 NHI [Maple Ridge 4C 2020]
  0000:05:00.0 PCI bridge: Intel Corporation JHL6340 Thunderbolt 3 Bridge (C step) [Alpine Ridge 2C 2016] (rev 02)
  0000:06:01.0 PCI bridge: Intel Corporation JHL6340 Thunderbolt 3 Bridge (C step) [Alpine Ridge 2C 2016] (rev 02)
  0000:07:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
  0000:38:00.0 USB controller: Intel Corporation Thunderbolt 4 USB Controller [Maple Ridge 4C 2020]

To check what IOMMU mappings the Maple Ridge controller add-in-card (connected to a
PCIe slot) gets I run:

  # cat /sys/bus/pci/devices/0000:03:01.0/iommu_group/type
  identity
  # cat /sys/bus/pci/devices/0000:03:03.0/iommu_group/type
  identity
  # cat /sys/bus/pci/devices/0000:04:00.0/iommu_group/type
  identity
  # cat /sys/bus/pci/devices/0000:38:00.0/iommu_group/type
  identity

So this is as expected. This is "trusted" so it gets identity mappings.
There is Thunderbolt 3 NVMe (JHL6340) connected to 03:01 downstream port
over PCIe tunnel so checking that too:

  # cat /sys/bus/pci/devices/0000:05:00.0/iommu_group/type 
  DMA
  # cat /sys/bus/pci/devices/0000:06:01.0/iommu_group/type
  DMA
  # cat /sys/bus/pci/devices/0000:07:00.0/iommu_group/type
  DMA

That's full IOMMU mappings as expected. Same thing with the other
systems I tested with.

Feel free to add my,

  Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Few minor comments, once addressed you can add also

  Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> The ExternalFacingPort ACPI property is described here:
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> 
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
> ---
> While working with devices that have discrete Thunderbolt chips, I
> noticed that their internal TBT chips are inaccurately labeled as
> untrusted and removable.
> 
> I've observed that this issue impacts all computers with internal,
> discrete Intel JHL Thunderbolt chips, such as JHL6240, JHL6340, JHL6540,
> and JHL7540, across multiple device manufacturers such as Lenovo, Dell,
> and HP.
> 
> This affects the execution of any downstream security policy that
> relies on the "untrusted" or "removable" flags.
> 
> I initially submitted a quirk to resolve this, which was too small in
> scope, and after some discussion, Mika proposed a more thorough fix:
> https://lore.kernel.org/lkml/20240510052616.GC4162345@black.fi.intel.com/#r
> I refactored it and am submitting as a new patch.
> ---
> Changes in v2:
> - I clarified some comments, and made minor fixins
> - I also added a more detailed description of implementation into the
>   commit message
> - Added Cc recipients Mike recommended
> - Link to v1: https://lore.kernel.org/r/20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org
> ---
>  drivers/pci/probe.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 144 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b14b9876c030..8a98c4ef5511 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1629,16 +1629,149 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  		dev->is_thunderbolt = 1;
>  }
>  
> +/*
> + * Checks if pdev is part of a PCIe switch that is directly below the
> + * specified bridge.
> + */
> +static bool pcie_switch_directly_under(struct pci_dev *bridge,
> +				       struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent = pci_upstream_bridge(pdev);
> +
> +	/* If the device doesn't have a parent, it's not under anything.*/
> +	if (!parent)
> +		return false;
> +
> +	/*
> +	 * If the device has a PCIe type, check if it is below the
> +	 * corresponding PCIe switch components (if applicable). Then check
> +	 * if its upstream port is directly beneath the specified bridge.
> +	 */
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_UPSTREAM:
> +		if (parent == bridge)
> +			return true;
> +		break;
> +
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
> +			parent = pci_upstream_bridge(parent);
> +			if (parent == bridge)
> +				return true;
> +		}
> +		break;
> +
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		if (pci_pcie_type(parent) == PCI_EXP_TYPE_DOWNSTREAM) {
> +			parent = pci_upstream_bridge(parent);
> +			if (parent && pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
> +				parent = pci_upstream_bridge(parent);
> +				if (parent == bridge)
> +					return true;
> +			}
> +		}
> +		break;
> +	}
> +
> +	return false;
> +}
> +
> +static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
> +{
> +	struct fwnode_handle *fwnode;
> +
> +	/*
> +	 * For USB4, the tunneled PCIe root or downstream ports are marked
> +	 * with the "usb4-host-interface" ACPI property, so we look for
> +	 * that first. This should cover most cases.
> +	 */
> +	fwnode = fwnode_find_reference(dev_fwnode(&pdev->dev),
> +				       "usb4-host-interface", 0);
> +	if (!IS_ERR(fwnode)) {
> +		fwnode_handle_put(fwnode);
> +		return true;
> +	}
> +
> +	/*
> +	 * Any integrated Thunderbolt 3/4 PCIe root ports from Intel
> +	 * before Alder Lake do not have the "usb4-host-interface"
> +	 * property so we use their PCI IDs instead. All these are
> +	 * tunneled. This list is not expected to grow.
> +	 */
> +	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> +		switch (pdev->device) {
> +		/* Ice Lake Thunderbolt 3 PCIe Root Ports */
> +		case 0x8a1d:
> +		case 0x8a1f:
> +		case 0x8a21:
> +		case 0x8a23:
> +		/* Tiger Lake-LP Thunderbolt 4 PCIe Root Ports */
> +		case 0x9a23:
> +		case 0x9a25:
> +		case 0x9a27:
> +		case 0x9a29:
> +		/* Tiger Lake-H Thunderbolt 4 PCIe Root Ports */
> +		case 0x9a2b:
> +		case 0x9a2d:
> +		case 0x9a2f:
> +		case 0x9a31:
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static bool pcie_is_tunneled(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent, *root;
> +
> +	parent = pci_upstream_bridge(pdev);
> +	/* If pdev doesn't have a parent, then there's no way it is tunneled.*/
> +	if (!parent)
> +		return false;
> +
> +	root = pcie_find_root_port(pdev);
> +	/* If pdev doesn't have a root, then there's no way it is tunneled.*/
> +	if (!root)
> +		return false;
> +
> +	/* Internal PCIe devices are not tunneled. */
> +	if (!root->external_facing)
> +		return false;
> +
> +	/* Anything directly behind a "usb4-host-interface" is tunneled. */
> +	if (pcie_has_usb4_host_interface(parent))
> +		return true;
> +
> +	/*
> +	 * Check if this is a discrete Thunderbolt/USB4 controller that is
> +	 * directly behind the non-USB4 PCIe Root Port marked as
> +	 * "ExternalFacingPort". These PCIe devices are used to add Thunderbolt
> +	 * capabilities to CPUs that lack integrated Thunderbolt.

I would drop the "Theese PCIe devices are used to add .." that part is
pretty obvious.

> +	 * These are not behind a PCIe tunnel.
> +	 */
> +	if (pcie_switch_directly_under(root, pdev))
> +		return false;
> +
> +	/* PCIe devices after the discrete chip are tunneled. */
> +	return true;
> +}
> +
>  static void set_pcie_untrusted(struct pci_dev *dev)
>  {
> -	struct pci_dev *parent;
> +	struct pci_dev *parent = pci_upstream_bridge(dev);
>  
> +	if (!parent)
> +		return;
>  	/*
> -	 * If the upstream bridge is untrusted we treat this device
> +	 * If the upstream bridge is untrusted we treat this device as
>  	 * untrusted as well.
>  	 */
> -	parent = pci_upstream_bridge(dev);
> -	if (parent && (parent->untrusted || parent->external_facing))
> +	if (parent->untrusted)
> +		dev->untrusted = true;
> +
> +	if (pcie_is_tunneled(dev))
>  		dev->untrusted = true;

I would add here debug log that the device is marked as "untrusted"
similarly as was done in my hack patch. This makes it easier to debug
possible issues later on.

>  }
>  
> @@ -1646,8 +1779,10 @@ static void pci_set_removable(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent = pci_upstream_bridge(dev);
>  
> +	if (!parent)
> +		return;
>  	/*
> -	 * We (only) consider everything downstream from an external_facing
> +	 * We (only) consider everything tunneled below an external_facing
>  	 * device to be removable by the user. We're mainly concerned with
>  	 * consumer platforms with user accessible thunderbolt ports that are
>  	 * vulnerable to DMA attacks, and we expect those ports to be marked by
> @@ -1657,8 +1792,10 @@ static void pci_set_removable(struct pci_dev *dev)
>  	 * accessible to user / may not be removed by end user, and thus not
>  	 * exposed as "removable" to userspace.
>  	 */
> -	if (parent &&
> -	    (parent->external_facing || dev_is_removable(&parent->dev)))
> +	if (dev_is_removable(&parent->dev))
> +		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +
> +	if (pcie_is_tunneled(dev))
>  		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);

Ditto here.

>  }
>  
> 
> ---
> base-commit: 3f386cb8ee9f04ff4be164ca7a1d0ef3f81f7374
> change-id: 20240806-trust-tbt-fix-5f337fd9ec8a
> 
> Best regards,
> -- 
> Esther Shimanovich <eshimanovich@chromium.org>

