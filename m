Return-Path: <linux-pci+bounces-45052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BB4D32796
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 15:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7FAB300092A
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBA9328B63;
	Fri, 16 Jan 2026 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxL4pcBU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D931BCA9
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573162; cv=none; b=nuXGaKVAAyMy2v34W3kvbg2zTNYVVh9/HQ20qEaJfqoJUjNLaNoJqxvQxkUNL3cNzE02RsJU/pTISh4g1nhNdB/vdG0ZMa29oAYdiM3H2iaiSJ1hYZwo4xikUdADtziw1BCJvpmlZLn533NaKezlChU/OoiJ/zv3eZrtiPSg2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573162; c=relaxed/simple;
	bh=JghXPm6HOBFNktLIBiI8eyfuN76nwomk97JpiXS3QS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChtOy5OUvJxBwrnlGdsZFI8Weo0zWavNepE0Og06lyd16dlwz/RfXoOLebZNh9b7OUj8vGh1zQNNsMzkrZSUIbKDCcR2IeknGSzPSyEO6Y9N66qz2dv7tjub07tt+6H3fZWef+Gqpsq+ZBlaI0rjgnod3Q4OiiMbmjMaoyRnqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxL4pcBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB05C2BCB2
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768573161;
	bh=JghXPm6HOBFNktLIBiI8eyfuN76nwomk97JpiXS3QS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OxL4pcBU9qQTdx9n8ylW4+63JJn3jJQq1mb+5GohfdbIkucdwgCLkyjualU8mlIyy
	 KxP0DkLB/NyJewlJloc2Fr0VoT54B2cMfGhElk2oGuLk/HATJ2d9MzlmU+xlLNVKLi
	 UdxOLCIiz/MBK4oMCLlstwC4mmVWzFqsjfE2WAPVfZ98PBKaU/gylwOIuMy3iBVnSS
	 FI2bcwrjfnZ0xPfq38Jr5byWaPhIJFGWpXgFYfrCyyrVBEfGaUwReAp4jwJLCZoWvb
	 O/8HwT//akwL51JCMSdMN8En3448ykrd3BUbpmXuYrUeQLGPvkOUu7Q9lJY0SGmlRm
	 GUEfyx4z/vcsQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b879d5c1526so129214566b.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 06:19:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVlbvGZe5zIO7C3VgljLMc6ZXZzsaWDCct1PoGZJ6szf7yuM2XYnKnyJUhA3bvDPFDgUSq4awRVhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOgv/aL8OxQ/BEBf//m68+QFqnkw5aEAq3bgRBlCxpLK9jcXDL
	b+WhI0+zs7rGCMEK0vAxCHiBKAHVHNsrUUrSOO2SBWIXCIAhBMNLGnNDlemKk6YWbx09QDxbQ7B
	kG0286oxS7AdKC2U8ZsyAQvgWiJBx8Q==
X-Received: by 2002:a17:907:d03:b0:b87:892:f43f with SMTP id
 a640c23a62f3a-b87969386d0mr231202266b.29.1768573159725; Fri, 16 Jan 2026
 06:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-5-eff84d2c6d26@oss.qualcomm.com> <20260113171424.GA3925312-robh@kernel.org>
 <xyttom64ht5hrrp5hecjqehnyfgsv4mfl2t36e2sveu44ccpjl@lkzquse2kqsx>
 <CAL_JsqJxBNm0y6T7vji6MXgsO65iDJ-tdUEo0cOxkw7EuMKpkg@mail.gmail.com> <gcmm23ji4fkcqeshcyiehuyega7kdbtvmofp4usmol2icwn6gy@i46icelwwqh5>
In-Reply-To: <gcmm23ji4fkcqeshcyiehuyega7kdbtvmofp4usmol2icwn6gy@i46icelwwqh5>
From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Jan 2026 08:19:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKKBjurY7ZrScayvkTijR-F6GWBofry48xoPFBFi55u4w@mail.gmail.com>
X-Gm-Features: AZwV_QhaVXIgz8bq4CqPsm9NXLoIfFaoT-4jNhJ-ZskY8n0WuXohQmqAGOhuiUQ
Message-ID: <CAL_JsqKKBjurY7ZrScayvkTijR-F6GWBofry48xoPFBFi55u4w@mail.gmail.com>
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

On Thu, Jan 15, 2026 at 4:42=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Wed, Jan 14, 2026 at 11:45:42AM -0600, Rob Herring wrote:
> > On Wed, Jan 14, 2026 at 10:14=E2=80=AFAM Manivannan Sadhasivam <mani@ke=
rnel.org> wrote:
> > >
> > > On Tue, Jan 13, 2026 at 11:14:24AM -0600, Rob Herring wrote:
> > > > On Mon, Jan 12, 2026 at 09:56:04PM +0530, Manivannan Sadhasivam wro=
te:
> > > > > Add the devicetree binding for PCIe M.2 Mechanical Key E connecto=
r defined
> > > > > in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This conne=
ctor
> > > > > provides interfaces like PCIe or SDIO to attach the WiFi devices =
to the
> > > > > host machine, USB or UART+PCM interfaces to attach the Bluetooth =
(BT)
> > > > > devices. Spec also provides an optional interface to connect the =
UIM card,
> > > > > but that is not covered in this binding.
> > > > >
> > > > > The connector provides a primary power supply of 3.3v, along with=
 an
> > > > > optional 1.8v VIO supply for the Adapter I/O buffer circuitry ope=
rating at
> > > > > 1.8v sideband signaling.
> > > > >
> > > > > The connector also supplies optional signals in the form of GPIOs=
 for fine
> > > > > grained power management.
> > > > >
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.q=
ualcomm.com>
> > > > > ---
> > > > >  .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++=
++++++++++++++
> > > > >  MAINTAINERS                                        |   1 +
> > > > >  2 files changed, 155 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-=
e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-co=
nnector.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..b65b39ddfd19
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-conne=
ctor.yaml
> > > > > @@ -0,0 +1,154 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector=
.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: PCIe M.2 Mechanical Key E Connector
> > > > > +
> > > > > +maintainers:
> > > > > +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.co=
m>
> > > > > +
> > > > > +description:
> > > > > +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mec=
hanical Key E
> > > > > +  connector. Mechanical Key E connectors are used to connect Wir=
eless
> > > > > +  Connectivity devices including combinations of Wi-Fi, BT, NFC =
to the host
> > > > > +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: pcie-m2-e-connector
> > > > > +
> > > > > +  vpcie3v3-supply:
> > > > > +    description: A phandle to the regulator for 3.3v supply.
> > > > > +
> > > > > +  vpcie1v8-supply:
> > > > > +    description: A phandle to the regulator for VIO 1.8v supply.
> > > >
> > > > I don't see any 1.8V supply on the connector. There are 1.8V IOs an=
d you
> > > > may need something in DT to ensure those are powered. However, ther=
e's
> > > > no guarantee that it's a single supply.
> > > >
> > >
> > > 1.8v VIO supply is an optional supply and is only required if the pla=
tform
> > > supports 1.8v for sideband signals such as PERST#, WAKE#... I can inc=
lude it in
> > > the example for completeness.
> >
> > My point is that PERST# and WAKE# supplies could be 2 different 1.8V
> > supplies and those supply the I/O pads of the GPIO pins (and possibly
> > external pull-ups) that drive them. The 1.8V supply doesn't supply
> > 1.8V to the slot, so making it a slot/connector property is wrong.
> >
>
> Ok, I get your point that VIO 1.8v supply is just limited to the I/O logi=
c and
> not the whole card/adapter. But I don't get your multiple supplies concer=
n. Spec
> says, "A 1.8 V supply pin called VIO 1.8 V is used to supply the on-Adapt=
er I/O
> buffer circuitry operating at 1.8 V." So it implies that either the singl=
e
> supply available to the card through VIO might be used to power the whole=
 I/O
> circuit logic or the card can derive its own 1.8v supply from 3.3v supply=
.
>
> So how come the card can have 2 different 1.8v supplies powering the I/O
> circuitry?

Is there a pin on the connector for 1.8V supply? I don't have the
spec, but the pinout I found[1] didn't show one. If there's a pin,
then I have no concern.

Rob

[1] https://pinoutguide.com/HD/M.2_NGFF_connector_pinout.shtml

