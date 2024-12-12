Return-Path: <linux-pci+bounces-18294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA8C9EE8E9
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 15:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FCA283D23
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 14:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F4B2153DC;
	Thu, 12 Dec 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7aODASg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F712153D2
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014012; cv=none; b=ZcyanB1xUE/7a2w5Du7VPohhzdEUN+OKHtV5zoofChthj/mJZ/gI01CN80pP9TpIIP/df8xxICTWN2htBgfU15kyz9jl1FWx2AT3ZWFfe97FEZymXLr8tBDKFnSrtsZFB+Q7ejYJmaCLNEN2Jb3XWugqFAKbbPugY3wamMctP6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014012; c=relaxed/simple;
	bh=kTwStEfotmE25Gog1Ab6lG6O4N/rG67DyCOjpxw5Cxw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qxA862YKpT3HXa6byeFE6VrkvS8uRvhVGNaXdrgQTUOFV9uH1+uXzikg+G/iSPZZ4TxhVobJBfTVaxRgbbOAsc+5YyvPmGFZWTXeCEQ+tFoWot1pJC+nz5DS9ocpCwCIBozZB7CvCRqdgcYWkQmarPU7woxNX1NbK+PtWIcaQTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7aODASg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734014010; x=1765550010;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=kTwStEfotmE25Gog1Ab6lG6O4N/rG67DyCOjpxw5Cxw=;
  b=a7aODASgYSMwOOhALsS4jeQg4lNiZbYuyeE0Vdn2AOdNB7H+8Kj/j8rE
   /d75cURB4E1UWuphrXBn8DPe9c2GKG9uZV00o5te57xcVu3iP5SiLGTb/
   YM3OKcCkMWvB++D8691InssS29t65+mImrypOqDzxcENN4QhPL7Dj+3QH
   k9TGzA1+aIbifyGW1673XZpy5kWND61OIp7SwQvR/ea4H/xpZXIujgNvQ
   xNP8UJ4m2n7N7ZBJ+l25mKp7jE8jAdjc25mIxRP4YTtTrrfSNMMCiIsTJ
   kiTXo2fUZD7bUsU08v0Bo3xxzbFK4HDiYWrXKyGp5v7/H3iwkn41qCJsl
   Q==;
X-CSE-ConnectionGUID: EulIk/5GQ8CkEqCTlElakg==
X-CSE-MsgGUID: ATPk/yo0QwGQBDjaYAoy0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="33741186"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="33741186"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:33:29 -0800
X-CSE-ConnectionGUID: IoZ7gBO9TF2LCojeixZjXQ==
X-CSE-MsgGUID: Brfz69gsTsCzp3z4J9xcCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="101343430"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.137])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:33:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 12 Dec 2024 16:33:23 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    Niklas Schnelle <niks@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH for-linus] PCI: Honor Max Link Speed when determining
 supported speeds
In-Reply-To: <e3386d62a766be6d0ef7138a001dabfe563cdff8.1733991971.git.lukas@wunner.de>
Message-ID: <30db80fd-15bd-c4a7-9f73-a86a062bce52@linux.intel.com>
References: <e3386d62a766be6d0ef7138a001dabfe563cdff8.1733991971.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2084276406-1734013701=:936"
Content-ID: <94eb8db2-6540-0de1-70e9-616dfe1f32a5@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2084276406-1734013701=:936
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <bea54e28-ab79-f7fd-83d7-b4ee81915216@linux.intel.com>

On Thu, 12 Dec 2024, Lukas Wunner wrote:

> The Supported Link Speeds Vector in the Link Capabilities 2 Register
> indicates the *supported* link speeds.  The Max Link Speed field in
> the Link Capabilities Register indicates the *maximum* of those speeds.
>=20
> Niklas reports that the Intel JHL7540 "Titan Ridge 2018" Thunderbolt
> controller supports 2.5-8 GT/s speeds, but indicates 2.5 GT/s as maximum.
> Ilpo recalls seeing this inconsistency on more devices.
>=20
> pcie_get_supported_speeds() neglects to honor the Max Link Speed field
> and will thus incorrectly deem higher speeds as supported.  Fix it.
>=20
> Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> Reported-by: Niklas Schnelle <niks@kernel.org>
> Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780d136=
9.camel@kernel.org/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 35dc9f2..b730560 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6240,12 +6240,14 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
>  =09pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
>  =09speeds =3D lnkcap2 & PCI_EXP_LNKCAP2_SLS;
> =20
> +=09/* Ignore speeds higher than Max Link Speed */
> +=09pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> +=09speeds &=3D GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS, 0);

Hi Lukas,

Why do you start GENMASK() from 0th position? That's the reserved bit.
(I doesn't exactly cause a misbehavior to & the never set 0th bit but
it is slightly confusing).

I suggest to get that either from PCI_EXP_LNKCAP2_SLS_2_5GB or=20
PCI_EXP_LNKCAP2_SLS (e.g. with __ffs()) and do not use literal at all
to make it explicit where it originates from.

--=20
 i.

> +
>  =09/* PCIe r3.0-compliant */
>  =09if (speeds)
>  =09=09return speeds;
> =20
> -=09pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> -
>  =09/* Synthesize from the Max Link Speed field */
>  =09if ((lnkcap & PCI_EXP_LNKCAP_SLS) =3D=3D PCI_EXP_LNKCAP_SLS_5_0GB)
>  =09=09speeds =3D PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;
>=20
--8323328-2084276406-1734013701=:936--

