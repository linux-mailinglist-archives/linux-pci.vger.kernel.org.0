Return-Path: <linux-pci+bounces-44778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E8D203DE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9E073032AC6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9583A1E70;
	Wed, 14 Jan 2026 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oephiA0t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D83A0B39;
	Wed, 14 Jan 2026 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408635; cv=none; b=NOqt1xVlbA2zCDgBhwYd4+2Jxg54syzoWhbD9u9JoJtCccCSv2owLOUmYDQzZGKdkhj6LHpauVcP9g16UXBJ3K+1ycws9TLg4nXHdLU5ucvPw210FzkJUfiaD+Nxk6G7FDab6QtVpfRTscFC3UtvvDp8juyKyWQKelB+JouXGDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408635; c=relaxed/simple;
	bh=9EysohX+mNDRl0+eAbgzu/rQreeHvu7kmWnrVCvytWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhSBFeH6TRn35OeaZa1C1V81lcevWee6qvnj0izPvov1HSP74j8eaB4X17kpxcZXd0ZbetbaycEcLWEhPm7/wwm7b5WUjhEHx9uBbgI9AhxGE7I+TlGIgjtlG5HDzmIC91ZKtzYb2ewdkoCQNmCZ8oPRHBSMD2AMpDfnAZcNsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oephiA0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E606C19424;
	Wed, 14 Jan 2026 16:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768408635;
	bh=9EysohX+mNDRl0+eAbgzu/rQreeHvu7kmWnrVCvytWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oephiA0tE+NErABlZbeVkSqSp9Ven7zWwWlwfWXql7AAO+ELF6uWCm4j+4lTBq+l0
	 skQhXvxffBbLvRyEBBzdzsJY2UK2bRJp/NSyg4od51QzSPM7PaPoghWNLl4sG+MwmU
	 qj7m1wZbiJS9n3EGY7J2/XiWKQ8GoJC6o7k/sxCf1m8aPUB8ZVKlbcuRWa3v7oEu+s
	 kUKUHpCG//ATZxYnlGD0I5z4pbs9igUYlifq4yTiwNcY3PpOiVw/GumqEMHH5bL2sd
	 psRdDtVvxPpeIbEucRKg7hj61C5cAXPkh4ORlbdT3jlX4E5Wk6Fm8Vi/9aVZxM5PAF
	 /Tbo7AcaINB5w==
Date: Wed, 14 Jan 2026 22:06:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v4 2/8] PCI/pwrctrl: Add 'struct
 pci_pwrctrl::power_{on/off}' callbacks
Message-ID: <muyprs5s6fvcfqthi2cc43xmcsykwjcgq4bc7ote3l3uqaemre@gt4jyltu3js4>
References: <20260105-pci-pwrctrl-rework-v4-2-6d41a7a49789@oss.qualcomm.com>
 <20260112032711.GA694710@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112032711.GA694710@bhelgaas>

On Sun, Jan 11, 2026 at 09:27:11PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 05, 2026 at 07:25:42PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > To allow the pwrctrl core to control the power on/off sequences of the
> > pwrctrl drivers, add the 'struct pci_pwrctrl::power_{on/off}' callbacks and
> > populate them in the respective pwrctrl drivers.
> > 
> > The pwrctrl drivers still power on the resources on their own now. So there
> > is no functional change.
> > 
> > Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 27 ++++++++++++++---
> >  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 22 ++++++++++----
> >  drivers/pci/pwrctrl/slot.c               | 50 +++++++++++++++++++++++---------
> >  include/linux/pci-pwrctrl.h              |  4 +++
> >  4 files changed, 79 insertions(+), 24 deletions(-)
> 
> I had a hard time reading this because of the gratuitous differences
> in names of pwrseq, tc9563, and slot structs, members, and pointers.
> These are all corresponding private structs that could be named
> similarly:
> 
>   struct pci_pwrctrl_pwrseq_data
>   struct tc9563_pwrctrl_ctx
>   struct pci_pwrctrl_slot_data
> 
> These are all corresponding members:
> 
>   struct pci_pwrctrl_pwrseq_data.ctx
>   struct tc9563_pwrctrl_ctx.pwrctrl (last in struct instead of first)
>   struct pci_pwrctrl_slot_data.ctx
>   
> And these are all corresponding pointers or parameters:
> 
>   struct pci_pwrctrl_pwrseq_data *data
>   struct tc9563_pwrctrl_ctx *ctx
>   struct pci_pwrctrl_slot_data *slot
> 
> There's no need for this confusion, so I reworked those names to make
> them a *little* more consistent:
> 
>   structs:
>     struct pci_pwrctrl_pwrseq
>     struct pci_pwrctrl_tc9563
>     struct pci_pwrctrl_slot
> 
>   member:
>     struct pci_pwrctrl pwrctrl (for all)
> 
>   pointers/parameters:
>     struct pci_pwrctrl_pwrseq *pwrseq
>     struct pci_pwrctrl_tc9563 *tc9563
>     struct pci_pwrctrl_slot *slot
> 
> The file names, function names, and driver names are still not very
> consistent, but I didn't do anything with them:
> 
>   pci-pwrctrl-pwrseq.c  pci_pwrctrl_pwrseq_probe()  "pci-pwrctrl-pwrseq"
>   pci-pwrctrl-tc9563.c  tc9563_pwrctrl_probe()      "pwrctrl-tc9563"
>   slot.c                pci_pwrctrl_slot_probe()    ""pci-pwrctrl-slot"
> 

Yeah, because all 3 were written by 3 different developers and Bartosz didn't
pay attention to the detail :) I can unify them in the upcoming patches. Thanks
for spotting the differences.

> > +++ b/drivers/pci/pwrctrl/slot.c
> > @@ -17,13 +17,38 @@ struct pci_pwrctrl_slot_data {
> >  	struct pci_pwrctrl ctx;
> >  	struct regulator_bulk_data *supplies;
> >  	int num_supplies;
> > +	struct clk *clk;
> >  };
> >  
> > -static void devm_pci_pwrctrl_slot_power_off(void *data)
> > +static int pci_pwrctrl_slot_power_on(struct pci_pwrctrl *ctx)
> >  {
> > -	struct pci_pwrctrl_slot_data *slot = data;
> > +	struct pci_pwrctrl_slot_data *slot = container_of(ctx, struct pci_pwrctrl_slot_data, ctx);
> > +	int ret;
> > +
> > +	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
> > +	if (ret < 0) {
> > +		dev_err(slot->ctx.dev, "Failed to enable slot regulators\n");
> > +		return ret;
> > +	}
> > +
> > +	return clk_prepare_enable(slot->clk);
> 
> It would be nice if we could add a preparatory patch to factor out
> pci_pwrctrl_slot_power_on() before this one.  Then the slot.c patch
> would look more like the pwrseq and tc9563 ones.
> 

Agree, other two drivers atleast had a helper to do power on/off, so that made
them look nicer in diff.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

