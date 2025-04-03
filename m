Return-Path: <linux-pci+bounces-25229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A2CA7A086
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 11:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9393ABE2C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD3E1F4CA4;
	Thu,  3 Apr 2025 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/yMYJVL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914E13D531;
	Thu,  3 Apr 2025 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674098; cv=none; b=fh6fRCT2NrPaRkUh5ZPzEvzYdtX60V5fk/CNebV48RW9BvqngjhSXjYbGyy3nass1FEJIVPbIFgzE0+Fuj1JS07bkaefUAooCOnu+og4OlsLVo6zFOzVKa++beDV5gT1UD4U6EsKrwQARFWgcinqgwcVOf5SkV6EXrIzrfTgVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674098; c=relaxed/simple;
	bh=4aLRfN57w9gzYeMIUFZ1CreUx/4uJrM+2z5ByxW5EGs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G6+1j1tPtpFSIQWerj2fV3EfWi1d9PFJB3qRJD42ddQ4x636GMwkJo6s6mt+PMta4bCTl+GJKXIg5HpAf4DoFbyr5xDJQQj+4i1EwaW94OHErTbUAmiBwGxAp0cJJnNeh3qU49u5QFDNcJWIQLLvcHrAwFCnuavVNROQX2VUlZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/yMYJVL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743674097; x=1775210097;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4aLRfN57w9gzYeMIUFZ1CreUx/4uJrM+2z5ByxW5EGs=;
  b=B/yMYJVLjUAKRgEGzKdpfgFeaCnXLloq0EzHHozlT9zYgWIRxhthI3Mt
   iyW/9EIA4P7weMb2UHvk+TPyxQ0De3dEhA8DUzIv4bkgKEsvJD5W49+Wr
   SpqwrOGM0u6PZJBVH9CowycHSj6u8NetxvlCq0osghSOfJZ/75KHUQ/LT
   xHbNS5pRKVmJp2FYEw38E1Gtqatqe1xmpWcPOSkkjvoMwCd9NwE7zhhca
   9GWrxbesjnHqQdYaKSTz+BmmFQYyQrjctg3VPSdDFAGLJFLZxicTv4f/9
   xU8dWNJoriohOj8yJ+U1FAzMDIrb+eqGSFc5TSO1vE0lC9fpucF1c3SHG
   w==;
X-CSE-ConnectionGUID: JQmukYzRT5uoDRV4YC2zqA==
X-CSE-MsgGUID: vsKjO1WrSiSjXI8pCWgH2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="45197216"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="45197216"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 02:54:56 -0700
X-CSE-ConnectionGUID: /c3TGysPSg6RF7ARnplGBw==
X-CSE-MsgGUID: WQuuYpJoT9S6C/he/aCgvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="150158033"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.152])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 02:54:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 3 Apr 2025 12:54:47 +0300 (EEST)
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
Subject: Re: [PATCH v7 4/6] PCI/IOV: Check that VF BAR fits within the
 reservation
In-Reply-To: <20250402141122.2818478-5-michal.winiarski@intel.com>
Message-ID: <308209c2-508e-19d1-a5aa-9c8a8af68b23@linux.intel.com>
References: <20250402141122.2818478-1-michal.winiarski@intel.com> <20250402141122.2818478-5-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1411218873-1743674087=:1302"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1411218873-1743674087=:1302
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 2 Apr 2025, Micha=C5=82 Winiarski wrote:

> When the resource representing VF MMIO BAR reservation is created, its
> size is always large enough to accommodate the BAR of all SR-IOV Virtual
> Functions that can potentially be created (total VFs). If for whatever
> reason it's not possible to accommodate all VFs - the resource is not
> assigned and no VFs can be created.
>=20
> An upcoming change will allow VF BAR size to be modified by drivers at
> a later point in time, which means that the check for resource
> assignment is no longer sufficient.
>=20
> Add an additional check that verifies that VF BAR for all enabled VFs
> fits within the underlying reservation resource.
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/pci/iov.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index fee99e15a943f..2fafbd6a998f0 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -668,9 +668,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_=
virtfn)
>  =09nres =3D 0;
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
>  =09=09int idx =3D pci_resource_num_from_vf_bar(i);
> +=09=09resource_size_t vf_bar_sz =3D pci_iov_resource_size(dev, idx);
> =20
>  =09=09bars |=3D (1 << idx);
>  =09=09res =3D &dev->resource[idx];
> +=09=09if (vf_bar_sz * nr_virtfn > resource_size(res))
> +=09=09=09continue;
>  =09=09if (res->parent)
>  =09=09=09nres++;
>  =09}
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1411218873-1743674087=:1302--

