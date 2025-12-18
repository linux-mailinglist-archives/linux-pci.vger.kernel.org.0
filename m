Return-Path: <linux-pci+bounces-43263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AF3CCAD56
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 09:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C159F3053FAA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E38531158A;
	Thu, 18 Dec 2025 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZYYgLaN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF122F745B;
	Thu, 18 Dec 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045706; cv=none; b=IwSh3O2oFmdTSadK/V0fg5tFKk6ORO6yRBTktxZgIqeMkyzL19n9VFsyWZOj5PS8SSxbrM5j9WQJeg2OLolxzOj4kuLCD++YtfLChgQZlawJJNCS/JFEfUS3XD5VTB+rAMRsausutkadMBbi3cHPYhmcYGXxULsOidbKddGY0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045706; c=relaxed/simple;
	bh=ieUg3d/oxE9bWhnyKM/m7zI5iGcvY57dmoKIy0J/7W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUuiGyvIEB9fKVj4gKBVx+jGi3IG01Pv/MC3vwOtRdUIZYH5JAJrnRS3S60yQ2s11KLEHhIiUM2+fEdyQCqBtDMmrR/JC5g0v2PFJVugyhBDHA95SQv5hxnP0wlrxonXzmTa/m4sUN9duEC9PLE0BO/YFAMhfifEYU5qBc3uYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZYYgLaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AB3C4CEFB;
	Thu, 18 Dec 2025 08:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766045704;
	bh=ieUg3d/oxE9bWhnyKM/m7zI5iGcvY57dmoKIy0J/7W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZYYgLaNKOo0slpQeUbOiMCXBHI+WqlAvB/70+CYP1urHbpBb9IIVY1yVivTiubfK
	 OvvQZeDuunIRg94dUKIt9vBS7/6BG0w0IRUJhJHZgt7+HaYC8FBldvD+qsFNmt6WpC
	 dh9nw9VZpfxFsm0zakQ67qdK45d+3K/7ypnVRH8+/BsCvZm8uf+2A9W5VSb/+NH36L
	 UbqvNcRMl35Q30mufIt26X8sJfVvAoozL9JBPT+UblZUiWnnEfQq0rwiAA4EZvW//x
	 uveJvON2CF4FAkWvdxiMVwAP8gTQJYDh7Nxy5pmPIkHvWcmI9PeMAXZg9dpVEVoiYP
	 bFk2iUIvgbhqw==
Date: Thu, 18 Dec 2025 13:44:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Frank Li <frank.li@nxp.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, 
	"zhangsenchuan@eswincomputing.com" <zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH 2/2] PCI: dwc: Do not return failure from
 dw_pcie_wait_for_link() if link is in Detect/Poll state
Message-ID: <paykevybcrzshvgcyenc6dfb5bv7iakr3p2j4gi37xznlfqq6g@por767desr3f>
References: <20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com>
 <20251119-pci-dwc-suspend-rework-v1-2-aad104828562@oss.qualcomm.com>
 <40e3197b-1670-4b63-a973-98012bcc623a@rock-chips.com>
 <jmysdqydimjl7min6dw34bdcf6hiyk3pqb4plzvzl6folgat5n@v55h5i7pufg3>
 <AS8PR04MB8833807ECE928024892B73408CD5A@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <yfag3ox6ifg5nvi4ayfcx3mvj5zfn2d2quwiakuczp7o3lwuy6@t3n4h23fsmiw>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yfag3ox6ifg5nvi4ayfcx3mvj5zfn2d2quwiakuczp7o3lwuy6@t3n4h23fsmiw>

On Fri, Nov 21, 2025 at 09:56:05PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 21, 2025 at 05:21:58AM +0000, Hongxing Zhu wrote:
> > > -----Original Message-----
> > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > Sent: 2025年11月20日 13:37
> > > To: Shawn Lin <shawn.lin@rock-chips.com>
> > > Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; Frank Li <frank.li@nxp.com>;
> > > Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>;
> > > Jingoo Han <jingoohan1@gmail.com>; Lorenzo Pieralisi
> > > <lpieralisi@kernel.org>; Krzysztof Wilczyński <kwilczynski@kernel.org>; Rob
> > > Herring <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
> > > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > vincent.guittot@linaro.org; zhangsenchuan@eswincomputing.com
> > > Subject: Re: [PATCH 2/2] PCI: dwc: Do not return failure from
> > > dw_pcie_wait_for_link() if link is in Detect/Poll state
> > > 
> > > + Richard, Frank
> > > 
> > > On Thu, Nov 20, 2025 at 09:13:24AM +0800, Shawn Lin wrote:
> > > > 在 2025/11/20 星期四 2:10, Manivannan Sadhasivam 写道:
> > > > > dw_pcie_wait_for_link() API waits for the link to be up and returns
> > > > > failure if the link is not up within the 1 second interval. But if
> > > > > there was no device connected to the bus, then the link up failure would
> > > be expected.
> > > > > In that case, the callers might want to skip the failure in a hope
> > > > > that the link will be up later when a device gets connected.
> > > > >
> > > > > One of the callers, dw_pcie_host_init() is currently skipping the
> > > > > failure irrespective of the link state, in an assumption that the
> > > > > link may come up later. But this assumption is wrong, since LTSSM
> > > > > states other than Detect and Poll during link training phase are
> > > > > considered to be fatal and the link needs to be retrained.
> > > > >
> > > > > So to avoid callers making wrong assumptions, skip returning failure
> > > > > from
> > > > > dw_pcie_wait_for_link() if the link is in Detect or Poll state after
> > > > > timeout and also check the return value of the API in
> > > dw_pcie_host_init().
> > > > >
> > > > > Signed-off-by: Manivannan Sadhasivam
> > > > > <manivannan.sadhasivam@oss.qualcomm.com>
> > > > > ---
> > > > >   drivers/pci/controller/dwc/pcie-designware-host.c | 8 +++++---
> > > > >   drivers/pci/controller/dwc/pcie-designware.c      | 8 ++++++++
> > > > >   2 files changed, 13 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > index 8fe3454f3b13..8c4845fd24aa 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > @@ -671,9 +671,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > > >   	 * If there is no Link Up IRQ, we should not bypass the delay
> > > > >   	 * because that would require users to manually rescan for devices.
> > > > >   	 */
> > > > > -	if (!pp->use_linkup_irq)
> > > > > -		/* Ignore errors, the link may come up later */
> > > > > -		dw_pcie_wait_for_link(pci);
> > > > > +	if (!pp->use_linkup_irq) {
> > > > > +		ret = dw_pcie_wait_for_link(pci);
> > > > > +		if (ret)
> > > > > +			goto err_stop_link;
> > > > > +	}
> > > > >   	ret = pci_host_probe(bridge);
> > > > >   	if (ret)
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > index c644216995f6..fe13c6b10ccb 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > @@ -651,6 +651,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > > >   	}
> > > > >   	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
> > > > > +		/*
> > > > > +		 * If the link is in Detect or Poll state, it indicates that no
> > > > > +		 * device is connected. So return success to allow the device to
> > > > > +		 * show up later.
> > > > > +		 */
> > > > > +		if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_WAIT)
> > > > > +			return 0;
> > > >
> > > > I'm afraid this might not be true. If there is no devices connected or
> > > > the device connected without power supplied, it means there is no
> > > > far-end pull-up termination resistor from TX view of RC. TX pulse
> > > > detection signal from the RC side will not undergo voltage division,
> > > > and its LTSSM state machine will only toggle between
> > > > DW_PCIE_LTSSM_DETECT_QUIET and DW_PCIE_LTSSM_DETECT_ACT.
> > > >
> > > 
> > > I must admit that I just inherited this check from dw_pcie_suspend_noirq().
> > > But I cross checked the PCIe base spec and it mentions clearly that the
> > > LTSSM will be in Detect.Quiet/Active states if no endpoint is detected i.e.,
> > > within the 1s timeout, the LTSSM should've transitioned back to these
> > > Detect states.
> > > 
> > > I'm wondering why we are checking for Poll and other states in
> > > dw_pcie_suspend_noirq(). I believe the intention was to check for the
> > > presence of an endpoint or not.
> > > 
> > > Richard, Frank, thoughts?
> > > 
> > Hi Mani:
> > Yes, it is.
> > In my initial upstreaming patches, the intention to check this state is to
> >  figure out that there is an endpoint device or not.
> > 
> 
> If so, why do we need to check for LTSSM states other than
> DW_PCIE_LTSSM_DETECT_QUIET and DW_PCIE_LTSSM_DETECT_ACT?
> 
> Did spec mandate it or you did it for some specific reason?
> 

Hongxing, ping!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

