Return-Path: <linux-pci+bounces-32239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73A9B06ECB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 09:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A65F167246
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 07:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DD4277028;
	Wed, 16 Jul 2025 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rF9CvnPI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87F256C6D;
	Wed, 16 Jul 2025 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650340; cv=none; b=YDR2GC0gXXxPqznEJ4nPiSHnoD8ueLjASNjojcIznSaS8QTCSwwXMldLdNQZCZKW2lZWWFMaYDnN3r9VsYyrm7exhIEg+eEDG2+mpV6JLraZhKsJx5UbpTF4O+6K1ey9+69eGMg5zujfJtWk2f3g6yTJR/DGtBM/qk/LlgnT1lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650340; c=relaxed/simple;
	bh=ft9NQ3VgWxxomwjuMEIjAFvCizB7sBVk+rQ5QVmSgk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnFa4c3yrdCOzlET9mBiyRM0xnKM8e8Q12hO8WytqMaZWUvmy9IgjlSDzL7sxcUtsslGFl1B3aiYEuQlYvRTHdjEnAeCmZl6FN8ggXArNnjorSkuMc/xoJobD2g+v31LjIiugcPRYIPbIqEVBB5BM8Ba7Ei42RqS4A34CBT42UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rF9CvnPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A1CC4CEF0;
	Wed, 16 Jul 2025 07:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752650340;
	bh=ft9NQ3VgWxxomwjuMEIjAFvCizB7sBVk+rQ5QVmSgk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rF9CvnPI38e1mLuhLYgfICUzIGSzoemT9H1BkbWJK9IMG2n8HZ7IYrRGK+ds20qht
	 SnFkGhmMsVeZsdKU7pfY/qKzAEhEOgeG8+8014/4ONQTib76gY54pgDldKCVWl5rTQ
	 yH8YFVwZx+16s4cIGvJd2YTqfECB4n5ZDAOdYu2bgFH2/jFXhUu5B39sgArdv9lczz
	 ugTuyIzSeXXoeNMIJBA/KC7xecgX2ETgBnkyFI54xwsVa0OAjfERv4EfNj2sYdMZaA
	 +OzehTgdXJhlPeYDoTyNHejp6JGhz23gl7Ui4Ulp5oBMSg3n22wQGZg25DxlrU4hiB
	 sBd35yZWOzETw==
Date: Wed, 16 Jul 2025 12:48:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
Message-ID: <itpv65wevbe62cvqpypw34u2htaycnk66msaguufynrpt2iqwj@z6m4bjp4ws7r>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
 <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>
 <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
 <eccae2e8-f158-4501-be21-e4188e6cbd84@oss.qualcomm.com>
 <qg4dof65dyggzgvkroeo2suhhnvosqs3dnkrmsqpbf4z67dcht@ltzirahk2mxd>
 <ead761e1-2b48-4b9d-90cc-f63463a97f60@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ead761e1-2b48-4b9d-90cc-f63463a97f60@quicinc.com>

On Wed, Jul 16, 2025 at 12:23:54PM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/16/2025 12:16 PM, Manivannan Sadhasivam wrote:
> > On Wed, Jul 16, 2025 at 10:24:23AM GMT, Krishna Chaitanya Chundru wrote:
> > > 
> > > 
> > > On 7/15/2025 4:06 PM, Manivannan Sadhasivam wrote:
> > > > On Tue, Jul 15, 2025 at 11:54:48AM GMT, Konrad Dybcio wrote:
> > > > > On 7/14/25 8:01 PM, Manivannan Sadhasivam wrote:
> > > > > > It allows us to group all the settings that need to be done when a PCI
> > > > > > device is attached to the bus in a single place.
> > > > > > 
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > > > ---
> > > > > >    drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
> > > > > >    1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > > index b4993642ed90915299e825e47d282b8175a78346..b364977d78a2c659f65f0f12ce4274601d20eaa6 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > > @@ -1616,8 +1616,6 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
> > > > > >    		pci_lock_rescan_remove();
> > > > > >    		pci_rescan_bus(pp->bridge->bus);
> > > > > >    		pci_unlock_rescan_remove();
> > > > > > -
> > > > > > -		qcom_pcie_icc_opp_update(pcie);
> > > > > >    	} else {
> > > > > >    		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
> > > > > >    			      status);
> > > > > > @@ -1765,6 +1763,7 @@ static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
> > > > > >    	switch (action) {
> > > > > >    	case BUS_NOTIFY_BIND_DRIVER:
> > > > > >    		qcom_pcie_enable_aspm(pdev);
> > > > > > +		qcom_pcie_icc_opp_update(pcie);
> > > > > 
> > > > > So I assume that we're not exactly going to do much with the device if
> > > > > there isn't a driver for it, but I have concerns that since the link
> > > > > would already be established(?), the icc vote may be too low, especially
> > > > > if the user uses something funky like UIO
> > > > > 
> > > > 
> > > > Hmm, that's a good point. Not enabling ASPM wouldn't have much consequence, but
> > > > not updating OPP would be.
> > > > 
> > > > Let me think of other ways to call these two APIs during the device addition. If
> > > > there are no sane ways, I'll drop *this* patch.
> > > > 
> > > How about using enable_device in host bridge, without pci_enable_device
> > > call the endpoints can't start the transfers. May be we can use that.
> > > 
> > 
> > Q: Who is going to call pci_enable_device()?
> > A: The PCI client driver
> > 
> > This is same as relying on BUS_NOTIFY_BIND_DRIVER notifier.
> > 
> userspace can enable device using sysfs[1] without attaching
> any kernel drivers.
> 

But that's not a common usecase. Even so, we cannot insist users to write to the
sysfs knob to let ASPM/OPP work without a driver.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

