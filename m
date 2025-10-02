Return-Path: <linux-pci+bounces-37446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20044BB49AC
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 18:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CB23C1344
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 16:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F7265CBE;
	Thu,  2 Oct 2025 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aih9vkrd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DBD1F4C87;
	Thu,  2 Oct 2025 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424361; cv=none; b=KFJVeCWtaS0HdMDbr87qixnmUZ1pSrizFf5uMIz8uqBwI4wJaMo7fRqgVvC3N7alwjj76KrvmmzQRDTMryStYMyhIgGQz3YvO2PxrNcV03I4qeZYpDafF+cizzpqR5U/8sQzaX0Idhx5C63Zo/4vhHxgwchoRRviT2dXxzpdano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424361; c=relaxed/simple;
	bh=Ck/wsMz5xBP4Ht03rZ9owz8Tr5dGzMAj27DcIuMnxhc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NtLVzpi1kBEt/Lhe8yFfgJW8/8OD8bw+61Dj0Bo/C47n2EINQyzD5Az2q3f5mVlOrxs0P3an1qb8ZrQfALu6ftfDd3TwTlPm2OiubTb+Nk0o1n2ENQHksfTk/NduwZKaG6qZR/AaWkMTTkJ3sREXC6CUnBpYudKtigE5/BdenTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aih9vkrd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759424359; x=1790960359;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ck/wsMz5xBP4Ht03rZ9owz8Tr5dGzMAj27DcIuMnxhc=;
  b=aih9vkrdh9Oa0ypKZtvSe1cGf+DFDeh4QggFDBXTGmiq9reYDPKjgZyY
   XzEZXvVsPeTs7toPX2di72fxiRdGzhhkyIpOHVxNimMNTaig6dtuPS8JL
   tXS3ZhOlnqaTBIkldG/29TAY9vhsX3lFrxGbKtr3iXuaLJbT6oYzuuTAr
   C0kIWKWAox3cCktE9GnNJSp9gvuIyzH0XPUvj7zFWQAylN+cyZ3vtmE5C
   jpHV0TlLRV7MdqJecsA84+2AI9ysWrT/hQf4Vuk1W0Qf1/nVzjEK4SSKR
   +nxrFRMSyrMcrLNbGktfM7aRi/VfR4R7KCYgw//gww6OWkZ1ffzt/pXDq
   g==;
X-CSE-ConnectionGUID: b8Fa/3z4SXWkpvJAZde30A==
X-CSE-MsgGUID: pdExtuMHSbmWO7a4fjGVEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65538542"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65538542"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 09:59:17 -0700
X-CSE-ConnectionGUID: OHV3ycYWR66HLKqZY3dYZQ==
X-CSE-MsgGUID: UbELGByJTrelbfq7LajlJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="184374084"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 09:59:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 2 Oct 2025 19:59:09 +0300 (EEST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set
 IORESOURCE_UNSET
In-Reply-To: <CAMuHMdU_tPmQd=9dCzNs+dEt3fHNsYpYPFnT6QZk546o-J-y9g@mail.gmail.com>
Message-ID: <7640a03e-dfea-db9c-80f5-d80fa2c505b7@linux.intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com> <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com> <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com> <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com>
 <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com> <c17c5ec1-132d-3588-2a4d-a0e6639cf748@linux.intel.com> <CAMuHMdVbyKdzbptA10F82Oj=6ktxnGAk4fz7dBLVdxALb8-WWg@mail.gmail.com> <2d5e9b78-8a90-3035-ff42-e881d61f4b7c@linux.intel.com>
 <CAMuHMdU_tPmQd=9dCzNs+dEt3fHNsYpYPFnT6QZk546o-J-y9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1758278253-1759424349=:947"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1758278253-1759424349=:947
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 2 Oct 2025, Geert Uytterhoeven wrote:

> Hi Ilpo,
>=20
> On Thu, 2 Oct 2025 at 16:54, Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > On Wed, 1 Oct 2025 at 15:06, Ilpo J=C3=A4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > On Tue, 30 Sept 2025 at 18:32, Ilpo J=C3=A4rvinen
> > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > > > > > On Fri, 26 Sept 2025 at 04:40, Ilpo J=C3=A4rvinen
> > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > PNP resources are checked for conflicts with the other reso=
urce in the
> > > > > > > > system by quirk_system_pci_resources() that walks through a=
ll PCI
> > > > > > > > resources. quirk_system_pci_resources() correctly filters o=
ut resource
> > > > > > > > with IORESOURCE_UNSET.
> > > > > > > >
> > > > > > > > Resources that do not reside within their bridge window, ho=
wever, are
> > > > > > > > not properly initialized with IORESOURCE_UNSET resulting in=
 bogus
> > > > > > > > conflicts detected in quirk_system_pci_resources():
> > > > > > > >
> > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit=
 pref]
> > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit=
 pref]: contains BAR 2 for 7 VFs
> > > > > > > > ...
> > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff 64bi=
t pref]
> > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff 64b=
it pref]: contains BAR 2 for 31 VFs
> > > > > > > > ...
> > > > > > > > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because it=
 overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it=
 overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> > > > > > > > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] because it=
 overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] because it=
 overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] because it=
 overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disabled] b=
ecause it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pr=
ef]
> > > > > > > > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] because it=
 overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] because it=
 overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] because it=
 overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] because it=
 overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > >
> > > > > > > > Mark resources that are not contained within their bridge w=
indow with
> > > > > > > > IORESOURCE_UNSET in __pci_read_base() which resolves the fa=
lse
> > > > > > > > positives for the overlap check in quirk_system_pci_resourc=
es().
> > > > > > > >
> > > > > > > > Fixes: f7834c092c42 ("PNP: Don't check for overlaps with un=
assigned PCI BARs")
> > > > > > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.inte=
l.com>
> > > > > > >
> > > > > > > Thanks for your patch, which is now commit 06b77d5647a4d6a7 (=
"PCI:
> > > > > > > Mark resources IORESOURCE_UNSET when outside bridge windows")=
 in
> > > > > > > linux-next/master next-20250929 pci/next
> > > > >
> > > > > > > This replaces the actual resources by their sizes in the boot=
 log on
> > > > > > > e.g. on R-Car M2-W:
> > > > > > >
> > > > > > >      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee09000=
0 ranges:
> > > > > > >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00e=
e08ffff -> 0x00ee080000
> > > > > > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > > > > > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:=
00
> > > > > > >      pci_bus 0000:00: root bus resource [bus 00]
> > > > > > >      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0=
8ffff]
> > > > > > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 con=
ventional PCI endpoint
> > > > > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> > > > > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
> > > > > >
> > > > > > What is going to be the parent of these resources? They don't s=
eem to fall
> > > > > > under the root bus resource above in which case the output chan=
ge is
> > > > > > intentional so they don't appear as if address range would be "=
okay".
> > > > >
> > > > > >From /proc/iomem:
> > > > >
> > > > >     ee080000-ee08ffff : pci@ee090000
> > > > >       ee080000-ee080fff : 0000:00:01.0
> > > > >         ee080000-ee080fff : ohci_hcd
> > > > >       ee081000-ee0810ff : 0000:00:02.0
> > > > >         ee081000-ee0810ff : ehci_hcd
> > > > >     ee090000-ee090bff : ee090000.pci pci@ee090000
> > > >
> > > > Okay, so this seem to appear in the resource tree but not among the=
 root
> > > > bus resources.
> > > >
> > > > >     ee0c0000-ee0cffff : pci@ee0d0000
> > > > >       ee0c0000-ee0c0fff : 0001:01:01.0
> > > > >         ee0c0000-ee0c0fff : ohci_hcd
> > > > >       ee0c1000-ee0c10ff : 0001:01:02.0
> > > > >         ee0c1000-ee0c10ff : ehci_hcd
> > > > >
> > > > > > When IORESOURCE_UNSET is set in a resource, %pR does not print =
the start
> > > > > > and end addresses.
> > > > >
> > > > > Yeah, that's how I found this commit, without bisecting ;-)
> > > > >
> > > > > > >     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > > > > > >     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> > > > > > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 con=
ventional PCI endpoint
> > > > > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
> > > > > > >     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> > > > > >
> > > > > > For this resource, it's very much intentional. It's a zero-base=
d BAR which
> > > > > > was left without IORESOURCE_UNSET prior to my patch leading to =
others part
> > > > > > of the kernel to think that resource range valid and in use (in=
 your
> > > > > > case it's so small it wouldn't collide with anything but it was=
n't
> > > > > > properly set up resource, nonetheless).
> > > > > >
> > > > > > >      pci 0000:00:01.0: supports D1 D2
> > > > > > >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> > > > > > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 con=
ventional PCI endpoint
> > > > > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
> > > > > > >     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> > > > > >
> > > > > > And this as well is very much intentional.
> > > > > >
> > > > > > >      pci 0000:00:02.0: supports D1 D2
> > > > > > >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> > > > > > >      PCI: bus0: Fast back to back transfers disabled
> > > > > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: ass=
igned
> > > > > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: ass=
igned
> > > > > > >      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
> > > > > > >
> > > > > > > Is that intentional?
> > > > > >
> > > > > > There's also that pci_dbg() in the patch which would show the o=
riginal
> > > > > > addresses (print the resource before setting IORESOURCE_UNSET) =
but to see
> > > > > > it one would need to enable it with dyndbg=3D... Bjorn was thin=
king of
> > > > > > making that pci_info() though so it would appear always.
> > > > > >
> > > > > > Was this the entire PCI related diff? I don't see those 0000:00=
:00.0 BARs
> > > > > > getting assigned anywhere.
> > > > >
> > > > > The above log is almost complete (lacked enabling the device afte=
rwards).
> > > > >
> > > > > AFAIU, the BARs come from the reg and ranges properties in the
> > > > > PCI controller nodes;
> > > > > https://elixir.bootlin.com/linux/v6.17/source/arch/arm/boot/dts/r=
enesas/r8a7791.dtsi#L1562
> > > >
> > > > Thanks, although I had already found this line by grep. I was just
> > > > expecting the address appear among root bus resources too.
> > > >
> > > > Curiously enough, pci_register_host_bridge() seems to try to add so=
me
> > > > resource from that list into bus and it's what prints those "root b=
us
> > > > resource" lines and ee090000 is not among the printed lines despite
> > > > appearing in /proc/iomem. As is, the resource tree and PCI bus view=
 on the
> > > > resources seems to be in disagreement and I'm not sure what to make=
 of it.
> > > >
> > > > But before considering going into that direction or figuring out wh=
y this
> > > > ee090000 resource does not appear among root bus resources, could y=
ou
> > > > check if the attached patch changes behavior for the resource which=
 are
> > > > non-zero based?
> > >
> > > This patch has no impact on dmesg, lspci output, or /proc/iomem
> > > for pci-rcar-gen2.
> >
> > It would have been too easy... :-(
> >
> > I'm sorry I don't really know these platform well and I'm currently try=
ing
> > to understand what adds that ee090000 resource into the resource tree
> > and so far I've not been very successful.
> >
> > Perhaps it would be easiest to print a stacktrace when the resource is
> > added but there are many possible functions. I think all of them
> > converge in __request_resource() so I suggest adding:
> >
> > WARN_ON(new->start =3D=3D 0xee090000);
> >
> > before __request_resource() does anything.
>=20
>     Call trace:
>      unwind_backtrace from show_stack+0x10/0x14
>      show_stack from dump_stack_lvl+0x7c/0xb0
>      dump_stack_lvl from __warn+0x80/0x198
>      __warn from warn_slowpath_fmt+0xc0/0x124
>      warn_slowpath_fmt from __request_resource+0x38/0xc8
>      __request_resource from __request_region+0xc4/0x1e8
>      __request_region from __devm_request_region+0x80/0xac
>      __devm_request_region from __devm_ioremap_resource+0xcc/0x160
>      __devm_ioremap_resource from rcar_pci_probe+0x58/0x350
>      rcar_pci_probe from platform_probe+0x58/0x90
>=20
> I.e. the call to devm_platform_get_and_ioremap_resource() in
> drivers/pci/controller/pci-rcar-gen2.c:rcar_pci_probe().

Thanks, the patch below might help BAR0 (but I'm not sure if it's the=20
correct solution due to being so unfamiliar with these kind of platforms=20
and how they're initialized).

If this works, we'll also have to decide what to do with the BAR1 (it=20
didn't appear in your (partial?) /proc/iomem quote so I'm left unsure how=
=20
to approach it).

I also noticed that || COMPILE_TEST is made ineffective for this driver by=
=20
the depends on ARM on the other line but it built just fine on x86 after=20
changing the depends on to:

depends on (ARCH_RENESAS && ARM) || COMPILE_TEST


--
[PATCH 1/1] PCI: rcar-gen2: Add BAR0 into host bridge resources

On R-Car M2-W, 0000:00:00.0 has BAR0 address that does not fall under
any root bus resource.

 pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
 pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff -> 0x00ee0=
80000
 pci-rcar-gen2 ee090000.pci: PCI: revision 11
 pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
 pci_bus 0000:00: root bus resource [bus 00]
 pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
 pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional PCI endp=
oint
 pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]

The same resource, however, appears in the resource tree (from
/proc/iomem):

ee090000-ee090bff : ee090000.pci pci@ee090000

This discrepancy between the resource tree and PCI bus resources for
the root bus causes issues with the commit 06b77d5647a4 ("PCI: Mark
resources IORESOURCE_UNSET when outside bridge windows") as BAR0 is
outside of any bus resource, and therefore marked with
IORESOURCE_UNSET.

The resource is added into the resource tree by rcar_pci_probe().
Add the resource also into host bridge resources.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/pci-rcar-gen2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controlle=
r/pci-rcar-gen2.c
index d29866485361..72ed44fdcde4 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -294,6 +294,8 @@ static int rcar_pci_probe(struct platform_device *pdev)
 =09if (IS_ERR(reg))
 =09=09return PTR_ERR(reg);
=20
+=09pci_add_resource(&bridge->windows, cfg_res);
+
 =09mem_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
 =09if (!mem_res || !mem_res->start)
 =09=09return -ENODEV;

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
--=20
2.39.5

--8323328-1758278253-1759424349=:947--

