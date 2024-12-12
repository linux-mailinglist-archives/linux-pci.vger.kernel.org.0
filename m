Return-Path: <linux-pci+bounces-18326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B372E9EFA45
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A0228CCBC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5D22236F0;
	Thu, 12 Dec 2024 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eP7dmUKe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D7222D79;
	Thu, 12 Dec 2024 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026647; cv=none; b=rErh1OET22jWAbnR+i7NeWEufZYLwTBicJyDLrRIZRMY9HoAsAmNeHQnaJN+QznI9brA6huePygkwkOCGuF0THMQwe2YAJh3m8hm/c0bp30GGOTwSIWOHFC/6ypfjO18sBIA6WZXi5p883mUjHh06SJ/cBOEUKlaREnY3Ed8FkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026647; c=relaxed/simple;
	bh=F75IBG8N3JPrXMGX6GgOgsRBEU/kIskJWrg/4L6cN50=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Itl7gaEafocWqjHb0UPLQWrYcCoUkQ/1BPsBznIkCp9ghpfi/Jx7GGgP7g+CzVSBOgafwlLN6hPzJit3OgmtALA1hkadv7vmokcFD83K359N/eh6x9Z3TDCGaQoPBJjoOltD8HeP3AlDPYfy0V0q3HxsnZEge/cHLEFfs2cgWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eP7dmUKe; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734026646; x=1765562646;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F75IBG8N3JPrXMGX6GgOgsRBEU/kIskJWrg/4L6cN50=;
  b=eP7dmUKe9aqpKiHOkzHQ03yaV7kucwiRx2EWFuGiOA9LuSnBhsJijQ7F
   D/Ju46Q07u3hLonzb+tKjvbhI74IZGepVD1z3QFVzPA26YI3VMWLjovKM
   BSDs1XHVLaQvXxSAiCrVpg8FkoPzpbl4pxCv+LZEKkdQeqVALZOUUayry
   aNxjfN8c+HV989oX/sb2mrTR0+PiuKQ+LgWcZaCbtlZhBlQm0C8qvr/F5
   qmins96xqp49sabNzKR5XKUaGenwq/jhqoi9QqSafdFDLQPr8KgxK48UW
   +KkhWEJOvI/gXyp5ic9/PoJK1ShKUncPpPyh+KpJYLe9Pa4uMQMH0d7Ka
   Q==;
X-CSE-ConnectionGUID: EiWTbgjXQKSueQhWr6z3gg==
X-CSE-MsgGUID: 9QQk8YCNTU640I5qbrstiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34509005"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="34509005"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 10:04:05 -0800
X-CSE-ConnectionGUID: NNaPQb/OSlmhgIdu1GqAlQ==
X-CSE-MsgGUID: qT/iyMhKReqk+9X7aYR3pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="101158370"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.137])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 10:04:02 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 12 Dec 2024 20:03:59 +0200 (EET)
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Lukas Wunner <lukas@wunner.de>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 5/8] PCI: Store # of supported End-End TLP Prefixes
In-Reply-To: <20241211163629.00002937@huawei.com>
Message-ID: <349c5b75-3f6c-c119-fedb-32dd1ec61725@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com> <20240913143632.5277-6-ilpo.jarvinen@linux.intel.com> <20241211163629.00002937@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1886133581-1734026639=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1886133581-1734026639=:936
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Dec 2024, Jonathan Cameron wrote:

> On Fri, 13 Sep 2024 17:36:29 +0300
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > eetlp_prefix_path in the struct pci_dev tells if End-End TLP Prefixes
> > are supported by the path or not, the value is only calculated if
> > CONFIG_PCI_PASID is set.
> >=20
> > The Max End-End TLP Prefixes field in the Device Capabilities Register
> > 2 also tells how many (1-4) End-End TLP Prefixes are supported (PCIe r6
> > sec 7.5.3.15). The number of supported End-End Prefixes is useful for
> > reading correct number of DWORDs from TLP Prefix Log register in AER
> > capability (PCIe r6 sec 7.8.4.12).
> >=20
> > Replace eetlp_prefix_path with eetlp_prefix_max and determine the
> > number of supported End-End Prefixes regardless of CONFIG_PCI_PASID so
> > that an upcoming commit generalizing TLP Prefix Log register reading
> > does not have to read extra DWORDs for End-End Prefixes that never will
> > be there.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/ats.c             |  2 +-
> >  drivers/pci/probe.c           | 14 +++++++++-----
> >  include/linux/pci.h           |  2 +-
> >  include/uapi/linux/pci_regs.h |  1 +
> >  4 files changed, 12 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > index c570892b2090..e13433dcfc82 100644
> > --- a/drivers/pci/ats.c
> > +++ b/drivers/pci/ats.c
> > @@ -377,7 +377,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int feat=
ures)
> >  =09if (WARN_ON(pdev->pasid_enabled))
> >  =09=09return -EBUSY;
> > =20
> > -=09if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
> > +=09if (!pdev->eetlp_prefix_max && !pdev->pasid_no_tlp)
> >  =09=09return -EINVAL;
> > =20
> >  =09if (!pasid)
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index b14b9876c030..0ab70ea6840c 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2228,8 +2228,8 @@ static void pci_configure_relaxed_ordering(struct=
 pci_dev *dev)
> > =20
> >  static void pci_configure_eetlp_prefix(struct pci_dev *dev)
> >  {
> > -#ifdef CONFIG_PCI_PASID
> >  =09struct pci_dev *bridge;
> > +=09unsigned int eetlp_max;
> >  =09int pcie_type;
> >  =09u32 cap;
> > =20
> > @@ -2241,15 +2241,19 @@ static void pci_configure_eetlp_prefix(struct p=
ci_dev *dev)
> >  =09=09return;
> > =20
> >  =09pcie_type =3D pci_pcie_type(dev);
> > +
> > +=09eetlp_max =3D FIELD_GET(PCI_EXP_DEVCAP2_EE_PREFIX_MAX, cap);
> > +=09/* 00b means 4 */
> > +=09eetlp_max =3D eetlp_max ?: 4;
> > +
> >  =09if (pcie_type =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> >  =09    pcie_type =3D=3D PCI_EXP_TYPE_RC_END)
> > -=09=09dev->eetlp_prefix_path =3D 1;
> > +=09=09dev->eetlp_prefix_max =3D eetlp_max;
> >  =09else {
> >  =09=09bridge =3D pci_upstream_bridge(dev);
> > -=09=09if (bridge && bridge->eetlp_prefix_path)
> > -=09=09=09dev->eetlp_prefix_path =3D 1;
> > +=09=09if (bridge && bridge->eetlp_prefix_max)
>=20
> What happens if they disagree?  That is the bridge supports 2
> and the device 3?

That's a good question.

The current code obviously only checks if Prefixes are supported or not so=
=20
the max value doesn't matter for the existing code.

I went to read spec and my reading from TLP logging point of view is that=
=20
the device's own maximum matters even if it might never get >2 Prefixes
(r6.1 2.2.10.4 & 6.2.4).

AFAIK, things happen on low level and there's no way to program this=20
value. So it's not like the kernel is telling that hw must only use x=20
Prefixes at most if that's what you were worried about.

But there are more things to consider, e.g., I noticed End-End TLP Prefix=
=20
Blocking in DevCtl2 which might impact the existing usage too and is not
checked by the kernel currently.

My interest here lies on cleaning this up so I'm not sure if functional=20
changes such as considering End-End TLP Prefix Blocking really matter for=
=20
some case or not. I can obviously easily add the code for that too if it's=
=20
required for this series to be acceptable but I don't have a test case for=
=20
it. My main goal with this TLP logging consolidation series is to get to a=
=20
point that extending it to support Flit mode is easier.

There's also TLP Prefix Log Present which I think the reader should=20
consider, which matters to another patch in this series and I'm going to=20
alter the length based on that flag.

--=20
 i.

--8323328-1886133581-1734026639=:936--

