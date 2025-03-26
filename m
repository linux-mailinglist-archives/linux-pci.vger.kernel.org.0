Return-Path: <linux-pci+bounces-24772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20848A7195E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 15:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4441685DF
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635461C8638;
	Wed, 26 Mar 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AmcP9Hd+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B81DEFD7;
	Wed, 26 Mar 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000392; cv=none; b=ak88rf3K2amU5n6eGKzzdZJSn/WPQX4lCLABW3COaeNEBZP0SyQbeIawLKvD8FK4dv3n8LpNbiJYVFlE/C9SzERFjobo3YoOK1PgbWbU5AiocDnoE2Pd/uLwrjQVsHfQ6m7+mMHB3nERhzU+m7DKsbDlcSoiEvdVVUu5J+2mPDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000392; c=relaxed/simple;
	bh=Cc7wktbOWDJBZ+sIqX0WmKXii8fobhHZDsEO0msqRKU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KO4C4zP9g4xILpIgycKHsr8sfzkjhGQnnNIVc5M/ZVSQr5gdCv0jLS5guj8v+ZxsDRnaWEPCFRNg1dQDW4bsTyir+OGiFOZohcGfsLZgq08A4VdMQUqZUMdX6BdlkR5zWGfBWsAqzIyFYiRMDvKtqD8A4q9EzRfe3Ye84dWONaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AmcP9Hd+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743000390; x=1774536390;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Cc7wktbOWDJBZ+sIqX0WmKXii8fobhHZDsEO0msqRKU=;
  b=AmcP9Hd+FjaGYJ1uRGhpBmZ+sulEcU0uzSkItEeok5GS0NkCzuMLBu/4
   UV7TBSK5/iqtvTbec+WVbwoEtbdc7gz9J55h5POhNN2F6AVJW98SLvz4w
   aHD/sNYm5G0l1l6Az1+VZUfK3oz49h1FZJZpD8J7ha1jDv6f/xYN+JKp9
   InSllFMDQQr5cbmtgqrlm6oCs8a1dLtRqwBFrx6yOwOnGe8gEgKFeN1oo
   P5zFBGWthbvI3DoCARDB5e+6WhkNG+yAOpEm7DkLWZFLYrlSub80Vl1aP
   FF2EkzYC3QtWjWNToAp5pP0Gd5kJZAEezjLxbngjEzR8WuSrknJgwPuyq
   Q==;
X-CSE-ConnectionGUID: TfmwU6AfQkm3yk1Cn3vmyg==
X-CSE-MsgGUID: Nnn2h0xYQkKPLNDXEwnhjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="31898297"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="31898297"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 07:46:29 -0700
X-CSE-ConnectionGUID: s+ipq+BcQTq9kbQs3QqtxQ==
X-CSE-MsgGUID: LBm8mf+MSyyjbS37H75K2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124759051"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 07:46:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 26 Mar 2025 16:46:19 +0200 (EET)
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
Subject: Re: [PATCH v6 2/6] PCI: Add a helper to convert between VF BAR number
 and IOV resource
In-Reply-To: <20250320110854.3866284-3-michal.winiarski@intel.com>
Message-ID: <fd94c15d-7fcc-c9db-8af0-868c15bc34a3@linux.intel.com>
References: <20250320110854.3866284-1-michal.winiarski@intel.com> <20250320110854.3866284-3-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1096444980-1743000379=:942"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1096444980-1743000379=:942
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 20 Mar 2025, Micha=C5=82 Winiarski wrote:

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
>  drivers/pci/iov.c       | 22 ++++++++++++----------
>  drivers/pci/pci.h       | 19 +++++++++++++++++++
>  drivers/pci/setup-bus.c |  3 ++-
>  3 files changed, 33 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index bf95387993cd5..985ea11339c45 100644
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
> @@ -322,12 +322,13 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  =09virtfn->multifunction =3D 0;
> =20
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> -=09=09res =3D &dev->resource[i + PCI_IOV_RESOURCES];
> +=09=09res =3D &dev->resource[pci_resource_num_from_vf_bar(i)];
>  =09=09if (!res->parent)
>  =09=09=09continue;
>  =09=09virtfn->resource[i].name =3D pci_name(virtfn);
>  =09=09virtfn->resource[i].flags =3D res->flags;
> -=09=09size =3D pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
> +=09=09size =3D pci_iov_resource_size(dev,
> +=09=09=09=09=09     pci_resource_num_from_vf_bar(i));
>  =09=09resource_set_range(&virtfn->resource[i],
>  =09=09=09=09   res->start + size * id, size);
>  =09=09rc =3D request_resource(res, &virtfn->resource[i]);
> @@ -624,8 +625,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_v=
irtfn)
> =20
>  =09nres =3D 0;
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> -=09=09bars |=3D (1 << (i + PCI_IOV_RESOURCES));
> -=09=09res =3D &dev->resource[i + PCI_IOV_RESOURCES];
> +=09=09bars |=3D (1 << pci_resource_num_from_vf_bar(i));
> +=09=09res =3D &dev->resource[pci_resource_num_from_vf_bar(i)];
>  =09=09if (res->parent)
>  =09=09=09nres++;
>  =09}
> @@ -791,8 +792,9 @@ static int sriov_init(struct pci_dev *dev, int pos)
> =20
>  =09nres =3D 0;
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> -=09=09res =3D &dev->resource[i + PCI_IOV_RESOURCES];
> -=09=09res_name =3D pci_resource_name(dev, i + PCI_IOV_RESOURCES);
> +=09=09res =3D &dev->resource[pci_resource_num_from_vf_bar(i)];
> +=09=09res_name =3D pci_resource_name(dev,
> +=09=09=09=09=09     pci_resource_num_from_vf_bar(i));

All these get easier to read if you add (same comment for the cases=20
above):

=09=09int idx =3D pci_resource_num_from_vf_bar(i);

> =20
>  =09=09/*
>  =09=09 * If it is already FIXED, don't change it, something
> @@ -851,7 +853,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  =09dev->is_physfn =3D 0;
>  failed:
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> -=09=09res =3D &dev->resource[i + PCI_IOV_RESOURCES];
> +=09=09res =3D &dev->resource[pci_resource_num_from_vf_bar(i)];
>  =09=09res->flags =3D 0;
>  =09}
> =20
> @@ -913,7 +915,7 @@ static void sriov_restore_state(struct pci_dev *dev)
>  =09pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, ctrl);
> =20
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++)
> -=09=09pci_update_resource(dev, i + PCI_IOV_RESOURCES);
> +=09=09pci_update_resource(dev, pci_resource_num_from_vf_bar(i));
> =20
>  =09pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgs=
z);
>  =09pci_iov_set_numvfs(dev, iov->num_VFs);
> @@ -979,7 +981,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int=
 resno)
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
> index 54d6f4fa3ce16..55e91ba1e74a2 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1885,7 +1885,8 @@ static int iov_resources_unassigned(struct pci_dev =
*dev, void *data)
>  =09bool *unassigned =3D data;
> =20
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> -=09=09struct resource *r =3D &dev->resource[i + PCI_IOV_RESOURCES];
> +=09=09struct resource *r =3D
> +=09=09=09&dev->resource[pci_resource_num_from_vf_bar(i)];

I'd add int idx here as well.

>  =09=09struct pci_bus_region region;
> =20
>  =09=09/* Not assigned or rejected by kernel? */
>=20

--=20
 i.

--8323328-1096444980-1743000379=:942--

