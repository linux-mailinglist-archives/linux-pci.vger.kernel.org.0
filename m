Return-Path: <linux-pci+bounces-3878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B0585FEAE
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 18:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B84528811F
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FB2154437;
	Thu, 22 Feb 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMv3dQYD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C715099F;
	Thu, 22 Feb 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621604; cv=none; b=kswNrQDrVARku7F8IK9dDiqbiristj14HmZihWpgrYn4PcO5FoM2fYxg8qihpzYw6mLFV9PafF+jUoEbyQGxsItbg1j95tilD3brUBiYLfHq1r6EHwwXW98v1gSvmX41N5lcTi4krVo3vrt7CQBgDq+IZ1CwmQV2K378igfsfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621604; c=relaxed/simple;
	bh=kE8TIXCP4omiH8Tb48QLZ4vtCQlIIcYaY2PACwfRHLU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PXA93MwD/OdzL+FQOQgzWsH6W7CUa0KVCL6dkosrFMrtcALwmOscIayTgaSUL9i4jbbFTSRBUx1GCeO+9MDVX2VAQ68qHtDrZQ7XUMR+x7jdgR/9eYp1SQimodLGt31HTOv7Rq5GBoAFJqbIIX5G8YL5WLXYUf9z0AF4+3IciJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMv3dQYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5688BC433C7;
	Thu, 22 Feb 2024 17:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708621603;
	bh=kE8TIXCP4omiH8Tb48QLZ4vtCQlIIcYaY2PACwfRHLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qMv3dQYDhbkA55iCtTxciIgE1L7pMg9o9uWTVAV+VOYkCajdj9ypNeK3dAMJjedon
	 Yfm16dXgjEDaJvw7MKL3T1NUQJuoykxKJy3QBBvO7KjZn6mhHuhTJGHvovxIKU2zrR
	 zDIG+iHYedR7cXvE6GdAAvt5KB235VxZ/Plmw5wAIXTGdCIAdrxI/gYIsiztfOlUMO
	 sRy4h/QB7EziUrqeYVH8Xhch+hYzriJXTd6xGKvdtvOfJu8/ojjSIEqc2no6ipAGbJ
	 +fGCcGAK0vbTCM29gk3bUyqBGrb/tWnTENLA+Bk37mXCqwO4TnK5iKODRwQgZELV7b
	 cavlvjo3SyKpg==
Date: Thu, 22 Feb 2024 11:06:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	will@kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, frowand.list@gmail.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI: Add support for preserving boot configuration
Message-ID: <20240222170641.GA15593@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124110.2681455-1-vidyas@nvidia.com>

On Thu, Feb 22, 2024 at 06:11:10PM +0530, Vidya Sagar wrote:
> Add support for preserving the boot configuration done by the
> platform firmware per host bridge basis, based on the presence of
> 'linux,pci-probe-only' property in the respective PCIe host bridge
> device-tree node. It also unifies the ACPI and DT based boot flows
> in this regard.

> +/**
> + * of_pci_bridge_check_probe_only - Return true if the boot configuration
> + *                                  needs to be preserved

I don't like the "check_probe_only" name because it's a boolean
function but the name doesn't tell me what a true/false return value
means.  Something like "preserve_resources" would be better.  If you
want "probe_only", even removing the "check" would help.

> + * @node: Device tree node with the domain information.
> + *
> + * This function looks for "linux,pci-probe-only" property for a given
> + * PCIe controller's node and returns true if found. Having this property
> + * for a PCIe controller ensures that the kernel doesn't re-enumerate and
> + * reconfigure the BAR resources that are already done by the platform firmware.

This is generic PCI, not PCIe-specific (also in commit log and comment
below).

I think "enumeration" specifically refers to discovering what devices
are present, and the kernel always does that, so drop that part.
Reconfiguring BARs and bridge windows is what we want to prevent.

> + * NOTE: The scope of "linux,pci-probe-only" defined within a PCIe bridge device
> + *       is limited to the hierarchy under that particular bridge device. whereas
> + *       the scope of "linux,pci-probe-only" defined within chosen node is
> + *       system wide.
> + *
> + * Return: true if the property exists false otherwise.
> + */

> +bool of_pci_bridge_check_probe_only(struct device_node *node)
> +{
> +	return of_property_read_bool(node, "linux,pci-probe-only");
> +}
> +EXPORT_SYMBOL_GPL(of_pci_bridge_check_probe_only);

Why does this need to be exported for modules and exposed via
include/linux/pci.h?

> +static void pci_check_config_preserve(struct pci_host_bridge *host_bridge)
> +{
> +	if (&host_bridge->dev) {

Checking &host_bridge->dev doesn't seem like the right way to
determine whether this is an ACPI host bridge.

> +		union acpi_object *obj;
> +
> +		/*
> +		 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> +		 * exists and returns 0, we must preserve any PCI resource
> +		 * assignments made by firmware for this host bridge.
> +		 */
> +		obj = acpi_evaluate_dsm(ACPI_HANDLE(&host_bridge->dev), &pci_acpi_dsm_guid, 1,
> +					DSM_PCI_PRESERVE_BOOT_CONFIG, NULL);
> +		if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0)
> +			host_bridge->preserve_config = 1;
> +		ACPI_FREE(obj);
> +	}

