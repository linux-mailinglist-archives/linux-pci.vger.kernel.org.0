Return-Path: <linux-pci+bounces-44932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3A2D23FC3
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 11:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5427301E99F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAEA36C597;
	Thu, 15 Jan 2026 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Una2UUlr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EF536C0AA;
	Thu, 15 Jan 2026 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473763; cv=none; b=r8+5ZpswkebblZA6vtujb7T6jKaUgK41EkWdK3lB0avWeOwvc8k5U6MUjKzS17NYovkBooQkIbwNvBg6I1yTM5d7UDUh034cRs+P1h/pkJmoWTenquyURzQIbhZANAMV7griPVaUGkjJjWJ70nlSUSZ5SQNyO906jdCewxsOTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473763; c=relaxed/simple;
	bh=llEBPxw2+pMZWxuWT4kSJKy3MloVCCidvTx0iLzR37A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEyuwExKzof00JWHDCc/1Pw0h2xEU6I6leZjk0yFfeySMN8qvEgYg8wowz+RPDmP73j0B5DKeW6qHf4qkTJLsvRdmZQ6xITLJlbkzQbXBAs/Rp56PVRnrKDc/DF60llJtAFzEPrBelz54mf9LWALsNsbMwgLFDOQrOqMmBCGaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Una2UUlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5C0C116D0;
	Thu, 15 Jan 2026 10:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768473762;
	bh=llEBPxw2+pMZWxuWT4kSJKy3MloVCCidvTx0iLzR37A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Una2UUlrcBz4SHlUiUp5PrFBWLmf9udmXhChU4WIFgX3C1hxfO3dWAPXKXeJoc8uo
	 yHxSqV2EMldhU+3sgUIm8T2iLCsfknAe3vM4rSDivCL/tgWwkduL17CqMGYIa5/Om4
	 IiDaTGERYO4sPRyY8ovwO5VsV5ncx/ksiGLw31LieoMJ9SZHTflpato7llsHLHSA20
	 mQRpJNMIvamS8EiJ7VwekA5ZSKpjnlQ6EhNGGhwyTJ9NZ0//b03mbLAVU5aNPxoxV7
	 hYUxUy3kSBmt8/eucatEA3Lgq1zSefgjZ3Jue8GuuIAu3dhJU/ptnO6Nolzxo/7E8I
	 UiS5UAgEd4p9Q==
Date: Thu, 15 Jan 2026 16:12:23 +0530
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
Message-ID: <gcmm23ji4fkcqeshcyiehuyega7kdbtvmofp4usmol2icwn6gy@i46icelwwqh5>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-5-eff84d2c6d26@oss.qualcomm.com>
 <20260113171424.GA3925312-robh@kernel.org>
 <xyttom64ht5hrrp5hecjqehnyfgsv4mfl2t36e2sveu44ccpjl@lkzquse2kqsx>
 <CAL_JsqJxBNm0y6T7vji6MXgsO65iDJ-tdUEo0cOxkw7EuMKpkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJxBNm0y6T7vji6MXgsO65iDJ-tdUEo0cOxkw7EuMKpkg@mail.gmail.com>

On Wed, Jan 14, 2026 at 11:45:42AM -0600, Rob Herring wrote:
> On Wed, Jan 14, 2026 at 10:14 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Tue, Jan 13, 2026 at 11:14:24AM -0600, Rob Herring wrote:
> > > On Mon, Jan 12, 2026 at 09:56:04PM +0530, Manivannan Sadhasivam wrote:
> > > > Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> > > > in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> > > > provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> > > > host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> > > > devices. Spec also provides an optional interface to connect the UIM card,
> > > > but that is not covered in this binding.
> > > >
> > > > The connector provides a primary power supply of 3.3v, along with an
> > > > optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> > > > 1.8v sideband signaling.
> > > >
> > > > The connector also supplies optional signals in the form of GPIOs for fine
> > > > grained power management.
> > > >
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > ---
> > > >  .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++++++++++++++++
> > > >  MAINTAINERS                                        |   1 +
> > > >  2 files changed, 155 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > > > new file mode 100644
> > > > index 000000000000..b65b39ddfd19
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > > > @@ -0,0 +1,154 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: PCIe M.2 Mechanical Key E Connector
> > > > +
> > > > +maintainers:
> > > > +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > +
> > > > +description:
> > > > +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechanical Key E
> > > > +  connector. Mechanical Key E connectors are used to connect Wireless
> > > > +  Connectivity devices including combinations of Wi-Fi, BT, NFC to the host
> > > > +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: pcie-m2-e-connector
> > > > +
> > > > +  vpcie3v3-supply:
> > > > +    description: A phandle to the regulator for 3.3v supply.
> > > > +
> > > > +  vpcie1v8-supply:
> > > > +    description: A phandle to the regulator for VIO 1.8v supply.
> > >
> > > I don't see any 1.8V supply on the connector. There are 1.8V IOs and you
> > > may need something in DT to ensure those are powered. However, there's
> > > no guarantee that it's a single supply.
> > >
> >
> > 1.8v VIO supply is an optional supply and is only required if the platform
> > supports 1.8v for sideband signals such as PERST#, WAKE#... I can include it in
> > the example for completeness.
> 
> My point is that PERST# and WAKE# supplies could be 2 different 1.8V
> supplies and those supply the I/O pads of the GPIO pins (and possibly
> external pull-ups) that drive them. The 1.8V supply doesn't supply
> 1.8V to the slot, so making it a slot/connector property is wrong.
> 

Ok, I get your point that VIO 1.8v supply is just limited to the I/O logic and
not the whole card/adapter. But I don't get your multiple supplies concern. Spec
says, "A 1.8 V supply pin called VIO 1.8 V is used to supply the on-Adapter I/O
buffer circuitry operating at 1.8 V." So it implies that either the single
supply available to the card through VIO might be used to power the whole I/O
circuit logic or the card can derive its own 1.8v supply from 3.3v supply.

So how come the card can have 2 different 1.8v supplies powering the I/O
circuitry?

> This isn't exactly a new issue. It could be an issue on any binding
> with GPIOs. Perhaps this needs to be handled within GPIO or pinctrl.
> 
> > > > +
> > > > +    oneOf:
> > > > +      - required:
> > > > +          - port@0
> > > > +
> > > > +  clocks:
> > > > +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
> > > > +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
> > > > +      more details.
> > > > +    maxItems: 1
> > > > +
> > > > +  w-disable1-gpios:
> > > > +    description: GPIO input to W_DISABLE1# signal. This signal is used by the
> > > > +      system to disable WiFi radio in the M.2 card. Refer, PCI Express M.2
> > > > +      Specification r4.0, sec 3.1.12.3 for more details.
> > > > +    maxItems: 1
> > > > +
> > > > +  w-disable2-gpios:
> > > > +    description: GPIO input to W_DISABLE2# signal. This signal is used by the
> > > > +      system to disable WiFi radio in the M.2 card. Refer, PCI Express M.2
> > > > +      Specification r4.0, sec 3.1.12.3 for more details.
> > > > +    maxItems: 1
> > > > +
> > > > +  viocfg-gpios:
> > > > +    description: GPIO output to IO voltage configuration (VIO_CFG) signal. This
> > > > +      signal is used by the M.2 card to indicate to the host system that the
> > > > +      card supports an independent IO voltage domain for the sideband signals.
> > > > +      Refer, PCI Express M.2 Specification r4.0, sec 3.1.15.1 for more details.
> > > > +    maxItems: 1
> > >
> > > What about SDIO and UART WAKE, SDIO RESET, and vendor defined signals?
> > >
> >
> > Not sure about vendor defined signals as they can be either GPIO or interface
> > signals. How should them be defined?
> 
> That kind of breaks any notion of this being a generic slot/connector.
> How's the host supposed to know how to connect them? What if a card
> required them to be driven a certain way before you can discover the
> card? If they can be GPIOs and can be hooked up to the host system
> GPIOs, then you should define GPIOs for them. If they aren't GPIOs on
> a host, then you omit them.
> 

Ok, then defining them as 'vendorN-gpios' is fine?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

