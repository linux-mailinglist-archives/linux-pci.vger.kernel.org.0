Return-Path: <linux-pci+bounces-14190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC369984A9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 13:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE371C21167
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 11:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9293C1BBBE5;
	Thu, 10 Oct 2024 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXl0ANCv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10A1BDA9C;
	Thu, 10 Oct 2024 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559042; cv=none; b=igcksWrVeMtnq639u9NsKAXH4c1zXIBr6M4nb1tI5cZ6heCDSC4Ub3B24oushZlXdK2D3BVykjRio+1WD6hA1g14HpvIk7H0m/VhpiS5/TU+M2342bZGtV4R4sIj5rByNnU/ym+HGuc5iEE6CfwGrNYexwOZHLSol51NbmM3I/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559042; c=relaxed/simple;
	bh=zP2pjdHdRFiJEYIE+KjxKHZBjWBZoJSjYQjRZUQVWkM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Gu8OtVb3GBhKc0T6uo08vW4Qnv3yYkJK+QaDgI/B9CddTqZOwpZRfED56EQKN5F5/pHjZf/2M6bnWjyWmq0kjhFT3HcaaDu0dwAe/Eyuz0SrSm/2+quO8/0hnM4KYahazOPDC/3vxbxwyP4NSkawyQjBTEiFoOD74/gB4ALwAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXl0ANCv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728559041; x=1760095041;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zP2pjdHdRFiJEYIE+KjxKHZBjWBZoJSjYQjRZUQVWkM=;
  b=iXl0ANCvhsHgCbye13P89TpHG8jmFXx3ogMXVkVz3Rn1n1I60J2sfXDs
   qXKdRKdqiob4DGdm58P54PjbuSZVI67eapBJiNo145Y224NWHmyleorLD
   MKlS/tqRjwSVTgDlFdY70BWUWKuCUfuYjKLR8iVN453qUjrb8WPtNGs6+
   F0xccsf158ZEK99GaIHOBvqs02FSSa5quqFsuZAIF/miyVZsXBHFazngM
   YbVS7faN9W851Wqufx06l4tGthc3cEEMyDkvfIzfzagdDkFTUF1d0Bri3
   6EKNkgjMztCwQqyp2J9B3OeXJtgXeGVQHpxM+rLS1bzgBxjDelvs9WhWT
   g==;
X-CSE-ConnectionGUID: h0rrKwwKQTiB8AiqRe3uyw==
X-CSE-MsgGUID: bmIer0qhTVutFFtY0htBcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31698770"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="31698770"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:17:20 -0700
X-CSE-ConnectionGUID: gQR5DOKORw6SQDbg4DeL3w==
X-CSE-MsgGUID: G1l0qngmQeCFx+pzLoXK1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="107291580"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:17:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 10 Oct 2024 14:17:11 +0300 (EEST)
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
Subject: Re: [PATCH v3 3/5] PCI: Allow IOV resources to be resized in
 pci_resize_resource
In-Reply-To: <20241010103203.382898-4-michal.winiarski@intel.com>
Message-ID: <4c783170-930f-945f-a2b8-8dc3a111d13e@linux.intel.com>
References: <20241010103203.382898-1-michal.winiarski@intel.com> <20241010103203.382898-4-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2094611729-1728559031=:12246"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2094611729-1728559031=:12246
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 10 Oct 2024, Micha=C5=82 Winiarski wrote:

> Similar to regular resizable BAR, VF BAR can also be resized.
> The structures are very similar, which means we can reuse most of the
> implementation. See PCIe r4.0, sec 9.3.7.4.
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/pci/iov.c       | 20 ++++++++++++++++++++
>  drivers/pci/pci.c       |  9 ++++++++-
>  drivers/pci/pci.h       |  8 ++++++++
>  drivers/pci/setup-res.c | 33 ++++++++++++++++++++++++++++-----
>  4 files changed, 64 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index fd5c059b29c13..591a3eae1618a 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -154,6 +154,26 @@ resource_size_t pci_iov_resource_size(struct pci_dev=
 *dev, int resno)
>  =09return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
>  }
> =20
> +void pci_iov_resource_set_size(struct pci_dev *dev, int resno, resource_=
size_t size)
> +{
> +=09if (!pci_resource_is_iov(resno)) {
> +=09=09pci_warn(dev, "%s is not an IOV resource\n",
> +=09=09=09 pci_resource_name(dev, resno));
> +=09=09return;
> +=09}
> +
> +=09dev->sriov->barsz[resno - PCI_IOV_RESOURCES] =3D size;
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
> index 7d85c04fbba2a..788ae61731213 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3718,10 +3718,17 @@ void pci_acs_init(struct pci_dev *dev)
>   */
>  static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
>  {
> +=09int cap =3D PCI_EXT_CAP_ID_REBAR;
>  =09unsigned int pos, nbars, i;
>  =09u32 ctrl;
> =20
> -=09pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +#ifdef CONFIG_PCI_IOV
> +=09if (pci_resource_is_iov(bar)) {
> +=09=09cap =3D PCI_EXT_CAP_ID_VF_REBAR;
> +=09=09bar -=3D PCI_IOV_RESOURCES;
> +=09}
> +#endif

Perhaps abstracting bar -=3D PCI_IOV_RESOURCES too into some static inline=
=20
function would be useful so you could drop the ifdefs. That calculation=20
seems to be done in few places besides this one.

> +=09pos =3D pci_find_ext_capability(pdev, cap);
>  =09if (!pos)
>  =09=09return -ENOTSUPP;
> =20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index c55f2d7a4f37e..e15fd8fe0f81f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -584,6 +584,8 @@ static inline bool pci_resource_is_iov(int resno)
>  {
>  =09return resno >=3D PCI_IOV_RESOURCES && resno <=3D PCI_IOV_RESOURCE_EN=
D;
>  }
> +void pci_iov_resource_set_size(struct pci_dev *dev, int resno, resource_=
size_t size);
> +bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev);
>  extern const struct attribute_group sriov_pf_dev_attr_group;
>  extern const struct attribute_group sriov_vf_dev_attr_group;
>  #else
> @@ -607,6 +609,12 @@ static inline bool pci_resource_is_iov(int resno)
>  {
>  =09return false;
>  }
> +static inline void pci_iov_resource_set_size(struct pci_dev *dev, int re=
sno,
> +=09=09=09=09=09     resource_size_t size) { }
> +static inline bool pci_iov_is_memory_decoding_enabled(struct pci_dev *de=
v)
> +{
> +=09return false;
> +}
>  #endif /* CONFIG_PCI_IOV */
> =20
>  #ifdef CONFIG_PCIE_PTM
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index e2cf79253ebda..95a13a5fa379c 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -425,13 +425,37 @@ void pci_release_resource(struct pci_dev *dev, int =
resno)
>  }
>  EXPORT_SYMBOL(pci_release_resource);
> =20
> +static bool pci_resize_is_memory_decoding_enabled(struct pci_dev *dev, i=
nt resno)
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
> +static void pci_resize_resource_set_size(struct pci_dev *dev, int resno,=
 int size)
> +{
> +=09resource_size_t res_size =3D pci_rebar_size_to_bytes(size);
> +=09struct resource *res =3D dev->resource + resno;
> +
> +=09if (!pci_resource_is_iov(resno)) {
> +=09=09res->end =3D res->start + res_size - 1;
> +=09} else {
> +=09=09res->end =3D res->start + res_size * pci_sriov_get_totalvfs(dev) -=
 1;

I wish Bjorn would pick up my resource_set_{range,size}() series [1] so we=
=20
wouldn't need to open-code this resource size calculation everywhere.

> +=09=09pci_iov_resource_set_size(dev, resno, res_size);
> +=09}
> +}
> +
>  int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>  {
>  =09struct resource *res =3D dev->resource + resno;
>  =09struct pci_host_bridge *host;
>  =09int old, ret;
>  =09u32 sizes;
> -=09u16 cmd;
> =20
>  =09/* Check if we must preserve the firmware's resource assignment */
>  =09host =3D pci_find_host_bridge(dev->bus);
> @@ -442,8 +466,7 @@ int pci_resize_resource(struct pci_dev *dev, int resn=
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
> @@ -461,7 +484,7 @@ int pci_resize_resource(struct pci_dev *dev, int resn=
o, int size)
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09res->end =3D res->start + pci_rebar_size_to_bytes(size) - 1;
> +=09pci_resize_resource_set_size(dev, resno, size);
> =20
>  =09/* Check if the new config works by trying to assign everything. */
>  =09if (dev->bus->self) {
> @@ -473,7 +496,7 @@ int pci_resize_resource(struct pci_dev *dev, int resn=
o, int size)
> =20
>  error_resize:
>  =09pci_rebar_set_size(dev, resno, old);
> -=09res->end =3D res->start + pci_rebar_size_to_bytes(old) - 1;
> +=09pci_resize_resource_set_size(dev, resno, old);
>  =09return ret;
>  }
>  EXPORT_SYMBOL(pci_resize_resource);
>=20

[1] https://patchwork.kernel.org/project/linux-pci/patch/20240614100606.158=
30-2-ilpo.jarvinen@linux.intel.com/

--=20
 i.

--8323328-2094611729-1728559031=:12246--

