Return-Path: <linux-pci+bounces-44602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D87D18044
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 11:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1DDF3025722
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3A338A9C7;
	Tue, 13 Jan 2026 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHVExecN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A3F3446CC;
	Tue, 13 Jan 2026 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300074; cv=none; b=ZSnncMllVR0jaFnKdsXgHVTkFwWy0GnQ7N/32ZqatZFYg2xMkSZ48WTvZKXiU0XD3tObHIQu7gB/hlIzBCFtrcL5D628wggSwOFLeQNb+n1Qjp0cQO3Rx04y7J0p5WU45kusK824FoopdMG0AZecol/lPsLDRV6BGdboPBabEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300074; c=relaxed/simple;
	bh=C8UgsS+YrsZDchnel7CNOtadN1mg/ONjw32g4J6+OCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3oONQMcgpC9Kmz7Z9cPcpieBDdE7mFY8YjR9zIxIqvkJ4bBPeQkMWKoDLk/T5UnMSEd640bsETxWSL5ODFjrB321UM1Z2FyZDFsSDhbXOwQ6TRhz9GsRQN+gkl1NpBnZE9e/UarBMEk2kbjFAYJ+3UwtgQXuWWuCuh4sE6OucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHVExecN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FB0C116C6;
	Tue, 13 Jan 2026 10:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768300073;
	bh=C8UgsS+YrsZDchnel7CNOtadN1mg/ONjw32g4J6+OCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHVExecNeP0XkZg6xghaAQoJqr/q0z3GdC0x9jlfMNdwId0ErGseOxuOiGwv29fD7
	 AvHvAxAYhEhEwlTtZ/HzVBPzak/DCiPS0cy2tK74aPn60U+CPG+/5TqEOYVmIpPOB+
	 t0lfLQrTlza7crImIQKqJobRsLqGMk0r+g0eXbY9SIXRxX+hMLbFEU7eN5Xkq1qwjt
	 tqZncLDnAqJDaSQnuMYsFLITR5wWfSPuJ4e3LtNOMwEMkXQnDUSM9mD8VFTfDQepbM
	 3idXM1YFBgiHX990n6orktQZK0baqsg7qxAQ9euVwMmyZF8sanjixl845BLKqFX5sj
	 jWW9lS8W7E+tQ==
Date: Tue, 13 Jan 2026 11:27:40 +0100
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
Subject: Re: [PATCH v6 4/5] PCI: dwc: ep: Support BAR subrange inbound
 mapping via Address Match Mode iATU
Message-ID: <aWYeHNoPEl9T-Qo-@ryzen>
References: <20260113023715.3463724-1-den@valinux.co.jp>
 <20260113023715.3463724-5-den@valinux.co.jp>
 <aWYbTt6UjlXb9Uk-@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWYbTt6UjlXb9Uk-@ryzen>

On Tue, Jan 13, 2026 at 11:15:42AM +0100, Niklas Cassel wrote:
> On Tue, Jan 13, 2026 at 11:37:14AM +0900, Koichiro Den wrote:
> > @@ -626,11 +831,22 @@ static const struct pci_epc_features*
> >  dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> >  {
> >  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> > +	struct pci_epc_features *features;
> >  
> >  	if (!ep->ops->get_features)
> >  		return NULL;
> >  
> > -	return ep->ops->get_features(ep);
> > +	features = ep->ops->get_features(ep);
> > +	if (!features)
> > +		return NULL;
> > +
> > +	/* All DWC-based glue drivers support dynamic inbound mapping */
> > +	features->dynamic_inbound_mapping = true;
> 
> I think you should create a separate patch, before this patch, that simply
> sets:
> features->dynamic_inbound_mapping = true;
> 
> Since that is technically a different feature, independent of this
> feature, so it deserves its own patch.

The commit message for that separate patch should mention that the reason
why there are no code changes when exposing/enabling support for the
dynamic_inbound_mapping feature, is because the actual code changes to the
the DWC driver already in commit 4284c88fff0e ("PCI: designware-ep: Allow
pci_epc_set_bar() update inbound map address").


Kind regards,
Niklas

