Return-Path: <linux-pci+bounces-26225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E5A93967
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF231B66EE1
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 15:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC320897E;
	Fri, 18 Apr 2025 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODOQuVDN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3D513A265;
	Fri, 18 Apr 2025 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989341; cv=none; b=PVnSeuS5HWFTmG2PoWwtjzQfpX2MTsc0amtuwk/+qXpORrnbzFJ6zKEwFDmnLg348d9dGkH41NJnCIZnYA+DAsz2iWZ6Zh/4F8q+hApiLxZ+QRAnPUgf3ZNfmbl+kgoW6ij3iqZulrlz1pOHpM5ItuCJW1nrd9F+RreSyMHqAZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989341; c=relaxed/simple;
	bh=zDBDOU+6Hp5zW2pHFlOudW97qd8nblMkmeHFllhXDYM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mjnXPtywl6Cgy2u9Jiwl6k3VZ8cwu/M3v6XZ76LFVRQJigAC1dmpVZH489SYSy+cpY/+MhvK3Y2R6vgBjJERcHdSJ36+RG0o9e5tWHrhmiyZtzlVSP235Zly1elWnoHdEVjkZc7o6Cc/LZjnWlN8vsmuMiYc4x9wtWdmmJ8FWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODOQuVDN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744989339; x=1776525339;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=zDBDOU+6Hp5zW2pHFlOudW97qd8nblMkmeHFllhXDYM=;
  b=ODOQuVDNKgOKtwMTVlxMZ6Vlmpr82P8E//VdzUxzxUgHrQMrjhg8rqzd
   Lc9pYKxociUc1hldnbgRkKjNF9rLIb5BxGTVS6sfwbnc8OUTYTij+WW4I
   1zjBMUrtCnE0U2u2/2NTSB3VD+udPizONl/02HS4uPuoF6Rzdut2f2hq+
   nwAFiYfttwXqRjcePrQ9UlIVXA23CJSISMYq+Eto30j/VA3Z7ngWYUrdL
   +khi4NryFpQ3PRUYZ0MfMrEKxBPs47rYHfzEpUVUcTZHEYAzhSjCmhAX3
   mLaUTvGmSNmtZZi7taSnxMoRcAum5U+TX7ea/iqXbsSnR/XBwYjtxZpb6
   Q==;
X-CSE-ConnectionGUID: caY/D+cjTzugtlGLLirw8Q==
X-CSE-MsgGUID: K5gj2cd6R46kxoW2TLvETg==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="45849851"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="45849851"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 08:15:38 -0700
X-CSE-ConnectionGUID: Akw1pynlSEGh2bUJxdPI7w==
X-CSE-MsgGUID: XVVgHKXYQIqD2uzf7hj6yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="135990325"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.4])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 08:15:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Apr 2025 18:15:30 +0300 (EEST)
To: Ingo Molnar <mingo@kernel.org>
cc: Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
    Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
    "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: Use resource_set_{range,size}() helpers
In-Reply-To: <aAIB7Om9n_tXDnvk@gmail.com>
Message-ID: <db829a60-c524-73bc-e7c3-fed60e980d99@linux.intel.com>
References: <20250416101318.7313-1-ilpo.jarvinen@linux.intel.com> <Z_-E3W8i4EfxdBh3@smile.fi.intel.com> <a046f6bb-0b6e-a431-eaa5-ecd279459f86@linux.intel.com> <aAIB7Om9n_tXDnvk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1296546784-1744988942=:948"
Content-ID: <fe026d98-6232-bcd6-efa3-99ed79a78586@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1296546784-1744988942=:948
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <40bafa21-795a-e848-290b-cf4269f62d67@linux.intel.com>

On Fri, 18 Apr 2025, Ingo Molnar wrote:

>=20
> * Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > On Wed, 16 Apr 2025, Andy Shevchenko wrote:
> >=20
> > > On Wed, Apr 16, 2025 at 01:13:18PM +0300, Ilpo J=E4rvinen wrote:
> > > > Convert open coded resource size calculations to use
> > > > resource_set_{range,size}() helpers.
> > > >=20
> > > > While at it, use SZ_* for size parameter which makes the intent of =
code
> > > > more obvious.
> > >=20
> > > ...
> > >=20
> > > > +=09resource_set_range(res, base, 1ULL << (segn_busn_bits + 20));
> > >=20
> > > Then probably
> > >=20
> > > =09resource_set_range(res, base, BIT_ULL(segn_busn_bits) * SZ_1M);
> > >=20
> > > to follow the same "While at it"?
> >=20
> > I'll change that now since you brought it up. It did cross my mind to=
=20
> > convert that to * SZ_1M but it seemed to go farther than I wanted with =
a=20
> > simple conversion patch.
> >=20
> > I've never liked the abuse of BIT*() for size related shifts though,=20
> > I recall I saw somewhere a helper that was better named for size=20
> > related operations but I just cannot recall its name and seem to not=20
> > find that anymore :-(. But until I come across it once again, I guess=
=20
> > I'll have to settle to BIT*().
>=20
> BITS_TO_LONGS()?

Hi Ingo,

I'm not entiry sure if you're referring to my BIT*() matching unrelated
macros such as BITS_TO_LONGS() (I only meant BIT() and BIT_ULL() which I=20
thought was clear from the context), or that BITS_TO_LONGS() would be the=
=20
solution what I'm looking for.

In case you meant the latter, BITS_TO_LONGS() is not what I'm after.=20
BIT(n) sets nth bit and what I'm looking for is converting n to power of=20
two size. Obviously, both are mathematically doing 2^n (or 1 << n) but=20
they feel conceptually very different things.

--=20
 i.
--8323328-1296546784-1744988942=:948--

