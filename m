Return-Path: <linux-pci+bounces-10109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE0E92DB38
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 23:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE85B21CD9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 21:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D9212CD88;
	Wed, 10 Jul 2024 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw8A58bA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6635B3AC0C;
	Wed, 10 Jul 2024 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720648067; cv=none; b=J5a+qkL0i/GjYOl6ZOt7Gl7I3GyiKofjxMo7MgzqE+O9NuM0upvDho/wJ2y4TEJfmcD5/7Y1dQZy56TKKptKYV0xzn0Ui9RwglFcb7kHZSaX7NiAxT2GdszMXYZvOReerZfL7KkBwtNLS1nZfItrqUGgiyXSDq+bdbgwFzaz9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720648067; c=relaxed/simple;
	bh=au1e9V8nUaNL/Ed0ZbAhZWTGUGGE9KSPfdbAOqBBOP0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T1+dldNU+XG2LP8Xl4u2RA603/vP7p4Up2qsQEXeV3UXGuS9UuysNGfSacSh9YM8XPbtKaOt5jarvuGNKp1pIooFxx+VBIiHj5s3Rj0xc3Iim1X8DVO9JBWEkCXo3JpI0UAXNuvVBKOfol6oPrmdqOQ9YP5rTJNxLLsEsu+ZfDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw8A58bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27BDC32781;
	Wed, 10 Jul 2024 21:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720648066;
	bh=au1e9V8nUaNL/Ed0ZbAhZWTGUGGE9KSPfdbAOqBBOP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nw8A58bAK2dTgAU4pJEwe1yoc1ZCAGiMNNPbhsg6m3tkzXAx+NUcu5wCyWnJxJNwV
	 v0VeaAK98uAzI+shc5onVvgjLiiJfZJnN5bAt4iIwWta8Y/+cJjtzfWcuFD/KumF8Z
	 yZCASSTZ4d08ZcblhTNHWd1ccEWqTmRuSyDRWF0MVMTTEIPc82Tdq7jNnaVQEdZT4L
	 U/AIjq9O5LHIilaIV0FIM5f8LcLLdKyTjH568QCxtYS6wTYN/MrMHrWR/XNOD6traa
	 ajM6jGVpNE/qS84l3SfP5YxM7fQR5hScKiAxPQyv3XfrDtCQE9rAvJprzb+TH/GPon
	 8ZQallWXxpEgQ==
Date: Wed, 10 Jul 2024 16:47:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	ming4.li@intel.com, vishal.l.verma@intel.com,
	jim.harris@samsung.com, ilpo.jarvinen@linux.intel.com,
	ardb@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 8/9] PCI/AER: Export pci_aer_unmask_internal_errors()
Message-ID: <20240710214744.GA261828@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617200411.1426554-9-terry.bowman@amd.com>

On Mon, Jun 17, 2024 at 03:04:10PM -0500, Terry Bowman wrote:
> AER correctable internal errors (CIE) and AER uncorrectable internal
> errors (UIE) are disabled through the AER mask register by default.[1]

Nit: "Correctable Errors" and "Uncorrectable Errors" are generic PCIe
concepts that exist independent of AER, so I wouldn't prefix them with
AER.  The AER mask registers control *reporting* of errors, but of
course they don't disable the errors themselves.

> CXL PCIe ports use the CIE/UIE to report RAS errors and as a result
> need CIE/UIE enabled.[2]
> 
> Change pci_aer_unmask_internal_errors() function to be exported for
> the CXL driver and other drivers to use.
> 
> [1] PCI6.0 - 7.8.4.3 Uncorrectable

s/PCI6.0 .../PCIe r6.0, sec 7.8.4.3/ since there is a conventional PCI
spec as well.

> [2] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and Upstream
>              Switch Ports
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pcie/aer.c | 3 ++-
>  include/linux/aer.h    | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4dc03cb9aff0..d7a1982f0c50 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -951,7 +951,7 @@ static bool find_source_device(struct pci_dev *parent,
>   * Note: AER must be enabled and supported by the device which must be
>   * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 mask;
> @@ -964,6 +964,7 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
>  
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>  {
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 4b97f38f3fcf..a4fd25ea0280 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -50,6 +50,12 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
> +#ifdef CONFIG_PCIEAER_CXL
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
> +#else
> +static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
> +#endif

I don't like the idea of exporting a generic PCI interface that only
does something when CONFIG_PCIEAER_CXL is enabled.  If there's ever a
non-CXL caller, it will be confused.

Bjorn

