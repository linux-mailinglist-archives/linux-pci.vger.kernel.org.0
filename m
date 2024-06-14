Return-Path: <linux-pci+bounces-8830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ABC908C20
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 14:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13891288663
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9057199E90;
	Fri, 14 Jun 2024 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3wNiDHn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2DA19A29B;
	Fri, 14 Jun 2024 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369879; cv=none; b=dzrxjmkvU7wroek6ksB2/rWZRHproOCbMncsvusDVn5IC5QXY3hG0wyHHSyJZiBMkKuWc9hGuWTF5YeueMboF0MHxN42gqyleSSg/JABlzSCkPl5xnl4m4Z8UNUuI7CAms+8oVvIG/RVA0uHvXx5wdSCaHINymwigltZxqMkifM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369879; c=relaxed/simple;
	bh=HCRovoAa1zGmgG0Pz8GJKQKP/C/f+F6NWJoVTm3RPws=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QOCSi3wnHcej3V44+xzSocQRbgsqyVVWHsJFvuyOferLXema36U7Q5LRNAlL7ETwnAjZ1MmmXSG4/Xs8JNLojtUBMNgbg8qL3bWhjh/CW3T+SjIAa5FMrpa3l+AYMJdng+2y86+I9wBRvMX7BDyqY46FsHJEw+rRI1bjI+QNYbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3wNiDHn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718369878; x=1749905878;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HCRovoAa1zGmgG0Pz8GJKQKP/C/f+F6NWJoVTm3RPws=;
  b=m3wNiDHnFbzkBn9QSdiwK3s4gouMFcaGrQcdl4ICjta5YAbjg1Ddx2Qr
   /METDPss+PZQ7RxlnptGBRAVM6G8VF/3VvnQi961zlHRS7sxxM2peeOLK
   E3HvJv+9+AXYYGKMP7aTIe0X3OQyKWRuiYiAUsKyp8SfuFpBVidYG91qw
   cr/OLrWyv0CjK20h7iC++biqNZYGT9oDpJv5txjHKDRqvUIzenGLtdM+7
   aIExSTvfZNm2ZawS1F/QlHcLQta4wmVBx41MS6uoBA+qLEb6jA2en4DOE
   thjcQ4ocLS/os3TioWmEkjU+ZYKHJHG2nrr4m1YZmFA9nJnCVsJDUtxg1
   Q==;
X-CSE-ConnectionGUID: ID2t8JSIQXaKMGmhmiLXMA==
X-CSE-MsgGUID: +VILcGYWTwmpUbPMJM0+5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="26649479"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="26649479"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:57:57 -0700
X-CSE-ConnectionGUID: ND41G8VNRSCad+rFwIws0w==
X-CSE-MsgGUID: +4i6ZaJFStGPQ2N0NBMx5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40456270"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:57:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Jun 2024 15:57:49 +0300 (EEST)
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Frank Li <Frank.Li@nxp.com>, Jon Mason <jdmason@kudzu.us>, 
    Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Kishon Vijay Abraham I <kishon@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: Clean up error handling in
 vpci_scan_bus()
In-Reply-To: <68e0f6a4-fd57-45d0-945b-0876f2c8cb86@moroto.mountain>
Message-ID: <d8f510d1-db05-66a8-b379-464fdc817143@linux.intel.com>
References: <68e0f6a4-fd57-45d0-945b-0876f2c8cb86@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1335945687-1718369869=:1013"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1335945687-1718369869=:1013
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 10 Jun 2024, Dan Carpenter wrote:

> Smatch complains about inconsistent NULL checking in vpci_scan_bus():
>=20
>     drivers/pci/endpoint/functions/pci-epf-vntb.c:1024 vpci_scan_bus()
>     error: we previously assumed 'vpci_bus' could be null (see line 1021)
>=20
> Instead of printing an error message and then crashing we should return
> an error code and clean up.  Also the NULL check is reversed so it
> prints an error for success instead of failure.
>=20
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and =
EP")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index 8e779eecd62d..7f05a44e9a9f 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1018,8 +1018,10 @@ static int vpci_scan_bus(void *sysdata)
>  =09struct epf_ntb *ndev =3D sysdata;
> =20
>  =09vpci_bus =3D pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
> -=09if (vpci_bus)
> -=09=09pr_err("create pci bus\n");
> +=09if (!vpci_bus) {
> +=09=09pr_err("create pci bus failed\n");
> +=09=09return -EINVAL;
> +=09}
> =20
>  =09pci_bus_add_devices(vpci_bus);
> =20
> @@ -1338,10 +1340,14 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  =09=09goto err_bar_alloc;
>  =09}
> =20
> -=09vpci_scan_bus(ntb);
> +=09ret =3D vpci_scan_bus(ntb);
> +=09if (ret)
> +=09=09goto err_unregister;
> =20
>  =09return 0;
> =20
> +err_unregister:
> +=09pci_unregister_driver(&vntb_pci_driver);
>  err_bar_alloc:
>  =09epf_ntb_config_spad_bar_free(ntb);

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-1335945687-1718369869=:1013--

