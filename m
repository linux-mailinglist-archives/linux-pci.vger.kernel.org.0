Return-Path: <linux-pci+bounces-25158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4252BA78DCC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 14:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46A216C367
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1209623771E;
	Wed,  2 Apr 2025 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3MKtqYk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64134235360;
	Wed,  2 Apr 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595497; cv=none; b=fCcWH0dATDUse+QyWRAcZiVWRpOeUGMc88xGy9ma9p45EPs7gOD1I12eVYbhjuKPFmqAb/Gm3tPkIEuJRsgkoINIWJnjb7e33K5U5yaL1B4ZfeTzY/8O5wyArVS5qQOXOwkNxtSatOPSnLDg36M02GMIeDEGKa7s5T24kAmHqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595497; c=relaxed/simple;
	bh=gyT77WPdhw/G+FzvEtM14D9rh108cqFsFkXIeMboHpk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JWRgjwyqERYvPwHuSPp7EL8u5HEMifejY8WWDYtOgNbQ1wOBixMvrdJTRAmEDdaPuMMRB6/Iu3HuZFpOcA00cdfxqtXOta34JKnU0CtRG1MwHHyK2SHE8YIBrXiS7ZMBea1nY4YRFyIgamt+3rCJ73mEA7dycIl98ej1HgIb3wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3MKtqYk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743595496; x=1775131496;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gyT77WPdhw/G+FzvEtM14D9rh108cqFsFkXIeMboHpk=;
  b=b3MKtqYk4Uw7c8jXV5qyJA/6kAVKBrfoHPypzlJiGM8R+X6qtDwMzl/r
   NWvJBKu376norD0FmuOrktu4APSlC5EYJvIWSIPbFjjm+LaHQWmk5BSGF
   s6taeddfGvRyux2VmptXRfG48zQF3l+2w+Cl2NkGEb1qBaHULCIAA6hxN
   NNbNdZ8bMUMyUkoGFXmp3flaWtH8t/CCFSaElvS9kZruzf7T1HUqh8KZz
   Fy4tcWVOUqzC//WzYgaOZ8prXmWB4f9uSLC3wSoyQ4GBubSLMB9zIHIqV
   H/U43c5qXgGdtRPxTQ2+Un/1FuVa87l4zKZdYlCpEyXvsNH+LB1oxLs3J
   A==;
X-CSE-ConnectionGUID: 0bQWR08xQrKdzfkdA8xtRw==
X-CSE-MsgGUID: sjvdT33mRdeonSkTIRW5pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="48620593"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="48620593"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:04:55 -0700
X-CSE-ConnectionGUID: 0teg8t3fR3OxKzSxWSsNqA==
X-CSE-MsgGUID: ZxrKiiIpTdqd/QP/Vs14QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="126579557"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.40])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:04:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 2 Apr 2025 15:04:44 +0300 (EEST)
To: =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>
cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org, 
    dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rodrigo Vivi <rodrigo.vivi@intel.com>, 
    Michal Wajdeczko <michal.wajdeczko@intel.com>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
    Maxime Ripard <mripard@kernel.org>, 
    Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
    Simona Vetter <simona@ffwll.ch>, Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v6 5/6] PCI: Allow drivers to control VF BAR size
In-Reply-To: <fnisbg2bng3f5rkcoc7duzi34g7hghcqgzzehc5v6yb772kdj4@rcjs4mftf7s6>
Message-ID: <5de3951c-01f1-3892-09e1-f7d30a4e048d@linux.intel.com>
References: <20250320110854.3866284-1-michal.winiarski@intel.com> <20250320110854.3866284-6-michal.winiarski@intel.com> <7374beef-46ed-ab53-ccb5-48565526545c@linux.intel.com> <fnisbg2bng3f5rkcoc7duzi34g7hghcqgzzehc5v6yb772kdj4@rcjs4mftf7s6>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-679664592-1743595484=:952"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-679664592-1743595484=:952
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 2 Apr 2025, Micha=C5=82 Winiarski wrote:

> On Wed, Mar 26, 2025 at 05:22:50PM +0200, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 20 Mar 2025, Micha=C5=82 Winiarski wrote:
> >=20
> > > Drivers could leverage the fact that the VF BAR MMIO reservation is
> > > created for total number of VFs supported by the device by resizing t=
he
> > > BAR to larger size when smaller number of VFs is enabled.
> > >=20
> > > Add a pci_iov_vf_bar_set_size() function to control the size and a
> > > pci_iov_vf_bar_get_sizes() helper to get the VF BAR sizes that will
> > > allow up to num_vfs to be successfully enabled with the current
> > > underlying reservation size.
> > >=20
> > > Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>


> > > +/**
> > > + * pci_iov_vf_bar_get_sizes - get VF BAR sizes allowing to create up=
 to num_vfs
> > > + * @dev: the PCI device
> > > + * @resno: the resource number
> > > + * @num_vfs: number of VFs
> > > + *
> > > + * Get the sizes of a VF resizable BAR that can be accommodated with=
in the
> > > + * resource that reserves the MMIO space if num_vfs are enabled.
> >=20
> > I'd rephrase to:
> >=20
> > Get the sizes of a VF resizable BAR that can be accommodate @num_vfs=20
> > within the currently assigned size of the resource @resno.
>=20
> Ok.

I have small grammar error in that:

"can be accomodate" -> "can accomodate"

> > > + * defined in the spec (bit 0=3D1MB, bit 31=3D128TB).
> > > + */
> > > +u32 pci_iov_vf_bar_get_sizes(struct pci_dev *dev, int resno, int num=
_vfs)
> > > +{
> > > +=09resource_size_t size;
> > > +=09u32 sizes;
> > > +=09int i;
> > > +
> > > +=09sizes =3D pci_rebar_get_possible_sizes(dev, resno);
> > > +=09if (!sizes)
> > > +=09=09return 0;
> > > +
> > > +=09while (sizes > 0) {
> > > +=09=09i =3D __fls(sizes);
> > > +=09=09size =3D pci_rebar_size_to_bytes(i);
> > > +
> > > +=09=09if (size * num_vfs <=3D pci_resource_len(dev, resno))
> > > +=09=09=09break;
> > > +
> > > +=09=09sizes &=3D ~BIT(i);
> > > +=09}
> >=20
> > Couldn't this be handled without a loop:
> >=20
> > =09bar_sizes =3D (round_up(pci_resource_len(dev, resno) / num_vfs) - 1)=
 >>
> > =09=09    ilog2(SZ_1M);
> >=20
> > =09sizes &=3D bar_sizes;
> >=20
> > (Just to given an idea, I wrote this into the email so it might contain=
=20
> > some off-by-one errors or like).
>=20
> I think the division will need to be wrapped with something like do_div
> (because IIUC, we have 32bit architectures where resource_size_t is
> u64).
>=20
> But yeah, we can drop the loop, turning it into something like this:
>=20
> =09vf_len =3D pci_resource_len(dev, resno);
> =09do_div(vf_len, num_vfs);
> =09sizes =3D (roundup_pow_of_two(vf_len + 1) - 1) >> ilog2(SZ_1M);

Yes, good point, 64-bit division is required.

--=20
 i.

--8323328-679664592-1743595484=:952--

