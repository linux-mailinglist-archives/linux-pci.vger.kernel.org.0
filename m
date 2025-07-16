Return-Path: <linux-pci+bounces-32223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384C1B06D2E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 07:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940CF189D3CC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 05:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293E270EBD;
	Wed, 16 Jul 2025 05:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snDUiCqG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B62134BD;
	Wed, 16 Jul 2025 05:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752643691; cv=none; b=TBttkvJltxmPVPpyvgnjUE9YUONj7kzTW8pBAJ8EFWKI/FFgJDKL9CF45bTD4Ta9981LZ84h1qbFzndjJ84MPb1PsDb9NAEhcOudLsgTiWONn7CYykyaeD2Pi+zPP/idoFfvY2J8JJcpaBOuqtPCpFyMiTtvlT5CpGemeomXJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752643691; c=relaxed/simple;
	bh=9O93w4B7Hk3WGCGlAA9pG4sEPSW2m4KxTBY8MylOZhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m652hWgBH2gWfd4Q8k/jYqrt4G2QDIz5ymZ/s+YuX8PaXvvKMhBohiwMpNBT2Zn0DBG9pMkjn27Oio3BHwZa/LHGtq9WFrh6gi7S3TUFUxJjAbo9VovwXwzToGpsp2Kw9jT78nJeVNSFrx6eN1GRIkZcDTbnz9V2xNKzgXuhfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snDUiCqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C45CC4CEF0;
	Wed, 16 Jul 2025 05:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752643691;
	bh=9O93w4B7Hk3WGCGlAA9pG4sEPSW2m4KxTBY8MylOZhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snDUiCqGE+4XXcQLWm/p/ERjkuprsYJajXTwWYRWhl5hSBejuJQE3owYtndGtd8dR
	 hTOUC6D+02JdAsXgjIGpjlq1uTi/RqkrP09ikXZwedX7j9KcDZqSts109BBGzPUZIN
	 xnjk+CxPQh8IByACuK3UtXzvt32iJWAehnvwKoS4Cxm3cZ5gUSLmnWAwWjadV01Ljx
	 PXiUnU+E28VNZBr/HK7uxyApsaiTx7gJEMVOuvYKn9VMeJBw++Qs4rriwhD9iLNxZ6
	 /LSTs8WrbSoyhR7+zPHSWaLra3IwnAnP+5QUQWzgb285U9b54BwNOjO0Ycnh3S5NU7
	 DdZeHw6p/xZGg==
Date: Wed, 16 Jul 2025 10:58:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
Message-ID: <kyu4bpuqvmc3iyqekmqvbpxqpbbxbq7df725dcpiu3dnvcztyy@yyqwm2uqjobj>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
 <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>
 <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
 <55f2e014-044c-4021-8b01-99bdf2a0fd7f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55f2e014-044c-4021-8b01-99bdf2a0fd7f@oss.qualcomm.com>

On Tue, Jul 15, 2025 at 12:45:36PM GMT, Konrad Dybcio wrote:
> On 7/15/25 12:36 PM, Manivannan Sadhasivam wrote:
> > On Tue, Jul 15, 2025 at 11:54:48AM GMT, Konrad Dybcio wrote:
> >> On 7/14/25 8:01 PM, Manivannan Sadhasivam wrote:
> >>> It allows us to group all the settings that need to be done when a PCI
> >>> device is attached to the bus in a single place.
> >>>
> >>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >>> ---
> >>>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
> >>>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >>> index b4993642ed90915299e825e47d282b8175a78346..b364977d78a2c659f65f0f12ce4274601d20eaa6 100644
> >>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >>> @@ -1616,8 +1616,6 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
> >>>  		pci_lock_rescan_remove();
> >>>  		pci_rescan_bus(pp->bridge->bus);
> >>>  		pci_unlock_rescan_remove();
> >>> -
> >>> -		qcom_pcie_icc_opp_update(pcie);
> >>>  	} else {
> >>>  		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
> >>>  			      status);
> >>> @@ -1765,6 +1763,7 @@ static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
> >>>  	switch (action) {
> >>>  	case BUS_NOTIFY_BIND_DRIVER:
> >>>  		qcom_pcie_enable_aspm(pdev);
> >>> +		qcom_pcie_icc_opp_update(pcie);
> >>
> >> So I assume that we're not exactly going to do much with the device if
> >> there isn't a driver for it, but I have concerns that since the link
> >> would already be established(?), the icc vote may be too low, especially
> >> if the user uses something funky like UIO
> >>
> > 
> > Hmm, that's a good point. Not enabling ASPM wouldn't have much consequence, but
> > not updating OPP would be.
> > 
> > Let me think of other ways to call these two APIs during the device addition. If
> > there are no sane ways, I'll drop *this* patch.
> 
> Would it be too naive to assume BUS_NOTIFY_ADD_DEVICE is a good fit?

BUS_NOTIFY_ADD_DEVICE is not currently a good fit as ASPM link state
initialization happen after all the devices are enumerated for the slot. This is
something to be fixed in the PCI core and would allow us to use
BUS_NOTIFY_ADD_DEVICE.

I talked to Bjorn H and we both agreed that this needs to be revisited. But I'm
just worrried that until this happens, we cannot upstream the ASPM fix and not
even backport it to 6.16/16.

So maybe we need to resort to this patch as an interim fix if everyone agrees.

> Do
> ASPM setting need to be reapplied after the PCIe device is reset? (well
> I would assume there are probably multiple levels of "reset" :/)
> 

I'm assuming that you are referring to link down reset here. PCI core takes care
of saving both the endpoint as well as Root Port config space when that happens
and restores them afterwards.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

