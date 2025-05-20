Return-Path: <linux-pci+bounces-28085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 347D1ABD51C
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 12:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D42D8C112A
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF813270578;
	Tue, 20 May 2025 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erLGK5Vb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453826B085;
	Tue, 20 May 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737165; cv=none; b=hpPsISQapk0zIoJjON+fanY68FDn8pxbhkxzBoVQmNyYfNOTjqGR/mh5efYUyr6IqjcrjpMNRUjXcySuuXnUkqNNrai7nzbnMRJryvG5zUf5towJYOOiLcYD88JLi6X5aAxtPHWcAluYOlvdPUoJ+Cd0ZRBZ3YHDt1ht/z+rzFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737165; c=relaxed/simple;
	bh=jSrPTsUdiYGaIXTDtmHfRKOVo6dm+izWDCI+NqHxcFQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=haZTlO9vxDIJd0h/Nyw8h0/Z7h0a9SQLmw4J9s4eREIJDnZXblQiWe8EDACDXLh6wrXvnSAEdk5rbNsZV4x1B2OiAvcrJEa8Z1HVG9F9parmMKUhwBQZmNc3xBDmPgGZxMpDHM8YgkZ6KDMakFquTidM1/zv3sKYaO9b2UKBoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erLGK5Vb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747737164; x=1779273164;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jSrPTsUdiYGaIXTDtmHfRKOVo6dm+izWDCI+NqHxcFQ=;
  b=erLGK5VbWP4FLpqa4N/vwBoft52HSKECwmrbw71ddAKVHUpFk3+xOS/a
   5eXRnt+SrJM8gmTOQmSAtwSPWfTJ8iZkvoI35QUYoQndHU+pAgGUKvvoa
   ik5Weuyw7iuvSEIQZEr/7j0WSOoTgjExwVqMp3FYNmU7fVxXhHGO4JuE8
   MGJIWPq/e/28/ZMF6zHhnepOyu1RF/qqCY+Yax5bI9Vpgyn/T+bbyyZBZ
   cLvxO1jddNxzTxLgw4BvigLgdL5lsAbtpOdFhe714+ujgCpoRUyuXhxSZ
   JAZjAPlUNKFvKvgtH97yKRY9Hx/ydRBvRbdXRUvRBkQgnyf2BfoNDWzNK
   Q==;
X-CSE-ConnectionGUID: Omumm2kRT8m7w94eHoDxjA==
X-CSE-MsgGUID: c+uVwU7PReiqEewno8JqeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48917709"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48917709"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:32:43 -0700
X-CSE-ConnectionGUID: /yTSjeFFQ7iKO4HR0N18Dw==
X-CSE-MsgGUID: d0Ajj8wcR9+ZmqYffBY8BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="162956622"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:32:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 13:32:32 +0300 (EEST)
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
Subject: Re: [PATCH v6 04/16] PCI/AER: Extract bus/dev/fn in aer_print_port_info()
 with PCI_BUS_NUM(), etc
In-Reply-To: <20250519213603.1257897-5-helgaas@kernel.org>
Message-ID: <cf21c493-7430-fbbe-54c0-77305f5af14b@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-5-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-699488453-1747737152=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-699488453-1747737152=:936
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 19 May 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Use PCI_BUS_NUM(), PCI_SLOT(), PCI_FUNC() to extract the bus number,
> device, and function number directly from the Error Source ID.  There's n=
o
> need to shift and mask it explicitly.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index b8494ccd935b..dc8a50e0a2b7 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -736,14 +736,13 @@ void aer_print_error(struct pci_dev *dev, struct ae=
r_err_info *info)
>  static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info=
 *info,
>  =09=09=09=09const char *details)
>  {
> -=09u8 bus =3D info->id >> 8;
> -=09u8 devfn =3D info->id & 0xff;
> +=09u16 source =3D info->id;
> =20
>  =09pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n=
",
>  =09=09 info->multi_error_valid ? "Multiple " : "",
>  =09=09 aer_error_severity_string[info->severity],
> -=09=09 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> -=09=09 PCI_FUNC(devfn), details);
> +=09=09 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
> +=09=09 PCI_SLOT(source), PCI_FUNC(source), details);
>  }
> =20
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-699488453-1747737152=:936--

