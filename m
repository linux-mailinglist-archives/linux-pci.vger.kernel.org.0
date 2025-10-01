Return-Path: <linux-pci+bounces-37347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20753BB0A63
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 16:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED6616AC4D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF603019D1;
	Wed,  1 Oct 2025 14:08:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170B2EF653
	for <linux-pci@vger.kernel.org>; Wed,  1 Oct 2025 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327737; cv=none; b=EiJz+ABEaOh3jUNESosfNNghDmSHcNf6iPZD2NTEKSHhGPmiMK6KeyPjKKvlQXZlz02ylexlPYxvlbmSQtNT/jI3dljM0+p6wepEtvhInqKB6BcWpLbt0GqkVG8u53yJU6kI9Mun87M9PA60drgvqfA0qS4frVpy6cCPQPHNYtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327737; c=relaxed/simple;
	bh=aVjm7nsSk3MpK0Ybz2S8XwhrZGlGiGMKP0ozCtx1Fug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTYrd6nZYUIwBS6ufIW9ybZqV06P1mo9VPrCS394H0+q17tKUBqykJRQ5D2/GT4KKZROCeRmOelYgQYknUIIw3bc5j5HB/n2op97pX0zI2u2vXSy0Eo3wGSUrHg3LEd/Xg3bNSzECP2LkD2u5jqk8S7OvPwNMHXY+gklsLCeOLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9000129f2bcso4879131241.2
        for <linux-pci@vger.kernel.org>; Wed, 01 Oct 2025 07:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327734; x=1759932534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xz5PdUboJ1NmOVuSbpHG255Mw2uRB3+8MjK6aZSUD/Q=;
        b=TdppI8O8k7OM6pnMDi5EbWNJKNiGHBl/uvJFkef4F9tEPFeEa9vmIwZXRtF6lpPzbl
         SekVkOwjrE95V1E3nXmHUAcJ2utxj/ZMb0xAuqm+1Vlk8DJKiX1JVLSYLKQZnwp/01Cu
         7jTFE3j3eR7XFPf4RECql56irQkZ4MEuyaeV/BIH9Gco41eycWdAs9u8OFZKHuf7Ed9+
         SLgn9rEY/rCm5M69h1SrA4nhJ2bhNg0LKB7Ufof8ThxTwcUki1GGFgyDwe4st2t6vBSN
         szkLqzp/zMP/yqkhR1t5+IxfF8jEJ1dpxw9pecsB0dhfRnoVE8cGG0MNVzH/4Hacsc3+
         eDFg==
X-Gm-Message-State: AOJu0YynfT5l9XSM2sxmbOLCS1OXwoPgU5Oj81OmwJyFh7PrYlV7f+/x
	RBAnYaAI85DTOMkMnB6O0VzOORjLm3rxLbC1V/M7/j8WUX3e+WUuibzNpRkXZAS5
X-Gm-Gg: ASbGncv8J9/AHXpaUio9zDKUC0GJ8Bzm5KC6ZobTJj1GYd6FoY+6fvKa8z1261FV+Df
	jdhY558T/VSbN2R4QmVKGGsLfnN8I7hJZSjXrSDaJZwsLgjhPHkpcJrW0MYEeJBCVVLT+axsfiW
	ZCzp5p4uZGjIQLR0A5gLw2HXt73qEPCjPXuSTCQ/ILYs2DohCkmfUrm9J+jb5AyROV0aYYXL3sS
	dFc1r+PszCBJAhMf/raKaqihZ2o69dZ5R+JnpdupdhRHtEg+nwgPUv7jEQQwQoKjPbLuJsmGvBY
	7D1XUD4Y3VYngnWQCtfdCCDzO8jlcLKFG2c2Stuu9BffFuSh+K5qACy1l9zam8qKszdVD2LizZs
	UMWeHkeT/a/tckOgzwsf17pQNjuOVSdBk1PniLMdhurPqaHPRM1l0YC1B7cwtmMqvrn4ToYtDY1
	7R8L57NnH1
X-Google-Smtp-Source: AGHT+IHepzTSLeQ/G5CINyhMT4bMrUo4zcsUSWPM3B7uy32D/J8Hl7LcBpcszpb/BsmryyDDNgDApQ==
X-Received: by 2002:a05:6122:1824:b0:54c:3fe6:6281 with SMTP id 71dfb90a1353d-5522d3460abmr1427914e0c.6.1759327734120;
        Wed, 01 Oct 2025 07:08:54 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54beddbb84bsm3678483e0c.21.2025.10.01.07.08.52
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 07:08:52 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5d28f9b4c8cso2118995137.2
        for <linux-pci@vger.kernel.org>; Wed, 01 Oct 2025 07:08:52 -0700 (PDT)
X-Received: by 2002:a05:6102:1629:b0:520:dbc0:6ac4 with SMTP id
 ada2fe7eead31-5d3fe4e4d01mr1726266137.2.1759327732025; Wed, 01 Oct 2025
 07:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
 <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com> <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com>
 <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com> <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com>
 <c17c5ec1-132d-3588-2a4d-a0e6639cf748@linux.intel.com>
In-Reply-To: <c17c5ec1-132d-3588-2a4d-a0e6639cf748@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Oct 2025 16:08:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVbyKdzbptA10F82Oj=6ktxnGAk4fz7dBLVdxALb8-WWg@mail.gmail.com>
X-Gm-Features: AS18NWDSe69_JEeKgA8QttkxMcLIXMbSn-oNZuqPwYgxLktm1Z3rr1fy86KWDUc
Message-ID: <CAMuHMdVbyKdzbptA10F82Oj=6ktxnGAk4fz7dBLVdxALb8-WWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set IORESOURCE_UNSET
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Wed, 1 Oct 2025 at 15:06, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > On Tue, 30 Sept 2025 at 18:32, Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > > On Fri, 26 Sept 2025 at 04:40, Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > PNP resources are checked for conflicts with the other resource i=
n the
> > > > > system by quirk_system_pci_resources() that walks through all PCI
> > > > > resources. quirk_system_pci_resources() correctly filters out res=
ource
> > > > > with IORESOURCE_UNSET.
> > > > >
> > > > > Resources that do not reside within their bridge window, however,=
 are
> > > > > not properly initialized with IORESOURCE_UNSET resulting in bogus
> > > > > conflicts detected in quirk_system_pci_resources():
> > > > >
> > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
> > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]=
: contains BAR 2 for 7 VFs
> > > > > ...
> > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff 64bit pref=
]
> > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff 64bit pre=
f]: contains BAR 2 for 31 VFs
> > > > > ...
> > > > > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overl=
aps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disabled] because=
 it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] because it overl=
aps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > >
> > > > > Mark resources that are not contained within their bridge window =
with
> > > > > IORESOURCE_UNSET in __pci_read_base() which resolves the false
> > > > > positives for the overlap check in quirk_system_pci_resources().
> > > > >
> > > > > Fixes: f7834c092c42 ("PNP: Don't check for overlaps with unassign=
ed PCI BARs")
> > > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > >
> > > > Thanks for your patch, which is now commit 06b77d5647a4d6a7 ("PCI:
> > > > Mark resources IORESOURCE_UNSET when outside bridge windows") in
> > > > linux-next/master next-20250929 pci/next
> >
> > > > This replaces the actual resources by their sizes in the boot log o=
n
> > > > e.g. on R-Car M2-W:
> > > >
> > > >      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 rang=
es:
> > > >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08fff=
f -> 0x00ee080000
> > > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> > > >      pci_bus 0000:00: root bus resource [bus 00]
> > > >      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
> > > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventio=
nal PCI endpoint
> > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
> > >
> > > What is going to be the parent of these resources? They don't seem to=
 fall
> > > under the root bus resource above in which case the output change is
> > > intentional so they don't appear as if address range would be "okay".
> >
> > >From /proc/iomem:
> >
> >     ee080000-ee08ffff : pci@ee090000
> >       ee080000-ee080fff : 0000:00:01.0
> >         ee080000-ee080fff : ohci_hcd
> >       ee081000-ee0810ff : 0000:00:02.0
> >         ee081000-ee0810ff : ehci_hcd
> >     ee090000-ee090bff : ee090000.pci pci@ee090000
>
> Okay, so this seem to appear in the resource tree but not among the root
> bus resources.
>
> >     ee0c0000-ee0cffff : pci@ee0d0000
> >       ee0c0000-ee0c0fff : 0001:01:01.0
> >         ee0c0000-ee0c0fff : ohci_hcd
> >       ee0c1000-ee0c10ff : 0001:01:02.0
> >         ee0c1000-ee0c10ff : ehci_hcd
> >
> > > When IORESOURCE_UNSET is set in a resource, %pR does not print the st=
art
> > > and end addresses.
> >
> > Yeah, that's how I found this commit, without bisecting ;-)
> >
> > > >     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > > >     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> > > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventio=
nal PCI endpoint
> > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
> > > >     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> > >
> > > For this resource, it's very much intentional. It's a zero-based BAR =
which
> > > was left without IORESOURCE_UNSET prior to my patch leading to others=
 part
> > > of the kernel to think that resource range valid and in use (in your
> > > case it's so small it wouldn't collide with anything but it wasn't
> > > properly set up resource, nonetheless).
> > >
> > > >      pci 0000:00:01.0: supports D1 D2
> > > >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> > > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventio=
nal PCI endpoint
> > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
> > > >     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> > >
> > > And this as well is very much intentional.
> > >
> > > >      pci 0000:00:02.0: supports D1 D2
> > > >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> > > >      PCI: bus0: Fast back to back transfers disabled
> > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
> > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
> > > >      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
> > > >
> > > > Is that intentional?
> > >
> > > There's also that pci_dbg() in the patch which would show the origina=
l
> > > addresses (print the resource before setting IORESOURCE_UNSET) but to=
 see
> > > it one would need to enable it with dyndbg=3D... Bjorn was thinking o=
f
> > > making that pci_info() though so it would appear always.
> > >
> > > Was this the entire PCI related diff? I don't see those 0000:00:00.0 =
BARs
> > > getting assigned anywhere.
> >
> > The above log is almost complete (lacked enabling the device afterwards=
).
> >
> > AFAIU, the BARs come from the reg and ranges properties in the
> > PCI controller nodes;
> > https://elixir.bootlin.com/linux/v6.17/source/arch/arm/boot/dts/renesas=
/r8a7791.dtsi#L1562
>
> Thanks, although I had already found this line by grep. I was just
> expecting the address appear among root bus resources too.
>
> Curiously enough, pci_register_host_bridge() seems to try to add some
> resource from that list into bus and it's what prints those "root bus
> resource" lines and ee090000 is not among the printed lines despite
> appearing in /proc/iomem. As is, the resource tree and PCI bus view on th=
e
> resources seems to be in disagreement and I'm not sure what to make of it=
.
>
> But before considering going into that direction or figuring out why this
> ee090000 resource does not appear among root bus resources, could you
> check if the attached patch changes behavior for the resource which are
> non-zero based?

This patch has no impact on dmesg, lspci output, or /proc/iomem
for pci-rcar-gen2.

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

