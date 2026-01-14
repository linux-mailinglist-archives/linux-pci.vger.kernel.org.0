Return-Path: <linux-pci+bounces-44773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9DCD202AF
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30BEF30D6124
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBAD39C65F;
	Wed, 14 Jan 2026 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqUtIFp8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AD2BCF7F;
	Wed, 14 Jan 2026 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407428; cv=none; b=NtjPESheh8ouIkhQj4BV9kRkdaghiz/631Hi/VtjQ2LJn9kHJaw4pFizyLL85MsHdMWc8NQq+NJB7P3yqxjz0MJ4WV2iBG2OSNRP9Y5x72FxeiWJ5yciUAD26zlja2JnVrT2vK1IOE/p7IoqwQqdfbSr3dRt/h/uy6pLaACVx+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407428; c=relaxed/simple;
	bh=nTjWyUkkJkRHMQPexGyys9WNEHTYEZhRyiyG7Ihh+3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mBK+FbSa0TDQkK73uStI/objZXJFSzEeG4Qre+FOkSc2W2MGb/PGAwz0HggiR225TO2WvdmHVhSUao2pqyf3aX7UBlwl2dD2SoHDbdERWIUSH6rrgWfXLlCT3B7eejoueNqCfUDmPIfQPaal3ulM4dUax/n5N7q/rZVjlLw3lmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqUtIFp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAFAC4CEF7;
	Wed, 14 Jan 2026 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768407428;
	bh=nTjWyUkkJkRHMQPexGyys9WNEHTYEZhRyiyG7Ihh+3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nqUtIFp8qu2JEMYWPT97gnK4I0Qk7nS2Hy5NBTwxhyKYMqHa8EYyMuPxrVRL9IYP5
	 wGe1Sv7czpLvvNdsOj9kEiiQ1u6rBHv016tlDCKD+pXx9Fenp31tUHnLDV0jkwpWOp
	 x6OqzwhkE54cQb1+a3st8FF33nyMyxP82LqSJeeFstfoV3dgbUghN799/t8YnPZ+/o
	 PGfDHk7KIINlSg+nJ4DFvi2pfN834XCUdE2OLHIU1PKMYFTnjaK92NZ1DAPNwxu3G+
	 rb9mWTk/txHoMV45tfbGMSDjg82XND0skAwWidHA0KXEUlswAz701j9hZU7HBOBbbv
	 AMxserl0t+Scw==
Date: Wed, 14 Jan 2026 10:17:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v4 2/8] PCI/pwrctrl: Add 'struct
 pci_pwrctrl::power_{on/off}' callbacks
Message-ID: <20260114161706.GA809548@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

tc9563 implements power control functions:

  tc9563_pwrctrl_bring_up(struct tc9563_pwrctrl_ctx *ctx)
  tc9563_pwrctrl_power_off(struct pci_pwrctrl_tc9563 *tc9563)

and this patch updates these to make the signature generic so they can
be used as callbacks:

  tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
  tc9563_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)

This part of the patch is super straightforward -- make the signature
generic and extract the per-driver struct using the generic pointer.

I was thinking that if a preparatory patch factored out the slot power
on/off, e.g.:

  pci_pwrctrl_slot_power_on(struct pci_pwrctrl_slot_data *slot)

Then the slot.c part of this patch wouldn't move any code around, so
the structure would be identical to the tc9563 part.

pwrseq doesn't currently have the power-on/off functions factored out
either because they're so trivial, but I might even consider factoring
those out first, e.g.:

  pci_pwrctrl_pwrseq_power_on(struct pci_pwrctrl_pwrseq *pwrseq)

If we did that, this patch would be strictly conversion from
driver-specific pointer to "struct pci_pwrctrl *pwrctrl" followed by
"<driver-specific pointer = container_of(...)", so all three driver
changes would be identical and trivial to describe and review:

  - pci_pwrctrl_pwrseq_power_on(struct pci_pwrctrl_pwrseq *pwrseq)
  + pci_pwrctrl_pwrseq_power_on(struct pci_pwrctrl *pwrctrl)
  +   struct pci_pwrctrl_pwrseq *pwrseq = container_of(...);

  - tc9563_pwrctrl_bring_up(struct pci_pwrctrl_tc9563 *tc9563)
  + tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
  +   struct pci_pwrctrl_tc9563 *tc9563 = container_of(...);

  - pci_pwrctrl_slot_power_on(struct pci_pwrctrl_slot *slot)
  + pci_pwrctrl_slot_power_on(struct pci_pwrctrl *pwrctrl)
  +   struct pci_pwrctrl_slot *slot = container_of(...);

