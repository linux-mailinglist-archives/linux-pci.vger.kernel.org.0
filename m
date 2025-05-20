Return-Path: <linux-pci+bounces-28084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F78ABD52E
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 12:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6BF4C35E1
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB7E26F47D;
	Tue, 20 May 2025 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOLGAJnM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD42A26B08D;
	Tue, 20 May 2025 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737126; cv=none; b=Zzjcg8mRTaHN4bYxv2VjNu+mtb4lC4QBVxe2iWS5LLeqne98Qgyt+vhfaZ5L39g13d7pam1PrKZb1S8Vq8L8Ew3gvQF++L9ZNwTn9yC4D+tFavYH6DVkYH7Onddo4a6pGIOCz37AH7rRmGm//pgGWadROZh31CRsLbuhIqDp8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737126; c=relaxed/simple;
	bh=TJRyDHxczC9IA4djKmSUESAGNZkcmiHKFFh7fx72gCo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P3dn9ecv9pGGigh1AR5gJlFLwkvtP/6neSXBUGQCuitI5hTWz3sgMA9MxPPygPTntY6QikUxSCi0k3p0GZaVA8vTzZLQIPVKR4TaLENMBE9TTTw/Q7soqcQkjDrvvUSXo0zf/y+vh4T6F8d1eduHh+D+ppxu5CcYLQZ1Ll65FGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOLGAJnM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747737125; x=1779273125;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TJRyDHxczC9IA4djKmSUESAGNZkcmiHKFFh7fx72gCo=;
  b=iOLGAJnM9x9ba75PDmfukFlH6G0YrhNzCT+n6t9yRrR725hTMU3oe7rb
   hXgyABE1JSa36qkVCKKD6qbzWKYssjfAuWbKLUu9OYY87wpXpz1wI7UGC
   1+pFzRM5V1jmks0rZZjXc/XVfFXf3XRdBBGpFclyz5KlK1D/2QAnSgCng
   obP00/OyAPWq59tco+N/+PIryu7a0AZVyoWO8pj0T9puxdQaGWpdq7qhg
   sNc3BPDOTpQCRgkQTQd93dzBazU6EyKXfHFiembmcoby2EEY/igWUhD8C
   YQTB69ID0gUWNxLYEASQRw6X8s5RTX1G7DmOSD3KrHQSIp5Woe55VtRCL
   g==;
X-CSE-ConnectionGUID: dkJzHcvNSFWSVHCP25wJuQ==
X-CSE-MsgGUID: 3fREYQeQTg22FCEeG9Z46Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="72175977"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="72175977"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:31:52 -0700
X-CSE-ConnectionGUID: Y6hkVwn/RruBDe+ob+/vDw==
X-CSE-MsgGUID: GLIdw7GwQ7KGkOWZuroKKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140067264"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:31:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 13:31:41 +0300 (EEST)
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
Subject: Re: [PATCH v6 03/16] PCI/AER: Consolidate Error Source ID logging
 in aer_print_port_info()
In-Reply-To: <20250519213603.1257897-4-helgaas@kernel.org>
Message-ID: <fe9d879f-a908-e794-03ff-6ac4526c674a@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-4-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-651407544-1747737101=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-651407544-1747737101=:936
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 19 May 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Previously we decoded the AER Error Source ID in two places.  Consolidate
> them so both places use aer_print_port_info().  Add a "details" parameter
> so we can add a note when we didn't find any downstream devices with erro=
rs
> logged in their AER Capability.
>=20
> When we didn't read any error details from the source device, we logged t=
wo
> messages: one in aer_isr_one_error() and another in find_source_device().
> Since they both contain the same information, only log the first one when
> when find_source_device() has found error details.
>=20
> This changes the dmesg logging when we found no devices with errors logge=
d:
>=20
>   - pci 0000:00:01.0: AER: Correctable error message received from 0000:0=
2:00.0
>   - pci 0000:00:01.0: AER: found no error details for 0000:02:00.0
>   + pci 0000:00:01.0: AER: Correctable error message received from 0000:0=
2:00.0 (no details found)
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628..b8494ccd935b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -733,16 +733,17 @@ void aer_print_error(struct pci_dev *dev, struct ae=
r_err_info *info)
>  =09=09=09info->severity, info->tlp_header_valid, &info->tlp);
>  }
> =20
> -static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info=
 *info)
> +static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info=
 *info,
> +=09=09=09=09const char *details)
>  {
>  =09u8 bus =3D info->id >> 8;
>  =09u8 devfn =3D info->id & 0xff;
> =20
> -=09pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
> +=09pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n=
",
>  =09=09 info->multi_error_valid ? "Multiple " : "",
>  =09=09 aer_error_severity_string[info->severity],
>  =09=09 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> -=09=09 PCI_FUNC(devfn));
> +=09=09 PCI_FUNC(devfn), details);
>  }
> =20
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
> @@ -926,13 +927,13 @@ static bool find_source_device(struct pci_dev *pare=
nt,
>  =09else
>  =09=09pci_walk_bus(parent->subordinate, find_device_iter, e_info);
> =20
> +=09/*
> +=09 * If we didn't find any devices with errors logged in the AER
> +=09 * Capability, just print the Error Source ID from the Root Port or
> +=09 * RCEC that received an ERR_* Message.
> +=09 */
>  =09if (!e_info->error_dev_num) {
> -=09=09u8 bus =3D e_info->id >> 8;
> -=09=09u8 devfn =3D e_info->id & 0xff;
> -
> -=09=09pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
> -=09=09=09 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
> -=09=09=09 PCI_FUNC(devfn));
> +=09=09aer_print_port_info(parent, e_info, " (no details found)");
>  =09=09return false;
>  =09}
>  =09return true;
> @@ -1297,10 +1298,11 @@ static void aer_isr_one_error(struct aer_rpc *rpc=
,
>  =09=09=09e_info.multi_error_valid =3D 1;
>  =09=09else
>  =09=09=09e_info.multi_error_valid =3D 0;
> -=09=09aer_print_port_info(pdev, &e_info);
> =20
> -=09=09if (find_source_device(pdev, &e_info))
> +=09=09if (find_source_device(pdev, &e_info)) {
> +=09=09=09aer_print_port_info(pdev, &e_info, "");
>  =09=09=09aer_process_err_devices(&e_info);
> +=09=09}
>  =09}
> =20
>  =09if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
> @@ -1316,10 +1318,10 @@ static void aer_isr_one_error(struct aer_rpc *rpc=
,
>  =09=09else
>  =09=09=09e_info.multi_error_valid =3D 0;
> =20
> -=09=09aer_print_port_info(pdev, &e_info);
> -
> -=09=09if (find_source_device(pdev, &e_info))
> +=09=09if (find_source_device(pdev, &e_info)) {
> +=09=09=09aer_print_port_info(pdev, &e_info, "");
>  =09=09=09aer_process_err_devices(&e_info);
> +=09=09}
>  =09}
>  }
> =20
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-651407544-1747737101=:936--

