Return-Path: <linux-pci+bounces-11589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FC194EB48
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 12:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484331C21688
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 10:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8D516FF2A;
	Mon, 12 Aug 2024 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2JcfTjP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A516F0E3;
	Mon, 12 Aug 2024 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459003; cv=none; b=QzLYSPJeKsf0pVQbPDWMEvC4yh69iZWYU5D6tBWq6Rpf3rzs/pfzeiXqtnj+jGd2xsFnL5c53owOJXwHngkrFM4ikAUYXCfABXQgn4/BAxsRwoNt6L8AcFw31pAEiqVRJhLctYCdncYmbBG0Qv4kbMR8hCBeHSZqNhQThbFXQoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459003; c=relaxed/simple;
	bh=Qb6jAUhVjK8W6QarbFw1RfFPANuHV8vfIMDQdFdwoc0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qpLEHnA2VNytUO3rVM3MGwCCx8VO85LoI6bQ/bpKYZplFTZIY6DwlKuW6NdrFw/Pk57/gTZVUMIRY8CsrD52484R1HCGSY7W8RxvdQUpFoN2nqFT4k/8cJCdA3BMhbNJOFyWLf+JXBZ/gyOCkXkYYPM+v8HLZ+8pgKlb3yOmziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2JcfTjP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723459002; x=1754995002;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Qb6jAUhVjK8W6QarbFw1RfFPANuHV8vfIMDQdFdwoc0=;
  b=T2JcfTjPzOWshwt8+kKHExUVuYOHMh1AoRf6TfLYeqRUnLa5yI/eJmGQ
   4Oh5rThFMenKKashXzG3RljP5jn/VqFVQsDuq76WaVBN/GP818BzHNV5D
   2aIGU5FAXjJQkarIktoyib1zZVcvvOn+wRA1J3VzXkcJWomsJCasNT2Cc
   krr+r51gpM9To3QWfq58z/G88k8UVQ209q5pkS6HjIKTeUau/RjhwCeOP
   esLcRcvahZEJsqPgBiMmZnBvJh0wWT0o5GL7gn7ASVX7GTjhO/gf4NyPl
   6ly3ZtCdd+QSf+N6+VvoksML0HSojpA6XmbnInOkitEqKxb8IupeH9LJs
   Q==;
X-CSE-ConnectionGUID: mP1Z5jtMQh+dnvtDaqKRIg==
X-CSE-MsgGUID: e5bqMv+RQ+qP5bnct++/bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32138253"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32138253"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 03:36:40 -0700
X-CSE-ConnectionGUID: MKR8R4EvS4+eZ/HCfqXS0w==
X-CSE-MsgGUID: bu/JthxeQUiR02FtOSI8mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="62617183"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 03:36:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Aug 2024 13:36:36 +0300 (EEST)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Matthew W Carlis <mattc@purestorage.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] PCI: Revert to the original speed after PCIe
 failed link retraining
In-Reply-To: <alpine.DEB.2.21.2408091204580.61955@angie.orcam.me.uk>
Message-ID: <d2110cf7-7dd1-73b3-d139-746588b2967f@linux.intel.com>
References: <alpine.DEB.2.21.2408091017050.61955@angie.orcam.me.uk> <alpine.DEB.2.21.2408091204580.61955@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1136569245-1723458996=:1039"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1136569245-1723458996=:1039
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 9 Aug 2024, Maciej W. Rozycki wrote:

> When `pcie_failed_link_retrain' has failed to retrain the link by hand=20
> it leaves the link speed restricted to 2.5GT/s, which will then affect=20
> any device that has been plugged in later on, which may not suffer from=
=20
> the problem that caused the speed restriction to have been attempted. =20
> Consequently such a downstream device will suffer from an unnecessary=20
> communication throughput limitation and therefore performance loss.
>=20
> Remove the speed restriction then and revert the Link Control 2 register=
=20
> to its original state if link retraining with the speed restriction in=20
> place has failed.  Retrain the link again afterwards to remove any=20
> residual state, ignoring the result as it's supposed to fail anyway.
>=20
> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> Reported-by: Matthew W Carlis <mattc@purestorage.com>
> Link: https://lore.kernel.org/r/20240806000659.30859-1-mattc@purestorage.=
com/
> Link: https://lore.kernel.org/r/20240722193407.23255-1-mattc@purestorage.=
com/
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: stable@vger.kernel.org # v6.5+
> ---
> New change in v2.
> ---
>  drivers/pci/quirks.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> linux-pcie-failed-link-retrain-fail-unclamp.diff
> Index: linux-macro/drivers/pci/quirks.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-macro.orig/drivers/pci/quirks.c
> +++ linux-macro/drivers/pci/quirks.c
> @@ -66,7 +66,7 @@
>   * apply this erratum workaround to any downstream ports as long as they
>   * support Link Active reporting and have the Link Control 2 register.
>   * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
> - * request a retrain and wait 200ms for the data link to go up.
> + * request a retrain and check the result.
>   *
>   * If this turns out successful and we know by the Vendor:Device ID it i=
s
>   * safe to do so, then lift the restriction, letting the devices negotia=
te
> @@ -74,6 +74,10 @@
>   * firmware may have already arranged and lift it with ports that alread=
y
>   * report their data link being up.
>   *
> + * Otherwise revert the speed to the original setting and request a retr=
ain
> + * again to remove any residual state, ignoring the result as it's suppo=
sed
> + * to fail anyway.
> + *
>   * Return TRUE if the link has been successfully retrained, otherwise FA=
LSE.
>   */
>  bool pcie_failed_link_retrain(struct pci_dev *dev)
> @@ -92,6 +96,8 @@ bool pcie_failed_link_retrain(struct pci
>  =09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>  =09if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) =3D=3D
>  =09    PCI_EXP_LNKSTA_LBMS) {
> +=09=09u16 oldlnkctl2 =3D lnkctl2;
> +
>  =09=09pci_info(dev, "broken device, retraining non-functional downstream=
 link at 2.5GT/s\n");
> =20
>  =09=09lnkctl2 &=3D ~PCI_EXP_LNKCTL2_TLS;
> @@ -100,6 +106,9 @@ bool pcie_failed_link_retrain(struct pci
> =20
>  =09=09if (pcie_retrain_link(dev, false)) {
>  =09=09=09pci_info(dev, "retraining failed\n");
> +=09=09=09pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
> +=09=09=09=09=09=09   oldlnkctl2);
> +=09=09=09pcie_retrain_link(dev, false);
>  =09=09=09return false;
>  =09=09}

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1136569245-1723458996=:1039--

