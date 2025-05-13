Return-Path: <linux-pci+bounces-27651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1056BAB5B25
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 19:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0971B4474B
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BFF2BF3ED;
	Tue, 13 May 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDGJXCq7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7201C863B;
	Tue, 13 May 2025 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157150; cv=none; b=EgSK0uGO6sw4/vOarrM+wWe2KMLYjhgYEgX9e22sAb9Ucaq8oiaX6KOMX9wUJF3Io9z9g6oqyjeGCsqeADplloBZjMRGHtnf2eC6q3IYp/rNMRtVdAT7tf1NglUD6vWVesfERQsefSz5XnHeVbWqEOjQQXH4+M+KsyJDGkr7tZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157150; c=relaxed/simple;
	bh=VhUfuH8QAkJ3uCuV1pb0BMrdx0COli1mOl7/YxCNZz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otnHE1YI70hGwxxsmmlP0zXe/iQlyJQ55r+XGsCfs82G8un9LpXG/YOT8ZuyY75xSgOLci4cc4ykiC+WSVVaXF6DOKlshkY7/g8m37K/WF+E8sGp7dZSMiL8MF8V+gIO1JqprBgCWpe/YwitLaaYZJtgYKL1Ji9iFbj+3HR3FJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDGJXCq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BEDC4CEE4;
	Tue, 13 May 2025 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747157150;
	bh=VhUfuH8QAkJ3uCuV1pb0BMrdx0COli1mOl7/YxCNZz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDGJXCq7+kBOyTWsqKM45DaPgXI/pkDktSOtQfEFSi6bQSkF2w8tzl0eXtdKCqVXN
	 C+CCgdsUNhRt61kkkTOBbEEAKm1jWMNdX0rRl31FH/DhlClu3iYKieTNluq1KLiqds
	 7gK94dPgt25aLyIADqWaGtKopbwN3JBSLXLV6+dkar7duK7Fb1ESVD08wGJYTuxjVN
	 lO1+g6OB6+BEMNIrOn0co3gsGi6+GNOQTwJA0qY2B0XqHH6/VgGOkqHvdZD8c8sNRE
	 2gdvvNXlfd6Y5/gNZVDZpbcom9Fq+lQtE/zv441HYomC9jshnohUdKg1sgL5c8CWkm
	 ANMDQBiY3dMbQ==
Date: Tue, 13 May 2025 19:25:45 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	dlemoal@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: pci-ep: Add ref-clk-mode
Message-ID: <aCOAmQNWUWU55VKT@ryzen>
References: <20250425092012.95418-2-cassel@kernel.org>
 <7xtp5i3jhntfev35uotcunur3qvcgq4vmcnkjde5eivajdbiqt@n2wsivrsr2dk>
 <aBHOaJFgZiOfTrrT@ryzen>
 <dxgs3wuekwjh6f22ftkmi7dcw7xpw3fa7lm74fwm5thvol42z3@wuovkynp3jey>
 <20250509181827.GA3879057-robh@kernel.org>
 <a7rfa6rlygbe7u3nbxrdc3doln7rk37ataxjrutb2lunctbpuo@72jnf6odl5xp>
 <aB8ysBuQysAR-Zcp@ryzen>
 <20250512135909.GA3177343-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512135909.GA3177343-robh@kernel.org>

On Mon, May 12, 2025 at 08:59:09AM -0500, Rob Herring wrote:
> > 
> > This patch adds a refclk-mode property to an endpoint side DT binding.
> 
> If we are dealing with the same property of the link, it doesn't matter 
> which side. What we don't need is 2 different solutions.

It is not really a property of the link though.

The RC could be running with a Separate Reference clock without spread
spectrum clocking (SSC), while the EP could be running with a Separate
Reference clock with SSC.

The link would still be classified as SRIS, even though only one end of
the link is using SSC.

So AFAICT there cannot be property "per link".


> 
> > This property is needed such that the endpoint can configure the bits
> > in its own PCIe Link Control Register before starting the link.
> > 
> > Perhaps the host side could also make use of a similar property, but I'm not
> > sure, you don't know from the host side which endpoint will be plugged in.
> > 
> > >From the EP side, you do know if your SoC only supports common-clock or
> > SRNS/SRIS, since that depends on if the board can source the clock from
> > the PCIe slot or not (of all the DWC based drivers, only Qcom and Tegra
> > can do so, rest uses SRNS/SRIS), so this property definitely makes sense
> > in an EP side DT binding.
> 
> I don't understand why we need this in DT in the first place. Seems like 
> needing to specify this breaks discoverability? Perhaps this information 
> is only relevant after initial link is up and the host can read the EP 
> registers?

If we take the RK3588 SoC as an example, per the TRM, the SoC supports both
SRNS and Common Clock. However, on the Rock 5b board (which uses the RK3588
SoC), the refclock when running is EP mode can only be sourced from the
clock generator on the board itself (Separate Reference clock), it is not
possible to source the refclock from the PCIe slot itself (Common Clock).

However, this is a design limitation of the board, not of the SoC.

E.g. Rockchip might have a development board that uses the RK3588 SoC,
which allows you select where to source the clock from using a mux, either
from the PCIe slot, or from the on board clock generator.

Some development boards I have seen have a DIP switch on the board that
allows you to select if you want to source the clock from the PCIe slot or
not. However, not all boards have this nice feature.

And even if you do have a DIP switch for that, and a GPIO which you can
read the DIP switch value from, when running in Separate Reference clock
mode, you can either run with or without SSC (i.e. SRNS mode or SRIS mode).

When running in SRIS mode, to enable SSC, we need to write registers both
in the PHY and in the controller, before even starting link training.

I do realize that, for boards supporting more than a single mode (Common
Clock/SRNS/SRIS), this device tree property is basically a configuration
option. For boards only supporting a single mode, it is actually describing
the hardware.

E.g. Rock 5b can run in both SRNS and SRIS mode (Common Clock is not
supported), and since this has to be configured before starting the link,
I cannot think of a better way to control this than a device tree property.

In my specific case, I will also need to add a SSC property to the PCIe PHY
DT binding, to control if SSC should be enabled or not (needed when running
in SRIS mode).

Sure, perhaps it could be possible to use phy_set_mode() from the PCIe
controller driver or similar, that conveys this information to the PHY
driver... But with all the possible PCI bifurcation DT properties that
already exist in the PCIe PHY DT binding, I'm not sure if making use of
phy_set_mode() is feasible, or if I will be forced to add a property to the
PCIe PHY DT binding.


Kind regards,
Niklas

