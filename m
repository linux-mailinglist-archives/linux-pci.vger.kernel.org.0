Return-Path: <linux-pci+bounces-12194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DC595ECE9
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 11:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0972819AA
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E0413CA9C;
	Mon, 26 Aug 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7vqHooc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E58172A;
	Mon, 26 Aug 2024 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663821; cv=none; b=UGJM6aQgF/4FYMsbM1FYle+ceQOBg5eGBuDs2I83d53RXHjXl7POXgQMaszioq4dGXxTN24Q7Xc3fCXjkiSso+N6D1xTXkVx8YMvKtmsj7kobRj+ciKMPaVgQuvvfsbVL2bj0cFNub70QrYC8QNpXKrTml9TJtdOFDbQnGpxiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663821; c=relaxed/simple;
	bh=ucDCZHH9q43sDJFvaNUh5wuUi566REaO2LKCT0DkCAg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SyKimAkACJGv+9KyoSlgdbDtGje2q6I/N54wvViKWsl8yBDkIvmgj0ACKRugPQ264XXbM0mYEdi8XnpXeUin4Dl8w7xVFDAur3vDihCoJI07OQrU+IV++81YKzQh0gV/c/HCuvQzyQvXsY7qGCLyljIEz9Ldy2QD5fDkz29J7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7vqHooc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724663820; x=1756199820;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ucDCZHH9q43sDJFvaNUh5wuUi566REaO2LKCT0DkCAg=;
  b=g7vqHoocBcalJqDNgOK0+nHSeqEM5FCNiuRy3nhD9FBauCx5SW5r99d9
   Q/ZoXTa1aO+PE5qw3fl8KsmZPRMvQI5eADH+XgxZaaUqesvoWrTny0jC+
   eLPY2R6uM1rd9C4vtuuTyGFEsftQO5vUR0F/3nysdq2r0mcD2bj6od69B
   YzCSu5NDdP0L9MKiTsZbzIanid7apy47OlqCXw7XzPxzQGYivLCxs3gSF
   D0NpOUXDNJ1PU/XoMld1eHIXpSX92IngbJzUoocqynfSxBmXDGZdhQmNV
   3cdT0phbHcC2hRwHXId3TwbBrrjFkrimW9R/WCd6s3WQzJY9BugtGQ3GW
   w==;
X-CSE-ConnectionGUID: VaLPiWrWS1e86g5acCPPSQ==
X-CSE-MsgGUID: 5ZXgTWc3RyKTjYTP4sNT6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="23229363"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="23229363"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:16:59 -0700
X-CSE-ConnectionGUID: etMzg08HQ0KODBTDShMejA==
X-CSE-MsgGUID: r5Cz6iMDTRu6Bbf26H+RvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="93253478"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:16:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Aug 2024 12:16:51 +0300 (EEST)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Matthew W Carlis <mattc@purestorage.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] PCI: Revert to the original speed after PCIe
 failed link retraining
In-Reply-To: <alpine.DEB.2.21.2408251412590.30766@angie.orcam.me.uk>
Message-ID: <db382712-8b71-3f1c-bffd-7b35921704c7@linux.intel.com>
References: <alpine.DEB.2.21.2408251354540.30766@angie.orcam.me.uk> <alpine.DEB.2.21.2408251412590.30766@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-639461899-1724663811=:1013"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-639461899-1724663811=:1013
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 25 Aug 2024, Maciej W. Rozycki wrote:

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
> place has failed.  Retrain the link again afterwards so as to remove any=
=20
> residual state, waiting on LT rather than DLLLA to avoid an excessive=20
> delay and ignoring the result as this training is supposed to fail anyway=
=2E
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
> Changes from v2:
>=20
> - Wait on LT rather than DLLLA with clean-up retraining with the speed=20
>   restriction lifted, so as to avoid an excessive delay as it's supposed=
=20
>   to fail anyway.
>=20
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
> +=09=09=09pcie_retrain_link(dev, true);

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


--8323328-639461899-1724663811=:1013--

