Return-Path: <linux-pci+bounces-37614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF827BBE28F
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 15:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5303BB9A3
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2CA2C21F9;
	Mon,  6 Oct 2025 13:17:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0B1B4247
	for <linux-pci@vger.kernel.org>; Mon,  6 Oct 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756640; cv=none; b=el5tSc+93CjlqKrptobOUBL70oCI9yZhdXxbGBtiTmnii6sJV7Sxwy6r0GfSn7FcGvgCe3AmB1c7DR6A261Gf3EZ6Zy0b7imxFnUgslSWeIieXiqdJXnnnXTs2ETxNsKTvPFCF5t5Ppy+nAFMwtySLbDocQB96HMojITmc6PJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756640; c=relaxed/simple;
	bh=KGnWqIGqIKSniA79RO3vOzqDOgzISe13r8623BSRbqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgXA+aYlmVpNM18nAfrTaVoqazguij5IP+bGHXnTuUpbael0g5N7Dtl31KQVXLdmVxfKbL3bBt2efkR5U+OYl17TxgPk2sIWhvq+TEUSOXSGqtp9KNBioSFvz0QRghAxgrSZz6/5wEfvnN+gX5V+zzMo2wir6p+WG4C0Wr5jGsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8e30a19da78so2881209241.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Oct 2025 06:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759756635; x=1760361435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/5IKalp7KoFmJQfsce+aQR+XVFAjEugjnItXqVt8U4=;
        b=aS0WH10ceOLf/yNcnOIR0vzKUz82BaaM4H8jCejmTQoptamb51T2dkpIki5YCIZrTP
         XrPZ3W/hS4lB/Deb32+1e6cxRMpOCTMdBWUTmPM8KoiB+aqilFwwRpVR3kIClRsUNCTV
         wX8ohCXibq7DH11F63t6Fs44YsCcYkNIlKnM23T5lsEWeg9+8v29ozh2SE9qYED9m1us
         0/3RhjS6XFl6Vh9yW08U/C+LE04Ab7dKnE7+3Q9YoCBcxfPUJbXIN/VujyISatj9mJs3
         C5veM4+nI8vs0Z/2OHTN0pXpZERo08Zt0s70TupFp7AqP8/+UI6uecFBSUpy/NbW/mv7
         F4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH7thFj69bqbCuaScmpeZYyQpmqRXU8gZSq0y9oFZdRLn69AgW7BVK1laWlypyrlESaKnEyLns8TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4kKrmtKJxDl/ewbuYdu38MJF8AbR0XBFhjemK/kUvmpcsphO
	Ht3/GOlaU6xCJprZJwivRSD3uBPkXH4995AkaqQ1D8LxuWUgYqELGuRntAKhKEGI
X-Gm-Gg: ASbGncsJPHp6/aOOyfrb21/1449jpXCrsd60KISpUFy8NTIsSWTlHB4B/Xab7vjXGYo
	5ZMf0K1y+GHm05IP+Ao8Z1JDgYIDg3CpdxsdLhMIomJttR7uIPaFOdBepVUaIydxaZ+4etYH1DE
	mO/f1BksGgqf7lDHTYylbrIhu8HQBkbhVXwKt1Bjj6d7sB8uosC0fjwEv76/HWYZxNz4PWg0H5s
	xGITp3exF8ayEKuNHBBMZsm5Ljdq6jIAxmfwVQtXmef+B+hoV7DAyaQgJe4OubSmcUPUyygBZe8
	QMbNuT1MMvPcrkkJ0sYBCwVrOW2DnBzTE5oUpJJns8yHBbb0N4O0AqcFO/1SQt1XU2gJUFZ/bYi
	LW5IZOkf3eH5hIZNdfjoEOEXNRIWkpTFs9QUQHXpKk68ld1gz+PwLc1HUy7ropizfsAsnQDcW97
	jB1Y85TtT9pD220CAXWvk=
X-Google-Smtp-Source: AGHT+IFwwcUalz6xJ4UXAhJELSM3DLCIGB+q5Z8TNfgil+SavV4C4guXoUtq9OtybTvyqqu7j/FO+w==
X-Received: by 2002:a05:6102:38d4:b0:5a3:5b69:b963 with SMTP id ada2fe7eead31-5d41cfc911bmr5290493137.7.1759756634532;
        Mon, 06 Oct 2025 06:17:14 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4d83c45sm2845739241.4.2025.10.06.06.17.13
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 06:17:13 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-8e30a19da78so2881175241.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Oct 2025 06:17:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLPYPACb2oaD/NvwB1wjpNOIyEG9kn/4vXCYhwkwCnrCljRTKaWjqSZLhQ7hDzwyAEechIWS8cZKg=@vger.kernel.org
X-Received: by 2002:a05:6102:5111:b0:526:db01:5fb2 with SMTP id
 ada2fe7eead31-5d41d11fb3fmr4896191137.30.1759756633093; Mon, 06 Oct 2025
 06:17:13 -0700 (PDT)
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
 <7640a03e-dfea-db9c-80f5-d80fa2c505b7@linux.intel.com> <CAMuHMdVgCHU80mRm1Vwo6GFgNAtQcf50yHBz_oAk4TrtjcMpYg@mail.gmail.com>
 <8b46093f-82bc-1c25-5607-ee40923b51af@linux.intel.com> <CAMuHMdUjhq2ZLFyMYv9KYRW8brsvXMH5xb5NW8shsHJmx7w2QQ@mail.gmail.com>
 <bd1810d7-3e37-b599-5105-02902e6edf33@linux.intel.com>
In-Reply-To: <bd1810d7-3e37-b599-5105-02902e6edf33@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Oct 2025 15:17:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUrM+WJm2JAPuLmUjA0wWpipdqTfW6mu7cQdAHEyCAwdw@mail.gmail.com>
X-Gm-Features: AS18NWBJ-yFB-FmJ5_xlpTHa6T0uLFGmSRL7T13bfyHcbmdHQMViSbqv-hVH-Wc
Message-ID: <CAMuHMdUrM+WJm2JAPuLmUjA0wWpipdqTfW6mu7cQdAHEyCAwdw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set IORESOURCE_UNSET
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Mon, 6 Oct 2025 at 14:37, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Mon, 6 Oct 2025, Geert Uytterhoeven wrote:
> > On Fri, 3 Oct 2025 at 16:58, Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > On Fri, 3 Oct 2025, Geert Uytterhoeven wrote:
> > > > On Thu, 2 Oct 2025 at 18:59, Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > On Thu, 2 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > On Thu, 2 Oct 2025 at 16:54, Ilpo J=C3=A4rvinen
> > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > > > On Wed, 1 Oct 2025 at 15:06, Ilpo J=C3=A4rvinen
> > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > > > > > On Tue, 30 Sept 2025 at 18:32, Ilpo J=C3=A4rvinen
> > > > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > > > On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > > > > > > > > > > On Fri, 26 Sept 2025 at 04:40, Ilpo J=C3=A4rvinen
> > > > > > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > > > > > PNP resources are checked for conflicts with the =
other resource in the
> > > > > > > > > > > > > system by quirk_system_pci_resources() that walks=
 through all PCI
> > > > > > > > > > > > > resources. quirk_system_pci_resources() correctly=
 filters out resource
> > > > > > > > > > > > > with IORESOURCE_UNSET.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Resources that do not reside within their bridge =
window, however, are
> > > > > > > > > > > > > not properly initialized with IORESOURCE_UNSET re=
sulting in bogus
> > > > > > > > > > > > > conflicts detected in quirk_system_pci_resources(=
):
> > > > > > > > > > > > >
> > > > > > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fff=
ffff 64bit pref]
> > > > > > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfff=
ffff 64bit pref]: contains BAR 2 for 7 VFs
> > > > > > > > > > > > > ...
> > > > > > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1fff=
fffff 64bit pref]
> > > > > > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dff=
ffffff 64bit pref]: contains BAR 2 for 31 VFs
> > > > > > > > > > > > > ...
> > > > > > > > > > > > > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] =
because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit p=
ref]
> > > > > > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] =
because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pre=
f]
> > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] =
because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit p=
ref]
> > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] =
because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit p=
ref]
> > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] =
because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit p=
ref]
> > > > > > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff d=
isabled] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dfffffff=
f 64bit pref]
> > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] =
because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit p=
ref]
> > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] =
because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit p=
ref]
> > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] =
because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit p=
ref]
> > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] =
because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit p=
ref]
> > > > > > > > > > > > >
> > > > > > > > > > > > > Mark resources that are not contained within thei=
r bridge window with
> > > > > > > > > > > > > IORESOURCE_UNSET in __pci_read_base() which resol=
ves the false
> > > > > > > > > > > > > positives for the overlap check in quirk_system_p=
ci_resources().
> > > > > > > > > > > > >
> > > > > > > > > > > > > Fixes: f7834c092c42 ("PNP: Don't check for overla=
ps with unassigned PCI BARs")
> > > > > > > > > > > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@=
linux.intel.com>
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks for your patch, which is now commit 06b77d56=
47a4d6a7 ("PCI:
> > > > > > > > > > > > Mark resources IORESOURCE_UNSET when outside bridge=
 windows") in
> > > > > > > > > > > > linux-next/master next-20250929 pci/next
> > > > > > > > > >
> > > > > > > > > > > > This replaces the actual resources by their sizes i=
n the boot log on
> > > > > > > > > > > > e.g. on R-Car M2-W:
> > > > > > > > > > > >
> > > > > > > > > > > >      pci-rcar-gen2 ee090000.pci: host bridge /soc/p=
ci@ee090000 ranges:
> > > > > > > > > > > >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080=
000..0x00ee08ffff -> 0x00ee080000
> > > > > > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > > > > > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to=
 bus 0000:00
> > > > > > > > > > > >      pci_bus 0000:00: root bus resource [bus 00]
> > > > > > > > > > > >      pci_bus 0000:00: root bus resource [mem 0xee08=
0000-0xee08ffff]
> > > > > > > > > > > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x=
060000 conventional PCI endpoint
> > > > > > > > > > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee09=
0bff]
> > > > > > > > > > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fff=
ffff pref]
> > > > > > > > > > >
> > > > > > > > > > > What is going to be the parent of these resources? Th=
ey don't seem to fall
> > > > > > > > > > > under the root bus resource above in which case the o=
utput change is
> > > > > > > > > > > intentional so they don't appear as if address range =
would be "okay".
> > > > > > > > > >
> > > > > > > > > > >From /proc/iomem:
> > > > > > > > > >
> > > > > > > > > >     ee080000-ee08ffff : pci@ee090000
> > > > > > > > > >       ee080000-ee080fff : 0000:00:01.0
> > > > > > > > > >         ee080000-ee080fff : ohci_hcd
> > > > > > > > > >       ee081000-ee0810ff : 0000:00:02.0
> > > > > > > > > >         ee081000-ee0810ff : ehci_hcd
> > > > > > > > > >     ee090000-ee090bff : ee090000.pci pci@ee090000
> > > > > > > > >
> > > > > > > > > Okay, so this seem to appear in the resource tree but not=
 among the root
> > > > > > > > > bus resources.
> > > > > > > > >
> > > > > > > > > >     ee0c0000-ee0cffff : pci@ee0d0000
> > > > > > > > > >       ee0c0000-ee0c0fff : 0001:01:01.0
> > > > > > > > > >         ee0c0000-ee0c0fff : ohci_hcd
> > > > > > > > > >       ee0c1000-ee0c10ff : 0001:01:02.0
> > > > > > > > > >         ee0c1000-ee0c10ff : ehci_hcd
> > > > > > > > > >
> > > > > > > > > > > When IORESOURCE_UNSET is set in a resource, %pR does =
not print the start
> > > > > > > > > > > and end addresses.
> > > > > > > > > >
> > > > > > > > > > Yeah, that's how I found this commit, without bisecting=
 ;-)
> > > > > > > > > >
> > > > > > > > > > > >     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > > > > > > > > > > >     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 p=
ref]
> > > > > > > > > > > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x=
0c0310 conventional PCI endpoint
> > > > > > > > > > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x0000=
0fff]
> > > > > > > > > > > >     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> > > > > > > > > > >
> > > > > > > > > > > For this resource, it's very much intentional. It's a=
 zero-based BAR which
> > > > > > > > > > > was left without IORESOURCE_UNSET prior to my patch l=
eading to others part
> > > > > > > > > > > of the kernel to think that resource range valid and =
in use (in your
> > > > > > > > > > > case it's so small it wouldn't collide with anything =
but it wasn't
> > > > > > > > > > > properly set up resource, nonetheless).
> > > > > > > > > > >
> > > > > > > > > > > >      pci 0000:00:01.0: supports D1 D2
> > > > > > > > > > > >      pci 0000:00:01.0: PME# supported from D0 D1 D2=
 D3hot
> > > > > > > > > > > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x=
0c0320 conventional PCI endpoint
> > > > > > > > > > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x0000=
00ff]
> > > > > > > > > > > >     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> > > > > > > > > > >
> > > > > > > > > > > And this as well is very much intentional.
> > > > > > > > > > >
> > > > > > > > > > > >      pci 0000:00:02.0: supports D1 D2
> > > > > > > > > > > >      pci 0000:00:02.0: PME# supported from D0 D1 D2=
 D3hot
> > > > > > > > > > > >      PCI: bus0: Fast back to back transfers disable=
d
> > > > > > > > > > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee08=
0fff]: assigned
> > > > > > > > > > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee08=
10ff]: assigned
> > > > > > > > > > > >      pci_bus 0000:00: resource 4 [mem 0xee080000-0x=
ee08ffff]
> > > > > > > > > > > >
> > > > > > > > > > > > Is that intentional?
> > > > > > > > > > >
> > > > > > > > > > > There's also that pci_dbg() in the patch which would =
show the original
> > > > > > > > > > > addresses (print the resource before setting IORESOUR=
CE_UNSET) but to see
> > > > > > > > > > > it one would need to enable it with dyndbg=3D... Bjor=
n was thinking of
> > > > > > > > > > > making that pci_info() though so it would appear alwa=
ys.
> > > > > > > > > > >
> > > > > > > > > > > Was this the entire PCI related diff? I don't see tho=
se 0000:00:00.0 BARs
> > > > > > > > > > > getting assigned anywhere.
> > > > > > > > > >
> > > > > > > > > > The above log is almost complete (lacked enabling the d=
evice afterwards).
> > > > > > > > > >
> > > > > > > > > > AFAIU, the BARs come from the reg and ranges properties=
 in the
> > > > > > > > > > PCI controller nodes;
> > > > > > > > > > https://elixir.bootlin.com/linux/v6.17/source/arch/arm/=
boot/dts/renesas/r8a7791.dtsi#L1562
> > > > > > > > >
> > > > > > > > > Thanks, although I had already found this line by grep. I=
 was just
> > > > > > > > > expecting the address appear among root bus resources too=
.
> > > > > > > > >
> > > > > > > > > Curiously enough, pci_register_host_bridge() seems to try=
 to add some
> > > > > > > > > resource from that list into bus and it's what prints tho=
se "root bus
> > > > > > > > > resource" lines and ee090000 is not among the printed lin=
es despite
> > > > > > > > > appearing in /proc/iomem. As is, the resource tree and PC=
I bus view on the
> > > > > > > > > resources seems to be in disagreement and I'm not sure wh=
at to make of it.
> > > > > > > > >
> > > > > > > > > But before considering going into that direction or figur=
ing out why this
> > > > > > > > > ee090000 resource does not appear among root bus resource=
s, could you
> > > > > > > > > check if the attached patch changes behavior for the reso=
urce which are
> > > > > > > > > non-zero based?
> > > > > > > >
> > > > > > > > This patch has no impact on dmesg, lspci output, or /proc/i=
omem
> > > > > > > > for pci-rcar-gen2.
> > > > > > >
> > > > > > > It would have been too easy... :-(
> > > > > > >
> > > > > > > I'm sorry I don't really know these platform well and I'm cur=
rently trying
> > > > > > > to understand what adds that ee090000 resource into the resou=
rce tree
> > > > > > > and so far I've not been very successful.
> > > > > > >
> > > > > > > Perhaps it would be easiest to print a stacktrace when the re=
source is
> > > > > > > added but there are many possible functions. I think all of t=
hem
> > > > > > > converge in __request_resource() so I suggest adding:
> > > > > > >
> > > > > > > WARN_ON(new->start =3D=3D 0xee090000);
> > > > > > >
> > > > > > > before __request_resource() does anything.
> > > > > >
> > > > > >     Call trace:
> > > > > >      unwind_backtrace from show_stack+0x10/0x14
> > > > > >      show_stack from dump_stack_lvl+0x7c/0xb0
> > > > > >      dump_stack_lvl from __warn+0x80/0x198
> > > > > >      __warn from warn_slowpath_fmt+0xc0/0x124
> > > > > >      warn_slowpath_fmt from __request_resource+0x38/0xc8
> > > > > >      __request_resource from __request_region+0xc4/0x1e8
> > > > > >      __request_region from __devm_request_region+0x80/0xac
> > > > > >      __devm_request_region from __devm_ioremap_resource+0xcc/0x=
160
> > > > > >      __devm_ioremap_resource from rcar_pci_probe+0x58/0x350
> > > > > >      rcar_pci_probe from platform_probe+0x58/0x90
> > > > > >
> > > > > > I.e. the call to devm_platform_get_and_ioremap_resource() in
> > > > > > drivers/pci/controller/pci-rcar-gen2.c:rcar_pci_probe().
> > > > >
> > > > > Thanks, the patch below might help BAR0 (but I'm not sure if it's=
 the
> > > > > correct solution due to being so unfamiliar with these kind of pl=
atforms
> > > > > and how they're initialized).
> > > >
> > > > Thanks, that has the following impact on dmesg:
> > > >
> > > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> > > >      pci_bus 0000:00: root bus resource [bus 00]
> > > >     -pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
> > > >     +pci_bus 0000:00: root bus resource [mem 0xee080000-0xee090bff]
> > > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventio=
nal
> > > > PCI endpoint
> > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initia=
l
> > > > claim (no window)
> > > >     -pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
> > > > initial claim (no window)
> > > >     +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> > > >      pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> > > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventio=
nal
> > > > PCI endpoint
> > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initia=
l
> > > > claim (no window)
> > > >      pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> > > >      pci 0000:00:01.0: supports D1 D2
> > > >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> > > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventio=
nal
> > > > PCI endpoint
> > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initia=
l
> > > > claim (no window)
> > >
> > > Did you e.g. forget to change pci_dbg() to pci_info() as these all we=
nt
> > > away, I cannot see why it should disappear because of my patch?
> > >
> > > (No need to apologize if that was the case, just confirming if that
> > > explains it is enough. :-))
> >
> > I indeed dropped that change. Adding it back...
> >
> > > >      pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> > > >      pci 0000:00:02.0: supports D1 D2
> > > >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> > > >      PCI: bus0: Fast back to back transfers disabled
> > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
> > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
> > >
> > > Perhaps print here what's the parent resource of these resource.
> >
> > pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned (parent
> > [mem 0xee080000-0xee08ffff])
> > pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned (parent
> > [mem 0xee080000-0xee08ffff])
>
> Were these from a kernel without the problematic commit at all or with th=
e
> problematic commit and my fix? They look like the former case. The full
> /proc/iomem also shows all the parent resources I think.

With commit 06b77d5647a4d6a7 ("PCI: Mark resources IORESOURCE_UNSET when
outside bridge windows"), but without adding
"pci_add_resource(&bridge->windows, cfg_res);" in .probe().

> > > >     -pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
> > > >     +pci_bus 0000:00: resource 4 [mem 0xee080000-0xee090bff]
> > > >      pci-rcar-gen2 ee0d0000.pci: adding to PM domain always-on
> > > >      PM: genpd_add_device: Add ee0d0000.pci to always-on
> > > >      pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 rang=
es:
> > > >     @@ -414,26 +416,22 @@ PM: =3D=3D=3D=3D always-on/ee0d0000.pci: =
start
> > > >      pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
> > > >      pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
> > > >      pci_bus 0001:01: root bus resource [bus 01]
> > > >     -pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cffff]
> > > >     +pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0d0bff]
> > > >      pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conventio=
nal PCI endpoint
> > > >     -pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]: no initia=
l claim (no window)
> > > >     -pci 0001:01:00.0: BAR 0 [mem size 0x00000400]
> > > >     -pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no i=
nitial claim (no window)
> > > >     +pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
> > > >      pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
> > > >      pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310 conventio=
nal PCI endpoint
> > > >     -pci 0001:01:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initia=
l claim (no window)
> > > >      pci 0001:01:01.0: BAR 0 [mem size 0x00001000]
> > > >      pci 0001:01:01.0: supports D1 D2
> > > >      pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
> > > >      pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320 conventio=
nal PCI endpoint
> > > >     -pci 0001:01:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initia=
l claim (no window)
> > > >      pci 0001:01:02.0: BAR 0 [mem size 0x00000100]
> > > >      pci 0001:01:02.0: supports D1 D2
> > > >      pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
> > > >      PCI: bus1: Fast back to back transfers disabled
> > > >      pci 0001:01:01.0: BAR 0 [mem 0xee0c0000-0xee0c0fff]: assigned
> > > >      pci 0001:01:02.0: BAR 0 [mem 0xee0c1000-0xee0c10ff]: assigned
> > > >     -pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0cffff]
> > > >     +pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0d0bff]
> > > >      rcar-pcie fe000000.pcie: adding to PM domain always-on
> > > >      PM: genpd_add_device: Add fe000000.pcie to always-on
> > > >      rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges=
:
> > > >
> > > > and on /proc/iomem (I used "diff -w" to reduce clutter):
> > > >
> > > >      ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec7=
00000
> > > >      ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec7=
20000
> > > >      ec740000-ec7401ff : ec500000.sound audmapp
> > > >     -ee080000-ee08ffff : pci@ee090000
> > >
> > > So what did add this previous? (Maybe use the same WARN_ON() trick as
> > > previously to find out.)
> >
> > First call:
> >
> >     + __request_resource from request_resource_conflict+0x24/0x3c
> >     + request_resource_conflict from devm_request_resource+0x48/0x9c
> >     + devm_request_resource from devm_request_pci_bus_resources+0x5c/0x=
70
> >     + devm_request_pci_bus_resources from devm_of_pci_bridge_init+0x7c/=
0x1c0
> >     + devm_of_pci_bridge_init from devm_pci_alloc_host_bridge+0x44/0x6c
> >     + devm_pci_alloc_host_bridge from rcar_pci_probe+0x34/0x384
> >     + rcar_pci_probe from platform_probe+0x58/0x90
>
> Thanks. So this is the call of interest, the rest are just the childs of
> it with the same address.
>
> I'm looking devm_of_pci_get_host_bridge_resources(), it seems to read
> "ranges" property but not "reg" at all.
>
> I wonder if devm_of_pci_get_host_bridge_resources() should also loop
> through "reg" addresses and add those to host resources which are outside
> of the "ranges"? Or if there should be a "range" that covers all what's
> in "reg" to get them added into host bridge resources? That would seem th=
e
> generic solution instead of trying to do this in rcar_pci_probe().
>
> (Perhaps these are stupid questions, please excuse my lack of knowledge
> about OF things.)
>
> While looking at another issue report, I also notice of_pci_prop_ranges()
> assumes there are only bridge windows or BARs, but not both (not sure if
> this relates to anything, just an observation while reading these code
> paths).

We still have Rob in CC...

> > Second call:
> >
> >     + __request_resource from allocate_resource+0x1b8/0x1d4
> >     + allocate_resource from pci_bus_alloc_from_region+0x1e0/0x220
> >     + pci_bus_alloc_from_region from pci_bus_alloc_resource+0x84/0xb8
> >     + pci_bus_alloc_resource from _pci_assign_resource+0x78/0x150
> >     + _pci_assign_resource from pci_assign_resource+0x10c/0x310
> >     + pci_assign_resource from assign_requested_resources_sorted+0x78/0=
xac
> >     + assign_requested_resources_sorted from
> > __assign_resources_sorted+0x74/0x5c4
> >     + __assign_resources_sorted from __pci_bus_assign_resources+0x50/0x=
1f0
> >     + __pci_bus_assign_resources from
> > pci_assign_unassigned_root_bus_resources+0xa8/0x190
> >     + pci_assign_unassigned_root_bus_resources from pci_host_probe+0x5c=
/0xb0
> >     + pci_host_probe from rcar_pci_probe+0x2e0/0x384
> >     + rcar_pci_probe from platform_probe+0x58/0x90
> >
> > Third call:
> >
> >     + __request_resource from __request_region+0xc4/0x1e8
> >     + __request_region from __devm_request_region+0x80/0xac
> >     + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
> >     + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
> >     + pci_device_probe from really_probe+0x128/0x28c
> >
> > Fourth call:
> >
> >     + __request_region from __devm_request_region+0x80/0xac
> >     + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
> >     + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
> >     + pci_device_probe from really_probe+0x128/0x28c
> >
> > Fifth call:
> >
> >     + __request_region from __devm_request_region+0x80/0xac
> >     + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
> >     + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
> >     + pci_device_probe from really_probe+0x128/0x28c
> >
> > > It might have gotten broken because the coalesed resource
> > > ee080000-ee090bff overlaps with that other resource in the resource t=
ree.
> > > But I don't see anything to that effect in the log so it's either sil=
ent
> > > failure or there's much filtered from the log.
> > >
> > > >     -  ee080000-ee080fff : 0000:00:01.0
> > > >          ee080000-ee080fff : ohci_hcd
> > > >     -  ee081000-ee0810ff : 0000:00:02.0
> > > >          ee081000-ee0810ff : ehci_hcd
> > > >      ee090000-ee090bff : ee090000.pci pci@ee090000
> > > >     -ee0c0000-ee0cffff : pci@ee0d0000
> > > >     -  ee0c0000-ee0c0fff : 0001:01:01.0
> > > >          ee0c0000-ee0c0fff : ohci_hcd
> > > >     -  ee0c1000-ee0c10ff : 0001:01:02.0
> > > >          ee0c1000-ee0c10ff : ehci_hcd
> > > >      ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000
> > > >      ee100000-ee100327 : ee100000.mmc mmc@ee100000
> > > >
> > > > Removing the pci@ee0x0000 and 000x:0x:0x.0 entries doesn't look
> > > > right to me? Or am I missing something?
> > >
> > > I cannot understand this output, these resources seem to have been no=
w
> > > left without a parent and due to -w I don't know what's their real
> > > indentation level.
> >
> > The *_hcd resources are now at the top level.
> >
> >      ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec70000=
0
> >      ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec72000=
0
> >      ec740000-ec7401ff : ec500000.sound audmapp
> >     -ee080000-ee08ffff : pci@ee090000
> >     -  ee080000-ee080fff : 0000:00:01.0
> >     -    ee080000-ee080fff : ohci_hcd
> >     -  ee081000-ee0810ff : 0000:00:02.0
> >     -    ee081000-ee0810ff : ehci_hcd
> >     +ee080000-ee080fff : ohci_hcd
> >     +ee081000-ee0810ff : ehci_hcd
> >      ee090000-ee090bff : ee090000.pci pci@ee090000
> >     -ee0c0000-ee0cffff : pci@ee0d0000
> >     -  ee0c0000-ee0c0fff : 0001:01:01.0
> >     -    ee0c0000-ee0c0fff : ohci_hcd
> >     -  ee0c1000-ee0c10ff : 0001:01:02.0
> >     -    ee0c1000-ee0c10ff : ehci_hcd
> >     +ee0c0000-ee0c0fff : ohci_hcd
> >     +ee0c1000-ee0c10ff : ehci_hcd
> >      ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000
> >      ee100000-ee100327 : ee100000.mmc mmc@ee100000
> >      ee140000-ee1400ff : ee140000.mmc mmc@ee140000
> >
> > I assume the others are gone because they now conflict with the *_hcd
> > resources at the top level.
>
> Like you initially assumed, it is wrong (while it works as the resources
> themselves don't care that much about their parent they're under as long
> as the resource is assigned, it's still not intended to be that way).
>
> It might be worth to see if the coalescing in pci_register_host_bridge()
> somehow messes these resources up either by not doing the coalesing loop
> at all or by adding:
>
>                 if (res->parent || next_res->parent) {
>                         if (res->parent)
>                                 pr_info("Has parent %pR\n", res);
>                         if (next_res->parent)
>                                 pr_info("Has parent %pR\n", next_res);
>                         continue;
>                 }
>
> ...into the coalescing loop in case one of them happens to have a parent
> (this is to be tested with the rcar_probe() fix).

The above restores the missing entries in /proc/iomem.
Changes to dmesg:

     pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
     pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff
-> 0x00ee080000
     pci-rcar-gen2 ee090000.pci: PCI: revision 11
     pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
    +Has parent [mem 0xee080000-0xee08ffff]
     pci_bus 0000:00: root bus resource [bus 00]
     pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
    +pci_bus 0000:00: root bus resource [mem 0xee090000-0xee090bff]
     pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
PCI endpoint
    -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial
claim (no window)
    -pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
    +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
     pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
initial claim (no window)
     pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
     pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
PCI endpoint
    @@ -403,21 +397,24 @@ pci 0000:00:02.0: BAR 0 [mem size 0x0000
     pci 0000:00:02.0: supports D1 D2
     pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
     PCI: bus0: Fast back to back transfers disabled
     pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
     pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
     pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
    +pci_bus 0000:00: resource 5 [mem 0xee090000-0xee090bff]
     pci-rcar-gen2 ee0d0000.pci: adding to PM domain always-on
     pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 ranges:
     pci-rcar-gen2 ee0d0000.pci:      MEM 0x00ee0c0000..0x00ee0cffff
-> 0x00ee0c0000
     pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
     pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
    +Has parent [mem 0xee0c0000-0xee0cffff]
     pci_bus 0001:01: root bus resource [bus 01]
     pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cffff]
    +pci_bus 0001:01: root bus resource [mem 0xee0d0000-0xee0d0bff]
     pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conventional
PCI endpoint
    -pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]: no initial
claim (no window)
    -pci 0001:01:00.0: BAR 0 [mem size 0x00000400]
    +pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
     pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
initial claim (no window)
     pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
     pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310 conventional
PCI endpoint
    @@ -431,9 +428,10 @@ pci 0001:01:02.0: BAR 0 [mem size 0x0000
     pci 0001:01:02.0: supports D1 D2
     pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
     PCI: bus1: Fast back to back transfers disabled
     pci 0001:01:01.0: BAR 0 [mem 0xee0c0000-0xee0c0fff]: assigned
     pci 0001:01:02.0: BAR 0 [mem 0xee0c1000-0xee0c10ff]: assigned
     pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0cffff]
    +pci_bus 0001:01: resource 5 [mem 0xee0d0000-0xee0d0bff]

> > > > > If this works, we'll also have to decide what to do with the BAR1=
 (it
> > > > > didn't appear in your (partial?) /proc/iomem quote so I'm left un=
sure how
> > > > > to approach it).
> > > >
> > > > That is indeed not visible in /proc/iomem.
> > >
> > > I meant before the commit 06b77d5647a4d6a7 ("PCI Mark resources
> > > IORESOURCE_UNSET when outside bridge windows"), was it present?
> >
> > No, it was not present.
> >
> > > > I tried the following (whitespace-damaged):
> > > >
> > > > --- a/drivers/pci/controller/pci-rcar-gen2.c
> > > > +++ b/drivers/pci/controller/pci-rcar-gen2.c
> > > > @@ -179,6 +179,7 @@ static void rcar_pci_setup(struct rcar_pci *pri=
v)
> > > >         unsigned long window_size;
> > > >         unsigned long window_addr;
> > > >         unsigned long window_pci;
> > > > +       struct resource res;
> > > >         u32 val;
> > > >
> > > >         entry =3D resource_list_first_type(&bridge->dma_ranges, IOR=
ESOURCE_MEM);
> > > > @@ -191,6 +192,8 @@ static void rcar_pci_setup(struct rcar_pci *pri=
v)
> > > >                 window_pci =3D entry->res->start - entry->offset;
> > > >                 window_size =3D resource_size(entry->res);
> > > >         }
> > > > +       resource_set_range(&res, window_addr, window_size);
> > >
> > > You need to set flags properly too as this now tried to insert BUS, n=
ot
> > > MEM resource (DEFINE_RES() might be the more appropriate in that case
> > > anyway).
> > >
> > > However, if there's not &bridge->dma_ranges ranges entry, rcar_pci_se=
tup()
> > > seems to initialize the resource to 0x40000000-0x7fffffff and I'm not=
 sure
> >
> > I guess the not &bridge->dma_ranges case dates back to the time the
> > DTS didn't have dma-ranges yet.  However, upon closer look, the DTS
> > still doesn't have dma_ranges, thus always using the default.
> >
> > > how it's supposed to work if there's more than one of these devices a=
s per
> > > the log above.
> >
> > Upon closer look, this is not a resource of the device, but an inbound
> > memory region.  Hence there is no issue if multiple devices use the
> > same region.
> >
> > >
> > > > +       pci_add_resource(&bridge->windows, &res);
> > >
> > > What would be the backing resource in the resource tree for this? I'm=
 not
> > > sure if pci_add_resource() is going to result in adding one into the
> > > resource tree.
> >
> > Likewise, it should not appear in /proc/ioem.
>
> Thanks for checking it out.
>
> I wonder how it would be supposed to work if PCI resource fitting logic
> finds place for it and changes its address. I don't think it would ever
> happen because it should never fit...
>
> ...But the logic still is a bit fishy if rcar2 code expects that address
> to be fixed but doesn't flag the resource to have a fixed address.

How can the PCI resource fitting logic change it? It is an inbound
memory region, not a normal BAR?

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

