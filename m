Return-Path: <linux-pci+bounces-24780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD666A71A69
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 16:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F383AC4A8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A5A1F0E5D;
	Wed, 26 Mar 2025 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpnWHTgi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901EE1A8F60;
	Wed, 26 Mar 2025 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002983; cv=none; b=EObJBKmd5NzM8RnTmrgV+ZcTEQ1VmNtzNBJEUzw8aj3CYZh4Zge89pfokJ1lxnaiGhBAddtoVp2nW0+HOfN3GfR4woMqRQjhfxn4TUYSwpzYSvrS+Cv9XBKMGpLwrwhaMA2oHbEDPggmeGwVRE+T8T5ifilpGr+3hkimhi7Se9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002983; c=relaxed/simple;
	bh=1rR+/faxkHLlYltbcuI3PbbS4s/fXFMou00xu/7HeXY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zae7GFlcvFZ+zZoK6x80xO/ZEZqFII5ehynVM8SbJ0k3Nn7k6VFvBomGhKBoVDxMdfn2Pp6zWendT+EzRSZfPMvTZXJN85jzso6zCiV5C0RL9nLhYd6OSZ6Uo6bArpzeKITWhK0bNfcLWMjgIBtK6VN9+yiD92TaKCqJXfaA6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpnWHTgi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743002981; x=1774538981;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1rR+/faxkHLlYltbcuI3PbbS4s/fXFMou00xu/7HeXY=;
  b=mpnWHTgiDJBA/64CQhfDNg4MSTqk9xEr/6q004lzqoV6b6T+Oc5rbKRL
   H5lUOtSxTRPjPfeiDqb7Ez0LXdfGuZajEp//ZgmuVCnrfmz/OnkwcL4Fl
   G1Wj5MtOiuKFBMiLCX1i9Y2OQB5RGL1Ny1JwWEfJhEU3hfp6zUM+daAet
   DHNM6h0HYaUImpRnALMdg2X5U4vKjPEWYfmVKbaUu/WjO7frBEAwvRDHn
   9QgX4AoiVOR0B0hyDUDJiM0MIghrC+dCumza2E86bwnj3PpyPKWj9ImCW
   i2zfx5JYRr4UGxONZ3QLkn01EVXrYzhAOecZj4Dd4b6ZSYdojBEEBRi0a
   g==;
X-CSE-ConnectionGUID: jByE/pSPSzaswhum6VvZvA==
X-CSE-MsgGUID: 5Cyg2YVUTvSYJo8AxW4SXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48090994"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="48090994"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:29:41 -0700
X-CSE-ConnectionGUID: YzU27J2ySvuWW45LWD51FQ==
X-CSE-MsgGUID: zcEnZjfDTm2RZuW6qMnLTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="125742493"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.5])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:29:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 26 Mar 2025 17:29:31 +0200 (EET)
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
Subject: Re: [PATCH v6 6/6] drm/xe/pf: Set VF LMEM BAR size
In-Reply-To: <20250320110854.3866284-7-michal.winiarski@intel.com>
Message-ID: <bdfe5413-547a-67b0-b822-9852d3f94cc5@linux.intel.com>
References: <20250320110854.3866284-1-michal.winiarski@intel.com> <20250320110854.3866284-7-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1374919276-1743002971=:942"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1374919276-1743002971=:942
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 20 Mar 2025, Micha=C5=82 Winiarski wrote:

> LMEM is partitioned between multiple VFs and we expect that the more
> VFs we have, the less LMEM is assigned to each VF.
> This means that we can achieve full LMEM BAR access without the need to
> attempt full VF LMEM BAR resize via pci_resize_resource().
>=20
> Always set the largest possible BAR size that allows to fit the number
> of enabled VFs.
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/gpu/drm/xe/regs/xe_bars.h |  1 +
>  drivers/gpu/drm/xe/xe_pci_sriov.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/xe/regs/xe_bars.h b/drivers/gpu/drm/xe/regs/=
xe_bars.h
> index ce05b6ae832f1..880140d6ccdca 100644
> --- a/drivers/gpu/drm/xe/regs/xe_bars.h
> +++ b/drivers/gpu/drm/xe/regs/xe_bars.h
> @@ -7,5 +7,6 @@
> =20
>  #define GTTMMADR_BAR=09=09=090 /* MMIO + GTT */
>  #define LMEM_BAR=09=09=092 /* VRAM */
> +#define VF_LMEM_BAR=09=09=099 /* VF VRAM */
> =20
>  #endif
> diff --git a/drivers/gpu/drm/xe/xe_pci_sriov.c b/drivers/gpu/drm/xe/xe_pc=
i_sriov.c
> index aaceee748287e..57cdeb41ef1d9 100644
> --- a/drivers/gpu/drm/xe/xe_pci_sriov.c
> +++ b/drivers/gpu/drm/xe/xe_pci_sriov.c
> @@ -3,6 +3,10 @@
>   * Copyright =C2=A9 2023-2024 Intel Corporation
>   */
> =20
> +#include <linux/bitops.h>
> +#include <linux/pci.h>
> +
> +#include "regs/xe_bars.h"
>  #include "xe_assert.h"
>  #include "xe_device.h"
>  #include "xe_gt_sriov_pf_config.h"
> @@ -62,6 +66,18 @@ static void pf_reset_vfs(struct xe_device *xe, unsigne=
d int num_vfs)
>  =09=09=09xe_gt_sriov_pf_control_trigger_flr(gt, n);
>  }
> =20
> +static int resize_vf_vram_bar(struct xe_device *xe, int num_vfs)
> +{
> +=09struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);
> +=09u32 sizes;
> +
> +=09sizes =3D pci_iov_vf_bar_get_sizes(pdev, VF_LMEM_BAR, num_vfs);
> +=09if (!sizes)
> +=09=09return 0;
> +
> +=09return pci_iov_vf_bar_set_size(pdev, VF_LMEM_BAR, __fls(sizes));
> +}
> +
>  static int pf_enable_vfs(struct xe_device *xe, int num_vfs)
>  {
>  =09struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);
> @@ -88,6 +104,12 @@ static int pf_enable_vfs(struct xe_device *xe, int nu=
m_vfs)
>  =09if (err < 0)
>  =09=09goto failed;
> =20
> +=09if (IS_DGFX(xe)) {
> +=09=09err =3D resize_vf_vram_bar(xe, num_vfs);
> +=09=09if (err)
> +=09=09=09xe_sriov_info(xe, "Failed to set VF LMEM BAR size: %d\n", err);

If you intended this error to not result in failure, please mention it=20
in the changelog so that it's recorded somewhere for those who have to=20
look up things from the git history one day :-).

> +=09}
> +
>  =09err =3D pci_enable_sriov(pdev, num_vfs);
>  =09if (err < 0)
>  =09=09goto failed;

Seems pretty straightforward after reading the support code on the PCI=20
core side,

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1374919276-1743002971=:942--

