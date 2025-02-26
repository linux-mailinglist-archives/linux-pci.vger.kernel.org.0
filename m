Return-Path: <linux-pci+bounces-22470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE85A46F81
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 00:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC403ABE64
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 23:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE152620CE;
	Wed, 26 Feb 2025 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mph1cYH0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B62620C8;
	Wed, 26 Feb 2025 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612823; cv=none; b=ToNiWlKcWU+ClqUp9ifJZDA5ELImfj4Q0LQO2H06QqR68YEPlWrHDUoLCyaV2UaigmrKegAbvBRsxuFSN9LzFT3lhQzgoR+I07MI8yAj5lB99jAjM9jwvrMIMY064fpYsyocTF/Ke8DQFPhWQZZs5QSTLws6v5h85CrZqlUzP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612823; c=relaxed/simple;
	bh=JU2kjfLvtCKvCAcKZzE2OOPkpTNFwZNgTF7Ciu+cRA4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ehWFxzqKcU4ucnBUvvVcycE+IU/o1tBv58OVQ6eHXbXhFliDA3StmAd1ZXkuReM6i4Z4CFAxTOPgr5c+RU4cDdyyOvpfgzasnZfFGxzs9TXqmaic/sCoRf69m5/KT/lyXP9PKe7SoBctAOG18S6ZAqsS/7aZy2SckzARYGCjnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mph1cYH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD53C4CED6;
	Wed, 26 Feb 2025 23:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740612822;
	bh=JU2kjfLvtCKvCAcKZzE2OOPkpTNFwZNgTF7Ciu+cRA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mph1cYH0/GtxEnkYNjCOOhVVx56YpsQjSOk1NStNxEAjASxrD7HdP89Eu4QiFsjQp
	 FaY8Xks0fxxWsXbG0tGc1hVg1E8MwdMRqFTK8X7jjvATAcXjECwZqgiyPCvT3dHxUt
	 qW1qWzKdtvNXzRAGOsnQSV66plI7HGitg8nnLwYby1irqcym0luHmdV+wN76k2JwOm
	 iR34vJbsDmq6bIXion0gGlpstWi49EKe12WKUXlHfzk0KtCantRd19Hb9ATkeh73Qx
	 sOq2e+gAUnuYFRHoKt4gCCqbzhMUX33KGRP89sfavZuSOlnmEtXD32v2ULnB/BGLti
	 +yYugUjDQL0qQ==
Date: Wed, 26 Feb 2025 17:33:39 -0600
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
Subject: Re: [PATCH v9 4/7] PCI: dwc: Use devicetree 'ranges' property to get
 rid of cpu_addr_fixup() callback
Message-ID: <20250226233339.GA562682@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-pci_fixup_addr-v9-4-3c4bb506f665@nxp.com>

On Tue, Jan 28, 2025 at 05:07:37PM -0500, Frank Li wrote:
> parent_bus_offset in resource_entry can indicate address information just
> ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> map. See below diagram:
> ...

> @@ -448,6 +451,26 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (IS_ERR(pp->va_cfg0_base))
>  		return PTR_ERR(pp->va_cfg0_base);
>  
> +	if (pci->use_parent_dt_ranges) {
> +		if (pci->ops->cpu_addr_fixup) {
> +			dev_err(dev, "Use parent bus DT ranges, cpu_addr_fixup() must be removed\n");
> +			return -EINVAL;
> +		}
> +
> +		index = of_property_match_string(np, "reg-names", "config");
> +		if (index < 0)
> +			return -EINVAL;
> +
> +		 /*
> +		  * Retrieve the parent bus address of PCI config space.
> +		  * If the parent bus ranges in the device tree provide
> +		  * the correct address conversion information, set
> +		  * 'use_parent_dt_ranges' to true, The
> +		  * 'cpu_addr_fixup()' can be eliminated.
> +		  */
> +		of_property_read_reg(np, index, &pp->cfg0_base, NULL);
> +	}

I think all this code dealing with the "config" resource could go in a
helper function.  It's kind of a lot of clutter in
dw_pcie_host_init().

It would be nice to assign pp->cfg0_base once, not assign res->start
to it and then possibly overwrite it later.

> @@ -841,6 +841,15 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  	pci->region_align = 1 << fls(min);
>  	pci->region_limit = (max << 32) | (SZ_4G - 1);
>  
> +	if (pci->ops && pci->ops->cpu_addr_fixup) {
> +		/*
> +		 * If the parent 'ranges' property in DT correctly describes
> +		 * the address translation, cpu_addr_fixup() callback is not
> +		 * needed.
> +		 */
> +		dev_warn_once(pci->dev, "cpu_addr_fixup() usage detected. Please fix DT!\n");
> +	}

Can you split the warnings out to a separate patch?  I think we should
warn once in every initialization path where .cpu_addr_fixup() could
be used, i.e.,

  dw_pcie_host_init()
  dw_pcie_ep_init()
  cdns_pcie_host_setup()
  cdns_pcie_ep_setup()

IMO these should warn if .cpu_addr_fixup() is implemented, regardless
of use_parent_dt_ranges.

I'm still puzzling over some of the rest of this, so no need to post a
revised series yet.

Bjorn

