Return-Path: <linux-pci+bounces-35392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26275B42583
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 17:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66C148252C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 15:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA4F244685;
	Wed,  3 Sep 2025 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apnG0CKT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276823D287;
	Wed,  3 Sep 2025 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913373; cv=none; b=Ev9j0IvHht1cY36Lw2XqO1WHGQNrOxh97NDGF4fNruGTc0woQnP3txPz9YT4cqe0wEqvFO/axMpFF+XiT1fwPFyiGssXYQdl2Yyzyc2bPYTOOxki0aRrq5KL6SipOjmGLa8tGIGYNe7gGT+T4VyPMUarvWyRG3Qft+oN3g6jzS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913373; c=relaxed/simple;
	bh=VIC3yESeSFavKGxbmPdXIWhH/KHmeXOIED4A31+ezvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQAn0YUg5oqDl4Ow3Ac3SPFsTpMGQajXNu+XkUOp5Cs78jZXeYxN+Z6UXswOM4+4thFMLqAaH1MCDDiWcFYmv56uSD5FIJa15EVo8ySW/Vk2cUl2+B4apoFsbqtCKbawTlkE9VCjqw1JQulYajfNu/xzFnfD40V8R2f8dp66oOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apnG0CKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F2FC4CEE7;
	Wed,  3 Sep 2025 15:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756913373;
	bh=VIC3yESeSFavKGxbmPdXIWhH/KHmeXOIED4A31+ezvE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=apnG0CKTdKsdZHcilpZah+9QTA9Pp8xfDSZM28TFW3A/lnYW/imlO23Yo30cBBGaJ
	 FGaW8LjAN6LvwhElgRSMceeMZhJdfeQch20cEt+2eLyIYVIcWPKPhzis378GXOVOSM
	 jZiRhphCsvLh/+yrR3YM5mGsSC7HH+IEl+AXnJIDJHknOwJdQfat/egCULhZnnLEUe
	 tTRhCLKOwRFcv6zrXJeugd5cWol4mRcJv3i7ZPisLE331rl0JAm+ardoLSW1juW5Ns
	 5n1yLqrkqufDz+9UnhKbMuf1iwzKDdbeM/RYv18Y6UiAX4k03p72QHiR/DCDZnjUVJ
	 bl+uTgi5gThcQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61cebce2f78so12738138a12.1;
        Wed, 03 Sep 2025 08:29:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNTNAylWNhwXV8XNSetbLUI5pi+SUsYo40w4qmI3i1NuPOYfLdfNpYDWP85O0UCAd3d6oTwe5JI9QLrj0=@vger.kernel.org, AJvYcCWeOLpeVcaTjIKy3o1e6cRT2bHMu8DN69rLOsZs9DndK0aJ2+0sGJln4ieQ/peZDLJn4xfIlbmcUKQh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8hUtAi/Rgpwb+ILvRrQF4nPn/qWfKNgU7BoffB3BgyWElUPjO
	Gaf1wpFLipctvSkHZCf5+bGm95cI5wkYbXDn/pq4tFotmTgck7EH44QaoGuNoF0aFj6RKRm4ndT
	xkcHO2f08berAP4K4Kul0SvQP2onf3A==
X-Google-Smtp-Source: AGHT+IHIZntuL2/Ac5u2OaDFAuRDB+LbG/bkyWkqoVLmP8JAXC3VGc5IAFp7aOeSXvXSi7KwhtkL+44jIjkwTuJse7Y=
X-Received: by 2002:a05:6402:3594:b0:61e:49dc:171f with SMTP id
 4fb4d7f45d1cf-61e49dc176fmr10199592a12.1.1756913371891; Wed, 03 Sep 2025
 08:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902151543.147439-1-klaus.kudielka@gmail.com> <hiu2ouj4f7zak2ovtwtigf6fylz4c7fdyyqiqezsddoouzr4n5@bfs7kudjfnp5>
In-Reply-To: <hiu2ouj4f7zak2ovtwtigf6fylz4c7fdyyqiqezsddoouzr4n5@bfs7kudjfnp5>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Sep 2025 10:29:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLo8WbHMtjdbsauncusFh--OkNWXcN_pkpPxxT8xAmBNA@mail.gmail.com>
X-Gm-Features: Ac12FXy3-NzR24Y_vWe7NkORfh2uesLtfRvYO0BBWxGtos2fLyE26nKGT2Xfr8k
Message-ID: <CAL_JsqLo8WbHMtjdbsauncusFh--OkNWXcN_pkpPxxT8xAmBNA@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Fix the use of the for_each_of_range() iterator
To: Jan Palus <jpalus@fastmail.com>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 7:44=E2=80=AFAM Jan Palus <jpalus@fastmail.com> wrot=
e:
>
> On 02.09.2025 17:13, Klaus Kudielka wrote:
> > The blamed commit simplifies code, by using the for_each_of_range()
> > iterator. But it results in no pci devices being detected anymore on
> > Turris Omnia (and probably other mvebu targets).
> >
> > Analysis:
> >
> > To determine range.flags, of_pci_range_parser_one() uses bus->get_flags=
(),
> > which resolves to of_bus_pci_get_flags(). That function already returns=
 an
> > IORESOURCE bit field, and NOT the original flags from the "ranges"
> > resource.
> >
> > Then mvebu_get_tgt_attr() attempts the very same conversion again.
> > But this is a misinterpretation of range.flags.
> >
> > Remove the misinterpretation of range.flags in mvebu_get_tgt_addr(),
> > to restore the intended behavior.
> >
> > Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> > Fixes: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for =
parsing "ranges"")
> > Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> > Closes: https://lore.kernel.org/r/20250820184603.GA633069@bhelgaas/
> > Reported-by: Jan Palus <jpalus@fastmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220479
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controlle=
r/pci-mvebu.c
> > index 755651f338..4e2e1fa197 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -1168,9 +1168,6 @@ static void __iomem *mvebu_pcie_map_registers(str=
uct platform_device *pdev,
> >       return devm_ioremap_resource(&pdev->dev, &port->regs);
> >  }
> >
> > -#define DT_FLAGS_TO_TYPE(flags)       (((flags) >> 24) & 0x03)
> > -#define    DT_TYPE_IO                 0x1
> > -#define    DT_TYPE_MEM32              0x2
> >  #define DT_CPUADDR_TO_TARGET(cpuaddr) (((cpuaddr) >> 56) & 0xFF)
> >  #define DT_CPUADDR_TO_ATTR(cpuaddr)   (((cpuaddr) >> 48) & 0xFF)
> >
> > @@ -1189,17 +1186,10 @@ static int mvebu_get_tgt_attr(struct device_nod=
e *np, int devfn,
> >               return -EINVAL;
> >
> >       for_each_of_range(&parser, &range) {
> > -             unsigned long rtype;
> >               u32 slot =3D upper_32_bits(range.bus_addr);
> >
> > -             if (DT_FLAGS_TO_TYPE(range.flags) =3D=3D DT_TYPE_IO)
> > -                     rtype =3D IORESOURCE_IO;
> > -             else if (DT_FLAGS_TO_TYPE(range.flags) =3D=3D DT_TYPE_MEM=
32)
> > -                     rtype =3D IORESOURCE_MEM;
> > -             else
> > -                     continue;
> > -
> > -             if (slot =3D=3D PCI_SLOT(devfn) && type =3D=3D rtype) {
> > +             if (slot =3D=3D PCI_SLOT(devfn) &&
> > +                 type =3D=3D (range.flags & IORESOURCE_TYPE_BITS)) {
> >                       *tgt =3D DT_CPUADDR_TO_TARGET(range.cpu_addr);
> >                       *attr =3D DT_CPUADDR_TO_ATTR(range.cpu_addr);
>
> Thanks for the patch Klaus! While it does improve situation we're not
> quite there yet. It appears that what used to be stored in `cpuaddr` var
> is also very different from `range.cpu_addr` value so the results
> in both `*tgt` and `*attr` are both wrong.
>
> Previously `cpuaddr` had a value like ie 0x8e8000000000000 or
> 0x4d0000000000000. Now `range.cpu_addr` is always 0xffffffffffffffff.
> Luckily what used to be stored in `cpuaddr`:

~0 is OF_BAD_ADDR which means we couldn't translate the address. Seems
it is not needed here, but it should work. Can you define DEBUG in
drivers/of/address.c and post the log?

Rob

