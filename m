Return-Path: <linux-pci+bounces-37189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9E1BA8E69
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 12:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC7427AA4F1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56242F25F9;
	Mon, 29 Sep 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQOnD5/6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB552BEFF8;
	Mon, 29 Sep 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759142112; cv=none; b=CIL+S98IaluhEUAWfzMITgL3uFYWEuRarrGbsMX6mz8SRmJxBfcgIb1+or2oNKGtFUmU14IjbmdKxDhjuKWWXWVjr8MEDtK8JrBezRTe84NXBtG/VZms3+hGt75n0zBSLIgtxZk3qdG2OiM2cpx6lvYNoiWZTazjoJap0UUfChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759142112; c=relaxed/simple;
	bh=wYBNcG5mnxDwKWxBl9Q+NTkUS6jU20ckgneZYpAdm3c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j2u5hVjFIf5Q788bHgOz0YWVTUXj7IstFOT/Fg6T5U7FGUCZjF2JsZ422SU6+l5y7qyt0Mq/zkaTloXoMuMwpXn+IXBGX1Xqhcl9Mg6ZSXI6s+oU14GhVtG8cBpnfnbljV7n4wYV3nZLcGwE00i+K8FJKHj6mXMe2EJ9Ugt7nNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQOnD5/6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759142110; x=1790678110;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wYBNcG5mnxDwKWxBl9Q+NTkUS6jU20ckgneZYpAdm3c=;
  b=XQOnD5/6qPojP2yAGJ79ym8YNmxuPV1sB699i/kMmf9fWZZ70RevEKvR
   AGDzeqEPf/mTVv1LexoQzCSwvrNnD4aH5SbHoFiBbaAdb8AXN96hYmA4E
   XZf8yUq6lLN+GYSCeo8BXTRTY+sDt+b9omqGSlnrfGfbchJLqdQxCYUIF
   xNxLa7vdNqlDWshNnSL5Xv6srORpfUoH2dP7qKeNjt+NODxApCjJF21LE
   mNyBMJXRBXEyvXMmVizdepTtvn8XpbR+Z/HY1m2oTVt5rwc9b2CVo1csc
   qE2nRnGUBNptDCGqpAntYv4c/x/ysARNqTA2sQr/1/HBZCnFGe33W2z6y
   Q==;
X-CSE-ConnectionGUID: +cJhAtPRR/erqAoCfSkY3g==
X-CSE-MsgGUID: k87G3lvdSXyDKYUzOW/mPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="78803219"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="78803219"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 03:35:10 -0700
X-CSE-ConnectionGUID: fnWlT/h7TTWvpNsSmgwCww==
X-CSE-MsgGUID: +yaRE7DDTj6jFregkcgsYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="178625340"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 03:35:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Sep 2025 13:34:59 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set
 IORESOURCE_UNSET
In-Reply-To: <20250926193029.GA2254976@bhelgaas>
Message-ID: <ce12bdc8-517c-db9f-ba2b-303d2f30c2f0@linux.intel.com>
References: <20250926193029.GA2254976@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2026409950-1759142099=:943"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2026409950-1759142099=:943
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 26 Sep 2025, Bjorn Helgaas wrote:
> On Fri, Sep 26, 2025 at 03:21:17PM +0300, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 25 Sep 2025, Bjorn Helgaas wrote:
> > > On Wed, Sep 24, 2025 at 04:42:28PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > > PNP resources are checked for conflicts with the other resource in =
the
> > > > system by quirk_system_pci_resources() that walks through all PCI
> > > > resources. quirk_system_pci_resources() correctly filters out resou=
rce
> > > > with IORESOURCE_UNSET.
> > > >=20
> > > > Resources that do not reside within their bridge window, however, a=
re
> > > > not properly initialized with IORESOURCE_UNSET resulting in bogus
> > > > conflicts detected in quirk_system_pci_resources():
>=20
> > > > @@ -329,6 +349,18 @@ int __pci_read_base(struct pci_dev *dev, enum =
pci_bar_type type,
> > > >  =09=09=09 res_name, (unsigned long long)region.start);
> > > >  =09}
> > > > =20
> > > > +=09if (!(res->flags & IORESOURCE_UNSET)) {
> > > > +=09=09struct resource *b_res;
> > > > +
> > > > +=09=09b_res =3D pbus_select_window_for_res_addr(dev->bus, res);
> > > > +=09=09if (!b_res ||
> > > > +=09=09    b_res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))=
 {
> > > > +=09=09=09pci_dbg(dev, "%s %pR: no initial claim (no window)\n",
> > > > +=09=09=09=09res_name, res);
> > >=20
> > > Should this be pci_info()?  Or is there somewhere else that we
> > > complain about a child resource that's not contained in a bridge
> > > window?
> >=20
> > AFAIK, there's no other print. The kernel didn't even recognize this ca=
se=20
> > until now so how could there have been one?!
>=20
> > They'd generally show up as failures later in resource assignment if th=
e=20
> > resource doesn't fit to the bridge window [1], which should also set=20
> > IORESOURCE_UNSET, but good luck for inferring things from that. It's=20
> > tedious, I know. :-) If the bridge window is large enough, the base=20
> > address would just change where the resource fits (I think).
> >=20
> > It can be pci_info() if you think that's better. I just picked the leve=
l=20
> > which is the least noisy. We can go with pci_info() now and if the logg=
ing=20
> > turns out excessive when we start to see dmesgs with it, we can of cour=
se=20
> > adjust it later so it's not permanent either way.
> >=20
> > In any case, there's not much user can do for these as it's the setup F=
W=20
> > gave us.
> >=20
> > > I recently got an internal report of child BARs being reassigned, I
> > > think because they weren't inside a bridge window, and the dmesg log
> > > (from an older kernel) showed the BAR reassignments, but didn't say
> > > anything about the *reason* for the reassignment.
> >=20
> > Resource reassignment is only done after the resource was initially=20
> > assigned so I'm not sure if that inferring chain is sound.
> >=20
> > Admittedly, you didn't exactly specify how you picked up that it was=20
> > "reassigned" so it could be just terminology that doesn't match what=20
> > setup-bus/res.c considers as resource reassignment. That is, if BAR's=
=20
> > address was simply changed from the initial, that's not "reassignment" =
in=20
> > the sense used by the kernel.
>=20
> Here's the case I saw (a v6.1 kernel, so old log messages):
>=20
>   pci 0000:00:00.0: bridge window [mem 0x80000000-0x97fffffff 64bit pref]=
 to [bus 01-05] add_size 80000000 add_align 80000000
>   pci 0000:00:00.0: BAR 15: assigned [mem 0x380000000-0xcffffffff 64bit p=
ref]
>   pci 0000:01:01.0: BAR 0: [mem 0xb00000000-0xbffffffff 64bit pref]
>   ...
>   pci 0000:01:01.7: BAR 0: [mem 0x400000000-0x4ffffffff 64bit pref]
>   pci 0000:01:01.0: BAR 0: assigned [mem 0x400000000-0x4ffffffff 64bit pr=
ef]
>=20
> Obviously these initial BAR 0 values don't fit in the
> [0x80000000-0x97fffffff] bridge window, so I think we moved and
> expanded it and then assigned the BARs to be inside.
>=20
> I was thinking might get the "can't claim; no compatible bridge
> window" message in pci_claim_resource() as a clue, but we didn't.

Is pci_bus_claim_resources() called in this case? That requires=20
preserve_config. In my tests pci_bus_allocate_dev_resources() is never=20
called, only bridge window resources are claimed.

> This *seems* like a firmware defect: why would firmware bother to
> program these BARs at all unless it also made a bridge window that
> could reach them.

--=20
 i.

--8323328-2026409950-1759142099=:943--

