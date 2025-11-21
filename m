Return-Path: <linux-pci+bounces-41883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C37FC7AD57
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 17:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5345B3A1D6B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 16:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74507231830;
	Fri, 21 Nov 2025 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkgK03I0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA331F09AD;
	Fri, 21 Nov 2025 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742382; cv=none; b=uz+YnNKltYEMr1Cc23WGL0CAMuITo6zXcoFGf3hKo6nh4BbWljsbJpiCtcWiDqgfudnBIC6a7EoiewQfG4AAANm5MgQIoGOkd4mpPj79vM+pW+4nv07kL7wdKKARGjm1EhVh+sqncZC5zrrElS/pzzl0pW5A2/8k3vBAtoc8SCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742382; c=relaxed/simple;
	bh=oZuv7cwQv91ygVY0uUC6DgpKYQJYqbV8d9fXmOXhSPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVR5Nh0pRG62AAFBrTGhHrsy9GCIVAkNGB1CqU/TgV/1KxXFaBC3vMBsPKjUkYBacV+lRxP2LFfRpiB4qn7ldS+h0zytVak/FSwwHO2FJdhIniX5PRO8XROr6e3Osu0PKXGuFND+AQe2mXl1qZTTSmZeR8MUAZJjqsT09mfvJEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkgK03I0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A31C4CEF1;
	Fri, 21 Nov 2025 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742381;
	bh=oZuv7cwQv91ygVY0uUC6DgpKYQJYqbV8d9fXmOXhSPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkgK03I0JH2mL+SM4cOr/dofova5ugFRy2TTVPRKHRoVCHEePVGoF/tWyIXQA8etj
	 2siod3QV/gJmGUWDEE6KkLUMD5jTz2UuXfBFuCvTPmibUOzs1maS/foNZHS3bEHHGQ
	 W/Kml67/oqMIX7/grkOgmVsYB/YzImIOjJl17T25HLSYMnozG1uv4WcBcQT7I7fVbb
	 LAHknIm5b6USXxWPVP9HnUtb2bGRIZQIOP5gPH/xXklG0XvtW1o28vuAPwLeMxkA24
	 EFBBfaTc8Vlgm+YhK0CaFrHGOs5T4av3vrlH0b4I08TtDKEPOeB+NebXLnlDG0C6HP
	 yaFhtETqK+U/g==
Date: Fri, 21 Nov 2025 21:56:05 +0530
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
Message-ID: <yfag3ox6ifg5nvi4ayfcx3mvj5zfn2d2quwiakuczp7o3lwuy6@t3n4h23fsmiw>
References: <20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com>
 <20251119-pci-dwc-suspend-rework-v1-2-aad104828562@oss.qualcomm.com>
 <40e3197b-1670-4b63-a973-98012bcc623a@rock-chips.com>
 <jmysdqydimjl7min6dw34bdcf6hiyk3pqb4plzvzl6folgat5n@v55h5i7pufg3>
 <AS8PR04MB8833807ECE928024892B73408CD5A@AS8PR04MB8833.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8833807ECE928024892B73408CD5A@AS8PR04MB8833.eurprd04.prod.outlook.com>

On Fri, Nov 21, 2025 at 05:21:58AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > Sent: 2025年11月20日 13:37
> > To: Shawn Lin <shawn.lin@rock-chips.com>
> > Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; Frank Li <frank.li@nxp.com>;
> > Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>;
> > Jingoo Han <jingoohan1@gmail.com>; Lorenzo Pieralisi
> > <lpieralisi@kernel.org>; Krzysztof Wilczyński <kwilczynski@kernel.org>; Rob
> > Herring <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
> > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > vincent.guittot@linaro.org; zhangsenchuan@eswincomputing.com
> > Subject: Re: [PATCH 2/2] PCI: dwc: Do not return failure from
> > dw_pcie_wait_for_link() if link is in Detect/Poll state
> > 
> > + Richard, Frank
> > 
> > On Thu, Nov 20, 2025 at 09:13:24AM +0800, Shawn Lin wrote:
> > > 在 2025/11/20 星期四 2:10, Manivannan Sadhasivam 写道:
> > > > dw_pcie_wait_for_link() API waits for the link to be up and returns
> > > > failure if the link is not up within the 1 second interval. But if
> > > > there was no device connected to the bus, then the link up failure would
> > be expected.
> > > > In that case, the callers might want to skip the failure in a hope
> > > > that the link will be up later when a device gets connected.
> > > >
> > > > One of the callers, dw_pcie_host_init() is currently skipping the
> > > > failure irrespective of the link state, in an assumption that the
> > > > link may come up later. But this assumption is wrong, since LTSSM
> > > > states other than Detect and Poll during link training phase are
> > > > considered to be fatal and the link needs to be retrained.
> > > >
> > > > So to avoid callers making wrong assumptions, skip returning failure
> > > > from
> > > > dw_pcie_wait_for_link() if the link is in Detect or Poll state after
> > > > timeout and also check the return value of the API in
> > dw_pcie_host_init().
> > > >
> > > > Signed-off-by: Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@oss.qualcomm.com>
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-designware-host.c | 8 +++++---
> > > >   drivers/pci/controller/dwc/pcie-designware.c      | 8 ++++++++
> > > >   2 files changed, 13 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 8fe3454f3b13..8c4845fd24aa 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -671,9 +671,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > >   	 * If there is no Link Up IRQ, we should not bypass the delay
> > > >   	 * because that would require users to manually rescan for devices.
> > > >   	 */
> > > > -	if (!pp->use_linkup_irq)
> > > > -		/* Ignore errors, the link may come up later */
> > > > -		dw_pcie_wait_for_link(pci);
> > > > +	if (!pp->use_linkup_irq) {
> > > > +		ret = dw_pcie_wait_for_link(pci);
> > > > +		if (ret)
> > > > +			goto err_stop_link;
> > > > +	}
> > > >   	ret = pci_host_probe(bridge);
> > > >   	if (ret)
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index c644216995f6..fe13c6b10ccb 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -651,6 +651,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > >   	}
> > > >   	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
> > > > +		/*
> > > > +		 * If the link is in Detect or Poll state, it indicates that no
> > > > +		 * device is connected. So return success to allow the device to
> > > > +		 * show up later.
> > > > +		 */
> > > > +		if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_WAIT)
> > > > +			return 0;
> > >
> > > I'm afraid this might not be true. If there is no devices connected or
> > > the device connected without power supplied, it means there is no
> > > far-end pull-up termination resistor from TX view of RC. TX pulse
> > > detection signal from the RC side will not undergo voltage division,
> > > and its LTSSM state machine will only toggle between
> > > DW_PCIE_LTSSM_DETECT_QUIET and DW_PCIE_LTSSM_DETECT_ACT.
> > >
> > 
> > I must admit that I just inherited this check from dw_pcie_suspend_noirq().
> > But I cross checked the PCIe base spec and it mentions clearly that the
> > LTSSM will be in Detect.Quiet/Active states if no endpoint is detected i.e.,
> > within the 1s timeout, the LTSSM should've transitioned back to these
> > Detect states.
> > 
> > I'm wondering why we are checking for Poll and other states in
> > dw_pcie_suspend_noirq(). I believe the intention was to check for the
> > presence of an endpoint or not.
> > 
> > Richard, Frank, thoughts?
> > 
> Hi Mani:
> Yes, it is.
> In my initial upstreaming patches, the intention to check this state is to
>  figure out that there is an endpoint device or not.
> 

If so, why do we need to check for LTSSM states other than
DW_PCIE_LTSSM_DETECT_QUIET and DW_PCIE_LTSSM_DETECT_ACT?

Did spec mandate it or you did it for some specific reason?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

