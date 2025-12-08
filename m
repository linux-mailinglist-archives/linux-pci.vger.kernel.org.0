Return-Path: <linux-pci+bounces-42780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0F9CADF60
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 19:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A84730495A3
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19034228CA9;
	Mon,  8 Dec 2025 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjHQxoS5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF2F770FE;
	Mon,  8 Dec 2025 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765217186; cv=none; b=Sjy+b2p0YFenWcI1adDOCRTN4DJW6fimY1RmRDe1DZpmcl9acyxAPhp24yzf8WEkgAQhd+xUI16v0K4TDcWYSACOFNkGEi6zy7ZFEt6l8a8K3xRoryF8M7w9NkbNhBOyqWB+pW6wniX9uehcGyKwu1O5Qgc/fPotu5/CoTojGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765217186; c=relaxed/simple;
	bh=5L9j+bDMmpipf6t2OXyZSTWQkiHdOPheH8Bn3XAGC4I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vy0kQk9/h59UjB0lXvOqh3b6MdGomaiGF53GRhYYeUISYoFxjKvTWA5LECdyfHsa9+Pb/+03cuI18J+DJcx9AyaA/NvfR3MJ0HTVALWGKosGtddLM5x7HuMFcXSaBk6kMgjg3Du5ROUi4LGSLwSfdP4ktmVPBFQIEY9MPxDfLQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjHQxoS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAB1C4CEF1;
	Mon,  8 Dec 2025 18:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765217185;
	bh=5L9j+bDMmpipf6t2OXyZSTWQkiHdOPheH8Bn3XAGC4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IjHQxoS5maBYA0O0Hnww0yf8yFG5PKbOCjml5d9LQSMEjK1SDwgQit95c80ucV+yj
	 5K+O73vm5wfHeOI/XrvXpyGO+1B4Qz9+2ftyrpNUSkkXsDy8/dIbfEzsWz+9gUipFg
	 seZ2mipC8whUVRo7NAQwO5CpUDlAvmOgqkxlWXTJ9qBKjPKr1fitAmREcxcL4EGGmg
	 1r6/4mwMyyG7bFxwrAzlot4j5EWMPjtOhEL1wS7FkqeR/shJWw3e4QAmPGQyVROQhb
	 RmncvcYStBH67rnVTgFmIw3TPFqjcTSQbNz6LavAZLwbLzoHlaF5Rvxzozw3deitYZ
	 eUQJ9P6Z2O7eA==
Date: Mon, 8 Dec 2025 12:06:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 08/25] CXL/AER: Move AER drivers RCH error handling
 into pcie/aer_cxl_rch.c
Message-ID: <20251208180624.GA3300935@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104001001.3833651-9-terry.bowman@amd.com>

I vote for a subject like:

  PCI/AER: Move CXL RCH error handling to aer_cxl_rch.c

I think stuff in drivers/pci should have a PCI/... prefix.  "CXL" is
really its own major subsystem, not a feature of PCI.

On Mon, Nov 03, 2025 at 06:09:44PM -0600, Terry Bowman wrote:
> The restricted CXL Host (RCH) AER error handling logic currently resides
> in the AER driver file, drivers/pci/pcie/aer.c. CXL specific changes are
> conditionally compiled using #ifdefs.

s|the AER driver file, drivers/pci/pcie/aer.c|aer.c|

> Improve the AER driver maintainability by separating the RCH specific logic
> from the AER driver's core functionality and removing the ifdefs. Introduce
> drivers/pci/pcie/aer_cxl_rch.c for moving the RCH AER logic into.
> Conditionally compile the file using the CONFIG_CXL_RCH_RAS Kconfig.
> 
> Move the CXL logic into the new file but leave helper functions in aer.c
> for now as they will be moved in future patch for CXL virtual hierarchy
> handling. Export the handler functions as needed. Export
> pci_aer_unmask_internal_errors() allowing for all subsystems to use.
> Avoid multiple declaration moves and export cxl_error_is_native() now to
> allow access from cxl_core.
> 
> Inorder to maintain compilation after the move other changes are required.
> Change cxl_rch_handle_error() & cxl_rch_enable_rcec() to be non-static
> inorder for accessing from the AER driver in aer.c.

s/Inorder to/In order to/  (or just "To maintain ...")
/inorder for accessing from the AER driver in/so they can be used by/

> Update the new file with the SPDX and 2023 AMD copyright notations because
> the RCH bits were initally contributed in 2023 by AMD.

Maybe cite the commit that did this so it's easy to check.

> +++ b/drivers/pci/pci.h

> +#ifdef CONFIG_CXL_RAS
> +bool is_internal_error(struct aer_err_info *info);
> +#else
> +static inline bool is_internal_error(struct aer_err_info *info) { return false; }

This used to be static and internal.  "is_internal_error()" seems a
little too generic now that it's not static; probably should include
"aer".  Maybe rename it in a preliminary patch so the move is more of
a pure move.

> +++ b/drivers/pci/pcie/aer.c
> @@ -1130,7 +1130,7 @@ static bool find_source_device(struct pci_dev *parent,
>   * Note: AER must be enabled and supported by the device which must be
>   * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 mask;
> @@ -1143,116 +1143,25 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);

Not sure why these EXPORTs are needed.  Is there a caller that can be
a module?  The callers I see look like they would be builtin.  If you
add callers later that need this, the export can be done then.

> +++ b/include/linux/aer.h
> @@ -56,12 +56,20 @@ struct aer_capability_regs {
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> +static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
> +#endif
> +
> +#ifdef CONFIG_CXL_RAS
> +bool cxl_error_is_native(struct pci_dev *dev);
> +#else
> +static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }

These include/linux/aer.h changes look like a separate patch.  Moving
code from aer.c to aer_cxl_rch.c doesn't add any callers outside
drivers/pci, so these shouldn't need to be in include/linux/.

