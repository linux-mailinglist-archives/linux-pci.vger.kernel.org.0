Return-Path: <linux-pci+bounces-5165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D5288BF45
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 11:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DF51C3D0BF
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 10:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40186BFCB;
	Tue, 26 Mar 2024 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2r619DL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2AF5C911;
	Tue, 26 Mar 2024 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448665; cv=none; b=tnAJFsNvd0gh3Y3KzbMvJleYfyPqGHrbZ1MgWCkglVDqWjGMntLHeAGsevMt+JRTDlk/lDxIW80KDZJ5I/5erEPfa6ww2YHFsqk4X9xD314SC75WSLqeYCNoIjSBEj1guESwICzuXr3GcRso9N4Yvh3IHTlwiT0C65H7A/nYaIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448665; c=relaxed/simple;
	bh=ZkbHCq6nAL0MIaIZEtKSB6EEfdQdN64B2/Jl1eMR0RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT6DWZy0/dRPgQWq/was24CJyiEp0EPYaKk6IJOULYJPTx6oBqksXMzWqnbORAdYGo7k60OeMLScongS0j+LBUIrDRV8+zHH/gYN5IXkWXDYmQMZFRLn3P9GLyUKGCHRjtwi/sUuRyxp+U9szSu7QalbhXlaRSCMg2RYiEkpJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2r619DL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB07FC433F1;
	Tue, 26 Mar 2024 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711448665;
	bh=ZkbHCq6nAL0MIaIZEtKSB6EEfdQdN64B2/Jl1eMR0RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2r619DLhNC10h/q01WXZyG3D9Lx1CmqGmcxGAhui0+34BpHk+Y2EtptfqDzY5x9A
	 qlIKZlbcmPq5DM81PNrXZQVR/VC4WGPS8KHfLAOFXPBl4spLFZdgwdqE1w6bgE0G1c
	 CG7xUr/FETI8rnJRcIGgyr7ahE2HKJwDBOC0vzDKCgX/6zTKNAOGxW0Zh9TNMJM6e/
	 UH9u1ElIIsLbv7431IcQ3apZtT77bQzpYF33e+nlzRz5Ltk7EEaLCW3JJcA97ELNWY
	 +VxWcSi40qO77OMoPIERYzGnUWhR+RHOsVKslT9Wv8IobfyYzHB8rvEl7ILg4otZ3X
	 LnP7rrsx4ggEA==
Date: Tue, 26 Mar 2024 11:24:18 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 01/11] PCI: qcom-ep: Disable resources unconditionally
 during PERST# assert
Message-ID: <ZgKiUogkgrMwV1uD@x1-carbon>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-1-6134e6c1d491@linaro.org>
 <Zf2s9kTMlZncldWx@ryzen>
 <20240326074429.GC9565@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326074429.GC9565@thinkpad>

On Tue, Mar 26, 2024 at 01:14:29PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Mar 22, 2024 at 05:08:22PM +0100, Niklas Cassel wrote:
> > On Thu, Mar 14, 2024 at 08:53:40PM +0530, Manivannan Sadhasivam wrote:
> > > All EP specific resources are enabled during PERST# deassert. As a counter
> > > operation, all resources should be disabled during PERST# assert. There is
> > > no point in skipping that if the link was not enabled.
> > > 
> > > This will also result in enablement of the resources twice if PERST# got
> > > deasserted again. So remove the check from qcom_pcie_perst_assert() and
> > > disable all the resources unconditionally.
> > > 
> > > Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > index 2fb8c15e7a91..50b1635e3cbb 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > @@ -500,12 +500,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
> > >  static void qcom_pcie_perst_assert(struct dw_pcie *pci)
> > >  {
> > >  	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > > -	struct device *dev = pci->dev;
> > > -
> > > -	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED) {
> > > -		dev_dbg(dev, "Link is already disabled\n");
> > > -		return;
> > > -	}
> > >  
> > >  	dw_pcie_ep_cleanup(&pci->ep);
> > >  	qcom_pcie_disable_resources(pcie_ep);
> > 
> > Are you really sure that this is safe?
> > 
> > I think I remember seeing some splat in dmesg if some clks, or maybe it
> > was regulators, got disabled while already being disabled.
> > 
> > Perhaps you could test it by simply calling:
> > qcom_pcie_disable_resources();
> > twice here, and see if you see and splat in dmesg.
> > 
> 
> Calling the disable_resources() function twice will definitely result in the
> splat. But here PERST# is level triggered, so I don't see how the EP can see
> assert twice.
> 
> Am I missing something?

I think I remember now, I was developing a driver using a .core_init_notifier,
but I followed the pcie-tegra model, which does not enable any resources in
probe() (it only gets them), so I got the splat because when PERST got
asserted, resources would get disabled even though they were already disabled.

pcie-qcom:
-gets resources in .probe()
-enables resources in .probe()
-sets no default state in .probe()

pcie-tegra:
-gets resources in .probe()
-enables resources in perst_deassert()
-sets default state to EP_STATE_DISABLED in probe()

So pcie-qcom does not seem to be following the same pattern like pcie-tegra,
because pcie-qcom actually does enable resources for the first time in
probe(), while tegra will enable resources for the first time in
perst_deassert().

Sorry for the noise.


Kind regards,
Niklas

