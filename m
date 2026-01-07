Return-Path: <linux-pci+bounces-44206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28326CFF682
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 19:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F00DC3026F0B
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 18:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE1434AAE9;
	Wed,  7 Jan 2026 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkCXjGpd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20908345CC6;
	Wed,  7 Jan 2026 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804521; cv=none; b=eXyJxTq7S5wXSIiUuuJwIPvPONcUJX/R+k+f4auiMIPlv7Y5uJOZ4rk6Ep97I1oeXV5XHrUcKRvze9zxWvkixV8BdKR64AzYlMU8QIpzybj45Bz1wf+d0P0T4+QYm4nFfWni0StEU4dbEOBJ9SE6N35Gtor9heYiOx0U9fup1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804521; c=relaxed/simple;
	bh=YlIeTCM10zf09MC9CyZkYv+Kn5yyXyFaG8Q3R0EOyrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIt2JV1/ldYbD8D9qZjcTCPPi4x0TYvPYibZLemwNWUTOUfFIYzPi0eTclv94e14bz2FWZyXa7pra639w7D5b21eQo08krtt8rvhUegHTXdvIs33Z1t7LgH8FVPrizAHMJNNasJddMIuChOL3nWizUrm+meQSYxpQv2R+JE9uHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkCXjGpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C678FC4CEF1;
	Wed,  7 Jan 2026 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767804520;
	bh=YlIeTCM10zf09MC9CyZkYv+Kn5yyXyFaG8Q3R0EOyrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkCXjGpdmaVvCdlXKlt1x5wAhSc63hUWo+x4Ex3TYEh2dB+ZMmdk5nm7o5G+BO/Ig
	 0mlgkEV5z4chNbADVglVF4ChIBltwuEgqOvZ3JLfunPAthyFjdYfuA0l90z3UdIopQ
	 hIiECu9bx4wH66PhzJ1HFT4RLVU8dd9ZxpwA3GXb3loqZRo7KUiB3E88wO8/ERm5wV
	 yK13JQJX7C/662kUtLXhlUlceCVBda++u5jrfgo78rz8sb/iULabBS56d21dHdEqfx
	 jmo2pWbLpmMVClcy+ti2vay36O1SZyDxqNriRNg97HdHNOgL2xYr+mr3y9vZkF+GF6
	 D59Rq0OT+MotQ==
Date: Wed, 7 Jan 2026 22:18:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Damien Le Moal <dlemoal@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-ide@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 0/5] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Message-ID: <3jzmxpjz46rx6yfem6govgvahwpxwsqtzxfj5cmkcfmgeubdcb@6oudcjxqsw4h>
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
 <aV5vb1VlQYeWNcv1@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV5vb1VlQYeWNcv1@ryzen>

On Wed, Jan 07, 2026 at 03:36:31PM +0100, Niklas Cassel wrote:
> On Wed, Jan 07, 2026 at 07:41:22PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > Hi,
> > 
> > This series is an initial attempt to support the PCIe M.2 connectors in the
> > kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
> > Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
> > in PCs). On the ACPI platforms, power to these connectors are mostly handled by
> > the firmware/BIOS and the kernel never bothered to directly power manage them as
> > like other PCIe connectors. But on the devicetree platforms, the kernel needs to
> > power manage these connectors with the help of the devicetree description. But
> > so far, there is no proper representation of the M.2 connectors in devicetree
> > binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
> > and fixed regulators in devicetree.
> > 
> > So to properly support the M.2 connectors in devicetree platforms, this series
> > introduces the devicetree binding for Mechanical Key M connector as an example
> > and also the corresponding pwrseq driver and PCI changes in kernel to driver the
> > connector.
> > 
> > The Mechanical Key M connector is used to connect SSDs to the host machine over
> > PCIe/SATA interfaces. Due to the hardware constraints, this series only adds
> > support for driving the PCIe interface of the connector in the kernel.
> > 
> > Also, the optional interfaces supported by the Key M connectors are not
> > supported in the driver and left for the future enhancements.
> 
> For me, it is not clear if there is a dependency or conflict with your
> "major pwrctrl rework series":
> [PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl devices with controller drivers
> 
> Does one need to go before the other, or are they completely unrelated
> and can be merged in any order without conflicts?
> 

Only patch 2 has the conflict with pwrctrl rework series, but that is trivial to
fix. Otherwise, both are mostly independent.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

