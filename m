Return-Path: <linux-pci+bounces-37436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ECABB437A
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 16:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8845A19C7192
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DB5634EC;
	Thu,  2 Oct 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jx9Aa44+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9414A01;
	Thu,  2 Oct 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759416861; cv=none; b=jKLVN//BJk9KTCnuNXF3EXFMIJ6U47i/b6pVXMohA+G9f8RUU44kf2fxwwD1W8pDQM3OYBbqzSYv/8F6P4XtHbohvCZ6LJ+NOdet4W67lwq1HK3rQiJgy8a3l/x+t6SdNdSFD3mPbxPLIV4MgXMGvgrwKlCjgI035sfniUf4GKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759416861; c=relaxed/simple;
	bh=6rLn1aZBCCQeZO05QrGDkxTGMMTUPAhFYfX7Y5GteVo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VhoOCNMr0OC0AgtAKgZrvX4U5rHWTIbKv+98InjNTBAW4TjhLyA0zEMnkTNDU89Gg31mS26gDBEqxi6irgYepf7kks64o9LrSxM5Fich6OAd+4dLE7dj9/8YYlYGKksDTGk6InDypIjrTSoxHVqrnTtETog2NEuHNfnlECGz0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jx9Aa44+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759416859; x=1790952859;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6rLn1aZBCCQeZO05QrGDkxTGMMTUPAhFYfX7Y5GteVo=;
  b=Jx9Aa44+E66BHeDuyyMziPZphg77OQ0dJBMDDcrs9ap7Y1lYjdrx0BDa
   Iex13wFKK2h9qvv64B/O2lQdC17mF665FhpZGi+kkTMSgDenG1NNLlfD7
   x/c101NWXBbRVi8CfNSJwRr4Xo6AP//K2Q9bvA03h9rAfV3kh8sRTLEDE
   RljfPz7gDYz52Pca15rnJwwLO7skvYh8adroR3irNBCESyaZyzax5hwaJ
   V5Cc6nhKJK2uk6zBHdSbCrQB03vmeOLezSMslzgQGvZ4Zp6MdrcoN2haD
   0m+Snrabg4nsyDOxQ2yTWFOgoZrx31D8mDj1LHKDP/BWW+31QJjHQrgAy
   Q==;
X-CSE-ConnectionGUID: g6wlG2F+Q1iJ6JwEuLm8Tw==
X-CSE-MsgGUID: zyBpOlIRRfOXovkAisCtNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="60740067"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="60740067"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 07:54:17 -0700
X-CSE-ConnectionGUID: qkx929+7RY64TKgRJ4EUgw==
X-CSE-MsgGUID: HOrkj3FtSDqSRQbl6gabuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="178332386"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 07:54:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 2 Oct 2025 17:54:10 +0300 (EEST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set
 IORESOURCE_UNSET
In-Reply-To: <CAMuHMdVbyKdzbptA10F82Oj=6ktxnGAk4fz7dBLVdxALb8-WWg@mail.gmail.com>
Message-ID: <2d5e9b78-8a90-3035-ff42-e881d61f4b7c@linux.intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com> <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com> <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com> <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com>
 <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com> <c17c5ec1-132d-3588-2a4d-a0e6639cf748@linux.intel.com> <CAMuHMdVbyKdzbptA10F82Oj=6ktxnGAk4fz7dBLVdxALb8-WWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1265333908-1759416850=:947"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1265333908-1759416850=:947
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> On Wed, 1 Oct 2025 at 15:06, Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > On Tue, 30 Sept 2025 at 18:32, Ilpo J=C3=A4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > > > On Fri, 26 Sept 2025 at 04:40, Ilpo J=C3=A4rvinen
> > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > PNP resources are checked for conflicts with the other resource=
 in the
> > > > > > system by quirk_system_pci_resources() that walks through all P=
CI
> > > > > > resources. quirk_system_pci_resources() correctly filters out r=
esource
> > > > > > with IORESOURCE_UNSET.
> > > > > >
> > > > > > Resources that do not reside within their bridge window, howeve=
r, are
> > > > > > not properly initialized with IORESOURCE_UNSET resulting in bog=
us
> > > > > > conflicts detected in quirk_system_pci_resources():
> > > > > >
> > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pre=
f]
> > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pre=
f]: contains BAR 2 for 7 VFs
> > > > > > ...
> > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff 64bit pr=
ef]
> > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff 64bit p=
ref]: contains BAR 2 for 31 VFs
> > > > > > ...
> > > > > > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because it ove=
rlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it ove=
rlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> > > > > > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] because it ove=
rlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] because it ove=
rlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] because it ove=
rlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disabled] becau=
se it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] because it ove=
rlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] because it ove=
rlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] because it ove=
rlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] because it ove=
rlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > >
> > > > > > Mark resources that are not contained within their bridge windo=
w with
> > > > > > IORESOURCE_UNSET in __pci_read_base() which resolves the false
> > > > > > positives for the overlap check in quirk_system_pci_resources()=
=2E
> > > > > >
> > > > > > Fixes: f7834c092c42 ("PNP: Don't check for overlaps with unassi=
gned PCI BARs")
> > > > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.co=
m>
> > > > >
> > > > > Thanks for your patch, which is now commit 06b77d5647a4d6a7 ("PCI=
:
> > > > > Mark resources IORESOURCE_UNSET when outside bridge windows") in
> > > > > linux-next/master next-20250929 pci/next
> > >
> > > > > This replaces the actual resources by their sizes in the boot log=
 on
> > > > > e.g. on R-Car M2-W:
> > > > >
> > > > >      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ra=
nges:
> > > > >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08f=
fff -> 0x00ee080000
> > > > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > > > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> > > > >      pci_bus 0000:00: root bus resource [bus 00]
> > > > >      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08fff=
f]
> > > > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 convent=
ional PCI endpoint
> > > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> > > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
> > > >
> > > > What is going to be the parent of these resources? They don't seem =
to fall
> > > > under the root bus resource above in which case the output change i=
s
> > > > intentional so they don't appear as if address range would be "okay=
".
> > >
> > > >From /proc/iomem:
> > >
> > >     ee080000-ee08ffff : pci@ee090000
> > >       ee080000-ee080fff : 0000:00:01.0
> > >         ee080000-ee080fff : ohci_hcd
> > >       ee081000-ee0810ff : 0000:00:02.0
> > >         ee081000-ee0810ff : ehci_hcd
> > >     ee090000-ee090bff : ee090000.pci pci@ee090000
> >
> > Okay, so this seem to appear in the resource tree but not among the roo=
t
> > bus resources.
> >
> > >     ee0c0000-ee0cffff : pci@ee0d0000
> > >       ee0c0000-ee0c0fff : 0001:01:01.0
> > >         ee0c0000-ee0c0fff : ohci_hcd
> > >       ee0c1000-ee0c10ff : 0001:01:02.0
> > >         ee0c1000-ee0c10ff : ehci_hcd
> > >
> > > > When IORESOURCE_UNSET is set in a resource, %pR does not print the =
start
> > > > and end addresses.
> > >
> > > Yeah, that's how I found this commit, without bisecting ;-)
> > >
> > > > >     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > > > >     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> > > > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 convent=
ional PCI endpoint
> > > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
> > > > >     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> > > >
> > > > For this resource, it's very much intentional. It's a zero-based BA=
R which
> > > > was left without IORESOURCE_UNSET prior to my patch leading to othe=
rs part
> > > > of the kernel to think that resource range valid and in use (in you=
r
> > > > case it's so small it wouldn't collide with anything but it wasn't
> > > > properly set up resource, nonetheless).
> > > >
> > > > >      pci 0000:00:01.0: supports D1 D2
> > > > >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> > > > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 convent=
ional PCI endpoint
> > > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
> > > > >     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> > > >
> > > > And this as well is very much intentional.
> > > >
> > > > >      pci 0000:00:02.0: supports D1 D2
> > > > >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> > > > >      PCI: bus0: Fast back to back transfers disabled
> > > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigne=
d
> > > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigne=
d
> > > > >      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
> > > > >
> > > > > Is that intentional?
> > > >
> > > > There's also that pci_dbg() in the patch which would show the origi=
nal
> > > > addresses (print the resource before setting IORESOURCE_UNSET) but =
to see
> > > > it one would need to enable it with dyndbg=3D... Bjorn was thinking=
 of
> > > > making that pci_info() though so it would appear always.
> > > >
> > > > Was this the entire PCI related diff? I don't see those 0000:00:00.=
0 BARs
> > > > getting assigned anywhere.
> > >
> > > The above log is almost complete (lacked enabling the device afterwar=
ds).
> > >
> > > AFAIU, the BARs come from the reg and ranges properties in the
> > > PCI controller nodes;
> > > https://elixir.bootlin.com/linux/v6.17/source/arch/arm/boot/dts/renes=
as/r8a7791.dtsi#L1562
> >
> > Thanks, although I had already found this line by grep. I was just
> > expecting the address appear among root bus resources too.
> >
> > Curiously enough, pci_register_host_bridge() seems to try to add some
> > resource from that list into bus and it's what prints those "root bus
> > resource" lines and ee090000 is not among the printed lines despite
> > appearing in /proc/iomem. As is, the resource tree and PCI bus view on =
the
> > resources seems to be in disagreement and I'm not sure what to make of =
it.
> >
> > But before considering going into that direction or figuring out why th=
is
> > ee090000 resource does not appear among root bus resources, could you
> > check if the attached patch changes behavior for the resource which are
> > non-zero based?
>=20
> This patch has no impact on dmesg, lspci output, or /proc/iomem
> for pci-rcar-gen2.

It would have been too easy... :-(

I'm sorry I don't really know these platform well and I'm currently trying=
=20
to understand what adds that ee090000 resource into the resource tree
and so far I've not been very successful.

Perhaps it would be easiest to print a stacktrace when the resource is=20
added but there are many possible functions. I think all of them=20
converge in __request_resource() so I suggest adding:

WARN_ON(new->start =3D=3D 0xee090000);

before __request_resource() does anything.


--=20
 i.

--8323328-1265333908-1759416850=:947--

