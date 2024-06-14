Return-Path: <linux-pci+bounces-8831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C997B908C2F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 15:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DD5289C13
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB3113B797;
	Fri, 14 Jun 2024 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRjipV/G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5143D14884C;
	Fri, 14 Jun 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718370070; cv=none; b=kFVem0+/s4tzxeP4kfYPf0mWUrLYGj5nszfIMo0oVJDndhQyekYHeeKpPTS//fyludZLqaVEUp/DyPFLfU0VG94ymEdAwYPjeZktgU+HNnNRckrBEUc2HMkC9p2nxSbssBaIboIRh2iGTlQ6M9bH1n5SMKYwztfSX0dbNe5ptxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718370070; c=relaxed/simple;
	bh=9w0oxfZW3tzeT9Qsfui1ClN8mhXS4JJ7xFStryXFdiE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qQB74gRI3enBNJs+Lmof5sqzE/J/7cKdCifRynRiVpVvQSqLasuUn4RfFI+XxhDCPnBz56off4KOrxoxS6PLy37frG5Nc+zdLBHXenOckLxf6tuS5pc08subEdt0RpX3uO5/9pyp0uu51kIK/IEGnmDhypounnmySVMp/Z21lLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRjipV/G; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718370069; x=1749906069;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9w0oxfZW3tzeT9Qsfui1ClN8mhXS4JJ7xFStryXFdiE=;
  b=mRjipV/G82fWpCS8EVGxRhFstjypPIFlMWweNXguoDZ1KJ6iCwcizH4e
   BcXYcOFOBbK8W7i7Tj69Yhbgwq+XWewE3500L2o6WQuq8W1urqbM6FMJI
   nNif96g84n+o/HwcpEC0r8sPUHxMV8BrCQRMlcCm3Yif2wsmxdf35dCoc
   DzRSv/ix7Ira4w3rMtiq1HzM3lVA1UG4oKiL31O8sq5Y8PLyEbIWD2r7F
   Bx7+2utx3bLb7ucTF4jUVKt6wbViQBy6t0UV8Yvbx3pNPxKntdiCp/IZX
   JsoMzFYc8OaBay7i7onF06ETFbHJFRsojsk+IjpLhTuPQH6EC5w/N4jDq
   w==;
X-CSE-ConnectionGUID: aweVGN1eQ0SHI+ae25G0zQ==
X-CSE-MsgGUID: Pjmls1RxToyt1cwfiWNpaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="18174144"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="18174144"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:01:08 -0700
X-CSE-ConnectionGUID: XcaeA88/TC6G0Aa5E0hrSg==
X-CSE-MsgGUID: hX1ZIzpIQzC6QNcKUEiMkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="63695069"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:01:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Jun 2024 16:01:01 +0300 (EEST)
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Frank Li <Frank.Li@nxp.com>, Jon Mason <jdmason@kudzu.us>, 
    Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Kishon Vijay Abraham I <kishon@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: endpoint: Fix epf_ntb_epc_cleanup() a bit
In-Reply-To: <aaffbe8d-7094-4083-8146-185f4a84e8a1@moroto.mountain>
Message-ID: <7ae11357-6284-9afa-2272-19e796bc2018@linux.intel.com>
References: <aaffbe8d-7094-4083-8146-185f4a84e8a1@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1326312854-1718370061=:1013"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1326312854-1718370061=:1013
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 10 Jun 2024, Dan Carpenter wrote:

> There are two issues related to epf_ntb_epc_cleanup().
> 1) It should call epf_ntb_config_sspad_bar_clear().
> 2) The epf_ntb_bind() function should call epf_ntb_epc_cleanup()
>    to cleanup.
>=20
> I also changed the ordering a bit.  Unwinding should be done in the
> mirror order from how they are allocated.
>=20
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and =
EP")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index 7f05a44e9a9f..874cb097b093 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -799,8 +799,9 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>   */
>  static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
>  {
> -=09epf_ntb_db_bar_clear(ntb);
>  =09epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
> +=09epf_ntb_db_bar_clear(ntb);
> +=09epf_ntb_config_sspad_bar_clear(ntb);
>  }
> =20
>  #define EPF_NTB_R(_name)=09=09=09=09=09=09\
> @@ -1337,7 +1338,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  =09ret =3D pci_register_driver(&vntb_pci_driver);
>  =09if (ret) {
>  =09=09dev_err(dev, "failure register vntb pci driver\n");
> -=09=09goto err_bar_alloc;
> +=09=09goto err_epc_cleanup;
>  =09}
> =20
>  =09ret =3D vpci_scan_bus(ntb);
> @@ -1348,6 +1349,8 @@ static int epf_ntb_bind(struct pci_epf *epf)
> =20
>  err_unregister:
>  =09pci_unregister_driver(&vntb_pci_driver);
> +err_epc_cleanup:
> +=09epf_ntb_epc_cleanup(ntb);
>  err_bar_alloc:
>  =09epf_ntb_config_spad_bar_free(ntb);

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1326312854-1718370061=:1013--

