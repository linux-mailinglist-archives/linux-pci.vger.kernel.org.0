Return-Path: <linux-pci+bounces-37612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55189BBE0B0
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 14:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED9294E02F6
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AD827E7DA;
	Mon,  6 Oct 2025 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpdJiQa9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0AA22DF99;
	Mon,  6 Oct 2025 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754257; cv=none; b=WUZCn4KemzErjLRHVDCDYJOSagoT8xze5N446cFjRxlamfDESFJ5gJZluid87CHOyOzdLQqAAexXhYlHDSYETmYWYTxl51SVnbpGcqVESyMUTyDJm8XOqCM6uyz3OASzOqVnllXeRfl+QaKgTnQuPkXPRlhdZZJCTfFvNdPncC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754257; c=relaxed/simple;
	bh=YqRkfEqSsRjNLpz0blForhT5GHmcxZhAhhLjgUmT9e8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KdwDqc+zUKLPjUBUpEE5runb9Rw/pUcqPqv74kUMHCuESA823LXFKbEPTPPFp0+eO3kobbQPMdAFHKcyiz3GxclEpS6Fz7vUOQnv7f6IaWPbWGFeLpfTBX7+2/wmh/LfyVWt134xPEHFgvPo5LgWu5Rp+Xkyjo2krcc1vBWsvXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpdJiQa9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759754255; x=1791290255;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YqRkfEqSsRjNLpz0blForhT5GHmcxZhAhhLjgUmT9e8=;
  b=kpdJiQa94yiew77Jrp1BUEUoFYfv+WxlAE0mOB8CtPMaS82zZ8aE91IY
   KxWu0pykDIRTLQiy+Qg7hnFpsMaeD/yZFBpWONly6QSXjh0lx7jVOO1PG
   3xheKYn0IypNzxg2oNyWHdZHnADcu0rcp7L/bPxX0rDUbTXFfNu+/aMdv
   YUULhbkejSF4Yt2V+etOKJ9BEsj1/Q7qHYbVeagcS4zuRZa3UZL6h07QC
   dMUwAu+reahqgeenJYB5mCz+7XzWnPnv4GL2I2QbO7dvtR+pe7sb4tiqy
   LBTvTYUA+pDNvv0y6IRTiEcc0+9iMNXTIrggVU5RL3oJ/qF8gQxhrHWYR
   Q==;
X-CSE-ConnectionGUID: FMTZx17bQx6F7tniWUL7qg==
X-CSE-MsgGUID: lqjKP+FtTaCUmZrtoa2e5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="60962659"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="60962659"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 05:37:34 -0700
X-CSE-ConnectionGUID: We5KSncQQmKv4POR05NRuA==
X-CSE-MsgGUID: NxGDiXhqTHWnam45p2+rTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="185047058"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 05:37:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 Oct 2025 15:37:26 +0300 (EEST)
To: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set
 IORESOURCE_UNSET
In-Reply-To: <CAMuHMdUjhq2ZLFyMYv9KYRW8brsvXMH5xb5NW8shsHJmx7w2QQ@mail.gmail.com>
Message-ID: <bd1810d7-3e37-b599-5105-02902e6edf33@linux.intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com> <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com> <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com> <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com>
 <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com> <c17c5ec1-132d-3588-2a4d-a0e6639cf748@linux.intel.com> <CAMuHMdVbyKdzbptA10F82Oj=6ktxnGAk4fz7dBLVdxALb8-WWg@mail.gmail.com> <2d5e9b78-8a90-3035-ff42-e881d61f4b7c@linux.intel.com>
 <CAMuHMdU_tPmQd=9dCzNs+dEt3fHNsYpYPFnT6QZk546o-J-y9g@mail.gmail.com> <7640a03e-dfea-db9c-80f5-d80fa2c505b7@linux.intel.com> <CAMuHMdVgCHU80mRm1Vwo6GFgNAtQcf50yHBz_oAk4TrtjcMpYg@mail.gmail.com> <8b46093f-82bc-1c25-5607-ee40923b51af@linux.intel.com>
 <CAMuHMdUjhq2ZLFyMYv9KYRW8brsvXMH5xb5NW8shsHJmx7w2QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1682239440-1759754246=:943"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1682239440-1759754246=:943
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 6 Oct 2025, Geert Uytterhoeven wrote:
> On Fri, 3 Oct 2025 at 16:58, Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Fri, 3 Oct 2025, Geert Uytterhoeven wrote:
> > > On Thu, 2 Oct 2025 at 18:59, Ilpo J=C3=A4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > On Thu, 2 Oct 2025, Geert Uytterhoeven wrote:
> > > > > On Thu, 2 Oct 2025 at 16:54, Ilpo J=C3=A4rvinen
> > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > > On Wed, 1 Oct 2025 at 15:06, Ilpo J=C3=A4rvinen
> > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> > > > > > > > > On Tue, 30 Sept 2025 at 18:32, Ilpo J=C3=A4rvinen
> > > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > > On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > > > > > > > > > On Fri, 26 Sept 2025 at 04:40, Ilpo J=C3=A4rvinen
> > > > > > > > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > > > > > > PNP resources are checked for conflicts with the ot=
her resource in the
> > > > > > > > > > > > system by quirk_system_pci_resources() that walks t=
hrough all PCI
> > > > > > > > > > > > resources. quirk_system_pci_resources() correctly f=
ilters out resource
> > > > > > > > > > > > with IORESOURCE_UNSET.
> > > > > > > > > > > >
> > > > > > > > > > > > Resources that do not reside within their bridge wi=
ndow, however, are
> > > > > > > > > > > > not properly initialized with IORESOURCE_UNSET resu=
lting in bogus
> > > > > > > > > > > > conflicts detected in quirk_system_pci_resources():
> > > > > > > > > > > >
> > > > > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffff=
ff 64bit pref]
> > > > > > > > > > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffff=
ff 64bit pref]: contains BAR 2 for 7 VFs
> > > > > > > > > > > > ...
> > > > > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1fffff=
fff 64bit pref]
> > > > > > > > > > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffff=
ffff 64bit pref]: contains BAR 2 for 31 VFs
> > > > > > > > > > > > ...
> > > > > > > > > > > > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] be=
cause it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pre=
f]
> > > > > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] be=
cause it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> > > > > > > > > > > > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] be=
cause it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pre=
f]
> > > > > > > > > > > > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] be=
cause it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pre=
f]
> > > > > > > > > > > > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] be=
cause it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pre=
f]
> > > > > > > > > > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff dis=
abled] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff =
64bit pref]
> > > > > > > > > > > > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] be=
cause it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pre=
f]
> > > > > > > > > > > > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] be=
cause it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pre=
f]
> > > > > > > > > > > > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] be=
cause it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pre=
f]
> > > > > > > > > > > > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] be=
cause it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pre=
f]
> > > > > > > > > > > >
> > > > > > > > > > > > Mark resources that are not contained within their =
bridge window with
> > > > > > > > > > > > IORESOURCE_UNSET in __pci_read_base() which resolve=
s the false
> > > > > > > > > > > > positives for the overlap check in quirk_system_pci=
_resources().
> > > > > > > > > > > >
> > > > > > > > > > > > Fixes: f7834c092c42 ("PNP: Don't check for overlaps=
 with unassigned PCI BARs")
> > > > > > > > > > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@li=
nux.intel.com>
> > > > > > > > > > >
> > > > > > > > > > > Thanks for your patch, which is now commit 06b77d5647=
a4d6a7 ("PCI:
> > > > > > > > > > > Mark resources IORESOURCE_UNSET when outside bridge w=
indows") in
> > > > > > > > > > > linux-next/master next-20250929 pci/next
> > > > > > > > >
> > > > > > > > > > > This replaces the actual resources by their sizes in =
the boot log on
> > > > > > > > > > > e.g. on R-Car M2-W:
> > > > > > > > > > >
> > > > > > > > > > >      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci=
@ee090000 ranges:
> > > > > > > > > > >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee08000=
0..0x00ee08ffff -> 0x00ee080000
> > > > > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > > > > > > > > > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to b=
us 0000:00
> > > > > > > > > > >      pci_bus 0000:00: root bus resource [bus 00]
> > > > > > > > > > >      pci_bus 0000:00: root bus resource [mem 0xee0800=
00-0xee08ffff]
> > > > > > > > > > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x06=
0000 conventional PCI endpoint
> > > > > > > > > > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090b=
ff]
> > > > > > > > > > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffff=
ff pref]
> > > > > > > > > >
> > > > > > > > > > What is going to be the parent of these resources? They=
 don't seem to fall
> > > > > > > > > > under the root bus resource above in which case the out=
put change is
> > > > > > > > > > intentional so they don't appear as if address range wo=
uld be "okay".
> > > > > > > > >
> > > > > > > > > >From /proc/iomem:
> > > > > > > > >
> > > > > > > > >     ee080000-ee08ffff : pci@ee090000
> > > > > > > > >       ee080000-ee080fff : 0000:00:01.0
> > > > > > > > >         ee080000-ee080fff : ohci_hcd
> > > > > > > > >       ee081000-ee0810ff : 0000:00:02.0
> > > > > > > > >         ee081000-ee0810ff : ehci_hcd
> > > > > > > > >     ee090000-ee090bff : ee090000.pci pci@ee090000
> > > > > > > >
> > > > > > > > Okay, so this seem to appear in the resource tree but not a=
mong the root
> > > > > > > > bus resources.
> > > > > > > >
> > > > > > > > >     ee0c0000-ee0cffff : pci@ee0d0000
> > > > > > > > >       ee0c0000-ee0c0fff : 0001:01:01.0
> > > > > > > > >         ee0c0000-ee0c0fff : ohci_hcd
> > > > > > > > >       ee0c1000-ee0c10ff : 0001:01:02.0
> > > > > > > > >         ee0c1000-ee0c10ff : ehci_hcd
> > > > > > > > >
> > > > > > > > > > When IORESOURCE_UNSET is set in a resource, %pR does no=
t print the start
> > > > > > > > > > and end addresses.
> > > > > > > > >
> > > > > > > > > Yeah, that's how I found this commit, without bisecting ;=
-)
> > > > > > > > >
> > > > > > > > > > >     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > > > > > > > > > >     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pre=
f]
> > > > > > > > > > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c=
0310 conventional PCI endpoint
> > > > > > > > > > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000f=
ff]
> > > > > > > > > > >     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> > > > > > > > > >
> > > > > > > > > > For this resource, it's very much intentional. It's a z=
ero-based BAR which
> > > > > > > > > > was left without IORESOURCE_UNSET prior to my patch lea=
ding to others part
> > > > > > > > > > of the kernel to think that resource range valid and in=
 use (in your
> > > > > > > > > > case it's so small it wouldn't collide with anything bu=
t it wasn't
> > > > > > > > > > properly set up resource, nonetheless).
> > > > > > > > > >
> > > > > > > > > > >      pci 0000:00:01.0: supports D1 D2
> > > > > > > > > > >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D=
3hot
> > > > > > > > > > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c=
0320 conventional PCI endpoint
> > > > > > > > > > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000=
ff]
> > > > > > > > > > >     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> > > > > > > > > >
> > > > > > > > > > And this as well is very much intentional.
> > > > > > > > > >
> > > > > > > > > > >      pci 0000:00:02.0: supports D1 D2
> > > > > > > > > > >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D=
3hot
> > > > > > > > > > >      PCI: bus0: Fast back to back transfers disabled
> > > > > > > > > > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080f=
ff]: assigned
> > > > > > > > > > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810=
ff]: assigned
> > > > > > > > > > >      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee=
08ffff]
> > > > > > > > > > >
> > > > > > > > > > > Is that intentional?
> > > > > > > > > >
> > > > > > > > > > There's also that pci_dbg() in the patch which would sh=
ow the original
> > > > > > > > > > addresses (print the resource before setting IORESOURCE=
_UNSET) but to see
> > > > > > > > > > it one would need to enable it with dyndbg=3D... Bjorn =
was thinking of
> > > > > > > > > > making that pci_info() though so it would appear always=
=2E
> > > > > > > > > >
> > > > > > > > > > Was this the entire PCI related diff? I don't see those=
 0000:00:00.0 BARs
> > > > > > > > > > getting assigned anywhere.
> > > > > > > > >
> > > > > > > > > The above log is almost complete (lacked enabling the dev=
ice afterwards).
> > > > > > > > >
> > > > > > > > > AFAIU, the BARs come from the reg and ranges properties i=
n the
> > > > > > > > > PCI controller nodes;
> > > > > > > > > https://elixir.bootlin.com/linux/v6.17/source/arch/arm/bo=
ot/dts/renesas/r8a7791.dtsi#L1562
> > > > > > > >
> > > > > > > > Thanks, although I had already found this line by grep. I w=
as just
> > > > > > > > expecting the address appear among root bus resources too.
> > > > > > > >
> > > > > > > > Curiously enough, pci_register_host_bridge() seems to try t=
o add some
> > > > > > > > resource from that list into bus and it's what prints those=
 "root bus
> > > > > > > > resource" lines and ee090000 is not among the printed lines=
 despite
> > > > > > > > appearing in /proc/iomem. As is, the resource tree and PCI =
bus view on the
> > > > > > > > resources seems to be in disagreement and I'm not sure what=
 to make of it.
> > > > > > > >
> > > > > > > > But before considering going into that direction or figurin=
g out why this
> > > > > > > > ee090000 resource does not appear among root bus resources,=
 could you
> > > > > > > > check if the attached patch changes behavior for the resour=
ce which are
> > > > > > > > non-zero based?
> > > > > > >
> > > > > > > This patch has no impact on dmesg, lspci output, or /proc/iom=
em
> > > > > > > for pci-rcar-gen2.
> > > > > >
> > > > > > It would have been too easy... :-(
> > > > > >
> > > > > > I'm sorry I don't really know these platform well and I'm curre=
ntly trying
> > > > > > to understand what adds that ee090000 resource into the resourc=
e tree
> > > > > > and so far I've not been very successful.
> > > > > >
> > > > > > Perhaps it would be easiest to print a stacktrace when the reso=
urce is
> > > > > > added but there are many possible functions. I think all of the=
m
> > > > > > converge in __request_resource() so I suggest adding:
> > > > > >
> > > > > > WARN_ON(new->start =3D=3D 0xee090000);
> > > > > >
> > > > > > before __request_resource() does anything.
> > > > >
> > > > >     Call trace:
> > > > >      unwind_backtrace from show_stack+0x10/0x14
> > > > >      show_stack from dump_stack_lvl+0x7c/0xb0
> > > > >      dump_stack_lvl from __warn+0x80/0x198
> > > > >      __warn from warn_slowpath_fmt+0xc0/0x124
> > > > >      warn_slowpath_fmt from __request_resource+0x38/0xc8
> > > > >      __request_resource from __request_region+0xc4/0x1e8
> > > > >      __request_region from __devm_request_region+0x80/0xac
> > > > >      __devm_request_region from __devm_ioremap_resource+0xcc/0x16=
0
> > > > >      __devm_ioremap_resource from rcar_pci_probe+0x58/0x350
> > > > >      rcar_pci_probe from platform_probe+0x58/0x90
> > > > >
> > > > > I.e. the call to devm_platform_get_and_ioremap_resource() in
> > > > > drivers/pci/controller/pci-rcar-gen2.c:rcar_pci_probe().
> > > >
> > > > Thanks, the patch below might help BAR0 (but I'm not sure if it's t=
he
> > > > correct solution due to being so unfamiliar with these kind of plat=
forms
> > > > and how they're initialized).
> > >
> > > Thanks, that has the following impact on dmesg:
> > >
> > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> > >      pci_bus 0000:00: root bus resource [bus 00]
> > >     -pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
> > >     +pci_bus 0000:00: root bus resource [mem 0xee080000-0xee090bff]
> > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventiona=
l
> > > PCI endpoint
> > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial
> > > claim (no window)
> > >     -pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
> > > initial claim (no window)
> > >     +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> > >      pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventiona=
l
> > > PCI endpoint
> > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
> > > claim (no window)
> > >      pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> > >      pci 0000:00:01.0: supports D1 D2
> > >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventiona=
l
> > > PCI endpoint
> > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
> > > claim (no window)
> >
> > Did you e.g. forget to change pci_dbg() to pci_info() as these all went
> > away, I cannot see why it should disappear because of my patch?
> >
> > (No need to apologize if that was the case, just confirming if that
> > explains it is enough. :-))
>=20
> I indeed dropped that change. Adding it back...
>=20
> > >      pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> > >      pci 0000:00:02.0: supports D1 D2
> > >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> > >      PCI: bus0: Fast back to back transfers disabled
> > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
> > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
> >
> > Perhaps print here what's the parent resource of these resource.
>=20
> pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned (parent
> [mem 0xee080000-0xee08ffff])
> pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned (parent
> [mem 0xee080000-0xee08ffff])

Were these from a kernel without the problematic commit at all or with the=
=20
problematic commit and my fix? They look like the former case. The full=20
/proc/iomem also shows all the parent resources I think.

> > >     -pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
> > >     +pci_bus 0000:00: resource 4 [mem 0xee080000-0xee090bff]
> > >      pci-rcar-gen2 ee0d0000.pci: adding to PM domain always-on
> > >      PM: genpd_add_device: Add ee0d0000.pci to always-on
> > >      pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 ranges=
:
> > >     @@ -414,26 +416,22 @@ PM: =3D=3D=3D=3D always-on/ee0d0000.pci: st=
art
> > >      pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
> > >      pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
> > >      pci_bus 0001:01: root bus resource [bus 01]
> > >     -pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cffff]
> > >     +pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0d0bff]
> > >      pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conventiona=
l PCI endpoint
> > >     -pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]: no initial =
claim (no window)
> > >     -pci 0001:01:00.0: BAR 0 [mem size 0x00000400]
> > >     -pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no ini=
tial claim (no window)
> > >     +pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
> > >      pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
> > >      pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310 conventiona=
l PCI endpoint
> > >     -pci 0001:01:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial =
claim (no window)
> > >      pci 0001:01:01.0: BAR 0 [mem size 0x00001000]
> > >      pci 0001:01:01.0: supports D1 D2
> > >      pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
> > >      pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320 conventiona=
l PCI endpoint
> > >     -pci 0001:01:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial =
claim (no window)
> > >      pci 0001:01:02.0: BAR 0 [mem size 0x00000100]
> > >      pci 0001:01:02.0: supports D1 D2
> > >      pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
> > >      PCI: bus1: Fast back to back transfers disabled
> > >      pci 0001:01:01.0: BAR 0 [mem 0xee0c0000-0xee0c0fff]: assigned
> > >      pci 0001:01:02.0: BAR 0 [mem 0xee0c1000-0xee0c10ff]: assigned
> > >     -pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0cffff]
> > >     +pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0d0bff]
> > >      rcar-pcie fe000000.pcie: adding to PM domain always-on
> > >      PM: genpd_add_device: Add fe000000.pcie to always-on
> > >      rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
> > >
> > > and on /proc/iomem (I used "diff -w" to reduce clutter):
> > >
> > >      ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec700=
000
> > >      ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec720=
000
> > >      ec740000-ec7401ff : ec500000.sound audmapp
> > >     -ee080000-ee08ffff : pci@ee090000
> >
> > So what did add this previous? (Maybe use the same WARN_ON() trick as
> > previously to find out.)
>=20
> First call:
>=20
>     + __request_resource from request_resource_conflict+0x24/0x3c
>     + request_resource_conflict from devm_request_resource+0x48/0x9c
>     + devm_request_resource from devm_request_pci_bus_resources+0x5c/0x70
>     + devm_request_pci_bus_resources from devm_of_pci_bridge_init+0x7c/0x=
1c0
>     + devm_of_pci_bridge_init from devm_pci_alloc_host_bridge+0x44/0x6c
>     + devm_pci_alloc_host_bridge from rcar_pci_probe+0x34/0x384
>     + rcar_pci_probe from platform_probe+0x58/0x90

Thanks. So this is the call of interest, the rest are just the childs of=20
it with the same address.

I'm looking devm_of_pci_get_host_bridge_resources(), it seems to read=20
"ranges" property but not "reg" at all.

I wonder if devm_of_pci_get_host_bridge_resources() should also loop=20
through "reg" addresses and add those to host resources which are outside=
=20
of the "ranges"? Or if there should be a "range" that covers all what's=20
in "reg" to get them added into host bridge resources? That would seem the=
=20
generic solution instead of trying to do this in rcar_pci_probe().

(Perhaps these are stupid questions, please excuse my lack of knowledge=20
about OF things.)


While looking at another issue report, I also notice of_pci_prop_ranges()=
=20
assumes there are only bridge windows or BARs, but not both (not sure if=20
this relates to anything, just an observation while reading these code=20
paths).


> Second call:
>=20
>     + __request_resource from allocate_resource+0x1b8/0x1d4
>     + allocate_resource from pci_bus_alloc_from_region+0x1e0/0x220
>     + pci_bus_alloc_from_region from pci_bus_alloc_resource+0x84/0xb8
>     + pci_bus_alloc_resource from _pci_assign_resource+0x78/0x150
>     + _pci_assign_resource from pci_assign_resource+0x10c/0x310
>     + pci_assign_resource from assign_requested_resources_sorted+0x78/0xa=
c
>     + assign_requested_resources_sorted from
> __assign_resources_sorted+0x74/0x5c4
>     + __assign_resources_sorted from __pci_bus_assign_resources+0x50/0x1f=
0
>     + __pci_bus_assign_resources from
> pci_assign_unassigned_root_bus_resources+0xa8/0x190
>     + pci_assign_unassigned_root_bus_resources from pci_host_probe+0x5c/0=
xb0
>     + pci_host_probe from rcar_pci_probe+0x2e0/0x384
>     + rcar_pci_probe from platform_probe+0x58/0x90
>=20
> Third call:
>=20
>     + __request_resource from __request_region+0xc4/0x1e8
>     + __request_region from __devm_request_region+0x80/0xac
>     + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
>     + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
>     + pci_device_probe from really_probe+0x128/0x28c
>=20
> Fourth call:
>=20
>     + __request_region from __devm_request_region+0x80/0xac
>     + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
>     + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
>     + pci_device_probe from really_probe+0x128/0x28c
>=20
> Fifth call:
>=20
>     + __request_region from __devm_request_region+0x80/0xac
>     + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
>     + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
>     + pci_device_probe from really_probe+0x128/0x28c
>=20
> > It might have gotten broken because the coalesed resource
> > ee080000-ee090bff overlaps with that other resource in the resource tre=
e.
> > But I don't see anything to that effect in the log so it's either silen=
t
> > failure or there's much filtered from the log.
> >
> > >     -  ee080000-ee080fff : 0000:00:01.0
> > >          ee080000-ee080fff : ohci_hcd
> > >     -  ee081000-ee0810ff : 0000:00:02.0
> > >          ee081000-ee0810ff : ehci_hcd
> > >      ee090000-ee090bff : ee090000.pci pci@ee090000
> > >     -ee0c0000-ee0cffff : pci@ee0d0000
> > >     -  ee0c0000-ee0c0fff : 0001:01:01.0
> > >          ee0c0000-ee0c0fff : ohci_hcd
> > >     -  ee0c1000-ee0c10ff : 0001:01:02.0
> > >          ee0c1000-ee0c10ff : ehci_hcd
> > >      ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000
> > >      ee100000-ee100327 : ee100000.mmc mmc@ee100000
> > >
> > > Removing the pci@ee0x0000 and 000x:0x:0x.0 entries doesn't look
> > > right to me? Or am I missing something?
> >
> > I cannot understand this output, these resources seem to have been now
> > left without a parent and due to -w I don't know what's their real
> > indentation level.
>=20
> The *_hcd resources are now at the top level.
>=20
>      ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec700000
>      ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec720000
>      ec740000-ec7401ff : ec500000.sound audmapp
>     -ee080000-ee08ffff : pci@ee090000
>     -  ee080000-ee080fff : 0000:00:01.0
>     -    ee080000-ee080fff : ohci_hcd
>     -  ee081000-ee0810ff : 0000:00:02.0
>     -    ee081000-ee0810ff : ehci_hcd
>     +ee080000-ee080fff : ohci_hcd
>     +ee081000-ee0810ff : ehci_hcd
>      ee090000-ee090bff : ee090000.pci pci@ee090000
>     -ee0c0000-ee0cffff : pci@ee0d0000
>     -  ee0c0000-ee0c0fff : 0001:01:01.0
>     -    ee0c0000-ee0c0fff : ohci_hcd
>     -  ee0c1000-ee0c10ff : 0001:01:02.0
>     -    ee0c1000-ee0c10ff : ehci_hcd
>     +ee0c0000-ee0c0fff : ohci_hcd
>     +ee0c1000-ee0c10ff : ehci_hcd
>      ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000
>      ee100000-ee100327 : ee100000.mmc mmc@ee100000
>      ee140000-ee1400ff : ee140000.mmc mmc@ee140000
>=20
> I assume the others are gone because they now conflict with the *_hcd
> resources at the top level.

Like you initially assumed, it is wrong (while it works as the resources=20
themselves don't care that much about their parent they're under as long=20
as the resource is assigned, it's still not intended to be that way).

It might be worth to see if the coalescing in pci_register_host_bridge()=20
somehow messes these resources up either by not doing the coalesing loop=20
at all or by adding:

=09=09if (res->parent || next_res->parent) {
=09=09=09if (res->parent)
=09=09=09=09pr_info("Has parent %pR\n", res);
=09=09=09if (next_res->parent)
=09=09=09=09pr_info("Has parent %pR\n", next_res);
=09=09=09continue;
=09=09}

=2E..into the coalescing loop in case one of them happens to have a parent
(this is to be tested with the rcar_probe() fix).

> > > > If this works, we'll also have to decide what to do with the BAR1 (=
it
> > > > didn't appear in your (partial?) /proc/iomem quote so I'm left unsu=
re how
> > > > to approach it).
> > >
> > > That is indeed not visible in /proc/iomem.
> >
> > I meant before the commit 06b77d5647a4d6a7 ("PCI Mark resources
> > IORESOURCE_UNSET when outside bridge windows"), was it present?
>=20
> No, it was not present.
>=20
> > > I tried the following (whitespace-damaged):
> > >
> > > --- a/drivers/pci/controller/pci-rcar-gen2.c
> > > +++ b/drivers/pci/controller/pci-rcar-gen2.c
> > > @@ -179,6 +179,7 @@ static void rcar_pci_setup(struct rcar_pci *priv)
> > >         unsigned long window_size;
> > >         unsigned long window_addr;
> > >         unsigned long window_pci;
> > > +       struct resource res;
> > >         u32 val;
> > >
> > >         entry =3D resource_list_first_type(&bridge->dma_ranges, IORES=
OURCE_MEM);
> > > @@ -191,6 +192,8 @@ static void rcar_pci_setup(struct rcar_pci *priv)
> > >                 window_pci =3D entry->res->start - entry->offset;
> > >                 window_size =3D resource_size(entry->res);
> > >         }
> > > +       resource_set_range(&res, window_addr, window_size);
> >
> > You need to set flags properly too as this now tried to insert BUS, not
> > MEM resource (DEFINE_RES() might be the more appropriate in that case
> > anyway).
> >
> > However, if there's not &bridge->dma_ranges ranges entry, rcar_pci_setu=
p()
> > seems to initialize the resource to 0x40000000-0x7fffffff and I'm not s=
ure
>=20
> I guess the not &bridge->dma_ranges case dates back to the time the
> DTS didn't have dma-ranges yet.  However, upon closer look, the DTS
> still doesn't have dma_ranges, thus always using the default.
>=20
> > how it's supposed to work if there's more than one of these devices as =
per
> > the log above.
>=20
> Upon closer look, this is not a resource of the device, but an inbound
> memory region.  Hence there is no issue if multiple devices use the
> same region.
>=20
> >
> > > +       pci_add_resource(&bridge->windows, &res);
> >
> > What would be the backing resource in the resource tree for this? I'm n=
ot
> > sure if pci_add_resource() is going to result in adding one into the
> > resource tree.
>=20
> Likewise, it should not appear in /proc/ioem.

Thanks for checking it out.

I wonder how it would be supposed to work if PCI resource fitting logic=20
finds place for it and changes its address. I don't think it would ever=20
happen because it should never fit...

=2E..But the logic still is a bit fishy if rcar2 code expects that address=
=20
to be fixed but doesn't flag the resource to have a fixed address.

--=20
 i.

--8323328-1682239440-1759754246=:943--

