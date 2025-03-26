Return-Path: <linux-pci+bounces-24776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D762A719BA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 16:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FB6175AED
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 14:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4496A1B3950;
	Wed, 26 Mar 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNUyq96g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5581547C9;
	Wed, 26 Mar 2025 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001109; cv=none; b=TebWNzuZ0tQIIBInUbaEhX5O2Q3UVDGS82dSwr16FFyRpzbJmzKZv3swMtoYiQqtq0MtgtUj+rek+JR57cbHU6848wPwb5a9Rhdjk4F2q3X6VjqwyBRaVvJFW/uFwL9IXSZiASwyLKQ0ixqdNo0MrU45m1Ff5tjZ7PXfYB0eZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001109; c=relaxed/simple;
	bh=96LiUBQe4hIaEOtxzADb9NSaDtEYTehbHxTiVpODfk0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S0nuWomv6OQt1eyFG6ZMYQFPsr06pdYwfK1ggYzlEeoKrprtlssS7ED3xY0tnSWMa5Dsbo4kuDHWImDU/tMmlx1t391rMhYYzsjmvoe+HG6sCPDh03fpa4k/liDnlGwNOgxhdZlUprWq7qgv3sqRdSc16ELYu7JCl7tozH43TgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNUyq96g; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743001108; x=1774537108;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=96LiUBQe4hIaEOtxzADb9NSaDtEYTehbHxTiVpODfk0=;
  b=MNUyq96g68+l39qBRkH2Z+Nmj08aAqwfDStQQ8iwE68H/AnBR36AuPzL
   CDHhqbqhL+8DvHg+kjURX3vE1tt9HoXNnMB8Xs0XMDrnrkcmwbeTqZjMF
   MDrE+7/JJN2DCg/axLQ6om0p5Y4L3PMbjEFzdLGzWA1o7Bn6JSX1nL29T
   yNrcwrVFmD2WsgvKGQzEIdCQlmXqLO6QQJfXBT1vMnX0Fl9vYr7qORaJT
   IJZv4QGdNx4+y3looBAkijUSUbcarokfywJLRJT0qktCq9pv9Vfd0st6l
   TovPZGLZbKpCHPLpDBPiC6+2QBs27ejldaBZtGlFCf7TqG4ij5apSNt2n
   g==;
X-CSE-ConnectionGUID: QrsWZDJhTSOoh+Dc3TI5Yg==
X-CSE-MsgGUID: trz2bM9SThauTB5JMVQW5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44477471"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="44477471"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 07:58:23 -0700
X-CSE-ConnectionGUID: qGaXCMjZRHqf+TLPq9E7pA==
X-CSE-MsgGUID: FNgw9BpWRk6tKxs6LX1fYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124814573"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 07:58:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 26 Mar 2025 16:58:14 +0200 (EET)
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
Subject: Re: [PATCH v6 3/6] PCI: Allow IOV resources to be resized in
 pci_resize_resource()
In-Reply-To: <20250320110854.3866284-4-michal.winiarski@intel.com>
Message-ID: <d79a7a63-af36-9852-bc65-876bb8a8c842@linux.intel.com>
References: <20250320110854.3866284-1-michal.winiarski@intel.com> <20250320110854.3866284-4-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2033718689-1743000594=:942"
Content-ID: <3fdd1558-2ac0-4c01-5ac6-640afcfc5cb9@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2033718689-1743000594=:942
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <61e32419-8ced-5c4e-16fd-edc6a34afae2@linux.intel.com>

On Thu, 20 Mar 2025, Micha=B3 Winiarski wrote:

> Similar to regular resizable BAR, VF BAR can also be resized.
>=20
> The structures are very similar, which means we can reuse most of the
> implementation.

There are differences in resizing which should be described (size calc=20
and mem decode check).

> Extend the pci_resize_resource() function to accept IOV resources.

> See PCIe r4.0, sec 9.3.7.4.

Can you update this to r6* please.

> Signed-off-by: Micha=B3 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/pci/iov.c       | 21 +++++++++++++++++++++
>  drivers/pci/pci.c       |  8 +++++++-
>  drivers/pci/pci.h       |  9 +++++++++
>  drivers/pci/setup-res.c | 35 ++++++++++++++++++++++++++++++-----
>  4 files changed, 67 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 985ea11339c45..cbf335725d4fb 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -154,6 +154,27 @@ resource_size_t pci_iov_resource_size(struct pci_dev=
 *dev, int resno)
>  =09return dev->sriov->barsz[pci_resource_num_to_vf_bar(resno)];
>  }
> =20
> +void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
> +=09=09=09       resource_size_t size)
> +{
> +=09if (!pci_resource_is_iov(resno)) {
> +=09=09pci_warn(dev, "%s is not an IOV resource\n",
> +=09=09=09 pci_resource_name(dev, resno));
> +=09=09return;
> +=09}
> +
> +=09dev->sriov->barsz[pci_resource_num_to_vf_bar(resno)] =3D size;
> +}
> +
> +bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev)
> +{
> +=09u16 cmd;
> +
> +=09pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_CTRL, &cmd);
> +
> +=09return cmd & PCI_SRIOV_CTRL_MSE;
> +}
> +
>  static void pci_read_vf_config_common(struct pci_dev *virtfn)
>  {
>  =09struct pci_dev *physfn =3D virtfn->physfn;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ff69f3d653ced..1fad9f4c54977 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3745,7 +3745,13 @@ static int pci_rebar_find_pos(struct pci_dev *pdev=
, int bar)
>  =09unsigned int pos, nbars, i;
>  =09u32 ctrl;
> =20
> -=09pos =3D pdev->rebar_cap;
> +=09if (pci_resource_is_iov(bar)) {
> +=09=09pos =3D pdev->physfn ? pdev->sriov->vf_rebar_cap : 0;

I'd explicitly do:

=09=09if (!pdev->physfn)
=09=09=09return -ENOTSUPP;

rather than relying pos =3D 0 triggering that return later on as the intent=
=20
is more obvious that way.

> +=09=09bar =3D pci_resource_num_to_vf_bar(bar);
> +=09} else {
> +=09=09pos =3D pdev->rebar_cap;
> +=09}
> +
>  =09if (!pos)
>  =09=09return -ENOTSUPP;
> =20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f44840ee3c327..643cd8c737f66 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -689,6 +689,9 @@ void pci_iov_update_resource(struct pci_dev *dev, int=
 resno);
>  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int re=
sno);
>  void pci_restore_iov_state(struct pci_dev *dev);
>  int pci_iov_bus_range(struct pci_bus *bus);
> +void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
> +=09=09=09       resource_size_t size);
> +bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev);
>  static inline bool pci_resource_is_iov(int resno)
>  {
>  =09return resno >=3D PCI_IOV_RESOURCES && resno <=3D PCI_IOV_RESOURCE_EN=
D;
> @@ -722,6 +725,12 @@ static inline int pci_iov_bus_range(struct pci_bus *=
bus)
>  {
>  =09return 0;
>  }
> +static inline void pci_iov_resource_set_size(struct pci_dev *dev, int re=
sno,
> +=09=09=09=09=09     resource_size_t size) { }
> +static inline bool pci_iov_is_memory_decoding_enabled(struct pci_dev *de=
v)
> +{
> +=09return false;
> +}
>  static inline bool pci_resource_is_iov(int resno)
>  {
>  =09return false;
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index c6657cdd06f67..d2b3ed51e8804 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -423,13 +423,39 @@ void pci_release_resource(struct pci_dev *dev, int =
resno)
>  }
>  EXPORT_SYMBOL(pci_release_resource);
> =20
> +static bool pci_resize_is_memory_decoding_enabled(struct pci_dev *dev,
> +=09=09=09=09=09=09  int resno)
> +{
> +=09u16 cmd;
> +
> +=09if (pci_resource_is_iov(resno))
> +=09=09return pci_iov_is_memory_decoding_enabled(dev);
> +
> +=09pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +
> +=09return cmd & PCI_COMMAND_MEMORY;
> +}
> +
> +static void pci_resize_resource_set_size(struct pci_dev *dev, int resno,
> +=09=09=09=09=09 int size)
> +{
> +=09resource_size_t res_size =3D pci_rebar_size_to_bytes(size);
> +=09struct resource *res =3D pci_resource_n(dev, resno);
> +
> +=09if (!pci_resource_is_iov(resno)) {
> +=09=09resource_set_size(res, res_size);
> +=09} else {
> +=09=09resource_set_size(res, res_size * pci_sriov_get_totalvfs(dev));
> +=09=09pci_iov_resource_set_size(dev, resno, res_size);
> +=09}
> +}
> +
>  int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>  {
>  =09struct resource *res =3D pci_resource_n(dev, resno);
>  =09struct pci_host_bridge *host;
>  =09int old, ret;
>  =09u32 sizes;
> -=09u16 cmd;
> =20
>  =09/* Check if we must preserve the firmware's resource assignment */
>  =09host =3D pci_find_host_bridge(dev->bus);
> @@ -440,8 +466,7 @@ int pci_resize_resource(struct pci_dev *dev, int resn=
o, int size)
>  =09if (!(res->flags & IORESOURCE_UNSET))
>  =09=09return -EBUSY;
> =20
> -=09pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -=09if (cmd & PCI_COMMAND_MEMORY)
> +=09if (pci_resize_is_memory_decoding_enabled(dev, resno))
>  =09=09return -EBUSY;
> =20
>  =09sizes =3D pci_rebar_get_possible_sizes(dev, resno);
> @@ -459,7 +484,7 @@ int pci_resize_resource(struct pci_dev *dev, int resn=
o, int size)
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09resource_set_size(res, pci_rebar_size_to_bytes(size));
> +=09pci_resize_resource_set_size(dev, resno, size);
> =20
>  =09/* Check if the new config works by trying to assign everything. */
>  =09if (dev->bus->self) {
> @@ -471,7 +496,7 @@ int pci_resize_resource(struct pci_dev *dev, int resn=
o, int size)
> =20
>  error_resize:
>  =09pci_rebar_set_size(dev, resno, old);
> -=09resource_set_size(res, pci_rebar_size_to_bytes(old));
> +=09pci_resize_resource_set_size(dev, resno, old);
>  =09return ret;
>  }
>  EXPORT_SYMBOL(pci_resize_resource);
>=20

--=20
 i.
--8323328-2033718689-1743000594=:942--

