Return-Path: <linux-pci+bounces-30509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489A6AE68CC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 16:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346E44E3EE5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2932D23BF;
	Tue, 24 Jun 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFz/8rGN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F012D23AD
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775049; cv=none; b=otOdKQ9thNKUSGT3H+fPMchJdSMA/b4T4q2UKF7zCbLjdpiHD8tssCRVAO6Ygd7I4yfSdka1r5S/9znG3BDrkefC0JKD/t7ZrsaIg3+fMeG91bYw+luNaYZYd+fAtLPum/F2O2bM/h9eO/PaM+i6pxInyE1rbrDtscvkR81+k+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775049; c=relaxed/simple;
	bh=Aav5jyBLjcf34J9XQwRsiwqdiBOuhsofLlZLaw/lI+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nt0atbkMFtZlmpedXaRfp90e1rmzONO/lVpj0ZQow/P+M6Q987951tcJStLYHVBJUt2/+Vy4WvYzPm4ZA8cX24YZn5Q7V7RjGtJFscxlBKmmBjHvV1JGgnDlB9/uwUUcHIYvk+CZygM2YPGjoNZbCImaTwEB+CiLUYxYZnafswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFz/8rGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615C8C4CEE3;
	Tue, 24 Jun 2025 14:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750775048;
	bh=Aav5jyBLjcf34J9XQwRsiwqdiBOuhsofLlZLaw/lI+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WFz/8rGN3QKgcCsHUBtoR8V1qDbxQbcvMpcmeRcy11KhQa3xLksixUWk42ERPcQt2
	 LE8vBdVM42Lf7qdNtt5SrAsJemz5Op5NFS2WTLh3hub42Y6stKqwZxstZrzzDP2HWY
	 a599By5Cp7O7JN4uJhFsbAj8YlDax1ktEAG4GAKqfuNydWDpl1nQ7sl1tTYSXyXVdS
	 CmDlHCiOYKfQ27Ra8lc2JT53sR6rcKUXKkbG6x3HagBZVi/oV9wmvrbZXQes0NNKQX
	 9oA8b9UMQKS95z9mjMw3vyTCxn2X1A1SssYT6hskyDAFsys59M2zyMfp9Zyu00SbjC
	 eB7Pp4nWN9f0Q==
Date: Tue, 24 Jun 2025 09:24:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug
 capable ports
Message-ID: <20250624142407.GA1473261@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>

On Mon, Jun 23, 2025 at 07:08:20PM +0200, Lukas Wunner wrote:
> pcie_portdrv_probe() and pcie_portdrv_remove() both call
> pci_bridge_d3_possible() to determine whether to use runtime power
> management.  The underlying assumption is that pci_bridge_d3_possible()
> always returns the same value because otherwise a runtime PM reference
> imbalance occurs.
> 
> That assumption falls apart if the device is inaccessible on ->remove()
> due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(),
> which accesses Config Space to determine whether the device is Hot-Plug
> Capable.   An inaccessible device returns "all ones", which is converted
> to "all zeroes" by pcie_capability_read_dword().  Hence the device no
> longer seems Hot-Plug Capable on ->remove() even though it was on
> ->probe().

This is pretty subtle; thanks for chasing it down.

It doesn't look like anything in pci_bridge_d3_possible() should 
change over the life of the device, although acpi_pci_bridge_d3() is
non-trivial.

Should we consider calling pci_bridge_d3_possible() only once and
caching the result?  We already call it in pci_pm_init() and save the
result in dev->bridge_d3.  That member can be changed by
pci_bridge_d3_update(), but we could add another copy that we never
update after pci_pm_init().

I worry a little that the fix is equally subtle and we could easily
reintroduce this issue with future code reorganization.

> The resulting runtime PM ref imbalance causes errors such as:
> 
>   pcieport 0000:02:04.0: Runtime PM usage count underflow!
> 
> The Hot-Plug Capable bit is cached in pci_dev->is_hotplug_bridge.
> pci_bridge_d3_possible() only calls pciehp_is_native() if that flag is
> set.  Re-checking the bit in pciehp_is_native() is thus unnecessary.
> 
> However pciehp_is_native() is also called from hotplug_is_native().  Move
> the Config Space access to that function.  The function is only invoked
> from acpiphp_glue.c, so move it there instead of keeping it in a publicly
> visible header.
> 
> Fixes: 5352a44a561d ("PCI: pciehp: Make pciehp_is_native() stricter")
> Reported-by: Laurent Bigonville <bigon@bigon.be>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220216
> Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> Closes: https://lore.kernel.org/r/20250609020223.269407-3-superm1@kernel.org/
> Link: https://lore.kernel.org/all/20250620025535.3425049-3-superm1@kernel.org/T/#u
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.18+
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 15 +++++++++++++++
>  drivers/pci/pci-acpi.c             |  5 -----
>  include/linux/pci_hotplug.h        |  4 ----
>  3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 5b1f271c6034..ae2bb8970f63 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -50,6 +50,21 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus);
>  static void hotplug_event(u32 type, struct acpiphp_context *context);
>  static void free_bridge(struct kref *kref);
>  
> +static bool hotplug_is_native(struct pci_dev *bridge)
> +{
> +	u32 slot_cap;
> +
> +	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> +
> +	if (slot_cap & PCI_EXP_SLTCAP_HPC && pciehp_is_native(bridge))
> +		return true;
> +
> +	if (shpchp_is_native(bridge))
> +		return true;
> +
> +	return false;
> +}
> +
>  /**
>   * acpiphp_init_context - Create hotplug context and grab a reference to it.
>   * @adev: ACPI device object to create the context for.
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b78e0e417324..57bce9cc8a38 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -816,15 +816,10 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
>  bool pciehp_is_native(struct pci_dev *bridge)
>  {
>  	const struct pci_host_bridge *host;
> -	u32 slot_cap;
>  
>  	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>  		return false;
>  
> -	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> -	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
> -		return false;
> -
>  	if (pcie_ports_native)
>  		return true;
>  
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index ec77ccf1fc4d..02efeea62b25 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -102,8 +102,4 @@ static inline bool pciehp_is_native(struct pci_dev *bridge) { return true; }
>  static inline bool shpchp_is_native(struct pci_dev *bridge) { return true; }
>  #endif
>  
> -static inline bool hotplug_is_native(struct pci_dev *bridge)
> -{
> -	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
> -}
>  #endif
> -- 
> 2.47.2
> 

