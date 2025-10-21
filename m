Return-Path: <linux-pci+bounces-38856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BE8BF50C5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 09:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 334FD4F6E6B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 07:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA72A287504;
	Tue, 21 Oct 2025 07:44:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B22737F9
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032687; cv=none; b=R+dXQFNrHpZayi66sEUxLNdvUDASGklarqu+BorkaBeJsZ784VRaUO/YhGFe+xPVb3rdz/Hr6RwrV5ELE9VzOsisQxOcnuRmOTcXqvfDKLYVOhhA08fwveUforUN0fOIwn90cqw5fOLwgsExjX5H26DQyFWHKkWda2PuM7VVTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032687; c=relaxed/simple;
	bh=IG7tayKRQ/yarsAOMuot2dwGDZWhIk36rza1ofFk6j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rvr3HPZuRISpW947T8PNgLVOK16EVwsQEDWYG7mhByvYFr5ZfLQiRNTtXZPRlMXqEJ1k8lPttWpM9dOlWJS1DSZM+rRQvXI9WIt01UsytDBhaZjxi80T9OUHC/1N9l77WWVZWF9AXeKuVTY93Io60fmt30lHlzGRX4B7H9VzyGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54bbaca0ee5so1931773e0c.3
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 00:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032684; x=1761637484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUqrwvpQXr6guDNLgU9SzLdOYzQwJ1tizkmuIUMCSQg=;
        b=E8H1WtXoJSK0gmoZzSVJfio9M2XCDOev3DC7XVbpUHvDFsqut3NKNvUGqXZ5vFoCyg
         GIL11Kp+YvbuJAbt7ZZL8mvxqJkft4mp+rjf3zuA9EjkM/w2vJdlBTKQ7b0hIHTm/dlv
         vfnukX94s5L/43UM4tUXF6Tb+TWMnJqQusIbxVgOXeTNfeCORwb0VvpUGWpB0PMKqjg7
         uSB8wnqEfwwX4HcNROvCMMSzQjG9lTeEOZmkXqFhY+ZFJKbN3VQ6Dy5g4u54gqowp9wD
         Pv8yyUYIL/qpYM32k6MeKQIxzMj4sA4bLTqdG00GpvyLE01Swzxr5J+IHXX9TwQrqW44
         +gMg==
X-Gm-Message-State: AOJu0YyFMl04ocYR19njtYZagvB8wDpnU5tsNMJ7HUt1jyBfMz8y3wZo
	YLudevJgBSH2eD4LA42TuVZ+VtrPHrzA5wgk6WWRCJhvaAtVCrkISFWUI23IcjVv
X-Gm-Gg: ASbGnctWixsnyn24Vtl4xSMu4jjMc6Nev9MJ5bgPYoIcZ3pOV4aA7oF2WDNPw8F0HHe
	yQ74Tma5+kNjQ4rkFMqXOs0toHiT4Gu2C8JQjLzSzBLaAVXPrm0EkMyHiuH4qJJccTxkYMxMa35
	V9OwaaC24NrEy37pAVzisvB9HxskF8KVgymeH4eJpiaR+pLuYmJ7o8pDw5u/YY2rkfLb43v1BXK
	1JWbPHGWQmXR7gGfEe4cBS6j2M+APYyufawTQlY0y9iKwVN9ipDx9P9xqvB3PcMMdp3FSFHHpUq
	Bz3HwoqWHkmJ4pzfmdIt/1P9Qa0jhN6zIhSczb1yNJNw/i18ObbEytolo6mtlwVPLcpEI7ur6dw
	edDdUqNBH9zyb70VqY3fPzzQ+gjj+AZybPn+qvxcHkew8IgRwGgMjNozwQB+kNOuVsXuSRPOGD5
	HomzG1280oAGUnNZoLL2tfczB1K/z7PZJum/Z6Xw==
X-Google-Smtp-Source: AGHT+IGLBTcnk53d1DA5uFSUZ9kQsuU39mDG8GuUA2hW6n0v+94emzJH/3DOxGnBfS1JdRzkt6Yh3w==
X-Received: by 2002:a05:6122:169c:b0:549:f04a:6ea8 with SMTP id 71dfb90a1353d-5564ef63d3cmr4323694e0c.9.1761032684158;
        Tue, 21 Oct 2025 00:44:44 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55661f9b0b8sm3088032e0c.8.2025.10.21.00.44.43
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:44:43 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5d967b66fedso1622476137.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 00:44:43 -0700 (PDT)
X-Received: by 2002:a05:6102:3a0c:b0:5d5:f6ae:38c8 with SMTP id
 ada2fe7eead31-5d7dd6f48c9mr4413144137.39.1761032683037; Tue, 21 Oct 2025
 00:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
 <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com> <89a20c14-dd0f-22ae-d998-da511a94664a@linux.intel.com>
In-Reply-To: <89a20c14-dd0f-22ae-d998-da511a94664a@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 09:44:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUbseFEY8AGOxm2T8W-64qT9OSvfmvu+hyTJUT+WE2cVw@mail.gmail.com>
X-Gm-Features: AS18NWDBDpeYkZ3rgn5Tqmr6-1KFQr01Xx8X4chOVFcJI4f9-bqI7eigteiWqww
Message-ID: <CAMuHMdUbseFEY8AGOxm2T8W-64qT9OSvfmvu+hyTJUT+WE2cVw@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows safer
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Mon, 20 Oct 2025 at 18:20, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Mon, 20 Oct 2025, Geert Uytterhoeven wrote:
> > On Fri, 10 Oct 2025 at 16:42, Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > Here's a series for Geert to test if this fixes the improper coalesci=
ng
> > > of resources as was experienced with the pci_add_resource() change (I
> > > know the breaking change was pulled before 6.18 main PR but I'd want =
to
> > > retry it later once the known issues have been addressed). The expect=
ed
> > > result is there'll be two adjacent host bridge resources in the
> > > resource tree as the different name should disallow coalescing them
> > > together, and therefore BAR0 has a window into which it belongs to.
> > >
> > > Generic info for the series:
> > >
> > > PCI host bridge windows were coalesced in place into one of the struc=
ts
> > > on the resources list. The host bridge window coalescing code does no=
t
> > > know who holds references and still needs the struct resource it's
> > > coalescing from/to so it is safer to perform coalescing into entirely
> > > a new struct resource instead and leave the old resource addresses as
> > > they were.
> > >
> > > The checks when coalescing is allowed are also made stricter so that
> > > only resources that have identical the metadata can be coalesced.
> > >
> > > As a bonus, there's also a bit of framework to easily create kunit
> > > tests for resource tree functions (beyond just resource_coalesce()).
> > >
> > > Ilpo J=C3=A4rvinen (3):
> > >   PCI: Refactor host bridge window coalescing loop to use prev
> > >   PCI: Do not coalesce host bridge resource structs in place
> > >   resource, kunit: add test case for resource_coalesce()
> >
> > Thanks for your series!
> >
> > I have applied this on top of commit 06b77d5647a4d6a7 ("PCI:
> > Mark resources IORESOURCE_UNSET when outside bridge windows"), and
> > gave it a a try on Koelsch (R-Car M2-W).
>
> So the pci_bus_add_resource() patch to rcar_pci_probe() was not included?
> No coalescing would be attempted without that change.

Sorry, I didn't realize you wanted that (and anything else) to be
included, too.  Please tell me the exact base I should use for testing,
and I will give it another run.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

