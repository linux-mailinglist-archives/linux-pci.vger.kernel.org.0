Return-Path: <linux-pci+bounces-28095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56CDABD658
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 13:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A621888C15
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D08C27CCE2;
	Tue, 20 May 2025 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beU5rQlQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9305027CCEE;
	Tue, 20 May 2025 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739312; cv=none; b=oK9xFEy6Mm5Cb27LX8TfZPknB3Hp9SoAh5ZNe2ndWKg863fBu/xCMlvvbSIcaUNGX8dZ7XhjNtzax4/otooaiJZZ6bsVNrPqFKeKkb7K45xj6FkV7vPpRXyeRCBjV3enz0gaqiJ0zFWucHmKOJsc62BGqrDU/VHAfOwnB+m4/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739312; c=relaxed/simple;
	bh=2prKnSO821SeuO9H2s4uOwiNlz7rB9Uw7dRLE80sspg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GzsDg5plYmAgE57ZQFwBxN7QKS4ahxiZgneOkJAh6o8cNR3RezRTJhTYYJHb2jCk8CssT1MSzCgOptS9Dyc0uKKyB97Osf+uCtO+qgMJpVh+0t/V9sDSz5FRZHUUdAA/L6ydAfoHKvm40aNV8u/dZOLd3j3lX4YVDGX7jICAF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beU5rQlQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747739311; x=1779275311;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2prKnSO821SeuO9H2s4uOwiNlz7rB9Uw7dRLE80sspg=;
  b=beU5rQlQPYQVo6Vabeq14xobBJVwdQQ5h3OmAr3XnZFumstrkTZLEnVY
   BU8GjK3M5whI1MltPXvL+1g5c2dLpMtm15OrVEky8b4DkX5y4XY3MaYKg
   SwXE/slD9pBx1T8S90PQGolI+lM5uUR+p6QUrTtfKpPehkEeTZy4ftcRG
   4BQKKYGWhGNDyriml9hSYcMjuRthxa/83sUKkwLSDZwPJUmqPkZ3pDtB6
   Vu0h3cKhLEX41SU0ZTOv8tZCESdt11Jr8Wn/5xNz/thiOSqq/sGkGJuZF
   WgGyhnLepEHQdW7Md4xls9eKZh8LrQFWVeUoKO2DAa6Tv5vHg/yNT+iV9
   Q==;
X-CSE-ConnectionGUID: VlRnVtJaQDeaj/X8CI2qxQ==
X-CSE-MsgGUID: 5D7ADScVQUWYQngu2qxhUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="67222150"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="67222150"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:08:30 -0700
X-CSE-ConnectionGUID: Psky762oSGWT9Xebg7dWIw==
X-CSE-MsgGUID: vN1G9CdjQXOh3FilZV04og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144914007"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:08:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 14:08:19 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
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
Subject: Re: [PATCH v6 10/16] PCI/AER: Combine trace_aer_event() with statistics
 updates
In-Reply-To: <20250519213603.1257897-11-helgaas@kernel.org>
Message-ID: <a6260206-a02f-2212-9610-66186d6e26a2@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-11-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1580202455-1747739299=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1580202455-1747739299=:936
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 19 May 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> As with the AER statistics, we always want to emit trace events, even if
> the actual dmesg logging is rate limited.
>=20
> Call trace_aer_event() directly from pci_dev_aer_stats_incr(), where we
> update the statistics.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index eb80c382187d..4683a99c7568 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -625,6 +625,9 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pd=
ev,
>  =09u64 *counter =3D NULL;
>  =09struct aer_stats *aer_stats =3D pdev->aer_stats;
> =20
> +=09trace_aer_event(pci_name(pdev), (info->status & ~info->mask),
> +=09=09=09info->severity, info->tlp_header_valid, &info->tlp);
> +
>  =09if (!aer_stats)
>  =09=09return;
> =20
> @@ -741,9 +744,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_=
err_info *info)
>  out:
>  =09if (info->id && info->error_dev_num > 1 && info->id =3D=3D id)
>  =09=09pci_err(dev, "  Error of this Agent is reported first\n");
> -
> -=09trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> -=09=09=09info->severity, info->tlp_header_valid, &info->tlp);
>  }
> =20
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
> @@ -782,6 +782,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_sever=
ity,
> =20
>  =09info.status =3D status;
>  =09info.mask =3D mask;
> +=09info.tlp_header_valid =3D tlp_header_valid;
> +=09if (tlp_header_valid)
> +=09=09info.tlp =3D aer->header_log;
> =20
>  =09pci_dev_aer_stats_incr(dev, &info);
> =20
> @@ -799,9 +802,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_sever=
ity,
> =20
>  =09if (tlp_header_valid)
>  =09=09pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> -
> -=09trace_aer_event(pci_name(dev), (status & ~mask),
> -=09=09=09aer_severity, tlp_header_valid, &aer->header_log);
>  }
>  EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
> =20
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1580202455-1747739299=:936--

