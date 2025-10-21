Return-Path: <linux-pci+bounces-38882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B116EBF679C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6BF46084C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6691F3D56;
	Tue, 21 Oct 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5Xs1FJ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3AD1F956;
	Tue, 21 Oct 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050123; cv=none; b=gRVFgbmPQsD3uFeAXuA5PPSlnPmHuI8pgXh6qhRNqaJ61ZNKfFXup9ZbTi33xxPz5f4C+O4DJSzscQzzgv8Akgo4MB551myOnoRIui5X3WBVH/x+DiDLqz8XG43ZE3Nz2my3GZf/inAqpzRBygP6u4etpl3NNhJ7i8pCdq60sSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050123; c=relaxed/simple;
	bh=vFnVtSPbyPTEjkoeyLNfM/J8eCQptnRUb2kkNBw5Jqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryC/CUPyDJFgtqq97kgd0YM6nEQC79OjbYNG5EsThQ6qzn5zbk4kLDOYR+nqgC1M8jqqk0EMnVPeNXv7pDYQeiqHXo7JxexdOlY54pkJeRs9AtcmGIyL7tFeZtEntY37215yzK1eDXvCpldRNpKwRhzM82SLVKKRyVqsO7O1KV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5Xs1FJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AC5C4CEF1;
	Tue, 21 Oct 2025 12:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761050123;
	bh=vFnVtSPbyPTEjkoeyLNfM/J8eCQptnRUb2kkNBw5Jqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5Xs1FJ6oLvLfbf3Z6LEFGNGr4+moq83sE9b9oR70Zt76s8I94g66zVPpdgxywQk2
	 r+3KJeYjhU43AaRnoHn84XBlAv/+Zq/ukl3H21cq00HkfG7xxkW8cmFYF0ktaFfrel
	 zLYeo46wCIvyI1IzmBYXuxMcAUNdeM8rd0QWRZb/3AHeRlP/cXx13O+FdFU/XBfk8k
	 KjJo6V/Yd69P7qzkC6czt19QhZWP6xgEW5kiL8gNF9tUuXymLAJN3ALdYY7voRuL4C
	 bdPUjwfQUZTUf3i/PqU6L8unYDMqFOPp4x+t7TAf1HZUgBhVZ6K3iZvGfEbKD43y0p
	 B2S1FB6Uw69DQ==
Date: Tue, 21 Oct 2025 18:05:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Christian Zigotzky <chzigotzky@xenosoft.de>, FUKAUMI Naoki <naoki@radxa.com>, linux-rockchip@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Message-ID: <2wv7662f23seqtifn4zkud6xlecfhpeso4rn72syn6q2ts6sm5@cllw6gyv2xwx>
References: <20251020221217.1164153-1-helgaas@kernel.org>
 <lmkrtyq6uzhzlz5ttvajnmojegrbfgaz3e3kkwej5qar2lkeof@r5gdlvesm6xl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lmkrtyq6uzhzlz5ttvajnmojegrbfgaz3e3kkwej5qar2lkeof@r5gdlvesm6xl>

On Tue, Oct 21, 2025 at 09:31:32AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Oct 20, 2025 at 05:12:07PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree
> > platforms") enabled Clock Power Management and L1 Substates, but that
> > caused regressions because these features depend on CLKREQ#, and not all
> > devices and form factors support it.
> 
> I believe we haven't concluded that CLKREQ# is the cluprit here. It is probably
> the best bet, but there could be the device specific issues as well.
> 
> > 
> > Enable only ASPM L0s and L1, and only when both ends of the link advertise
> > support for them.
> > 
> > Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> > Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> > Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de/
> 
> Closes?
> 
> > Reported-by: FUKAUMI Naoki <naoki@radxa.com>
> > Link: https://lore.kernel.org/r/22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com/
> 
> Same here.
> 
> > ---
> > 
> > Mani, not sure what you think we should do here.  Here's a stab at it as a
> > strawman and in case anybody can test it.
> > 
> 
> Thanks Bjorn! I had a similar change slated to be sent post Diwali, but you beat
> me to it.
> 
> > Not sure about the message log message.  Maybe OK for testing, but might be
> > overly verbose ultimately.
> > 
> 
> Let's have it for sometime, so we have some clue when someone reports issue with
> ASPM.
> 
> > ---
> >  drivers/pci/pcie/aspm.c | 34 +++++++++-------------------------
> >  1 file changed, 9 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 7cc8281e7011..dbc74cc85bcb 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -243,8 +243,7 @@ struct pcie_link_state {
> >  	/* Clock PM state */
> >  	u32 clkpm_capable:1;		/* Clock PM capable? */
> >  	u32 clkpm_enabled:1;		/* Current Clock PM state */
> > -	u32 clkpm_default:1;		/* Default Clock PM state by BIOS or
> > -					   override */
> > +	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
> >  	u32 clkpm_disable:1;		/* Clock PM disabled */
> >  };
> >  
> > @@ -376,18 +375,6 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
> >  	pcie_set_clkpm_nocheck(link, enable);
> >  }
> >  
> > -static void pcie_clkpm_override_default_link_state(struct pcie_link_state *link,
> > -						   int enabled)
> > -{
> > -	struct pci_dev *pdev = link->downstream;
> > -
> > -	/* For devicetree platforms, enable ClockPM by default */
> > -	if (of_have_populated_dt() && !enabled) {
> > -		link->clkpm_default = 1;
> > -		pci_info(pdev, "ASPM: DT platform, enabling ClockPM\n");
> > -	}
> > -}
> > -
> >  static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> >  {
> >  	int capable = 1, enabled = 1;
> > @@ -410,7 +397,6 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> >  	}
> >  	link->clkpm_enabled = enabled;
> >  	link->clkpm_default = enabled;
> > -	pcie_clkpm_override_default_link_state(link, enabled);
> >  	link->clkpm_capable = capable;
> >  	link->clkpm_disable = blacklist ? 1 : 0;
> >  }
> > @@ -811,19 +797,17 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
> >  	struct pci_dev *pdev = link->downstream;
> >  	u32 override;
> >  
> > -	/* For devicetree platforms, enable all ASPM states by default */
> > +	/* For devicetree platforms, enable L0s and L1 by default */
> >  	if (of_have_populated_dt()) {
> > -		link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
> > +		if (link->aspm_support & PCIE_LINK_STATE_L0S)
> > +			link->aspm_default |= PCIE_LINK_STATE_L0S;
> > +		if (link->aspm_support & PCIE_LINK_STATE_L1)
> > +			link->aspm_default |= PCIE_LINK_STATE_L1;
> 
> Not sure if it is worth setting these states conditionally. Link state
> enablement code should make use of the cached ASPM cap in 'link->aspm_capable'.
> 

I see the point now. Without the check, we falsely claim that the ASPM states
are getting enabled. But we cannot be sure until the register write to LNKCTL
happens, which will depend on many factors (own device capability,
upstream/downstream port capability,...)

To avoid ambiguity, can we reword the log to something like,

	"ASPM: Overridding default states %s%s\n"

- Mani

-- 
மணிவண்ணன் சதாசிவம்

