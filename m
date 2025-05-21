Return-Path: <linux-pci+bounces-28202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6CAABF115
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 12:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC528E071D
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 10:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A8325A342;
	Wed, 21 May 2025 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AwH8a/60"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FF9253F3A;
	Wed, 21 May 2025 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822352; cv=none; b=KVDqEZr9T6w9hbDXf/N25ordnOss8HIJ4etTHpYx76/wPS1KAogE3hRJe4LJVzS50SyFCxDOe7etHkcNfX/aT/tdjVyX1RIlhOfvRSvkZcaPDGJgoXvGbR4yYyDfyBHL3jOf/UmSAMgoz5s81nBT6qAmHs6sQ6nAcAdF51vpNXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822352; c=relaxed/simple;
	bh=GnBe3IeIQt6OC2JsK7/U8UeTims0vuSmq1ePGQQjad4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Dpj1cBY2kQQJ1E4Kr+eMF/f54rQ6TZIY4QB3GgGwnt5HDgW+G6Yi4MmvodQsQo/8ntZOzyI5R9RqZj7oEOKnzuWJTgeolPZ+lwejhIaVDPZDBXdcrrQVEyVD94B+EfUb0m+FftDNLkGtrzeHgGqzVyVxkYNoEWbqctiOS3RZ6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AwH8a/60; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747822351; x=1779358351;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GnBe3IeIQt6OC2JsK7/U8UeTims0vuSmq1ePGQQjad4=;
  b=AwH8a/60LuM7c3dZvnYD5PPwqhZ0ENrOF2AIlrOgsbhiENIIQpSA7rSf
   GS7K1PettOLDe5nsGkJGynJtZuy6WdmDhzL2ljOwx5iMph/a9Pq1UdgJF
   rfhUrPiFhgVes8PszkjiqN8OqyB5J8WpQccDeF0bZTYYlQT2NrUnnMy5N
   wYhK0AZ1GG50I9qF+g3VbezFe0dEVEyl1Gl3N6Iom65TWXBQuhXfLl5b6
   Io39rD8RtpFox5oOx2rX99gJuFZhZWWLNi3e/Q+PtsbysLof78iu7WB7Q
   cgrUl1aXR0wbl1I/z9KSch6twtXZbUucwqh1NaryFmYnQxE+7UJ6ElGQ7
   A==;
X-CSE-ConnectionGUID: iYHyzqdpT0ioS77VcWwBKw==
X-CSE-MsgGUID: PwD72KSHRQWIz1NyqoS/iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="67206817"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="67206817"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 03:12:30 -0700
X-CSE-ConnectionGUID: zsQQroisTUWpPsUBeoW8Dw==
X-CSE-MsgGUID: 8fg1fRZIRPitzdV3wAFxcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140068274"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 03:12:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 May 2025 13:12:19 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    Weinan Liu <wnliu@google.com>, 
    Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
    Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, 
    Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
    Dave Jiang <dave.jiang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 03/17] PCI/AER: Factor COR/UNCOR error handling out
 from aer_isr_one_error()
In-Reply-To: <20250520215047.1350603-4-helgaas@kernel.org>
Message-ID: <95fbe3a9-fa77-c4ef-1396-618fd6944d41@linux.intel.com>
References: <20250520215047.1350603-1-helgaas@kernel.org> <20250520215047.1350603-4-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1330325227-1747822339=:946"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1330325227-1747822339=:946
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 20 May 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> aer_isr_one_error() duplicates the Error Source ID logging and AER error
> processing for Correctable Errors and Uncorrectable Errors.  Factor out t=
he
> duplicated code to aer_isr_one_error_type().
>=20
> aer_isr_one_error() doesn't need the struct aer_rpc pointer, so pass it t=
he
> Root Port or RCEC pci_dev pointer instead.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628..568229288ca3 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1273,17 +1273,32 @@ static inline void aer_process_err_devices(struct=
 aer_err_info *e_info)
>  }
> =20
>  /**
> - * aer_isr_one_error - consume an error detected by Root Port
> - * @rpc: pointer to the Root Port which holds an error
> + * aer_isr_one_error_type - consume a Correctable or Uncorrectable Error
> + *=09=09=09    detected by Root Port or RCEC
> + * @root: pointer to Root Port or RCEC that signaled AER interrupt
> + * @info: pointer to AER error info
> + */
> +static void aer_isr_one_error_type(struct pci_dev *root,
> +=09=09=09=09   struct aer_err_info *info)
> +{
> +=09aer_print_port_info(root, info);
> +
> +=09if (find_source_device(root, info))
> +=09=09aer_process_err_devices(info);
> +}
> +
> +/**
> + * aer_isr_one_error - consume error(s) signaled by an AER interrupt fro=
m
> + *=09=09       Root Port or RCEC
> + * @root: pointer to Root Port or RCEC that signaled AER interrupt
>   * @e_src: pointer to an error source
>   */
> -static void aer_isr_one_error(struct aer_rpc *rpc,
> +static void aer_isr_one_error(struct pci_dev *root,
>  =09=09struct aer_err_source *e_src)
>  {
> -=09struct pci_dev *pdev =3D rpc->rpd;
>  =09struct aer_err_info e_info;
> =20
> -=09pci_rootport_aer_stats_incr(pdev, e_src);
> +=09pci_rootport_aer_stats_incr(root, e_src);
> =20
>  =09/*
>  =09 * There is a possibility that both correctable error and
> @@ -1297,10 +1312,8 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  =09=09=09e_info.multi_error_valid =3D 1;
>  =09=09else
>  =09=09=09e_info.multi_error_valid =3D 0;
> -=09=09aer_print_port_info(pdev, &e_info);
> =20
> -=09=09if (find_source_device(pdev, &e_info))
> -=09=09=09aer_process_err_devices(&e_info);
> +=09=09aer_isr_one_error_type(root, &e_info);
>  =09}
> =20
>  =09if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
> @@ -1316,10 +1329,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  =09=09else
>  =09=09=09e_info.multi_error_valid =3D 0;
> =20
> -=09=09aer_print_port_info(pdev, &e_info);
> -
> -=09=09if (find_source_device(pdev, &e_info))
> -=09=09=09aer_process_err_devices(&e_info);
> +=09=09aer_isr_one_error_type(root, &e_info);
>  =09}
>  }
> =20
> @@ -1340,7 +1350,7 @@ static irqreturn_t aer_isr(int irq, void *context)
>  =09=09return IRQ_NONE;
> =20
>  =09while (kfifo_get(&rpc->aer_fifo, &e_src))
> -=09=09aer_isr_one_error(rpc, &e_src);
> +=09=09aer_isr_one_error(rpc->rpd, &e_src);
>  =09return IRQ_HANDLED;
>  }
> =20
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1330325227-1747822339=:946--

