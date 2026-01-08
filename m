Return-Path: <linux-pci+bounces-44280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C79C4D03790
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 15:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EC483083A9F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 14:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF054BFF32;
	Thu,  8 Jan 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwxVQqDK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F34BF3D4;
	Thu,  8 Jan 2026 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878008; cv=none; b=g55YLjWstCwmet/qTBAtQE9389F9yBhgBtGV1hpsxkbOvAn6Lrub0vfW93c5FTMT4pPiG9CH5N51I9jZTU8eZDLW485RNuBrdL2UZ7ct4g3dz8JBnzg8sf3SvcmgFIfz7GecPc555sh3jZSis/nxPMP/A3EOvt9bl7YHXNbkZcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878008; c=relaxed/simple;
	bh=ERTD0Sor+pEtzz38aRhDP1xX0g2kV+U4E2MCpQ9o2UE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aW64YPDzvMbIia+1tXmE5zp/SSUq+QB/jqSN9UF8xVkMPcEk+sYJwRMtT/Nk9FLXJ7rhAaTDbldpEdiFC0alEhQ0M0jCGp0hcT98QUn9nZWlcXYa+6ImFIhk7HkPg9yqOA49fWvIe/YpynnIwoH64mWpVVltzpxP/2sGqUSSAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwxVQqDK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767878006; x=1799414006;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ERTD0Sor+pEtzz38aRhDP1xX0g2kV+U4E2MCpQ9o2UE=;
  b=DwxVQqDKGLIpTrek6Uj7drB78AU4H283/NuFJvCxVdzpwk2NQsPf5Viz
   O0r8RiaR0GGZ0epLYwicvQdHgF3Rg/lhVXdnxVAbi5SX4d92aObpimup5
   D8JgjUdzKz8dFJBhoaByZC5ohOY/XhrlWpjrNd2bcgUx26dwkgZxqZFjb
   Sbm9uvRBsAiQefIphE30SE3fX4nZQHC3ynxJN1ryq6W1fSoscQEcEUPEP
   O3Ah46hXJGeOHSNJWMNfVxtA0zTUWrEI2pLGJbpIkexKWg76UI9MkCTLn
   Y54CJ0+FdwFJwQq20bM/oFBwo9ipmon/zxNtZBuY919botNzyRbW9onCs
   Q==;
X-CSE-ConnectionGUID: Ql2FwxlQRXO1yu1IoL2a3Q==
X-CSE-MsgGUID: TngO3NDLQvS+9oXaFBkeeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="80619520"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="80619520"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 05:13:26 -0800
X-CSE-ConnectionGUID: Q2gOtcxBRlGZvcZ7jjWg0g==
X-CSE-MsgGUID: OI3RzOPAS2mMDC0hG2Jk/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="208042647"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.14])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 05:13:22 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Jan 2026 15:13:18 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
    "David S. Miller" <davem@davemloft.net>, 
    Andreas Larsson <andreas@gaisler.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Nathaniel Roach <nroach44@gmail.com>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH RESEND 1/1] SPARC/PCI: Correct 64-bit non-pref -> pref
 BAR resources
In-Reply-To: <20260107202421.GA442125@bhelgaas>
Message-ID: <381abcc3-d6c3-ba57-4e69-1e65083f1b6c@linux.intel.com>
References: <20260107202421.GA442125@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1165435432-1767877998=:1132"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1165435432-1767877998=:1132
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 7 Jan 2026, Bjorn Helgaas wrote:

> [+cc Adrian]
>=20
> On Mon, Nov 24, 2025 at 07:04:11PM +0200, Ilpo J=C3=A4rvinen wrote:
> > SPARC T5-2 dts describes some PCI BARs as 64-bit resources without
> > pref(etchable) bit (0x83... vs 0xc3... in assigned-addresses) for
> > address ranges above the 4G threshold. Such resources cannot be placed
> > into a non-prefetchable PCI bridge window that is capable only to
> > 32-bit addressing. As such, it looks the platform is improperly
> > describe by dts.
> >=20
> > Kernel detect this problem (see the IORESOURCE_PREFETCH check in
> > pci_find_parent_resource()) and fails to assign these BAR resources to
> > the resource tree due to lack of a compatible bridge window.
> >=20
> > Prior to the commit 754babaaf333 ("sparc/PCI: Remove
> > pcibios_enable_device() as they do nothing extra") SPARC arch code did
> > not test whether device resources were successfully in the resource
> > tree when enabling a device, effectively hiding the problem. After
> > removing the arch specific enable code, PCI core's
> > pci_enable_resources() refuses to enable the device when it finds not
> > all mem resources are assigned, and therefore mpt3sas can't be enabled:
> >=20
> > pci 0001:04:00.0: reg 0x14: [mem 0x801110000000-0x80111000ffff 64bit]
> > pci 0001:04:00.0: reg 0x1c: [mem 0x801110040000-0x80111007ffff 64bit]
> > pci 0001:04:00.0: BAR 1 [mem 0x801110000000-0x80111000ffff 64bit]: can'=
t claim; no compatible bridge window
> > pci 0001:04:00.0: BAR 3 [mem 0x801110040000-0x80111007ffff 64bit]: can'=
t claim; no compatible bridge window
> > mpt3sas 0001:04:00.0: BAR 1 [mem size 0x00010000 64bit]: not assigned; =
can't enable device
> >=20
> > For clarity, this filtered log only shows failures for one mpt3sas
> > device but other devices fail similarly. In the reported case, the end
> > result with all the failures is an unbootable system.
> >=20
> > Things appeared to "work" before the commit 754babaaf333 ("sparc/PCI:
> > Remove pcibios_enable_device() as they do nothing extra") because the
> > resource tree is agnostic to whether PCI BAR resources are properly in
> > the tree or not. So as long as there was a parent resource (e.g. a root
> > bus resource) that contains the address range, the resource tree code
> > just places resource request underneath it without any consideration to
> > the intermediate BAR resource. While it worked, it's incorrect setup
> > still.
> >=20
> > Add of fixup to set IORESOURCE_PREFETCH flag for a 64-bit PCI resource
> > that has the end address above 4G requiring placement into the
> > prefetchable window. Also log the issue.
> >=20
> > Fixes: 754babaaf333 ("sparc/PCI: Remove pcibios_enable_device() as they=
 do nothing extra")
> > Reported-by: Nathaniel Roach <nroach44@gmail.com>
> > Tested-by: Nathaniel Roach <nroach44@gmail.com>
> > Closes: https://github.com/sparclinux/issues/issues/22
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Originally posted as attachment in response to Adrian's pointer to
> Nathaniel's regression report:
>=20
>   https://lore.kernel.org/r/d221be13-f652-cc75-90d1-92cf38e0110e@linux.in=
tel.com
>=20
> This seems reasonable to me and addresses a v6.18 regression, so I put
> this on pci/for-linus for v6.19.
>=20
> > ---
> >=20
> > Resending with linux-pci@ ML.
> >=20
> > Any comments on the approach are welcome. E.g., is the fixup done at a
> > correct level? Should it be targeted specifically to the known failures
> > (how?) to avoid hiding more platform description problems?
> >=20
> > It seems VF BARs still have 64-bit non-pref despite this change, AFAICT=
,
> > those are read directly from the device's config space so would require
> > ordinary quirks. None of them result in device enable failing though so=
 the
> > issue is orthogonal to the one being fixed here.
>=20
> The VF BARs that don't have PCI_BASE_ADDRESS_MEM_PREFETCH set is a
> generic question, not anything sparc-specific, right?

What I tried to say is that on this platform, we have such cases, but that=
=20
being said they do not cause regression (and they cannot be "fixed" by the=
=20
same means either).

None of these BARs (non-VF and VF ones) would not get assigned because of=
=20
the IORESOURCE_PREFETCH check in pci_find_parent_resource() but=20
post-754babaaf333 ("sparc/PCI: Remove pcibios_enable_device() as they do=20
nothing extra"), enable device just doesn't like that. But because VF=20
BARs are treated "optional", only non-VF BARs cause enable fail=20
(unrelated to this issue, I got asked this week why VF resources are=20
optional and realized I don't know the answer myself).

=2E..

> As of the "Removing Prefetchable Terminology" ECN
> (https://members.pcisig.com/wg/PCI-SIG/document/20839) that was
> incorporated in PCIe r6.3, PCI_BASE_ADDRESS_MEM_PREFETCH (bit 3) is
> deprecated.  There's a recommendation that it be set for 64-bit BARs
> and cleared for 32-bit BARs, but I suppose we'll see 64-bit VF BARs
> with it cleared as in this case.

I'd missed this change (IIRC, I only read CBs only up to r6.2 and then=20
r6.4 to r7.0).

=2E..If we look VF BAR flags on general level, could we now actually set=20
IORESOURCE_PREFETCH in decode_bar() if it's a 64-bit BAR on a PCIe=20
device? That should make those VF BARs and other non-pref 64-bit "right"=20
and it would be rather straightforward way to differentiate PCI vs PCIe=20
use cases.

> We might need to rework the PCI_BASE_ADDRESS_MEM_PREFETCH handling to
> accommodate this.  I suspect we'll still need to pay attention to it
> at least for conventional PCI, but there might be some wiggle room for
> PCIe.

Abolish 64-bit non-pref goes to non-prefetchable window rule, or more like=
=20
replace it with some rule that depends on conventional PCI being present=20
or not, doesn't look that complicated change thanks to the addition of=20
pbus_select_window_for_type() which consolidates these decision into a=20
central place (but it would require finding out if there's conventional=20
PCI involved which requires more work such as walking the device hierarchy=
=20
or maintaining flag which tells that information). Only the assignment=20
still run on its own fallback rules independent of=20
pbus_select_window_for_type() and of course that=20
pci_find_parent_resource() (this should probably be renamed to _for_addr=20
or something along those lines to better align with=20
pbus_select_window_for_type()).

Out of those two approaches, to keep conventional PCI compability, it=20
would be probably more straightforward to just make any PCIe 64-bit BAR=20
IORESOURCE_PREFETCH but that isn't as clearly connected to the intended=20
logic decision which is "conventional PCI or not?" but I guess a comment=20
in decode_bar() and perhaps in ioport.h would be good enough the explain=20
it.

Related to this, the root bus resource flags are a mess, IORESOURCE_MEM_64=
=20
is not always there even if addresses are clearly 64-bit and parent=20
resource selection there should probably be agnostic to=20
IORESOURCE_PREFETCH (which is currently not done as cleanly as it could be=
=20
but just as artifacts the fallbacks have).

--=20
 i.

> > If suggesting a different approach, please do realize my knowledge
> > about OF code is generally very limited (and I'm not sure how directly
> > the fixup code in other archs, mainly ppc, can be used as an example
> > how to do fixups with sparc).
> > ---
> >  arch/sparc/kernel/pci.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >=20
> > diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> > index a9448088e762..b290107170e9 100644
> > --- a/arch/sparc/kernel/pci.c
> > +++ b/arch/sparc/kernel/pci.c
> > @@ -181,6 +181,28 @@ static int __init ofpci_debug(char *str)
> > =20
> >  __setup("ofpci_debug=3D", ofpci_debug);
> > =20
> > +static void of_fixup_pci_pref(struct pci_dev *dev, int index,
> > +=09=09=09      struct resource *res)
> > +{
> > +=09struct pci_bus_region region;
> > +
> > +=09if (!(res->flags & IORESOURCE_MEM_64))
> > +=09=09return;
> > +
> > +=09if (!resource_size(res))
> > +=09=09return;
> > +
> > +=09pcibios_resource_to_bus(dev->bus, &region, res);
> > +=09if (region.end <=3D ~((u32)0))
> > +=09=09return;
> > +
> > +=09if (!(res->flags & IORESOURCE_PREFETCH)) {
> > +=09=09res->flags |=3D IORESOURCE_PREFETCH;
> > +=09=09pci_info(dev, "reg 0x%x: fixup: pref added to 64-bit resource\n"=
,
> > +=09=09=09 index);
> > +=09}
> > +}
> > +
> >  static unsigned long pci_parse_of_flags(u32 addr0)
> >  {
> >  =09unsigned long flags =3D 0;
> > @@ -244,6 +266,7 @@ static void pci_parse_of_addrs(struct platform_devi=
ce *op,
> >  =09=09res->end =3D op_res->end;
> >  =09=09res->flags =3D flags;
> >  =09=09res->name =3D pci_name(dev);
> > +=09=09of_fixup_pci_pref(dev, i, res);
> > =20
> >  =09=09pci_info(dev, "reg 0x%x: %pR\n", i, res);
> >  =09}
> >=20
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > --=20
> > 2.39.5
> >=20
>=20
--8323328-1165435432-1767877998=:1132--

