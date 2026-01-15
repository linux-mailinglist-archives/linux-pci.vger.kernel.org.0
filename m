Return-Path: <linux-pci+bounces-44934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D74D24011
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 11:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 534CB300FE17
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715F636C599;
	Thu, 15 Jan 2026 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzw1nZu0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0036C0CC;
	Thu, 15 Jan 2026 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473900; cv=none; b=qdzlAemVo7+4MCX/2IvV6t6yVALBtoJBpCpL+5BquJFmu9isMTdz3eQhZKoJiw8i6/NjsnXXCaqrl+K7n2jk51uyVQzM6TBsBCpObtK41ElBmubqgeA5FM7wwuOsrN63G3ICGng7zO5ksEbRccQIFMQZL5/n+gMOwJvu+xK+xIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473900; c=relaxed/simple;
	bh=KCf9/BUWQWrV3YzZSQGIBitilFEV6z7FvLz9+gF37+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oex+vl1fhQmlZHLjnjUgH+5Ef382bp86X6OXITRa7IBg95eYAos71Mwob4tzCX9dAc7V+3Xyuw0xM04P8va69RY6A3CisXeR/FgKkQMbOdeUT07/W2nlfyxpJIv/ECaL4M5nYkeGweZUQmu1p3roWABM8hPbdwwtmdNX6fBnaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzw1nZu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9EAC116D0;
	Thu, 15 Jan 2026 10:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768473899;
	bh=KCf9/BUWQWrV3YzZSQGIBitilFEV6z7FvLz9+gF37+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bzw1nZu02dQejptA0JvWTI5Kzv8ZivGSWw//ar5HN7g3e3fvnK7diB8O0pmaWexh4
	 5XojmtjQzGc+FqgbwVH2OFPPVeB906fgkmpSff5sPYhHM9sX74IQMkFXLXtpzuQfpO
	 Pk8R5eLtUsALQjTeXVEzkQhHjDEr5iiYb4F3/cPOxl99In93iEdalxJ3MLkIBxWSLs
	 H+RNlPsIdKmA7LfQjWgynvtJn1jEMFnR4fv0CDiviCt6UruWq6Lva0mb7fk3SP90DC
	 JomhCfyV4tem4mdNhgWhbDBkTX7C0gcNvZ9B6aLLKSKPDPMSTV0V4oPzyFvhH5q9zu
	 hvi8JEqsO6aag==
Date: Thu, 15 Jan 2026 16:14:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 5/9] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
Message-ID: <pfyzilu4xpggftei4th37uv7wb4gpfsntjlagctsydrrc35qci@4uyd3zog6t7j>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-5-eff84d2c6d26@oss.qualcomm.com>
 <20260113171601.GB3925312-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113171601.GB3925312-robh@kernel.org>

On Tue, Jan 13, 2026 at 11:16:01AM -0600, Rob Herring wrote:
> On Mon, Jan 12, 2026 at 09:56:04PM +0530, Manivannan Sadhasivam wrote:
> > Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> > in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> > provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> > host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> > devices. Spec also provides an optional interface to connect the UIM card,
> > but that is not covered in this binding.
> > 
> > The connector provides a primary power supply of 3.3v, along with an
> > optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> > 1.8v sideband signaling.
> > 
> > The connector also supplies optional signals in the form of GPIOs for fine
> > grained power management.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++++++++++++++++
> >  MAINTAINERS                                        |   1 +
> >  2 files changed, 155 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > new file mode 100644
> > index 000000000000..b65b39ddfd19
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > @@ -0,0 +1,154 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: PCIe M.2 Mechanical Key E Connector
> > +
> > +maintainers:
> > +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > +
> > +description:
> > +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechanical Key E
> > +  connector. Mechanical Key E connectors are used to connect Wireless
> > +  Connectivity devices including combinations of Wi-Fi, BT, NFC to the host
> > +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> > +
> > +properties:
> > +  compatible:
> > +    const: pcie-m2-e-connector
> > +
> > +  vpcie3v3-supply:
> > +    description: A phandle to the regulator for 3.3v supply.
> > +
> > +  vpcie1v8-supply:
> > +    description: A phandle to the regulator for VIO 1.8v supply.
> > +
> > +  ports:
> 
> Also, nodes go after all properties.
> 

Ack.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

