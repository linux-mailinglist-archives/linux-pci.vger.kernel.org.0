Return-Path: <linux-pci+bounces-23591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD9DA5F001
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 10:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863E83B29B7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CE5261583;
	Thu, 13 Mar 2025 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkU1iSOk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812411C1F0C;
	Thu, 13 Mar 2025 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859778; cv=none; b=AdwuhJ8opoJgDXPL45hKwPZbUOyzugSfC9PGZe91FEUxwzR1TEgn0+Yik1zxOzyv5qq5xcvAfQHZM/B37jDqvVx2+5ohJmk/Eqdx0ORCv8VQOrbodYU8hqXYi8nZ0jMavRd0yd6LUjgm3Oo0OMU6d2rPUaqurDXuoN9VuNYe8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859778; c=relaxed/simple;
	bh=7A7CXQ1D8YunDLXzWL2mbCvEvN81Zg7DaI+66KINIEU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BsRYv/2c7zzqzgUuL1yuAoqW/VVJysRvdUyMOIODvxmCMMXanhSUy7L1NJnRJ9JcJPa6y0etQAh/iEDcuGkzX4CmltRI/CYELHtHhXloEO19+aaLd0qLYcCcig5xWdQGLvGAa6ESkTd6ATC+ebb0SUs/ed/CpCGDibBnT1ebuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkU1iSOk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741859777; x=1773395777;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7A7CXQ1D8YunDLXzWL2mbCvEvN81Zg7DaI+66KINIEU=;
  b=kkU1iSOkMpcxLuckTqPtZFkDzkc5SK82i5iOarjTzWU4xHO3FPJ7O0CS
   IibVHDIZR2KA0JwS9HSIvYgVViWoxVz2qW1oXIM4ffoxBD6nhTZYuLtxH
   kG36xxUtiEklb5XE+oXhQaIiaAunqw8/C6dQoP/vf2S+LsF1wlxaOrDIC
   mBYu9fLk33IASfORhoDZV14f89/9HGQ5JN/hgyjc3fqPC6LV51UrRwTKU
   hvtRSusuZDljoxzMsI9Rc9z3dcuWlXP2JlI1Tl59qvpJyIqGekpop565A
   qDeGZJZG66+00a3ojU0o9Djx9w28+JwjFHYYUVlV8LrNMElknxhAznW/v
   Q==;
X-CSE-ConnectionGUID: ogWy6jOZTHOjN4mSxZuw8A==
X-CSE-MsgGUID: 7XzFT3CISR6nVwxQaHAu+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="30557600"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="30557600"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:56:15 -0700
X-CSE-ConnectionGUID: 7Id4GbPKR5KkNDtc+RS1dw==
X-CSE-MsgGUID: WdRV1eWBRqCw3A/LiN2+ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120967102"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:56:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Mar 2025 11:56:07 +0200 (EET)
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
Subject: Re: [PATCH v5 3/6] PCI: Allow IOV resources to be resized in
 pci_resize_resource()
In-Reply-To: <20250312225949.969716-4-michal.winiarski@intel.com>
Message-ID: <a4eaa28c-a080-949d-6ae3-8eae4ca24f40@linux.intel.com>
References: <20250312225949.969716-1-michal.winiarski@intel.com> <20250312225949.969716-4-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2011323846-1741859767=:1742"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2011323846-1741859767=:1742
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 12 Mar 2025, Micha=C5=82 Winiarski wrote:

> Similar to regular resizable BAR, VF BAR can also be resized.
>=20
> The structures are very similar, which means we can reuse most of the
> implementation.
>=20
> Extend the pci_resize_resource() function to accept IOV resources.
>=20
> See PCIe r4.0, sec 9.3.7.4.
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/pci/iov.c       | 21 +++++++++++++++++++++
>  drivers/pci/pci.c       | 10 +++++++++-
>  drivers/pci/pci.h       |  9 +++++++++
>  drivers/pci/setup-res.c | 35 ++++++++++++++++++++++++++++++-----
>  4 files changed, 69 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 23c741e9ede89..7cc17e898cea7 100644
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
> index 72ac91e359aaf..e6a986ad24d61 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3731,8 +3731,16 @@ static int pci_rebar_find_pos(struct pci_dev *pdev=
, int bar)
>  {
>  =09unsigned int pos, nbars, i;
>  =09u32 ctrl;
> +=09int cap;
> =20
> -=09pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +=09if (pci_resource_is_iov(bar)) {
> +=09=09cap =3D PCI_EXT_CAP_ID_VF_REBAR;
> +=09=09bar =3D pci_resource_num_to_vf_bar(bar);
> +=09} else {
> +=09=09cap =3D PCI_EXT_CAP_ID_REBAR;
> +=09}

Use the cached values here.

> +
> +=09pos =3D pci_find_ext_capability(pdev, cap);
>  =09if (!pos)
>  =09=09return -ENOTSUPP;
> =20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index e3cd9b8f9b734..af41f6c24451f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -655,6 +655,9 @@ void pci_iov_update_resource(struct pci_dev *dev, int=
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
> @@ -688,6 +691,12 @@ static inline int pci_iov_bus_range(struct pci_bus *=
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
> index c6657cdd06f67..6cce3e19f22b0 100644
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
> +=09struct resource *res =3D dev->resource + resno;

pci_resource_n()

> +
> +=09if (!pci_resource_is_iov(resno)) {
> +=09=09resource_set_size(res, res_size);
> +=09} else {
> +=09=09resource_set_size(res, res_size * pci_sriov_get_totalvfs(dev));

Should this too be done in pci_iov_resource_set_size()? Why is it being=20
done here?

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

--8323328-2011323846-1741859767=:1742--

