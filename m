Return-Path: <linux-pci+bounces-31755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF338AFE1EE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 10:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C72A1C4152C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFAB233159;
	Wed,  9 Jul 2025 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8JuAV/6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79535625;
	Wed,  9 Jul 2025 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048318; cv=none; b=peC5zzC97lpH1aK9O5sJERK94OT3ZYO4sDqLt9DL2p73BwBvk+kljt/Ls8B6inGyXXuHFC5QoFjqpMLJF84KoOkgfVyX3asX5rPlSNJfSZBbcVXVui2qiBYGC5ADgqjBarzTWO1mvI4SQH/sRFGP435nJQS50mL3/LqPz/hk37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048318; c=relaxed/simple;
	bh=PHFvslbn1dHlskTevgGPTlrGpDxkF+3vYBfYx9dm7QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkYdoRs9fvnAC8Dvky8coZPZiDVbrxTLExtlCjUZb2pXh+CyLGDOAOF/K1/a7cN+Keq+hdrfLTCCXqK2N1NGLQMVu/EvPtIeQQhR8GOe4X6AqZSsJsY5lrYphn4INPrI5pV2Q3KmZsVDR9XRJMWoDAFzXf+36qEi3cLU6GlkqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8JuAV/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAACC4CEEF;
	Wed,  9 Jul 2025 08:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752048318;
	bh=PHFvslbn1dHlskTevgGPTlrGpDxkF+3vYBfYx9dm7QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8JuAV/6EPqKfTmJvV9BtrmecFukxAnweZODl2FBKCQLsZhyBuAGQ1tDQppgHAi6e
	 aT2wVmgLftJUA1ljZHnkKVvKZGkseDj87HRl5SjKH87WplbCuhVqW7SLZkPKJpxUjP
	 Ax+oq4uyaa09YQ6cRR4cReFdX2AE7ir7kut9R6gr54S/N+XMpMkDT4tvhoFwzja0ek
	 wdN+HcM775i7vYwGZYwXdsH1NB7iLsb0UGuA4tAFILcGMnEHUJkdE2DALlcBtIlSsF
	 aJEUkfZYNXsRAsFzgcj0SjUd3ZKc9sNwzo6oQX+mxQrdSbku3LXsx6xF7NonQ6oxI8
	 JiPntU/199ASA==
Date: Wed, 9 Jul 2025 13:35:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 2/3] PCI/pwrctrl: Allow pwrctrl core to control
 PERST# GPIO if available
Message-ID: <kl5rsst6p2lgnepopxij5o6vyca4abrjlktsirfac3v7cnm33l@svrcm7v4gasr>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <20250707-pci-pwrctrl-perst-v1-2-c3c7e513e312@kernel.org>
 <aG3e26yjO4I1WSnG@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aG3e26yjO4I1WSnG@google.com>

On Tue, Jul 08, 2025 at 08:15:39PM GMT, Brian Norris wrote:
> Hi Manivannan,
> 
> On Mon, Jul 07, 2025 at 11:48:39PM +0530, Manivannan Sadhasivam wrote:
> > PERST# is an (optional) auxiliary signal provided by the PCIe host to
> > components for signalling 'Fundamental Reset' as per the PCIe spec r6.0,
> > sec 6.6.1.
> > 
> > If PERST# is available, it's state will be toggled during the component
> > power-up and power-down scenarios as per the PCI Express Card
> > Electromechanical Spec v4.0, sec 2.2.
> > 
> > Historically, the PCIe controller drivers were directly controlling the
> > PERST# signal together with the power supplies. But with the advent of the
> > pwrctrl framework, the power supply control is now moved to the pwrctrl,
> > but controller drivers still ended up toggling the PERST# signal.
> 
> [reflowed:]
> > This only happens on Qcom platforms where pwrctrl framework is being
> > used.
> 
> What do you mean by this sentence? That this problem only occurs on Qcom
> platforms? (I believe that's false.) Or that the problem doesn't occur
> if the platform is not using pwrctrl? (i.e., it maintained power in some
> other way, before the controller driver gets involved. I believe this
> variation is correct.)
> 

The latter one. I will rephrase this sentence in next version.

> > But
> > nevertheseless, it is wrong to toggle PERST# (especially deassert) without
> > controlling the power supplies.
> > 
> > So allow the pwrctrl core to control the PERST# GPIO is available. The
> 
> s/is/if/
> 
> ?
> 
> > controller drivers still need to parse them and populate the
> > 'host_bridge->perst' GPIO descriptor array based on the available slots.
> > Unfortunately, we cannot just move the PERST# handling from controller
> > drivers as most of the controller drivers need to assert PERST# during the
> > controller initialization.
> > 
> > Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  drivers/pci/pwrctrl/core.c  | 39 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-pwrctrl.h |  2 ++
> >  include/linux/pci.h         |  2 ++
> >  3 files changed, 43 insertions(+)
> > 
> > diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> > index 6bdbfed584d6d79ce28ba9e384a596b065ca69a4..abdb46399a96c8281916f971329d5460fcff3f6e 100644
> > --- a/drivers/pci/pwrctrl/core.c
> > +++ b/drivers/pci/pwrctrl/core.c
> 
> >  static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
> >  			      void *data)
> >  {
> > @@ -56,11 +61,42 @@ static void rescan_work_func(struct work_struct *work)
> >   */
> >  void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
> >  {
> > +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dev->parent);
> > +	int devfn;
> > +
> >  	pwrctrl->dev = dev;
> >  	INIT_WORK(&pwrctrl->work, rescan_work_func);
> > +
> > +	if (!host_bridge->perst)
> > +		return;
> > +
> > +	devfn = of_pci_get_devfn(dev_of_node(dev));
> > +	if (devfn >= 0 && host_bridge->perst[PCI_SLOT(devfn)])
> > +		pwrctrl->perst = host_bridge->perst[PCI_SLOT(devfn)];
> 
> It seems a little suspect that we trust the device tree slot
> specification to not overflow the perst[] array. I think we can
> reasonably mitigate that in the controller driver (so, patch 3 in this
> series), but I want to call that out, in case there's something we can
> do here too.
> 
> >  }
> >  EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
> >  
> > +static void pci_pwrctrl_perst_deassert(struct pci_pwrctrl *pwrctrl)
> > +{
> > +	/* Bail out early to avoid the delay if PERST# is not available */
> > +	if (!pwrctrl->perst)
> > +		return;
> > +
> > +	msleep(PCIE_T_PVPERL_MS);
> > +	gpiod_set_value_cansleep(pwrctrl->perst, 0);
> 
> What if PERST# was already deasserted? On one hand, we're wasting time
> here if so. On the other, you're not accomplishing your spec-compliance
> goal if it was.
> 

If controller drivers populate 'pci_host_bridge::perst', then they should not
deassert PERST# as they don't control the supplies. I've mentioned it in the
cover letter, but I will mention it in commit message also.

> > +	/*
> > +	 * FIXME: The following delay is only required for downstream ports not
> > +	 * supporting link speed greater than 5.0 GT/s.
> > +	 */
> > +	msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);
> 
> Should this be PCIE_RESET_CONFIG_DEVICE_WAIT_MS or PCIE_T_RRS_READY_MS?
> Or are those describing the same thing? It seems like they were added
> within a month or two of each other, so maybe they're just duplicates.
> 

You are right. This is already taken care in:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/linkup-fix&id=bbc6a829ad3f054181d24a56944f944002e68898

I will rebase the next version on top of pci/next to make use of it.

> BTW, I see you have a FIXME here, but anyway, I wonder if both of the
> msleep() delays in this function will need some kind of override (e.g.,
> via Device Tree), since there's room for implementation or form factor
> differences, if I'm reading the spec correctly. Maybe that's a question
> for another time, with actual proof / use case.
> 

First delay cannot be skipped as both PCIe CEM and M.2 FF, mandates this delay.
Though, M.2 mandates only a min delay of 50ms, and leaves the value to be
defined by the vendor. So a common 100ms would be on the safe side.

For the second delay, it comes from the PCIe spec itself. Refer r6.0, sec
6.6.1. So we cannot skip that, though we should only need it if the link is
operating at <= 5.0 GT/s. Right now, I haven't implemented the logic to detect
the link speed, hence the TODO.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

