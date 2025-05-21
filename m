Return-Path: <linux-pci+bounces-28191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F88ABF046
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138251BA77C6
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24EF25394E;
	Wed, 21 May 2025 09:43:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3174E1A3BD7;
	Wed, 21 May 2025 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820626; cv=none; b=tYrB4uq5ibzYIoPHcQSyV/hT4+kRHbFscS/0fl4/vSC/Fv2OlKR9HZEdixUU90wNPvSxwXp1xwhGiDcJ8tqhjnxuiKFiHPUGd1/RX6pj8CuRfFzp36Zr+veDYsXBRZ0DrnXSVt2zIz7M65k6lrQTGoWEBTOVMxoGAo7fcEYltUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820626; c=relaxed/simple;
	bh=EpMirKs3V4vscdqhbkz9OdoZWXChfs/1azyGpZR/Es4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4L9CFPO54IHSxekJXLPQa3s4CfnooSYga/6NVbz0d54iZX7WQl0U1TlVxFL3c21LACcGAsigksEvvU+6LZNBANjuAIa4Nqasmfw2lvklsTyP44QImw/kI7xkW8t3SiMa95r3gXfgjbCarg4iA2up4VUPe9nIDcR8W3GoN+Z05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2RHD2zfWz6L55h;
	Wed, 21 May 2025 17:40:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AF3614020A;
	Wed, 21 May 2025 17:43:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 11:43:34 +0200
Date: Wed, 21 May 2025 10:43:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Jon Pan-Doh <pandoh@google.com>, "Karolina
 Stolarek" <karolina.stolarek@oracle.com>, Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller
	<ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, "Anil
 Agrawal" <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, Ilpo
 =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Sathyanarayanan
 Kuppuswamy" <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner
	<lukas@wunner.de>, Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney"
	<paulmck@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver
 O'Halloran" <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, "Keith
 Busch" <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v7 10/17] PCI/AER: Update statistics early in logging
Message-ID: <20250521104331.00001a6a@huawei.com>
In-Reply-To: <20250520215047.1350603-11-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
	<20250520215047.1350603-11-helgaas@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 20 May 2025 16:50:27 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> There are two AER logging entry points:
>=20
>   - aer_print_error() is used by DPC (dpc_process_error()) and native AER
>     handling (aer_process_err_devices()).
>=20
>   - pci_print_aer() is used by GHES (aer_recover_work_func()) and CXL
>     (cxl_handle_rdport_errors())
>=20
> Both use __aer_print_error() to print the AER error bits.  Previously
> __aer_print_error() also incremented the AER statistics via
> pci_dev_aer_stats_incr().
>=20
> Call pci_dev_aer_stats_incr() early in the entry points instead of in
> __aer_print_error() so we update the statistics even if the actual printi=
ng
> of error bits is rate limited by a future change.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
Always felt odd that a stat got updated in a _print_ function
so even without the other reasoning this is a good change.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pcie/aer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d845079429f0..53b7559564a9 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -693,7 +693,6 @@ static void __aer_print_error(struct pci_dev *dev,
>  		aer_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
>  				info->first_error =3D=3D i ? " (First)" : "");
>  	}
> -	pci_dev_aer_stats_incr(dev, info);
>  }
> =20
>  static void aer_print_source(struct pci_dev *dev, struct aer_err_info *i=
nfo,
> @@ -714,6 +713,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_=
err_info *info)
>  	int id =3D pci_dev_id(dev);
>  	const char *level;
> =20
> +	pci_dev_aer_stats_incr(dev, info);
> +
>  	if (!info->status) {
>  		pci_err(dev, "PCIe Bus Error: severity=3D%s, type=3DInaccessible, (Unr=
egistered Agent ID)\n",
>  			aer_error_severity_string[info->severity]);
> @@ -782,6 +783,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_sever=
ity,
>  	info.status =3D status;
>  	info.mask =3D mask;
> =20
> +	pci_dev_aer_stats_incr(dev, &info);
> +
>  	layer =3D AER_GET_LAYER_ERROR(aer_severity, status);
>  	agent =3D AER_GET_AGENT(aer_severity, status);
> =20


