Return-Path: <linux-pci+bounces-14653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421669A0B47
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 15:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C5A1C22F7D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 13:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAE417A92F;
	Wed, 16 Oct 2024 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfEMqM+6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573D1E531;
	Wed, 16 Oct 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084785; cv=none; b=Hrtcy+78QybbsAY0wuqs4aSuDE147guoHIZ+5mf4C+8N1pyOocpeqfEu0NzTw03O7KBAaxETXNmTlKh8YIhH7qGKS6O2eQM5JXuwsBcWt3+m0p6zqZQmXsMgQQ+DSx38Sb9S2iTIJI/rbsIVVWHOABEpv3T02YUwHsjM80hMnTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084785; c=relaxed/simple;
	bh=SYw7XI5JjSFTHiTR6NbSiOgdW8W+9NX9323XdUFaZ3g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZhBLhnuW5jin0Ft/RToGAKkL9uZiv6CHB7eGNCEtfY5sKZ7t2K16CrvFkS1IlyebsHBuMvya/NARB9sbRseAQhuZccEBpYoJHFNGl+hzo4kMFOxK/psGvq47QRjGtCSekaaINvTBaJ0srlJLZfkaot9yVIxSB/PhGkKEWBxdfmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfEMqM+6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729084785; x=1760620785;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SYw7XI5JjSFTHiTR6NbSiOgdW8W+9NX9323XdUFaZ3g=;
  b=FfEMqM+6jX2sCoKZ6NSU+z6GeidtbMZOkt39w9EErEdeNlmSNBD++emv
   0sfSwTqdUJcfcjyCiwWNO+9NuncMltPaf3+llp5Bq6fjzVe7qzICrmmwX
   NXvic9AY+PubnYrLL0905i1fBtcNzKctjbG7L4JjJ1xWP1zqmv7bGzJyB
   zOKDayrjMd+Ky0x9cTjLFjG/fBslrU3i4Ns2Jog0bGrvb4ERv7Zw7Ta0i
   dcNmFCTAOJioyi547CGx9wW9woAi2QHK/dUNnmkaT23cd26ClBokF5eB8
   VnSZhMrfBWpUWzzlYVo1c30vySgGA6I/4w6g+Q6xaxJ6yb3TA8GtoRALG
   A==;
X-CSE-ConnectionGUID: M6N5NGQuQZWYzvtjhSDsGQ==
X-CSE-MsgGUID: IvwQ/MQ/RLWWqZfH5otXQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="27972672"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="27972672"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:19:10 -0700
X-CSE-ConnectionGUID: 7CXUroWXScGcKe/XrNzVZw==
X-CSE-MsgGUID: jjP5wTK5SxCmAQH25pTRVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="109020524"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.221])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:19:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 16 Oct 2024 16:19:03 +0300 (EEST)
To: Philipp Stanner <pstanner@redhat.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Convert pdev_sort_resources() to use resource
 name helper
In-Reply-To: <fc0649b5-d065-2627-f475-d61f0594d0e5@linux.intel.com>
Message-ID: <5b783894-99f3-b231-9d73-9980d0cac12d@linux.intel.com>
References: <20241016120048.1355-1-ilpo.jarvinen@linux.intel.com> <1cf314b3e91779e3353bbcaf8ad13516a00642e3.camel@redhat.com> <fc0649b5-d065-2627-f475-d61f0594d0e5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-898264977-1729084743=:1010"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-898264977-1729084743=:1010
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 16 Oct 2024, Ilpo J=C3=A4rvinen wrote:

> On Wed, 16 Oct 2024, Philipp Stanner wrote:
>=20
> > On Wed, 2024-10-16 at 15:00 +0300, Ilpo J=C3=A4rvinen wrote:
> > > Use pci_resource_name() helper in pdev_sort_resources() to print
> > > resources in user-friendly format.
> > >=20
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > > =C2=A0drivers/pci/setup-bus.c | 5 +++--
> > > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 23082bc0ca37..071c5436b4a5 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -134,6 +134,7 @@ static void pdev_sort_resources(struct pci_dev
> > > *dev, struct list_head *head)
> > > =C2=A0=09int i;
> > > =C2=A0
> > > =C2=A0=09pci_dev_for_each_resource(dev, r, i) {
> > > +=09=09const char *r_name =3D pci_resource_name(dev, i);
> > > =C2=A0=09=09struct pci_dev_resource *dev_res, *tmp;
> > > =C2=A0=09=09resource_size_t r_align;
> > > =C2=A0=09=09struct list_head *n;
> > > @@ -146,8 +147,8 @@ static void pdev_sort_resources(struct pci_dev
> > > *dev, struct list_head *head)
> > > =C2=A0
> > > =C2=A0=09=09r_align =3D pci_resource_alignment(dev, r);
> > > =C2=A0=09=09if (!r_align) {
> > > -=09=09=09pci_warn(dev, "BAR %d: %pR has bogus
> > > alignment\n",
> > > -=09=09=09=09 i, r);
> > > +=09=09=09pci_warn(dev, "%s: %pR has bogus
> > > alignment\n",
> > > +=09=09=09=09 r_name, r);
> >=20
> > Why do you remove the BAR index number, don't you think this
> > information is also useful?
>=20
> That's because of how pci_resource_name() works. The number will be=20
> included in the returned string and it won't be always same as i.
> So that change is done on purpose.

That being said, I now realize the other examples use the colon=20
differently "%s %pR: ..." so I'll change that for v2.

--=20
 i.

> > One could also consider printing r_align, would that be useful?
>=20
> As per the preceeding condition, it's known to be zero so it's not=20
> that useful for any developer looking at these code lines.
>=20
> > Note
> > that there is a similar pci_warn down below in line 1118 that does
> > print it. Would you want to change that pci_warn()-string, too?
>=20
> pci_warn() on line 1118 does NOT print i (as expected when using=20
> pci_resource_name()) and there align is not zero so I don't see how this=
=20
> is relevant.
>=20
> But thanks for taking a look anyway. :-)
>=20
>=20

--8323328-898264977-1729084743=:1010--

