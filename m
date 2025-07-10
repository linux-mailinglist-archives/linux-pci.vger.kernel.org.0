Return-Path: <linux-pci+bounces-31830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA79AFF6AA
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 04:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A62585C4D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 02:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5426E14C;
	Thu, 10 Jul 2025 02:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="mWX32b4F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88909A944;
	Thu, 10 Jul 2025 02:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752113869; cv=none; b=sQI4bgiyz2Ss3A8ocWK0GKgn53KwyAOHYezQmctpCc6H37UByYD7Su4bltsZxJK4Xkub2jcTASCECFLoSangO2P1+vsmkuqQ5sd/PQ42ph+FnvdhIg7A8RloJCsREWP+U+61rYRe1zhWQO3Ni5ppJ2a1XzAUEtnoNRBicqRwb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752113869; c=relaxed/simple;
	bh=JkH67B7V6FlcTktsqx5cIzqH3Ef7ONT5ylXP0d/tqRg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FeOE3BDhGikkeCFF5e+sAZe7eS6UOqVhprxSSmxrJKV1g1tFq/q+HTtPk0RxQJwQmeFX7vvmgQyorXSApkhId3p2J09Ya5qeCr+9PgrzrnihKrR3LVGIrMAR5E7cT6YhNKLNDl03JmyKBJ6k1F6AeI+eXZZXXiiKJYJi406q7d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=mWX32b4F; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from xps-9320 (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4bcz5P258Lz19Mv;
	Wed,  9 Jul 2025 22:17:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1752113866; bh=JkH67B7V6FlcTktsqx5cIzqH3Ef7ONT5ylXP0d/tqRg=;
	h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
	b=mWX32b4FYS5B+TLkpcers79hSx2hNo0whwQcSDghjkjcq8MRouqFq1KZ7/mvU+uUI
	 2rZaljz8uZ5GCvp49SF4yhmHgrYfS+kiHTgJ4v3C4qjGkjJL+MChAoqHhWw+QogdLf
	 i9m9zzTwnFfRFHW9pHhVG2DhMvkFCu2wvKy0RHGY=
Date: Wed, 9 Jul 2025 19:17:44 -0700 (PDT)
From: "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To: "David E. Box" <david.e.box@linux.intel.com>
cc: rafael@kernel.org, bhelgaas@google.com, andrea.righi@canonical.com, 
    vicamo.yang@canonical.com, nirmal.patel@linux.intel.com, 
    linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
    ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Allow ASPM enablement for devices behind Intel
 VMD
In-Reply-To: <20250710011647.990046-1-david.e.box@linux.intel.com>
Message-ID: <6d51924d-dcb8-eb42-b2b5-f0c33f77837a@panix.com>
References: <20250710011647.990046-1-david.e.box@linux.intel.com>
Errors-To: kenny@panix.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


(Resending; for some reason VGER thinks the Thunderbird MUA is "Spammy", but doesn't think as badly of "Alpine")

Testing now; so far, results look quite promising!

-K

On Wed, 9 Jul 2025, David E. Box wrote:

> Devices behind Intel's Volume Management Device (VMD) controller reside on
> a synthetic PCI hierarchy that is intentionally hidden from ACPI and
> firmware. As such, BIOS does not configure ASPM for these devices, and the
> responsibility for link power management, including ASPM and LTR, falls
> entirely to the VMD driver.
>
> However, the current PCIe ASPM code prevents ASPM configuration when the
> ACPI_FADT_NO_ASPM flag is set, disallowing OS management. This leaves ASPM
> permanently disabled for these devices, contrary to the platform's design
> intent.
>
> Introduce a callback mechanism that allows the VMD driver to enable ASPM
> for its domain, bypassing the global ACPI_FADT_NO_ASPM restriction that is
> not applicable in this context. This ensures that devices behind VMD can
> benefit from ASPM savings as originally intended.
>
> Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-2212-50d995611cef@panix.com
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 28 ++++++++++++++++++++++++++--
>  drivers/pci/pci.h            |  8 ++++++++
>  drivers/pci/pcie/aspm.c      | 36 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 69 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 8df064b62a2f..e685586dc18b 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -21,6 +21,8 @@
>
>  #include <asm/irqdomain.h>
>
> +#include "../pci.h"
> +
>  #define VMD_CFGBAR	0
>  #define VMD_MEMBAR1	2
>  #define VMD_MEMBAR2	4
> @@ -730,7 +732,7 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>  }
>
>  /*
> - * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
> + * Enable LTR settings on devices that aren't configured by BIOS.
>   */
>  static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  {
> @@ -770,10 +772,27 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	 * PCIe r6.0, sec 5.5.4.
>  	 */
>  	pci_set_power_state_locked(pdev, PCI_D0);
> -	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
>  	return 0;
>  }
>
> +static long vmd_get_link_state(struct pci_dev *pdev, void *data)
> +{
> +	struct pci_bus *vmd_bus = data;
> +	struct pci_bus *bus = pdev->bus;
> +
> +	while (bus) {
> +		if (bus == vmd_bus)
> +			return PCIE_LINK_STATE_ALL;
> +
> +		if (!bus->self)
> +			break;
> +
> +		bus = bus->self->bus;
> +	}
> +
> +	return -ENODEV;
> +}
> +
>  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  {
>  	struct pci_sysdata *sd = &vmd->sysdata;
> @@ -785,6 +804,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	resource_size_t membar2_offset = 0x2000;
>  	struct pci_bus *child;
>  	struct pci_dev *dev;
> +	struct pcie_aspm_vmd_link_state vmd_link_state;
>  	int ret;
>
>  	/*
> @@ -911,6 +931,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		return -ENODEV;
>  	}
>
> +	vmd_link_state.cb = vmd_get_link_state;
> +	vmd_link_state.data = vmd->bus;
> +	pci_register_vmd_link_state_cb(&vmd_link_state);
> +
>  	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
>  				   to_pci_host_bridge(vmd->bus->bridge));
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..dcf7d39c660f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -821,6 +821,12 @@ void pci_configure_aspm_l1ss(struct pci_dev *dev);
>  void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>  void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>
> +
> +struct pcie_aspm_vmd_link_state {
> +	long (*cb)(struct pci_dev *pdev, void *data);
> +	void *data;
> +};
> +
>  #ifdef CONFIG_PCIEASPM
>  void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> @@ -828,6 +834,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>  void pci_configure_ltr(struct pci_dev *pdev);
>  void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
> +void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state *state);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> @@ -835,6 +842,7 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked)
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>  static inline void pci_configure_ltr(struct pci_dev *pdev) { }
>  static inline void pci_bridge_reconfigure_ltr(struct pci_dev *pdev) { }
> +void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state *state) { }
>  #endif
>
>  #ifdef CONFIG_PCIE_ECRC
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 29fcb0689a91..c609d3c309be 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -320,6 +320,27 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
>  	return 0;
>  }
>
> +static struct pcie_aspm_vmd_link_state vmd_state;
> +
> +void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state *state)
> +{
> +	mutex_lock(&aspm_lock);
> +	vmd_state.cb = state->cb;
> +	vmd_state.data = state->data;
> +	mutex_unlock(&aspm_lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_register_vmd_link_state_cb);
> +
> +static long pci_get_vmd_link_state(struct pci_dev *pdev)
> +{
> +	int state = -ENODEV;
> +
> +	if (vmd_state.cb)
> +		state = vmd_state.cb(pdev, vmd_state.data);
> +
> +	return state;
> +}
> +
>  static void pci_update_aspm_saved_state(struct pci_dev *dev)
>  {
>  	struct pci_cap_saved_state *save_state;
> @@ -794,6 +815,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	u32 parent_lnkcap, child_lnkcap;
>  	u16 parent_lnkctl, child_lnkctl;
>  	struct pci_bus *linkbus = parent->subordinate;
> +	int vmd_aspm_default;
>
>  	if (blacklist) {
>  		/* Set enabled/disable so that we will disable ASPM later */
> @@ -865,8 +887,20 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
>  	}
>
> +	/*
> +	 * Devices behind Intel VMD operate on a synthetic PCI bus that BIOS
> +	 * and ACPI do not enumerate or configure. ASPM for these devices must
> +	 * be managed by the VMD driver itself, independent of global ACPI ASPM
> +	 * constraints. This callback mechanism allows selective ASPM
> +	 * enablement for such domains.
> +	 */
> +	vmd_aspm_default = pci_get_vmd_link_state(parent);
> +
>  	/* Save default state */
> -	link->aspm_default = link->aspm_enabled;
> +	if (vmd_aspm_default < 0)
> +		link->aspm_default = link->aspm_enabled;
> +	else
> +		link->aspm_default = vmd_aspm_default;
>
>  	/* Setup initial capable state. Will be updated later */
>  	link->aspm_capable = link->aspm_support;
>
> base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
>

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA

