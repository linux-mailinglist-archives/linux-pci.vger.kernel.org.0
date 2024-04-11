Return-Path: <linux-pci+bounces-6146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDFA8A1E07
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 20:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4604F28E90D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 18:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424F7130A42;
	Thu, 11 Apr 2024 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D57Dm9na"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E321E892;
	Thu, 11 Apr 2024 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857303; cv=none; b=c2AOT/orD75sm7gM7ApRyLsj+do4gc65Bb1oiN431RFbYIrKamUE4CwmN5Q2rrefjkbCAoqedQyqo/88NpNfZQ9rKbfTxMJI3Qlw42QmzLkW9KQTagHYoxDslPQwZ1MInmNCdmpb2ldrzCWaQk9ZI98r0p6Whkbz3kaHxWksKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857303; c=relaxed/simple;
	bh=DoJYSiMJhYT9Zt6gL2BrmpCKBnw00cmz4PnYnC16w5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwmNXKiRF1P5ivu9O5/WcYRnqwrD61JH4YR0+mMItMxHNUD7VKCiWA58hyn2+7+MAQqT0XqbF7CGT+rrCKrojfNhour7vwSz0ccejPPiwgvRhb1Wtk/8j7VRd/5MFmubw4B4Hyf1UDiZA7f7KEKXHkP6OUXB70hbZdF4WCph9Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D57Dm9na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EEDC2BD10;
	Thu, 11 Apr 2024 17:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712857302;
	bh=DoJYSiMJhYT9Zt6gL2BrmpCKBnw00cmz4PnYnC16w5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D57Dm9naJovNyxjN+f4aK9UEhia+7xBZ5MkhbWxsEKsouoD9VR5HyxJ5oTVAWHCjb
	 dtJXrqqBbam7Ebzp9GS7S90fyxedAGal4WgfiO7sOcXo5myFf7hNnj0B/EH10Jxhsz
	 8TiWXIpMKl7BCob/OsWv+skUeQDl/S0KYW0Vr/5EuGpJ16JCqcWzxaUvuHKJ9XUbbi
	 CSENDnGpBt9rbplij+sVAGrhpZAtha0txZMtw6gUe8PkUKXdOJXiNbJsYo2NDTOcQL
	 Y6PMOlqq3rqEDmXL2M0h33mpmxiQYTqjK5SqIn+kAlSm5TTPnngLQiq4aeZWDOr0eP
	 I7UAhbLSYWkLg==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4155819f710so878385e9.2;
        Thu, 11 Apr 2024 10:41:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/t6ZleoCy+GTcclfp17JOnM1izxkprtDAhmvP26Jsyu17qxYGN97UyH9CiyNroggWtG6BYdiurW0mjcbZta3VTCpyqu/31ivhRoHdE0wW7xm91NpwVothIc6lSUqB4NNaacr8NgG0bbzSe+sPPqAkbVqiLZEQEjuhBSRYdG902KCYQ5zdvQ/XhnV7AMt5eJAoyQhoWhEYNB7mPJBrg4x+ecUt9GqlSnijns2YT/k0nXj0hI1VkmszVZzp7FD95/fN9sXM+Q==
X-Gm-Message-State: AOJu0Ywe439K/4LIETRslV0ClpKONy8MP1tQ84+y5Eq46R6WUP2PWxCR
	y5LI3TzGIx0wmIQlxNi2wE03zTPev0eu/rrUclZjYISvYBj1OBpZ7zTBcd5pZpjFlCCrEkMVAy1
	oFMPn+wwiK13U1lpURt9y4J5GSA==
X-Google-Smtp-Source: AGHT+IGTYTnd27cZwUZ7kXUf6/DQ0pj9531II4F7GuikLZRsZ/ZfHrcFFNL5HrA9aNOfAtjGuv7mboSXH/hsVf3pPeQ=
X-Received: by 2002:a19:f60a:0:b0:517:535b:9f2d with SMTP id
 x10-20020a19f60a000000b00517535b9f2dmr231054lfe.25.1712857280506; Thu, 11 Apr
 2024 10:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411142107.GA3537062-robh@kernel.org> <20240411161108.GA2184354@bhelgaas>
In-Reply-To: <20240411161108.GA2184354@bhelgaas>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Apr 2024 12:41:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKaJR9v=EEwm=rGf-XtXhhSd4_U2FUJoCoN_mcvPBtPBA@mail.gmail.com>
Message-ID: <CAL_JsqKaJR9v=EEwm=rGf-XtXhhSd4_U2FUJoCoN_mcvPBtPBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: PCI: mediatek,mt7621: add missing
 child node reg
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Will Deacon <will@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Srikanth Thokala <srikanth.thokala@intel.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Heiko Stuebner <heiko@sntech.de>, Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Tom Joseph <tjoseph@cadence.com>, Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:11=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Thu, Apr 11, 2024 at 09:21:07AM -0500, Rob Herring wrote:
> > On Thu, Apr 11, 2024 at 07:39:17AM -0500, Bjorn Helgaas wrote:
> > > On Thu, Apr 11, 2024 at 08:13:18AM +0200, Sergio Paracuellos wrote:
> > > > On Thu, Apr 11, 2024 at 8:01=E2=80=AFAM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > > On 10/04/2024 23:26, Bjorn Helgaas wrote:
> > > > > > On Wed, Apr 10, 2024 at 08:15:19PM +0200, Krzysztof Kozlowski w=
rote:
> > > > > >> MT7621 PCI host bridge has children which apparently are also =
PCI host
> > > > > >> bridges, at least that's what the binding suggest.
> > > > > >
> > > > > > What does it even mean for a PCI host bridge to have a child th=
at is
> > > > > > also a PCI host bridge?
> >
> > It should say 'root port' instead as the binding description correctly
> > says.
>
> OK, that makes a lot more sense, and we should fix the commit log.
>
> > > > > I think the question should be towards Mediatek folks. I don't kn=
ow what
> > > > > this hardware is exactly, just looks like pci-pci-bridge. The dri=
ver
> > > > > calls the children host bridges as "ports".
> > > >
> > > > You can see the topology here in my first driver submit cover lette=
r
> > > > message [0].
> > > >
> > > >  [0]: https://lore.kernel.org/all/CAMhs-H-BA+KzEwuDPzcmrDPdgJBFA2Xd=
YTBvT4R4MEOUB=3DWQ1g@mail.gmail.com/t/
> > >
> > > Nothing unusual here, this looks like the standard PCIe topology.
> > >
> > > What *might* be unusual is describing the Root Ports in DT.  Since
> > > they are standard PCI devices, they shouldn't need DT description
> > > unless there's some unusual power/clock/reset control or something
> > > that is not discoverable via PCI enumeration.
> >
> > It's only unusual because typically there's only 1 RP per host bridge
> > and properties which really apply to the RP get stuck in the host bridg=
e
> > node because we don't have a RP node. An example is perst-gpios. That's
> > not a property of the RP either, but the RP is the upstream side of a
> > slot and we often don't have a node for the device either.
>
> Makes sense.
>
> I'm still confused about one thing, maybe just because I don't really
> know how to read these bindings.  The binding now looks like this:
>
>   properties:
>     compatible:
>       const: mediatek,mt7621-pci
>
>     reg:
>       items:
>         - description: host-pci bridge registers
>         - description: pcie port 0 RC control registers       # A
>         - description: pcie port 1 RC control registers       # A
>         - description: pcie port 2 RC control registers       # A
>
>   patternProperties:
>     '^pcie@[0-2],0$':
>       type: object
>       $ref: /schemas/pci/pci-pci-bridge.yaml#
>
>       properties:
>         reg:                                                  # B
>           maxItems: 1
>
> It looks like the "A" items are separate things from the "B" items?
>
> But I think the relevant code is here:
>
>   mt7621_pcie_probe
>     mt7621_pcie_parse_dt
>       pcie->base =3D devm_platform_ioremap_resource(pdev, 0)             =
# 1
>       for_each_available_child_of_node(node, child)
>         mt7621_pcie_parse_port
>           port->base =3D devm_platform_ioremap_resource(pdev, slot + 1)  =
# 2
>
> where it looks like both "1" and "2" use the items in the "A" list,
> i.e., resources 0, 1, 2, 3, all from the same platform device.  Is
> there code that uses the "B" item that this patch adds?

The A items are in the host address space. The B item is a PCI
address. Specifically, for PCI devices, the first entry is config
space with just the device and function (devfn). The format is defined
in the OpenFirmware PCI bus supplement.

Rob

