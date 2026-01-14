Return-Path: <linux-pci+bounces-44852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 769DBD21232
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FAB03048EC6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7B352FB6;
	Wed, 14 Jan 2026 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5mIULR/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2723093BF;
	Wed, 14 Jan 2026 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768421629; cv=none; b=nUxpeFAXcKWxlzOdpx4/MAXw4/+zBCRszUDyQMV/e374e6Ux+0xOJ/JMxjA0W45iiTEHZGac1GgVfar0Qj59hqAmdK61fl6i07s4QsE4HEvYJGGS7ovyeO6YpGa5M5Fd5b3xDCnweiCltkBSJPAX+HTk50GbMESoxTGJl7Bvuc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768421629; c=relaxed/simple;
	bh=MMH8BxTdLCMG6H0k3fKrVpip0aGLgha/EOhPfRlgxMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUpZJk40YRS6uezEpmpfs0EdBBq981OdkC6jK220VOx7oMu9IgDNBbLeaji9ipLcNNxOKbgnCIa/idTQyeaQbA9dpu4cPlz9C08W9XCkPhDfXb0SoWM9EwlZq3t/h+wk970e/6ErzP+dv2nnC7WeC0B38vmuxawBVE/ms8m5cIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5mIULR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D89CC4CEF7;
	Wed, 14 Jan 2026 20:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768421629;
	bh=MMH8BxTdLCMG6H0k3fKrVpip0aGLgha/EOhPfRlgxMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5mIULR/ygIzxL+Pxuty2E8BhuVMHRvwCUrYsJBWxe4NzUKKOvLAHR7O5T55F/bwX
	 8Sao0YehpAnrOtH3Cv93t6hj77ccJbds7h9behm5sB/bF4j1EXJT+XINv2x1ke5C+i
	 nBTDVTjP+ljthpD5TzWKEMWc32UsTKRs+aTvOb3d3kUOm1miZ8lNpyqikqvMgP3BDW
	 WLIgmTjHA+HTTrPt2NMj093kfu2BQb33BcNhJChO49A8CRrFYcvFATIckjUkyHgWo8
	 duYni3PcbrLxP3ol8/+Vqc3h2JQtvSwo/amvWEl164C/evEW3b51EsRId7Yoax4GR6
	 0YROdUiZQvKJA==
Date: Wed, 14 Jan 2026 21:13:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Koichiro Den <den@valinux.co.jp>, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, vigneshr@ti.com, s-vadapalli@ti.com,
	hongxing.zhu@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
	jesper.nilsson@axis.com, heiko@sntech.de,
	srikanth.thokala@intel.com, marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
	magnus.damm@gmail.com, christian.bruel@foss.st.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
	kishon@kernel.org, jirislaby@kernel.org, rongqianfeng@vivo.com,
	18255117159@163.com, shawn.lin@rock-chips.com,
	nicolas.frattaroli@collabora.com, linux.amoon@gmail.com,
	vidyas@nvidia.com, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@axis.com,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 3/6] PCI: dwc: Allow glue drivers to return mutable
 EPC features
Message-ID: <aWf47s1oY-bjCDSA@fedora>
References: <20260113162719.3710268-1-den@valinux.co.jp>
 <20260113162719.3710268-4-den@valinux.co.jp>
 <aWatVUFdyYz+JaMI@lizhi-Precision-Tower-5810>
 <mz3ahnech7yn66hcv7hqllir6rz6qpjd6m2aj3feh2gqfsvpwk@oobwtkb6o2jx>
 <aWe0KJnZNHqSUAKg@lizhi-Precision-Tower-5810>
 <m47oybaq4u2noqqd77czzgwwnmmquhvarjnxgijlhb5neulznt@dts3icronu6u>
 <aWfyDHZCoh1t6/vP@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWfyDHZCoh1t6/vP@lizhi-Precision-Tower-5810>

On Wed, Jan 14, 2026 at 02:44:12PM -0500, Frank Li wrote:
> > > > > Add
> > > > > 	DWC_EPC_DEFAULT, into every epc_features.
> > > >
> > > > One corner case is that pci-layerscape-ep.c builds the pci_epc_features
> > >
> > > It is our old platform. I checked code, it should be wrong. features should
> > > report EPC hardware capibility.
> >
> > I'm not really sure whether commit cc255eb0bfbe ("PCI: layerscape: Modify
> > the way of getting capability with different PEX") was wrong.
> > Do you have a patch in mind?
> 
> I think it's wrong. And it doesn't impact your patch. Just leave it as it.
> we can add submap support later if need.

Adding a macro:
#define DWC_EPC_COMMON_FEATURES .dynamic_inbound_mapping = true

And including it in all the DWC glue drivers' epc_features sounds
fine to me.

Frank does have a point that if some glue driver ever has some random
errata or bad integration, it will be simpler for a single glue driver
to override the defaults.


The commit that adds subrange mapping support would then just
change the macro to something like:

#define DWC_EPC_COMMON_FEATURES .dynamic_inbound_mapping = true, \
				.subrange_mapping = true


Kind regards,
Niklas

