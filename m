Return-Path: <linux-pci+bounces-11396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F8A949AED
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 00:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E4B1C21331
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A7C17BB11;
	Tue,  6 Aug 2024 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6gAuVTw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B39917839E;
	Tue,  6 Aug 2024 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981848; cv=none; b=buasxZPEK6Koyy+VoqhtBadrUmWe0UCm8lJqMDtf2ja+xuEk8HpoSq5lGlmKWkXAexvhFzybi7a8tHGEAYzoD8JZ/guVceq2YCBOBfbZkRO/E9tEq5+n6iWy0Qu+JM1rDkIqRp+VJUSk7hTo+s2eJELFPybKTqa4Wbiqk8sB0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981848; c=relaxed/simple;
	bh=obPTo/kSA5CicZ+iGNDwRPbntktGZz+xY2ZRyCcB2lc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MmISmOFOOvQOBSRESQBL/dJu1JP3mNvMHp0o11gbTzhvYc7HXM2A9NauEBWcwvo4h+YWbbb5TS0jLi5/98stUu01spCsTl4gqU6Np3gFEWdFb0k3SokhRUynezbdFCwuAycSRuKU1GWipzHDGhhhGmrq0FACvATTI5h3WM/jw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6gAuVTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D071AC32786;
	Tue,  6 Aug 2024 22:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722981848;
	bh=obPTo/kSA5CicZ+iGNDwRPbntktGZz+xY2ZRyCcB2lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=K6gAuVTwA2JVNIatbPuMA71/jJL/NY00pNnZ//00cbMCcMNgl2FQcWKsK+YFbBhg/
	 VAZSErNlm6iuqTLiO5FLQ+Cub431WLeLbPm6KiajWEtEuV+sMG0RtBMabvLFahTlJt
	 B9db1/0US3Z4FHp+AGv5UCVwUvtgKzjw34Zz65fM7v4lY/bk2LJ3A+BDo5iAoAryjd
	 ean/jieGxd705gsY1Y+7D699tL3WmFE5d4LnKpHagFUYQ/vBnU8KqK3cuxiylJX3rK
	 O3UONiEfJKF+8G0Xo4tn2AlX90nidXlrhfyTH40wU2coELs/s4sAQi5vPBtdLbW2it
	 dUEKq6UODzRMQ==
Date: Tue, 6 Aug 2024 17:04:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Detect and trust built-in TBT chips
Message-ID: <20240806220406.GA80520@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org>

On Tue, Aug 06, 2024 at 09:39:11PM +0000, Esther Shimanovich wrote:
> Some computers with CPUs that lack Thunderbolt features use discrete
> Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
> chips are located within the chassis; between the root port labeled
> ExternalFacingPort and the USB-C port.

So is this fundamentally a firmware defect?  ACPI says a Root Port is
an "ExternalFacingPort", but the Root Port is actually connected to an
internal Thunderbolt chip, not an external connector?

> These Thunderbolt PCIe devices should be labeled as fixed and trusted,
> as they are built into the computer. Otherwise, security policies that
> rely on those flags may have unintended results, such as preventing
> USB-C ports from enumerating.
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

Add blank line here.

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

This case is not part of a PCIe switch, so the comment above isn't
quite right.

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

What is the source of this property?  ACPI?  DT?  Is there some spec
we can cite that defines it?

s/cover the most/cover most/

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

Is the "usb4-host-interface" property built into the hardware somehow?
Or is this a statement about the firmware we expect to see with the
parts listed below?

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

I need more context to be convinced that this is a reliable heuristic.
What keeps somebody from plugging a discrete Thunderbolt/USB4
controller into an external port?  Maybe this just needs a sentence or
two from Lukas's (?) helpful intro to tunneling?

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
> 

