Return-Path: <linux-pci+bounces-14656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C9A9A0B83
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 15:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778651C23980
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D161FCC67;
	Wed, 16 Oct 2024 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="au8nXXnO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB711D8E1D;
	Wed, 16 Oct 2024 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085699; cv=none; b=pJ0GlOmKar8Zpn9u3eytq/3RjRSHr/eA8T9nNsFjgwWWQg97R17vYODbum/IHXxE2TQmYRMhulQZ2ObCsoXvmJcajDOBl/8uKxWGFO9yKP2Be2LfXfJthWrxitqvn/ejD360JutPrZuVjXqMszLI0wkJHBwUEpu7fu3PsA3jBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085699; c=relaxed/simple;
	bh=OY0qvxYgqynwJ+VveG5PA3n7LpCIo4LJHrj6PoUVQec=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k4MTkcCIHkX043f6jqW6PzZVqH2yIMq2gmsJHkhIzHSLf5MwGOO9y0Y/1uJw1SY3UFXSPJvVXPhA2bl5yQcEEb5wBvzsHvYIxdM7m8AhR9M4WpXfQVuvINpAyIu/zATGBO5FLOUnb2prZqNZUpliLxN4Fdj+GZpvAsp5QFhDhJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=au8nXXnO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729085698; x=1760621698;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OY0qvxYgqynwJ+VveG5PA3n7LpCIo4LJHrj6PoUVQec=;
  b=au8nXXnO0Jzt6Ps5StvMeug0CWHTFV96nMnbrF7yUhTMDFRoepilKhhf
   3B3OgqQQC4JwWkKpx/QMM6r/jXaNZ05VL/nEn7Bo40RiTMCv6SmaRPVLK
   7MJDD2gyfW9Rza+0jND2pa4ufWO7QO34CC2HEB/BlpIzoS9TF09Mts7LA
   CV8x0AAP0c276lTrAW2ev9NElXIM1yaMW9scqpU0BX28QHPhfVwLaS8PC
   HMWeN2cM7XmHoCvTpxGRoqFa09ZD7L0V3PNQiEPrdJLqXcUgqtZrJjJP9
   TY30+6G0VryvN1UHuPDiqmpe785TfMlKOhrwh5hJicOrpnkVPLhp3XhNN
   g==;
X-CSE-ConnectionGUID: l2NTsIu3QhuDkquUaNctOQ==
X-CSE-MsgGUID: ABjFQtLMRoWItwBkrxcXtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28628968"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28628968"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:34:57 -0700
X-CSE-ConnectionGUID: pUHmFB6fR36iIR/wkEo+Sg==
X-CSE-MsgGUID: 2grDQqx5T8es3DQ1CQnzkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78121898"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.221])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:34:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 16 Oct 2024 16:34:51 +0300 (EEST)
To: Philipp Stanner <pstanner@redhat.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Convert pdev_sort_resources() to use resource
 name helper
In-Reply-To: <ac50d7cf2a2071f196552fa4dc4109f9a551c7e7.camel@redhat.com>
Message-ID: <d1202665-1fb7-0a10-7c27-1a9bb0b2ecc4@linux.intel.com>
References: <20241016120048.1355-1-ilpo.jarvinen@linux.intel.com>  <1cf314b3e91779e3353bbcaf8ad13516a00642e3.camel@redhat.com>  <fc0649b5-d065-2627-f475-d61f0594d0e5@linux.intel.com> <ac50d7cf2a2071f196552fa4dc4109f9a551c7e7.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-381602611-1729085691=:1010"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-381602611-1729085691=:1010
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 16 Oct 2024, Philipp Stanner wrote:

> On Wed, 2024-10-16 at 16:15 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 16 Oct 2024, Philipp Stanner wrote:
> >=20
> > > On Wed, 2024-10-16 at 15:00 +0300, Ilpo J=C3=A4rvinen wrote:
> > > > Use pci_resource_name() helper in pdev_sort_resources() to print
> > > > resources in user-friendly format.
> > > >=20
> > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > > ---
> > > > =C2=A0drivers/pci/setup-bus.c | 5 +++--
> > > > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > > index 23082bc0ca37..071c5436b4a5 100644
> > > > --- a/drivers/pci/setup-bus.c
> > > > +++ b/drivers/pci/setup-bus.c
> > > > @@ -134,6 +134,7 @@ static void pdev_sort_resources(struct
> > > > pci_dev
> > > > *dev, struct list_head *head)
> > > > =C2=A0=09int i;
> > > > =C2=A0
> > > > =C2=A0=09pci_dev_for_each_resource(dev, r, i) {
> > > > +=09=09const char *r_name =3D pci_resource_name(dev, i);
> > > > =C2=A0=09=09struct pci_dev_resource *dev_res, *tmp;
> > > > =C2=A0=09=09resource_size_t r_align;
> > > > =C2=A0=09=09struct list_head *n;
> > > > @@ -146,8 +147,8 @@ static void pdev_sort_resources(struct
> > > > pci_dev
> > > > *dev, struct list_head *head)
> > > > =C2=A0
> > > > =C2=A0=09=09r_align =3D pci_resource_alignment(dev, r);
> > > > =C2=A0=09=09if (!r_align) {
> > > > -=09=09=09pci_warn(dev, "BAR %d: %pR has bogus
> > > > alignment\n",
> > > > -=09=09=09=09 i, r);
> > > > +=09=09=09pci_warn(dev, "%s: %pR has bogus
> > > > alignment\n",
> > > > +=09=09=09=09 r_name, r);
> > >=20
> > > Why do you remove the BAR index number, don't you think this
> > > information is also useful?
> >=20
> > That's because of how pci_resource_name() works. The number will be=20
> > included in the returned string and it won't be always same as i.
> > So that change is done on purpose.
> >=20
> > > One could also consider printing r_align, would that be useful?
> >=20
> > As per the preceeding condition, it's known to be zero so it's not=20
> > that useful for any developer looking at these code lines.
>=20
> Ah, right. Would it then make sense then to do:
>=20
> pci_warn(dev, "%s: %pR: Alignment must not be zero.\n", ...);
>=20
> Would tell then exactly what the problem is. Unless the devs know that
> a bogus alignment is definitely always 0.
>=20
> ?

While I personally don't need that given the surrounding code, I can=20
change the string to be more precise. Thanks.

--=20
 i.

--8323328-381602611-1729085691=:1010--

