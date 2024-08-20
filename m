Return-Path: <linux-pci+bounces-11899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC64958C0A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 18:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D90284660
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 16:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC53A8F0;
	Tue, 20 Aug 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIhiBCTQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2D1B86E3;
	Tue, 20 Aug 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170545; cv=none; b=k6GWlhVuKw4U7flbOncZt18MPPp3byOSJAlPbME2RrVQUua92dvZlsKiiB+qFpnE7OryeRf1lC3PlI1LqM81HkJferPB9r+os9GZI1kEeXyk6FMw8mBkJM5oSN09h3KGeF1PprjZoDGGsNSKvLFeL54+8dXq+Zgr3AnB5gieff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170545; c=relaxed/simple;
	bh=VPOpWT+bAqv0FsPUqqDpxjM34TFjksmf3pyQA+6hdBs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LBspZpJqb/syU+3pCJaJFPqKowLUHF9Foi/+5SPn95sPXeowUOzDnDgrek6biZkt3xFCxoL6eQERvXw7jyxx+CmCvXbZYS6uFFxNDEhfB/oU3Ont/jJAgM0uYQaMJKNKw+cROS367CbGH77DqQ9s/eb00xKDKOHc4xlCIGo7b1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIhiBCTQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724170543; x=1755706543;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VPOpWT+bAqv0FsPUqqDpxjM34TFjksmf3pyQA+6hdBs=;
  b=iIhiBCTQeijBVoMzIgiKEwCQ6cPrjDxw/6qvxqLQLCbWVUGGDwyOz/4Z
   g0BfobRPDJRNgAaihd8P9Eb90Gjv9Hlu5Le7qzL7YUV0oAI1OFc4eYf+D
   BOoYm8Z7ThlSBY9b9ivllcunLaonX5jtskh+BJktbRWadqW/LH8wubm8T
   UE4WyIk4kPINocCxqgt0mz/Mgl6nj5Fr++Hk28kWDDVTpHFgZ76EWOvm/
   JyUxZzoxyKp0lEj8IMU8jXvUMGGa5vT5SU5WsMTvrS+OwPO/owGk8x5JC
   b5FiLCuM4jKnWnKNxEXD3PF0k0LYriGRNrFMY2LrLknvUDwsUAkiUXRHL
   Q==;
X-CSE-ConnectionGUID: UYUB/7IbQNquFyL7FIymYg==
X-CSE-MsgGUID: KqCmo3/JTb+Zgiuvr+QZxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33052919"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="33052919"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 09:14:02 -0700
X-CSE-ConnectionGUID: gSfXkD3HQquJFvx+j3ebXg==
X-CSE-MsgGUID: haPKNuHmTZ26blMLPKGZ5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60428954"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.102])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 09:13:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 Aug 2024 19:13:56 +0300 (EEST)
To: Esther Shimanovich <eshimanovich@chromium.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, iommu@lists.linux.dev, 
    Lukas Wunner <lukas@wunner.de>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: Detect and trust built-in Thunderbolt chips
In-Reply-To: <20240815-trust-tbt-fix-v3-1-6ba01865d54c@chromium.org>
Message-ID: <2af37d5d-ec82-d4fb-9ee5-5a3e47790122@linux.intel.com>
References: <20240815-trust-tbt-fix-v3-1-6ba01865d54c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 Aug 2024, Esther Shimanovich wrote:

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
> 
> The ExternalFacingPort ACPI property is described here:
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> 
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
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
> https://lore.kernel.org/lkml/20240510052616.GC4162345@black.fi.intel.com
> I refactored it and am submitting as a new patch.
> ---
> Changes in v3:
> - Incorporated minor edits suggested by Mika Westerberg.
> - Mika Westerberg tested patch (more details in v2 link)
> - Added "reviewed-by" and "tested-by" lines
> - Link to v2: https://lore.kernel.org/r/20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org
> 
> Changes in v2:
> - I clarified some comments, and made minor fixins
> - I also added a more detailed description of implementation into the
>   commit message
> - Added Cc recipients Mike recommended
> - Link to v1: https://lore.kernel.org/r/20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org
> ---
>  drivers/pci/probe.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 146 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b14b9876c030..308d5a0e5c51 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1629,25 +1629,160 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
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

Missing space.

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

return parent == bridge; ?

> +		break;
> +
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {

It would be slightly easier to follow the logic if code uses reverse logic
and returns false immediately when the decision is known. (Will also help 
the indentation levels especially in the last case block).

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

Missing space.

> +	if (!parent)
> +		return false;
> +
> +	root = pcie_find_root_port(pdev);
> +	/* If pdev doesn't have a root, then there's no way it is tunneled.*/

Missing space.

Though instead of near identical repeat, I'd combine those two comments 
into something along the lines of:

/* pdev without a parent or Root Port is never tunneled. */

-- 
 i.

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
> +	 * "ExternalFacingPort". Those are not behind a PCIe tunnel.
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
>  		dev->untrusted = true;
> +
> +	if (pcie_is_tunneled(dev)) {
> +		pci_dbg(dev, "marking as untrusted\n");
> +		dev->untrusted = true;
> +	}
>  }
>  
>  static void pci_set_removable(struct pci_dev *dev)
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
> @@ -1657,9 +1792,13 @@ static void pci_set_removable(struct pci_dev *dev)
>  	 * accessible to user / may not be removed by end user, and thus not
>  	 * exposed as "removable" to userspace.
>  	 */
> -	if (parent &&
> -	    (parent->external_facing || dev_is_removable(&parent->dev)))
> +	if (dev_is_removable(&parent->dev))
> +		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +
> +	if (pcie_is_tunneled(dev)) {
> +		pci_dbg(dev, "marking as removable\n");
>  		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +	}
>  }
>  
>  /**
> 
> ---
> base-commit: 3f386cb8ee9f04ff4be164ca7a1d0ef3f81f7374
> change-id: 20240806-trust-tbt-fix-5f337fd9ec8a
> 
> Best regards,
> 


