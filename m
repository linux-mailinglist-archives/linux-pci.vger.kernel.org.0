Return-Path: <linux-pci+bounces-22475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6A5A47025
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 01:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5FF07A7273
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 00:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA70F323D;
	Thu, 27 Feb 2025 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tL83cyzx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7767BA47;
	Thu, 27 Feb 2025 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615809; cv=none; b=mjePfhGod1u+1VwHyoY7EOhoOqilF5BPavn9HTSLmqXj5ciilb2fNug+3sswYrA3YebEEiSMXScZu0mIe23TdYVoliFRPhHI5OEEhdfhg6JQ1ObjqxLuhmp991WER3vsDNRxWIcNAPD00ubt32f8Da2FSpDNw5stmJ1by0cCQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615809; c=relaxed/simple;
	bh=Snbn7RL/BEWOlEKJMOnfQXtsEkFO1ZODqdbhYhfuwis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JAn/S7ep1sZrxVCKhwszsFQIt4s7m+j+2FUwojgzGWfvhSO2dPMYRKs01pfk4drWKRRFD29yBbSg7JFlTFeTJw23YZgwe8cWqqPcxRf9IhgsgwWz0pOeBv1T57ewveX8G1t21adl3C/7lsW/XGmHGeHyVKDnO9eKYN6tdHSj100=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tL83cyzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E91C4CED6;
	Thu, 27 Feb 2025 00:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740615808;
	bh=Snbn7RL/BEWOlEKJMOnfQXtsEkFO1ZODqdbhYhfuwis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tL83cyzxc1jmWFi+Npy+ataI7BSMe3WmInn/gZ433hDXbfcUXE43I1HFOv1mKSDWe
	 R/TFB1Y9hNmlzeSjIGXMoN8W7IC6rVYbyd1y7+fccn56zqBsfk2eok2QCDSkA+wKOs
	 Vgin+CiJAEZyxgCZE4vw4l7TrWuolCUeRW3QXgWQSn++AUAFdEvoL4P9n3swqBWzxs
	 jWySl0T4WQ9LQIg4poVHPxMxnIi68JL9rxSVx0uRSJOKynxbfviWne7o5czp4jxMQs
	 vfdNO2dsIFSz4HFDF1jUDeopba30bsGitUiyXKL864E4UsNQ0EDs9pppksASriq5hb
	 s1VOyJ48mrG8A==
Date: Wed, 26 Feb 2025 18:23:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 3/7] PCI: Add parent_bus_offset to resource_entry
Message-ID: <20250227002326.GA566507@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-pci_fixup_addr-v9-3-3c4bb506f665@nxp.com>

On Tue, Jan 28, 2025 at 05:07:36PM -0500, Frank Li wrote:
> Introduce `parent_bus_offset` in `resource_entry` and a new API,
> `pci_add_resource_parent_bus_offset()`, to provide necessary information
> for PCI controllers with address translation units.
> 
> Typical PCI data flow involves:
>   CPU (CPU address) -> Bus Fabric (Intermediate address) ->
>   PCI Controller (PCI bus address) -> PCI Bus.
> 
> While most bus fabrics preserve address consistency, some modify addresses
> to intermediate values. The `parent_bus_offset` enables PCI controllers to
> translate these intermediate addresses correctly to PCI bus addresses.
> 
> Pave the road to remove hardcoded cpu_addr_fixup() and similar patterns in
> PCI controller drivers.
> ...

> +++ b/drivers/pci/of.c
> @@ -402,7 +402,17 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  			res->flags &= ~IORESOURCE_MEM_64;
>  		}
>  
> -		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
> +		/*
> +		 * IORESOURCE_IO res->start is io space start address.
> +		 * IORESOURCE_MEM res->start is cpu start address, which is the
> +		 * same as range.cpu_addr.
> +		 *
> +		 * Use (range.cpu_addr - range.parent_bus_addr) to align both
> +		 * IO and MEM's parent_bus_offset always offset to cpu address.
> +		 */
> +
> +		pci_add_resource_parent_bus_offset(resources, res, res->start - range.pci_addr,
> +						   range.cpu_addr - range.parent_bus_addr);

I don't know exactly where it needs to go, but I think we can call
.cpu_addr_fixup() once at startup on the base of the region.  This
will tell us the offset that applies to the entire region, i.e.,
parent_bus_offset.

Then we can remove all the .cpu_addr_fixup() calls in
cdns_pcie_host_init_address_translation(),
cdns_pcie_set_outbound_region(), and dw_pcie_prog_outbound_atu().

Until we can get rid of all the .cpu_addr_fixup() implementations,
We'll still have that single call at startup (I guess once for cadence
and another for designware), but it should simplify the current
callers quite a bit.

>  	}
>  
>  	/* Check for dma-ranges property */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 47b31ad724fa5..0d7e67b47be47 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1510,6 +1510,8 @@ static inline void pci_release_config_region(struct pci_dev *pdev,
>  void pci_add_resource(struct list_head *resources, struct resource *res);
>  void pci_add_resource_offset(struct list_head *resources, struct resource *res,
>  			     resource_size_t offset);
> +void pci_add_resource_parent_bus_offset(struct list_head *resources, struct resource *res,
> +					resource_size_t offset, resource_size_t parent_bus_offset);
>  void pci_free_resource_list(struct list_head *resources);
>  void pci_bus_add_resource(struct pci_bus *bus, struct resource *res);
>  struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);
> diff --git a/include/linux/resource_ext.h b/include/linux/resource_ext.h
> index ff0339df56afc..b6ec6cc318203 100644
> --- a/include/linux/resource_ext.h
> +++ b/include/linux/resource_ext.h
> @@ -24,6 +24,7 @@ struct resource_entry {
>  	struct list_head	node;
>  	struct resource		*res;	/* In master (CPU) address space */
>  	resource_size_t		offset;	/* Translation offset for bridge */
> +	resource_size_t		parent_bus_offset; /* Parent bus address offset for bridge */
>  	struct resource		__res;	/* Default storage for res */
>  };
>  
> 
> -- 
> 2.34.1
> 

