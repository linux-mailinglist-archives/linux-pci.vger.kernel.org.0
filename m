Return-Path: <linux-pci+bounces-45071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51249D37A1E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 18:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 509A93007898
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429C834105D;
	Fri, 16 Jan 2026 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tbqn46Rx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA063375DC
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584671; cv=none; b=E5xdb/9xAkzXG/ktFd7cZBhIsD033BTOulQ4NKWOFpd71irQ4MoOzv63XT5S5F4AiznyR914SNN7RBRsuO0bTo4Q/O1gv5KubuaCLlf2m+sNETN4MsS62XZl8RLguFrMqLbqW3/lDBjN7skKLTbHeKSI1ZrjL2wFU29lVWNoyVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584671; c=relaxed/simple;
	bh=dacZLFUsrFNSw+mnrOAiyarQ8iNk57zLC4mQM+1G4ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrTvKvaWvYeOqQbgTilQPWONLY6VhdvMSHxZgEgXORRiBFN1ZcLDt5zMStdY3rIxE9cZNFPWd1QvWALpYH4CCz2vW0qYHZifhrOzk3/KDFfN8vkwIoq3MksoFLa9zRwvztBqc0S61GRVV90tsUyPNRnDbefRF+pRmoCXkqDhBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tbqn46Rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07F7C2BCB2
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 17:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768584670;
	bh=dacZLFUsrFNSw+mnrOAiyarQ8iNk57zLC4mQM+1G4ms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tbqn46RxyswXpSrrExNUmy11j8SVEE7pu8HvZnEbz1kpwOTRAwX1Ei9LrmrNNtijf
	 DBcPLc6iRBqqhziruuzikOYfzrxKgjD0wLfnl7NBvy26+6pAhGqwLvYCXtna81BvSo
	 ypZRmXswlxDp0ih6lGE3JSPovzNJnoIiztS3nnvwkTYhT2TZ6zJU93c90MxHqJoKAQ
	 MEFlfSsRs3FNk1/Qv0zxN4FIGD/BpzKBdTpD/BmdOJY/I1AXepWyR+3p0wxpa3vxJX
	 557N1PRl0DnJjGy1M8klAYUmZeIP4FSSYYD3NaVRYPxue7dGRqyEYRY5EeBVaLZNnM
	 hhuYeqzPdwEMw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so3604957a12.2
        for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 09:31:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyumv7sGXQq52tx7bBCEDvSrIQV/SMo5Jserq3oZQqRqeH/RSQVEeMrxLHm5bHFm6RVYTTlJJYQtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjhwYOs0UUHBsX058oZHHXEjmLbcA+uUZkrshnrQA7bUTiwL0
	Xe5aP9J3WnzJJBIi7kz2/r6npQdrxIToInZsSKm5qs3PAlud0qw7OoEy3GCWcVyVN9nsJmsPRdc
	nd+lioP38F5QLdsfSDM1t28z6s3Wxrw==
X-Received: by 2002:a05:6402:3547:b0:64c:9e19:9831 with SMTP id
 4fb4d7f45d1cf-654ba1c92e9mr2632146a12.12.1768584669199; Fri, 16 Jan 2026
 09:31:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-5-eff84d2c6d26@oss.qualcomm.com> <20260113171424.GA3925312-robh@kernel.org>
 <xyttom64ht5hrrp5hecjqehnyfgsv4mfl2t36e2sveu44ccpjl@lkzquse2kqsx>
 <CAL_JsqJxBNm0y6T7vji6MXgsO65iDJ-tdUEo0cOxkw7EuMKpkg@mail.gmail.com>
 <gcmm23ji4fkcqeshcyiehuyega7kdbtvmofp4usmol2icwn6gy@i46icelwwqh5>
 <CAL_JsqKKBjurY7ZrScayvkTijR-F6GWBofry48xoPFBFi55u4w@mail.gmail.com> <ysfkemsf4w7r3eoahfpjdr3z3buec5kvw4qol2njhxrz5tsdpo@4scz632uaj5i>
In-Reply-To: <ysfkemsf4w7r3eoahfpjdr3z3buec5kvw4qol2njhxrz5tsdpo@4scz632uaj5i>
From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Jan 2026 11:30:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLJhLgDj846Xm3xh6iTpqKcGgAc0JarsAw4gJbOOih-eA@mail.gmail.com>
X-Gm-Features: AZwV_Qgl_qLSqXPnKjpXjk329SOPF0xVaDGWoAyGNkj_0sZsVv7qP7OLwVi399U
Message-ID: <CAL_JsqLJhLgDj846Xm3xh6iTpqKcGgAc0JarsAw4gJbOOih-eA@mail.gmail.com>
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

On Fri, Jan 16, 2026 at 8:43=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Fri, Jan 16, 2026 at 08:19:07AM -0600, Rob Herring wrote:
> > On Thu, Jan 15, 2026 at 4:42=E2=80=AFAM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > >
> > > On Wed, Jan 14, 2026 at 11:45:42AM -0600, Rob Herring wrote:
> > > > On Wed, Jan 14, 2026 at 10:14=E2=80=AFAM Manivannan Sadhasivam <man=
i@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jan 13, 2026 at 11:14:24AM -0600, Rob Herring wrote:
> > > > > > On Mon, Jan 12, 2026 at 09:56:04PM +0530, Manivannan Sadhasivam=
 wrote:
> > > > > > > Add the devicetree binding for PCIe M.2 Mechanical Key E conn=
ector defined
> > > > > > > in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This c=
onnector
> > > > > > > provides interfaces like PCIe or SDIO to attach the WiFi devi=
ces to the
> > > > > > > host machine, USB or UART+PCM interfaces to attach the Blueto=
oth (BT)
> > > > > > > devices. Spec also provides an optional interface to connect =
the UIM card,
> > > > > > > but that is not covered in this binding.
> > > > > > >
> > > > > > > The connector provides a primary power supply of 3.3v, along =
with an
> > > > > > > optional 1.8v VIO supply for the Adapter I/O buffer circuitry=
 operating at
> > > > > > > 1.8v sideband signaling.
> > > > > > >
> > > > > > > The connector also supplies optional signals in the form of G=
PIOs for fine
> > > > > > > grained power management.
> > > > > > >
> > > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@o=
ss.qualcomm.com>
> > > > > > > ---
> > > > > > >  .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++=
++++++++++++++++++
> > > > > > >  MAINTAINERS                                        |   1 +
> > > > > > >  2 files changed, 155 insertions(+)
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/connector/pcie=
-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-=
e-connector.yaml
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..b65b39ddfd19
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-c=
onnector.yaml
> > > > > > > @@ -0,0 +1,154 @@
> > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id: http://devicetree.org/schemas/connector/pcie-m2-e-conne=
ctor.yaml#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: PCIe M.2 Mechanical Key E Connector
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcom=
m.com>
> > > > > > > +
> > > > > > > +description:
> > > > > > > +  A PCIe M.2 E connector node represents a physical PCIe M.2=
 Mechanical Key E
> > > > > > > +  connector. Mechanical Key E connectors are used to connect=
 Wireless
> > > > > > > +  Connectivity devices including combinations of Wi-Fi, BT, =
NFC to the host
> > > > > > > +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and =
I2C.
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    const: pcie-m2-e-connector
> > > > > > > +
> > > > > > > +  vpcie3v3-supply:
> > > > > > > +    description: A phandle to the regulator for 3.3v supply.
> > > > > > > +
> > > > > > > +  vpcie1v8-supply:
> > > > > > > +    description: A phandle to the regulator for VIO 1.8v sup=
ply.
> > > > > >
> > > > > > I don't see any 1.8V supply on the connector. There are 1.8V IO=
s and you
> > > > > > may need something in DT to ensure those are powered. However, =
there's
> > > > > > no guarantee that it's a single supply.
> > > > > >
> > > > >
> > > > > 1.8v VIO supply is an optional supply and is only required if the=
 platform
> > > > > supports 1.8v for sideband signals such as PERST#, WAKE#... I can=
 include it in
> > > > > the example for completeness.
> > > >
> > > > My point is that PERST# and WAKE# supplies could be 2 different 1.8=
V
> > > > supplies and those supply the I/O pads of the GPIO pins (and possib=
ly
> > > > external pull-ups) that drive them. The 1.8V supply doesn't supply
> > > > 1.8V to the slot, so making it a slot/connector property is wrong.
> > > >
> > >
> > > Ok, I get your point that VIO 1.8v supply is just limited to the I/O =
logic and
> > > not the whole card/adapter. But I don't get your multiple supplies co=
ncern. Spec
> > > says, "A 1.8 V supply pin called VIO 1.8 V is used to supply the on-A=
dapter I/O
> > > buffer circuitry operating at 1.8 V." So it implies that either the s=
ingle
> > > supply available to the card through VIO might be used to power the w=
hole I/O
> > > circuit logic or the card can derive its own 1.8v supply from 3.3v su=
pply.
> > >
> > > So how come the card can have 2 different 1.8v supplies powering the =
I/O
> > > circuitry?
> >
> > Is there a pin on the connector for 1.8V supply? I don't have the
> > spec, but the pinout I found[1] didn't show one. If there's a pin,
> > then I have no concern.
> >
>
> Oh yes, there is a single VIO pin defined in the spec for multiple Keys. =
Since
> it is optional, it could've been omitted in the design you referenced.
>
> So should I name it as vio1v8-supply or vpcie1v8-supply? I don't see any =
other
> 1.8v supplies other than the VIO supply though.

vpcie1v8 is fine.

Rob

