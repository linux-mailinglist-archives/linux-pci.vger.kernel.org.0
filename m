Return-Path: <linux-pci+bounces-25996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2007EA8B7E9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 13:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4143BC3D2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 11:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA90B2459E9;
	Wed, 16 Apr 2025 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mEtJiAJE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D832459DF;
	Wed, 16 Apr 2025 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804442; cv=none; b=teIQI8wdv5grJnGUMeIMj37fgZd36G1AhLJweGuuhPeSALRTCG6P0Ga74DgGmbkYasuNstfR+p3uskTBg+gEduJaWTJgtSppwtReS/IiHP/nebtK1aYlOTREHza6Qd6XSSsJsVtBfDj/vb1pf/ZbEe2giXFf6bIKQFJ+6nKhOjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804442; c=relaxed/simple;
	bh=7qRIbmiS09zuebkIhFNeAIS85Mr+wGvkcDi7aBOIq4w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZzrcQ3kQogm+WkDwJC9yQOTyRx7s9kNpZLslOdPpruU9cwO5olNser36CaKMrUNf2KJccD4WsDcVXYLZwRZx1wMhev9HczRkxLirz0U09znSsAvtR7Fk74nMg240QsGtAv47qJij05jNuzi23ubSSkB5Xb/ONN2TiautDlboz1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mEtJiAJE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744804441; x=1776340441;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7qRIbmiS09zuebkIhFNeAIS85Mr+wGvkcDi7aBOIq4w=;
  b=mEtJiAJEoOJoz5NHxd+eMe8UnE7RxjdszMe95fEo7tvK4JoXT+ot/d1B
   RT63nZdwAaFt8BLQw2bKL8vCJJNE3UDgzv6BquRcLQU3fFoDDyLQgjQfd
   kcnXzH4ptsQJZ5zgF+m9Ync8hcKDMYbjODiuFNjoqSPH/UnB3M2ySWcbl
   ECO383Uu9EgLTVJLabua+6+Tu9W0ZSkAA4iNVE94dgNR+SrUO5vrrg1/V
   mPd15/SOKPtWdKFiqPxwuP++bAuPDOovvFewvHYE6n8+7bGTu9rdCzsLH
   eD86/5dV6hLBQ1KwdT2iRHmHXbzuQ7QETVKyTTljedY5yiANTMSBFyu+C
   A==;
X-CSE-ConnectionGUID: 6vaO3GaaQhCbD0HmgWTYEQ==
X-CSE-MsgGUID: EWjSetY6SZqWCXVYhgWjwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="63753828"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="63753828"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 04:54:00 -0700
X-CSE-ConnectionGUID: U0GvJdoERtK0/oYmQ01AEQ==
X-CSE-MsgGUID: CTzwN4b6S16MzzsgE131bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="130403134"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.243])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 04:53:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 16 Apr 2025 14:53:51 +0300 (EEST)
To: Andy Shevchenko <andy@kernel.org>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: Use resource_set_{range,size}() helpers
In-Reply-To: <Z_-E3W8i4EfxdBh3@smile.fi.intel.com>
Message-ID: <a046f6bb-0b6e-a431-eaa5-ecd279459f86@linux.intel.com>
References: <20250416101318.7313-1-ilpo.jarvinen@linux.intel.com> <Z_-E3W8i4EfxdBh3@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-255701998-1744804431=:991"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-255701998-1744804431=:991
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 16 Apr 2025, Andy Shevchenko wrote:

> On Wed, Apr 16, 2025 at 01:13:18PM +0300, Ilpo J=E4rvinen wrote:
> > Convert open coded resource size calculations to use
> > resource_set_{range,size}() helpers.
> >=20
> > While at it, use SZ_* for size parameter which makes the intent of code
> > more obvious.
>=20
> ...
>=20
> > +=09resource_set_range(res, base, 1ULL << (segn_busn_bits + 20));
>=20
> Then probably
>=20
> =09resource_set_range(res, base, BIT_ULL(segn_busn_bits) * SZ_1M);
>=20
> to follow the same "While at it"?

I'll change that now since you brought it up. It did cross my mind to=20
convert that to * SZ_1M but it seemed to go farther than I wanted with a=20
simple conversion patch.

I've never liked the abuse of BIT*() for size related shifts though, I=20
recall I saw somewhere a helper that was better named for size related=20
operations but I just cannot recall its name and seem to not find that=20
anymore :-(. But until I come across it once again, I guess I'll have to=20
settle to BIT*().

> > +=09=09=09resource_set_range(res, 0xC0000, SZ_128K);
> >  =09=09=09res->flags =3D IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
> >  =09=09=09=09     IORESOURCE_PCI_FIXED;
>=20
> I'm wondering why not DEFINE_RES_MEM() in such cases?

I guess you meant DEFINE_RES() as that seems to allow giving custom flags.
However, DEFINE_RES*() will overwrite ->name which seems something that=20
ought to not be done here.

I found one other case from the same file though which is truly defines
a resource from scratch.

--=20
 i.
--8323328-255701998-1744804431=:991--

