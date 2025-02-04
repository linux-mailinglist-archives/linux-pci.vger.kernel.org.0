Return-Path: <linux-pci+bounces-20689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26796A26D7A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 09:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E0B188448B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 08:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D386190468;
	Tue,  4 Feb 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLwTp8tv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8091213D8A4;
	Tue,  4 Feb 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738658735; cv=none; b=ToIVBylwHOlSuR9GQjhJHf5qb4UroI5phPhUKr1edWjn5pjUweB1n+5osqWYh7rZNHYfw0fU5kD50InKbtMWw7C+DOFxQTFKnuRnGumdJa+obSU0PpogVuRMAQNcy0Gx+giWgDD5JxSl4suCYkz65DUteWNcq9t1dnsoOByQUNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738658735; c=relaxed/simple;
	bh=SPpXPUpwk/W57k2iVLstC4U5AtSCuka53j4S57VXJHE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qm0c35+Upv1KMTDunArDtNoTOmOZTPRBS5W3tWTBrLa+RMGJQjgCa4sZ5iaNIXUGJNg+FTDzGePHGo9c4oH1IfZIWSjcOYpjhvvskXeQsSYrb0bAbA2tEnzRObN14agEsg0ON/PG+eHgR38cqbZDzyTCqwngSjMGEWo0Db7VeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLwTp8tv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738658734; x=1770194734;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SPpXPUpwk/W57k2iVLstC4U5AtSCuka53j4S57VXJHE=;
  b=JLwTp8tvYrSjmPn02qPDyUfeqkG3AHo5H3kaj9Y15oyvJWTsGUVV6ICz
   JLy4Hb4mTL3B8hPHtHe2Cv5Z941cKoSoMFdO8R2nqFZ/IJv+80UK0jEal
   44aWyrDwUlUrFjAmhU2aYKsE1lrbrQnxMHhV07VB46S8rRFS2Ftg9b6Mb
   MlWEAFz0514JhXTSqar0CzorR1dsAovvTekzXQdPDkLhu7v1vN228EKYW
   XIfLTnP1j9uUNy2232VwLyz/TvzLlbcTS+v25GUkbMAwGlm9oNTfjOr8Z
   2AngqlPNY65kMjoY39AuX6EbJbY6mxQx5InsY9TSOKI4r+bS16T2iD5+G
   w==;
X-CSE-ConnectionGUID: fvVKYzzIQLWo67Vh2dXdPA==
X-CSE-MsgGUID: /GD3MWSURGW4RwI3d5Nq6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="42923798"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="42923798"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 00:45:33 -0800
X-CSE-ConnectionGUID: nziqMhAiRK+uY5idikq9Qw==
X-CSE-MsgGUID: HdCMd7riT1SMFbw/Ka/uGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114576159"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.75])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 00:45:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Feb 2025 10:45:27 +0200 (EET)
To: Ma Ke <make24@iscas.ac.cn>
cc: bhelgaas@google.com, rafael.j.wysocki@intel.com, yinghai@kernel.org, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI: fix reference leak in pci_alloc_child_bus()
In-Reply-To: <20250202062357.872971-1-make24@iscas.ac.cn>
Message-ID: <c34742e8-cc03-49a9-386e-afb4d14a68b1@linux.intel.com>
References: <20250202062357.872971-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1449886408-1738658727=:1609"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1449886408-1738658727=:1609
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 2 Feb 2025, Ma Ke wrote:

> When device_register(&child->dev) failed, we should call put_device()
> to explicitly release child->dev.
>=20
> As comment of device_register() says, 'NOTE: _Never_ directly free
> @dev after calling this function, even if it returned an error! Always
> use put_device() to give up the reference initialized in this function
> instead.'
>=20
> Found by code review.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 4f535093cf8f ("PCI: Put pci_dev in device tree as early as possibl=
e")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v3:
> - modified the description as suggestions.
> Changes in v2:
> - added the bug description about the comment of device_add();
> - fixed the patch as suggestions;
> - added Cc and Fixes table.
> ---
>  drivers/pci/probe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e81ab0f5a25..51b78fcda4eb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1174,7 +1174,10 @@ static struct pci_bus *pci_alloc_child_bus(struct =
pci_bus *parent,
>  add_dev:
>  =09pci_set_bus_msi_domain(child);
>  =09ret =3D device_register(&child->dev);
> -=09WARN_ON(ret < 0);
> +=09if (WARN_ON(ret < 0)) {
> +=09=09put_device(&child->dev);
> +=09=09return NULL;
> +=09}
> =20
>  =09pcibios_add_bus(child);

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Unrelated to this fix, IMO that WARN_ON() is overkill and I'm skeptical=20
that printing a stack trace on a failure in device_register() is helpful.
IMO, a simple error print would suffice to tell something (unexpectedly)
went wrong here.

--=20
 i.

--8323328-1449886408-1738658727=:1609--

