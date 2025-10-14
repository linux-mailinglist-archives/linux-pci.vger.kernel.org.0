Return-Path: <linux-pci+bounces-38059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613FEBD96AD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 14:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633A819279EC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9851B314A77;
	Tue, 14 Oct 2025 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvJCwlbj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55544314A9B;
	Tue, 14 Oct 2025 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445711; cv=none; b=cpV+tHzAVQsAXcxEB2LHr4bz3P05kIVVUXbjb6YFFReskh5g0gt+hYYmL/MWhLrF2zmlaQ2JyKckJwZOtVDZl9RzwGTfVSHjvy4VtCcraGeJv72TgFVXo69kuIdzjV2SEmZDjFQ4Cp/3eKSQ96nWvNOkmYJ4/t8NZxzOg8ywKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445711; c=relaxed/simple;
	bh=Fh2zvIdneAnx+rNA7JVNRSLfcG52gBkauKLz308+u2A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eX0UBEjFQhGh8KgOHVz23aOjIYcPWOCXtbWbzexRwZxo+tHAqLB+//v34yH/SoLtSlxPzfy4tq1yjKcNyU0AUzoz3dZulg6SOEYd3+XmC/XsKYnXvo4ncC751WVMFQEiXxioroim6DQ9Mt9iKRECcQp0gC9zC8BGO6PiiDXJgBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvJCwlbj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760445709; x=1791981709;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Fh2zvIdneAnx+rNA7JVNRSLfcG52gBkauKLz308+u2A=;
  b=NvJCwlbjVvn8QQzj126fK8eDs74iPIUprLJcMRnFvHJjtnaRr024Ery3
   FPqmvJmnrvWKnzwEcLTUtiPcI6D9Qr6P+prVr2uPE/thIZWON25IizlLQ
   U11WOsdOoEm5PeZZaCMUCyr5KxqjnaebhpKO6Xj333vKOQ7WzqUzGF3rY
   CKp25CADu78ufiS5pEroaF++Dg1PEL9+yv8HwUX21eELx3uOefSvIV6f1
   rNg26J/horcV0dt58hlABqSKC+jhNNGUCAb/KFGMXVb8cU1lHWFyHJHJb
   Prjh8dGt8lBCK5Rk3f7QLcd/LUjquoqNYeNZ/+kp2WnJR5DnbDtDfGyqo
   g==;
X-CSE-ConnectionGUID: MI5gX/+sQBKuP2yih3HHkQ==
X-CSE-MsgGUID: APBvlQ6mQ4eGr+kkubu1Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62308580"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="62308580"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 05:41:48 -0700
X-CSE-ConnectionGUID: ATtpmtE3RAO3kOU5hd16zg==
X-CSE-MsgGUID: GIHMxPqSSyie+IHuRd3C/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="181424203"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.195])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 05:41:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 Oct 2025 15:41:42 +0300 (EEST)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
In-Reply-To: <alpine.DEB.2.21.2510141232400.39634@angie.orcam.me.uk>
Message-ID: <9f80ba5e-726b-ad68-b71f-ab23470bfa36@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com> <20250829131113.36754-4-ilpo.jarvinen@linux.intel.com> <9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net> <aO1sWdliSd03a2WC@alpha.franken.de> <alpine.DEB.2.21.2510132229120.39634@angie.orcam.me.uk>
 <74ed2ce0-744a-264f-6042-df4bbec0f58e@linux.intel.com> <alpine.DEB.2.21.2510141232400.39634@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-336658487-1760445640=:925"
Content-ID: <41cc3ac1-8798-33f2-459c-a96547ccac52@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-336658487-1760445640=:925
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <c7e2fab7-1980-c80e-bb98-a51bc4deb605@linux.intel.com>

On Tue, 14 Oct 2025, Maciej W. Rozycki wrote:

> On Tue, 14 Oct 2025, Ilpo J=E4rvinen wrote:
>=20
> > > As you can see there are holes in the map below 0x100, so e.g. if the=
 bus=20
> > > master IDE I/O space registers (claimed last in the list by `ata_piix=
')=20
> > > were assigned to 00000030-0000003f, then all hell would break loose. =
 It=20
> > > is exactly the mapping that happened in the absence of the code piece=
 in=20
> > > question IIRC.
> >=20
> > Are you sure pci-malta.c has to do anything like this as=20
> > pcibios_align_resource() does lower bound IO resource start addresses i=
f=20
> > PCIBIOS_MIN_IO is set?
>=20
>  Well, PCIBIOS_MIN_IO is never set for Malta and therefore stays at 0.

I meant whether pci-malta.c has to play with the ->start address at all=20
if it would use PCIBIOS_MIN_IO.

> I could boot 2.6.11 with the hunk reverted and see what happens, not a bi=
g=20
> deal (I should have old GCC somewhere as a kernel such old would surely b=
e=20
> a pain to build with modern GCC).  This stuff was badly broken before=20
> commit ae81aad5c2e1 (and there was support there too for the Atlas board,=
=20
> a weird one with a Philips SAA9730 southbridge and supporting a subset of=
=20
> the same CPU core cards as the Malta board does).
>=20
> > How about this patch below?
> >=20
> > (I'm not sure if it should actually be
> > =09PCIBIOS_MIN_IO =3D 0x1000 - hose->io_resource->start;
> > to allow resources starting from 0x1000 if ->start is not at 0.)
>=20
>  I'd have to go through the relevant datasheets to see whether it can=20
> actually happen in reality.  Perhaps we can just hardwire PCIBIOS_MIN_IO=
=20
> to 0x1000 instead, similarly to what other MIPS platforms do.

My patch did hardcode set it to 0x1000, I just noted before the patch that=
=20
I'm not sure if the code should actually try to align the resulting "real=
=20
start address" to 0x1000 if hose->io_resource->start !=3D 0.

Or are you saying also the the if () check should be removed as well?

> After all=20
> Malta's southbridge is on the mainboard and therefore always the same,=20
> regardless of the northbridge (system controller in MIPS-speak) which=20
> comes with the pluggable CPU core card.
>=20
>  NB there are commit c5de50dada14 ("MIPS: Malta: Change start address to=
=20
> avoid conflicts.") and commit 27547abf36af ("MIPS: malta: Incorporate=20
> PIIX4 ACPI I/O region in PCI controller resources") that fiddled with thi=
s=20
> code piece.  Especially the latter one refers additional commits that may=
=20
> give further insights.  And the former one removed a "FIXME" annotation,=
=20
> which suggests I didn't consider the solution perfect back 20 years ago,=
=20
> but given how long it stayed there it was surely good enough for its time=
=2E

It was "good enough" only because the arch specific=20
pcibios_enable_resources() was lacking the check for whether the resource=
=20
truly got assigned or not. The PIIX4 driver must worked just fine without=
=20
those IO resources which is what most drivers do despite using=20
pci(m)_enable_device() and not pci_enable_device_mem() (the latter=20
doesn't even seem to come with m variant).

--=20
 i.
--8323328-336658487-1760445640=:925--

