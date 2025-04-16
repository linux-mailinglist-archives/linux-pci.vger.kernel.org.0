Return-Path: <linux-pci+bounces-25999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857C5A8B8B6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 14:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988E4443371
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 12:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BF023A985;
	Wed, 16 Apr 2025 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdUkq7fa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2C221272;
	Wed, 16 Apr 2025 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805948; cv=none; b=MRue9sLBI9uPEMYVAdHVAISoIbCfyFjztoqtZM1EQoSGpL2AR1GyumoUAVw07CO0I0zpCGWiQ8VhorTo61iUaV0Y8BZD2zyMrggI9I9WfLOIJVUHvrXWgj3rH1AGdW9GGtJjcf5l7Z/+Z3jzguTkIg6vD10zQ6bzv01cd+IGFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805948; c=relaxed/simple;
	bh=Uwk/C5Fncf0gM3yHMM6IMOis7Lej7BqXPBmzclEOot8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=N5l9EU6whjRnnGDOKL6cgSw9Ce8Xb7hvuKd0CLQktfQZ8j55cjI0qBQG26lYihcxSFQRGCMoYk0xMOzCPpnVpEbo+hdcgBM8CNvxAlRrP1K82OG6d77KElveoeTGbI/er2l67UhiVJv6EH34PRiF/xnRJQ0Q4qy3Ze9uvN4rE1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdUkq7fa; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744805947; x=1776341947;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Uwk/C5Fncf0gM3yHMM6IMOis7Lej7BqXPBmzclEOot8=;
  b=AdUkq7farBOCEkFVOmn2Vzrjfp07JlVc9gxy+egUkA4Q8qClsB26qV8I
   NJ62xS2PKNJGnMUMPEYlnIxFqkx9eDqGNmSKLIwg1rPP6fhDy0pspjie3
   CB+hComZvfj24moOnjvZ4L0u4ZIMYqhZfp5c1vvjyfHMmR/7ZdH2tM3Xv
   ba5oEF0vlnSEnCYuME0gTsfWS+xNuEUlbZdU7/xsOF1YA0DqDpZXUWT84
   X7joDuTLF0vczmKReW6WYlZ7m1ZtJWo0LyyaxtfAPrORKNhaB+Rpxj3b1
   vNa4sFNv6iQk4U3rfn+jlTnuy1uAE1L+FpjmWzfjPDEZxZg0XDD1OxLzU
   Q==;
X-CSE-ConnectionGUID: Etfr6T6ZQ2GPxLi1TGQQDQ==
X-CSE-MsgGUID: ffGyuR9RRQaaeldd85Jq8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46271070"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="46271070"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 05:19:06 -0700
X-CSE-ConnectionGUID: uiM4xANsQpmKm+YiO3uNLg==
X-CSE-MsgGUID: BthUMN0UReeTsIzXg0uYdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="135444032"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.243])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 05:19:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 16 Apr 2025 15:18:56 +0300 (EEST)
To: Andy Shevchenko <andy@kernel.org>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: Use resource_set_{range,size}() helpers
In-Reply-To: <Z_-cgFJWZTjMl_ud@smile.fi.intel.com>
Message-ID: <7f0d376c-2d03-8e09-5d85-e53b0bce0cc5@linux.intel.com>
References: <20250416101318.7313-1-ilpo.jarvinen@linux.intel.com> <Z_-E3W8i4EfxdBh3@smile.fi.intel.com> <a046f6bb-0b6e-a431-eaa5-ecd279459f86@linux.intel.com> <Z_-cgFJWZTjMl_ud@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2113019736-1744805936=:991"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2113019736-1744805936=:991
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 16 Apr 2025, Andy Shevchenko wrote:

> On Wed, Apr 16, 2025 at 02:53:51PM +0300, Ilpo J=E4rvinen wrote:
> > On Wed, 16 Apr 2025, Andy Shevchenko wrote:
> > > On Wed, Apr 16, 2025 at 01:13:18PM +0300, Ilpo J=E4rvinen wrote:
>=20
> > > > +=09=09=09resource_set_range(res, 0xC0000, SZ_128K);
> > > >  =09=09=09res->flags =3D IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
> > > >  =09=09=09=09     IORESOURCE_PCI_FIXED;
> > >=20
> > > I'm wondering why not DEFINE_RES_MEM() in such cases?
> >=20
> > I guess you meant DEFINE_RES() as that seems to allow giving custom fla=
gs.
> > However, DEFINE_RES*() will overwrite ->name which seems something that=
=20
> > ought to not be done here.
>=20
> Okay, I haven't checked the initial state of name field here, so then
> DEFINE_RES_MEM_NAMED()?  Or don't we have one?

There's pre-existing res->name on it and your suggestion would have=20
resulted in overwriting it with NULL. res->name seems to be filled earlier=
=20
by PCI probe code.

> In any case I would rather see a one assignment for these cases than some=
thing
> hidden behind proposed conversions.

TBH, these DEFINE_RES*() helpers are doing hidden things such as=20
blantantly overwriting ->name which I only realized after I had already=20
converted to it as per your suggestion.

And yes, it is possible to pass the pre-existing res->name to=20
DEFINE_RES_NAMED() if that what you insist, though it seems doing it for=20
the sake of DEFINE_RES*() interface rather than this code wanting to=20
really define the resource from scratch.

Given the hidden overwriting, please be careful on suggesting=20
DEFINE_RES*() conversions as it's not as trivial as it seems.

> > I found one other case from the same file though which is truly defines
> > a resource from scratch.
>=20
>=20
>=20

--=20
 i.

--8323328-2113019736-1744805936=:991--

