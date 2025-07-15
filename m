Return-Path: <linux-pci+bounces-32143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A55CB057F8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 12:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5BD7B21F8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11172D7807;
	Tue, 15 Jul 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmqDReYK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C224167B;
	Tue, 15 Jul 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575829; cv=none; b=GNbxlPPixuOmUVMXay146ggCeUEfHB0SZ9j7MwOmLwCWiez77K+WgFE7kmzQnenOuq5spZKCPhcAoX5mEoysMXo63smXhM9i9kDws97kQOadeHKlDpOO4J2toOfAJP42HhWNUJZO5Ok7PEneptUp6PGM3mBxncFhonjxBTZR+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575829; c=relaxed/simple;
	bh=CwV8NACOodZkn+P442AO0/+Cb1UGkGUDkZelMg7IKI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQoWjYdjyx8H52Cd7XvdTGNuMt9Nk0BUXeCABDFDyCyaMFmGt2KzkN0/U++MukxDbUJFcy6WJ37TEWtQQ89hOLJF84i7HClYVVWM6jaajUcYR791p+BOvOkm4gIba5noCZa/g3w3bZotVpMyZIiwO5MluXgkSOn4ddRVUMOTLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmqDReYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF39C4CEE3;
	Tue, 15 Jul 2025 10:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752575829;
	bh=CwV8NACOodZkn+P442AO0/+Cb1UGkGUDkZelMg7IKI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmqDReYKYUKIR1od3JUcHgQZL1aJrur1id/0IR5ViVMTo9FgxjPjElBXq55egu19x
	 24Ip/tJJItag/U3DXnPnxbh7Ya79+sGSVwZLRwfRWxwPHidydRvGchGnI/mkyevqKu
	 ri2rl1xNXdM6yU3VLZ+qnaU7YdYTk/ydbhV41U9zBSsFSrJGyDvN4zDqvydRVvivl1
	 utJP6n7utnoFrnp9yNiXg46egZAIUFXzBzfHDlm8EPJCt5LxGzIpXqogqQHFHVoArw
	 YD/Bqi/CGpkevIYKn6VVzjp/z0ux1rcMEf0nE6q3X+wbk2uJsLdo5NWeFNQVsFiUKJ
	 hwIyUA4jY+/+Q==
Date: Tue, 15 Jul 2025 16:06:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
Message-ID: <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
 <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>

On Tue, Jul 15, 2025 at 11:54:48AM GMT, Konrad Dybcio wrote:
> On 7/14/25 8:01 PM, Manivannan Sadhasivam wrote:
> > It allows us to group all the settings that need to be done when a PCI
> > device is attached to the bus in a single place.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index b4993642ed90915299e825e47d282b8175a78346..b364977d78a2c659f65f0f12ce4274601d20eaa6 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1616,8 +1616,6 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
> >  		pci_lock_rescan_remove();
> >  		pci_rescan_bus(pp->bridge->bus);
> >  		pci_unlock_rescan_remove();
> > -
> > -		qcom_pcie_icc_opp_update(pcie);
> >  	} else {
> >  		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
> >  			      status);
> > @@ -1765,6 +1763,7 @@ static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
> >  	switch (action) {
> >  	case BUS_NOTIFY_BIND_DRIVER:
> >  		qcom_pcie_enable_aspm(pdev);
> > +		qcom_pcie_icc_opp_update(pcie);
> 
> So I assume that we're not exactly going to do much with the device if
> there isn't a driver for it, but I have concerns that since the link
> would already be established(?), the icc vote may be too low, especially
> if the user uses something funky like UIO
> 

Hmm, that's a good point. Not enabling ASPM wouldn't have much consequence, but
not updating OPP would be.

Let me think of other ways to call these two APIs during the device addition. If
there are no sane ways, I'll drop *this* patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

