Return-Path: <linux-pci+bounces-36150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0919B57B6E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 14:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C04446FFC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 12:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08330C35A;
	Mon, 15 Sep 2025 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dgg5eDCQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE3B30BF78;
	Mon, 15 Sep 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940155; cv=none; b=G8e4haaYLo0e+i6UGw6yPiWYNrJQRbEI+9BZdnOpe5Zf4b0ujLUMw0/9bQHuJo3CASdkhhUIUW2k1j/QWo7TTFAj2tUrVBNOK3wfpbpXf3in03j5/H3u4taW0PV2tLVisq52JEN4Tlz8MIsB0EFKmCWjgxVzOsZkWZK1pEq3LWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940155; c=relaxed/simple;
	bh=oAEeoHs9rXo/wf2oE06+wQRWp/MuIBStmQIAXSQs2Yc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D1boHwcL6FXp5VCqREeJh5VIxgYO47m/rFTtJcZmOxj2utqgRNeHmwqynfVB1eI/bKHttReenbWh5/i87hCU6BUwNa/cwQRLOedGIOKS4aFAJEReefenL54zzhdrVPdhap8A55jL2sv541UxhVhUX1dhN8PxoFal05n7Hja1E6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dgg5eDCQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757940154; x=1789476154;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=oAEeoHs9rXo/wf2oE06+wQRWp/MuIBStmQIAXSQs2Yc=;
  b=Dgg5eDCQT4ZFzRh1+mEjh6ag0c6mFBeOZNj8figqyyUHHEzBDS+ONBTE
   3uCBlyw8enrCE3dFqyIH4mJc5OYyJ6sVi16b7hIOixCkV4i5WWuOpKlXr
   fhUq/BvKbh6vMlTF3cMk26c8DoWzjv4OlaeCeXYk4DxIGBpi8C+t5h3/S
   rfxub1SFFG0K49liXlQLbXbbEde9smYOjqZaD02diozEKvuagq9BuSXox
   iR2GJmW8D2LLQxNXNRUVrHXT/iMYejFjALSq5t0UvLr6P6RxaKoiMVOxk
   8UF3RAG1ZNDkMcIT6EMgkfH6h63mLR4pd9Aqd9iMY0KgGSZoa4WrEbxcJ
   A==;
X-CSE-ConnectionGUID: H6zBGGM0TWeZ4x0WK8YB9Q==
X-CSE-MsgGUID: myqocbLcRfuT4avmKPhjGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="71617240"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="71617240"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 05:42:34 -0700
X-CSE-ConnectionGUID: cOZDlnkpT02cRk3T8k23uw==
X-CSE-MsgGUID: XKZSDT/hQSW8OJec2XHG4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="175056198"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.17])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 05:42:26 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Christian =?utf-8?Q?K=C3=B6ni?=
 =?utf-8?Q?g?= <christian.koenig@amd.com>,
 =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Alex
 Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, David Airlie
 <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona
 Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 ?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Michael J . Ruhl" <mjruhl@habana.ai>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 06/11] drm/i915/gt: Use pci_rebar_size_supported()
In-Reply-To: <20250915091358.9203-7-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250915091358.9203-1-ilpo.jarvinen@linux.intel.com>
 <20250915091358.9203-7-ilpo.jarvinen@linux.intel.com>
Date: Mon, 15 Sep 2025 15:42:23 +0300
Message-ID: <b918053f6ac7b4a27148a1cbf10eb8402572c6c9@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sep 2025, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wro=
te:
> PCI core provides pci_rebar_size_supported() that helps in checking if
> a BAR Size is supported for the BAR or not. Use it in
> i915_resize_lmem_bar() to simplify code.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

and

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging via whichever tree is convenient.

> ---
>  drivers/gpu/drm/i915/gt/intel_region_lmem.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_region_lmem.c b/drivers/gpu/dr=
m/i915/gt/intel_region_lmem.c
> index 51bb27e10a4f..69c65fc8a72d 100644
> --- a/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> +++ b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
> @@ -61,16 +61,12 @@ static void i915_resize_lmem_bar(struct drm_i915_priv=
ate *i915, resource_size_t
>  	current_size =3D roundup_pow_of_two(pci_resource_len(pdev, GEN12_LMEM_B=
AR));
>=20=20
>  	if (i915->params.lmem_bar_size) {
> -		u32 bar_sizes;
> -
> -		rebar_size =3D i915->params.lmem_bar_size *
> -			(resource_size_t)SZ_1M;
> -		bar_sizes =3D pci_rebar_get_possible_sizes(pdev, GEN12_LMEM_BAR);
> -
> +		rebar_size =3D i915->params.lmem_bar_size * (resource_size_t)SZ_1M;
>  		if (rebar_size =3D=3D current_size)
>  			return;
>=20=20
> -		if (!(bar_sizes & BIT(pci_rebar_bytes_to_size(rebar_size))) ||
> +		if (!pci_rebar_size_supported(pdev, GEN12_LMEM_BAR,
> +					      pci_rebar_bytes_to_size(rebar_size)) ||
>  		    rebar_size >=3D roundup_pow_of_two(lmem_size)) {
>  			rebar_size =3D lmem_size;

--=20
Jani Nikula, Intel

