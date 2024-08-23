Return-Path: <linux-pci+bounces-12143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E26095D8F6
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 00:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17571B210B7
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 22:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428AB1C86E4;
	Fri, 23 Aug 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0GIUvrF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142DB191F6B;
	Fri, 23 Aug 2024 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450679; cv=none; b=W6YJ45+sKsKHvZeEeNxl8O8Q5E6k5AXBQ/6tsfm2Xp+A2OuVcDP+inu1aRaZN2pwEkHthVJeeardPJrukNEHiXVAVjsiZfbE83JwyRAv3su0GoKTdsaZjNnxA+KrsOOrFQfo1s1OoUBBuLk51lAWmj0IalL5zzjhrn+fwRIjh14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450679; c=relaxed/simple;
	bh=sOlJNt/5c8Tti76v1n49s0eMhAqmyUoYvBQpT3/63iw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nKHUA85GaIRzA5mnyPb8um8UkG9p4p99ergC2jUTnu8Rz1FamW8yOPQrvzX9TwLFi92t8GrMsZq3HkpZ4lKJxXEB+jUmtElXtIyjup69EqLqoGOL4gtN9fBOUhwWsmKg0UEZA1AAsKeb10nhgHPIyz8k0fnVjHKkOGmKfcOQ82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0GIUvrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2E6C4AF09;
	Fri, 23 Aug 2024 22:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724450678;
	bh=sOlJNt/5c8Tti76v1n49s0eMhAqmyUoYvBQpT3/63iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=m0GIUvrFPOyEVZhaqCcLPsT3YYIF0gj8VeSwK6EDF2BeJmSdE1/NX8wGZ5PTVN8Gc
	 I/XEwJ8xILDRraxWzFbzoDYlh14JAEOuX29IGL1epmBvcmtTnxgwdeOsgATdXP92Dg
	 yjIT0MckINcQ35Uz8wliKIRgiOsIKf+2c4P265C3K9JLJ8wA0w6luL9cOzv8RTgknl
	 qAmDEbZIikugVGnACgJ9XYxU4OKbpCWgTJ75X8TSH/xssxeJrjvVxwLn4KkA/TqBCy
	 4e32l57W24Sk3bbjP9ZGykzx3weT+QurgxW0CyPeiaLpxODCtrwM26K3+m5mXKgNKy
	 Sf7wl0gx0/lDQ==
Date: Fri, 23 Aug 2024 17:04:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240823220436.GA387844@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823044133.b27cgioefsg4sjlr@thinkpad>

On Fri, Aug 23, 2024 at 10:11:33AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Aug 22, 2024 at 12:31:33PM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 22, 2024 at 09:10:25PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Aug 22, 2024 at 10:16:58AM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Aug 22, 2024 at 12:18:23PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Wed, Aug 21, 2024 at 05:56:18PM -0500, Bjorn Helgaas wrote:
> > > > > ...
> > > > 
> > > > > > Although I do have the question of what happens if the RC deasserts
> > > > > > PERST# before qcom-ep is loaded.  We probably don't execute
> > > > > > qcom_pcie_perst_deassert() in that case, so how does the init happen?
> > > > > 
> > > > > PERST# is a level trigger signal. So even if the host has asserted
> > > > > it before EP booted, the level will stay low and ep will detect it
> > > > > while booting.
> > > > 
> > > > The PERST# signal itself is definitely level oriented.
> > > > 
> > > > I'm still skeptical about the *interrupt* from the PCIe controller
> > > > being level-triggered, as I mentioned here:
> > > > https://lore.kernel.org/r/20240815224735.GA57931@bhelgaas
> > > 
> > > Sorry, that comment got buried into my inbox. So didn't get a chance
> > > to respond.
> > > 
> > > > tegra194 is also dwc-based and has a similar PERST# interrupt but
> > > > it's edge-triggered (tegra_pcie_ep_pex_rst_irq()), which I think
> > > > is a cleaner implementation.  Then you don't have to remember the
> > > > current state, switch between high and low trigger, worry about
> > > > races and missing a pulse, etc.
> > > 
> > > I did try to mimic what tegra194 did when I wrote the qcom-ep
> > > driver, but it didn't work. If we use the level triggered interrupt
> > > as edge, the interrupt will be missed if we do not listen at the
> > > right time (when PERST# goes from high to low and vice versa).
> > > 
> > > I don't know how tegra194 interrupt controller is wired up, but IIUC
> > > they will need to boot the endpoint first and then host to catch the
> > > PERST# interrupt.  Otherwise, the endpoint will never see the
> > > interrupt until host toggles it again.
> > 
> > Having to control the boot ordering of endpoint and host is definitely
> > problematic.
> > 
> > What is the nature of the crash when we try to enable the PHY when
> > Refclk is not available?  The endpoint has no control over when the
> > host asserts/deasserts PERST#.  If PERST# happens to be asserted while
> > the endpoint is enabling the PHY, and this causes some kind of crash
> > that the endpoint driver can't easily recover from, that's a serious
> > robustness problem.
> 
> The whole endpoint SoC crashes if the refclk is not available during
> phy_power_on() as the PHY driver tries to access some register on Dmitry's
> platform (I did not see this crash on SM8450 SoC though).
> 
> If we keep the enable_resources() during probe() then the race condition you
> observed above could apply. So removing that from probe() will also make the
> race condition go away,

Example:

  1) host deasserts PERST#
  2) qcom-ep handles PERST# IRQ
  3) qcom_pcie_ep_perst_irq_thread() calls qcom_pcie_perst_deassert()
  4) host asserts PERST#, Refclk no longer valid
  5) qcom_pcie_perst_deassert() calls qcom_pcie_enable_resources()
  6) qcom_pcie_enable_resources() enables PHY

I don't see what prevents the PERST# assertion at 4.  It sounds like
the endpoint SoC crashes at 6.

