Return-Path: <linux-pci+bounces-41726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C859EC7242D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 06:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7799B347817
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 05:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB98305954;
	Thu, 20 Nov 2025 05:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="It0rpD18"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB34305953;
	Thu, 20 Nov 2025 05:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763617060; cv=none; b=t+GfwzLx2GLIiCW+ASNPRV2klCgMfnqQqh37yzLiQV1iV8BDjDSJn1wV0jX78a/ZXPoKF/R51+SmwHIgYlbNXyYjkuONx3bBU6US+Mdmc4iMbizJaf8eQNOz617bUss5f2BWRBCHcyorWyyxJQ4XIiBrqBNKJxeSL2M+Y/KLyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763617060; c=relaxed/simple;
	bh=yG7nuEY+c3kzsKZopmU+1ku8TRmGsxcP/k6HUhViMwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbAiDBQeSEKsIQf8O2CSRsy3A6ohCdn4sRAgsP3HLj9eekYsuDvK7XeITZToEoxfPptk3Q/SRJxEU1iGnLo2LmsOFxG4cUS1wW4lNHlE8ToTB1bL96Nheb4Ob4fflKateBpIZ60sX7XlZFGjr0ZUOMtKf2QOjeSqWI0wiKSwjKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=It0rpD18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35992C4CEF1;
	Thu, 20 Nov 2025 05:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763617059;
	bh=yG7nuEY+c3kzsKZopmU+1ku8TRmGsxcP/k6HUhViMwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=It0rpD188uxHhQUJ4u74ALh+2uLf9QPNzAmkk/3BoiuqzvZLGnrDUSUi3o6/407Wx
	 ARqI2Tm7rJVtWLxqYA7UEaW/EgxIjEvFBsTg4pXLSYGxfdBKb+4pkrpZ75TiMPFbH9
	 t+C44rsc7mevmi6+4vbdgOObQVkV2VUxeH0ylJDorxkisk1delKWUd9tFm2RjJGtnL
	 mS0+ctjqt2xxl/264/sPkU57Oq3BwZ5R1mqQGrNXfo6BGOG4xsls1Nd8m1vJ3vR3yo
	 c8dLcmz0rlQ04sOSIrltFNDo5pm9cLUguYWOe0Aoof7dBIcrTLHnODH99lWt6Q7b70
	 H2wtVPgJz5opw==
Date: Thu, 20 Nov 2025 11:07:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.li@nxp.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com
Subject: Re: [PATCH 2/2] PCI: dwc: Do not return failure from
 dw_pcie_wait_for_link() if link is in Detect/Poll state
Message-ID: <jmysdqydimjl7min6dw34bdcf6hiyk3pqb4plzvzl6folgat5n@v55h5i7pufg3>
References: <20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com>
 <20251119-pci-dwc-suspend-rework-v1-2-aad104828562@oss.qualcomm.com>
 <40e3197b-1670-4b63-a973-98012bcc623a@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40e3197b-1670-4b63-a973-98012bcc623a@rock-chips.com>

+ Richard, Frank

On Thu, Nov 20, 2025 at 09:13:24AM +0800, Shawn Lin wrote:
> 在 2025/11/20 星期四 2:10, Manivannan Sadhasivam 写道:
> > dw_pcie_wait_for_link() API waits for the link to be up and returns failure
> > if the link is not up within the 1 second interval. But if there was no
> > device connected to the bus, then the link up failure would be expected.
> > In that case, the callers might want to skip the failure in a hope that the
> > link will be up later when a device gets connected.
> > 
> > One of the callers, dw_pcie_host_init() is currently skipping the failure
> > irrespective of the link state, in an assumption that the link may come up
> > later. But this assumption is wrong, since LTSSM states other than Detect
> > and Poll during link training phase are considered to be fatal and the link
> > needs to be retrained.
> > 
> > So to avoid callers making wrong assumptions, skip returning failure from
> > dw_pcie_wait_for_link() if the link is in Detect or Poll state after
> > timeout and also check the return value of the API in dw_pcie_host_init().
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >   drivers/pci/controller/dwc/pcie-designware-host.c | 8 +++++---
> >   drivers/pci/controller/dwc/pcie-designware.c      | 8 ++++++++
> >   2 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 8fe3454f3b13..8c4845fd24aa 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -671,9 +671,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >   	 * If there is no Link Up IRQ, we should not bypass the delay
> >   	 * because that would require users to manually rescan for devices.
> >   	 */
> > -	if (!pp->use_linkup_irq)
> > -		/* Ignore errors, the link may come up later */
> > -		dw_pcie_wait_for_link(pci);
> > +	if (!pp->use_linkup_irq) {
> > +		ret = dw_pcie_wait_for_link(pci);
> > +		if (ret)
> > +			goto err_stop_link;
> > +	}
> >   	ret = pci_host_probe(bridge);
> >   	if (ret)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index c644216995f6..fe13c6b10ccb 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -651,6 +651,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >   	}
> >   	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
> > +		/*
> > +		 * If the link is in Detect or Poll state, it indicates that no
> > +		 * device is connected. So return success to allow the device to
> > +		 * show up later.
> > +		 */
> > +		if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_WAIT)
> > +			return 0;
> 
> I'm afraid this might not be true. If there is no devices connected or
> the device connected without power supplied, it means there is no
> far-end pull-up termination resistor from TX view of RC. TX pulse detection
> signal from the RC side will not undergo voltage division, and
> its LTSSM state machine will only toggle between
> DW_PCIE_LTSSM_DETECT_QUIET and DW_PCIE_LTSSM_DETECT_ACT.
> 

I must admit that I just inherited this check from dw_pcie_suspend_noirq(). But
I cross checked the PCIe base spec and it mentions clearly that the LTSSM will
be in Detect.Quiet/Active states if no endpoint is detected i.e., within the 1s
timeout, the LTSSM should've transitioned back to these Detect states.

I'm wondering why we are checking for Poll and other states in
dw_pcie_suspend_noirq(). I believe the intention was to check for the presence
of an endpoint or not.

Richard, Frank, thoughts?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

