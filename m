Return-Path: <linux-pci+bounces-3344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34518512F3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 13:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE11B282053
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9023A8FD;
	Mon, 12 Feb 2024 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VewNf8WA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF53A8F3;
	Mon, 12 Feb 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739295; cv=none; b=gGqFaX4kMmfVSxsNqiqqKXKB/nyv6OYjFCWoNmH6ZtVd5RereMoxGH6SJTRGuWCw9Rv7Pg3DJCCl3xJkoke2vla3qwZ7neaSU41ugs7cmqfjr5aTL6htuprZ5yA8+QyG0qqBs35kXxxQN1EXJTXBI9rH8tQZHY6yR99oJfixYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739295; c=relaxed/simple;
	bh=6JvoMl+MHdSsuOMcAJwraxyF5vh1I7HnMGQ855T0VP8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dEBveNKwWK+NP4kYu4GlkX1MmZLuTxNLrKg8LcVQnsS3vtwbtzJXGYwt6y5BX+mD4xNmJf1+lklwxLl7GWIEDQGzwIYLMAkj6nRtT9hCKnYAqX1j+An8dIPN/I6tPt+8QBIG3toUR58SpiThPmA6XCoeUT5/fpGmD9hs/PIdhp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VewNf8WA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707739294; x=1739275294;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6JvoMl+MHdSsuOMcAJwraxyF5vh1I7HnMGQ855T0VP8=;
  b=VewNf8WAu2VJhTS/NeCpBjr53C+KnQPwsj2ErGx36r8fQoEbDzDzPfaP
   uevvIcAR5qgnqLKIQovNYoPCxPcQPaxfV8rwys3A7Mfys42UFbuStDmSv
   WviuZUvK2ul3Klfkp7fli6CdkTIGW0IXzc/1NT7LRGlvMxSUQ5XUqD02T
   D9TSpBBWW/Z4kMs/mTFh2GzsTpG1bK1QLB5c6sTz2h47rLh+nHonJzgC+
   HkrwwlI1OcGweZUZhbKJ/Bd8dSZV5flzv5aYshJgMS/Hg+kV5fiDNJywC
   60OjOfGf1utGl2uxQ+kiNj34/IzdU+/SgNwC3Es1uEbpYJbNESdX7c0Ub
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12800646"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="12800646"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:01:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2576576"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.160])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:01:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Feb 2024 14:01:25 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: Correct error reporting with PCIe failed link
 retraining
In-Reply-To: <alpine.DEB.2.21.2402100045590.2376@angie.orcam.me.uk>
Message-ID: <f4eafdbc-b295-a982-fe8e-dbd11b98d56f@linux.intel.com>
References: <alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk> <alpine.DEB.2.21.2402100045590.2376@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-194427090-1707739285=:1013"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-194427090-1707739285=:1013
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 10 Feb 2024, Maciej W. Rozycki wrote:

> Only return successful completion status from `pcie_failed_link_retrain'=
=20
> if retraining has actually been done, preventing excessive delays from=20
> being triggered at call sites in a hope that communication will finally=
=20
> be established with the downstream device where in fact nothing has been=
=20
> done about the link in question that would justify such a hope.
>=20
> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> Reported-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Link: https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linu=
x.intel.com/
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: stable@vger.kernel.org # v6.5+

Thanks.

The original thread might be useful for context if somebody has to look at=
=20
this change later on from the history, so:

Link: https://lore.kernel.org/linux-pci/20240129112710.2852-2-ilpo.jarvinen=
@linux.intel.com/T/#u

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/pci/quirks.c |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> linux-pcie-failed-link-retrain-status-fix.diff
> Index: linux-macro/drivers/pci/quirks.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-macro.orig/drivers/pci/quirks.c
> +++ linux-macro/drivers/pci/quirks.c
> @@ -74,7 +74,8 @@
>   * firmware may have already arranged and lift it with ports that alread=
y
>   * report their data link being up.
>   *
> - * Return TRUE if the link has been successfully retrained, otherwise FA=
LSE.
> + * Return TRUE if the link has been successfully retrained, otherwise FA=
LSE,
> + * also when retraining was not needed in the first place.
>   */
>  bool pcie_failed_link_retrain(struct pci_dev *dev)
>  {
> @@ -83,10 +84,11 @@ bool pcie_failed_link_retrain(struct pci
>  =09=09{}
>  =09};
>  =09u16 lnksta, lnkctl2;
> +=09bool ret =3D false;
> =20
>  =09if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
>  =09    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
> -=09=09return false;
> +=09=09return ret;
> =20
>  =09pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>  =09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> @@ -98,9 +100,10 @@ bool pcie_failed_link_retrain(struct pci
>  =09=09lnkctl2 |=3D PCI_EXP_LNKCTL2_TLS_2_5GT;
>  =09=09pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
> =20
> -=09=09if (pcie_retrain_link(dev, false)) {
> +=09=09ret =3D pcie_retrain_link(dev, false) =3D=3D 0;
> +=09=09if (!ret) {
>  =09=09=09pci_info(dev, "retraining failed\n");
> -=09=09=09return false;
> +=09=09=09return ret;
>  =09=09}
> =20
>  =09=09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> @@ -117,13 +120,14 @@ bool pcie_failed_link_retrain(struct pci
>  =09=09lnkctl2 |=3D lnkcap & PCI_EXP_LNKCAP_SLS;
>  =09=09pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
> =20
> -=09=09if (pcie_retrain_link(dev, false)) {
> +=09=09ret =3D pcie_retrain_link(dev, false) =3D=3D 0;
> +=09=09if (!ret) {
>  =09=09=09pci_info(dev, "retraining failed\n");
> -=09=09=09return false;
> +=09=09=09return ret;
>  =09=09}
>  =09}
> =20
> -=09return true;
> +=09return ret;
>  }
> =20
>  static ktime_t fixup_debug_start(struct pci_dev *dev,
>=20

--8323328-194427090-1707739285=:1013--

