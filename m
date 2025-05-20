Return-Path: <linux-pci+bounces-28089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC21ABD583
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 12:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02E117BAF8
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD9E276030;
	Tue, 20 May 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpUXhDpl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994FB2701B6;
	Tue, 20 May 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737768; cv=none; b=EJ+8+IcnNSKsdJ407987THU4zkzB98Pwd0onoRjODUGEErYYXbjgsYjq20ejFkF+XSzcMKmR33bSrJSF2dxntxIv4VYvUAPMOMPPLSe62YWKBMTIeHWTZHmkppmkLa2rW8XyrLd4xi/PT/6BedTE3CxObqvA+kSGtznAswlHK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737768; c=relaxed/simple;
	bh=VVRJ0cc49ivFUcS/222ihD/X953hUY24HsmeyEvjzMI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lDYaAUxF2pora85DG7LwaF40OAu90pQsCUJ21UZP2jjHAI37OEZybvG1kFHBxKrTU3a6vQsubMSXxhcVW3GLHfhDGUiohY2C7O4p/kKK3Ol6IX9G7MHh+XJNsEDdkxIy/FRIreJiYqFhjCdoUEe5xNyqkglMaYp+xHF4G/HG//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpUXhDpl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747737767; x=1779273767;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VVRJ0cc49ivFUcS/222ihD/X953hUY24HsmeyEvjzMI=;
  b=GpUXhDpl8sUR2sqygVhNfamtMTksiWxc0ZZu18yPfezoQJckFiW95l1Q
   xql48hInGxyjmKbgHD1K9SY2AcZhLFKSANKrS83EYyMXDdydzE+CGwmq+
   ceyJUr/IHaMbmZPTA8AGjvrjyrGX3Kp8G1yhvrJFBC88kpTj1xVJ9pnUA
   6lIENMcGHHG7+A/yJdWAD8R1gkrUuw2IDP+6gsduNnNM8oG3ZCD49KgoL
   2JxHC91yfzsqCYuu9kMvjNY+V3+Hl1yHyf8Bxxmc5Xms7A6nAdFSGKl+m
   UwX+LtgZ7Tk8WJ5uB+VQuoDnGfFn5lZiEeEfqTPYt/7htmWmPrDV5VLPn
   g==;
X-CSE-ConnectionGUID: Dj2Y+0ACTe6hJaWGlOxu8Q==
X-CSE-MsgGUID: /w3GzhmgTyeS5FHNnHdlmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="75066297"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="75066297"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:42:46 -0700
X-CSE-ConnectionGUID: ZBtXtbmQRgSzVNxZmPrKIQ==
X-CSE-MsgGUID: Ljl4tQ5iQpCWru7A/t3jlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144408251"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:42:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 13:42:36 +0300 (EEST)
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
Subject: Re: [PATCH v6 08/16] PCI/AER: Simplify pci_print_aer()
In-Reply-To: <20250519213603.1257897-9-helgaas@kernel.org>
Message-ID: <c77305f2-1117-8c7c-83e4-1036c46dbbbb@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-9-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1668877726-1747737756=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1668877726-1747737756=:936
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 19 May 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Simplify pci_print_aer() by initializing the struct aer_err_info "info"
> with a designated initializer list (it was previously initialized with
> memset()) and using pci_name().
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 40f003eca1c5..73d618354f6a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -765,7 +765,10 @@ void pci_print_aer(struct pci_dev *dev, int aer_seve=
rity,
>  {
>  =09int layer, agent, tlp_header_valid =3D 0;
>  =09u32 status, mask;
> -=09struct aer_err_info info;
> +=09struct aer_err_info info =3D {
> +=09=09.severity =3D aer_severity,
> +=09=09.first_error =3D PCI_ERR_CAP_FEP(aer->cap_control),
> +=09};
> =20
>  =09if (aer_severity =3D=3D AER_CORRECTABLE) {
>  =09=09status =3D aer->cor_status;
> @@ -776,14 +779,11 @@ void pci_print_aer(struct pci_dev *dev, int aer_sev=
erity,
>  =09=09tlp_header_valid =3D status & AER_LOG_TLP_MASKS;
>  =09}
> =20
> -=09layer =3D AER_GET_LAYER_ERROR(aer_severity, status);
> -=09agent =3D AER_GET_AGENT(aer_severity, status);
> -
> -=09memset(&info, 0, sizeof(info));
> -=09info.severity =3D aer_severity;
>  =09info.status =3D status;
>  =09info.mask =3D mask;
> -=09info.first_error =3D PCI_ERR_CAP_FEP(aer->cap_control);
> +
> +=09layer =3D AER_GET_LAYER_ERROR(aer_severity, status);
> +=09agent =3D AER_GET_AGENT(aer_severity, status);
> =20
>  =09pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>  =09__aer_print_error(dev, &info);
> @@ -797,7 +797,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_sever=
ity,
>  =09if (tlp_header_valid)
>  =09=09pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> =20
> -=09trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> +=09trace_aer_event(pci_name(dev), (status & ~mask),
>  =09=09=09aer_severity, tlp_header_valid, &aer->header_log);
>  }
>  EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1668877726-1747737756=:936--

