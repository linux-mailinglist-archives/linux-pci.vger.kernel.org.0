Return-Path: <linux-pci+bounces-24778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2ADA719DC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 16:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60677A37B8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24DC1F2382;
	Wed, 26 Mar 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oq8aBQw7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A8C1E1E0D;
	Wed, 26 Mar 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001875; cv=none; b=cR5FQoIgdPWkAQNzFfnV+ZBpImewyco4ilIuAwU3W+n9KWI+JzoIf4yBPhksfPzBIV66QRhTWAzKwPCdofow2MrNCx2ySEXd4DGLmP+u9YbM2BsNP2xLsHe2F5joxdhZk6zwgLQ8SGSw3zlk1qLKHX9OVej/C2UHVWS9dZ3ab7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001875; c=relaxed/simple;
	bh=T2vj5fs1lJoyIJWe3E0BaCVb+RTTxO7rAjHyemXklF4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DPPnN6WdW7lFwM4pEOXmDIytWTcuJavj+plC0SXdVKDJ8qlfEmqpPNiyMarHgjrjLIINlhq0LFxxzviEh8dkNY3i2pr/XyIbgwitZZvMftH4oIbYdWTnDq9x64tOXylyTJ1rOa5qr1nXaOHR8kyGmpx2Car+KytSD8PfD6Dp3wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oq8aBQw7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743001874; x=1774537874;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T2vj5fs1lJoyIJWe3E0BaCVb+RTTxO7rAjHyemXklF4=;
  b=Oq8aBQw7iP613k3oZiIej3oM8swD6n6gKht7OmfR0JYkctGaEHRizwla
   XXhTfoo3WHXp6ayYO2Kn0XfM1CFFi6VomoUrMYvPCCnbUvSBAcY7/dvSQ
   iaXVfa3+OZ35ToGEET/aBivEzsQJ7P3t6grgVqIPyRmlKGxvQICAngs4I
   kWugprTk0TZOo1oocQceAVwFSYzt6IMC2fwug1BzhJ9sn/HqlvMF+WaFb
   2kwfKndsJv/2PZb/Tre8fBaUzcL7p/COLxxMAR7tnH2io9CzPZiA9WALk
   2CHHMNzNMjzTL8qYg9067piKK+Q0uaR9Rkm6yLW4HAtzLllIv40ISFieC
   A==;
X-CSE-ConnectionGUID: H16PUm1KSgOY5w4iRecgAw==
X-CSE-MsgGUID: UZwYrOIMRmyTdmzuSrC/dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="47950122"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="47950122"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:11:14 -0700
X-CSE-ConnectionGUID: xuZCinpVSzu60sPZ4LJ70g==
X-CSE-MsgGUID: ZI+qmaGRThuotURKYdK1wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124817289"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:11:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 26 Mar 2025 17:11:04 +0200 (EET)
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
Subject: Re: [PATCH v6 4/6] PCI/IOV: Check that VF BAR fits within the
 reservation
In-Reply-To: <20250320110854.3866284-5-michal.winiarski@intel.com>
Message-ID: <4959d675-edd8-a296-661c-6a7bd22fbc0d@linux.intel.com>
References: <20250320110854.3866284-1-michal.winiarski@intel.com> <20250320110854.3866284-5-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1797840117-1743001864=:942"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1797840117-1743001864=:942
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 20 Mar 2025, Micha=C5=82 Winiarski wrote:

> When the resource representing VF MMIO BAR reservation is created, its
> size is always large enough to accommodate the BAR of all SR-IOV Virtual
> Functions that can potentially be created (total VFs). If for whatever
> reason it's not possible to accommodate all VFs - the resource is not
> assigned and no VFs can be created.
>=20
> The following patch will allow VF BAR size to be modified by drivers at

"The following patch" sounds to be like you're referring to patch that=20
follows this description, ie., the patch below. "An upcoming change" is=20
alternative that doesn't suffer from the same problem.

> a later point in time, which means that the check for resource
> assignment is no longer sufficient.
>=20
> Add an additional check that verifies that VF BAR for all enabled VFs
> fits within the underlying reservation resource.

So this does not solve the case where the initial size was too large to=20
fix and such VF BARs remain unassigned, right?

> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/pci/iov.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index cbf335725d4fb..861273ad9a580 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -646,8 +646,13 @@ static int sriov_enable(struct pci_dev *dev, int nr_=
virtfn)
> =20
>  =09nres =3D 0;
>  =09for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> +=09=09resource_size_t vf_bar_sz =3D
> +=09=09=09pci_iov_resource_size(dev,
> +=09=09=09=09=09      pci_resource_num_from_vf_bar(i));

Please add int idx =3D pci_resource_num_from_vf_bar(i);

>  =09=09bars |=3D (1 << pci_resource_num_from_vf_bar(i));
>  =09=09res =3D &dev->resource[pci_resource_num_from_vf_bar(i)];
> +=09=09if (vf_bar_sz * nr_virtfn > resource_size(res))
> +=09=09=09continue;

Not directly related to this patch, I suspect this could actually try to=20
assign an unassigned resource by doing something like this (perhaps in own=
=20
patch, it doesn't even need to be part of this series but can be sent=20
later if you find the suggestion useful):

=09=09/* Retry assignment if the initial size didn't fit */
=09=09if (!res->parent && pci_assign_resource(res, idx))
=09=09=09continue;

Although I suspect reset_resource() might have been called for the=20
resource and IIRC it breaks the resource somehow but it could have been=20
that IOV resources can be resummoned from that state though thanks to=20
their size not being stored into the resource itself but comes from iov=20
structures.

>  =09=09if (res->parent)
>  =09=09=09nres++;
>  =09}
>=20

--=20
 i.

--8323328-1797840117-1743001864=:942--

