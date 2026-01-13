Return-Path: <linux-pci+bounces-44601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F683D17F8D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 11:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 031D4302AE10
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A425B38BF76;
	Tue, 13 Jan 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRp9YMAN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8D38BF63;
	Tue, 13 Jan 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299484; cv=none; b=kloxPr08pHjMgoAOw76IQ7rtwZDyzpGYOWIrTHJPyenDXDV6wNakY6FI30op5HhLLxGdR6mk7mkZN81iMXNH2cEK4fCJoweViU/r5H4+NzBc0OzT0k3vi/HXaTciWrtxZ10F1ntdmWsHcqzU8PW/Kh1UrsGLW4gZ2NYCJgbYClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299484; c=relaxed/simple;
	bh=0fpbeQGAJF9xjq5Byej/gkDKIoAX4CGtzrNcpesJoYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usXozLUJ0C8p9MVjS/kwyIb4UeCh828BsdMeZcAEARiQxhCt9DgDXO3ydm+j4i/d/fB8fBgWh601EizxEji9fW62vTWomdgZP2XmvaOzlfscYpX4wvccafpXPk+nDI1ovHh0zAK9AjE3Cfwvk2OHazi4/1gf6izeBMDXuV2pklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRp9YMAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE25C116C6;
	Tue, 13 Jan 2026 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768299484;
	bh=0fpbeQGAJF9xjq5Byej/gkDKIoAX4CGtzrNcpesJoYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRp9YMANteq690cw3Tc7KijMkA6B5f5vSRAv1KYS88CI6bYfRan3AunIB+7E3+4Zf
	 mH6JR+bx1yw1zxCxKPf3N1DLKskJu82uTfBstubAf28agXhdqU772iiBJkM5LgXEpy
	 plOKWgaX4KN/pF6w30vo35DCBordFKJeLgvSIIfExlQb5H2XThPtbweNqsw40BnW02
	 gumS3q0YECyjFfZOW1nnxfwdEnGYxO1CC4ikdXYnd7c3XwQmF7m/5skQdCXx7sdxre
	 E0Rgup+mH27I+3bpVVUf7q1WahO6w+oqQMKt64/Evzkesa8eBewcfSH5ATrS9liPkS
	 BVWMV4ydfdzuQ==
Date: Tue, 13 Jan 2026 11:17:51 +0100
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
Subject: Re: [PATCH v6 5/5] Documentation: PCI: endpoint: Clarify
 pci_epc_set_bar() usage
Message-ID: <aWYbzzAeDSLYJJcB@ryzen>
References: <20260113023715.3463724-1-den@valinux.co.jp>
 <20260113023715.3463724-6-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113023715.3463724-6-den@valinux.co.jp>

On Tue, Jan 13, 2026 at 11:37:15AM +0900, Koichiro Den wrote:
> The current documentation implies that pci_epc_set_bar() is only used
> before the host enumerates the endpoint.
> 
> In practice, some Endpoint Controllers support calling pci_epc_set_bar()
> multiple times for the same BAR (without clearing it) in order to update
> inbound address translations after the host has programmed the BAR base
> address, which some Endpoint Functions such as vNTB already relies on.
> Add document text for that.
> 
> Also document the expected call flow for BAR subrange mapping
> (pci_epf_bar.use_submap / pci_epf_bar.submap), which may require
> a second pci_epc_set_bar() call after the host has programmed the BAR base
> address.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  Documentation/PCI/endpoint/pci-endpoint.rst | 22 +++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> index 0741c8cbd74e..d3d9abbbc71e 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> @@ -95,6 +95,28 @@ by the PCI endpoint function driver.
>     Register space of the function driver is usually configured
>     using this API.
>  
> +   Some endpoint controllers also support calling pci_epc_set_bar() again
> +   for the same BAR (without calling pci_epc_clear_bar()) to update inbound
> +   address translations after the host has programmed the BAR base address.
> +   Endpoint function drivers can check this capability via the
> +   dynamic_inbound_mapping EPC feature bit.
> +
> +   When pci_epf_bar.use_submap is set, the endpoint function driver is
> +   requesting BAR subrange mapping using pci_epf_bar.submap. This requires
> +   the EPC to advertise support via the subrange_mapping EPC feature bit.
> +
> +   If the EPF driver wants to program inbound subrange mappings that are
> +   based on the BAR base address programmed by the host during enumeration,
> +   it needs to call pci_epc_set_bar() twice for the same BAR (requires
> +   dynamic_inbound_mapping): first with use_submap cleared to configure the
> +   BAR size, then after the PCIe link is up and the host enumerates the
> +   endpoint and programs the BAR base address, again with use_submap set.

"If the EPF driver wants to ..."

Here you have phrased it in a way where it almost seems like this is an
alternative way that you could use this feature.

But in reality, dw_pcie_ep_ib_atu_addr() will return an error if
dw_pcie_ep_read_bar_assigned() does not return an assigned PCI address.

So perhaps write it something like:
"When an EPF driver wants to make use of the inbound subrange mapping
feature, it requires that the BAR base address has been programmed by
the host during enumeration. Thus, it needs to ..."


> +
> +   Note that in this flow, the EPF driver must not call pci_epc_clear_bar()
> +   between the two pci_epc_set_bar() calls, because clearing the BAR can
> +   clear/disable the BAR register or BAR decode on the endpoint while the
> +   host still expects the assigned BAR address to remain valid.

"Note that in this flow, ..."

This also somehow sounds like this is an alternative way, when it is the
only way.

Perhaps simply something like:
"Note that when making use of the inbound subrange mapping feature,
the EPF driver must not call pci_epc_clear_bar() ..."


With that fixed, this looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

