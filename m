Return-Path: <linux-pci+bounces-6034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 999DD89FAAF
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 16:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8601C22E9E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF77F16DECE;
	Wed, 10 Apr 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG4YXjQ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939B1591E1;
	Wed, 10 Apr 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760744; cv=none; b=movAJwJrP82ouT0yfuJ2ysOT21JucN8idnnJKGujkAghSY26SCS3V4VjMO0wWzfcf5aHnnKtmAWRL9EpjI5/CZatefMXvzOzyMb0STdH7ZLgbKJ0NeEoknIAEQ2xliltHUvey0OLBEcEjbQnhV7ZA/J65zXe9ArgDoR9Z7FGm3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760744; c=relaxed/simple;
	bh=pHb6JorI0DA1E9/KxEhk+TcTp1ctv1kMIlPonkHp88A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9aN4SoqTSo+VRLyiHZGeaya1/DAFCg8Rgksn6ZNfW1ppGXFWi3ocF1ct4RJPuFBh9HPtZ43S5URawg8HpYsYX0seX0fvqOakeeTNdzohigvmbnTgLfgoeP/b3jum4VcA1J286nsZlu1mTcyRY92u8w0Wl1gkzzkL3pNDkeojbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG4YXjQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE85C433B1;
	Wed, 10 Apr 2024 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712760744;
	bh=pHb6JorI0DA1E9/KxEhk+TcTp1ctv1kMIlPonkHp88A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KG4YXjQ+NS5vFj41o9mKwCum3LunWyYZBmYGkhyjynAgWYI4/rsBAtUik8xXtUBaf
	 /ZM4pZSRsn4aFsS6KYZj8zHmjpCNJHPh1O/Rvv/Ii8jeRh4G45vZGvYYYenvSPnb7z
	 0j4DiTE9tp/n5psLqSBe0W+ZyH72HpnCPJWRpTgJrxCQYZF7AIE3aV4cFkfQ580lOO
	 AcSjFh2Q0thU0PZsDzyQp00RBVlkjavi7dfHRRL0KojvUJHfIcaZ+sh5M8LYIj3kJT
	 j9zF4LJjGu3t4UIvbfUOCbka6vKWWj08J4UPWUBH5BYDDDUGbBZwYl3rOD+gQQ26ug
	 3jd6iL8j7RiqA==
Date: Wed, 10 Apr 2024 16:52:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI: qcom: Implement shutdown() callback to
 properly reset the endpoint devices
Message-ID: <Zhanol2xi_E2Ypv3@ryzen>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
 <20240401-pci-epf-rework-v2-10-970dbe90b99d@linaro.org>
 <ZgvpnqdjQ39JMRiV@ryzen>
 <20240403133217.GK25309@thinkpad>
 <Zg22Dhi2c7U5oqoz@ryzen>
 <20240410105410.GC2903@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410105410.GC2903@thinkpad>

On Wed, Apr 10, 2024 at 04:24:10PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Apr 03, 2024 at 10:03:26PM +0200, Niklas Cassel wrote:
> > On Wed, Apr 03, 2024 at 07:02:17PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Apr 02, 2024 at 01:18:54PM +0200, Niklas Cassel wrote:
> > > > On Mon, Apr 01, 2024 at 09:20:36PM +0530, Manivannan Sadhasivam wrote:
> > > > > PCIe host controller drivers are supposed to properly reset the endpoint
> > > > > devices during host shutdown/reboot. Currently, Qcom driver doesn't do
> > > > > anything during host shutdown/reboot, resulting in both PERST# and refclk
> > > > > getting disabled at the same time. This prevents the endpoint device
> > > > > firmware to properly reset the state machine. Because, if the refclk is
> > > > > cutoff immediately along with PERST#, access to device specific registers
> > > > > within the endpoint will result in a firmware crash.
> > > > > 
> > > > > To address this issue, let's call qcom_pcie_host_deinit() inside the
> > > > > shutdown callback, that asserts PERST# and then cuts off the refclk with a
> > > > > delay of 1ms, thus allowing the endpoint device firmware to properly
> > > > > cleanup the state machine.
> > > > 
> > > > Hm... a QCOM EP device could be attached to any of the PCIe RC drivers that
> > > > we have in the kernel, so it seems a bit weird to fix this problem by
> > > > patching the QCOM RC driver only.
> > > > 
> > > > Which DBI call is it that causes this problem during perst assert on EP side?
> > > > 
> > > > I assume that it is pci-epf-test:deinit() callback that calls
> > > > pci_epc_clear_bar(), which calls dw_pcie_ep_clear_bar(), which will both:
> > > > -clear local data structures, e.g.
> > > > ep->epf_bar[bar] = NULL;
> > > > ep->bar_to_atu[bar] = 0;
> > > > 
> > > > but also call:
> > > > __dw_pcie_ep_reset_bar()
> > > > dw_pcie_disable_atu()
> > > > 
> > > > 
> > > > Do we perhaps need to redesign the .deinit EPF callback?
> > > > 
> > > > Considering that we know that .deinit() will only be called on platforms
> > > > where there will be a fundamental core reset, I guess we could do something
> > > > like introduce a __dw_pcie_ep_clear_bar() which will only clear the local
> > > > data structures. (It might not need to do any DBI writes, since the
> > > > fundamental core reset should have reset all values.)
> > > > 
> > > > Or perhaps instead of letting pci_epf_test_epc_deinit() call
> > > > pci_epf_test_clear_bar()/__pci_epf_test_clear_bar() directly, perhaps let
> > > > pci_epf_test_epc_deinit() call add a .deinit()/.cleanup() defined in the
> > > > EPC driver.
> > > > 
> > > > This EPC .deinit()/.cleanup() callback would then only clear the
> > > > local data structures (no DBI writes...).
> > > > 
> > > > Something like that?
> > > > 
> > > 
> > > It is not just about the EPF test driver. A function driver may need to do many
> > > things to properly reset the state machine. Like in the case of MHI driver, it
> > > needs to reset channel state, mask interrupts etc... and all requires writing to
> > > some registers. So certainly there should be some time before cutting off the
> > > refclk.
> > 
> > I was more thinking that perhaps we should think of .deinit() as in how
> > dw_pcie_ep_init() used to be. It was not allowed to have any DBI writes.
> > (The DBI writes were all in dw_pcie_ep_init_complete()).
> > So perhaps we could define that a EPF .deinit() callback is not allowed
> > to have any DBI writes.
> > 
> > If we take qcom-ep as an example, as soon as you get a PERST assertion
> > the qcom-ep driver calls notify_deinit(), then asserts the reset control,
> > disables clocks and regulators.
> > 
> > Since the PCIe core is held in reset, the hardware is in a well defined
> > state, no? Sure, the data structures e.g. bar_to_iatu[], etc., might be
> > out of sync, but these could be memset():ed no? Since this is a fundamental
> > reset, all registers should be reset to their default state (once reset
> > is deasserted).
> > 
> 
> Well, we could prevent the register access during PERST# assert time in the
> endpoint, but my worry is that we will end up with 2 version of the cleanup
> APIs. Lets take an example of dw_pcie_edma_remove() API which gets called
> during deinit and it touches some eDMA registers.
> 
> So should we introduce another API which just clears the sw data structure and
> not touching the registers? And this may be needed for other generic APIs as
> well.

I agree that it will be hard to come up with an elegant solution to this
problem.

These endpoint controllers that cannot do register accesses to their own
controllers' DBI/register space without the RC providing a refclock are
really becoming a pain... and the design and complexity of the PCI endpoint
APIs is what suffers as a result.

PERST could be asserted at any time.
So for your system to not crash/hang by accessing registers in the controller,
an EPF driver must be designed with great care to never do any register access
when it is not safe...

Perhaps the the EPF core should set the state (i.e. init_complete = false,
even before calling the deinit callback in EPF driver, and perhaps even add
safe-guards against init_complete in some APIs, so that e.g. a set_bar() call
cannot trigger a crash because PERST# is asserted.. but even then, it could
still be asserted in the middle of set_bar()'s execution.)


Looking at the databook, it looks like core_clk is derived from pipe_clk
output of the PHY. The PHY will either use external clock or internal clock.

4.6.2 DBI Protocol Transactions
it looks like core_clk must be active to read/write the DBI.

I really wish those controllers could e.g. change the clock temporarily
using a mux, so that it could still perform DBI read/writes when there is
not external refclk... Something like pm_sel_aux_clk selecting to use the
aux clk instead of core_clk when in low power states.
But I don't know the hardware well enough to know if that is possible for
the DBI, so that might just be wishful thinking...


Kind regards,
Niklas

