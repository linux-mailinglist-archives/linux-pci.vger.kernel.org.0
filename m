Return-Path: <linux-pci+bounces-32135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D65AB05603
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 11:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC9456257B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AAF2D5420;
	Tue, 15 Jul 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOgvB81X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF733277CB0;
	Tue, 15 Jul 2025 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570837; cv=none; b=hJUN3UaH4h8ukI1/4Eg5MxJpeDmO/qqsPOrTZPAGJxbVMsjN8s6dwvIWycxrb37stOdKBuB6wttmfUce4zMbCiykfWr+Q0N79Fnw5u+LIfp+wbPS2GHaXbTnlbW+GUtflVAe1NCL99jg4qjkzBv2cu49XKl64gYDLXTBwaUMbKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570837; c=relaxed/simple;
	bh=l/RGES8DH2ekgRfnlC6sXT+q0PRN/1KSbMb1r4knNYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1/TbnVp0qmL5M2FJaAaw8XR7kmgB0zl8UL+NwZlSGbLDdIRzSGhmFrEjSvnKU8VmITglEzzJq1cKspRr9aBeqsIaT/IBDoB3jmBizD6REdPOnqVye1Ztf4TbU8qNgDvZpc5a8Vs8xiRE6IX72gnvRE2aj2AzKcMvMJ8RvxJnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOgvB81X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73666C4CEE3;
	Tue, 15 Jul 2025 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752570837;
	bh=l/RGES8DH2ekgRfnlC6sXT+q0PRN/1KSbMb1r4knNYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOgvB81X6Jde2+HwT/fcT7T/nuc63d/Pw6RVWTKk2CeseGr+70BE9fiDk4wL4MOF1
	 ErFvboJavhDjunHVR/Bd+3dhUrWNKSiw5mi+8kUUcexHrjBGxMRlPVxkqnByzSQXja
	 aARC2own7LhuZwsOI/FmdmUKly86e2F6nfD/pYSQf6ZSOD9wlDdkm9oN5QDin1XByE
	 e2KzmxJzuYph66syHkdU+wrTowRli0f6ZtS7Wq7a7VReHedJL9iSOQzE49hhXbIYJq
	 WOkWyT8yTlRay32Rx898BMWVfAxKH+ZX/LbuavAeJaQ0Wf7bXM0TBfZfPS+thNp95w
	 gnh3y7yEfCg4g==
Date: Tue, 15 Jul 2025 14:43:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
Message-ID: <jkv4rbx324gzndmzfmjkkft7kmukz6eukjwg4rdgmfpmxj5cjn@ewhc3wfdcqx3>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
 <aHYIjEbOhM4xvavJ@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHYIjEbOhM4xvavJ@hovoldconsulting.com>

On Tue, Jul 15, 2025 at 09:51:40AM GMT, Johan Hovold wrote:
> On Mon, Jul 14, 2025 at 11:31:05PM +0530, Manivannan Sadhasivam wrote:
> > It allows us to group all the settings that need to be done when a PCI
> > device is attached to the bus in a single place.
> 
> This commit message should be amended so that it makes sense on its own
> (e.g. without Subject).
> 
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
> I guess you should also drop the now redundant
> qcom_pcie_icc_opp_update() call from probe()?
> 

Oops. This got sneaked in. I removed it locally but eventually lost the change
while rebasing. Will remove it in next version. This API just bails out if the
link is not up. So no reason to call it here also now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

