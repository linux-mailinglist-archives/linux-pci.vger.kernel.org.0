Return-Path: <linux-pci+bounces-14652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B539C9A0B28
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 15:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593721F25EEB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3245D520;
	Wed, 16 Oct 2024 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vh1jPMVj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5BE21E3C8;
	Wed, 16 Oct 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084551; cv=none; b=QclNl7Q2zQiTJTswwH/3KENavT7lC0Vl7oyT73SD8uGMgn7A18tUAX7kpmDvsSMSVWBEFzjDdBHDvMbmZ0SUhOPi4iye7mCZV5avSi0TCOO6AWIQwBNy4Oo2w9arrymk6u3uFbo+PCGB8nX1yBfgzUH0a2GV3w5j/AlCkxF3iAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084551; c=relaxed/simple;
	bh=EfJUuAe1s4fdRdVwE23ivoBR2VlMaD3iurypFphbVDc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L5rBdQAImTZ+h246275ftOxJTwxq3S3exymPfUJTfH6DamnyNkNF1HHeasyi9TNxhLRdUau9lhB4MYkmeVOxV6x7+JYF4vDCj9Qv6V2zPHf+pFIMUZLKC3VPE/hkJlsTO8f/h/6DAc5ob3+DRL69fyZIn/46xfMhliSh7fL6ABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vh1jPMVj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729084549; x=1760620549;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EfJUuAe1s4fdRdVwE23ivoBR2VlMaD3iurypFphbVDc=;
  b=Vh1jPMVjSsx7kQLkPoN3i9Gt6u6Wn+M1WPNnXCrzR6fs8VHbX9JUpyYD
   Gq91KRS9SLzuUN/hwr8V/3nbz9W/BJJBlMYm33AKwRBepKOHwqlqZZq1m
   puOr0aaOhIYZLXeVEKHsTitUtHbIP51B8rDpRjK/56CpvQEqpYkqIjh2R
   gwJQ5fVxDbu4RS3HTaVC98KSnitAr0lyban2M5XY1Cre1cP9q+DybayGr
   obV1xwV/rV2AS7oiU0tt2U60r4xhniTraZD9hKytXwbmgnEXOZx7xfbpo
   q7Iyy5ksp0mlIrkajEJVxUdLHNjdUwrlYvpv2LclgYWTEdEf9qu+R11BY
   g==;
X-CSE-ConnectionGUID: /BbiRxbVRvGxaSDF9LDrSA==
X-CSE-MsgGUID: Rg7eUL8WRvW1eg21MnD7BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="32452449"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="32452449"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:15:49 -0700
X-CSE-ConnectionGUID: A59i0irTQVe9qdiE+gamJQ==
X-CSE-MsgGUID: NY4tXSmBQ1+BA8Cf/4h7bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="77838366"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.221])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:15:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 16 Oct 2024 16:15:43 +0300 (EEST)
To: Philipp Stanner <pstanner@redhat.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Convert pdev_sort_resources() to use resource
 name helper
In-Reply-To: <1cf314b3e91779e3353bbcaf8ad13516a00642e3.camel@redhat.com>
Message-ID: <fc0649b5-d065-2627-f475-d61f0594d0e5@linux.intel.com>
References: <20241016120048.1355-1-ilpo.jarvinen@linux.intel.com> <1cf314b3e91779e3353bbcaf8ad13516a00642e3.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1157704481-1729084543=:1010"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1157704481-1729084543=:1010
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 16 Oct 2024, Philipp Stanner wrote:

> On Wed, 2024-10-16 at 15:00 +0300, Ilpo J=C3=A4rvinen wrote:
> > Use pci_resource_name() helper in pdev_sort_resources() to print
> > resources in user-friendly format.
> >=20
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> > =C2=A0drivers/pci/setup-bus.c | 5 +++--
> > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 23082bc0ca37..071c5436b4a5 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -134,6 +134,7 @@ static void pdev_sort_resources(struct pci_dev
> > *dev, struct list_head *head)
> > =C2=A0=09int i;
> > =C2=A0
> > =C2=A0=09pci_dev_for_each_resource(dev, r, i) {
> > +=09=09const char *r_name =3D pci_resource_name(dev, i);
> > =C2=A0=09=09struct pci_dev_resource *dev_res, *tmp;
> > =C2=A0=09=09resource_size_t r_align;
> > =C2=A0=09=09struct list_head *n;
> > @@ -146,8 +147,8 @@ static void pdev_sort_resources(struct pci_dev
> > *dev, struct list_head *head)
> > =C2=A0
> > =C2=A0=09=09r_align =3D pci_resource_alignment(dev, r);
> > =C2=A0=09=09if (!r_align) {
> > -=09=09=09pci_warn(dev, "BAR %d: %pR has bogus
> > alignment\n",
> > -=09=09=09=09 i, r);
> > +=09=09=09pci_warn(dev, "%s: %pR has bogus
> > alignment\n",
> > +=09=09=09=09 r_name, r);
>=20
> Why do you remove the BAR index number, don't you think this
> information is also useful?

That's because of how pci_resource_name() works. The number will be=20
included in the returned string and it won't be always same as i.
So that change is done on purpose.

> One could also consider printing r_align, would that be useful?

As per the preceeding condition, it's known to be zero so it's not=20
that useful for any developer looking at these code lines.

> Note
> that there is a similar pci_warn down below in line 1118 that does
> print it. Would you want to change that pci_warn()-string, too?

pci_warn() on line 1118 does NOT print i (as expected when using=20
pci_resource_name()) and there align is not zero so I don't see how this=20
is relevant.

But thanks for taking a look anyway. :-)

--=20
 i.

--8323328-1157704481-1729084543=:1010--

