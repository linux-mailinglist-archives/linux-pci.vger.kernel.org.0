Return-Path: <linux-pci+bounces-12159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066CA95DEE7
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 18:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B007C282F88
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A77376E9;
	Sat, 24 Aug 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKE+kTU1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BBE2AD0F;
	Sat, 24 Aug 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724515957; cv=none; b=FIlk4LZyRuu4eEBpHz6g9hjkVZ4uJF9gE7pKwoI2pQKVHqzMXcTkcRz0PgHSW2SSPMrp9ekOhy3NPQ8Xhd5p607ERtlpgzSX/A5A7wSAw3/48bb6cXmDHJucsFL+WlyOVHqah3I5R5/mBkSpLt3fBzi0Z3cyrYtvmBKZpUDkl7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724515957; c=relaxed/simple;
	bh=XfcQFjPpEXffdqMYF5gM2PxhYLu+aE9KAENjS4qqD5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SEXnqpd3H6d/jaHmGOlp8Jqz7ONf1cCI6j+KwYlyPaZiU+VkDW/zwlL1hkp4Qmbp2lb5FCf9LnkQlMN4gChEQIKtkhdGQx6JJCQS6SRH5xUfEvt2VgZ2qdVwFYzAW0sSS2EvxSeHb5HmjCvTM0QGUXmoDBzXaadzx6QL0mRqAsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKE+kTU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7A7C32781;
	Sat, 24 Aug 2024 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724515956;
	bh=XfcQFjPpEXffdqMYF5gM2PxhYLu+aE9KAENjS4qqD5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CKE+kTU1bOp7Ni0DIucadU5r416oXNQzmaIb7T3+gaEhMIh6RCNZEZgykXbJeGA9o
	 ikGUfAi7B6phJpsxIzN3QC1rMzDj6pzqu/stFxjPf/v1poKBySAt5nEaV2r/Gn7vD6
	 GrpCZ8djg2xQ6DERGnsPc6j0xo+g1lOfgEfvS2NFfuVZNIaKWW6P1LfBmRvwkdvOPn
	 Xj0mXOQujnf32Y/J7huOhMuLDwDBbe9/g9btYB1rKl+iJjj2w7FO2nRVBihP8f0d0l
	 ZREWY9GViU5bk0fKgZMwDu+x+u6RaYzEnlfxEadwISS8KTihZL7+tolYp+z2/m7fxR
	 7+u1XamISrngA==
Date: Sat, 24 Aug 2024 11:12:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240824161234.GA411277@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824021946.s5jbzvysjxl5dcvt@thinkpad>

On Sat, Aug 24, 2024 at 07:49:46AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Aug 23, 2024 at 05:04:36PM -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 23, 2024 at 10:11:33AM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Aug 22, 2024 at 12:31:33PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Aug 22, 2024 at 09:10:25PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Thu, Aug 22, 2024 at 10:16:58AM -0500, Bjorn Helgaas wrote:
> > > > > > On Thu, Aug 22, 2024 at 12:18:23PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Wed, Aug 21, 2024 at 05:56:18PM -0500, Bjorn Helgaas wrote:
> > > > > > > ...
> > > > > > 
> > > > > > > > Although I do have the question of what happens if the RC deasserts
> > > > > > > > PERST# before qcom-ep is loaded.  We probably don't execute
> > > > > > > > qcom_pcie_perst_deassert() in that case, so how does the init happen?
> > > > > > > 
> > > > > > > PERST# is a level trigger signal. So even if the host has asserted
> > > > > > > it before EP booted, the level will stay low and ep will detect it
> > > > > > > while booting.
> > > > > > 
> > > > > > The PERST# signal itself is definitely level oriented.
> > > > > > 
> > > > > > I'm still skeptical about the *interrupt* from the PCIe controller
> > > > > > being level-triggered, as I mentioned here:
> > > > > > https://lore.kernel.org/r/20240815224735.GA57931@bhelgaas
> > > > > 
> > > > > Sorry, that comment got buried into my inbox. So didn't get a chance
> > > > > to respond.
> > > > > 
> > > > > > tegra194 is also dwc-based and has a similar PERST# interrupt but
> > > > > > it's edge-triggered (tegra_pcie_ep_pex_rst_irq()), which I think
> > > > > > is a cleaner implementation.  Then you don't have to remember the
> > > > > > current state, switch between high and low trigger, worry about
> > > > > > races and missing a pulse, etc.
> > > > > 
> > > > > I did try to mimic what tegra194 did when I wrote the qcom-ep
> > > > > driver, but it didn't work. If we use the level triggered interrupt
> > > > > as edge, the interrupt will be missed if we do not listen at the
> > > > > right time (when PERST# goes from high to low and vice versa).
> > > > > 
> > > > > I don't know how tegra194 interrupt controller is wired up, but IIUC
> > > > > they will need to boot the endpoint first and then host to catch the
> > > > > PERST# interrupt.  Otherwise, the endpoint will never see the
> > > > > interrupt until host toggles it again.
> > > > 
> > > > Having to control the boot ordering of endpoint and host is definitely
> > > > problematic.
> > > > 
> > > > What is the nature of the crash when we try to enable the PHY when
> > > > Refclk is not available?  The endpoint has no control over when the
> > > > host asserts/deasserts PERST#.  If PERST# happens to be asserted while
> > > > the endpoint is enabling the PHY, and this causes some kind of crash
> > > > that the endpoint driver can't easily recover from, that's a serious
> > > > robustness problem.
> > > 
> > > The whole endpoint SoC crashes if the refclk is not available during
> > > phy_power_on() as the PHY driver tries to access some register on Dmitry's
> > > platform (I did not see this crash on SM8450 SoC though).

I don't think the nature of this crash has been explained, so I don't
know whether it's a recoverable situation or not.

> > > If we keep the enable_resources() during probe() then the race
> > > condition you observed above could apply. So removing that from
> > > probe() will also make the race condition go away,
> > 
> > Example:
> > 
> >   1) host deasserts PERST#
> >   2) qcom-ep handles PERST# IRQ
> >   3) qcom_pcie_ep_perst_irq_thread() calls qcom_pcie_perst_deassert()
> >   4) host asserts PERST#, Refclk no longer valid
> >   5) qcom_pcie_perst_deassert() calls qcom_pcie_enable_resources()
> >   6) qcom_pcie_enable_resources() enables PHY
> > 
> > I don't see what prevents the PERST# assertion at 4.  It sounds like
> > the endpoint SoC crashes at 6.
> 
> IDK why host would quickly assert the PERST# after deasserting
> during probe() unless someone intentionally does that from host
> side.

I think the host is allowed to assert PERST# at any arbitrary time, so
an endpoint should be able to handle it no matter when it happens.

> If that happens then there is a possibility of the endpoint SoC
> crash, but I'm not sure how we can avoid that.
> 
> But what this patch fixes is a crash occuring in a sane scenario:
> 
> 1) Endpoint boots first (no refclk from host)
> 2) Probe() calls qcom_pcie_enable_resources() --> Crash

I agree with this, although I think it's more of a band-aid than a
complete solution.  I don't have access to any SoC or PCIe controller
docs, so maybe this is a hardware design problem and this is the best
we can do.

Bjorn

