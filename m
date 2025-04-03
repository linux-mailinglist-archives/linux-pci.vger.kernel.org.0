Return-Path: <linux-pci+bounces-25226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2CA79FFC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 11:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615E93A13A9
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8982224891;
	Thu,  3 Apr 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iejpTnim"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C218C910;
	Thu,  3 Apr 2025 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743672264; cv=none; b=lwYeO8phx6toZbl4Eqp+n/vAW5dStQIz9K5ylmvj+8udTOTqMxosZwJLYMUysGO4E18pe4MzubCN4hmkZrpObQXicYXpKrjkKu8aE70B5RGuIRgcrtbKx2UUVo8HELuHxO4rlFJe21yK01IuXmo2o36rpd4Gql2pqtWs8fJWE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743672264; c=relaxed/simple;
	bh=7VCT8HrgotJu0FeOR9DgnBYiH6sAi4gtpRg/UAtuitk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PnG4XNw34ZomxncwKvGVhGd6ZWY85qKz2IxDHiMdQxmUL706NQBYyHVS6ZOFLy3quGzTYs2dJValCwnnYTVLd6NpgB6IqkqJ4jewW5Jh2r3NbTaoph9IUQnD5Dai0DgiAf4xzHkeu4AVzGK124q8l+G00/UcQF2IlCGHSIMAWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iejpTnim; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743672263; x=1775208263;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7VCT8HrgotJu0FeOR9DgnBYiH6sAi4gtpRg/UAtuitk=;
  b=iejpTnimZJQ+/jR2jcEqw7EwiGr2ACplR1wSk5xqUiOPiejUXl9eUJSr
   Ic4jFsB48QV0nk155kapL0Kd/dsUYqZa8b+XS/Uj1Emetpj8IpeSzA9S4
   G6gR3OrneOWFz06CU+3aMjsgPF3R1KXpmRQsIWA3QQFp+RC0ypJx+Xwwf
   G1G+0tRmP2KPsrqazIBRp0YMoXEXdTwSGOxX9VVJ9OdT0utQRjidj3aos
   MkfVDhPYfyPMky+rBKhnu23Uyv2yRSFEF4T7LYpocCJqIpkkItD7TjkYG
   4wOgIm0oaPRdMYPvgczmHoV2UxO+hK0x2nHsHLjf0zcXJ7fe8e9tz48bU
   A==;
X-CSE-ConnectionGUID: tw7q356zR+iLozSBxqncyg==
X-CSE-MsgGUID: 3/9vcV69QCm/ZvP3lMdC5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44963074"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="44963074"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 02:24:13 -0700
X-CSE-ConnectionGUID: O4CbjtLxTYWttoyiGo7z2g==
X-CSE-MsgGUID: UefEEqGFQd+rZ5+ctpbh4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="127452098"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.152])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 02:24:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 3 Apr 2025 12:24:02 +0300 (EEST)
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
Subject: Re: [PATCH v7 2/6] PCI: Add a helper to convert between VF BAR number
 and IOV resource
In-Reply-To: <20250402141122.2818478-3-michal.winiarski@intel.com>
Message-ID: <1355b321-da51-62fb-1696-290b87fe783b@linux.intel.com>
References: <20250402141122.2818478-1-michal.winiarski@intel.com> <20250402141122.2818478-3-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1835209759-1743672242=:1302"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1835209759-1743672242=:1302
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 2 Apr 2025, Micha=C5=82 Winiarski wrote:

> There are multiple places where conversions between IOV resources and
> corresponding VF BAR numbers are done.
>=20
> Extract the logic to pci_resource_num_from_vf_bar() and
> pci_resource_num_to_vf_bar() helpers.
>=20
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/pci/iov.c       | 26 ++++++++++++++++----------
>  drivers/pci/pci.h       | 19 +++++++++++++++++++
>  drivers/pci/setup-bus.c |  3 ++-
>  3 files changed, 37 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 8bdc0829f847b..3d5da055c3dc1 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -151,7 +151,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev =
*dev, int resno)
>  =09if (!dev->is_physfn)
>  =09=09return 0;
> =20
> -=09return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
> +=09return dev->sriov->barsz[pci_resource_num_to_vf_bar(resno)];
>  }
> =20
>  static void pci_read_vf_config_common(struct pci_dev *virtfn)
> @@ -342,12 +342,14 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  =09virtfn->multifunction =3D 0;
> =20
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> -=09=09res =3D &dev->resource[i + PCI_IOV_RESOURCES];
> +=09=09int idx =3D pci_resource_num_from_vf_bar(i);
> +
> +=09=09res =3D &dev->resource[idx];
>  =09=09if (!res->parent)
>  =09=09=09continue;
>  =09=09virtfn->resource[i].name =3D pci_name(virtfn);
>  =09=09virtfn->resource[i].flags =3D res->flags;
> -=09=09size =3D pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
> +=09=09size =3D pci_iov_resource_size(dev, idx);
>  =09=09resource_set_range(&virtfn->resource[i],
>  =09=09=09=09   res->start + size * id, size);
>  =09=09rc =3D request_resource(res, &virtfn->resource[i]);
> @@ -644,8 +646,10 @@ static int sriov_enable(struct pci_dev *dev, int nr_=
virtfn)
> =20
>  =09nres =3D 0;
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> -=09=09bars |=3D (1 << (i + PCI_IOV_RESOURCES));
> -=09=09res =3D &dev->resource[i + PCI_IOV_RESOURCES];
> +=09=09int idx =3D pci_resource_num_from_vf_bar(i);
> +
> +=09=09bars |=3D (1 << idx);
> +=09=09res =3D &dev->resource[idx];
>  =09=09if (res->parent)
>  =09=09=09nres++;
>  =09}
> @@ -811,8 +815,10 @@ static int sriov_init(struct pci_dev *dev, int pos)
> =20
>  =09nres =3D 0;
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> -=09=09res =3D &dev->resource[i + PCI_IOV_RESOURCES];
> -=09=09res_name =3D pci_resource_name(dev, i + PCI_IOV_RESOURCES);
> +=09=09int idx =3D pci_resource_num_from_vf_bar(i);
> +
> +=09=09res =3D &dev->resource[idx];
> +=09=09res_name =3D pci_resource_name(dev, idx);
> =20
>  =09=09/*
>  =09=09 * If it is already FIXED, don't change it, something
> @@ -871,7 +877,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  =09dev->is_physfn =3D 0;
>  failed:
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> -=09=09res =3D &dev->resource[i + PCI_IOV_RESOURCES];
> +=09=09res =3D &dev->resource[pci_resource_num_from_vf_bar(i)];
>  =09=09res->flags =3D 0;
>  =09}
> =20
> @@ -933,7 +939,7 @@ static void sriov_restore_state(struct pci_dev *dev)
>  =09pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, ctrl);
> =20
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++)
> -=09=09pci_update_resource(dev, i + PCI_IOV_RESOURCES);
> +=09=09pci_update_resource(dev, pci_resource_num_from_vf_bar(i));
> =20
>  =09pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgs=
z);
>  =09pci_iov_set_numvfs(dev, iov->num_VFs);
> @@ -999,7 +1005,7 @@ void pci_iov_update_resource(struct pci_dev *dev, in=
t resno)
>  {
>  =09struct pci_sriov *iov =3D dev->is_physfn ? dev->sriov : NULL;
>  =09struct resource *res =3D pci_resource_n(dev, resno);
> -=09int vf_bar =3D resno - PCI_IOV_RESOURCES;
> +=09int vf_bar =3D pci_resource_num_to_vf_bar(resno);
>  =09struct pci_bus_region region;
>  =09u16 cmd;
>  =09u32 new;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index adc54bb2c8b34..f44840ee3c327 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -693,6 +693,15 @@ static inline bool pci_resource_is_iov(int resno)
>  {
>  =09return resno >=3D PCI_IOV_RESOURCES && resno <=3D PCI_IOV_RESOURCE_EN=
D;
>  }
> +static inline int pci_resource_num_from_vf_bar(int resno)
> +{
> +=09return resno + PCI_IOV_RESOURCES;
> +}
> +
> +static inline int pci_resource_num_to_vf_bar(int resno)
> +{
> +=09return resno - PCI_IOV_RESOURCES;
> +}
>  extern const struct attribute_group sriov_pf_dev_attr_group;
>  extern const struct attribute_group sriov_vf_dev_attr_group;
>  #else
> @@ -717,6 +726,16 @@ static inline bool pci_resource_is_iov(int resno)
>  {
>  =09return false;
>  }
> +static inline int pci_resource_num_from_vf_bar(int resno)
> +{
> +=09WARN_ON_ONCE(1);
> +=09return -ENODEV;
> +}
> +static inline int pci_resource_num_to_vf_bar(int resno)
> +{
> +=09WARN_ON_ONCE(1);
> +=09return -ENODEV;
> +}
>  #endif /* CONFIG_PCI_IOV */
> =20
>  #ifdef CONFIG_PCIE_TPH
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 54d6f4fa3ce16..281121449fc0b 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1885,7 +1885,8 @@ static int iov_resources_unassigned(struct pci_dev =
*dev, void *data)
>  =09bool *unassigned =3D data;
> =20
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> -=09=09struct resource *r =3D &dev->resource[i + PCI_IOV_RESOURCES];
> +=09=09int idx =3D pci_resource_num_from_vf_bar(i);
> +=09=09struct resource *r =3D &dev->resource[idx];
>  =09=09struct pci_bus_region region;
> =20
>  =09=09/* Not assigned or rejected by kernel? */
>=20

Thanks, looks more readable now.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1835209759-1743672242=:1302--

