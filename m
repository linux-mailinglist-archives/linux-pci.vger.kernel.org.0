Return-Path: <linux-pci+bounces-44342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC20FD07D75
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 09:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F31203017387
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 08:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17A233F8DD;
	Fri,  9 Jan 2026 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaHmVdUw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5793002D8;
	Fri,  9 Jan 2026 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947417; cv=none; b=dQwjZ+KSmAYScKBoZiSV2AQuwSXSvOa2bMUc4vGrQQJDSUXhdzVGEwY56WsoHiXoO/RWM6ynIZ3x2fR8b9MQlnyFBG09FoPqYWRs6QtT5FYWXjyspnUEoLGYpFv93EQVQSsQVCqwbVUsEhAw1iX1arufxG2QOxINEn6TL38s/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947417; c=relaxed/simple;
	bh=3Y/4K7MdRQsPCaqilZFCu7ZODfNDBbKlBmqwPSVOHE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s33D3PpzsQGPGiv5MhIFJw2ZEWRoJ+amQq78BnByhvwWDWasaA434BuxKtLabLBx5EhxCasQc60OdWZswKF4Qc1SMF3mvO7ihANU1U3NJKcT1gO3Ol2lRzhDy0jYFvse9jdnKnEbhTbxItxazKXwVo9TcC9YocUMYVpp/2N8njY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaHmVdUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929F2C4CEF1;
	Fri,  9 Jan 2026 08:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767947416;
	bh=3Y/4K7MdRQsPCaqilZFCu7ZODfNDBbKlBmqwPSVOHE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KaHmVdUwZWxvuB7ircX7ZztfhNCS1a9BTb6T0uPs+Q8BKvaZCbB+xYdh0efbbA/BR
	 bkIBdQCmh2pdinGW6ArMfuOO6fvAaC1nJbcezIMdkn2kzkbHwDwRFXL2OpiN19nk8N
	 4igYJU5hWPQG9zpkf1UjRb9Issh9v819ZcqIFnR52+WTmYfRzEv07jzrVDy/GKTXyi
	 Y5gf1lPSGGMTiKQqntrZ6xy4Or5V7cJVR+A/Mo2DBg60Vo6XrD+dgWiMldLe/rBdU2
	 SJIPFSwArTjX0JW+7sHkCG2FBzFloJGX/CmtARnJdYrNMmKN9qvU6cFpl6PtI7O/ep
	 fOAbK1oUz946A==
Date: Fri, 9 Jan 2026 09:30:04 +0100
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
Message-ID: <aWC8jGTtKIzVuG-X@ryzen>
References: <20260108172403.2629671-1-den@valinux.co.jp>
 <20260108172403.2629671-4-den@valinux.co.jp>
 <aWAZv3ZwdUmo4_wc@ryzen>
 <nqpwi6ewen4kf7jqgon4ljerceqjeaule25dzb6ytas3wslqhp@ddkr3jum6eac>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nqpwi6ewen4kf7jqgon4ljerceqjeaule25dzb6ytas3wslqhp@ddkr3jum6eac>

On Fri, Jan 09, 2026 at 04:29:14PM +0900, Koichiro Den wrote:
> > Does that mean that the usage of this API will be something like:
> > 
> > 1) set_bar() ## using BAR match mode, since BAR match mode can write
> >    the BAR mask to define a BAR size, so that the host can assign a
> >    PCI address to the BAR.
> 
> BAR sizing is done by dw_pcie_ep_set_bar_{programmable,resizable}() before
> iATU programming regardless of match mode. I keep BAR match mode here just
> because Address match mode requires a valid base address. That's why I
> added the `if (!base)` guard.
> 
> > 
> > 2) start() ## start link
> > 
> > 3) link up
> > 
> > 4) wait for some special command, perhaps NTB_EPF_COMMAND
> > CMD_CONFIGURE_DOORBELL or NTB_EPF_COMMAND CMD_CONFIGURE_MW
> > 
> > 5) set_bar() ## using Address match mode. Because address match mode
> >    requires that the host has assigned a PCI address to the BAR, we
> >    can only change the mapping for a BAR after the host has assigned
> >    PCI addresses for all bars.
> > 
> 
> The overall usage flow matches what I'm assuming.

Ok, perhaps document something that the submap feature requires that the
BAR already has been assigned an address (and that it thus has to call
set_bar() twice, without calling clear_bar() in-between.

This is a new feature, and since you provide a mapping for the whole BAR,
I think it is logical for people to incorrectly assume that you could use
this feature by just calling set_bar() once.


> > Perhaps you should add some text to:
> > Documentation/PCI/endpoint/pci-endpoint.rst
> > 
> > Because right now the documentation for pci_epc_set_bar() says:
> > 
> >    The PCI endpoint function driver should use pci_epc_set_bar() to configure
> >    the Base Address Register in order for the host to assign PCI addr space.
> >    Register space of the function driver is usually configured
> >    using this API.
> > 
> > So it is obviously meant to be called *before* the host assigns a PCI
> > address for the BAR. Now with submap ranges, it appears that it has to
> > be called *after* the host assigned a PCI address for the BAR.
> 
> I agree. As I understand it, the current text seems not to reflect mainline
> since commit 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar()
> update inbound map address"), but anyway I should add explicit
> documentation for this subrange mapping use case.

Sure, 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update
inbound map address") modified so that set_bar() can be called twice,
without calling clear_bar().

However, that patch was a mess because:
1) It got merged via the NTB tree, even though the PCI maintainer wanted a
   different design:
   https://lore.kernel.org/linux-pci/20220818060230.GA12008@thinkpad/T/#m411b3e9f6625da9dde747f624ed6870bef3e8823
2) It was buggy:
   https://github.com/torvalds/linux/commit/c2a57ee0f2f1ad8c970ff58b78a43e85abbdeb7f
3) It lacked the proper conditional checks for the feature to work (and it
   lacked any comments in the source explaining why it was skipping steps):
   https://github.com/torvalds/linux/commit/3708acbd5f169ebafe1faa519cb28adc56295546
4) It failed to update the documentation.
5) It failed to add a new flag for this feature in epc_features.
   I seriously doubt that any non-DWC based EP controller supports changing
   the inbound address translations without first disabling the BAR.
   (It probably should have added a epc_features->dynamic_inbound_mapping bit.)


So all in all 4284c88fff0e in not the best example :)


Your new feature (epc_features->subrange_mapping) in epc_features appears
to depend on epc_features->dynamic_inbound_mapping, so it is a shame that
we don't have a epc_features->dynamic_inbound_mapping bit, so that this new
feature could have depended on that bit.

	if (epf_bar->use_submap &&
	    !(epc_features->dynamic_inbound_mapping &&
	      epc_features->subrange_mapping))
		return -EINVAL;


I think adding some documentation is a good step.

Perhaps we should also introduce a epc_features->dynamic_inbound_mapping bit?
Since you are making DWC glue drivers return a mutable EPC features, we could
set this bit in the DWC driver after that commit. What do you think?

I realize that we would not be able to add any actual verification for the
epc_features->dynamic_inbound_mapping feature itself (in set_bar()), since
there is no way for set_bar() to know if a BAR has already been configured
(since struct pci_epc does not have an array of the currently configured BARs).

But at least it would allow an EPF driver (e.g. vNTB) to know if it can call
set_bar() twice or not, and can error out if the EPF driver is being used on
a EPC that doesn't support epc_features->dynamic_inbound_mapping.


Kind regards,
Niklas

