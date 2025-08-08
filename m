Return-Path: <linux-pci+bounces-33641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EEFB1ED30
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 18:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63F5726746
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183F2281509;
	Fri,  8 Aug 2025 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvHuX7FE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D382C285CB6;
	Fri,  8 Aug 2025 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671530; cv=none; b=a6MsZS/ytRRzNlugei16WrcFnEwDOzSEazh/oLi9TPsaQmE/2e+M+K6kXUPHsjxQM6L+XTKUEgEuXyVtTMzeUDcTn5L/YTwultPqwyAgIC1nJAtUJz8INnQ/BylgWjGy0N4N69QkTgWeis5/GmMmahytQ92c7hXl4Bnft55M4pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671530; c=relaxed/simple;
	bh=//umrJE1AbcTB9AycRys08E8KmLxAmzbvhRupedv5Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Hj6m6Hv93lo+vlOnGIOPRwxBt5Kc5j2pfzVKbZrPNc98EfhEGu14DEgJ6To2ixQ8wK9HkSMPwB/f0QXhPe2AI5DMNZkiCkiRaA7wwGB875yy65T7j8njJry5oRBHWLRBz/kid/XZ+WUgUvK+PLL76ZbAMilNaY+r770fXhgrfq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvHuX7FE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B18C4CEED;
	Fri,  8 Aug 2025 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754671529;
	bh=//umrJE1AbcTB9AycRys08E8KmLxAmzbvhRupedv5Dc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SvHuX7FEsNr/3GDzQCcVIGtDMzLvyEzFXv2qcJIyKcwE3G78CSt/D7BpyK8W2wlnq
	 JcneXt1bupQaxlOiNKQqGSnYPJN3gHF2rsyY9huClbmsgeaaWtB6ztvE8lig3YSkom
	 typw/etKQmR4W3aFAdlT3O1MtBlp3Ep1wqgigkNBBW9L/SL+AkcJKVVpBD//k/2gSL
	 VjeTSEi189qln5PGC1fpGpcbTwSuFr32t8jznTpd45Yw4mTx9q/Wd/Cns+n+M12cC2
	 Se0DxDoj28CwAkOJDftgEKv/PP5dBs1tSEC+Fc0no1sAx+NaR6LTEctwBcOto5dXzv
	 ABu30wpzFBPDA==
Date: Fri, 8 Aug 2025 11:45:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	p.zabel@pengutronix.de, johan+linaro@kernel.org, cassel@kernel.org,
	shradha.t@samsung.com, thippeswamy.havalige@amd.com,
	quic_schintav@quicinc.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/9] PCI: stm32: Add PCIe host support for STM32MP25
Message-ID: <20250808164527.GA92564@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7cd764d-bc6d-4e39-aa03-0eee8e30d3e5@foss.st.com>

On Fri, Aug 08, 2025 at 04:55:52PM +0200, Christian Bruel wrote:
> On 8/7/25 20:09, Bjorn Helgaas wrote:
> > [+to Linus for pinctrl usage question below]
> > 
> > On Tue, Jun 10, 2025 at 11:07:07AM +0200, Christian Bruel wrote:
> > > Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
> > > controller based on the DesignWare PCIe core.

> > > +	return pinctrl_pm_select_sleep_state(dev);
> > 
> > Isn't there some setup required before we can use
> > pinctrl_select_state(), pinctrl_pm_select_sleep_state(),
> > pinctrl_pm_select_default_state(), etc?
> > 
> > I expected something like devm_pinctrl_get() in the .probe() path, but
> > I don't see anything.  I don't know how pinctrl works, but I don't see
> > how dev->pins gets set up.
> 
> Linus knows better, but the dev->pins states are attached to the dev struct
> before probe by the pinctrl driver
> 
> /**
>  * pinctrl_bind_pins() - called by the device core before probe
>  * @dev: the device that is just about to probe
>  */
> int pinctrl_bind_pins(struct device *dev)

Thanks for the pointer.  Might be worthy of a mention in
Documentation/driver-api/pin-control.rst.  Maybe pinctrl/consumer.h
could even have a bread crumb to that effect since drivers use all
those interfaces that rely in the implicit initialization done before
their .probe().

pin-control.rst mentions pinctrl_get_select_default() being called
just before the driver probe, but that's now unused and it looks like
pinctrl_bind_pins() does something similar:

  really_probe
    pinctrl_bind_pins
      dev->pins = devm_kzalloc()
      devm_pinctrl_get
      pinctrl_lookup_state(PINCTRL_STATE_DEFAULT)
      pinctrl_lookup_state(PINCTRL_STATE_INIT)
      pinctrl_select_state(init)      # if present, else default
    call_driver_probe

Bjorn

