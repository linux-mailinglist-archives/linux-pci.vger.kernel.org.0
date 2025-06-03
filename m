Return-Path: <linux-pci+bounces-28843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB005ACC2B4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 11:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9B91891FD5
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 09:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4176328152B;
	Tue,  3 Jun 2025 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lliJDhkg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AE628151C;
	Tue,  3 Jun 2025 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748941874; cv=none; b=oV5ZckrrA3HYXqDBig1mphGgygw9a3HB/5gXQaCBvrUAmIRH/KdhXJDwtZKxTSZQLRBZ1mP5ulIW+YnLuiw0C4Uv+5eDPmvXWcvcCLhi8UHe5nsFDWY/dZF+sJU9yPBky4Ijo+x2jWGOJ9PF7c480m4HXOXwmlqhYz5X2RdGK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748941874; c=relaxed/simple;
	bh=gVK42G4dFjcGNb5SBkOPqqLEKwkFEd8sBXqVtBc+jKI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Hi8mhGrfnWG4zH4H0LZOF2LdaLQCeMsaEzY03RZzU0pQAGYHH4ZH5MI3Oit/yI6fcO+XrLeorpapJgMm1YzFaJIEsib8y9hiZNGGtZCUKI/2neUKZiXNUsGn3ILtRGErSSTSF3wj8LdguCOYvMyVW32vLMMCxtrxw860QE6tEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lliJDhkg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748941872; x=1780477872;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gVK42G4dFjcGNb5SBkOPqqLEKwkFEd8sBXqVtBc+jKI=;
  b=lliJDhkgkh59mAOeJaQkRgeJyoY0+uLssR8C+T36WoDFgy/YFgURa4g7
   LCW4XAUduqkgVf4Ay6bgBF6Y6BihPDmWDyB61QDVl/OdKen2YVP9HfZth
   WpdUckl0Fmx+59k+XYOzh3SPbXQXTVoP4OULWZkhtf7ASztip0+jQ90dW
   xJd/Iaz/wJ3htyDtjiffV0h6zKLQ+Ngb8JZcT0SosfTN1YrgHUy8s3Fuq
   kDRbsq9PxhRth6+f+vVuF46gxiuVLg/JzqAN8AReJXJ3TjX0aF//w6xmG
   ILg0T40nU1tfAx09/gsiERe31iz/1sD7eX4/6wJhFzEm0zVLgmYQtLTmK
   w==;
X-CSE-ConnectionGUID: 2Ppsz6sMTee2Hwxd/Fl53w==
X-CSE-MsgGUID: aIqTSQErT1KF+tts4023Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68404116"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="68404116"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:11:10 -0700
X-CSE-ConnectionGUID: 1pVQX+tgQjKDUXRxXr9kQw==
X-CSE-MsgGUID: ITOxGlMwRRePsXOFXoUkvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="145428441"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:11:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 12:11:04 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: bhelgaas@google.com, kwilczynski@kernel.org, 
    manivannan.sadhasivam@linaro.org, jhp@endlessos.org, 
    daniel.stodden@gmail.com, ajayagarwal@google.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ASPM: Use boolean type for aspm_disabled and
 aspm_force
In-Reply-To: <20250517154939.139237-1-18255117159@163.com>
Message-ID: <b363ab02-a2b4-9c5d-42ea-feb208d32c5d@linux.intel.com>
References: <20250517154939.139237-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1210779517-1748941864=:937"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1210779517-1748941864=:937
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 17 May 2025, Hans Zhang wrote:

> The aspm_disabled and aspm_force variables are used as boolean flags.
> Change their type from int to bool and update assignments to use
> true/false instead of 1/0. This improves code clarity.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/pcie/aspm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 29fcb0689a91..98b3022802b2 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -245,7 +245,7 @@ struct pcie_link_state {
>  =09u32 clkpm_disable:1;=09=09/* Clock PM disabled */
>  };
> =20
> -static int aspm_disabled, aspm_force;
> +static bool aspm_disabled, aspm_force;
>  static bool aspm_support_enabled =3D true;
>  static DEFINE_MUTEX(aspm_lock);
>  static LIST_HEAD(link_list);
> @@ -1712,11 +1712,11 @@ static int __init pcie_aspm_disable(char *str)
>  {
>  =09if (!strcmp(str, "off")) {
>  =09=09aspm_policy =3D POLICY_DEFAULT;
> -=09=09aspm_disabled =3D 1;
> +=09=09aspm_disabled =3D true;
>  =09=09aspm_support_enabled =3D false;
>  =09=09pr_info("PCIe ASPM is disabled\n");
>  =09} else if (!strcmp(str, "force")) {
> -=09=09aspm_force =3D 1;
> +=09=09aspm_force =3D true;
>  =09=09pr_info("PCIe ASPM is forcibly enabled\n");
>  =09}
>  =09return 1;
> @@ -1734,7 +1734,7 @@ void pcie_no_aspm(void)
>  =09 */
>  =09if (!aspm_force) {
>  =09=09aspm_policy =3D POLICY_DEFAULT;
> -=09=09aspm_disabled =3D 1;
> +=09=09aspm_disabled =3D true;
>  =09}
>  }

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1210779517-1748941864=:937--

