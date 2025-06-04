Return-Path: <linux-pci+bounces-28968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F47ACDDD9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D900E7A94AF
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97B128E575;
	Wed,  4 Jun 2025 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhXTjvaC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8479F2;
	Wed,  4 Jun 2025 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039964; cv=none; b=UCeCBhcGUqROL924r0vICVLDVCubPw/n0mNnJ/a4CxWhMfGh7aQcfCddXLxGpwoAWtGJ0rU9RBv0Cqce7nRR5FApcnkhIvCO48fWJQP67gcUFcRe5ImlYR1Hk+yUaVopgv8qg7/ev/sinY1o+X/XoJKyqzkVu1kjbEfEkNMNMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039964; c=relaxed/simple;
	bh=EFkzfqm1FA/pnUlUVk4/tkPBvTq7nP68gf7IeW/2B0w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UG89XT2Bw6lIDS3BslQkDDoYiPKNX4NXWQwqyXJqUy0gdsNQjEKpOh4ElQQs/CyS4JAMoA4DPpo6t3hZ/gAIqJ2k8VzwqBTBnZHIpZS9cfh2iA7KlIKofs/muOJ/r7MjpqOebMeaNDPMr32Uf1Q9r02+qhU2edMgSab/HSdCbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhXTjvaC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749039963; x=1780575963;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EFkzfqm1FA/pnUlUVk4/tkPBvTq7nP68gf7IeW/2B0w=;
  b=EhXTjvaCdoJe9SUD5eQ4XyGVolhq4qgixu37m1PL4IJMWTod9TUmUCwU
   DWGarE/CrPzfe9EZ95lOkVSw62jiiWiDjYHAY/UllnxvKtM/9XtKCY5Yd
   gOajgiS4U5gr/ZxM4wCwrQvgQhyTMJj65pzf+iRO83NaTdHZZ21sOna1P
   p9H3gErjAY/fonh68MVHxMD7+/ze3fgKc3sKhW3IeWAZkfpKMQtbritgf
   anRoN9vtYtkVYZgXWYHVM0vNIYtz2N++toROl0YiOVWlOYNRa/u8Uf+yz
   YRaQL+iUqa2yva/aSq5SLIDhiJzXlafCJQ9DcK5NeSkZ7tsNY2TDryW7a
   g==;
X-CSE-ConnectionGUID: jcoZAIqSTn+BhpTBx2+JbQ==
X-CSE-MsgGUID: pARAJ2wITsOF+G5YykbbxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="53745738"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="53745738"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 05:26:02 -0700
X-CSE-ConnectionGUID: lH/3sueOTVeh6pK8IT9H7Q==
X-CSE-MsgGUID: 4OTG5hFBSAutbZbNmejlmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145133647"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.124])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 05:25:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 4 Jun 2025 15:25:52 +0300 (EEST)
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
Subject: Re: [PATCH v9 5/6] PCI: Allow drivers to control VF BAR size
In-Reply-To: <20250527120637.665506-6-michal.winiarski@intel.com>
Message-ID: <a6dd1c15-7c0c-bb60-9784-f3a18bc8b765@linux.intel.com>
References: <20250527120637.665506-1-michal.winiarski@intel.com> <20250527120637.665506-6-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-318291348-1749039952=:979"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-318291348-1749039952=:979
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 May 2025, Micha=C5=82 Winiarski wrote:

> Drivers could leverage the fact that the VF BAR MMIO reservation is
> created for total number of VFs supported by the device by resizing the
> BAR to larger size when smaller number of VFs is enabled.
>=20
> Add a pci_iov_vf_bar_set_size() function to control the size and a
> pci_iov_vf_bar_get_sizes() helper to get the VF BAR sizes that will
> allow up to num_vfs to be successfully enabled with the current
> underlying reservation size.
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/pci/iov.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  6 ++++
>  2 files changed, 79 insertions(+)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index f34173c70b32a..ac4375954c947 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -8,11 +8,15 @@
>   */
> =20
>  #include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/log2.h>
>  #include <linux/pci.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <linux/string.h>
>  #include <linux/delay.h>
> +#include <asm/div64.h>
>  #include "pci.h"
> =20
>  #define VIRTFN_ID_LEN=0917=09/* "virtfn%u\0" for 2^32 - 1 */
> @@ -1313,3 +1317,72 @@ int pci_sriov_configure_simple(struct pci_dev *dev=
, int nr_virtfn)
>  =09return nr_virtfn;
>  }
>  EXPORT_SYMBOL_GPL(pci_sriov_configure_simple);
> +
> +/**
> + * pci_iov_vf_bar_set_size - set a new size for a VF BAR
> + * @dev: the PCI device
> + * @resno: the resource number
> + * @size: new size as defined in the spec (0=3D1MB, 31=3D128TB)
> + *
> + * Set the new size of a VF BAR that supports VF resizable BAR capabilit=
y.
> + * Unlike pci_resize_resource(), this does not cause the resource that
> + * reserves the MMIO space (originally up to total_VFs) to be resized, w=
hich
> + * means that following calls to pci_enable_sriov() can fail if the reso=
urces
> + * no longer fit.
> + *
> + * Return: 0 on success, or negative on failure.
> + */
> +int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size)
> +{
> +=09u32 sizes;
> +=09int ret;
> +
> +=09if (!pci_resource_is_iov(resno))
> +=09=09return -EINVAL;
> +
> +=09if (pci_iov_is_memory_decoding_enabled(dev))
> +=09=09return -EBUSY;
> +
> +=09sizes =3D pci_rebar_get_possible_sizes(dev, resno);
> +=09if (!sizes)
> +=09=09return -ENOTSUPP;
> +
> +=09if (!(sizes & BIT(size)))
> +=09=09return -EINVAL;
> +
> +=09ret =3D pci_rebar_set_size(dev, resno, size);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09pci_iov_resource_set_size(dev, resno, pci_rebar_size_to_bytes(size));
> +
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_iov_vf_bar_set_size);
> +
> +/**
> + * pci_iov_vf_bar_get_sizes - get VF BAR sizes allowing to create up to =
num_vfs
> + * @dev: the PCI device
> + * @resno: the resource number
> + * @num_vfs: number of VFs
> + *
> + * Get the sizes of a VF resizable BAR that can accommodate @num_vfs wit=
hin
> + * the currently assigned size of the resource @resno.
> + *
> + * Return: A bitmask of sizes in format defined in the spec (bit 0=3D1MB=
,
> + * bit 31=3D128TB).
> + */
> +u32 pci_iov_vf_bar_get_sizes(struct pci_dev *dev, int resno, int num_vfs=
)
> +{
> +=09u64 vf_len =3D pci_resource_len(dev, resno);
> +=09u32 sizes;
> +
> +=09if (!num_vfs)
> +=09=09return 0;
> +
> +=09do_div(vf_len, num_vfs);
> +=09sizes =3D (roundup_pow_of_two(vf_len + 1) - 1) >> ilog2(SZ_1M);
> +
> +=09return sizes & pci_rebar_get_possible_sizes(dev, resno);
> +}
> +EXPORT_SYMBOL_GPL(pci_iov_vf_bar_get_sizes);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index ab62bcb5f99c6..cc633b1a13d51 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2437,6 +2437,8 @@ int pci_sriov_set_totalvfs(struct pci_dev *dev, u16=
 numvfs);
>  int pci_sriov_get_totalvfs(struct pci_dev *dev);
>  int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn);
>  resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
> +int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size);
> +u32 pci_iov_vf_bar_get_sizes(struct pci_dev *dev, int resno, int num_vfs=
);
>  void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
> =20
>  /* Arch may override these (weak) */
> @@ -2489,6 +2491,10 @@ static inline int pci_sriov_get_totalvfs(struct pc=
i_dev *dev)
>  #define pci_sriov_configure_simple=09NULL
>  static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev,=
 int resno)
>  { return 0; }
> +static inline int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno=
, int size)
> +{ return -ENODEV; }
> +static inline u32 pci_iov_vf_bar_get_sizes(struct pci_dev *dev, int resn=
o, int num_vfs)
> +{ return 0; }
>  static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool pr=
obe) { }
>  #endif
> =20
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-318291348-1749039952=:979--

