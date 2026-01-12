Return-Path: <linux-pci+bounces-44495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D83D125A9
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 12:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6AF23018810
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 11:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C97356A36;
	Mon, 12 Jan 2026 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDSFaEjh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4648B356A27;
	Mon, 12 Jan 2026 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218243; cv=none; b=Di+0c759mNTBspbdiW2UbQsVRmnniBp6CLYeeighTF2Ja4Nc8y1Z9YuKkCnluimvsvoPhWrPGWbsuXQa16TUOG/2TZFYqAuE9oZg+aVRn92Ye1M00roEH3KJFlVGgwHBkY7u6DBWs1AO/B7FBCG2LiEaynTIJmcuWVRQdeEMJaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218243; c=relaxed/simple;
	bh=wYxzqaucRGuoMNi3CMgj0x5c6RoysJv8GcSjGMutuIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUrZC4+4w8TEk8GNxSIQC1bHBxE70WZ+J4cxp6yharDzScne3xPH0NT/pDp+oaeOUi/WNiH1D5y0S+7XA3jLCdfzqsG4FvMkIeJ2+WctU2DcAKDCGkjeVnpoqvIi6uBRTuCkCgQCYrSUts5Ro7M/LjApUq3Hpa8cB0pZYr2H/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDSFaEjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02848C16AAE;
	Mon, 12 Jan 2026 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768218242;
	bh=wYxzqaucRGuoMNi3CMgj0x5c6RoysJv8GcSjGMutuIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDSFaEjhcr82fZbuOnjBsIysguMmvESRnrY4Tpsv9UGf02g8W7lpkhwWzD3ZIsLOR
	 7AeG2s+ycAlQNjCw8YvdfZWEU6xGElMYLW6io9YkNrIvlGIPar1iQI7aij9znZaI/6
	 BxJ/wIFz6DdmbdPiZHbOoiwkZUJv3hQjpiOuavR/2Ua7mkrI3qhF0BRjXMU8U5mBPo
	 2HMuNGiN0xFNsBs0I4Q2tw3Cwl1R6aWTYi3pXz6xaXjzyFoGuIH7U0OtYGZv4JnSKY
	 y+AXIMFWSkAK5y7yHajqyXFoHhHBAtAJssYs+UufUpqaqMQPxX/X1j7u9ik4vwXeRY
	 +s9LbpjkC3sow==
Date: Mon, 12 Jan 2026 12:43:50 +0100
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
Message-ID: <aWTedhkOclAVvktO@ryzen>
References: <20260108172403.2629671-1-den@valinux.co.jp>
 <20260108172403.2629671-4-den@valinux.co.jp>
 <aWAZv3ZwdUmo4_wc@ryzen>
 <nqpwi6ewen4kf7jqgon4ljerceqjeaule25dzb6ytas3wslqhp@ddkr3jum6eac>
 <aWC8jGTtKIzVuG-X@ryzen>
 <wvb42kyfcpyii3jql2gm75dd6hqpcd32yat2yb7cg7sl3raw4l@d4mfxk47l6md>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wvb42kyfcpyii3jql2gm75dd6hqpcd32yat2yb7cg7sl3raw4l@d4mfxk47l6md>

Hello Koichiro,

On Sat, Jan 10, 2026 at 11:29:06PM +0900, Koichiro Den wrote:

(snip)

> > Your new feature (epc_features->subrange_mapping) in epc_features appears
> > to depend on epc_features->dynamic_inbound_mapping, so it is a shame that
> > we don't have a epc_features->dynamic_inbound_mapping bit, so that this new
> > feature could have depended on that bit.
> > 
> > 	if (epf_bar->use_submap &&
> > 	    !(epc_features->dynamic_inbound_mapping &&
> > 	      epc_features->subrange_mapping))
> > 		return -EINVAL;
> > 
> > 
> > I think adding some documentation is a good step.
> > 
> > Perhaps we should also introduce a epc_features->dynamic_inbound_mapping bit?
> > Since you are making DWC glue drivers return a mutable EPC features, we could
> > set this bit in the DWC driver after that commit. What do you think?
> 
> As you pointed out, support for dynamic_inbound_mapping is needed
> independently of my series. Given that, it would make sense to handle it
> either before this series, or to fold it into the next iteration (=v6) of
> the series if that is preferred.

Please fold it into the next iteration (=v6).

It should be a one liner patch in the DWC driver, at least if you put it
after your "PCI: dwc: Allow glue drivers to return mutable EPC features"
patch.

Thank you for all your efforts on improving the endpoint framework.


Kind regards,
Niklas

