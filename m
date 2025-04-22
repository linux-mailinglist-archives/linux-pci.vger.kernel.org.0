Return-Path: <linux-pci+bounces-26437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3864DA97682
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 22:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BCF3B9F11
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 20:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26552989BC;
	Tue, 22 Apr 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr0gnkYs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B619F464;
	Tue, 22 Apr 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352539; cv=none; b=MMJa9AlaybwZ7trN8eVkRVUY9ECIJMf+OiA/pIQ6+szdq9TJHV4p9Nb03vJQnFlo9s3Nt+xRhvkJbyhDwhh426l3dRMdq+LOcebSlH2pOG+y3DHyt0/BIFP9VSAg2hrgOfFZaT6Ze7KpjiJBrk1nuf+vuZAYoL0XZTtFOGkwAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352539; c=relaxed/simple;
	bh=HIC5n0BbMNJEad5tKLVS9XnjWuNIBBpihQkigOIzX8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XVeqnzR0XLwRCWfdDUmAx3ijXznZlX7XYoUSfkY4tK2NJqdqfi9GaUVFkFzrfp0P6tUwWG2mDDL/HJn7AKAwFxTCFxuiohN6Kq3c7j0PFgwDrs1aBJEwD3QQfOb9RYIzilqZIzSIBO4N1Aedlvy3hNze3/FzZ8PBeF49zc+CV6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr0gnkYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E85C4CEEB;
	Tue, 22 Apr 2025 20:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745352539;
	bh=HIC5n0BbMNJEad5tKLVS9XnjWuNIBBpihQkigOIzX8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Hr0gnkYsnrb3wjUochvX8MWNBaq32Du/zeqjcnz4+RwUwgKCcvPr4C6zMVQc9Pjbx
	 7d0iGqQl8Gn6GD1icWKwxq8dDBvcGXOjoxoVU6kT5Wo0ictj5+VrLDrSUlPwa3umHo
	 JycKn7r0+4CXBq9jxp2HCGS63siNNsn2oCNyxCB+fpt8b6L4DGn/Rtmswd4T6I0GBx
	 co2HqBA539fNP1pKGI2jghNuQXHlsSyumqB2zeGGwKhOZ7v+r2Fi28htDecZ963r8L
	 M8OaoAA4LknPJfyWdbtp7oi3wQ3HXLaia00CBig5sLnFMM9firlXgcCGsoiRr2Nbbl
	 XY/lLRCqESyAw==
Date: Tue, 22 Apr 2025 15:08:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Message-ID: <20250422200857.GA381276@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422130207.3124-1-ilpo.jarvinen@linux.intel.com>

On Tue, Apr 22, 2025 at 04:02:07PM +0300, Ilpo Järvinen wrote:
> When bifurcated to x2, Xeon 6 Root Port performance is sensitive to the
> configuration of Extended Tags, Max Read Request Size (MRRS), and 10-Bit
> Tag Requester (note: there is currently no 10-Bit Tag support in the
> kernel). While those can be configured to the recommended values by FW,
> kernel may decide to overwrite the initial values.
> 
> Unfortunately, there is no mechanism for FW to indicate OS which parts
> of PCIe configuration should not be altered. Thus, the only option is
> to add such logic into the kernel as quirks.
> 
> There is a pre-existing quirk flag to disable Extended Tags. Depending
> on CONFIG_PCIE_BUS_* setting, MRRS may be overwritten by what the
> kernel thinks is the best for performance (the largest supported
> value), resulting in performance degradation instead with these Root
> Ports. (There would have been a pre-existing quirk to disallow
> increasing MRRS but it is not identical to rejecting >128B MRRS.)
> 
> Add a quirk that disallows enabling Extended Tags and setting MRRS
> larger than 128B for devices under Xeon 6 Root Ports if the Root Port is
> bifurcated to x2. Reject >128B MRRS only when it is going to be written
> by the kernel (this assumes FW configured a good initial value for MRRS
> in case the kernel is not touching MRRS at all).
> 
> It was first attempted to always write MRRS when the quirk is needed
> (always overwrite the initial value). That turned out to be quite
> invasive change, however, given the complexity of the initial setup
> callchain and various stages returning early when they decide no changes
> are necessary, requiring override each. As such, the initial value for
> MRRS is now left into the hands of FW.
> 
> Link: https://cdrdv2.intel.com/v1/dl/getContent/837176
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

v1/rfc: https://lore.kernel.org/all/20250304135108.2599-1-ilpo.jarvinen@linux.intel.com/

I suppose it's quixotic to hope for anything better than quirks that
have to be added or updated for every new processor that comes along.

ACPI _HPX might be a possible way for the platform to tell us what to
do here.  ACPI r6.5, sec 6.2.9 says it's for hot-added devices and
"Functions not configured by the platform firmware during initial
system boot" (how are we supposed to determine that?)  In any case,
Linux does evaluate _HPX for every device in pci_configure_device().

I'm not sure _HPX really works; it's very general, and I would expect
to see reports of problems if firmware really tried to use it.

Or, I guess a _DSM function would be a possible way to communicate
this.

> v2:
> - Explain in changelog why FW cannot solve this on its own
> - Moved the quirk under arch/x86/pci/
> - Don't NULL check value from pci_find_host_bridge()
> - Added comment above the quirk about the performance degradation
> - Removed all setup chain 128B quirk overrides expect for MRRS write
>   itself (assumes a sane initial value is set by FW)
> 
>  arch/x86/pci/fixup.c | 30 ++++++++++++++++++++++++++++++
>  drivers/pci/pci.c    | 15 ++++++++-------
>  include/linux/pci.h  |  1 +
>  3 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index efefeb82ab61..aa9617bc4b55 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -294,6 +294,36 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PB1,	pcie_r
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC,	pcie_rootport_aspm_quirk);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_rootport_aspm_quirk);
>  
> +/*
> + * PCIe devices underneath Xeon6 PCIe Root Port bifurcated to 2x have slower
> + * performance with Extended Tags and MRRS > 128B. Workaround the performance
> + * problems by disabling Extended Tags and limiting MRRS to 128B.
> + *
> + * https://cdrdv2.intel.com/v1/dl/getContent/837176
> + */
> +static void quirk_pcie2x_no_tags_no_mrrs(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> +	u32 linkcap;
> +
> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &linkcap);
> +	if (FIELD_GET(PCI_EXP_LNKCAP_MLW, linkcap) != 0x2)
> +		return;
> +
> +	bridge->no_ext_tags = 1;
> +	bridge->only_128b_mrrs = 1;
> +	pci_info(pdev, "Disabling Extended Tags and limiting MRRS to 128B (performance reasons due to 2x PCIe link)\n");
> +}
> +
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db0, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db1, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db2, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db3, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db6, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db7, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db8, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db9, quirk_pcie2x_no_tags_no_mrrs);
> +
>  /*
>   * Fixup to mark boot BIOS video selected by BIOS before it changes
>   *
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4d7c9f64ea24..2ca9cb30fbd3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5941,7 +5941,7 @@ EXPORT_SYMBOL(pcie_get_readrq);
>  int pcie_set_readrq(struct pci_dev *dev, int rq)
>  {
>  	u16 v;
> -	int ret;
> +	int ret, max_mrrs = 4096;
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>  
>  	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
> @@ -5961,13 +5961,14 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  
>  	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
>  
> -	if (bridge->no_inc_mrrs) {
> -		int max_mrrs = pcie_get_readrq(dev);
> +	if (bridge->no_inc_mrrs)
> +		max_mrrs = pcie_get_readrq(dev);
> +	if (bridge->only_128b_mrrs)
> +		max_mrrs = 128;
>  
> -		if (rq > max_mrrs) {
> -			pci_info(dev, "can't set Max_Read_Request_Size to %d; max is %d\n", rq, max_mrrs);
> -			return -EINVAL;
> -		}
> +	if (rq > max_mrrs) {
> +		pci_info(dev, "can't set Max_Read_Request_Size to %d; max is %d\n", rq, max_mrrs);
> +		return -EINVAL;
>  	}
>  
>  	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0e8e3fd77e96..6dc7a05f4d4b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -603,6 +603,7 @@ struct pci_host_bridge {
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
>  	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
> +	unsigned int	only_128b_mrrs:1;	/* Only 128B MRRS */
>  	unsigned int	native_aer:1;		/* OS may use PCIe AER */
>  	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
>  	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
> 
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> -- 
> 2.39.5
> 

