Return-Path: <linux-pci+bounces-27710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A38DAB6A02
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 13:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4593A41C8
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 11:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4CE20102D;
	Wed, 14 May 2025 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFZgTON/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EB0270572;
	Wed, 14 May 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222190; cv=none; b=UgCNUfhoydhF4Sty0+ucc/QOuVEmm7Bxtcfruhk+ohkInWny6ZqgqKNUhufuKWWlK6n2oRHHVZasLu7Bz/dWj/wolLYgZKmZMyaQsdvVVP4sVudAAwGmhFNPw3EC+8TQLqRVua/mCWk8/3vFY8o/dSQ3A1Rz523OVu56OLmPcjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222190; c=relaxed/simple;
	bh=E4BSgJDVenYarAln03bgzuVa9WotPbGKy1KhI3IoiKo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G19/+14F/iaajfTC/ZZRDaStVDQw0a/J8JWZKOnHp4tLelxmsp6h9n7mycIc1PvGIv2rV+guJAhNQgHslubGwTdu4D4vX7sybzU9xGm+Q0xBHXct2+DOZ9vGEP9cMaIFAS7NS4TwUd1MrupqS+B06TtGUsrBb7XR9eUWeCmzBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFZgTON/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747222188; x=1778758188;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=E4BSgJDVenYarAln03bgzuVa9WotPbGKy1KhI3IoiKo=;
  b=mFZgTON/eS8SJQA0xaNBl5KwxBAbt+0DC/nTQLLV09RD6LeRdVdnf6xK
   jlJXXe4ThKS/IOwCcXQGokYs8xXC8GMVl43t6OB6EPT9AZkdf0b1RRIWE
   w+U2OTTKgGe2kh10tqlpiPKCO90ULn0hHZzmtMomCgT7H/qrqGhZmcy2L
   otDLWkMvvbbxMJ/eLwvlmcA2vaMz9RswL8tgCbYDgMyquKANU7VMJhDm0
   Fm94SE9/rPuSIBJO1qjAAja5POL6uYmNGCk6CBAfUsBhLaItjgAnR6Oj+
   ffkXimWcWtN5RI3fx/K0s5q/6Klqp/9mSJZAngtpaKN6bY7ztVNWslnE8
   w==;
X-CSE-ConnectionGUID: Ir8g3+VyR5+B7NduZ7a21g==
X-CSE-MsgGUID: h65dxn4iR3q221n7OfoThA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49256829"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49256829"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 04:29:47 -0700
X-CSE-ConnectionGUID: PuwOQQLISMaId9IJUlIxpg==
X-CSE-MsgGUID: VTo0qjriTzicmFIVnXHNqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142043820"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.231])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 04:29:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 14 May 2025 14:29:42 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Move reset and restore related code to
 reset-restore.c
In-Reply-To: <aCRBFWHKa02Hu-ec@wunner.de>
Message-ID: <7c8ebe5d-a5be-6aba-1b84-15dd2f32b52f@linux.intel.com>
References: <20250512120900.1870-1-ilpo.jarvinen@linux.intel.com> <aCRBFWHKa02Hu-ec@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-146288393-1747219295=:1054"
Content-ID: <96a63802-2113-5547-8fe3-06ec88c45643@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-146288393-1747219295=:1054
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <dfda58bc-098a-7139-d60e-4231d16e2767@linux.intel.com>

On Wed, 14 May 2025, Lukas Wunner wrote:

> On Mon, May 12, 2025 at 03:08:57PM +0300, Ilpo J=E4rvinen wrote:
> > There are quite many reset and restore related functions in pci.c that
> > barely depend on the other functions in pci.c. Create reset-restore.c
> > for reset and restore related logic to keep those 1k lines in one place=
=2E
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Hm, could I get a:
>=20
> Suggested-by: Lukas Wunner <lukas@wunner.de>
>=20
> ... per:
>=20
> https://lore.kernel.org/r/Z7hZZNT5NHYncZ3c@wunner.de/

Ah, I hadn't even noticed you suggested it (I recall reading the first=20
paragraph of that but not the last one which made the suggestion). I made=
=20
this patch first back in 2024 and have just sit on top of the change until=
=20
there seems to be reasonably conflict free window.

> >  drivers/pci/Makefile        |    4 +-
> >  drivers/pci/pci.c           | 1015 +----------------------------------
> >  drivers/pci/pci.h           |   10 +
> >  drivers/pci/reset-restore.c | 1014 ++++++++++++++++++++++++++++++++++
>=20
> I'd prefer reset.c for succinctness.

I initially had reset.c but was worried the name is too narrow scoped,
I can change back to reset.c.

> That said, this patch conflicts with Mani's slot reset patches
> which a lot of people seem to be interested in:
>=20
> https://lore.kernel.org/r/20250508-pcie-reset-slot-v4-0-7050093e2b50@lina=
ro.org/
>=20
> Maybe it's better to give Mani's series the advantage and defer
> this patch here to the next cycle.

Fine for me but those conflicts looks quite simple. Next cycle will=20
have its own share of conflicts, I'm sure :-).

> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -69,15 +69,7 @@ struct pci_pme_device {
> >   */
> >  #define PCI_RESET_WAIT 1000 /* msec */
>=20
> I'd move PCI_RESET_WAIT, pci_dev_wait() and
> pci_bridge_wait_for_secondary_bus() to reset.c as well.
> Then pci_dev_d3_sleep() is the only function which is no longer static.

Okay I'll move those as well but that static statement is not exactly=20
true, I'll these need to do these as well:

- move pci_bus_max_d3cold_delay() along with=20
  pci_bridge_wait_for_secondary_bus() to keep that static, or turn that
  into a non-static.

- make pcie_wait_for_link_delay() non-static.

--=20
 i.
--8323328-146288393-1747219295=:1054--

