Return-Path: <linux-pci+bounces-14187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A866099841C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 12:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF801F2302D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468621C0DF5;
	Thu, 10 Oct 2024 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KydmEq3D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27421A3038;
	Thu, 10 Oct 2024 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557229; cv=none; b=WIvmyxNOAwFEeJ+7Z+fDNPaVRZwf/3Z3ClF8FxqeFsX/mHS8TtzNhMnob5n0UGSwjg3NnlU/AnVVAM3/jXwcjpEbJJz7VaZuda4eYtfU2RXA0jqu1MJapONXX7M2RK6GRvBt1kK8p6x9FkJnHJdrT/UeLuduBz+OWfo4w563Nq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557229; c=relaxed/simple;
	bh=YMDy6bGmfOxER1Wv+tP5jbJx8zCzdbAPXTAuNo4sIjY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KFW0Rwm95X96/fcvXrSKzVrtZeTVCadzBr1qOdEADfuGnMYehmQCYQk9xyXvOEQYCyzerLueXOkgN0i84425u849rpOgwCJowZ98+25g3BQSNNrZ9q2o9sAG1KVdaywg7osd51vSIooEnQfpS9y3ItGMFHfdtOEFaXMyGDfAm3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KydmEq3D; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728557228; x=1760093228;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YMDy6bGmfOxER1Wv+tP5jbJx8zCzdbAPXTAuNo4sIjY=;
  b=KydmEq3D2MP89YVsk5vtPIfiXZOJqDXZbQOYTZ59v5fIdtyjLa8ldaeL
   B6fs9XzoDwlcJjEcOa4P35tQSorSDXQ6TlxJGqTstyn4MY/Mj4z4xExO5
   lfIl0ePlpGhVx24qbTv+cDt7vMO3UlFJ1lgse3+F9P0XO2AL7Zlh5XhQi
   HLmXSzJ11IH5ssCgwDW2tiniaZ+62yK5v213DxITUz5H0zMQgCJVbktb0
   Qf6zp/2AQQI1jjjrldxfe/OpKwkM7ty90ca9zrS4oI6S+cp5Hlp8YCe4c
   09CBXuyZ0GXNdCdhIJuhKjlsfkqNVs/ON+8+pSP+ibDSzCf1rZX0mY+EH
   Q==;
X-CSE-ConnectionGUID: ZbXzTLOLQy2ZonduFVz8/w==
X-CSE-MsgGUID: narqm6z+R56k61powT6zRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31695373"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="31695373"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 03:47:07 -0700
X-CSE-ConnectionGUID: eLfEQUBGQ3iNLT3dBbYACw==
X-CSE-MsgGUID: dXDbgdTHR06dVma7SeuQsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81357904"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 03:47:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 10 Oct 2024 13:46:57 +0300 (EEST)
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
Subject: Re: [PATCH v3 2/5] PCI: Add a helper to identify IOV resources
In-Reply-To: <20241010103203.382898-3-michal.winiarski@intel.com>
Message-ID: <f360f00e-2282-ff6b-a390-697f8acd7917@linux.intel.com>
References: <20241010103203.382898-1-michal.winiarski@intel.com> <20241010103203.382898-3-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-665666153-1728557217=:12246"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-665666153-1728557217=:12246
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 10 Oct 2024, Micha=C5=82 Winiarski wrote:

> There are multiple places where special handling is required for IOV
> resources.
> Extract it to a helper and drop a few ifdefs.
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/pci/pci.h       | 18 ++++++++++++++----
>  drivers/pci/setup-bus.c |  5 +----
>  drivers/pci/setup-res.c |  4 +---
>  3 files changed, 16 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 14d00ce45bfa9..c55f2d7a4f37e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -580,6 +580,10 @@ void pci_iov_update_resource(struct pci_dev *dev, in=
t resno);
>  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int re=
sno);
>  void pci_restore_iov_state(struct pci_dev *dev);
>  int pci_iov_bus_range(struct pci_bus *bus);
> +static inline bool pci_resource_is_iov(int resno)
> +{
> +=09return resno >=3D PCI_IOV_RESOURCES && resno <=3D PCI_IOV_RESOURCE_EN=
D;
> +}
>  extern const struct attribute_group sriov_pf_dev_attr_group;
>  extern const struct attribute_group sriov_vf_dev_attr_group;
>  #else
> @@ -589,12 +593,20 @@ static inline int pci_iov_init(struct pci_dev *dev)
>  }
>  static inline void pci_iov_release(struct pci_dev *dev) { }
>  static inline void pci_iov_remove(struct pci_dev *dev) { }
> +static inline void pci_iov_update_resource(struct pci_dev *dev, int resn=
o) { }
> +static inline resource_size_t pci_sriov_resource_alignment(struct pci_de=
v *dev, int resno)
> +{
> +=09return 0;
> +}
>  static inline void pci_restore_iov_state(struct pci_dev *dev) { }
>  static inline int pci_iov_bus_range(struct pci_bus *bus)
>  {
>  =09return 0;
>  }
> -
> +static inline bool pci_resource_is_iov(int resno)
> +{
> +=09return false;
> +}
>  #endif /* CONFIG_PCI_IOV */
> =20
>  #ifdef CONFIG_PCIE_PTM
> @@ -616,12 +628,10 @@ unsigned long pci_cardbus_resource_alignment(struct=
 resource *);
>  static inline resource_size_t pci_resource_alignment(struct pci_dev *dev=
,
>  =09=09=09=09=09=09     struct resource *res)
>  {
> -#ifdef CONFIG_PCI_IOV
>  =09int resno =3D res - dev->resource;
> =20
> -=09if (resno >=3D PCI_IOV_RESOURCES && resno <=3D PCI_IOV_RESOURCE_END)
> +=09if (pci_resource_is_iov(resno))
>  =09=09return pci_sriov_resource_alignment(dev, resno);
> -#endif
>  =09if (dev->class >> 8 =3D=3D PCI_CLASS_BRIDGE_CARDBUS)
>  =09=09return pci_cardbus_resource_alignment(res);
>  =09return resource_alignment(res);
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 23082bc0ca37a..8909948bc9a9f 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1093,17 +1093,14 @@ static int pbus_size_mem(struct pci_bus *bus, uns=
igned long mask,
>  =09=09=09     (r->flags & mask) !=3D type3))
>  =09=09=09=09continue;
>  =09=09=09r_size =3D resource_size(r);
> -#ifdef CONFIG_PCI_IOV
>  =09=09=09/* Put SRIOV requested res to the optional list */
> -=09=09=09if (realloc_head && i >=3D PCI_IOV_RESOURCES &&
> -=09=09=09=09=09i <=3D PCI_IOV_RESOURCE_END) {
> +=09=09=09if (realloc_head && pci_resource_is_iov(i)) {
>  =09=09=09=09add_align =3D max(pci_resource_alignment(dev, r), add_align)=
;
>  =09=09=09=09r->end =3D r->start - 1;
>  =09=09=09=09add_to_list(realloc_head, dev, r, r_size, 0 /* Don't care */=
);
>  =09=09=09=09children_add_size +=3D r_size;
>  =09=09=09=09continue;
>  =09=09=09}
> -#endif

Heh, I realized I've made pretty much the same patch a few days back...

Please leave empty lines around this SRIOV / optional resource.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


>  =09=09=09/*
>  =09=09=09 * aligns[0] is for 1MB (since bridge memory
>  =09=09=09 * windows are always at least 1MB aligned), so
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index c6d933ddfd464..e2cf79253ebda 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -127,10 +127,8 @@ void pci_update_resource(struct pci_dev *dev, int re=
sno)
>  {
>  =09if (resno <=3D PCI_ROM_RESOURCE)
>  =09=09pci_std_update_resource(dev, resno);
> -#ifdef CONFIG_PCI_IOV
> -=09else if (resno >=3D PCI_IOV_RESOURCES && resno <=3D PCI_IOV_RESOURCE_=
END)
> +=09else if (pci_resource_is_iov(resno))
>  =09=09pci_iov_update_resource(dev, resno);
> -#endif
>  }
> =20
>  int pci_claim_resource(struct pci_dev *dev, int resource)
>=20
--8323328-665666153-1728557217=:12246--

