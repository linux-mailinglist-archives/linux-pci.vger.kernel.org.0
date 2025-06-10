Return-Path: <linux-pci+bounces-29362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72140AD4282
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 21:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C9117BACF
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 19:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE72425CC5E;
	Tue, 10 Jun 2025 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBpHdltk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958702F85B;
	Tue, 10 Jun 2025 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582440; cv=none; b=OcZ2UoxJa6wC2XuuDnHibxQeGmLoJRnLyVxkRvBu64XeRrDEhscg4Wc50VYyU574+C8c+Mxa7Ra7xP7D1FGVOZi3vljN+PbijSF5Ktf7IqKOYwspgySGS+oyNePQYiV5wpSBQ7N/A95Kg8fQaa6KR2Fx8zf760fGCxCCw9QPzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582440; c=relaxed/simple;
	bh=AIvP26P9xWUqLZxFjmwu8G6XBOhcEd6iXdkzctN/muI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D+Ba4X0MOafeRNQitDGawHhmEcgy0AoUBB7R7jBzxZeNYgifx6M13jdHNsXzDOa9eVesaob+PFimt0mSYxg50PRD3B77k1GnFkCIzPvnciJ8C2nptoCZcDM/r6WbwZHnYxra6A3NBmuIvvuibvlfKiC3nmyTc6Kea4uOz/rjO0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBpHdltk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EE7C4CEED;
	Tue, 10 Jun 2025 19:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749582440;
	bh=AIvP26P9xWUqLZxFjmwu8G6XBOhcEd6iXdkzctN/muI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PBpHdltkX2oPZwR7aSMe5LjC6PDQ1XOhKgDblLfhZnX8RMczs+FiviOhjYb/f+tVj
	 2CMjcuBLbDn4SJkHn0jrUPTVJ7X3Uj8EUYziJtLB1PRn1Kq1ilG/ONHdN2TTBiNFEM
	 s+jFUhX/io9IMEqUMfHz+vZiyx9/Yv2x+bx6g8RjUXG1zhmHUbYNu0JbCzfOSKojdv
	 flMEos1Fn4hq46QhT04z1cBUVYCm7GJicTEuSk8aUF2X1kSYmpltcchTiYgPWyCSfC
	 dvdA2QSXIxlDw4NzdwG/d53nGBrLmYi6gvFo42TD3RRwLu93G89nrriARar4mkpWqF
	 Y3UyVfTvo2H9g==
Date: Tue, 10 Jun 2025 14:07:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI: xilinx: Support reset GPIO for PERST#
Message-ID: <20250610190718.GA819844@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610143919.393168-2-mike.looijmans@topic.nl>

On Tue, Jun 10, 2025 at 04:39:04PM +0200, Mike Looijmans wrote:
> Support providing the PERST# reset signal through a devicetree binding.
> Thus the system no longer relies on external components to perform the
> bus reset.

> @@ -576,11 +577,17 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct xilinx_pcie *pcie;
>  	struct pci_host_bridge *bridge;
> +	struct gpio_desc *perst_gpio;
>  	int err;
>  
>  	if (!dev->of_node)
>  		return -ENODEV;
>  
> +	perst_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(perst_gpio))
> +		return dev_err_probe(dev, PTR_ERR(perst_gpio),
> +				     "Failed to request reset GPIO\n");
> +
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>  	if (!bridge)
>  		return -ENODEV;
> @@ -595,6 +602,13 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> +	if (perst_gpio) {
> +		msleep(PCIE_T_PVPERL_MS); /* Minimum assertion time */
> +		gpiod_set_value_cansleep(perst_gpio, 0);

Are we assured that PERST# was already asserted when we entered
xilinx_pcie_probe()?

> +		/* Initial delay to provide endpoint time to initialize */
> +		msleep(PCIE_T_RRS_READY_MS);

I don't think this is the right spot for PCIE_T_RRS_READY_MS, details
in https://lore.kernel.org/r/20250610185734.GA819344@bhelgaas

I guess the spec assumes that for ports that don't support speeds
greater than 5.0 GT/s, 100ms is enough for the link to come up *and*
the endpoint to initialize.  But since you're going to wait for the
link to come up immediately *after* this PCIE_T_RRS_READY_MS sleep, I
would think you could extend the timeout in xilinx_pci_wait_link_up()
and then do the PCIE_T_RRS_READY_MS sleep.

