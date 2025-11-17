Return-Path: <linux-pci+bounces-41452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC51C660C4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 21:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 067434E82A2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F2283FCF;
	Mon, 17 Nov 2025 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6++nN2s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96CD27B327;
	Mon, 17 Nov 2025 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409624; cv=none; b=Nqv8G5ziUZDQjHkQfTZ7NZP+70UthZ0RPp7jeE/uzKrCVmvCJ9ora37+UvXkLzrmBw3WK3rvtm5jVEi1cerXy/K9p0AHmCRBAMVEO8Ev5TN5oBdLcR3KUQH//jQ3JGH+K7P/7qFmCuDtAFAk/jM+x3eLL2LnM+Q2RViUJqsy42c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409624; c=relaxed/simple;
	bh=KL4ddw+mqA9q22Tcaw70/uKb4mnlKlO94DBUCy7tcEA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eIjtTeNuoXvmv1d3WTHtLNPQBT94AoCt3XwCgks2yUgfsi6Z1X8WMwje+rsElmjpWOzesBripDao7Gfm1mkC34zf1g23rmW32KNzps5BmCc7wqU/Fkjz/X6NEKtGPsafsee9yI2PG2Rk3I9B0EHinAtmPZTKPeGCgX8heJL7ddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6++nN2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CBAC2BCB0;
	Mon, 17 Nov 2025 20:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763409622;
	bh=KL4ddw+mqA9q22Tcaw70/uKb4mnlKlO94DBUCy7tcEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=O6++nN2su5fvC7YOL15YxY2wHD1NrJgke+r+C0Y1ErXQ84kSI31a9ghucWfinpUml
	 5tBYLffCZUK9GNG4Hc9NhVpPOT9duH29630dMPSTA21GCcnYuv6R93gslma2ULiIXr
	 V21ywJO8p+odEWY/cyVZ3q6TCqQmIudAEeLgFZTSIIvK3RN6CSz41NthOmAQQ7o7q4
	 qU1os6pqo6wIvwbA7L0jg8CryqTD5Clxu4gauREAzFpXePpcVuylWNvkeegLEireYL
	 SDhlb+j6NR/j1aRSJPDMMwPW6iMXgYa2zbx7blo9t0hpAcYiTXAwxiQwoZLGfstfeA
	 dN9UqjE2383ug==
Date: Mon, 17 Nov 2025 14:00:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: stm32: Fix LTSSM EP race with start link.
Message-ID: <20251117200020.GA2518034@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367c8b88-79e7-4e8d-bf70-9d283696aba2@foss.st.com>

On Mon, Nov 17, 2025 at 01:04:47PM +0100, Christian Bruel wrote:
> On 11/14/25 19:59, Bjorn Helgaas wrote:
> > On Fri, Nov 14, 2025 at 08:45:52AM +0100, Christian Bruel wrote:
> > > If the host has deasserted PERST# and started link training before the link
> > > is started on EP side, enabling LTSSM before the endpoint registers are
> > > initialized in the perst_irq handler results in probing incorrect values.
> > > 
> > > Thus, wait for the PERST# level-triggered interrupt to start link training
> > > at the end of initialization and cleanup the stm32_pcie_[start stop]_link
> > > functions.
> > 
> > I've seen this kind of thing in other drivers, and I wondered whether
> > it was safe because the host asserts and deasserts PERST#
> > asynchronously, independent of anything the endpoint is doing.
> > 
> > I assume it's possible that the host deasserts PERST# before this
> > driver has the stm32_pcie_ep_perst_irq_thread() thread set up.  If
> > that happens and the driver doesn't see the PERST# interrupt, does
> > everything still work correctly?
> 
> yes it does. the PERST# interrupt is level-triggered and, if already
> de-asserted, fires only when enabled (it is NOAUTOEN) with start_link.
> 
> At that point, the host can enumerate by performing a manual rescan or
> rebind the PCIe driver, restarting the entire probe sequence.
> 
> Tested the pcie_epf_test driver with various power-up sequences: full
> power-up the host or device first, and stop or standby PM suspend/resume.

Help me think through this.  I guess the interesting case is when the
host boots first and enumerates devices before the stm32 endpoint is
ready, right?

I suppose the endpoint LTSSM is initially disabled, so the link is
down, and the host enumeration didn't find anything?

Where does the link come up?  I see the pci_epc_start_store() that
eventually leads to stm32_pcie_start_link(), which enables perst_irq.
Since you requested perst_irq with IRQF_TRIGGER_HIGH, and PERST# is
deasserted, does that trigger stm32_pcie_ep_perst_irq_thread() and
call stm32_pcie_perst_deassert() to enable the LTSSM?

When the link comes up, if the Downstream Port supports hotplug and
pciehp is enabled, it might notice the link-up event and treat this as
a hot-add?

Otherwise the user would have to manually rescan to notice the
endpoint?

> > > Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-stm32-ep.c | 38 ++++++------------------------
> > >   1 file changed, 7 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-stm32-ep.c b/drivers/pci/controller/dwc/pcie-stm32-ep.c
> > > index 3400c7cd2d88a279c49ef36a99fc7537c381c384..d0654bb43759bb8d0f0d7badbf7bdae839241fcf 100644
> > > --- a/drivers/pci/controller/dwc/pcie-stm32-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c
> > > @@ -37,36 +37,9 @@ static void stm32_pcie_ep_init(struct dw_pcie_ep *ep)
> > >   		dw_pcie_ep_reset_bar(pci, bar);
> > >   }
> > > -static int stm32_pcie_enable_link(struct dw_pcie *pci)
> > > -{
> > > -	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > -
> > > -	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> > > -			   STM32MP25_PCIECR_LTSSM_EN,
> > > -			   STM32MP25_PCIECR_LTSSM_EN);
> > > -
> > > -	return dw_pcie_wait_for_link(pci);
> > > -}
> > > -
> > > -static void stm32_pcie_disable_link(struct dw_pcie *pci)
> > > -{
> > > -	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > -
> > > -	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
> > > -}
> > > -
> > >   static int stm32_pcie_start_link(struct dw_pcie *pci)
> > >   {
> > >   	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > -	int ret;
> > > -
> > > -	dev_dbg(pci->dev, "Enable link\n");
> > > -
> > > -	ret = stm32_pcie_enable_link(pci);
> > > -	if (ret) {
> > > -		dev_err(pci->dev, "PCIe cannot establish link: %d\n", ret);
> > > -		return ret;
> > > -	}
> > >   	enable_irq(stm32_pcie->perst_irq);
> > > @@ -77,11 +50,7 @@ static void stm32_pcie_stop_link(struct dw_pcie *pci)
> > >   {
> > >   	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > -	dev_dbg(pci->dev, "Disable link\n");
> > > -
> > >   	disable_irq(stm32_pcie->perst_irq);
> > > -
> > > -	stm32_pcie_disable_link(pci);
> > >   }
> > >   static int stm32_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> > > @@ -152,6 +121,8 @@ static void stm32_pcie_perst_assert(struct dw_pcie *pci)
> > >   	dev_dbg(dev, "PERST asserted by host\n");
> > > +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
> > > +
> > >   	pci_epc_deinit_notify(ep->epc);
> > >   	stm32_pcie_disable_resources(stm32_pcie);
> > > @@ -192,6 +163,11 @@ static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
> > >   	pci_epc_init_notify(ep->epc);
> > > +	/* Enable link training */
> > > +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> > > +			   STM32MP25_PCIECR_LTSSM_EN,
> > > +			   STM32MP25_PCIECR_LTSSM_EN);
> > > +
> > >   	return;
> > >   err_disable_resources:
> > > 
> > > ---
> > > base-commit: 31115ecec74fe5c679a149d7037009f26b3aa8a9
> > > change-id: 20251113-perst_ep-0b57b9679cf9
> > > 
> > > Best regards,
> > > -- 
> > > Christian Bruel <christian.bruel@foss.st.com>
> > > 
> 

