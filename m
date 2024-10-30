Return-Path: <linux-pci+bounces-15558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98FC9B586E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 01:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BD5286930
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 00:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C670D15E96;
	Wed, 30 Oct 2024 00:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr0tu9WW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB6CA64;
	Wed, 30 Oct 2024 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247327; cv=none; b=kXpZnFyuN9lbwJgd85Xqi+urpGCyAUnkMjOQYLFosOzqPL0uIoTTQx+y4jxipCRVmKJWADuDQjQQJRFo5n/824gKpWMDV6R3JE0hQmkwbfIkWwBTt6IqEsUznoJmPIA+9A4kABtD16GD7coS6qPH5QLrKknwcSBz+4bBUtnTEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247327; c=relaxed/simple;
	bh=Yy0P1IZcy1h8RABTeivAl3JLt4m0j1R0j+/CQtYFOtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Tg6Yq83H5RLqrM6Td3KPFvSPZHtdFnV/LlJ8hMrkGeHqVXdTLj5XusTPm+/UpzRA88CcWYoFFE1+lZpoxmGNyWvwTVTwEh/TbXTatT5luwQu/iXvsNEfvXLybDdFV1SChd4FqejqddpUaAMYYiHGxwo2mOCc0w995k6OhiJM/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr0tu9WW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD844C4CECD;
	Wed, 30 Oct 2024 00:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730247326;
	bh=Yy0P1IZcy1h8RABTeivAl3JLt4m0j1R0j+/CQtYFOtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Qr0tu9WW263FT7aKu8DDn7gNNkLN9QYTa5IJ17LGFxWySaiag+FvWBJ48f/Tx5PGj
	 Zr0i/b8b7NOoSbM9Kj50HddFjSPQ6EsJ+wVcxbuw0mfhXFdo9UFlFn8QC87f3UJCAv
	 Klk6SfPXguJbA2eaZHd2R9MxtoN3xRCZQkt7uvYXLij9+BdlOGidO6Lj64JwZ1nza8
	 jwEDkrXdm9t/dBNNExTPrTMkw4v0KWKhTMe9xePxLIJG1jQ6hBalrwFJm17rFU42MW
	 K7Hgbg1G+xU36nHoq14NN4+IOsS9QilBniVty6UjgBCqj9IYXMfFm/uMoIVaXZ1JHo
	 lV32HqYdhgpRQ==
Date: Tue, 29 Oct 2024 19:15:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Esther Shimanovich <eshimanovich@chromium.org>,
	Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <20241030001524.GA1180712@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org>

On Tue, Sep 10, 2024 at 05:57:45PM +0000, Esther Shimanovich wrote:
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
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
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
> Changes in v5:
> - Applied the following edits suggested by Lukas Wunner:
>   - Applied ifdefs edits to ensure code is only compiled on x86 systems
>   with ACPI
>   - Added returns to avoid unecessary checks
>   - Renamed pcie_is_tunneled to arch_pci_dev_is_removable
> - Link to v4: https://lore.kernel.org/r/20240823-trust-tbt-fix-v4-1-c6f1e3bdd9be@chromium.org
> 
> Changes in v4:
> - Applied edits on logic-flow clarity and formatting suggested by Ilpo
>   Järvinen
> - Mario Limonciello tested patch and confirmed works as intended.
> - Link to v3: https://lore.kernel.org/r/20240815-trust-tbt-fix-v3-1-6ba01865d54c@chromium.org
> 
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
>  arch/x86/pci/acpi.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c |  30 +++++++++----
>  include/linux/pci.h |   6 +++
>  3 files changed, 148 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 55c4b07ec1f6..62271668c3b1 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -250,6 +250,125 @@ void __init pci_acpi_crs_quirks(void)
>  		pr_info("Please notify linux-pci@vger.kernel.org so future kernels can do this automatically\n");
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
> +	/* If the device doesn't have a parent, it's not under anything. */
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
> +		return parent == bridge;
> +
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		if (pci_pcie_type(parent) != PCI_EXP_TYPE_UPSTREAM)
> +			return false;
> +		parent = pci_upstream_bridge(parent);
> +		return parent == bridge;
> +
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		if (pci_pcie_type(parent) != PCI_EXP_TYPE_DOWNSTREAM)
> +			return false;
> +		parent = pci_upstream_bridge(parent);
> +		if (!parent || pci_pcie_type(parent) != PCI_EXP_TYPE_UPSTREAM)
> +			return false;
> +		parent = pci_upstream_bridge(parent);
> +		return parent == bridge;
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

The Intel devices below look like they're obviously x86-specific, but
what about the "usb4-host-interface" above?  Is there any reason that
should be x86-specific?

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
> +bool arch_pci_dev_is_removable(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent, *root;
> +
> +	/* pdev without a parent or Root Port is never tunneled. */
> +	parent = pci_upstream_bridge(pdev);
> +	if (!parent)
> +		return false;
> +	root = pcie_find_root_port(pdev);
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

I asked on the v4 patch whether we really need to make all this
ACPI specific, and I'm still curious about that, since we don't
actually use any ACPI interfaces directly.

Bjorn

