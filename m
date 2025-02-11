Return-Path: <linux-pci+bounces-21221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB65BA316A2
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B47188A4E1
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965DF262D0F;
	Tue, 11 Feb 2025 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azvTjfJZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3C1D8DF6;
	Tue, 11 Feb 2025 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305709; cv=none; b=GXPnGZLoHPF7MNYjuegmdlGkZZaJy+HyZAUq8j/zxSVA2Mht1LRbBpelZ0VAH6vHdJguO+QADGt9GFTwhjIvAHxLDnqyAHlboEn//Sf/IMafvAUPCecxWCkCO8Woa8iyMvZPrpp3MgCNgaJz3NzGkUXgEcClHnpKW959IUkV4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305709; c=relaxed/simple;
	bh=PorxhQhKaeA4sE5AZrSXMieeD8CtaoH/d52ZQgaCyTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R17Pd1y1JJqw07XtymGk7jgHjYZ5AU/PCtsWThG4s3EzBTWc0DFLH5SE/iE/vSa32knJhq8qM5imxtpSx84brQhocpg1avhe4W/msNssPIJQthnXOdgnXRdOY/2OlkZSN9Bg1dp0hVogdjuq9bPktbt2b12JBS6umUtr9AUq0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azvTjfJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2643FC4CEDD;
	Tue, 11 Feb 2025 20:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739305709;
	bh=PorxhQhKaeA4sE5AZrSXMieeD8CtaoH/d52ZQgaCyTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=azvTjfJZxWlUxUbpjz7qqIi2vW3to74F+MVLnsHdmAiRXYbf43SmlZUFedUj2iRKs
	 cgOx0VcObG25xO9qCUOUR6BpLqSKNrIq2KtAK32mRj9gwBQsQpamJIUtzQhYeqBWS2
	 eYDjBC6XQSzQPOFSYApYbWza7VQzMHCkNWoaeQfhCdCsXcEZntmeNTxikxNfjdKq4l
	 sD1URsFQqS5PvoTCyCl0sdi04oQ9xww9k0CKHm5UzqcKwQM6Wry/bbnU67IhGBrHbs
	 dLJbWOqBc1KLcpsdIh97xM3A2+o4EwJT06Mf0Nrf0QYrzhxiUIKiucrGNRJTGQ2a9T
	 iHq7SjfSHyjZw==
Date: Tue, 11 Feb 2025 14:28:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v7 03/17] CXL/PCI: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
Message-ID: <20250211202827.GA53859@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-4-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:30PM -0600, Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices and CXL port
> devices.
> 
> First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
> presence. The CXL Flexbus DVSEC presence is used because it is required
> for all the CXL PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> Flexbus presence.
> 
> Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl'.
> 
> Add pcie_is_cxl_port() to check if a device is a CXL Root Port, CXL
> Upstream Switch Port, or CXL Downstream Switch Port. Also, verify the
> CXL Extensions DVSEC for Ports is present.[1]
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

But I would change the subject to:

  PCI/CXL: ...

since this only changes drivers/pci files.

> ---
>  drivers/pci/pci.c             | 13 +++++++++++++
>  drivers/pci/probe.c           | 10 ++++++++++
>  include/linux/pci.h           |  5 +++++
>  include/uapi/linux/pci_regs.h |  3 ++-
>  4 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..a2d8b41dd043 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5032,6 +5032,19 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
>  					 PCI_DVSEC_CXL_PORT);
>  }
>  
> +inline bool pcie_is_cxl(struct pci_dev *pci_dev)
> +{
> +	return pci_dev->is_cxl;
> +}
> +
> +bool pcie_is_cxl_port(struct pci_dev *dev)
> +{
> +	if (!pcie_is_cxl(dev))
> +		return false;
> +
> +	return (cxl_port_dvsec(dev) > 0);
> +}
> +
>  static bool cxl_sbr_masked(struct pci_dev *dev)
>  {
>  	u16 dvsec, reg;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b6536ed599c3..7737b9ce7a83 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1676,6 +1676,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  		dev->is_thunderbolt = 1;
>  }
>  
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					      PCI_DVSEC_CXL_FLEXBUS);
> +	if (dvsec)
> +		dev->is_cxl = 1;
> +}
> +
>  static void set_pcie_untrusted(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent = pci_upstream_bridge(dev);
> @@ -2006,6 +2014,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* Need to have dev->cfg_size ready */
>  	set_pcie_thunderbolt(dev);
>  
> +	set_pcie_cxl(dev);
> +
>  	set_pcie_untrusted(dev);
>  
>  	if (pci_is_pcie(dev))
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1d62e785ae1f..82a0401c58d3 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -452,6 +452,7 @@ struct pci_dev {
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
>  	/*
>  	 * Devices marked being untrusted are the ones that can potentially
>  	 * execute DMA attacks and similar. They are typically connected
> @@ -741,6 +742,10 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>  	return false;
>  }
>  
> +bool pcie_is_cxl(struct pci_dev *pci_dev);
> +
> +bool pcie_is_cxl_port(struct pci_dev *dev);
> +
>  #define for_each_pci_bridge(dev, bus)				\
>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
>  		if (!pci_is_bridge(dev)) {} else
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 3445c4970e4d..dbc0f23d8c82 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1208,9 +1208,10 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> +/* Compute Express Link (CXL r3.1, sec 8.1) */
>  #define PCI_DVSEC_CXL_PORT				3
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +#define PCI_DVSEC_CXL_FLEXBUS				7
>  
>  #endif /* LINUX_PCI_REGS_H */
> -- 
> 2.34.1
> 

