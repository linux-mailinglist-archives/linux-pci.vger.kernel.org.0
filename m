Return-Path: <linux-pci+bounces-32234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4AB06E2D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 08:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC74E4A4459
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90881219300;
	Wed, 16 Jul 2025 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D69Z7lYm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B92A946C;
	Wed, 16 Jul 2025 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648414; cv=none; b=OA2bTyOPyS2JOJMzyJNIhANwFumpKlsjoZLl8bUoUM5C9aYRxPAEPWoy9HZx7JuzRv1ZCMiLAeluvZLsbkyixVEj0HQuu9iK3X5+FsJvciGLVGXbNHI+m4LmoQf6kaTN7OO2RmdCB0K2ot4tE8uwuP+fWno/avZtrSYVsFKbt4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648414; c=relaxed/simple;
	bh=dekmnBHsI8H/8ZSJKbqN4yDUeZEh6K6aQQaHLWxGQuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEREbOp4zgVLlGR4eWyTV+vSSj4miC6pe9VoGkkgqP33U6E+kGwWPEjSZ2qnWUr9m3KsZ3AIfavz7fCIPDP/hUmxhtHb2/qJvvarTpHOChtZpUHalMZ3DLB8vU8c1C4l3l4E4MscVvhj3Xg911ebeCKPH6/O2LsT0hnIGLCznKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D69Z7lYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E49C4CEF0;
	Wed, 16 Jul 2025 06:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752648413;
	bh=dekmnBHsI8H/8ZSJKbqN4yDUeZEh6K6aQQaHLWxGQuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D69Z7lYmx1h67mNQ6tg1crx83Z53yGBMhXxn3Vov2/RFq+LhIKx118NzYTC918nIx
	 x3qFK0OsG0Ho+EGToNZoCjpvuiNy96e4Cnb6CRDV4qtpRwXP8Hj/ofOonU70DITvF7
	 XD4tctlR3kQY67eGmAymmCIxgWy9cdTYHdw7wfdAapGcWvAE8BXdAO+fBYHsmbvmzI
	 OEDZYWFZbtyfWpZcFXcOGNe0N8gmEU2llyIM+67dBTmpo2tedO4A+N3JHrl8u1+/Nx
	 2mdpVT0CAhvns8rCGjUuQojot1D3tEOWAzeA30UI6+ITY6AUs9hYyYipxZ408B3BH9
	 ycKrx6Op/WlQA==
Date: Wed, 16 Jul 2025 12:16:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
Message-ID: <qg4dof65dyggzgvkroeo2suhhnvosqs3dnkrmsqpbf4z67dcht@ltzirahk2mxd>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
 <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>
 <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
 <eccae2e8-f158-4501-be21-e4188e6cbd84@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eccae2e8-f158-4501-be21-e4188e6cbd84@oss.qualcomm.com>

On Wed, Jul 16, 2025 at 10:24:23AM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/15/2025 4:06 PM, Manivannan Sadhasivam wrote:
> > On Tue, Jul 15, 2025 at 11:54:48AM GMT, Konrad Dybcio wrote:
> > > On 7/14/25 8:01 PM, Manivannan Sadhasivam wrote:
> > > > It allows us to group all the settings that need to be done when a PCI
> > > > device is attached to the bus in a single place.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
> > > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index b4993642ed90915299e825e47d282b8175a78346..b364977d78a2c659f65f0f12ce4274601d20eaa6 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -1616,8 +1616,6 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
> > > >   		pci_lock_rescan_remove();
> > > >   		pci_rescan_bus(pp->bridge->bus);
> > > >   		pci_unlock_rescan_remove();
> > > > -
> > > > -		qcom_pcie_icc_opp_update(pcie);
> > > >   	} else {
> > > >   		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
> > > >   			      status);
> > > > @@ -1765,6 +1763,7 @@ static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
> > > >   	switch (action) {
> > > >   	case BUS_NOTIFY_BIND_DRIVER:
> > > >   		qcom_pcie_enable_aspm(pdev);
> > > > +		qcom_pcie_icc_opp_update(pcie);
> > > 
> > > So I assume that we're not exactly going to do much with the device if
> > > there isn't a driver for it, but I have concerns that since the link
> > > would already be established(?), the icc vote may be too low, especially
> > > if the user uses something funky like UIO
> > > 
> > 
> > Hmm, that's a good point. Not enabling ASPM wouldn't have much consequence, but
> > not updating OPP would be.
> > 
> > Let me think of other ways to call these two APIs during the device addition. If
> > there are no sane ways, I'll drop *this* patch.
> > 
> How about using enable_device in host bridge, without pci_enable_device
> call the endpoints can't start the transfers. May be we can use that.
> 

Q: Who is going to call pci_enable_device()?
A: The PCI client driver

This is same as relying on BUS_NOTIFY_BIND_DRIVER notifier.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

