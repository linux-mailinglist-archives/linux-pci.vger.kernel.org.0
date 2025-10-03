Return-Path: <linux-pci+bounces-37517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B35BB63F1
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 10:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE3A421411
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 08:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D033F26E17D;
	Fri,  3 Oct 2025 08:36:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121EA26CE05
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759480585; cv=none; b=gi7mhfCZuqOT4a5WF3GEt0Al5F1PFrO4aRb60YUgy1v0ghsh82CWMoQ56b2lyLP5q0FKP6Bb41/EHlyMUnXcRuK0Dw94lGfxC5koNeCDxImkLPY5eqXv06HZcAfoR+e4pOOJ9RCnCzGOg6QRC06y99acKyNZPx8hDI+R6hUJaWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759480585; c=relaxed/simple;
	bh=cfrd57YYyjYqKaR3ugNAJPp3zEcBDHea8JquZ04nE+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxirRLealYL8pdhYiMdQ7hHJ2kSKaUtqixQ9xlJO32MpPL2KmOkEcbOvOiqqokIkHxrf5Lex1Jdc3V6HB8VceOrEQrDP9hiDGkU61tnrVSOl/7pwq7zlihl+8SHD0QRBmoQazIpuIC7Yo37uZSoFijkZL5KUXcD31tlvL7sxRrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-51d14932f27so962652137.2
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 01:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759480582; x=1760085382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJm5961noSyZ6vNZVTMrFP3FcaKw0C9GlbxQjCPQ5pQ=;
        b=cPAqGuxAhuCngU3GWneZAgbBdOTAI/v/6DM7Iz8r2kxLSA1RipJgWZ1UocBBaiQXCC
         UNpxG6wV4X16mPdElQe9+RGCeEb4hEdrvhtYqD8bRRW4LFMuLBvAIlXHH7zF5ZA4F1DS
         t7zqg03B5qXXAclHZoPd5//HqKyewCJjZX2FIdHxhQNo5lTkW0A5FmWVd8sTnnpw06bc
         tmrgxwS7ZaAuFEqaL3kig8WgHiPHmrEysLonyq/HURd1tE5qrtDXglZsY+vZSu6jMdIW
         RPIN0b1UO/dD4tkD8HXRY/JBC3TXowljYJIfE6+CRN1rWSgOwlGCtOnVBNbxzkfza8IR
         K+1Q==
X-Gm-Message-State: AOJu0YwIngZAfhEK0nO1P0ly66qHZtmjuC0/b3yKOHFUr/1iCG+EstOa
	AT9ju1dsT7HHdj4Ipqchm2A+wuv7XOH0lSmmdsLFGAfm4pkB4hTg9IgkJEZRFxlg7PA=
X-Gm-Gg: ASbGncuDB6plDxq5AszlS70dSWNgNAyXrlHUxw9v6OHkew216ctI881iQb0K9FLeVbL
	3J0Jp774MZBMuDjZ/WhX7WgAHSHW7qKRLd55Dz1dBdPIpbXo3x/AHq7BS+I26+TqAcoqw3hL8+0
	10s5/z+aE3qMxN1I8lTXLOMGweI0wHsoP/aIe8Q2Pqh8vJpedkuhmUqOMmNQsXlPSmNyrwfZ22h
	CVlccKqcpKLlh5TpKyh0QqQaHZ4cZN927hEh3fa5h7JPZLWvyZITSx+Ng8cA0GEvRbHlwFTyMpV
	PWRrBi1TjmzL1siyYRbfRTuggQk4478TK9lY9BBKgTmwK9ZyQWhPneOjPUZzk3+qFL23ZRy0fCx
	FTuoJ6vCKmNPeNuDSRpt0z+cc8ppTaDz7OQ7ZQz7OIikhar10WTQXL+TtGc2UrDGELvwHAmFYa/
	FhzqXD18H1VmgA
X-Google-Smtp-Source: AGHT+IGzg7jFtMJrR9LtD8VMfOnK9YWRp9WYhtFm1DSL4BV4vc8f/Qk/ThREUDfOFZ+LJYl0SzREjQ==
X-Received: by 2002:a05:6102:4414:b0:5d3:feea:65d9 with SMTP id ada2fe7eead31-5d41d12f6admr649725137.27.1759480581412;
        Fri, 03 Oct 2025 01:36:21 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4ede9e8sm967300241.15.2025.10.03.01.36.20
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 01:36:20 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54bc2d1feb2so537362e0c.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 01:36:20 -0700 (PDT)
X-Received: by 2002:a05:6122:2086:b0:543:53df:f3c with SMTP id
 71dfb90a1353d-5524e847342mr608221e0c.2.1759480580498; Fri, 03 Oct 2025
 01:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
 <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com> <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com>
 <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com> <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com>
 <c17c5ec1-132d-3588-2a4d-a0e6639cf748@linux.intel.com> <CAMuHMdVbyKdzbptA10F82Oj=6ktxnGAk4fz7dBLVdxALb8-WWg@mail.gmail.com>
 <2d5e9b78-8a90-3035-ff42-e881d61f4b7c@linux.intel.com> <CAMuHMdU_tPmQd=9dCzNs+dEt3fHNsYpYPFnT6QZk546o-J-y9g@mail.gmail.com>
 <7640a03e-dfea-db9c-80f5-d80fa2c505b7@linux.intel.com>
In-Reply-To: <7640a03e-dfea-db9c-80f5-d80fa2c505b7@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 3 Oct 2025 10:36:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVgCHU80mRm1Vwo6GFgNAtQcf50yHBz_oAk4TrtjcMpYg@mail.gmail.com>
X-Gm-Features: AS18NWAC3J-HExGr3j225sYFW_aJRHvXtE81_GRaX8pDUz3iz3twZt5eft3t9W0
Message-ID: <CAMuHMdVgCHU80mRm1Vwo6GFgNAtQcf50yHBz_oAk4TrtjcMpYg@mail.gmail.com>
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

On Thu, 2 Oct 2025 at 18:59, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Thu, 2 Oct 2025, Geert Uytterhoeven wrote:
> > On Thu, 2 Oct 2025 at 16:54, Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > On Wed, 1 Oct 2025 at 15:06, Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > On Tue, 30 Sept 2025 at 18:32, Ilpo J=C3=A4rvinen
> > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > > > > > > On Fri, 26 Sept 2025 at 04:40, Ilpo J=C3=A4rvinen
> > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > PNP resources are checked for conflicts with the other re=
source in the
> > > > > > > > > system by quirk_system_pci_resources() that walks through=
 all PCI
> > > > > > > > > resources. quirk_system_pci_resources() correctly filters=
 out resource
> > > > > > > > > with IORESOURCE_UNSET.
> > > > > > > > >
> > > > > > > > > Resources that do not reside within their bridge window, =
however, are
> > > > > > > > > not properly initialized with IORESOURCE_UNSET resulting =
in bogus
> > > > > > > > > conflicts detected in quirk_system_pci_resources():
> > > > > > > > >
> > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64b=
it pref]
> > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64b=
it pref]: contains BAR 2 for 7 VFs
> > > > > > > > > ...
> > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff 64=
bit pref]
> > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff 6=
4bit pref]: contains BAR 2 for 31 VFs
> > > > > > > > > ...
> > > > > > > > > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because =
it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because =
it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> > > > > > > > > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] because =
it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] because =
it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] because =
it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disabled]=
 because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit =
pref]
> > > > > > > > > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] because =
it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] because =
it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] because =
it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] because =
it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > >
> > > > > > > > > Mark resources that are not contained within their bridge=
 window with
> > > > > > > > > IORESOURCE_UNSET in __pci_read_base() which resolves the =
false
> > > > > > > > > positives for the overlap check in quirk_system_pci_resou=
rces().
> > > > > > > > >
> > > > > > > > > Fixes: f7834c092c42 ("PNP: Don't check for overlaps with =
unassigned PCI BARs")
> > > > > > > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.in=
tel.com>
> > > > > > > >
> > > > > > > > Thanks for your patch, which is now commit 06b77d5647a4d6a7=
 ("PCI:
> > > > > > > > Mark resources IORESOURCE_UNSET when outside bridge windows=
") in
> > > > > > > > linux-next/master next-20250929 pci/next
> > > > > >
> > > > > > > > This replaces the actual resources by their sizes in the bo=
ot log on
> > > > > > > > e.g. on R-Car M2-W:
> > > > > > > >
> > > > > > > >      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090=
000 ranges:
> > > > > > > >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x0=
0ee08ffff -> 0x00ee080000
> > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 000=
0:00
> > > > > > > >      pci_bus 0000:00: root bus resource [bus 00]
> > > > > > > >      pci_bus 0000:00: root bus resource [mem 0xee080000-0xe=
e08ffff]
> > > > > > > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 c=
onventional PCI endpoint
> > > > > > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> > > > > > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pre=
f]
> > > > > > >
> > > > > > > What is going to be the parent of these resources? They don't=
 seem to fall
> > > > > > > under the root bus resource above in which case the output ch=
ange is
> > > > > > > intentional so they don't appear as if address range would be=
 "okay".
> > > > > >
> > > > > > >From /proc/iomem:
> > > > > >
> > > > > >     ee080000-ee08ffff : pci@ee090000
> > > > > >       ee080000-ee080fff : 0000:00:01.0
> > > > > >         ee080000-ee080fff : ohci_hcd
> > > > > >       ee081000-ee0810ff : 0000:00:02.0
> > > > > >         ee081000-ee0810ff : ehci_hcd
> > > > > >     ee090000-ee090bff : ee090000.pci pci@ee090000
> > > > >
> > > > > Okay, so this seem to appear in the resource tree but not among t=
he root
> > > > > bus resources.
> > > > >
> > > > > >     ee0c0000-ee0cffff : pci@ee0d0000
> > > > > >       ee0c0000-ee0c0fff : 0001:01:01.0
> > > > > >         ee0c0000-ee0c0fff : ohci_hcd
> > > > > >       ee0c1000-ee0c10ff : 0001:01:02.0
> > > > > >         ee0c1000-ee0c10ff : ehci_hcd
> > > > > >
> > > > > > > When IORESOURCE_UNSET is set in a resource, %pR does not prin=
t the start
> > > > > > > and end addresses.
> > > > > >
> > > > > > Yeah, that's how I found this commit, without bisecting ;-)
> > > > > >
> > > > > > > >     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > > > > > > >     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> > > > > > > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 c=
onventional PCI endpoint
> > > > > > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
> > > > > > > >     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> > > > > > >
> > > > > > > For this resource, it's very much intentional. It's a zero-ba=
sed BAR which
> > > > > > > was left without IORESOURCE_UNSET prior to my patch leading t=
o others part
> > > > > > > of the kernel to think that resource range valid and in use (=
in your
> > > > > > > case it's so small it wouldn't collide with anything but it w=
asn't
> > > > > > > properly set up resource, nonetheless).
> > > > > > >
> > > > > > > >      pci 0000:00:01.0: supports D1 D2
> > > > > > > >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> > > > > > > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 c=
onventional PCI endpoint
> > > > > > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
> > > > > > > >     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> > > > > > >
> > > > > > > And this as well is very much intentional.
> > > > > > >
> > > > > > > >      pci 0000:00:02.0: supports D1 D2
> > > > > > > >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> > > > > > > >      PCI: bus0: Fast back to back transfers disabled
> > > > > > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: a=
ssigned
> > > > > > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: a=
ssigned
> > > > > > > >      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff=
]
> > > > > > > >
> > > > > > > > Is that intentional?
> > > > > > >
> > > > > > > There's also that pci_dbg() in the patch which would show the=
 original
> > > > > > > addresses (print the resource before setting IORESOURCE_UNSET=
) but to see
> > > > > > > it one would need to enable it with dyndbg=3D... Bjorn was th=
inking of
> > > > > > > making that pci_info() though so it would appear always.
> > > > > > >
> > > > > > > Was this the entire PCI related diff? I don't see those 0000:=
00:00.0 BARs
> > > > > > > getting assigned anywhere.
> > > > > >
> > > > > > The above log is almost complete (lacked enabling the device af=
terwards).
> > > > > >
> > > > > > AFAIU, the BARs come from the reg and ranges properties in the
> > > > > > PCI controller nodes;
> > > > > > https://elixir.bootlin.com/linux/v6.17/source/arch/arm/boot/dts=
/renesas/r8a7791.dtsi#L1562
> > > > >
> > > > > Thanks, although I had already found this line by grep. I was jus=
t
> > > > > expecting the address appear among root bus resources too.
> > > > >
> > > > > Curiously enough, pci_register_host_bridge() seems to try to add =
some
> > > > > resource from that list into bus and it's what prints those "root=
 bus
> > > > > resource" lines and ee090000 is not among the printed lines despi=
te
> > > > > appearing in /proc/iomem. As is, the resource tree and PCI bus vi=
ew on the
> > > > > resources seems to be in disagreement and I'm not sure what to ma=
ke of it.
> > > > >
> > > > > But before considering going into that direction or figuring out =
why this
> > > > > ee090000 resource does not appear among root bus resources, could=
 you
> > > > > check if the attached patch changes behavior for the resource whi=
ch are
> > > > > non-zero based?
> > > >
> > > > This patch has no impact on dmesg, lspci output, or /proc/iomem
> > > > for pci-rcar-gen2.
> > >
> > > It would have been too easy... :-(
> > >
> > > I'm sorry I don't really know these platform well and I'm currently t=
rying
> > > to understand what adds that ee090000 resource into the resource tree
> > > and so far I've not been very successful.
> > >
> > > Perhaps it would be easiest to print a stacktrace when the resource i=
s
> > > added but there are many possible functions. I think all of them
> > > converge in __request_resource() so I suggest adding:
> > >
> > > WARN_ON(new->start =3D=3D 0xee090000);
> > >
> > > before __request_resource() does anything.
> >
> >     Call trace:
> >      unwind_backtrace from show_stack+0x10/0x14
> >      show_stack from dump_stack_lvl+0x7c/0xb0
> >      dump_stack_lvl from __warn+0x80/0x198
> >      __warn from warn_slowpath_fmt+0xc0/0x124
> >      warn_slowpath_fmt from __request_resource+0x38/0xc8
> >      __request_resource from __request_region+0xc4/0x1e8
> >      __request_region from __devm_request_region+0x80/0xac
> >      __devm_request_region from __devm_ioremap_resource+0xcc/0x160
> >      __devm_ioremap_resource from rcar_pci_probe+0x58/0x350
> >      rcar_pci_probe from platform_probe+0x58/0x90
> >
> > I.e. the call to devm_platform_get_and_ioremap_resource() in
> > drivers/pci/controller/pci-rcar-gen2.c:rcar_pci_probe().
>
> Thanks, the patch below might help BAR0 (but I'm not sure if it's the
> correct solution due to being so unfamiliar with these kind of platforms
> and how they're initialized).

Thanks, that has the following impact on dmesg:

     pci-rcar-gen2 ee090000.pci: PCI: revision 11
     pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
     pci_bus 0000:00: root bus resource [bus 00]
    -pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
    +pci_bus 0000:00: root bus resource [mem 0xee080000-0xee090bff]
     pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
PCI endpoint
    -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial
claim (no window)
    -pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
    -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
initial claim (no window)
    +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
     pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
     pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
PCI endpoint
    -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
claim (no window)
     pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
     pci 0000:00:01.0: supports D1 D2
     pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
     pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
PCI endpoint
    -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
claim (no window)
     pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
     pci 0000:00:02.0: supports D1 D2
     pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
     PCI: bus0: Fast back to back transfers disabled
     pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
     pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
    -pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
    +pci_bus 0000:00: resource 4 [mem 0xee080000-0xee090bff]
     pci-rcar-gen2 ee0d0000.pci: adding to PM domain always-on
     PM: genpd_add_device: Add ee0d0000.pci to always-on
     pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 ranges:
    @@ -414,26 +416,22 @@ PM: =3D=3D=3D=3D always-on/ee0d0000.pci: start
     pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
     pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
     pci_bus 0001:01: root bus resource [bus 01]
    -pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cffff]
    +pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0d0bff]
     pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conventional
PCI endpoint
    -pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]: no initial
claim (no window)
    -pci 0001:01:00.0: BAR 0 [mem size 0x00000400]
    -pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
initial claim (no window)
    +pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
     pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
     pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310 conventional
PCI endpoint
    -pci 0001:01:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
claim (no window)
     pci 0001:01:01.0: BAR 0 [mem size 0x00001000]
     pci 0001:01:01.0: supports D1 D2
     pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
     pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
PCI endpoint
    -pci 0001:01:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
claim (no window)
     pci 0001:01:02.0: BAR 0 [mem size 0x00000100]
     pci 0001:01:02.0: supports D1 D2
     pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
     PCI: bus1: Fast back to back transfers disabled
     pci 0001:01:01.0: BAR 0 [mem 0xee0c0000-0xee0c0fff]: assigned
     pci 0001:01:02.0: BAR 0 [mem 0xee0c1000-0xee0c10ff]: assigned
    -pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0cffff]
    +pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0d0bff]
     rcar-pcie fe000000.pcie: adding to PM domain always-on
     PM: genpd_add_device: Add fe000000.pcie to always-on
     rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:

and on /proc/iomem (I used "diff -w" to reduce clutter):

     ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec700000
     ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec720000
     ec740000-ec7401ff : ec500000.sound audmapp
    -ee080000-ee08ffff : pci@ee090000
    -  ee080000-ee080fff : 0000:00:01.0
         ee080000-ee080fff : ohci_hcd
    -  ee081000-ee0810ff : 0000:00:02.0
         ee081000-ee0810ff : ehci_hcd
     ee090000-ee090bff : ee090000.pci pci@ee090000
    -ee0c0000-ee0cffff : pci@ee0d0000
    -  ee0c0000-ee0c0fff : 0001:01:01.0
         ee0c0000-ee0c0fff : ohci_hcd
    -  ee0c1000-ee0c10ff : 0001:01:02.0
         ee0c1000-ee0c10ff : ehci_hcd
     ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000
     ee100000-ee100327 : ee100000.mmc mmc@ee100000

Removing the pci@ee0x0000 and 000x:0x:0x.0 entries doesn't look
right to me? Or am I missing something?

> If this works, we'll also have to decide what to do with the BAR1 (it
> didn't appear in your (partial?) /proc/iomem quote so I'm left unsure how
> to approach it).

That is indeed not visible in /proc/iomem.

I tried the following (whitespace-damaged):

--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -179,6 +179,7 @@ static void rcar_pci_setup(struct rcar_pci *priv)
        unsigned long window_size;
        unsigned long window_addr;
        unsigned long window_pci;
+       struct resource res;
        u32 val;

        entry =3D resource_list_first_type(&bridge->dma_ranges, IORESOURCE_=
MEM);
@@ -191,6 +192,8 @@ static void rcar_pci_setup(struct rcar_pci *priv)
                window_pci =3D entry->res->start - entry->offset;
                window_size =3D resource_size(entry->res);
        }
+       resource_set_range(&res, window_addr, window_size);
+       pci_add_resource(&bridge->windows, &res);

        pm_runtime_enable(dev);
        pm_runtime_get_sync(dev);

and only got:

     pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
     pci_bus 0000:00: root bus resource [bus 00]
     pci_bus 0000:00: root bus resource [mem 0xee080000-0xee090bff]
    +pci_bus 0000:00: busn_res: can not insert [bus 00-7fffffff] under
domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
    +pci_bus 0000:00: root bus resource [mem size 0x40000000 64bit
pref window disabled]
     pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
PCI endpoint
     pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
     pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
    @@ -417,6 +419,8 @@ pci-rcar-gen2 ee0d0000.pci: PCI: revisio
     pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
     pci_bus 0001:01: root bus resource [bus 01]
     pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0d0bff]
    +pci_bus 0001:01: busn_res: can not insert [bus 01-7fffffff] under
domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
    +pci_bus 0001:01: root bus resource [mem size 0x40000000 64bit
pref window disabled]
     pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conventional
PCI endpoint
     pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
     pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]

but no impact on /proc/iomem.

> I also noticed that || COMPILE_TEST is made ineffective for this driver b=
y
> the depends on ARM on the other line but it built just fine on x86 after
> changing the depends on to:
>
> depends on (ARCH_RENESAS && ARM) || COMPILE_TEST

Thanks, that is a relic from the past, when the driver failed to build
on other architectures. I have submitted a fix.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

