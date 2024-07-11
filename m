Return-Path: <linux-pci+bounces-10185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A193A92F059
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 22:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA541C222E6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 20:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D86A19E82B;
	Thu, 11 Jul 2024 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC5TdLpX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F013DDD1;
	Thu, 11 Jul 2024 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730022; cv=none; b=rBMaqWYTBCf4Um6LgyWg8aGGRggvev430Z9O2pnPmgpgQx9XeQpc+lF2qLiY4kJZ1zkzfsZmZK8YtOimRs1or5uOhsA9fUg1iCr8v/SRsNv2bwbopb9s8i+bRFDPyLBdGWTuz51IMbp1xJNo7YLV2AiyhxVnF3BND0jhRtXmYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730022; c=relaxed/simple;
	bh=3s6t0CswabjkJ7pow6bUNxhLXYvaA+fwYXXiJ7M6KrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6xt7ik1mxQ6NGqPbh6EM0S9/zUjlTnDsUQSN2P8pUc3Z8VOwo//Xd9pmNR32OxYUr6BEj1LkxA3XWeu0Ug60hXAP6WeviA73eTV70Z02Fiqt30xnALH452yQheWQkQBCGJ+/XjpAX/7F46uUPCnuJev2CBdiTU99bJt74n8bhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC5TdLpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91391C4AF0F;
	Thu, 11 Jul 2024 20:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720730021;
	bh=3s6t0CswabjkJ7pow6bUNxhLXYvaA+fwYXXiJ7M6KrM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EC5TdLpX0cKuGNtGI5lbjNazbh4b8srWK6Qr3KGytIVpJ7z7VHQgcH6KcRiDefGMU
	 PlqZ9FV7kS4CM2sR8DUYfAymwuhS+nlL4TgemH5KwTtesZyeFe3AO8jttTgmRp3AzC
	 /ldEAlX/b74vkHINFzs+0d6RmKQOWqW23UPABOkbTEmJ9rjG/+vU1S31J9IP26ZsrU
	 xyBdio3tWVAwMkSBkmph3nKQxEEwewJwU2OC6ZHj3p9hJetGRYdW+PHWQJ9Tial9+y
	 PPeCXU4BuwZTGqO0ZYx/mCE3menTaQJS4ZfKtuDEE5EJcl/NDxTvyDnf9dqYTe3aD3
	 N8DqVOilynUfQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ea5dc3c66so2172067e87.3;
        Thu, 11 Jul 2024 13:33:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGShef0Q2SyOOOGZMS3/1JrWphjlaDlb5Izl/Qd3jyu8uo6tu4j9e4f2J1EapkqBPOB2IM44Ji2m+htA252nfNsHmifwKW8UXmBjF3CcWsWvvQz6hjONYTUpizqqNX9mNaWeaKww2+rseeFp1Q3pOUDN+3dCN8fmuxP21xSNPmRLdvTJnOtlMiJjssXKN3oDbdrTDWKaHqAZIoqA==
X-Gm-Message-State: AOJu0YzYF9xw1sKrQ9RLRFFRqR1JrL22cbnItbnCs5NYjvmVjHKE+bT2
	2q/4RHEv45/5o1PKxVn+IiK2SkZWzA+ULgpsrVuSZsG2JwOI/fMbUj4KEIyC+apXKjHNoJeSo5k
	tU0sV1rKhhOZICN2o49ugKGX0yw==
X-Google-Smtp-Source: AGHT+IH9fDJBb6vRKIf7eJgNl1y1C3rVvgy59J3R4rDDXXqqxjPM6C27hXW9YPtUAfvsjk0rbroExhSGNYkcvc2LVEY=
X-Received: by 2002:a05:6512:3ca5:b0:52b:c33a:aa7c with SMTP id
 2adb3069b0e04-52eb99d652emr7657946e87.65.1720730019781; Thu, 11 Jul 2024
 13:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627091137.370572-1-herve.codina@bootlin.com>
 <20240627091137.370572-7-herve.codina@bootlin.com> <20240711152952.GL501857@google.com>
 <20240711184438.65446cc3@bootlin.com> <2024071113-motocross-escalator-e034@gregkh>
In-Reply-To: <2024071113-motocross-escalator-e034@gregkh>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Jul 2024 14:33:26 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1r3SSaXupdNAcXO-4rcV-_3_hwh0XJaBsB9fuX5nBCQ@mail.gmail.com>
Message-ID: <CAL_Jsq+1r3SSaXupdNAcXO-4rcV-_3_hwh0XJaBsB9fuX5nBCQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] mfd: Add support for LAN966x PCI device
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Herve Codina <herve.codina@bootlin.com>, Lee Jones <lee@kernel.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	UNGLinuxDriver@microchip.com, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 1:08=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 11, 2024 at 06:44:38PM +0200, Herve Codina wrote:
> > Hi Lee,
> >
> > On Thu, 11 Jul 2024 16:29:52 +0100
> > Lee Jones <lee@kernel.org> wrote:
> >
> > > On Thu, 27 Jun 2024, Herve Codina wrote:
> > >
> > > > Add a PCI driver that handles the LAN966x PCI device using a device=
-tree
> > > > overlay. This overlay is applied to the PCI device DT node and allo=
ws to
> > > > describe components that are present in the device.
> > > >
> > > > The memory from the device-tree is remapped to the BAR memory thank=
s to
> > > > "ranges" properties computed at runtime by the PCI core during the =
PCI
> > > > enumeration.
> > > >
> > > > The PCI device itself acts as an interrupt controller and is used a=
s the
> > > > parent of the internal LAN966x interrupt controller to route the
> > > > interrupts to the assigned PCI INTx interrupt.
> > >
> > > Not entirely sure why this is in MFD.
> >
> > This PCI driver purpose is to instanciate many other drivers using a DT
> > overlay. I think MFD is the right subsystem.

It is a Multi-function Device, but it doesn't appear to use any of the
MFD subsystem. So maybe drivers/soc/? Another dumping ground, but it
is a driver for an SoC exposed as a PCI device.

> Please use the aux bus for that, that is what is was specifically
> designed for, and what it is being used for today.

We discussed this already[1]. Different usecase, but needs the same thing.

Like I said before, the bus and device used for DT MMIO devices is
like it or not platform bus/device.

In this case, all the child devices are already supported as platform
devices. There would be zero benefit to add all the boilerplate to
make their drivers both platform and aux bus drivers. Plus there is
zero DT support in aux bus.

Rob

[1] https://lore.kernel.org/all/Y9kuxrL3XaCG+blk@kroah.com/

