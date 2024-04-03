Return-Path: <linux-pci+bounces-5631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC5E89797F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 22:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B015A1F248C9
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 20:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7263155753;
	Wed,  3 Apr 2024 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOGphwE5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87078155749;
	Wed,  3 Apr 2024 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174613; cv=none; b=VH8v22eBMdNTVOtJdIut23WFrz0Pg+ggU2O4cMROL2F6hzxSUyWRbuoB6lcnQUJ0tU2mUATJoWQYOkRvpkyyuGSR2UNzmrAwdPKElEv096CVwAAiI3h1hJspMCTcHpKjjQGz0Z0vPaYTnSm261+ZL0sIjpMtIxkfBm/H+8Esupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174613; c=relaxed/simple;
	bh=Ovv7lqjG/5spEzrPzpiFA+SpnlcVPrC9hvQHQkXzbEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGsQS9gOQSt/H6nf5AErpFgRljr43poHuUz0VhmUYaVt+WhGjO2K7MF73GXbGiuxilw2tBniepRpDlEytlgcJzOFCW1SukGGybedemk+1+87ibQpDq0qIeUc4bJXguaiXSgJ0xcwrkj8fTLUEpMsMoc38v1V2l03LuuT9eA4rGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOGphwE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A55C433C7;
	Wed,  3 Apr 2024 20:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712174613;
	bh=Ovv7lqjG/5spEzrPzpiFA+SpnlcVPrC9hvQHQkXzbEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOGphwE5GwRdEQesODb7dWfj04T7o4VFCZoUH7f4EKV4/W5v7TSIhhtVUZjAiZC6B
	 Ojij1K5B0FAaGuqSRTZfc3tvYIY7We+XKjWJlA6F0IW7uccfLUMmK/5snYmSPBA4lr
	 iJ+ofXVO2x7Vb+pv8JIOOI4LJCbbnetBqviKVJ95MqUIb+qaPL8pEitZk4nYvhwvY/
	 +Ac6BYtWpvhWAf5GJesUU1/8/ebE07ERBRgdgwfH8lPY7z3lXXYfYNd23ia2Mm8a2K
	 JSRd3BbiMmSF0ODReSPtsHN77dFJWA7XUW9gWWwjIBlsbXc1FbfLJ2bhO/hSMq71eR
	 4JmHNKhepy2nQ==
Date: Wed, 3 Apr 2024 22:03:26 +0200
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
Message-ID: <Zg22Dhi2c7U5oqoz@ryzen>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
 <20240401-pci-epf-rework-v2-10-970dbe90b99d@linaro.org>
 <ZgvpnqdjQ39JMRiV@ryzen>
 <20240403133217.GK25309@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403133217.GK25309@thinkpad>

On Wed, Apr 03, 2024 at 07:02:17PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 02, 2024 at 01:18:54PM +0200, Niklas Cassel wrote:
> > On Mon, Apr 01, 2024 at 09:20:36PM +0530, Manivannan Sadhasivam wrote:
> > > PCIe host controller drivers are supposed to properly reset the endpoint
> > > devices during host shutdown/reboot. Currently, Qcom driver doesn't do
> > > anything during host shutdown/reboot, resulting in both PERST# and refclk
> > > getting disabled at the same time. This prevents the endpoint device
> > > firmware to properly reset the state machine. Because, if the refclk is
> > > cutoff immediately along with PERST#, access to device specific registers
> > > within the endpoint will result in a firmware crash.
> > > 
> > > To address this issue, let's call qcom_pcie_host_deinit() inside the
> > > shutdown callback, that asserts PERST# and then cuts off the refclk with a
> > > delay of 1ms, thus allowing the endpoint device firmware to properly
> > > cleanup the state machine.
> > 
> > Hm... a QCOM EP device could be attached to any of the PCIe RC drivers that
> > we have in the kernel, so it seems a bit weird to fix this problem by
> > patching the QCOM RC driver only.
> > 
> > Which DBI call is it that causes this problem during perst assert on EP side?
> > 
> > I assume that it is pci-epf-test:deinit() callback that calls
> > pci_epc_clear_bar(), which calls dw_pcie_ep_clear_bar(), which will both:
> > -clear local data structures, e.g.
> > ep->epf_bar[bar] = NULL;
> > ep->bar_to_atu[bar] = 0;
> > 
> > but also call:
> > __dw_pcie_ep_reset_bar()
> > dw_pcie_disable_atu()
> > 
> > 
> > Do we perhaps need to redesign the .deinit EPF callback?
> > 
> > Considering that we know that .deinit() will only be called on platforms
> > where there will be a fundamental core reset, I guess we could do something
> > like introduce a __dw_pcie_ep_clear_bar() which will only clear the local
> > data structures. (It might not need to do any DBI writes, since the
> > fundamental core reset should have reset all values.)
> > 
> > Or perhaps instead of letting pci_epf_test_epc_deinit() call
> > pci_epf_test_clear_bar()/__pci_epf_test_clear_bar() directly, perhaps let
> > pci_epf_test_epc_deinit() call add a .deinit()/.cleanup() defined in the
> > EPC driver.
> > 
> > This EPC .deinit()/.cleanup() callback would then only clear the
> > local data structures (no DBI writes...).
> > 
> > Something like that?
> > 
> 
> It is not just about the EPF test driver. A function driver may need to do many
> things to properly reset the state machine. Like in the case of MHI driver, it
> needs to reset channel state, mask interrupts etc... and all requires writing to
> some registers. So certainly there should be some time before cutting off the
> refclk.

I was more thinking that perhaps we should think of .deinit() as in how
dw_pcie_ep_init() used to be. It was not allowed to have any DBI writes.
(The DBI writes were all in dw_pcie_ep_init_complete()).
So perhaps we could define that a EPF .deinit() callback is not allowed
to have any DBI writes.

If we take qcom-ep as an example, as soon as you get a PERST assertion
the qcom-ep driver calls notify_deinit(), then asserts the reset control,
disables clocks and regulators.

Since the PCIe core is held in reset, the hardware is in a well defined
state, no? Sure, the data structures e.g. bar_to_iatu[], etc., might be
out of sync, but these could be memset():ed no? Since this is a fundamental
reset, all registers should be reset to their default state (once reset
is deasserted).

For a real PCIe card, if you assert + msleep(100) + deassert PERST, surely
the endpoint is supposed to be in a good/well defined state, regardless if
he REFCLK was cutoff at the exact time as PERST was asserted or not?

I would assume that we would want a PCI EPF driver to behave the same way,
if possible.


Kind regards,
Niklas

