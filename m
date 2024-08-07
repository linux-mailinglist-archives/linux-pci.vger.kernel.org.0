Return-Path: <linux-pci+bounces-11413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB47494A186
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 09:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FFE1B261EE
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 07:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAD61BCA1B;
	Wed,  7 Aug 2024 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cd15pnnN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61D918D63E;
	Wed,  7 Aug 2024 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015066; cv=none; b=WJdqFD8iyYQ2XsQU5Orf732GVphpfO6pSQGl1ZnLPfH48U2YQwYlAwSfgtRIJ9vMgb5yCUKtt+9iOocQDx1A/BxnvZ/Ppk5ATnF47SdkMuv/1d1ZOlRxdKiTZeMpd7XwUIqU33ByIpY0pklwczRpVq+M3Nr+osTUP51qxFjKh3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015066; c=relaxed/simple;
	bh=3HxEnjuuxJlgWdQWpmdem/Kx1JzZgsb9IufSXWYF1aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8ZCh35SrJGi5WT+RsD1YawHavan3MYbK1JTRd+5zvyUeA1QklQlWlGjTRrjc7p5/sHgAXS3+rCXs1QQEFr2hmvTjyQCTqQ3d850+Wx4bCr8hrPyejI/TQ+k9527G3n69NnyjUZjji4e+wXbDSJDPHR8VHIiqCSQvY2efzF1/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cd15pnnN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723015065; x=1754551065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3HxEnjuuxJlgWdQWpmdem/Kx1JzZgsb9IufSXWYF1aM=;
  b=Cd15pnnNfak7evzEqmhAA0HyOcTn4tGdXNWiGvd4Sv0huACU1ucitfPN
   DyZVa74rj38/dn2YYHb0Qv74oyq83+kE0JfX40nzWMTPaBT/lPz/ttyBd
   TmQCg0FOpXAr3Dt0bkLo5AzLBHXxQnBQ/8IUHT2aWM2s2DaXALNF+vrjz
   Z+xGAoiihM2ZnmwpvBvXxDgGZvm79BhZIm0k6Fglv3wYnXuJC0W2x1lrM
   kWu8SpRtCBE098NhAkLahuJ70DaA9GiNqtxIt2bFRh9oEJosJ8rX0l8yK
   wm610E9vbz01TzPgT1uw0qyI6ABh6P4w0WIC5AMZ0Ud7N5XGaW7Rkf1kQ
   Q==;
X-CSE-ConnectionGUID: udSDFrbeRgyVut1q17agwA==
X-CSE-MsgGUID: xIOHuzm6TNGWbRTLLmDMsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="20883967"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="20883967"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 00:17:45 -0700
X-CSE-ConnectionGUID: JQnDajitQsmXX4KgO3FUgA==
X-CSE-MsgGUID: 4vKdqPQ6QiWAXSlObv+9Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="61586372"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 07 Aug 2024 00:17:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 23FA8195; Wed, 07 Aug 2024 10:17:40 +0300 (EEST)
Date: Wed, 7 Aug 2024 10:17:40 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] PCI: Detect and trust built-in TBT chips
Message-ID: <20240807071740.GF1532424@black.fi.intel.com>
References: <20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org>

Hi Esther,

I think it is good to include IOMMU folks too, iommu@lists.linux.dev. I
Cc'd them now but for the next iteration please add them. Also added
Mario from AMD as this affects them too.

In the $subject, use "Thunderbolt" instead of TBT.

On Tue, Aug 06, 2024 at 09:39:11PM +0000, Esther Shimanovich wrote:
> Some computers with CPUs that lack Thunderbolt features use discrete
> Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
> chips are located within the chassis; between the root port labeled
> ExternalFacingPort and the USB-C port.
> 
> These Thunderbolt PCIe devices should be labeled as fixed and trusted,
> as they are built into the computer. Otherwise, security policies that
> rely on those flags may have unintended results, such as preventing
> USB-C ports from enumerating.

I suggest opening the heuristic here a bit more. And add the links to
the Microsoft firmware document somewhere. These:

https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports

Other than this the patch looks good to me.

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
>  drivers/pci/probe.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 142 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b14b9876c030..30de2f6da164 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1629,16 +1629,147 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
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
> +	/*
> +	 * If the device has a PCIe type, that means it is part of a PCIe
> +	 * switch.
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
> +	 * For USB4 the tunneled PCIe root or downstream ports are marked
> +	 * with the "usb4-host-interface" property, so we look for that
> +	 * first. This should cover the most cases.
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
> +	 * before Alder Lake do not have the above device property so we
> +	 * use their PCI IDs instead. All these are tunneled. This list
> +	 * is not expected to grow.
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
>  }
>  
> @@ -1646,8 +1777,10 @@ static void pci_set_removable(struct pci_dev *dev)
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
> @@ -1657,8 +1790,10 @@ static void pci_set_removable(struct pci_dev *dev)
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

