Return-Path: <linux-pci+bounces-36670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29EAB916D1
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C89A7AEF17
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 13:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6545B30BF4F;
	Mon, 22 Sep 2025 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ls3NJuJE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3D72F617A;
	Mon, 22 Sep 2025 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548216; cv=none; b=a39nrMgZvM7HX7EKcSwQiVrztsFmyd+WT+GayD+AfrwIxf8FS7KBP2Lk9E3kACSJBw0CvJ1IzuMsUt6cc2Pp+ZwZTZL5UIOl4vXNGnwFqKOjTnlbzkPO7iPPlRi0G159TIs+JT+GWTzyWBrTiZeCN/DbWQXj+fpakQpaNDMMOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548216; c=relaxed/simple;
	bh=HQRSdHoUww+a+9SLN3y2kDLvUmc+i9muhIO+nmOJ4xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYmbyNcdZiRUX6jOOZ/jVCXB1DCNdJOPMQag2h+zy3RMxhh0E4im/vifiqM9WnuEjz1hlD0xA921YSnvDGSnfF7piPzwZA33r450mLEu04+0XgOxXFu4pqFa2LfoTQf1bZDWaOytFQYDVDZHDnwOKdtyZnJWwjbsldy9M87DeKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls3NJuJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429C4C4CEF0;
	Mon, 22 Sep 2025 13:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758548215;
	bh=HQRSdHoUww+a+9SLN3y2kDLvUmc+i9muhIO+nmOJ4xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ls3NJuJEVsq58Jl/mQoW/grNoNgT+FCDq9Z9w7+wEc3XV7r5oKmkidq7clSfULj/1
	 NT38RJ0exSohE3lNk6rVK9op76yClTG2A7+Hi8KYMMqxAz0z10Xz2RwnR7YQMt+dqy
	 /9KjxT3P29tsddmLUKW+Isg0vAYY5sdSIMfN4f02JbY895GaIMKpiXMGmNNXqxx53x
	 5AyYNShMN61Vs5fILy47YduSqMN8z98z1JgYN2UML3CDKz1b73mgVSsFxpAUpUdRZr
	 S9c6a8JsOR2kO9Ng/SH8Vz7h0fr9y/1sNwhNKnRTQLrXOLeFQqWxVHlpcgZ1zBQa81
	 Xd0i8/fJM1qmg==
Date: Mon, 22 Sep 2025 15:36:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Handle errors in BPMP response
Message-ID: <aNFQ8hCznucs-CZw@ryzen>
References: <20250911122728.1465254-2-cassel@kernel.org>
 <lvchydppqdxm4hy4kogkzinz4w2hllvsihg2ehvueth25sxi53@feqxeedvrs2o>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lvchydppqdxm4hy4kogkzinz4w2hllvsihg2ehvueth25sxi53@feqxeedvrs2o>

On Sat, Sep 20, 2025 at 09:01:25PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Sep 11, 2025 at 02:27:29PM +0200, Niklas Cassel wrote:
> > From: Vidya Sagar <vidyas@nvidia.com>
> > 
> > The return value from tegra_bpmp_transfer() indicates the success or
> > failure of the IPC transaction with BPMP. If the transaction
> > succeeded, we also need to check the actual command's result code.
> > 
> > If a host deasserts PERST without providing a refclock, enabling the PHY
> > (via a tegra_bpmp_transfer() call) will silently fail, however, because
> > we are lacking error handling, pex_ep_event_pex_rst_deassert() will still
> > set pcie->ep_state = EP_STATE_ENABLED.
> > 
> 
> How can a host deassert PERST# without providing refclk? As per the CEM spec
> r4.0, sec 2.2, refclk should be active at least TPERST-CLK before PERST# is
> deasserted.
> 
> So does this controller violate the spec? Even so, I don't know how an endpoint
> could function if it relies on the host for refclk.

Hello Mani,

I apologize for my poor commit message.

What happens is this:

I use a rock5b as host. I use a jetson orin nano (Tegra234 based board).

When uboot starts on rock5b, it initializes the PCIe root complex, this
asserts+deasserts PERST#, and I can see the PERST GPIO handler being
triggered on the jetson board.

However, for some unknown reason, the PHY init fails.
I have no idea why. My guess is that perhaps the uboot driver does not
provide the refclock for very long after deasserting PERST, before deasserting
PERST again and booting linux.

The problem is that the tegra PCIe endpoint driver has no error handling for
the PHY init (which is done using a tegra_bpmp_transfer() command to firmware).

So the tegra PCIe endpoint driver will incorrectly set pcie->ep_state to
EP_STATE_ENABLED.

So when linux eventually boots on the rock5b, and the DWC based PCIe driver
asserts+deasserts PERST, it will be a no-op, because the tegra driver will
think that the pcie->ep_state is already EP_STATE_ENABLED.

This means that the driver will not try to initialize the PHY during this
second PERST assert+deassert.

By simply adding error handling to tegra_bpmp_transfer(), when the first
PERST assert+deassert (make by uboot) fails, the pcie->ep_state will not
incorrectly be set to EP_STATE_ENABLED.

Thus, when the second PERST assert+deassert (made by the linux driver) is done,
we will try to initialize the PHY again. For some reason, the PHY init works
this second time. Why? I don't really know, but we know that the DWC based
driver has the proper sleeps before/after asserting PERST, and that it will
not disable the reflock suddently, because it is loading some other OS.


I will try to improve the commit message to be more specific in V2.

Kind regards,
Niklas


> 
> > Because of this, any succeeding PERST deassertion will incorrectly be a
> > no-op (because of the pcie->ep_state == EP_STATE_ENABLED check in
> > pex_ep_event_pex_rst_deassert()), even if the host does provide a refclock
> > during the succeeding PERST deassertion.
> > 
> > Add error handling to tegra_bpmp_transfer(), such that the pcie->ep_state
> > can not get out of sync with reality, which will incorrectly cause the
> > driver to think that it has been successfully initialized, which
> > incorrectly makes future calls to pex_ep_event_pex_rst_deassert() a no-op.
> > 
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > [cassel: improve commit log]
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index 0c0734aa14b68..8c5c370dbba5e 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -1214,6 +1214,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
> >  	struct mrq_uphy_response resp;
> >  	struct tegra_bpmp_message msg;
> >  	struct mrq_uphy_request req;
> > +	int err;
> >  
> >  	/*
> >  	 * Controller-5 doesn't need to have its state set by BPMP-FW in
> > @@ -1236,7 +1237,13 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
> >  	msg.rx.data = &resp;
> >  	msg.rx.size = sizeof(resp);
> >  
> > -	return tegra_bpmp_transfer(pcie->bpmp, &msg);
> > +	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
> > +	if (err)
> > +		return err;
> > +	if (msg.rx.ret)
> > +		return -EINVAL;
> > +
> > +	return 0;
> >  }
> >  
> >  static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
> > @@ -1245,6 +1252,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
> >  	struct mrq_uphy_response resp;
> >  	struct tegra_bpmp_message msg;
> >  	struct mrq_uphy_request req;
> > +	int err;
> >  
> >  	memset(&req, 0, sizeof(req));
> >  	memset(&resp, 0, sizeof(resp));
> > @@ -1264,7 +1272,13 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
> >  	msg.rx.data = &resp;
> >  	msg.rx.size = sizeof(resp);
> >  
> > -	return tegra_bpmp_transfer(pcie->bpmp, &msg);
> > +	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
> > +	if (err)
> > +		return err;
> > +	if (msg.rx.ret)
> > +		return -EINVAL;
> > +
> > +	return 0;
> >  }
> >  
> >  static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
> > -- 
> > 2.51.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

