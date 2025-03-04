Return-Path: <linux-pci+bounces-22910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B743A4EF3E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 22:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577123A526E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 21:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DA7260384;
	Tue,  4 Mar 2025 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxeaMso+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B751FDA9D;
	Tue,  4 Mar 2025 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122870; cv=none; b=aGYzoL+WpdTaYtB+EfNbqFHoWTA74lwGLkicis3vHPV5GGZ8x87DYAlNRJa2i8gIYWDVJEGXmrg3XpOBAfKdaLS9JT867CclXvxwVrY0zAcetZU0IuCvw0ku1tuXCAJDiFeauOoICSXXKo6RcpGQTV16qnJ8+pZQz46FvW9bGRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122870; c=relaxed/simple;
	bh=9+zCNKmwNKnjGxDu60SDej4Qy7w6cwAgW7GjsjzZzO4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l5JB8IcxBUAbG5c0jzFv1pqBKn3KrSg4Ujcd1+IWkjMTDdgz7BMILU7+2CDBEhyvXBUYWCQ+Wv+BvQRygNurzNQ6ygh7LqQTLqe8xMM2WT1SiO8naHry6k+siidrXIYXVyEPfwBDjFESDqBTdnwLtkPH3MT7Hy3qtf2t29ttq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxeaMso+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976D2C4CEE5;
	Tue,  4 Mar 2025 21:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741122869;
	bh=9+zCNKmwNKnjGxDu60SDej4Qy7w6cwAgW7GjsjzZzO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WxeaMso+2o3FdrfLYBd13Y4/EhpLSq1MnT1cgAa/pvHzCnXNHWNEA4x+Uk2tc1A3s
	 oNYwospfrQ6/jrr8KN40IfQa9/nd0OXF1rNq6askJ/MjYfD4Vw93gz5A/MN18Ef4Hq
	 2homxCLZu+5UmthqT77SGhYvhc7VLruEFdgTAMBC/DhawAGVz8e2tuYX9sNANYN6cc
	 aBJyn6AK5Jxe7wRWcH+4zOzeextzHkiYD3UTihxBa9t762eUn/txBoxU/y5nJp9iJG
	 r9M+dux+AxqM1Ooos59NYw55Bk95Ascw168aaTBYRtrMr0YogbBS/j40R2VRqSulZz
	 B7dDQ6VEzFw3Q==
Date: Tue, 4 Mar 2025 15:14:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Message-ID: <20250304211428.GA258044@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304135108.2599-1-ilpo.jarvinen@linux.intel.com>

On Tue, Mar 04, 2025 at 03:51:08PM +0200, Ilpo Järvinen wrote:
> Disallow Extended Tags and Max Read Request Size (MRRS) larger than
> 128B for devices under Xeon 6 Root Ports if the Root Port is bifurcated
> to x2. Also, 10-Bit Tag Requester should be disallowed for device
> underneath these Root Ports but there is currently no 10-Bit Tag
> support in the kernel.
> 
> The normal path that writes MRRS is through
> pcie_bus_configure_settings() -> pcie_bus_configure_set() ->
> pcie_write_mrrs() and contains a few early returns that are based on
> the value of pcie_bus_config. Overriding such checks with the host
> bridge flag check on each level seems messy. Thus, simply ensure MRRS
> is always written in pci_configure_device() if a device requiring the
> quirk is detected.

This is kind of weird.  It's apparently not an erratum in the sense
that something doesn't *work*, just something for "optimized PCIe
performance"?

What are we supposed to do with this?  Add similar quirks for every
random PCI controller?  Scratching my head about what this means for
the future.

What bad things happen if we *don't* do this?  Is this something we
could/should rely on BIOS to configure for us?

> Link: https://cdrdv2.intel.com/v1/dl/getContent/837176
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> The normal path that writes MRRS is somewhat convoluted so I ensure MRRS
> gets written in a more direct way, I'm not sure if that's the best
> approach. Thus sending this as RFC.
> 
>  drivers/pci/pci.c    | 15 ++++++++-------
>  drivers/pci/probe.c  |  8 +++++++-
>  drivers/pci/quirks.c | 27 +++++++++++++++++++++++++++
>  include/linux/pci.h  |  1 +
>  4 files changed, 43 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..81ddad81ccb8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5913,7 +5913,7 @@ EXPORT_SYMBOL(pcie_get_readrq);
>  int pcie_set_readrq(struct pci_dev *dev, int rq)
>  {
>  	u16 v;
> -	int ret;
> +	int ret, max_mrrs = 4096;
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>  
>  	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
> @@ -5933,13 +5933,14 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
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
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b6536ed599c3..ceaa34b0525b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2342,7 +2342,11 @@ static void pci_configure_serr(struct pci_dev *dev)
>  
>  static void pci_configure_device(struct pci_dev *dev)
>  {
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
> +
>  	pci_configure_mps(dev);
> +	if (host_bridge && host_bridge->only_128b_mrrs)
> +		pcie_set_readrq(dev, 128);
>  	pci_configure_extended_tags(dev, NULL);
>  	pci_configure_relaxed_ordering(dev);
>  	pci_configure_ltr(dev);
> @@ -2851,13 +2855,15 @@ static void pcie_write_mps(struct pci_dev *dev, int mps)
>  
>  static void pcie_write_mrrs(struct pci_dev *dev)
>  {
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
>  	int rc, mrrs;
>  
>  	/*
>  	 * In the "safe" case, do not configure the MRRS.  There appear to be
>  	 * issues with setting MRRS to 0 on a number of devices.
>  	 */
> -	if (pcie_bus_config != PCIE_BUS_PERFORMANCE)
> +	if (pcie_bus_config != PCIE_BUS_PERFORMANCE &&
> +	    (!host_bridge || !host_bridge->only_128b_mrrs))
>  		return;
>  
>  	/*
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b84ff7bade82..987cd94028e1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5564,6 +5564,33 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0144, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
>  
> +static void quirk_pcie2x_no_tags_no_mrrs(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> +	u32 linkcap;
> +
> +	if (!bridge)
> +		return;
> +
> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &linkcap);
> +	if (FIELD_GET(PCI_EXP_LNKCAP_MLW, linkcap) != 0x2)
> +		return;
> +
> +	bridge->no_ext_tags = 1;
> +	bridge->only_128b_mrrs = 1;
> +	pci_info(pdev, "Disabling Extended Tags and forcing MRRS to 128B (performance reasons due to 2x PCIe link)\n");
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
> +
>  #ifdef CONFIG_PCI_ATS
>  static void quirk_no_ats(struct pci_dev *pdev)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 47b31ad724fa..def29c8c0f84 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -601,6 +601,7 @@ struct pci_host_bridge {
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
>  	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
> +	unsigned int	only_128b_mrrs:1;	/* Only 128B MRRS */
>  	unsigned int	native_aer:1;		/* OS may use PCIe AER */
>  	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
>  	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
> 
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> -- 
> 2.39.5
> 

