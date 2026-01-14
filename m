Return-Path: <linux-pci+bounces-44788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4772D209C1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A25083023D0B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9393632570A;
	Wed, 14 Jan 2026 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3f4RUtw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E68F324B1B
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412757; cv=none; b=L+CCN0w2hxS0BcN1GZbFpXNYcS2sLqCIrY2dBVW2tYlI348H/pmpC2vuBx5gmPw/3rSgpTDbtateVPxRB2G/QnyPxOvWxBhgE9qlYsRyBRtnOGQQa+usx6WA8h3GVz3HnFOvCvqI/D2swsacPP1Z171A6NuIETsWpDxfgh4eziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412757; c=relaxed/simple;
	bh=VLyvNJXlQ7uY8tpXWo5FC7Z644s2L6LFH6yjNoy6qEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Anr/JDteuM2SQ+mfQqdeamOglx8zI2BxXL9vn5sc2UHLk2p43WNF0PXorOY8ZgSb11HI/2DUmuaNjtc0s2faiuVa+bDMBcBwUWtiU9HQUMdbRI2VV6ZmBRIORfZlDddsLksczEkxwPcDS1Wc4aDPqsC0eGcZniN5oigqYqo8Xtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3f4RUtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304B7C2BCB2
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 17:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768412757;
	bh=VLyvNJXlQ7uY8tpXWo5FC7Z644s2L6LFH6yjNoy6qEE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L3f4RUtwn3UXoZPZmKpVuAv7wS20RfV9nBeLqZmGUIuaNo8FvXrtH44hdthYVevDH
	 QSVQZx/Ui5iVSgXFYt4fQV/OR2h5BgZM0KQs8bOzjqskmkZBBtcPZdAQe8kvMzlQV7
	 0D8fQ5rfmBXgU6sADeLNFwDWj4BiYHWgcJBj3/HVC2LCKSPDslf04gYsc7F7fomOS6
	 XAeELhC98vWgbpqPJYZUyYa6bAtBZ8ms96XRGp9rnARwthStUCk/pgZyhS8Dvx7NH+
	 4ef2okqQF+r1LwZp/eSJ0JojapcPG691nvMn06RUn32l9vbyAkm7o3fyZIw/LWsY3F
	 XlpOzBa2RmVkQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b872f1c31f1so18765966b.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 09:45:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZaYUbpeU7UXK0VtwHm/9JatZtJuLjdZZz+utyddZ26WwDFiK42M2lyoQYlqfW4m11uFwxiH2uWO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2qDFuFkIuTtZUF9ZmtMfMnvpw9ePXbHBrtW1h0C2Z3uKgwpI
	tGo49vJx35MwwHWVa+bwD4xJ7n8nhSz220mZvkyC9rWZtGLJrA9Wqy3HC2Ew+TPP6I1sZ/Bl8lx
	CoRkw9xlp20eF+86q8jv3aMnFMEjDZw==
X-Received: by 2002:a17:907:6d14:b0:b7d:1d1b:217a with SMTP id
 a640c23a62f3a-b87611110eamr270292166b.34.1768412755531; Wed, 14 Jan 2026
 09:45:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-5-eff84d2c6d26@oss.qualcomm.com> <20260113171424.GA3925312-robh@kernel.org>
 <xyttom64ht5hrrp5hecjqehnyfgsv4mfl2t36e2sveu44ccpjl@lkzquse2kqsx>
In-Reply-To: <xyttom64ht5hrrp5hecjqehnyfgsv4mfl2t36e2sveu44ccpjl@lkzquse2kqsx>
From: Rob Herring <robh@kernel.org>
Date: Wed, 14 Jan 2026 11:45:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJxBNm0y6T7vji6MXgsO65iDJ-tdUEo0cOxkw7EuMKpkg@mail.gmail.com>
X-Gm-Features: AZwV_Qjd8RRdZiuji8UWlnEg_b-A7CkYgcetFKx6gFJZkZR9Wa6Q2Mjzt04XOZQ
Message-ID: <CAL_JsqJxBNm0y6T7vji6MXgsO65iDJ-tdUEo0cOxkw7EuMKpkg@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 10:14=E2=80=AFAM Manivannan Sadhasivam <mani@kernel=
.org> wrote:
>
> On Tue, Jan 13, 2026 at 11:14:24AM -0600, Rob Herring wrote:
> > On Mon, Jan 12, 2026 at 09:56:04PM +0530, Manivannan Sadhasivam wrote:
> > > Add the devicetree binding for PCIe M.2 Mechanical Key E connector de=
fined
> > > in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> > > provides interfaces like PCIe or SDIO to attach the WiFi devices to t=
he
> > > host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> > > devices. Spec also provides an optional interface to connect the UIM =
card,
> > > but that is not covered in this binding.
> > >
> > > The connector provides a primary power supply of 3.3v, along with an
> > > optional 1.8v VIO supply for the Adapter I/O buffer circuitry operati=
ng at
> > > 1.8v sideband signaling.
> > >
> > > The connector also supplies optional signals in the form of GPIOs for=
 fine
> > > grained power management.
> > >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualc=
omm.com>
> > > ---
> > >  .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++++++=
++++++++++
> > >  MAINTAINERS                                        |   1 +
> > >  2 files changed, 155 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-co=
nnector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connec=
tor.yaml
> > > new file mode 100644
> > > index 000000000000..b65b39ddfd19
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector=
.yaml
> > > @@ -0,0 +1,154 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yam=
l#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: PCIe M.2 Mechanical Key E Connector
> > > +
> > > +maintainers:
> > > +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > +
> > > +description:
> > > +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechani=
cal Key E
> > > +  connector. Mechanical Key E connectors are used to connect Wireles=
s
> > > +  Connectivity devices including combinations of Wi-Fi, BT, NFC to t=
he host
> > > +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: pcie-m2-e-connector
> > > +
> > > +  vpcie3v3-supply:
> > > +    description: A phandle to the regulator for 3.3v supply.
> > > +
> > > +  vpcie1v8-supply:
> > > +    description: A phandle to the regulator for VIO 1.8v supply.
> >
> > I don't see any 1.8V supply on the connector. There are 1.8V IOs and yo=
u
> > may need something in DT to ensure those are powered. However, there's
> > no guarantee that it's a single supply.
> >
>
> 1.8v VIO supply is an optional supply and is only required if the platfor=
m
> supports 1.8v for sideband signals such as PERST#, WAKE#... I can include=
 it in
> the example for completeness.

My point is that PERST# and WAKE# supplies could be 2 different 1.8V
supplies and those supply the I/O pads of the GPIO pins (and possibly
external pull-ups) that drive them. The 1.8V supply doesn't supply
1.8V to the slot, so making it a slot/connector property is wrong.

This isn't exactly a new issue. It could be an issue on any binding
with GPIOs. Perhaps this needs to be handled within GPIO or pinctrl.

> > > +
> > > +    oneOf:
> > > +      - required:
> > > +          - port@0
> > > +
> > > +  clocks:
> > > +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the ho=
st system to
> > > +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3=
.1.12.1 for
> > > +      more details.
> > > +    maxItems: 1
> > > +
> > > +  w-disable1-gpios:
> > > +    description: GPIO input to W_DISABLE1# signal. This signal is us=
ed by the
> > > +      system to disable WiFi radio in the M.2 card. Refer, PCI Expre=
ss M.2
> > > +      Specification r4.0, sec 3.1.12.3 for more details.
> > > +    maxItems: 1
> > > +
> > > +  w-disable2-gpios:
> > > +    description: GPIO input to W_DISABLE2# signal. This signal is us=
ed by the
> > > +      system to disable WiFi radio in the M.2 card. Refer, PCI Expre=
ss M.2
> > > +      Specification r4.0, sec 3.1.12.3 for more details.
> > > +    maxItems: 1
> > > +
> > > +  viocfg-gpios:
> > > +    description: GPIO output to IO voltage configuration (VIO_CFG) s=
ignal. This
> > > +      signal is used by the M.2 card to indicate to the host system =
that the
> > > +      card supports an independent IO voltage domain for the sideban=
d signals.
> > > +      Refer, PCI Express M.2 Specification r4.0, sec 3.1.15.1 for mo=
re details.
> > > +    maxItems: 1
> >
> > What about SDIO and UART WAKE, SDIO RESET, and vendor defined signals?
> >
>
> Not sure about vendor defined signals as they can be either GPIO or inter=
face
> signals. How should them be defined?

That kind of breaks any notion of this being a generic slot/connector.
How's the host supposed to know how to connect them? What if a card
required them to be driven a certain way before you can discover the
card? If they can be GPIOs and can be hooked up to the host system
GPIOs, then you should define GPIOs for them. If they aren't GPIOs on
a host, then you omit them.

Rob

