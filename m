Return-Path: <linux-pci+bounces-37681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51837BC2418
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 19:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7AF19A118E
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFC12E7BA3;
	Tue,  7 Oct 2025 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BA9T7jCA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFC2E8B9F;
	Tue,  7 Oct 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858252; cv=none; b=DU0pEUEcYASnHYviIjXE3EkpOWZaupcA1ccymsZa3GZWaDnjIJs+mmcu5hIiRqDOsdVL9yJQmiXd/yo36+coLDHHl0GB2ZB0fyOJJy8pBD7uVgGttVW3sDaHRQK7AmJwEtpVnssPct3P5qLkchL7Zu44qQ4RZxePIYo0D/9VCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858252; c=relaxed/simple;
	bh=e5/bV+DqoNnJPV7TEyHQ/AgrPrgPzWdkyV7fki8uwPA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YXACF2192n4inyoJsTSGssEcWsgQmiJAn128srqhhE8pjyG6EG8ZQYm6wgC9JRywbUNseeNAh3+cPkhMJC1IhXSUMklWbOXehiXgFwe08w0BnggyrExi6tuMPSbJq7E1wDXydvOW4AzhOgC1dUIPUUaJFlwbvGwU0lrL7uhfzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BA9T7jCA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759858246; x=1791394246;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=e5/bV+DqoNnJPV7TEyHQ/AgrPrgPzWdkyV7fki8uwPA=;
  b=BA9T7jCA4HCogwXt0rTGFuJvfjNA3m4t3gdH5MpVnkdEThnG4PQU+RGQ
   TOIRXwDDn7e/7I3UKgCCWvVIgVgZUm57TwRu1rY8rSHEGnVnE86ipEnxn
   ULKUcPe3pQQNPVOBAt74XD9f920WhVTq00onOSY/iRahteeDBfKu70NLw
   gduqPFv+OFZx/cfMO9djXfZYTr499/PRfMCXiv0uDV3GI/RtkDXvZnaHu
   N2GEql6v47cceO+U1djEjpvNIYynVg+3HhRkHEiIfgafKHD4VIdnrAJYW
   5tz9VG8aRK6nXBZERwLPPaK0gL6PO4/uTyLAFLTZpmKIxSIoJ7kZ1UQSj
   w==;
X-CSE-ConnectionGUID: 11Yh4DkESoaK8Qsc83ql7A==
X-CSE-MsgGUID: Qx3nHGsNS9+GACZsIgV01g==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="62091937"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="62091937"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 10:30:45 -0700
X-CSE-ConnectionGUID: NaPfoE24TNe/qXTWw7iGLg==
X-CSE-MsgGUID: NQl4RpeQQAew2kIlO5U2Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184485216"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.20])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 10:30:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Oct 2025 20:30:38 +0300 (EEST)
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
    Kai-Heng Feng <kaihengf@nvidia.com>
cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set
 IORESOURCE_UNSET
In-Reply-To: <CAMuHMdUrM+WJm2JAPuLmUjA0wWpipdqTfW6mu7cQdAHEyCAwdw@mail.gmail.com>
Message-ID: <cadef017-c330-888b-a092-04d0b42ff686@linux.intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com> <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com> <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com> <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com>
 <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com> <c17c5ec1-132d-3588-2a4d-a0e6639cf748@linux.intel.com> <CAMuHMdVbyKdzbptA10F82Oj=6ktxnGAk4fz7dBLVdxALb8-WWg@mail.gmail.com> <2d5e9b78-8a90-3035-ff42-e881d61f4b7c@linux.intel.com>
 <CAMuHMdU_tPmQd=9dCzNs+dEt3fHNsYpYPFnT6QZk546o-J-y9g@mail.gmail.com> <7640a03e-dfea-db9c-80f5-d80fa2c505b7@linux.intel.com> <CAMuHMdVgCHU80mRm1Vwo6GFgNAtQcf50yHBz_oAk4TrtjcMpYg@mail.gmail.com> <8b46093f-82bc-1c25-5607-ee40923b51af@linux.intel.com>
 <CAMuHMdUjhq2ZLFyMYv9KYRW8brsvXMH5xb5NW8shsHJmx7w2QQ@mail.gmail.com> <bd1810d7-3e37-b599-5105-02902e6edf33@linux.intel.com> <CAMuHMdUrM+WJm2JAPuLmUjA0wWpipdqTfW6mu7cQdAHEyCAwdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1309060479-1759759541=:9961"
Content-ID: <0d481bd7-270b-eeea-3b77-75db097aabbd@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1309060479-1759759541=:9961
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <a9a2435e-aec2-05b5-599e-f3eb3c8c0649@linux.intel.com>

+ Kai-Heng

On Mon, 6 Oct 2025, Geert Uytterhoeven wrote:
> On Mon, 6 Oct 2025 at 14:37, Ilpo J=E4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Mon, 6 Oct 2025, Geert Uytterhoeven wrote:
> > > On Fri, 3 Oct 2025 at 16:58, Ilpo J=E4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > On Fri, 3 Oct 2025, Geert Uytterhoeven wrote:
> > > > > On Thu, 2 Oct 2025 at 18:59, Ilpo J=E4rvinen
> > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > On Thu, 2 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > > On Thu, 2 Oct 2025 at 16:54, Ilpo J=E4rvinen
> > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > > > > On Wed, 1 Oct 2025 at 15:06, Ilpo J=E4rvinen
> > > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > > > > > > On Tue, 30 Sept 2025 at 18:32, Ilpo J=E4rvinen
> > > > > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > > > > On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > > > > > > > > > > > On Fri, 26 Sept 2025 at 04:40, Ilpo J=E4rvinen
> > > > > > > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > > > > > > PNP resources are checked for conflicts with th=
e other resource in the
> > > > > > > > > > > > > > system by quirk_system_pci_resources() that wal=
ks through all PCI
> > > > > > > > > > > > > > resources. quirk_system_pci_resources() correct=
ly filters out resource
> > > > > > > > > > > > > > with IORESOURCE_UNSET.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Resources that do not reside within their bridg=
e window, however, are
> > > > > > > > > > > > > > not properly initialized with IORESOURCE_UNSET =
resulting in bogus
> > > > > > > > > > > > > > conflicts detected in quirk_system_pci_resource=
s():
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1f=
ffffff 64bit pref]
> > > > > > > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdf=
ffffff 64bit pref]: contains BAR 2 for 7 VFs
> > > > > > > > > > > > > > ...
> > > > > > > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1f=
fffffff 64bit pref]
> > > > > > > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3d=
ffffffff 64bit pref]: contains BAR 2 for 31 VFs
> > > > > > > > > > > > > > ...
> > > > > > > > > > > > > > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff=
] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit=
 pref]
> > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff=
] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit p=
ref]
> > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff=
] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit=
 pref]
> > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff=
] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit=
 pref]
> > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff=
] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit=
 pref]
> > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff=
 disabled] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dfffff=
fff 64bit pref]
> > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff=
] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit=
 pref]
> > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff=
] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit=
 pref]
> > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff=
] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit=
 pref]
> > > > > > > > > > > > > > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff=
] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit=
 pref]
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Mark resources that are not contained within th=
eir bridge window with
> > > > > > > > > > > > > > IORESOURCE_UNSET in __pci_read_base() which res=
olves the false
> > > > > > > > > > > > > > positives for the overlap check in quirk_system=
_pci_resources().
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Fixes: f7834c092c42 ("PNP: Don't check for over=
laps with unassigned PCI BARs")
> > > > > > > > > > > > > > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@l=
inux.intel.com>
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thanks for your patch, which is now commit 06b77d=
5647a4d6a7 ("PCI:
> > > > > > > > > > > > > Mark resources IORESOURCE_UNSET when outside brid=
ge windows") in
> > > > > > > > > > > > > linux-next/master next-20250929 pci/next
> > > > > > > > > > >
> > > > > > > > > > > > > This replaces the actual resources by their sizes=
 in the boot log on
> > > > > > > > > > > > > e.g. on R-Car M2-W:
> > > > > > > > > > > > >
> > > > > > > > > > > > >      pci-rcar-gen2 ee090000.pci: host bridge /soc=
/pci@ee090000 ranges:
> > > > > > > > > > > > >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee0=
80000..0x00ee08ffff -> 0x00ee080000
> > > > > > > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > > > > > > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI host bridge =
to bus 0000:00
> > > > > > > > > > > > >      pci_bus 0000:00: root bus resource [bus 00]
> > > > > > > > > > > > >      pci_bus 0000:00: root bus resource [mem 0xee=
080000-0xee08ffff]
> > > > > > > > > > > > >      pci 0000:00:00.0: [1033:0000] type 00 class =
0x060000 conventional PCI endpoint
> > > > > > > > > > > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee=
090bff]
> > > > > > > > > > > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7f=
ffffff pref]
> > > > > > > > > > > >
> > > > > > > > > > > > What is going to be the parent of these resources? =
They don't seem to fall
> > > > > > > > > > > > under the root bus resource above in which case the=
 output change is
> > > > > > > > > > > > intentional so they don't appear as if address rang=
e would be "okay".
> > > > > > > > > > >
> > > > > > > > > > > >From /proc/iomem:
> > > > > > > > > > >
> > > > > > > > > > >     ee080000-ee08ffff : pci@ee090000
> > > > > > > > > > >       ee080000-ee080fff : 0000:00:01.0
> > > > > > > > > > >         ee080000-ee080fff : ohci_hcd
> > > > > > > > > > >       ee081000-ee0810ff : 0000:00:02.0
> > > > > > > > > > >         ee081000-ee0810ff : ehci_hcd
> > > > > > > > > > >     ee090000-ee090bff : ee090000.pci pci@ee090000
> > > > > > > > > >
> > > > > > > > > > Okay, so this seem to appear in the resource tree but n=
ot among the root
> > > > > > > > > > bus resources.
> > > > > > > > > >
> > > > > > > > > > >     ee0c0000-ee0cffff : pci@ee0d0000
> > > > > > > > > > >       ee0c0000-ee0c0fff : 0001:01:01.0
> > > > > > > > > > >         ee0c0000-ee0c0fff : ohci_hcd
> > > > > > > > > > >       ee0c1000-ee0c10ff : 0001:01:02.0
> > > > > > > > > > >         ee0c1000-ee0c10ff : ehci_hcd
> > > > > > > > > > >
> > > > > > > > > > > > When IORESOURCE_UNSET is set in a resource, %pR doe=
s not print the start
> > > > > > > > > > > > and end addresses.
> > > > > > > > > > >
> > > > > > > > > > > Yeah, that's how I found this commit, without bisecti=
ng ;-)
> > > > > > > > > > >
> > > > > > > > > > > > >     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400=
]
> > > > > > > > > > > > >     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000=
 pref]
> > > > > > > > > > > > >      pci 0000:00:01.0: [1033:0035] type 00 class =
0x0c0310 conventional PCI endpoint
> > > > > > > > > > > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00=
000fff]
> > > > > > > > > > > > >     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000=
]
> > > > > > > > > > > >
> > > > > > > > > > > > For this resource, it's very much intentional. It's=
 a zero-based BAR which
> > > > > > > > > > > > was left without IORESOURCE_UNSET prior to my patch=
 leading to others part
> > > > > > > > > > > > of the kernel to think that resource range valid an=
d in use (in your
> > > > > > > > > > > > case it's so small it wouldn't collide with anythin=
g but it wasn't
> > > > > > > > > > > > properly set up resource, nonetheless).
> > > > > > > > > > > >
> > > > > > > > > > > > >      pci 0000:00:01.0: supports D1 D2
> > > > > > > > > > > > >      pci 0000:00:01.0: PME# supported from D0 D1 =
D2 D3hot
> > > > > > > > > > > > >      pci 0000:00:02.0: [1033:00e0] type 00 class =
0x0c0320 conventional PCI endpoint
> > > > > > > > > > > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x00=
0000ff]
> > > > > > > > > > > > >     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100=
]
> > > > > > > > > > > >
> > > > > > > > > > > > And this as well is very much intentional.
> > > > > > > > > > > >
> > > > > > > > > > > > >      pci 0000:00:02.0: supports D1 D2
> > > > > > > > > > > > >      pci 0000:00:02.0: PME# supported from D0 D1 =
D2 D3hot
> > > > > > > > > > > > >      PCI: bus0: Fast back to back transfers disab=
led
> > > > > > > > > > > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee=
080fff]: assigned
> > > > > > > > > > > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee=
0810ff]: assigned
> > > > > > > > > > > > >      pci_bus 0000:00: resource 4 [mem 0xee080000-=
0xee08ffff]
> > > > > > > > > > > > >
> > > > > > > > > > > > > Is that intentional?
> > > > > > > > > > > >
> > > > > > > > > > > > There's also that pci_dbg() in the patch which woul=
d show the original
> > > > > > > > > > > > addresses (print the resource before setting IORESO=
URCE_UNSET) but to see
> > > > > > > > > > > > it one would need to enable it with dyndbg=3D... Bj=
orn was thinking of
> > > > > > > > > > > > making that pci_info() though so it would appear al=
ways.
> > > > > > > > > > > >
> > > > > > > > > > > > Was this the entire PCI related diff? I don't see t=
hose 0000:00:00.0 BARs
> > > > > > > > > > > > getting assigned anywhere.
> > > > > > > > > > >
> > > > > > > > > > > The above log is almost complete (lacked enabling the=
 device afterwards).
> > > > > > > > > > >
> > > > > > > > > > > AFAIU, the BARs come from the reg and ranges properti=
es in the
> > > > > > > > > > > PCI controller nodes;
> > > > > > > > > > > https://elixir.bootlin.com/linux/v6.17/source/arch/ar=
m/boot/dts/renesas/r8a7791.dtsi#L1562
> > > > > > > > > >
> > > > > > > > > > Thanks, although I had already found this line by grep.=
 I was just
> > > > > > > > > > expecting the address appear among root bus resources t=
oo.
> > > > > > > > > >
> > > > > > > > > > Curiously enough, pci_register_host_bridge() seems to t=
ry to add some
> > > > > > > > > > resource from that list into bus and it's what prints t=
hose "root bus
> > > > > > > > > > resource" lines and ee090000 is not among the printed l=
ines despite
> > > > > > > > > > appearing in /proc/iomem. As is, the resource tree and =
PCI bus view on the
> > > > > > > > > > resources seems to be in disagreement and I'm not sure =
what to make of it.
> > > > > > > > > >
> > > > > > > > > > But before considering going into that direction or fig=
uring out why this
> > > > > > > > > > ee090000 resource does not appear among root bus resour=
ces, could you
> > > > > > > > > > check if the attached patch changes behavior for the re=
source which are
> > > > > > > > > > non-zero based?
> > > > > > > > >
> > > > > > > > > This patch has no impact on dmesg, lspci output, or /proc=
/iomem
> > > > > > > > > for pci-rcar-gen2.
> > > > > > > >
> > > > > > > > It would have been too easy... :-(
> > > > > > > >
> > > > > > > > I'm sorry I don't really know these platform well and I'm c=
urrently trying
> > > > > > > > to understand what adds that ee090000 resource into the res=
ource tree
> > > > > > > > and so far I've not been very successful.
> > > > > > > >
> > > > > > > > Perhaps it would be easiest to print a stacktrace when the =
resource is
> > > > > > > > added but there are many possible functions. I think all of=
 them
> > > > > > > > converge in __request_resource() so I suggest adding:
> > > > > > > >
> > > > > > > > WARN_ON(new->start =3D=3D 0xee090000);
> > > > > > > >
> > > > > > > > before __request_resource() does anything.
> > > > > > >
> > > > > > >     Call trace:
> > > > > > >      unwind_backtrace from show_stack+0x10/0x14
> > > > > > >      show_stack from dump_stack_lvl+0x7c/0xb0
> > > > > > >      dump_stack_lvl from __warn+0x80/0x198
> > > > > > >      __warn from warn_slowpath_fmt+0xc0/0x124
> > > > > > >      warn_slowpath_fmt from __request_resource+0x38/0xc8
> > > > > > >      __request_resource from __request_region+0xc4/0x1e8
> > > > > > >      __request_region from __devm_request_region+0x80/0xac
> > > > > > >      __devm_request_region from __devm_ioremap_resource+0xcc/=
0x160
> > > > > > >      __devm_ioremap_resource from rcar_pci_probe+0x58/0x350
> > > > > > >      rcar_pci_probe from platform_probe+0x58/0x90
> > > > > > >
> > > > > > > I.e. the call to devm_platform_get_and_ioremap_resource() in
> > > > > > > drivers/pci/controller/pci-rcar-gen2.c:rcar_pci_probe().
> > > > > >
> > > > > > Thanks, the patch below might help BAR0 (but I'm not sure if it=
's the
> > > > > > correct solution due to being so unfamiliar with these kind of =
platforms
> > > > > > and how they're initialized).
> > > > >
> > > > > Thanks, that has the following impact on dmesg:
> > > > >
> > > > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > > > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> > > > >      pci_bus 0000:00: root bus resource [bus 00]
> > > > >     -pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08fff=
f]
> > > > >     +pci_bus 0000:00: root bus resource [mem 0xee080000-0xee090bf=
f]
> > > > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 convent=
ional
> > > > > PCI endpoint
> > > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no init=
ial
> > > > > claim (no window)
> > > > >     -pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
> > > > > initial claim (no window)
> > > > >     +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> > > > >      pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> > > > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 convent=
ional
> > > > > PCI endpoint
> > > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no init=
ial
> > > > > claim (no window)
> > > > >      pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> > > > >      pci 0000:00:01.0: supports D1 D2
> > > > >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> > > > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 convent=
ional
> > > > > PCI endpoint
> > > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no init=
ial
> > > > > claim (no window)
> > > >
> > > > Did you e.g. forget to change pci_dbg() to pci_info() as these all =
went
> > > > away, I cannot see why it should disappear because of my patch?
> > > >
> > > > (No need to apologize if that was the case, just confirming if that
> > > > explains it is enough. :-))
> > >
> > > I indeed dropped that change. Adding it back...
> > >
> > > > >      pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> > > > >      pci 0000:00:02.0: supports D1 D2
> > > > >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> > > > >      PCI: bus0: Fast back to back transfers disabled
> > > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigne=
d
> > > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigne=
d
> > > >
> > > > Perhaps print here what's the parent resource of these resource.
> > >
> > > pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned (parent
> > > [mem 0xee080000-0xee08ffff])
> > > pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned (parent
> > > [mem 0xee080000-0xee08ffff])
> >
> > Were these from a kernel without the problematic commit at all or with =
the
> > problematic commit and my fix? They look like the former case. The full
> > /proc/iomem also shows all the parent resources I think.
>=20
> With commit 06b77d5647a4d6a7 ("PCI: Mark resources IORESOURCE_UNSET when
> outside bridge windows"), but without adding
> "pci_add_resource(&bridge->windows, cfg_res);" in .probe().
>=20
> > > > >     -pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
> > > > >     +pci_bus 0000:00: resource 4 [mem 0xee080000-0xee090bff]
> > > > >      pci-rcar-gen2 ee0d0000.pci: adding to PM domain always-on
> > > > >      PM: genpd_add_device: Add ee0d0000.pci to always-on
> > > > >      pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 ra=
nges:
> > > > >     @@ -414,26 +416,22 @@ PM: =3D=3D=3D=3D always-on/ee0d0000.pci=
: start
> > > > >      pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
> > > > >      pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
> > > > >      pci_bus 0001:01: root bus resource [bus 01]
> > > > >     -pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cfff=
f]
> > > > >     +pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0d0bf=
f]
> > > > >      pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 convent=
ional PCI endpoint
> > > > >     -pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]: no init=
ial claim (no window)
> > > > >     -pci 0001:01:00.0: BAR 0 [mem size 0x00000400]
> > > > >     -pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no=
 initial claim (no window)
> > > > >     +pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
> > > > >      pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
> > > > >      pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310 convent=
ional PCI endpoint
> > > > >     -pci 0001:01:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no init=
ial claim (no window)
> > > > >      pci 0001:01:01.0: BAR 0 [mem size 0x00001000]
> > > > >      pci 0001:01:01.0: supports D1 D2
> > > > >      pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
> > > > >      pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320 convent=
ional PCI endpoint
> > > > >     -pci 0001:01:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no init=
ial claim (no window)
> > > > >      pci 0001:01:02.0: BAR 0 [mem size 0x00000100]
> > > > >      pci 0001:01:02.0: supports D1 D2
> > > > >      pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
> > > > >      PCI: bus1: Fast back to back transfers disabled
> > > > >      pci 0001:01:01.0: BAR 0 [mem 0xee0c0000-0xee0c0fff]: assigne=
d
> > > > >      pci 0001:01:02.0: BAR 0 [mem 0xee0c1000-0xee0c10ff]: assigne=
d
> > > > >     -pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0cffff]
> > > > >     +pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0d0bff]
> > > > >      rcar-pcie fe000000.pcie: adding to PM domain always-on
> > > > >      PM: genpd_add_device: Add fe000000.pcie to always-on
> > > > >      rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 rang=
es:
> > > > >
> > > > > and on /proc/iomem (I used "diff -w" to reduce clutter):
> > > > >
> > > > >      ec700000-ec70ffff : ec700000.dma-controller dma-controller@e=
c700000
> > > > >      ec720000-ec72ffff : ec720000.dma-controller dma-controller@e=
c720000
> > > > >      ec740000-ec7401ff : ec500000.sound audmapp
> > > > >     -ee080000-ee08ffff : pci@ee090000
> > > >
> > > > So what did add this previous? (Maybe use the same WARN_ON() trick =
as
> > > > previously to find out.)
> > >
> > > First call:
> > >
> > >     + __request_resource from request_resource_conflict+0x24/0x3c
> > >     + request_resource_conflict from devm_request_resource+0x48/0x9c
> > >     + devm_request_resource from devm_request_pci_bus_resources+0x5c/=
0x70
> > >     + devm_request_pci_bus_resources from devm_of_pci_bridge_init+0x7=
c/0x1c0
> > >     + devm_of_pci_bridge_init from devm_pci_alloc_host_bridge+0x44/0x=
6c
> > >     + devm_pci_alloc_host_bridge from rcar_pci_probe+0x34/0x384
> > >     + rcar_pci_probe from platform_probe+0x58/0x90
> >
> > Thanks. So this is the call of interest, the rest are just the childs o=
f
> > it with the same address.
> >
> > I'm looking devm_of_pci_get_host_bridge_resources(), it seems to read
> > "ranges" property but not "reg" at all.
> >
> > I wonder if devm_of_pci_get_host_bridge_resources() should also loop
> > through "reg" addresses and add those to host resources which are outsi=
de
> > of the "ranges"? Or if there should be a "range" that covers all what's
> > in "reg" to get them added into host bridge resources? That would seem =
the
> > generic solution instead of trying to do this in rcar_pci_probe().
> >
> > (Perhaps these are stupid questions, please excuse my lack of knowledge
> > about OF things.)
> >
> > While looking at another issue report, I also notice of_pci_prop_ranges=
()
> > assumes there are only bridge windows or BARs, but not both (not sure i=
f
> > this relates to anything, just an observation while reading these code
> > paths).
>=20
> We still have Rob in CC...

While we wait, can you simply try to make the "ranges" large enough to fit=
=20
the BAR0 too?

I think it will results in making the larger "ranges" entry the parent of
ee090000-ee090bff : ee090000.pci pci@ee090000 entry in the resource tree
which would also avoid the coalescing issue.

Again, I'm not entirely sure if that would be an acceptable solution.

> > > Second call:
> > >
> > >     + __request_resource from allocate_resource+0x1b8/0x1d4
> > >     + allocate_resource from pci_bus_alloc_from_region+0x1e0/0x220
> > >     + pci_bus_alloc_from_region from pci_bus_alloc_resource+0x84/0xb8
> > >     + pci_bus_alloc_resource from _pci_assign_resource+0x78/0x150
> > >     + _pci_assign_resource from pci_assign_resource+0x10c/0x310
> > >     + pci_assign_resource from assign_requested_resources_sorted+0x78=
/0xac
> > >     + assign_requested_resources_sorted from
> > > __assign_resources_sorted+0x74/0x5c4
> > >     + __assign_resources_sorted from __pci_bus_assign_resources+0x50/=
0x1f0
> > >     + __pci_bus_assign_resources from
> > > pci_assign_unassigned_root_bus_resources+0xa8/0x190
> > >     + pci_assign_unassigned_root_bus_resources from pci_host_probe+0x=
5c/0xb0
> > >     + pci_host_probe from rcar_pci_probe+0x2e0/0x384
> > >     + rcar_pci_probe from platform_probe+0x58/0x90
> > >
> > > Third call:
> > >
> > >     + __request_resource from __request_region+0xc4/0x1e8
> > >     + __request_region from __devm_request_region+0x80/0xac
> > >     + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
> > >     + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
> > >     + pci_device_probe from really_probe+0x128/0x28c
> > >
> > > Fourth call:
> > >
> > >     + __request_region from __devm_request_region+0x80/0xac
> > >     + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
> > >     + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
> > >     + pci_device_probe from really_probe+0x128/0x28c
> > >
> > > Fifth call:
> > >
> > >     + __request_region from __devm_request_region+0x80/0xac
> > >     + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
> > >     + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
> > >     + pci_device_probe from really_probe+0x128/0x28c
> > >
> > > > It might have gotten broken because the coalesed resource
> > > > ee080000-ee090bff overlaps with that other resource in the resource=
 tree.
> > > > But I don't see anything to that effect in the log so it's either s=
ilent
> > > > failure or there's much filtered from the log.
> > > >
> > > > >     -  ee080000-ee080fff : 0000:00:01.0
> > > > >          ee080000-ee080fff : ohci_hcd
> > > > >     -  ee081000-ee0810ff : 0000:00:02.0
> > > > >          ee081000-ee0810ff : ehci_hcd
> > > > >      ee090000-ee090bff : ee090000.pci pci@ee090000
> > > > >     -ee0c0000-ee0cffff : pci@ee0d0000
> > > > >     -  ee0c0000-ee0c0fff : 0001:01:01.0
> > > > >          ee0c0000-ee0c0fff : ohci_hcd
> > > > >     -  ee0c1000-ee0c10ff : 0001:01:02.0
> > > > >          ee0c1000-ee0c10ff : ehci_hcd
> > > > >      ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000
> > > > >      ee100000-ee100327 : ee100000.mmc mmc@ee100000
> > > > >
> > > > > Removing the pci@ee0x0000 and 000x:0x:0x.0 entries doesn't look
> > > > > right to me? Or am I missing something?
> > > >
> > > > I cannot understand this output, these resources seem to have been =
now
> > > > left without a parent and due to -w I don't know what's their real
> > > > indentation level.
> > >
> > > The *_hcd resources are now at the top level.
> > >
> > >      ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec700=
000
> > >      ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec720=
000
> > >      ec740000-ec7401ff : ec500000.sound audmapp
> > >     -ee080000-ee08ffff : pci@ee090000
> > >     -  ee080000-ee080fff : 0000:00:01.0
> > >     -    ee080000-ee080fff : ohci_hcd
> > >     -  ee081000-ee0810ff : 0000:00:02.0
> > >     -    ee081000-ee0810ff : ehci_hcd
> > >     +ee080000-ee080fff : ohci_hcd
> > >     +ee081000-ee0810ff : ehci_hcd
> > >      ee090000-ee090bff : ee090000.pci pci@ee090000
> > >     -ee0c0000-ee0cffff : pci@ee0d0000
> > >     -  ee0c0000-ee0c0fff : 0001:01:01.0
> > >     -    ee0c0000-ee0c0fff : ohci_hcd
> > >     -  ee0c1000-ee0c10ff : 0001:01:02.0
> > >     -    ee0c1000-ee0c10ff : ehci_hcd
> > >     +ee0c0000-ee0c0fff : ohci_hcd
> > >     +ee0c1000-ee0c10ff : ehci_hcd
> > >      ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000
> > >      ee100000-ee100327 : ee100000.mmc mmc@ee100000
> > >      ee140000-ee1400ff : ee140000.mmc mmc@ee140000
> > >
> > > I assume the others are gone because they now conflict with the *_hcd
> > > resources at the top level.
> >
> > Like you initially assumed, it is wrong (while it works as the resource=
s
> > themselves don't care that much about their parent they're under as lon=
g
> > as the resource is assigned, it's still not intended to be that way).
> >
> > It might be worth to see if the coalescing in pci_register_host_bridge(=
)
> > somehow messes these resources up either by not doing the coalesing loo=
p
> > at all or by adding:
> >
> >                 if (res->parent || next_res->parent) {
> >                         if (res->parent)
> >                                 pr_info("Has parent %pR\n", res);
> >                         if (next_res->parent)
> >                                 pr_info("Has parent %pR\n", next_res);
> >                         continue;
> >                 }
> >
> > ...into the coalescing loop in case one of them happens to have a paren=
t
> > (this is to be tested with the rcar_probe() fix).
>=20
> The above restores the missing entries in /proc/iomem.
> Changes to dmesg:
>=20
>      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
>      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff
> -> 0x00ee080000
>      pci-rcar-gen2 ee090000.pci: PCI: revision 11
>      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>     +Has parent [mem 0xee080000-0xee08ffff]
>      pci_bus 0000:00: root bus resource [bus 00]
>      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
>     +pci_bus 0000:00: root bus resource [mem 0xee090000-0xee090bff]
>      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
> PCI endpoint
>     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial
> claim (no window)
>     -pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
>     +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
>      pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
> initial claim (no window)
>      pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
>      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
> PCI endpoint
>     @@ -403,21 +397,24 @@ pci 0000:00:02.0: BAR 0 [mem size 0x0000
>      pci 0000:00:02.0: supports D1 D2
>      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
>      PCI: bus0: Fast back to back transfers disabled
>      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
>      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
>      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
>     +pci_bus 0000:00: resource 5 [mem 0xee090000-0xee090bff]
>      pci-rcar-gen2 ee0d0000.pci: adding to PM domain always-on
>      pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 ranges:
>      pci-rcar-gen2 ee0d0000.pci:      MEM 0x00ee0c0000..0x00ee0cffff
> -> 0x00ee0c0000
>      pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
>      pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
>     +Has parent [mem 0xee0c0000-0xee0cffff]

So this ended up locating another bug in the coalescing loop.

It's very dangerous to mess with resources like that as the backing=20
struct resource is shared with whatever added that resource, which is=20
different sites in this case.

I'm preparing a better approach to do the resource merge, however, I'm=20
left unsure if the clean up of everything will happen "correctly" as this=
=20
coalescing is removing resources from the resource tree which were added=20
there by something else so it's then becomes very muddy who is responsible=
=20
for releasing it in the end.

>      pci_bus 0001:01: root bus resource [bus 01]
>      pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cffff]
>     +pci_bus 0001:01: root bus resource [mem 0xee0d0000-0xee0d0bff]
>      pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conventional
> PCI endpoint
>     -pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]: no initial
> claim (no window)
>     -pci 0001:01:00.0: BAR 0 [mem size 0x00000400]
>     +pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
>      pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
> initial claim (no window)
>      pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
>      pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310 conventional
> PCI endpoint
>     @@ -431,9 +428,10 @@ pci 0001:01:02.0: BAR 0 [mem size 0x0000
>      pci 0001:01:02.0: supports D1 D2
>      pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
>      PCI: bus1: Fast back to back transfers disabled
>      pci 0001:01:01.0: BAR 0 [mem 0xee0c0000-0xee0c0fff]: assigned
>      pci 0001:01:02.0: BAR 0 [mem 0xee0c1000-0xee0c10ff]: assigned
>      pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0cffff]
>     +pci_bus 0001:01: resource 5 [mem 0xee0d0000-0xee0d0bff]
>=20
> > > > > > If this works, we'll also have to decide what to do with the BA=
R1 (it
> > > > > > didn't appear in your (partial?) /proc/iomem quote so I'm left =
unsure how
> > > > > > to approach it).
> > > > >
> > > > > That is indeed not visible in /proc/iomem.
> > > >
> > > > I meant before the commit 06b77d5647a4d6a7 ("PCI Mark resources
> > > > IORESOURCE_UNSET when outside bridge windows"), was it present?
> > >
> > > No, it was not present.
> > >
> > > > > I tried the following (whitespace-damaged):
> > > > >
> > > > > --- a/drivers/pci/controller/pci-rcar-gen2.c
> > > > > +++ b/drivers/pci/controller/pci-rcar-gen2.c
> > > > > @@ -179,6 +179,7 @@ static void rcar_pci_setup(struct rcar_pci *p=
riv)
> > > > >         unsigned long window_size;
> > > > >         unsigned long window_addr;
> > > > >         unsigned long window_pci;
> > > > > +       struct resource res;
> > > > >         u32 val;
> > > > >
> > > > >         entry =3D resource_list_first_type(&bridge->dma_ranges, I=
ORESOURCE_MEM);
> > > > > @@ -191,6 +192,8 @@ static void rcar_pci_setup(struct rcar_pci *p=
riv)
> > > > >                 window_pci =3D entry->res->start - entry->offset;
> > > > >                 window_size =3D resource_size(entry->res);
> > > > >         }
> > > > > +       resource_set_range(&res, window_addr, window_size);
> > > >
> > > > You need to set flags properly too as this now tried to insert BUS,=
 not
> > > > MEM resource (DEFINE_RES() might be the more appropriate in that ca=
se
> > > > anyway).
> > > >
> > > > However, if there's not &bridge->dma_ranges ranges entry, rcar_pci_=
setup()
> > > > seems to initialize the resource to 0x40000000-0x7fffffff and I'm n=
ot sure
> > >
> > > I guess the not &bridge->dma_ranges case dates back to the time the
> > > DTS didn't have dma-ranges yet.  However, upon closer look, the DTS
> > > still doesn't have dma_ranges, thus always using the default.
> > >
> > > > how it's supposed to work if there's more than one of these devices=
 as per
> > > > the log above.
> > >
> > > Upon closer look, this is not a resource of the device, but an inboun=
d
> > > memory region.  Hence there is no issue if multiple devices use the
> > > same region.
> > >
> > > >
> > > > > +       pci_add_resource(&bridge->windows, &res);
> > > >
> > > > What would be the backing resource in the resource tree for this? I=
'm not
> > > > sure if pci_add_resource() is going to result in adding one into th=
e
> > > > resource tree.
> > >
> > > Likewise, it should not appear in /proc/ioem.
> >
> > Thanks for checking it out.
> >
> > I wonder how it would be supposed to work if PCI resource fitting logic
> > finds place for it and changes its address. I don't think it would ever
> > happen because it should never fit...
> >
> > ...But the logic still is a bit fishy if rcar2 code expects that addres=
s
> > to be fixed but doesn't flag the resource to have a fixed address.
>=20
> How can the PCI resource fitting logic change it? It is an inbound
> memory region, not a normal BAR?

I thought it can happen because it appears as BAR1, all resources from=20
BARs are eligible for the normal assignment but now that I think it more,=
=20
the underlying struct resource is going different for that BAR1 and the=20
actual dma_ranges entry.

--=20
 i.
--8323328-1309060479-1759759541=:9961--

