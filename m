Return-Path: <linux-pci+bounces-45054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A027CD32DDD
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 15:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01B9A31DC623
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1658399000;
	Fri, 16 Jan 2026 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK8eH7fb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DD283C82;
	Fri, 16 Jan 2026 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574594; cv=none; b=o9AAJcv9AcVtYFRV+DUq9C9aVxhf2SP/gPXC+0V+ydbioW5lCOU7SRKa6jASrlmmRR2MnLnk2AsHngc7Xib8HJv0nlxALNEbmNa2yzuJoi50lhO0KAPd0boOuP0JvA4C6IVTEXv8FPEYzTnO/5eVBzoYQY2HDQzCE+FuIhvsrQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574594; c=relaxed/simple;
	bh=VeHWIHkcQ9AFfItzbMmyl8YOQqITLehdpmsz1R9lqlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWWtgixHCsmwB/ronJhw+Ve8W34WvkXY8Tz5j4BvAf25DWJtzJSURvMTCZuKcQhROYRJlG7TYXQk0jhViEtUHCNiRy3ve/MpOu9mIB48nehM6g4PcmVASNmtEA2GKF9tRHq1ZD3Vm0Sz8RVOKDMZUxvfVWIZ26YaxFMr0KdbuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK8eH7fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073C6C116C6;
	Fri, 16 Jan 2026 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574594;
	bh=VeHWIHkcQ9AFfItzbMmyl8YOQqITLehdpmsz1R9lqlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZK8eH7fbVAJuu0G1Uo5qVMd3dtfbdYEGhZ6/BokuiAV/wPZ9vdI5GE1eIy+P1AMQV
	 TiGmHkll7ns/mv3/iMCJcUJBHkkOtD9wHC5Zzi+wvSskxpz39/DrvPo4sw35IkicJm
	 1n/q2Lmx8F5arkGNSAjC2UPdzq4t3Nn/7/EgGRwdS4YML52Sim0snfzJ9k3mhknutM
	 s9c0stY2Nu9tI6uqIshvgbH7zus7jYGZqvv4b2g+l38vn8yR4Ee2HlnkZX5JkLLOuU
	 2fyyOFYN/w5/E4247VfpoHnnbmiEjOiIAjvxehJu+m5vRJgPNqKem9bNykLInrPE0N
	 xNcfmyFHAJ35w==
Date: Fri, 16 Jan 2026 20:12:57 +0530
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
Message-ID: <ysfkemsf4w7r3eoahfpjdr3z3buec5kvw4qol2njhxrz5tsdpo@4scz632uaj5i>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-5-eff84d2c6d26@oss.qualcomm.com>
 <20260113171424.GA3925312-robh@kernel.org>
 <xyttom64ht5hrrp5hecjqehnyfgsv4mfl2t36e2sveu44ccpjl@lkzquse2kqsx>
 <CAL_JsqJxBNm0y6T7vji6MXgsO65iDJ-tdUEo0cOxkw7EuMKpkg@mail.gmail.com>
 <gcmm23ji4fkcqeshcyiehuyega7kdbtvmofp4usmol2icwn6gy@i46icelwwqh5>
 <CAL_JsqKKBjurY7ZrScayvkTijR-F6GWBofry48xoPFBFi55u4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKKBjurY7ZrScayvkTijR-F6GWBofry48xoPFBFi55u4w@mail.gmail.com>

On Fri, Jan 16, 2026 at 08:19:07AM -0600, Rob Herring wrote:
> On Thu, Jan 15, 2026 at 4:42 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Wed, Jan 14, 2026 at 11:45:42AM -0600, Rob Herring wrote:
> > > On Wed, Jan 14, 2026 at 10:14 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > >
> > > > On Tue, Jan 13, 2026 at 11:14:24AM -0600, Rob Herring wrote:
> > > > > On Mon, Jan 12, 2026 at 09:56:04PM +0530, Manivannan Sadhasivam wrote:
> > > > > > Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> > > > > > in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> > > > > > provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> > > > > > host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> > > > > > devices. Spec also provides an optional interface to connect the UIM card,
> > > > > > but that is not covered in this binding.
> > > > > >
> > > > > > The connector provides a primary power supply of 3.3v, along with an
> > > > > > optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> > > > > > 1.8v sideband signaling.
> > > > > >
> > > > > > The connector also supplies optional signals in the form of GPIOs for fine
> > > > > > grained power management.
> > > > > >
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > > > ---
> > > > > >  .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++++++++++++++++
> > > > > >  MAINTAINERS                                        |   1 +
> > > > > >  2 files changed, 155 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..b65b39ddfd19
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > > > > > @@ -0,0 +1,154 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: PCIe M.2 Mechanical Key E Connector
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > > > +
> > > > > > +description:
> > > > > > +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechanical Key E
> > > > > > +  connector. Mechanical Key E connectors are used to connect Wireless
> > > > > > +  Connectivity devices including combinations of Wi-Fi, BT, NFC to the host
> > > > > > +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    const: pcie-m2-e-connector
> > > > > > +
> > > > > > +  vpcie3v3-supply:
> > > > > > +    description: A phandle to the regulator for 3.3v supply.
> > > > > > +
> > > > > > +  vpcie1v8-supply:
> > > > > > +    description: A phandle to the regulator for VIO 1.8v supply.
> > > > >
> > > > > I don't see any 1.8V supply on the connector. There are 1.8V IOs and you
> > > > > may need something in DT to ensure those are powered. However, there's
> > > > > no guarantee that it's a single supply.
> > > > >
> > > >
> > > > 1.8v VIO supply is an optional supply and is only required if the platform
> > > > supports 1.8v for sideband signals such as PERST#, WAKE#... I can include it in
> > > > the example for completeness.
> > >
> > > My point is that PERST# and WAKE# supplies could be 2 different 1.8V
> > > supplies and those supply the I/O pads of the GPIO pins (and possibly
> > > external pull-ups) that drive them. The 1.8V supply doesn't supply
> > > 1.8V to the slot, so making it a slot/connector property is wrong.
> > >
> >
> > Ok, I get your point that VIO 1.8v supply is just limited to the I/O logic and
> > not the whole card/adapter. But I don't get your multiple supplies concern. Spec
> > says, "A 1.8 V supply pin called VIO 1.8 V is used to supply the on-Adapter I/O
> > buffer circuitry operating at 1.8 V." So it implies that either the single
> > supply available to the card through VIO might be used to power the whole I/O
> > circuit logic or the card can derive its own 1.8v supply from 3.3v supply.
> >
> > So how come the card can have 2 different 1.8v supplies powering the I/O
> > circuitry?
> 
> Is there a pin on the connector for 1.8V supply? I don't have the
> spec, but the pinout I found[1] didn't show one. If there's a pin,
> then I have no concern.
> 

Oh yes, there is a single VIO pin defined in the spec for multiple Keys. Since
it is optional, it could've been omitted in the design you referenced.

So should I name it as vio1v8-supply or vpcie1v8-supply? I don't see any other
1.8v supplies other than the VIO supply though.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

