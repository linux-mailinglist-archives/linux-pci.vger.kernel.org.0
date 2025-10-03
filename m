Return-Path: <linux-pci+bounces-37545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3776BB741F
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366593B3CBD
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3178028136B;
	Fri,  3 Oct 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQTUqpBq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50139347DD;
	Fri,  3 Oct 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503494; cv=none; b=YyQv9wqP//cHJnLgluiRifNsTc9LGZafp85wi6QHcQni0nv/QnzvJArnCISPV1ybI6VSvFPZNcOTarip5YKZuGrEcbf3TXJvLsvj4l2+MS73x3ebSlAahtPD+uBnHgNCzr46TT0CIC+sPCnUyxXW27kwpFXsCVzm/dHduGaBAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503494; c=relaxed/simple;
	bh=5fVvBRDk4TBtjS9SrOWQvOXCcxJhpNnH28SREh2GezI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m3XRiZADJZkY7jfy+Jhr4jzdDeX8C+y5tkelV21HqY/tAel5V/hyCGrF73ckGW26PYDaHGuLZ5hFfA3TNfYPiMcuy8jIotCvFQyH/Hfi6dGm0ZdAwnGEKDCiO8w5UJQqBz0EKPInnrCbF3I/s0bdr0q1Qsdf+tBz5QYzxedurw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQTUqpBq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759503492; x=1791039492;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=5fVvBRDk4TBtjS9SrOWQvOXCcxJhpNnH28SREh2GezI=;
  b=DQTUqpBqTYi+v0pHmjGSYCl/0iV5ZPrK+sdf9Ns2Y5u3Lb6IVwEP50E7
   xUQQi0uZLtC7xQM05JaOQg+tZN7jhw06xJJM93ALZ3BcW61DgFIilqY4o
   236/bnaXuO4UUJc+70EGxmf8mtuvn0g2M1EM+ukX9cfC4UtHnH1mmmLi8
   u54MheXyenMrAq3ktlb0ojvIWlUk3WJRHi01SRxiBHtwOl7D73lwC8ETj
   yKHxko0TichcTGEaTNopphRXHvIxt+Hv2MQconu+wDYigeNYbZucNn6vt
   JjsY2N0zDcHIVuG647kGu3c+fTKiWjiRKp+CIUVMqbyHRWrzFpWcOWaF3
   Q==;
X-CSE-ConnectionGUID: F+Ngqao4QX6+XL7Waq98RA==
X-CSE-MsgGUID: BG3maz9AShifJ5KFcrI2vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="73138800"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="73138800"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 07:58:10 -0700
X-CSE-ConnectionGUID: nTEa55piTD6m1jeSNVav/w==
X-CSE-MsgGUID: csZop6ioRW+Ipyy5isHgtQ==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.66])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 07:58:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 3 Oct 2025 17:58:03 +0300 (EEST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set
 IORESOURCE_UNSET
In-Reply-To: <CAMuHMdVgCHU80mRm1Vwo6GFgNAtQcf50yHBz_oAk4TrtjcMpYg@mail.gmail.com>
Message-ID: <8b46093f-82bc-1c25-5607-ee40923b51af@linux.intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com> <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com> <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com> <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com>
 <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com> <c17c5ec1-132d-3588-2a4d-a0e6639cf748@linux.intel.com> <CAMuHMdVbyKdzbptA10F82Oj=6ktxnGAk4fz7dBLVdxALb8-WWg@mail.gmail.com> <2d5e9b78-8a90-3035-ff42-e881d61f4b7c@linux.intel.com>
 <CAMuHMdU_tPmQd=9dCzNs+dEt3fHNsYpYPFnT6QZk546o-J-y9g@mail.gmail.com> <7640a03e-dfea-db9c-80f5-d80fa2c505b7@linux.intel.com> <CAMuHMdVgCHU80mRm1Vwo6GFgNAtQcf50yHBz_oAk4TrtjcMpYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1568081130-1759500539=:1157"
Content-ID: <a96fb8b5-e381-7d73-709c-0b4dfb3465ab@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1568081130-1759500539=:1157
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <0df305d0-231d-8299-92bc-2a046364760c@linux.intel.com>

On Fri, 3 Oct 2025, Geert Uytterhoeven wrote:
> On Thu, 2 Oct 2025 at 18:59, Ilpo J=E4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Thu, 2 Oct 2025, Geert Uytterhoeven wrote:
> > > On Thu, 2 Oct 2025 at 16:54, Ilpo J=E4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > On Wed, 1 Oct 2025 at 15:06, Ilpo J=E4rvinen
> > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > > On Tue, 30 Sept 2025 at 18:32, Ilpo J=E4rvinen
> > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > > > > > > > On Fri, 26 Sept 2025 at 04:40, Ilpo J=E4rvinen
> > > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > > PNP resources are checked for conflicts with the other =
resource in the
> > > > > > > > > > system by quirk_system_pci_resources() that walks throu=
gh all PCI
> > > > > > > > > > resources. quirk_system_pci_resources() correctly filte=
rs out resource
> > > > > > > > > > with IORESOURCE_UNSET.
> > > > > > > > > >
> > > > > > > > > > Resources that do not reside within their bridge window=
, however, are
> > > > > > > > > > not properly initialized with IORESOURCE_UNSET resultin=
g in bogus
> > > > > > > > > > conflicts detected in quirk_system_pci_resources():
> > > > > > > > > >
> > > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 6=
4bit pref]
> > > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 6=
4bit pref]: contains BAR 2 for 7 VFs
> > > > > > > > > > ...
> > > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff =
64bit pref]
> > > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff=
 64bit pref]: contains BAR 2 for 31 VFs
> > > > > > > > > > ...
> > > > > > > > > > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] becaus=
e it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] becaus=
e it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> > > > > > > > > > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] becaus=
e it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] becaus=
e it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] becaus=
e it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disable=
d] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bi=
t pref]
> > > > > > > > > > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] becaus=
e it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] becaus=
e it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] becaus=
e it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] becaus=
e it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > > > > > > >
> > > > > > > > > > Mark resources that are not contained within their brid=
ge window with
> > > > > > > > > > IORESOURCE_UNSET in __pci_read_base() which resolves th=
e false
> > > > > > > > > > positives for the overlap check in quirk_system_pci_res=
ources().
> > > > > > > > > >
> > > > > > > > > > Fixes: f7834c092c42 ("PNP: Don't check for overlaps wit=
h unassigned PCI BARs")
> > > > > > > > > > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.int=
el.com>
> > > > > > > > >
> > > > > > > > > Thanks for your patch, which is now commit 06b77d5647a4d6=
a7 ("PCI:
> > > > > > > > > Mark resources IORESOURCE_UNSET when outside bridge windo=
ws") in
> > > > > > > > > linux-next/master next-20250929 pci/next
> > > > > > >
> > > > > > > > > This replaces the actual resources by their sizes in the =
boot log on
> > > > > > > > > e.g. on R-Car M2-W:
> > > > > > > > >
> > > > > > > > >      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee0=
90000 ranges:
> > > > > > > > >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0=
x00ee08ffff -> 0x00ee080000
> > > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0=
000:00
> > > > > > > > >      pci_bus 0000:00: root bus resource [bus 00]
> > > > > > > > >      pci_bus 0000:00: root bus resource [mem 0xee080000-0=
xee08ffff]
> > > > > > > > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000=
 conventional PCI endpoint
> > > > > > > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> > > > > > > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff p=
ref]
> > > > > > > >
> > > > > > > > What is going to be the parent of these resources? They don=
't seem to fall
> > > > > > > > under the root bus resource above in which case the output =
change is
> > > > > > > > intentional so they don't appear as if address range would =
be "okay".
> > > > > > >
> > > > > > > >From /proc/iomem:
> > > > > > >
> > > > > > >     ee080000-ee08ffff : pci@ee090000
> > > > > > >       ee080000-ee080fff : 0000:00:01.0
> > > > > > >         ee080000-ee080fff : ohci_hcd
> > > > > > >       ee081000-ee0810ff : 0000:00:02.0
> > > > > > >         ee081000-ee0810ff : ehci_hcd
> > > > > > >     ee090000-ee090bff : ee090000.pci pci@ee090000
> > > > > >
> > > > > > Okay, so this seem to appear in the resource tree but not among=
 the root
> > > > > > bus resources.
> > > > > >
> > > > > > >     ee0c0000-ee0cffff : pci@ee0d0000
> > > > > > >       ee0c0000-ee0c0fff : 0001:01:01.0
> > > > > > >         ee0c0000-ee0c0fff : ohci_hcd
> > > > > > >       ee0c1000-ee0c10ff : 0001:01:02.0
> > > > > > >         ee0c1000-ee0c10ff : ehci_hcd
> > > > > > >
> > > > > > > > When IORESOURCE_UNSET is set in a resource, %pR does not pr=
int the start
> > > > > > > > and end addresses.
> > > > > > >
> > > > > > > Yeah, that's how I found this commit, without bisecting ;-)
> > > > > > >
> > > > > > > > >     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > > > > > > > >     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> > > > > > > > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310=
 conventional PCI endpoint
> > > > > > > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
> > > > > > > > >     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> > > > > > > >
> > > > > > > > For this resource, it's very much intentional. It's a zero-=
based BAR which
> > > > > > > > was left without IORESOURCE_UNSET prior to my patch leading=
 to others part
> > > > > > > > of the kernel to think that resource range valid and in use=
 (in your
> > > > > > > > case it's so small it wouldn't collide with anything but it=
 wasn't
> > > > > > > > properly set up resource, nonetheless).
> > > > > > > >
> > > > > > > > >      pci 0000:00:01.0: supports D1 D2
> > > > > > > > >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> > > > > > > > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320=
 conventional PCI endpoint
> > > > > > > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
> > > > > > > > >     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> > > > > > > >
> > > > > > > > And this as well is very much intentional.
> > > > > > > >
> > > > > > > > >      pci 0000:00:02.0: supports D1 D2
> > > > > > > > >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> > > > > > > > >      PCI: bus0: Fast back to back transfers disabled
> > > > > > > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]:=
 assigned
> > > > > > > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]:=
 assigned
> > > > > > > > >      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ff=
ff]
> > > > > > > > >
> > > > > > > > > Is that intentional?
> > > > > > > >
> > > > > > > > There's also that pci_dbg() in the patch which would show t=
he original
> > > > > > > > addresses (print the resource before setting IORESOURCE_UNS=
ET) but to see
> > > > > > > > it one would need to enable it with dyndbg=3D... Bjorn was =
thinking of
> > > > > > > > making that pci_info() though so it would appear always.
> > > > > > > >
> > > > > > > > Was this the entire PCI related diff? I don't see those 000=
0:00:00.0 BARs
> > > > > > > > getting assigned anywhere.
> > > > > > >
> > > > > > > The above log is almost complete (lacked enabling the device =
afterwards).
> > > > > > >
> > > > > > > AFAIU, the BARs come from the reg and ranges properties in th=
e
> > > > > > > PCI controller nodes;
> > > > > > > https://elixir.bootlin.com/linux/v6.17/source/arch/arm/boot/d=
ts/renesas/r8a7791.dtsi#L1562
> > > > > >
> > > > > > Thanks, although I had already found this line by grep. I was j=
ust
> > > > > > expecting the address appear among root bus resources too.
> > > > > >
> > > > > > Curiously enough, pci_register_host_bridge() seems to try to ad=
d some
> > > > > > resource from that list into bus and it's what prints those "ro=
ot bus
> > > > > > resource" lines and ee090000 is not among the printed lines des=
pite
> > > > > > appearing in /proc/iomem. As is, the resource tree and PCI bus =
view on the
> > > > > > resources seems to be in disagreement and I'm not sure what to =
make of it.
> > > > > >
> > > > > > But before considering going into that direction or figuring ou=
t why this
> > > > > > ee090000 resource does not appear among root bus resources, cou=
ld you
> > > > > > check if the attached patch changes behavior for the resource w=
hich are
> > > > > > non-zero based?
> > > > >
> > > > > This patch has no impact on dmesg, lspci output, or /proc/iomem
> > > > > for pci-rcar-gen2.
> > > >
> > > > It would have been too easy... :-(
> > > >
> > > > I'm sorry I don't really know these platform well and I'm currently=
 trying
> > > > to understand what adds that ee090000 resource into the resource tr=
ee
> > > > and so far I've not been very successful.
> > > >
> > > > Perhaps it would be easiest to print a stacktrace when the resource=
 is
> > > > added but there are many possible functions. I think all of them
> > > > converge in __request_resource() so I suggest adding:
> > > >
> > > > WARN_ON(new->start =3D=3D 0xee090000);
> > > >
> > > > before __request_resource() does anything.
> > >
> > >     Call trace:
> > >      unwind_backtrace from show_stack+0x10/0x14
> > >      show_stack from dump_stack_lvl+0x7c/0xb0
> > >      dump_stack_lvl from __warn+0x80/0x198
> > >      __warn from warn_slowpath_fmt+0xc0/0x124
> > >      warn_slowpath_fmt from __request_resource+0x38/0xc8
> > >      __request_resource from __request_region+0xc4/0x1e8
> > >      __request_region from __devm_request_region+0x80/0xac
> > >      __devm_request_region from __devm_ioremap_resource+0xcc/0x160
> > >      __devm_ioremap_resource from rcar_pci_probe+0x58/0x350
> > >      rcar_pci_probe from platform_probe+0x58/0x90
> > >
> > > I.e. the call to devm_platform_get_and_ioremap_resource() in
> > > drivers/pci/controller/pci-rcar-gen2.c:rcar_pci_probe().
> >
> > Thanks, the patch below might help BAR0 (but I'm not sure if it's the
> > correct solution due to being so unfamiliar with these kind of platform=
s
> > and how they're initialized).
>=20
> Thanks, that has the following impact on dmesg:
>=20
>      pci-rcar-gen2 ee090000.pci: PCI: revision 11
>      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>      pci_bus 0000:00: root bus resource [bus 00]
>     -pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
>     +pci_bus 0000:00: root bus resource [mem 0xee080000-0xee090bff]
>      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
> PCI endpoint
>     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial
> claim (no window)
>     -pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
>     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
> initial claim (no window)
>     +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
>      pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
>      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
> PCI endpoint
>     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
> claim (no window)
>      pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
>      pci 0000:00:01.0: supports D1 D2
>      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
>      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
> PCI endpoint
>     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
> claim (no window)

Did you e.g. forget to change pci_dbg() to pci_info() as these all went=20
away, I cannot see why it should disappear because of my patch?

(No need to apologize if that was the case, just confirming if that=20
explains it is enough. :-))

>      pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
>      pci 0000:00:02.0: supports D1 D2
>      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
>      PCI: bus0: Fast back to back transfers disabled
>      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
>      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned

Perhaps print here what's the parent resource of these resource.

>     -pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
>     +pci_bus 0000:00: resource 4 [mem 0xee080000-0xee090bff]
>      pci-rcar-gen2 ee0d0000.pci: adding to PM domain always-on
>      PM: genpd_add_device: Add ee0d0000.pci to always-on
>      pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 ranges:
>     @@ -414,26 +416,22 @@ PM: =3D=3D=3D=3D always-on/ee0d0000.pci: start
>      pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
>      pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
>      pci_bus 0001:01: root bus resource [bus 01]
>     -pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cffff]
>     +pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0d0bff]
>      pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conventional
> PCI endpoint
>     -pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]: no initial
> claim (no window)
>     -pci 0001:01:00.0: BAR 0 [mem size 0x00000400]
>     -pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
> initial claim (no window)
>     +pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
>      pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
>      pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310 conventional
> PCI endpoint
>     -pci 0001:01:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
> claim (no window)
>      pci 0001:01:01.0: BAR 0 [mem size 0x00001000]
>      pci 0001:01:01.0: supports D1 D2
>      pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
>      pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
> PCI endpoint
>     -pci 0001:01:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
> claim (no window)
>      pci 0001:01:02.0: BAR 0 [mem size 0x00000100]
>      pci 0001:01:02.0: supports D1 D2
>      pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
>      PCI: bus1: Fast back to back transfers disabled
>      pci 0001:01:01.0: BAR 0 [mem 0xee0c0000-0xee0c0fff]: assigned
>      pci 0001:01:02.0: BAR 0 [mem 0xee0c1000-0xee0c10ff]: assigned
>     -pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0cffff]
>     +pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0d0bff]
>      rcar-pcie fe000000.pcie: adding to PM domain always-on
>      PM: genpd_add_device: Add fe000000.pcie to always-on
>      rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
>=20
> and on /proc/iomem (I used "diff -w" to reduce clutter):
>=20
>      ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec700000
>      ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec720000
>      ec740000-ec7401ff : ec500000.sound audmapp
>     -ee080000-ee08ffff : pci@ee090000

So what did add this previous? (Maybe use the same WARN_ON() trick as=20
previously to find out.)

It might have gotten broken because the coalesed resource=20
ee080000-ee090bff overlaps with that other resource in the resource tree.=
=20
But I don't see anything to that effect in the log so it's either silent=20
failure or there's much filtered from the log.

>     -  ee080000-ee080fff : 0000:00:01.0
>          ee080000-ee080fff : ohci_hcd
>     -  ee081000-ee0810ff : 0000:00:02.0
>          ee081000-ee0810ff : ehci_hcd
>      ee090000-ee090bff : ee090000.pci pci@ee090000
>     -ee0c0000-ee0cffff : pci@ee0d0000
>     -  ee0c0000-ee0c0fff : 0001:01:01.0
>          ee0c0000-ee0c0fff : ohci_hcd
>     -  ee0c1000-ee0c10ff : 0001:01:02.0
>          ee0c1000-ee0c10ff : ehci_hcd
>      ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000
>      ee100000-ee100327 : ee100000.mmc mmc@ee100000
>=20
> Removing the pci@ee0x0000 and 000x:0x:0x.0 entries doesn't look
> right to me? Or am I missing something?

I cannot understand this output, these resources seem to have been now=20
left without a parent and due to -w I don't know what's their real=20
indentation level.

> > If this works, we'll also have to decide what to do with the BAR1 (it
> > didn't appear in your (partial?) /proc/iomem quote so I'm left unsure h=
ow
> > to approach it).
>=20
> That is indeed not visible in /proc/iomem.

I meant before the commit 06b77d5647a4d6a7 ("PCI Mark resources=20
IORESOURCE_UNSET when outside bridge windows"), was it present?

> I tried the following (whitespace-damaged):
>=20
> --- a/drivers/pci/controller/pci-rcar-gen2.c
> +++ b/drivers/pci/controller/pci-rcar-gen2.c
> @@ -179,6 +179,7 @@ static void rcar_pci_setup(struct rcar_pci *priv)
>         unsigned long window_size;
>         unsigned long window_addr;
>         unsigned long window_pci;
> +       struct resource res;
>         u32 val;
>=20
>         entry =3D resource_list_first_type(&bridge->dma_ranges, IORESOURC=
E_MEM);
> @@ -191,6 +192,8 @@ static void rcar_pci_setup(struct rcar_pci *priv)
>                 window_pci =3D entry->res->start - entry->offset;
>                 window_size =3D resource_size(entry->res);
>         }
> +       resource_set_range(&res, window_addr, window_size);

You need to set flags properly too as this now tried to insert BUS, not=20
MEM resource (DEFINE_RES() might be the more appropriate in that case=20
anyway).=20

However, if there's not &bridge->dma_ranges ranges entry, rcar_pci_setup()=
=20
seems to initialize the resource to 0x40000000-0x7fffffff and I'm not sure=
=20
how it's supposed to work if there's more than one of these devices as per=
=20
the log above.

> +       pci_add_resource(&bridge->windows, &res);

What would be the backing resource in the resource tree for this? I'm not=
=20
sure if pci_add_resource() is going to result in adding one into the=20
resource tree.

>         pm_runtime_enable(dev);
>         pm_runtime_get_sync(dev);
>=20
> and only got:
>=20
>      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>      pci_bus 0000:00: root bus resource [bus 00]
>      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee090bff]
>     +pci_bus 0000:00: busn_res: can not insert [bus 00-7fffffff] under
> domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
>     +pci_bus 0000:00: root bus resource [mem size 0x40000000 64bit
> pref window disabled]
>      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
> PCI endpoint
>      pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
>      pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
>     @@ -417,6 +419,8 @@ pci-rcar-gen2 ee0d0000.pci: PCI: revisio
>      pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
>      pci_bus 0001:01: root bus resource [bus 01]
>      pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0d0bff]
>     +pci_bus 0001:01: busn_res: can not insert [bus 01-7fffffff] under
> domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
>     +pci_bus 0001:01: root bus resource [mem size 0x40000000 64bit
> pref window disabled]
>      pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conventional
> PCI endpoint
>      pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
>      pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
>=20
> but no impact on /proc/iomem.
>=20
> > I also noticed that || COMPILE_TEST is made ineffective for this driver=
 by
> > the depends on ARM on the other line but it built just fine on x86 afte=
r
> > changing the depends on to:
> >
> > depends on (ARCH_RENESAS && ARM) || COMPILE_TEST
>=20
> Thanks, that is a relic from the past, when the driver failed to build
> on other architectures. I have submitted a fix.

Thanks.

--=20
 i.
--8323328-1568081130-1759500539=:1157--

