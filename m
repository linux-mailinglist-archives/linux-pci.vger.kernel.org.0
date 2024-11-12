Return-Path: <linux-pci+bounces-16602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FA89C6395
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 22:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D01C285137
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 21:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4EB219E34;
	Tue, 12 Nov 2024 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETc6dUJE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F582170DF;
	Tue, 12 Nov 2024 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447583; cv=none; b=PprZxGhWs3lV3mnvlL/OT8RrJ/hD2zI/JYdLROJyQPh0dkweGiD2W+z+PD7Zx63aqgaqExAvEHaD5y3oRM92d54/HfjFmmYvX0xLkoVS25xM0uVHhqZievbSnM7uSnIAn/46xuHOj7RNvg9/aO2z/tqRfr17iu1O/X2RbGsaPas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447583; c=relaxed/simple;
	bh=bpG4MJZvUxJRhkLBXeVj8tcIV5cdqWVlYHBeL3oM0AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=scIdpljYZT4NwzNbTM7gj3fLXF+hU5EROdianPdOmamiZgXwlb7nM/zYJj4O1QngeO1sWmWQ6qWJJCVtFoh0I3T7y0d15Y7q6E0SkgYka07WxspSgRnL2qg+91973ZkbmPowM7DdA18NQAteqEQQMhnfnjHNu0upzAUXPsI8gwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETc6dUJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D392BC4CECD;
	Tue, 12 Nov 2024 21:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731447583;
	bh=bpG4MJZvUxJRhkLBXeVj8tcIV5cdqWVlYHBeL3oM0AQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ETc6dUJEA/t7MXzRpXRDoNXZ0L/zTFivgsPdv7qn+yxjeZ/O1BJ6MHvV3/2SaUk4A
	 pFEWe+1WGgd/ZcpnUqi/nCPDXM9ADsrWLq2+ZzRQGsuF05d+mmt+Q3vIn72Qz+vjnq
	 HBdBFvcSlQldBlUOs9dw8SKM/IdUXeLjEQi5lAuev8hYrMvF/EBCZ2LyUUGz+en2N+
	 sX3pcd0i4r12d/Hu3HFf+7mlG44TNfbJqXFLBlLV0UhOTD1G/NdzMfhtStJybZzupH
	 6i16xHvL7tc4xWWj9FIFChWwXm3ZwztwodaRihZmQAaAVqZ2SMKlfeQSDHvm3Z7kF2
	 JNNIRcKceo/TQ==
Date: Tue, 12 Nov 2024 15:39:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: lpieralisi@kernel.org, thomas.petazzoni@bootlin.com, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	salee@marvell.com, dingwei@marvell.com
Subject: Re: [PATCH 1/1] PCI: armada8k: Fix bar assignment failure upon rescan
Message-ID: <20241112213941.GA1861660@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112073227.769814-1-jpatel2@marvell.com>

On Mon, Nov 11, 2024 at 11:32:27PM -0800, Jenishkumar Maheshbhai Patel wrote:
> When the attached device recovers the link from
> an external reset, the following error might be
> seen upon pci rescan.
> 
> On link-down event, it's not necessary to remove
> the root bus. Only the child buses or devices
> should be wiped off. However, the rescan operation
> should be performed only when the link could be
> retained. Otherwise, it should be done by a user
> manually after the link is finally recovered.

Wrap to fill 75 columns.

s/pci/PCI/
s/bar/BAR/ (subject)

> ~# echo 1 > /sys/bus/pci/rescan
> [  322.857504] pci 0000:01:00.0: [177d:b200] type 00 class 0x028000
> [  322.863682] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x007fffff 64bit pref]
> [  322.871031] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x0fffffff 64bit pref]
> [  322.878362] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x03ffffff 64bit pref]
> [  322.886845] pci 0000:01:00.0: reg 0x244: [mem 0x00000000-0x000fffff 64bit pref]
> [  322.894193] pci 0000:01:00.0: VF(n) BAR0 space: [mem 0x00000000-0x007fffff 64bit pref] (contains BAR0 for 8 VFs)
> [  322.905154] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x2 link at 0000:00:00.0 (capable of 63.008 Gb/s with 8.0 GT/s PCIe x8 link)
> [  322.921371] pcieport 0000:00:00.0: BAR 15: no space for [mem size 0x18000000 64bit pref]
> [  322.929507] pcieport 0000:00:00.0: BAR 15: failed to assign [mem size 0x18000000 64bit pref]
> [  322.937999] pcieport 0000:00:00.0: BAR 15: no space for [mem size 0x18000000 64bit pref]
> [  322.946131] pcieport 0000:00:00.0: BAR 15: failed to assign [mem size 0x18000000 64bit pref]
> [  322.954614] pci 0000:01:00.0: BAR 2: no space for [mem size 0x10000000 64bit pref]
> [  322.962225] pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x10000000 64bit pref]
> [  322.970193] pci 0000:01:00.0: BAR 4: no space for [mem size 0x04000000 64bit pref]
> [  322.977804] pci 0000:01:00.0: BAR 4: failed to assign [mem size 0x04000000 64bit pref]
> [  322.985766] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00800000 64bit pref]
> [  322.993373] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00800000 64bit pref]
> [  323.001331] pci 0000:01:00.0: BAR 7: no space for [mem size 0x00800000 64bit pref]
> [  323.008938] pci 0000:01:00.0: BAR 7: failed to assign [mem size 0x00800000 64bit pref]
> [  323.016903] pci 0000:01:00.0: BAR 2: no space for [mem size 0x10000000 64bit pref]
> [  323.024511] pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x10000000 64bit pref]
> [  323.032469] pci 0000:01:00.0: BAR 4: no space for [mem size 0x04000000 64bit pref]
> [  323.040079] pci 0000:01:00.0: BAR 4: failed to assign [mem size 0x04000000 64bit pref]
> [  323.048037] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00800000 64bit pref]
> [  323.055644] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00800000 64bit pref]
> [  323.063601] pci 0000:01:00.0: BAR 7: no space for [mem size 0x00800000 64bit pref]
> [  323.071211] pci 0000:01:00.0: BAR 7: failed to assign [mem size 0x00800000 64bit pref]
> [  323.081914] pcieport 0002:02:03.0: devices behind bridge are unusable because [bus 03] cannot be assigned for them
> [  323.092384] pcieport 0002:02:07.0: devices behind bridge are unusable because [bus 04] cannot be assigned for them
> [  323.102857] pcieport 0002:01:00.0: bridge has subordinate 02 but max busn 04

Remove timestamps; they don't help us understand.  We probably don't
need *all* the lines here to understand the problem.

Collect output from current kernel, which should use more useful
labels than "reg 0x10", "BAR 15", etc.

> Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index f9d6907900d1..ca2dedaa69a4 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -231,6 +231,7 @@ static void armada8k_pcie_recover_link(struct work_struct *ws)
>  	struct dw_pcie_rp *pp = &pcie->pci->pp;
>  	struct pci_bus *bus = pp->bridge->bus;
>  	struct pci_dev *root_port;
> +	struct pci_dev *child, *tmp;
>  	int ret;
>  
>  	root_port = pci_get_slot(bus, 0);
> @@ -239,7 +240,14 @@ static void armada8k_pcie_recover_link(struct work_struct *ws)
>  		return;
>  	}
>  	pci_lock_rescan_remove();
> -	pci_stop_and_remove_bus_device(root_port);
> +
> +	/* Remove all devices under root bus */
> +	list_for_each_entry_safe(child, tmp,
> +				 &root_port->subordinate->devices, bus_list) {
> +		pci_stop_and_remove_bus_device(child);
> +		dev_dbg(&child->dev, "removed\n");
> +	}
> +
>  	/* Reset device if reset gpio is set */
>  	if (pcie->reset_gpio) {
>  		/* assert and then deassert the reset signal */
> @@ -279,11 +287,12 @@ static void armada8k_pcie_recover_link(struct work_struct *ws)
>  
>  	/* Wait until the link becomes active again */
>  	if (dw_pcie_wait_for_link(pcie->pci))
> -		dev_err(pcie->pci->dev, "Link not up after reconfiguration\n");
> +		goto fail;
> +
> +	dev_dbg(pcie->pci->dev, "%s: link has been recovered\n", __func__);
>  
> -	bus = NULL;
> -	while ((bus = pci_find_next_bus(bus)) != NULL)
> -		pci_rescan_bus(bus);
> +	/* Rescan the root bus only if link is retained */
> +	pci_rescan_bus(bus);
>  
>  fail:
>  	pci_unlock_rescan_remove();
> -- 
> 2.25.1
> 

