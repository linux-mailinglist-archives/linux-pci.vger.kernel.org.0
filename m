Return-Path: <linux-pci+bounces-23688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD90A60364
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 22:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133583AB8EB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 21:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726471F4CB2;
	Thu, 13 Mar 2025 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnPUcGWQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD2126C1E;
	Thu, 13 Mar 2025 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741901158; cv=none; b=GG6sErMHPiTaoHj8GtUE8bSFBczJK0lzm+T2vKIm3Hf9hTWS3yvBVr6LhQs/N+zj+orwP7HTmo8JRHbh+pItUE9KN8LTeTxXLFGhcrAePwb/W+0wYRLqGtN41WVnwnMq/VfA6cgc97aKUuvj4NxY8RmIZvXPH5ujZcwROrMe8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741901158; c=relaxed/simple;
	bh=qYeT6sg3o0N3LisLXr2XhjHV7IFvBdDp00R762l5BHM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NsnxfwKsPsgaK3qYKkyozwVBXmAd6VzRNwOHkBxTn1jyJmuPTKqoxM426C5aaWGo+ZyJQE+JMF77WBmEIajKQWpGogzkSw7LKqCCl6nrIPZNWXrFtHy1lBKVQlqsRU2hrvjWPSRqe4vDqM6m/gSdMnywUw5yFnStBdcICQ7j0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnPUcGWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A88C4CEDD;
	Thu, 13 Mar 2025 21:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741901157;
	bh=qYeT6sg3o0N3LisLXr2XhjHV7IFvBdDp00R762l5BHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MnPUcGWQoUM9IkqxucI7SH1sBbRubpnGpPw1lssb/UUk3lwzq4rmlkc0xPyPCj5rd
	 JlMyh/PHDy1W1CuPonbH/Pll68nI+tTwx94KvYM9+7AMUmCGiA93ztgdHm4VZ64E8h
	 AoK1FqzJmulAoLfr78IUWxAbSSzA2HT56EliMAXTMHKtOwUBZp2iTwrQcoP0bZ66x0
	 y3DRfvijKNyhLHSoGbpoyqOd9XhhQ9gX32rUWtf+COpyZhMKi/L8YscXr82JNP2BBM
	 gmAjwny/5OjZEiCi+8y/6R88KqK3zWru5ROzfxer2M5JwoVVuYNBZ4WgSfiCcdj5gk
	 4MCYTN30/B+HQ==
Date: Thu, 13 Mar 2025 16:25:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
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
Subject: Re: [PATCH v11 04/11] PCI: dwc: Move devm_pci_alloc_host_bridge() to
 the beginning of dw_pcie_host_init()
Message-ID: <20250313212555.GA755531@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9ND5vARXpL8g1t/@lizhi-Precision-Tower-5810>

On Thu, Mar 13, 2025 at 04:45:26PM -0400, Frank Li wrote:
> On Thu, Mar 13, 2025 at 02:22:54PM -0500, Bjorn Helgaas wrote:
> > On Thu, Mar 13, 2025 at 11:38:40AM -0400, Frank Li wrote:
> > > Move devm_pci_alloc_host_bridge() to the beginning of dw_pcie_host_init().
> > > Since devm_pci_alloc_host_bridge() is common code that doesn't depend on
> > > any DWC resource, moving it earlier improves code logic and readability.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index c57831902686e..52a441662cabe 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -452,6 +452,12 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >
> > >  	raw_spin_lock_init(&pp->lock);
> > >
> > > +	bridge = devm_pci_alloc_host_bridge(dev, 0);
> > > +	if (!bridge)
> > > +		return bridge;
> >
> > This returns NULL (0) where it previously returned -ENOMEM.  Callers
> > interpret zero as "success", so I think it should stil return -ENOMEM.
> 
> It should be -ENOMEM. Sorry for that. Strange, not sure what happen when
> I copy/past code.
> 
> Do you need respin it or you can fix it?

I fixed it locally.  But you should fix it, too, in case we do another
spin for other reasons.

> > I tentatively changed it back to -ENOMEM locally, let me know if
> > that's wrong.
> >
> > > +	pp->bridge = bridge;
> > > +

