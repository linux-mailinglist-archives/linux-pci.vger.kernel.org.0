Return-Path: <linux-pci+bounces-25224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFA6A79FAA
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 11:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2CE1887E19
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842A219E7D1;
	Thu,  3 Apr 2025 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwVjqdoQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D981F236B;
	Thu,  3 Apr 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743671451; cv=none; b=VFoLplnBEXBnCka/GIkKfaNHrdpFYPDfLE3z5mJ6Vlfnp1AfubirHMVVnIEQpC/luN4TFHnHhtcT3/SsH/kzA+tdBrERIVbkFHRq8lJFWu8KP0a7r9maV0eY2bFqdpOql6kaaYD1fso2iUywzFFMOSF4Bf2URxFtqtnPm1W9Kq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743671451; c=relaxed/simple;
	bh=ZBG0Vv9MN4uDIzYRcVaSDYI9D8YaSDdVM57oQ7JZIXI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zx8Xc6Ij2ANO0l9UgoTte+CBCmq35uVj8Um80acEYyF9Rcq9ZWDSep2i587U2QKIAZ4Vn9iQpqTKYKfIqvgm9JtwSs3AOYdqVgPvs/jLaxtjDZk6bYqGiglsYZCjn/fvluSntzl4bl7p0zPIpDUswk8Jz78/MGtcdjYfap7YTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwVjqdoQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743671450; x=1775207450;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZBG0Vv9MN4uDIzYRcVaSDYI9D8YaSDdVM57oQ7JZIXI=;
  b=MwVjqdoQLUT0JgeZriML4NKjBJRZ6l0L+ddQtF3bL5OxjPM6uZc2RlVe
   TIwas5rcSlqaRB5IjD3mBpz0AdLmU9KY3v80mB1dl4ujzWD2LjVfY1tsy
   n1QN+bXNd3awa11bU9fmC+HLk1X+v1wAc520JMiUTD9+19Ip0EGMIYJEa
   IPmHWz4zF3k62RMjQaxHWM8BSt0CbbHmP+kPfXUgY72Z6fjDpRc4CaSji
   UEphXxsnmevGzSgb8uEUZ7R0L14sW+TkZvq8bOCSZaxqOiwLWJsowwA5z
   kWmDJ+DnsjK1or+C1wXKNod88gyxTBA2/YQzzbB6Y4iX7u/aGoqAt6k7/
   A==;
X-CSE-ConnectionGUID: AVq+PpZyRViLAueWWLL/Ww==
X-CSE-MsgGUID: m+BzlzHBRWqW4ReMUg7yKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="45079400"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="45079400"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 02:10:49 -0700
X-CSE-ConnectionGUID: cyWztgi0SDW/r7dpo4J8xw==
X-CSE-MsgGUID: 8xFd3C6oQ3KpnT1pjpkeyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="131925166"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.152])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 02:10:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 3 Apr 2025 12:10:41 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com, 
    manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com, 
    thomas.richard@bootlin.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v7 1/5] PCI: Refactor capability search into common macros
In-Reply-To: <6075b776-d2be-49d3-8321-e6af66781709@163.com>
Message-ID: <9e9a68b1-8c3a-6132-d4fc-9f7b0b2d3e3a@linux.intel.com>
References: <20250402042020.48681-1-18255117159@163.com> <20250402042020.48681-2-18255117159@163.com> <909653ac-7ba2-9da7-f519-3d849146f433@linux.intel.com> <6075b776-d2be-49d3-8321-e6af66781709@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-560524903-1743671441=:1302"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-560524903-1743671441=:1302
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 2 Apr 2025, Hans Zhang wrote:
> On 2025/4/2 20:42, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 2 Apr 2025, Hans Zhang wrote:
> >=20
> > > Introduce PCI_FIND_NEXT_CAP_TTL and PCI_FIND_NEXT_EXT_CAPABILITY macr=
os
> > > to consolidate duplicate PCI capability search logic found throughout=
 the
> > > driver tree. This refactoring:
> > >=20
> > >    1. Eliminates code duplication in capability scanning routines
> > >    2. Provides a standardized, maintainable implementation
> > >    3. Reduces error-prone copy-paste implementations
> > >    4. Maintains identical functionality to existing code
> > >=20
> > > The macros abstract the low-level capability register scanning while
> > > preserving the existing PCI configuration space access patterns. They=
 will
> > > enable future conversions of multiple capability search implementatio=
ns
> > > across various drivers (e.g., PCI core, controller drivers) to use
> > > this centralized logic.
> > >=20
> > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > ---
> > >   drivers/pci/pci.h             | 81 ++++++++++++++++++++++++++++++++=
+++
> > >   include/uapi/linux/pci_regs.h |  2 +
> > >   2 files changed, 83 insertions(+)
> > >=20
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 2e9cf26a9ee9..f705b8bd3084 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -89,6 +89,87 @@ bool pcie_cap_has_lnkctl(const struct pci_dev *dev=
);
> > >   bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
> > >   bool pcie_cap_has_rtctl(const struct pci_dev *dev);
> > >   +/* Standard Capability finder */
> > > +/**
> > > + * PCI_FIND_NEXT_CAP_TTL - Find a PCI standard capability
> > > + * @read_cfg: Function pointer for reading PCI config space
> > > + * @start: Starting position to begin search
> > > + * @cap: Capability ID to find
> > > + * @args: Arguments to pass to read_cfg function
> > > + *
> > > + * Iterates through the capability list in PCI config space to find
> > > + * the specified capability. Implements TTL (time-to-live) protectio=
n
> > > + * against infinite loops.
> > > + *
> > > + * Returns: Position of the capability if found, 0 otherwise.
> > > + */
> > > +#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)
> > > \
> > > +({=09=09=09=09=09=09=09=09=09\
> > > +=09u8 __pos =3D (start);=09=09=09=09=09=09\
> > > +=09int __ttl =3D PCI_FIND_CAP_TTL;=09=09=09=09=09\
> > > +=09u16 __ent;=09=09=09=09=09=09=09\
> > > +=09u8 __found_pos =3D 0;=09=09=09=09=09=09\
> > > +=09u8 __id;=09=09=09=09=09=09=09\
> > > +=09=09=09=09=09=09=09=09=09\
> > > +=09read_cfg(args, __pos, 1, (u32 *)&__pos);=09=09=09\
> > > +=09=09=09=09=09=09=09=09=09\
> > > +=09while (__ttl--) {=09=09=09=09=09=09\
> > > +=09=09if (__pos < PCI_STD_HEADER_SIZEOF)=09=09=09\
> > > +=09=09=09break;=09=09=09=09=09=09\
> > > +=09=09__pos =3D ALIGN_DOWN(__pos, 4);=09=09=09=09\
> > > +=09=09read_cfg(args, __pos, 2, (u32 *)&__ent);=09=09\
> > > +=09=09__id =3D FIELD_GET(PCI_CAP_ID_MASK, __ent);=09=09\
> > > +=09=09if (__id =3D=3D 0xff)=09=09=09=09=09\
> > > +=09=09=09break;=09=09=09=09=09=09\
> > > +=09=09if (__id =3D=3D (cap)) {=09=09=09=09=09\
> > > +=09=09=09__found_pos =3D __pos;=09=09=09=09\
> > > +=09=09=09break;=09=09=09=09=09=09\
> > > +=09=09}=09=09=09=09=09=09=09\
> > > +=09=09__pos =3D FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);=09\
> >=20
> > Could you please separate the coding style cleanups into own patch that
> > is before the actual move patch. IMO, all those cleanups can be in the
> > same patch.
> >=20
>=20
> Hi Ilpo,
>=20
> Thanks your for reply. I don't understand. Is it like this?

Add a patch before the first patch which does only the cleanups to=20
__pci_find_next_cap_ttl(). The patch that creates PCI_FIND_NEXT_CAP_TTL()=
=20
and converts its PCI core users (most of the patches 1&2) is to be based=20
on top of that cleanup patch.

> #define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)=09=09\
> ({=09=09=09=09=09=09=09=09=09\
> =09int __ttl =3D PCI_FIND_CAP_TTL;=09=09=09=09=09\
> =09u8 __id, __found_pos =3D 0;=09=09=09=09=09\
> =09u8 __pos =3D (start);=09=09=09=09=09=09\
> =09u16 __ent;=09=09=09=09=09=09=09\
> =09=09=09=09=09=09=09=09=09\
> =09read_cfg(args, __pos, 1, (u32 *)&__pos);=09=09=09\
> =09=09=09=09=09=09=09=09=09\
> =09while (__ttl--) {=09=09=09=09=09=09\
> =09=09if (__pos < PCI_STD_HEADER_SIZEOF)=09=09=09\
> =09=09=09break;=09=09=09=09=09=09\
> =09=09=09=09=09=09=09=09=09\
> =09=09__pos =3D ALIGN_DOWN(__pos, 4);=09=09=09=09\
> =09=09read_cfg(args, __pos, 2, (u32 *)&__ent);=09=09\
> =09=09=09=09=09=09=09=09=09\
> =09=09__id =3D FIELD_GET(PCI_CAP_ID_MASK, __ent);=09=09\
> =09=09if (__id =3D=3D 0xff)=09=09=09=09=09\
> =09=09=09break;=09=09=09=09=09=09\
> =09=09=09=09=09=09=09=09=09\
> =09=09if (__id =3D=3D (cap)) {=09=09=09=09=09\
> =09=09=09__found_pos =3D __pos;=09=09=09=09\
> =09=09=09break;=09=09=09=09=09=09\
> =09=09}=09=09=09=09=09=09=09\
> =09=09=09=09=09=09=09=09=09\
> =09=09__pos =3D FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);=09\
> =09}=09=09=09=09=09=09=09=09\
> =09__found_pos;=09=09=09=09=09=09=09\
> })
>=20
> > You also need to add #includes for the defines you now started to use.
> >=20
>=20
> Is that what you mean?
>=20
> +#include <linux/bitfield.h>
> +#include <linux/align.h>
> +#include <uapi/linux/pci_regs.h>

Almost, including pci_regs.h is not strictly necessary as linux/pci.h will=
=20
always pull that one in (not that it would hurt).

Also, sort the includes alphabetically.

--
 i.

>=20
> Best regards,
> Hans
>=20
> > > +=09}=09=09=09=09=09=09=09=09\
> > > +=09__found_pos;=09=09=09=09=09=09=09\
> > > +})
> > > +
> > > +/* Extended Capability finder */
> > > +/**
> > > + * PCI_FIND_NEXT_EXT_CAPABILITY - Find a PCI extended capability
> > > + * @read_cfg: Function pointer for reading PCI config space
> > > + * @start: Starting position to begin search (0 for initial search)
> > > + * @cap: Extended capability ID to find
> > > + * @args: Arguments to pass to read_cfg function
> > > + *
> > > + * Searches the extended capability space in PCI config registers
> > > + * for the specified capability. Implements TTL protection against
> > > + * infinite loops using a calculated maximum search count.
> > > + *
> > > + * Returns: Position of the capability if found, 0 otherwise.
> > > + */
> > > +#define PCI_FIND_NEXT_EXT_CAPABILITY(read_cfg, start, cap, args...)
> > > \
> > > +({
> > > \
> > > +=09u16 __pos =3D (start) ?: PCI_CFG_SPACE_SIZE;
> > > \
> > > +=09u16 __found_pos =3D 0;
> > > \
> > > +=09int __ttl, __ret;
> > > \
> > > +=09u32 __header;
> > > \
> > > +
> > > \
> > > +=09__ttl =3D (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> > > \
> > > +=09while (__ttl-- > 0 && __pos >=3D PCI_CFG_SPACE_SIZE) {
> > > \
> > > +=09=09__ret =3D read_cfg(args, __pos, 4, &__header);
> > > \
> > > +=09=09if (__ret !=3D PCIBIOS_SUCCESSFUL)
> > > \
> > > +=09=09=09break;
> > > \
> > > +
> > > \
> > > +=09=09if (__header =3D=3D 0)
> > > \
> > > +=09=09=09break;
> > > \
> > > +
> > > \
> > > +=09=09if (PCI_EXT_CAP_ID(__header) =3D=3D (cap) && __pos !=3D start)=
 {
> > > \
> > > +=09=09=09__found_pos =3D __pos;
> > > \
> > > +=09=09=09break;
> > > \
> > > +=09=09}
> > > \
> > > +
> > > \
> > > +=09=09__pos =3D PCI_EXT_CAP_NEXT(__header);
> > > \
> > > +=09}
> > > \
> > > +=09__found_pos;
> > > \
> > > +})
> > > +
> > >   /* Functions internal to the PCI core code */
> > >     #ifdef CONFIG_DMI
> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_r=
egs.h
> > > index 3445c4970e4d..a11ebbab99fc 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -206,6 +206,8 @@
> > >   /* 0x48-0x7f reserved */
> > >     /* Capability lists */
> > > +#define PCI_CAP_ID_MASK=09=090x00ff
> > > +#define PCI_CAP_LIST_NEXT_MASK=090xff00
> > >     #define PCI_CAP_LIST_ID=09=090=09/* Capability ID */
> > >   #define  PCI_CAP_ID_PM=09=090x01=09/* Power Management */
> > >=20
> >=20
>=20
--8323328-560524903-1743671441=:1302--

