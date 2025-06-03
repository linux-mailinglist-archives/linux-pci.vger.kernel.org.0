Return-Path: <linux-pci+bounces-28845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46210ACC2DE
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 11:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE57418937F7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 09:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E834B271452;
	Tue,  3 Jun 2025 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5dhN3aq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995A2C327A;
	Tue,  3 Jun 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942516; cv=none; b=lj0P8pjxKgbO2pzUfBuy/hbgD9moMyvuLg4iw/vwp1SXyxCwoyvjlUK1cu25HhKLa6QqyewjWT5dMbO0r+AA7Ti/iZ3Yku8hUIc4HW6idh14ILwqbBMYIv1sf8BxnW4Jm8jU78LodcO3UuVYsRtQJAzABGTpO8oPzJ7dW02CUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942516; c=relaxed/simple;
	bh=PYgH8ZouwZAnmjYl7YyPQ0wAj9nKCxAhyBzwcs3OqRQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pf83F2eOzlTjg+r+9flVx0blYgMmjThcMjPqF8egmJE9qqPDyAzqg3BMEAsMtN9lg3QTJsf1BM9IGytWZG+4c87o35NRFeMgsJPed5AeDJfKZZTKr9Ks35HsCABzGSTx6JT4e99lqPx7+/NZn76oG0p9ZM2hm1zgB+tA2LSli/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5dhN3aq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748942516; x=1780478516;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PYgH8ZouwZAnmjYl7YyPQ0wAj9nKCxAhyBzwcs3OqRQ=;
  b=F5dhN3aq1NItEzLfFR59mU3b8JWKYaAgL7AFC4WZBQPO4WQ9aLLe1Vf9
   AC1FZSpBQkAxvosjjirmkVNAfykMcK1zSIx+p3tVtN+8QqYrI3VMLDVzV
   J4Pc8eyQsHoiW8ROfYq73iy9HKyYEvErn1W10ogaUYdKEcCsMmkJohnxm
   /nPFMmgGCRyfhl4gjE1LSg3xdMq9Z1CyRJWlfG0VlGQfAfJV4Cp1ckHHU
   0XsAmSU5MRSUe1N/tPslVacsRoMFo0aLZ+E4WR8gYX+FxedJe1BKbR3nV
   K3Fh/dfuFZa30nQTg/gd6mmyfirZmWtIuDklqLx6O5KiBJtO6i2nm0qPS
   g==;
X-CSE-ConnectionGUID: hOZtJAE9QAehetOnrj74gg==
X-CSE-MsgGUID: ie3/vL0uQZWTl8eKmufoZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="54776800"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="54776800"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:21:54 -0700
X-CSE-ConnectionGUID: bRDcFgofRsGTQWVvt1fq/Q==
X-CSE-MsgGUID: u2rW9rOzTyeUrEQcuwfvEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="144685825"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:21:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 12:21:46 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, bhelgaas@google.com, 
    manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org, 
    robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 1/6] PCI: Introduce generic bus config read helper
 function
In-Reply-To: <d6eeb0b5-53b3-5c40-00df-f79aa2619711@linux.intel.com>
Message-ID: <e486d187-e869-98b5-a0cb-8bd463540312@linux.intel.com>
References: <20250514161258.93844-1-18255117159@163.com> <20250514161258.93844-2-18255117159@163.com> <d6eeb0b5-53b3-5c40-00df-f79aa2619711@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-132017667-1748942506=:937"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-132017667-1748942506=:937
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Jun 2025, Ilpo J=E4rvinen wrote:

> On Thu, 15 May 2025, Hans Zhang wrote:
>=20
> > The primary PCI config space accessors are tied to the size of the read
> > (byte/word/dword). Upcoming refactoring of PCI capability discovery log=
ic
> > requires passing a config accessor function that must be able to perfor=
m
> > read with different sizes.
> >=20
> > Add any size config space read accessor pci_bus_read_config() to allow
> > giving it as the config space accessor to the upcoming PCI capability
> > discovery macro.
> >=20
> > Reconstructs the PCI function discovery logic to prepare for unified
> > configuration of access modes. No function changes are intended.
> >=20
> > Signed-off-by: Hans Zhang <18255117159@163.com>
> > ---
> > Changes since v9 ~ v11:
> > - None
> >=20
> > Changes since v8:
> > - The new split is patch 1/6.
> > - The patch commit message were modified.
> > ---
> >  drivers/pci/access.c | 17 +++++++++++++++++
> >  drivers/pci/pci.h    |  2 ++
> >  2 files changed, 19 insertions(+)
> >=20
> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > index b123da16b63b..603332658ab3 100644
> > --- a/drivers/pci/access.c
> > +++ b/drivers/pci/access.c
> > @@ -85,6 +85,23 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
> >  EXPORT_SYMBOL(pci_bus_write_config_word);
> >  EXPORT_SYMBOL(pci_bus_write_config_dword);
> > =20
> > +int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32=
 size,
> > +=09=09=09u32 *val)
> > +{
> > +=09struct pci_bus *bus =3D priv;
> > +=09int ret;
> > +
> > +=09if (size =3D=3D 1)
> > +=09=09ret =3D pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> > +=09else if (size =3D=3D 2)
> > +=09=09ret =3D pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
> > +=09else
> > +=09=09ret =3D pci_bus_read_config_dword(bus, devfn, where, val);
>=20
> Perhaps this should check also size =3D=3D 4 and return=20
> PCIBIOS_BAD_REGISTER_NUMBER in case size is wrong.
>=20
> > +
> > +=09return ret;

I'd also forgo ret variable and return directly.

> > +}
> > +EXPORT_SYMBOL_GPL(pci_bus_read_config);
>=20
> Does this even need to be exported? Isn't the capability search always=20
> built in?
>=20
> >  int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
> >  =09=09=09    int where, int size, u32 *val)
> >  {
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index b81e99cd4b62..5e1477d6e254 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -88,6 +88,8 @@ extern bool pci_early_dump;
> >  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
> >  bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
> >  bool pcie_cap_has_rtctl(const struct pci_dev *dev);
> > +int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32=
 size,
> > +=09=09=09u32 *val);
> > =20
> >  /* Functions internal to the PCI core code */
> > =20
> >=20
>=20
>=20

--=20
 i.

--8323328-132017667-1748942506=:937--

