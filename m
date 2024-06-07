Return-Path: <linux-pci+bounces-8436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF218FFF2D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7243328863D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 09:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1136F15B57C;
	Fri,  7 Jun 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq/ngASC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81762209D;
	Fri,  7 Jun 2024 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752116; cv=none; b=jJGPig/3PsP1rc6GX0tDxuyWelKrMmJctH34hCMivSVlAbcmce8volXMg8r7Ok1+liHAutZfkHq7j1skwywNAmvaCFkZpM7dgZ5gF/QBWx1beAMrkGFSXhv+YoWlrdUdl6VIz5zOkeTye0MYaPJt2MvqlU6rhwGu3WjN+D+LbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752116; c=relaxed/simple;
	bh=mkI9Zleemp+5fJfBU0GcUZWrMN2oLrp/WKztAvoJ3vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUF/f1Vjerl5QHQjYb6cUDNFvq8mlrmgJYnbUbhwAJKgc6HLsnZIzLUM2/jJStYX5Ze96pJ/vb2C3XDpKSwFJjZWhGjghwWhw3ZuATdbrlhEVJQAVMEUxsMzLUYOc/+Wpsn3B6zzNHRTalvxxf/Joxh4jFCZhjlzXV3VwQjNItw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vq/ngASC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA625C2BBFC;
	Fri,  7 Jun 2024 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717752115;
	bh=mkI9Zleemp+5fJfBU0GcUZWrMN2oLrp/WKztAvoJ3vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vq/ngASCb2PCKhRAbva5iVV9N8kqnIlkHsohtzvANVFjV1DDyAL0TN2UQAPoldLNW
	 v3sAUcxfKxJTN15EKoiI4H9hbsB5XBUN8xvf8LvEyHWVv0YLhDtQnttgClP7zcf9bB
	 9+cimC+7UIPVxS6hSHqNafOxRvskvteDvcNu5W9bFgN+IJuB+xYSA3VRh8HeJ3ciF5
	 245pY+YWiCo1jQGVdSXp/8it4oYatSXX2GsENiVxQ63kTkCousJoMMY88chQs2Nvz9
	 Qkviu3aYYBDgpM2AWvu7CUwyLcQCTh/XN/iBZspUoxv3tH5+pIE3JeS5oP2rY6oq/l
	 GEEiy0iiT1ZFA==
Date: Fri, 7 Jun 2024 11:21:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH 3/5] PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown()
 API to handle Link Down event
Message-ID: <ZmLRKJ76esDBgYW1@ryzen.lan>
References: <20240606-pci-deinit-v1-0-4395534520dc@linaro.org>
 <20240606-pci-deinit-v1-3-4395534520dc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-pci-deinit-v1-3-4395534520dc@linaro.org>

On Thu, Jun 06, 2024 at 12:56:36PM +0530, Manivannan Sadhasivam wrote:
> As per the PCIe base spec r5.0, section 5.2, Link Down event can happen
> under any of the following circumstances:
> 
> 1. Fundamental/Hot reset
> 2. Link disable transmission by upstream component
> 3. Moving from L2/L3 to L0
> 
> In those cases, Link Down causes some non-sticky DWC registers to loose the
> state (like REBAR, etc...). So the drivers need to reinitialize them to
> function properly once the link comes back again.
> 
> This is not a problem for drivers supporting PERST# IRQ, since they can
> reinitialize the registers in the PERST# IRQ callback. But for the drivers
> not supporting PERST#, there is no way they can reinitialize the registers
> other than relying on Link Down IRQ received when the link goes down. So
> let's add a DWC generic API dw_pcie_ep_linkdown() that reinitializes the
> non-sticky registers and also notifies the EPF drivers about link going
> down.
> 
> This API can also be used by the drivers supporting PERST# to handle the
> scenario (2) mentioned above.
> 
> NOTE: For the sake of code organization, move the dw_pcie_ep_linkup()
> definition just above dw_pcie_ep_linkdown().
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Like Siddharth reported, this patch is already in pci/next.

