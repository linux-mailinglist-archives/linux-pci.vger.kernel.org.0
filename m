Return-Path: <linux-pci+bounces-42038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7EEC853FA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEE734EAF09
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45E223817D;
	Tue, 25 Nov 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFY9h3az"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736E2CA5A;
	Tue, 25 Nov 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078614; cv=none; b=ePFjRE58pFX81/6zrrjtfK8dKK38VVxS4c/DV2knQhNM5/yEXzXoMRIhvDqv5lMSJCddHrv//DtVRqt2ly35qN4s/0EOyQncHLRcWx0hxH03PBqsBCNJHxH/GgWXKX5f4jvLLy7BwYu0FQRczrry1c9hPQ5s1Di0RRYSaQ2QxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078614; c=relaxed/simple;
	bh=rYXrmQTeIaXWLWmMOb0VD9Hfd1DVePs5ECBDXzDhu+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYg8CIOFfs7yrfYZNzZoZ6Y/MecMeuj1ojDhdnKRo80dPkItkWLr5QFAAipnRyR3jrMwTpZE7V9R1axAoF+PNM1a3CYOSboF/V4UCByJ7ORBNAMGsYIjDMCoQuPBCFzlB5wl/xHZdmf0AymY+UVH+QfzLd+0zRe8Z8bEpWhhH8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFY9h3az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7D6C4CEF1;
	Tue, 25 Nov 2025 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764078613;
	bh=rYXrmQTeIaXWLWmMOb0VD9Hfd1DVePs5ECBDXzDhu+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFY9h3azm1FqKKFN46fo96T0dcbmkEiBGz5E1G9aFj03dz8C4BGdEsQ3OJFwIdyMH
	 euuU82RVYrVDyFo8i8ApDAgKbUBBWbGIUg5v06Ju6k2bFlrpIGVnVZnPOAroLsfrdB
	 +BvO1Nk2rF2FaLuxQKB9EZLwagMPoHf6FAt58uWzUmpHo50oJ650Jhx9hJ241V971r
	 OLB5+HodaO4+5IA9Tu/T+rXvIhVXB7kwnXMgUCPZ8bD11YzJUdg5d6KPJOW4wH+O//
	 y2hf/a6cZieSTPub5a2wqiQJgleKlxtUXcgNB/PFBmj0+Bgq8Z0fdXxQMvI1A6E/6A
	 2Jc58Rd/rt0Eg==
Date: Tue, 25 Nov 2025 19:20:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 4/5] PCI/pwrctrl: Add APIs to power on/off the pwrctrl
 devices
Message-ID: <rsfsl32fjfmke6ffvz6y3lvvh54rofnaetuxy4qo3niffjcaue@udb44lfwbfga>
References: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com>
 <20251124-pci-pwrctrl-rework-v1-4-78a72627683d@oss.qualcomm.com>
 <CAMRc=MeRVLALxdPoFP2fXpq+inZpA7h-eCBRuegTkxWUGOpDew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeRVLALxdPoFP2fXpq+inZpA7h-eCBRuegTkxWUGOpDew@mail.gmail.com>

On Tue, Nov 25, 2025 at 05:34:04AM -0800, Bartosz Golaszewski wrote:
> On Mon, 24 Nov 2025 17:20:47 +0100, Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > To fix PCIe bridge resource allocation issues when powering PCIe
> > switches with the pwrctrl driver, introduce APIs to explicitly power
> > on and off all related devices simultaneously.
> >
> > Previously, the individual pwrctrl drivers powered on/off the PCIe devices
> > autonomously, without any control from the controller drivers. But to
> > enforce ordering w.r.t powering on the devices, these APIs will power
> > on/off all the devices at the same time.
> >
> > The pci_pwrctrl_power_on_devices() API recursively scans the PCI child
> > nodes, makes sure that pwrctrl drivers are bind to devices, and calls their
> > power_on() callbacks.
> >
> > Similarly, pci_pwrctrl_power_off_devices() API powers off devices
> > recursively via their power_off() callbacks.
> >
> > These APIs are expected to be called during the controller probe and
> > suspend/resume time to power on/off the devices. But before calling these
> > APIs, the pwrctrl devices should've been created beforehand using the
> > pci_pwrctrl_{create/destroy}_devices() APIs.
> >
> > Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/pwrctrl/core.c  | 121 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-pwrctrl.h |   4 ++
> >  2 files changed, 125 insertions(+)
> >
> > diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> > index 6eca54e0d540..e0a0cf015bd0 100644
> > --- a/drivers/pci/pwrctrl/core.c
> > +++ b/drivers/pci/pwrctrl/core.c
> > @@ -65,6 +65,7 @@ void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
> >  {
> >  	pwrctrl->dev = dev;
> >  	INIT_WORK(&pwrctrl->work, rescan_work_func);
> > +	dev_set_drvdata(dev, pwrctrl);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
> >
> > @@ -152,6 +153,126 @@ int devm_pci_pwrctrl_device_set_ready(struct device *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
> >
> > +static int __pci_pwrctrl_power_on_device(struct device *dev)
> 
> Both this and __pci_pwrctrl_power_off_device() are only used once each. Does
> it really make sense to split it out?
> 

I just find it neat to split it out. Otherwise, the else condition looks clumsy
in pci_pwrctrl_power_on_device().

> > +{
> > +	struct pci_pwrctrl *pwrctrl = dev_get_drvdata(dev);
> > +
> > +	if (!pwrctrl)
> > +		return 0;
> > +
> > +	return pwrctrl->power_on(pwrctrl);
> > +}
> > +
> > +/*
> > + * Power on the devices in a depth first manner. Before powering on the device,
> > + * make sure its driver is bound.
> > + */
> > +static int pci_pwrctrl_power_on_device(struct device_node *np)
> > +{
> > +	struct platform_device *pdev;
> > +	int ret;
> > +
> > +	for_each_available_child_of_node_scoped(np, child) {
> > +		ret = pci_pwrctrl_power_on_device(child);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	pdev = of_find_device_by_node(np);
> > +	if (pdev) {
> > +		if (!device_is_bound(&pdev->dev)) {
> > +			dev_err(&pdev->dev, "driver is not bound\n");
> 
> This is not an error though, is it? If there are multiple deferalls, we'll
> spam the kernel log.
> 

Good question. Initially, I made it as a debug log, but then realized that
people may wonder why their controller driver encounters probe deferral without
much clue, especially when the driver spits out other logs before calling this
API. So decided to make it dev_err() to give a visual indication.

If it is not preferred, I can demote it to debug log.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

