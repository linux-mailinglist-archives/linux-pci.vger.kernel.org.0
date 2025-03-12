Return-Path: <linux-pci+bounces-23542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D68A5E6B4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 22:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71EC1770FB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 21:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6801E8327;
	Wed, 12 Mar 2025 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDGGa/Jv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0270810;
	Wed, 12 Mar 2025 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815480; cv=none; b=m6W8zs/ndqONq9lgEyomI+wGrEXU2BpxgZLREfqwpQRHQq6TNrfm91mmQCgoGIYw4VlIKjwqjzTGdJ0ffPP79tVRG6BcLbIPglPitgB8auVHC4xFBfcDQ2/g9Cjf/gO39KuwqSM7wyHj0MeCDEe6i0ao+Gwm/33qJvWQX7J20PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815480; c=relaxed/simple;
	bh=IpQ0kTcSTHlo9xweNH6Hk4r0BhULhn+PB1miZjUBO1A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gs/WAqLQBbb5c5e6zo/3VUvvuBqoK5C8LZDN/1POsA6O3hya2bcwpelEMR0+eEytve95CHLRG98q2yGCXY3tPGqLSA0497ikqwB9da0GfiaReP24IQ5XmuWzDlnecBlLYsihfCLcvb+9fKxjd/hYgNnkNHQnurI+ETudNTr2lTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDGGa/Jv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDB7C4CEDD;
	Wed, 12 Mar 2025 21:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741815479;
	bh=IpQ0kTcSTHlo9xweNH6Hk4r0BhULhn+PB1miZjUBO1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MDGGa/Jv/K0Tp8ERu+/t3wzW7sjaxvdm9hxpl+5UoReGjOfXsZEUMLmJ8i5MVeMlV
	 XeA2C97XH7anXUQGlEE6SVvRhIpLBl6pFfLAthj7lAZp2C/dYWR+GBTD8nDhKwCYgq
	 tqZrUMIgKxpAaqBqF7lZbO2x/MYwf3dUppQaR+iG91sfhT26Xvv+Dolr56QGJTzjWK
	 L14bZ23veCU1pLPH6jgX33hOxtSCx0yGUzkww9EokaA9s7HtG6sFGbrpf0+QH0d1ly
	 vjv1AmRcos0k3ivTC+xpEoQzszFTjEn4n8//t5lilrs56r1+8LwrvgJlXovRdze1/b
	 +qD7qbsLoY/zg==
Date: Wed, 12 Mar 2025 16:37:57 -0500
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
Subject: Re: [PATCH v10 05/10] PCI: dwc: Use devicetree 'ranges' property to
 get rid of cpu_addr_fixup() callback
Message-ID: <20250312213757.GA709739@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-pci_fixup_addr-v10-5-409dafc950d1@nxp.com>

On Mon, Mar 10, 2025 at 04:16:43PM -0400, Frank Li wrote:
> parent_bus_offset in resource_entry can indicate address information just
> ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> map. See below diagram:

> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -478,6 +478,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	bridge->ops = &dw_pcie_ops;
>  	bridge->child_ops = &dw_child_pcie_ops;
>  
> +	/*
> +	 * visconti_pcie_cpu_addr_fixup() use pp->io_base,
> +	 * so have to call dw_pcie_init_parent_bus_offset() after init
> +	 * pp->io_base.
> +	 */
> +	ret = dw_pcie_init_parent_bus_offset(pci, "config", pp->cfg0_base);
> +	if (ret)
> +		return ret;

The ordering in dw_pcie_host_init() doesn't look right to me.  We have
this:

  dw_pcie_host_init
    dw_pcie_get_resources
    dw_pcie_cfg0_setup
    devm_pci_alloc_host_bridge
    win = resource_list_first_type(&bridge->windows, IORESOURCE_IO)
    pp->io_base = pci_pio_to_address(win->res->start)
    bridge->ops = ...
    bridge->child_ops = ...
    dw_pcie_init_parent_bus_offset
    pp->ops->init

devm_pci_alloc_host_bridge() is generic, so it obviously can't depend
on any dwc-specific things.  I think the ordering should be more like
this:

  dw_pcie_host_init
    devm_pci_alloc_host_bridge             # generic
    dw_pcie_get_resources                  # dwc RP and EP

    dw_pcie_cfg0_setup
    win = resource_list_first_type(&bridge->windows, IORESOURCE_IO)
    pp->io_base = pci_pio_to_address(win->res->start)
    dw_pcie_init_parent_bus_offset

    bridge->ops = ...
    bridge->child_ops = ...
    pp->ops->init

and everything in the second block (dw_pcie_cfg0_setup() through
dw_pcie_init_parent_bus_offset()) is strictly DT-related resource
setup and could all go in a dw_pcie_host_get_resources() or similar.

>  	if (pp->ops->init) {
>  		ret = pp->ops->init(pp);
>  		if (ret)
> 
> -- 
> 2.34.1
> 

