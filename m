Return-Path: <linux-pci+bounces-44302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDE3D062CB
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 21:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71CB7302758F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 20:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD704331222;
	Thu,  8 Jan 2026 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjSg9NeT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56FF330D58;
	Thu,  8 Jan 2026 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767905740; cv=none; b=QbSr3HCC9+lgCUa0JRyxmUVaszSK57QlSlHZetDyleJfo4Yn+xveQO6fH3KeXt/9l9YJ4oZMQHJvfdGirOZ6j7guCiYyW/OFewW6yd0salFRdHDQR/5TiUKsGK0okZ4aIYHIIPll0M/yCiKAKsuVE2jwDoI0kBDB/XCH8FBQufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767905740; c=relaxed/simple;
	bh=xBJe/1TFcmT6ykWBd9m6VDk/sy5CDIe6A5UhmE5fQMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTmE/PVjCtmhNjdG6fyjOlh19PSd9lfdjxWmQC9b3P+r99O1315zh69YxsqaP/wLMhx2hu9MkJj9hD2A7fU3TQZk5l+sqk+UWRKwGw4LcXnvUk0eIsDlxPQXqmcsH7i0j64KOmkITPVY+wUYaD+WXkkiF8y9HEgbf4ms8SVeN3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjSg9NeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B290C116C6;
	Thu,  8 Jan 2026 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767905740;
	bh=xBJe/1TFcmT6ykWBd9m6VDk/sy5CDIe6A5UhmE5fQMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjSg9NeThhyh+++t7oDphRi9jrjfHMpyjFOTzaeh0gYoZ3izGVjS4O26bFUA1QUvm
	 J3SqsMuOQCewM7IKUQ96hK2KMq/kcHx9beh18yud/0R4cTYRVZLISqCM0zEThG8jQ+
	 h5AYr5uN46Rj5jEJLWP1pW79KbPjBYUs+2Un3MzTPCOu3AXqD7aNoNxS/PtrsiFlh/
	 hahC8p89QMUHjsXVrAsAGZl/GL0U9LcdaKzZNuS74lwloUO1xDsSnYzTWALX39Z9GL
	 rvyrOUOB/9IfhehMJlaoXTpriWA0L1IpI4LhNpjLMymvGJSP5UfbZz9Kzfuz+mPimt
	 U7lpSI5WgMQxg==
Date: Thu, 8 Jan 2026 21:55:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	vigneshr@ti.com, s-vadapalli@ti.com, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com, roy.zang@nxp.com, jesper.nilsson@axis.com,
	heiko@sntech.de, srikanth.thokala@intel.com,
	marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	christian.bruel@foss.st.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org, kishon@kernel.org, jirislaby@kernel.org,
	rongqianfeng@vivo.com, 18255117159@163.com,
	shawn.lin@rock-chips.com, nicolas.frattaroli@collabora.com,
	linux.amoon@gmail.com, vidyas@nvidia.com, Frank.Li@nxp.com,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v5 3/3] PCI: dwc: ep: Support BAR subrange inbound
 mapping via Address Match Mode iATU
Message-ID: <aWAZv3ZwdUmo4_wc@ryzen>
References: <20260108172403.2629671-1-den@valinux.co.jp>
 <20260108172403.2629671-4-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108172403.2629671-4-den@valinux.co.jp>

Hello Koichiro,

On Fri, Jan 09, 2026 at 02:24:03AM +0900, Koichiro Den wrote:

(snip)

> +/* Address Match Mode inbound iATU mapping */
> +static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
> +				  const struct pci_epf_bar *epf_bar)
> +{
> +	const struct pci_epf_bar_submap *submap = epf_bar->submap;
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar = epf_bar->barno;
> +	struct device *dev = pci->dev;
> +	u64 pci_addr, parent_bus_addr;
> +	struct dw_pcie_ib_map *new;
> +	u64 size, off, base;
> +	unsigned long flags;
> +	int free_win, ret;
> +	unsigned int i;
> +
> +	if (!epf_bar->num_submap || !submap || !epf_bar->size)
> +		return -EINVAL;
> +
> +	ret = dw_pcie_ep_validate_submap(ep, submap, epf_bar->num_submap,
> +					 epf_bar->size);
> +	if (ret)
> +		return ret;
> +
> +	base = dw_pcie_ep_read_bar_assigned(ep, func_no, bar, epf_bar->flags);
> +	if (!base) {
> +		dev_err(dev,
> +			"BAR%u not assigned, cannot set up sub-range mappings\n",
> +			bar);
> +		return -EINVAL;
> +	}

Sorry for giving additional review comments.

But there is one thing that I might not be so obvious for someone just
reading this source. How is this API supposed to be used in practice?

Most DWC-based controllers are not hotplug capable.

That means that we must boot the EP, create the EPF symlink in configfs,
and start link training by writing to configfs, before starting the host.

dw_pcie_ep_ib_atu_addr() reads the PCI address that the host has assigned
to the BAR, and returns an error if the host has not already assigned a
PCI addres to the BAR.

Does that mean that the usage of this API will be something like:

1) set_bar() ## using BAR match mode, since BAR match mode can write
   the BAR mask to define a BAR size, so that the host can assign a
   PCI address to the BAR.

2) start() ## start link

3) link up

4) wait for some special command, perhaps NTB_EPF_COMMAND
CMD_CONFIGURE_DOORBELL or NTB_EPF_COMMAND CMD_CONFIGURE_MW

5) set_bar() ## using Address match mode. Because address match mode
   requires that the host has assigned a PCI address to the BAR, we
   can only change the mapping for a BAR after the host has assigned
   PCI addresses for all bars.



Perhaps you should add some text to:
Documentation/PCI/endpoint/pci-endpoint.rst

Because right now the documentation for pci_epc_set_bar() says:

   The PCI endpoint function driver should use pci_epc_set_bar() to configure
   the Base Address Register in order for the host to assign PCI addr space.
   Register space of the function driver is usually configured
   using this API.

So it is obviously meant to be called *before* the host assigns a PCI
address for the BAR. Now with submap ranges, it appears that it has to
be called *after* the host assigned a PCI address for the BAR.

So I can only assume that you will call set_bar() twice.
Once with BAR match mode, and then a second time with address map mode.

It might be obvious to you, but I think it makes sense to also have some
kind of documentation for this feature.


Kind regards,
Niklas

