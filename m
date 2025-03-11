Return-Path: <linux-pci+bounces-23425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00F8A5C2C2
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 14:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CED5171AE8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBF71C07D9;
	Tue, 11 Mar 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjUGOna9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919551487E9;
	Tue, 11 Mar 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699964; cv=none; b=Wj64mCmbCbkKqDYPGc8ANA5TAQpx3vPvFDDMFGf7oOQzCbUt9fHEDoWeSUrtDE9iczlVQIhhiyw1zqYFDdQh5Q0WQrnZIKdeAY5Fwit2hqXcCRagH+bxWBBlMzuw2lrFXxuutv3zITRCfhabsu1OXmOy17ARO/qmISdrGfbyNIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699964; c=relaxed/simple;
	bh=foFBmGFbc+QCSONoZVpR+givHeN3h/c5aJuICUYGiE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXNuSj4+ueC4+4VILS36C8qLSsy+Ke6mtZjwPpHczd70V4caUSDwjheL0xWSv8u0WWI3y5cqMQ2KmRajk7Sz/13SiM4nWk9C4i6/PYhu16jzIZ1WnGbk3w8gpv9qtGVsi3CQRaPB3FK4KDWC8Kk/+L9bKDhlQsL5XFEOHH9By2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjUGOna9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2A3C4CEF3;
	Tue, 11 Mar 2025 13:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741699964;
	bh=foFBmGFbc+QCSONoZVpR+givHeN3h/c5aJuICUYGiE0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IjUGOna96P6PIijXA/JopSCd1d/VyKBBN+ce/Ed0nBiLhKysYuXMOO8ntjKoNJFoo
	 KvvRKcBWnITLYLhGRnSUQitn+rIdSSRK2Cpm5n6Mn/118FAtbrimE5jYp/UXlZTfql
	 gprF+LsaUajaD4mfZOL8d+MWXSTnEbYoMmCi0oUOd2lKGUmCmlD38v+i4Wiq5Pmpjr
	 ayzyPa2JHPukyRerL2/P8O+UDUAqMM7QygXATRowtyikvNNz/2O+EBnThkGFsw2KTR
	 mnRaXP7EryYvf+2VABTSHwEZzyziKQIuYIaobgi/ftZzS8lPgE5Ag3aYBUTqbdFhEr
	 HnFlBeThaEv+w==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so8324312a12.3;
        Tue, 11 Mar 2025 06:32:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVE/etq7yYVR731//mLbIx6fuz4N3WBsp/taDv6DUAdjSAvEFKqUOOcbNyt/mjSFvGPbId9zBqo21EC1w==@vger.kernel.org, AJvYcCVFFxWXi1G8EDjZ5tpKHuBLeDYh4rjTO2HNngx05BKIuJGzRJWd0LGcG/kHH0ZIDsQJKt2BCiE2koKJ@vger.kernel.org, AJvYcCW8UgNm2ORV6uv3gidMyg8hIgmUN1Lt9mJoi+wO2yxk3H2Rn4pAsnqQt1dohVxqKOsczdONO8z4Tw5a@vger.kernel.org, AJvYcCXkMokhN/355TGe12OSjeljQvVcn00quRImZ2ljZ6tIYzQ4VTmMH7PvgM8LtAe7ue13DOn99RcbuXyV@vger.kernel.org, AJvYcCXsHpk+Kco0TOlhTmQxQXJOw/sJn9QgRvlPYy+FAXFETqK6kuxts8w7ztT6RQVlVCkfabZPUZ8p2Ny2wNuE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvnou1cphY4sdaDF6XuvRYP/txe/G9yT/v+J9yb9bKE0VqXdDN
	KvnBxlQ8CXvCoJnhV1poU82s4+iFqTkRNkkMVcKGumV5WsZTjOlXsmeX06w6v9K1ITKFtPLZnjO
	2tXt6e1OYEiuildher/TYDvdidw==
X-Google-Smtp-Source: AGHT+IEifrCmqJfikkidIDTYr2jS6o8iDBri/VlKwu/FWmzn0+fbwXWdCCMBLNQSNY6IZ7RZHzcbstx5Fj81dc05srU=
X-Received: by 2002:a05:6402:2353:b0:5e5:c5f5:f82 with SMTP id
 4fb4d7f45d1cf-5e5e211e1f1mr21034407a12.0.1741699962525; Tue, 11 Mar 2025
 06:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738963156.git.andrea.porta@suse.com> <c0acc51a7210fb30cae7b26f4ad1f0449beed95e.1738963156.git.andrea.porta@suse.com>
 <20250310212125.GB2377483@rocinante>
In-Reply-To: <20250310212125.GB2377483@rocinante>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Mar 2025 08:32:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKPGOdS_8KDggO5tBHAnC-NTLAC5iS9GANm9BuxBfQUsw@mail.gmail.com>
X-Gm-Features: AQ5f1JpFqtVYiSlkH0QD-dTfJ4bf9VAjFuYNndnQ1jy7PeA-IWSalDclsIDbfBA
Message-ID: <CAL_JsqKPGOdS_8KDggO5tBHAnC-NTLAC5iS9GANm9BuxBfQUsw@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] dt-bindings: pci: Add common schema for devices
 accessible through PCI BARs
To: Krzysztof Wilczynski <kw@linux.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 4:21=E2=80=AFPM Krzysztof Wilczynski <kw@linux.com>=
 wrote:
>
> Hello,
>
> [...]
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d45c88955072..af2e4652bf3b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19752,6 +19752,7 @@ RASPBERRY PI RP1 PCI DRIVER
> >  M:   Andrea della Porta <andrea.porta@suse.com>
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.ya=
ml
> > +F:   Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> >  F:   Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.ya=
ml
> >  F:   include/dt-bindings/clock/rp1.h
> >  F:   include/dt-bindings/misc/rp1.h
>
> I would be happy to pick this via the PCI tree as per the standard
> operating procedure.  However, the MAINTAINERS changes do not exist
> for us yet, and are added in the first patch of the series, which is
> not ideal.
>
> I can add the missing dependency manually, but that would cause issues
> for linux-next tree, which is also not ideal.
>
> I saw some review feedback, as such, when you are going to be sending
> another version, can you make MAINTAINERS changes to be the last patch,
> perhaps.  Basically, something standalone that perhaps whoever will pick
> the misc patch could also pick and apply at the same time.
>
> Alternatively, someone else picking up the PCI dt-bindings would work, to=
o.
>
> Your thoughts?

I guess I missed this in review, but why is a common schema buried in
a device maintainer entry? Also, an entry in MAINTAINERS is redundant
anyway because get_maintainers.pl can fetch maintainers from the
schema file.

Rob

