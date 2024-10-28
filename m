Return-Path: <linux-pci+bounces-15477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7583A9B38EE
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 19:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A5E1F22143
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 18:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637491DEFD2;
	Mon, 28 Oct 2024 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfzpFEJN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84F1547CA;
	Mon, 28 Oct 2024 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139528; cv=none; b=d02uC/ZcMlMekHLSlH5lcr9sX9UCZ228LswhHHzRlJb/+zNyTxaQr54GguBwzjzrLfqsrRu+wn9FTor/x084szND6rhpq+5G4irqtcMmqblhLKwquaMCENPg8nWFllSYuT94FEyhJLHnBFqzhoBq/ULhsCUHt9GEySpVZWOgSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139528; c=relaxed/simple;
	bh=R2DVy8iU7fbfJEnyj+dAeHE6Oyfz71RsNxNurlp22O8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UNJdmIuQPU2ghcF99I5cG4KFOWUzA3d9WzwfgeXuc+KNQC3G91Poy6Eo6DBixsExwlKfB66hC7VzpI+z2w3zRWn/h+PFhWh7axXh+onaK5cPBpHM/BHTBRPHzdboXmNU9y/q5akfQzibCMv/jDp9Q4QfkbRMSzv34zF+3/tm/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfzpFEJN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730139526; x=1761675526;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=R2DVy8iU7fbfJEnyj+dAeHE6Oyfz71RsNxNurlp22O8=;
  b=DfzpFEJNEJCnb9R7Mt1JIKBxOvPlziISPLdVwVGExwcAmHPykv+IKKTV
   HL6r2YmztsoJqMs0xvFw6FKpFPKLEkg0pY7zRminCgMTnqXPLbQA5iYMH
   6j4T8aHC1vvTgXjYCjm+wVwyPy/pWQc5RKTHvfUlnEy2rQGlp70vkTJnM
   mNK9WvpLjFon7JZPFHrHiDVKML3mSY+JKBeGn30LJlZXJzRAfGsU8Hmv0
   fnwf2GTzkPM8ba8a1P9ZqcbZjYJcCv+ns7zKat0j0kB4fBeTbmPwU+SWh
   ZVQk8pAvhFgk2zj3Ed4YMm5p3+eCWJJX4xL5tVKo+YVhk1l5cuB5iLE1J
   A==;
X-CSE-ConnectionGUID: luYixyotSDGEq9NLiImvJw==
X-CSE-MsgGUID: wBCtcbrERNCrgQNAE+D+sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29890417"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29890417"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:18:45 -0700
X-CSE-ConnectionGUID: nlwtlu05TdqCiPMMaaJHTQ==
X-CSE-MsgGUID: a1iIFpFwRWOLai9o3BreiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="85647119"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.203])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:18:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 28 Oct 2024 20:18:39 +0200 (EET)
To: Keith Busch <kbusch@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI/sysfs: Use __free() in reset_method_store()
In-Reply-To: <8862b34b-26b3-af75-5d23-d765fb41b5d4@linux.intel.com>
Message-ID: <d07973e2-0ac1-d3e0-25f0-7b1270ca4a15@linux.intel.com>
References: <20241028174046.1736-1-ilpo.jarvinen@linux.intel.com> <20241028174046.1736-3-ilpo.jarvinen@linux.intel.com> <Zx_Pt2ObNKIS8cu2@kbusch-mbp> <8862b34b-26b3-af75-5d23-d765fb41b5d4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1788405296-1730139519=:947"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1788405296-1730139519=:947
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 28 Oct 2024, Ilpo J=E4rvinen wrote:

> On Mon, 28 Oct 2024, Keith Busch wrote:
>=20
> > On Mon, Oct 28, 2024 at 07:40:45PM +0200, Ilpo J=E4rvinen wrote:
> > > @@ -1430,7 +1431,7 @@ static ssize_t reset_method_store(struct device=
 *dev,
> > >  =09=09=09=09  const char *buf, size_t count)
> > >  {
> > >  =09struct pci_dev *pdev =3D to_pci_dev(dev);
> > > -=09char *options, *tmp_options, *name;
> > > +=09char *tmp_options, *name;
> > >  =09int m, n;
> > >  =09u8 reset_methods[PCI_NUM_RESET_METHODS] =3D { 0 };
> > > =20
> > > @@ -1445,7 +1446,7 @@ static ssize_t reset_method_store(struct device=
 *dev,
> > >  =09=09return count;
> > >  =09}
> > > =20
> > > -=09options =3D kstrndup(buf, count, GFP_KERNEL);
> > > +=09char *options __free(kfree) =3D kstrndup(buf, count, GFP_KERNEL);
> >=20
> > We should avoid mixing declarations with code. Please declare it with
> > the cleanup attribute at the top like before, and just initialize it to
> > NULL.
>=20
> Hi,
>=20
> I don't exactly disagree with you myself and would prefer to keep=20
> declarations at top, but I think as done now is exactly what Bjorn wants=
=20
> for the specific case where __free() is used. This was discussed earlier=
=20
> on the list.

Hi again,

I went to archives and found out it had already made itself into=20
include/linux/cleanup.h which now says this:

"
 * Now, when a function uses both __free() and guard(), or multiple
 * instances of __free(), the LIFO order of variable definition order
 * matters. GCC documentation says:
 *
 * "When multiple variables in the same scope have cleanup attributes,
 * at exit from the scope their associated cleanup functions are run in
 * reverse order of definition (last defined, first cleanup)."
 *
 * When the unwind order matters it requires that variables be defined
 * mid-function scope rather than at the top of the file.

[...snip examples...]

 * Given that the "__free(...) =3D NULL" pattern for variables defined at
 * the top of the function poses this potential interdependency problem
 * the recommendation is to always define and assign variables in one
 * statement and not group variable definitions at the top of the
 * function when __free() is used.
"

After reading the documentation for real now myself :-), I realized it's
not just about maintainer preferences but about order of releasing things,=
=20
so it's a BAD PATTERN to put those declarations into the usual place when
using __free().


For completeness, the discussion thread (there might have been another=20
thread earlier than these):

https://lore.kernel.org/linux-pci/171140738438.1574931.15717256954707430472=
=2Estgit@dwillia2-xfh.jf.intel.com/T/#u

> If I misunderstood the conclusion of the earlier cleanup related=20
> discussion, can you please correct me Bjorn?
>=20
>=20

--=20
 i.

--8323328-1788405296-1730139519=:947--

