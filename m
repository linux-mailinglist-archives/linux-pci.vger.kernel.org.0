Return-Path: <linux-pci+bounces-28322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743AEAC21D5
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 13:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8043BA6C1
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 11:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB9B20328;
	Fri, 23 May 2025 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiPZf+2+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B645221DB7;
	Fri, 23 May 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998907; cv=none; b=U9mYIjoi8rKKyPNZ0Eea4DnVD76umme70r9k8cODc2otbqwAFCX1GcuMPgP1E7DLngP7C4ZrwhAAoRcdzznZtjcNxiTq98ACRi3qOZr4WKRqQUmYcJdXzwijVm1Ysn0AZsAufbs1O3GQtxZvep8GZjmJtlmARC2yzxxZXFIY/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998907; c=relaxed/simple;
	bh=uLBLtxOJYDYA8ZKK3hhgGuqxa2VSzPJe0qY4w9hbLA0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UPRGGw8O6tJED5NdxxWFHc2s85fkZn5noVdoOxv0OfsgnBMJcoERBoXIIoi3wYf3lWb9lXWcs4hWGqPbonJT4xwAwa8ZMKVKFdsE3OCANycfqUxwUg2/EQ5G/GdK2dNyMdT4qf8qrx7pZW1igHUC/UZ/EzzYo1vsMsdnm7E2UaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiPZf+2+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747998906; x=1779534906;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uLBLtxOJYDYA8ZKK3hhgGuqxa2VSzPJe0qY4w9hbLA0=;
  b=OiPZf+2+fCd+ffgHwgXz5apZ04BKVfljz1AAbgU546EYI2Hm2lW4nEXA
   VNBBhiU/cbVH0JIPTjPZAxQsEdHcW9vM40cu5jnn6X/2BDa5qdZdqVlUO
   yAlnINhcz4VmqmpLNASfRRhiiPsUUKVyupFBdeRSuHyc1ToI0cN1xxW9p
   DAwHKI74HS+Zc9diDJ62vJ0WUXYC+Mkc3qEt5yerY3WmPoPX4AriXa/5i
   0jymltHROn0tMfmD2oJMYX/XSJKNnQLrtmkGSBCmOfRjdXxYDNwWOT3/6
   /yEFGwMT21o2OSYFySH7twZUS+dQdHPEtlBEHOpuVL/uHoUplTyIjvUzO
   w==;
X-CSE-ConnectionGUID: +jSRvJb+S9aENZKSYkdMgw==
X-CSE-MsgGUID: obqtnUS3SkKEqmT44t0qeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="72579764"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="72579764"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 04:15:04 -0700
X-CSE-ConnectionGUID: Vtg0ZHwRQnaaq6htq1XEYA==
X-CSE-MsgGUID: Qtk9mCUPRiWTvSmmhHzOkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="141165383"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.150])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 04:14:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 May 2025 14:14:53 +0300 (EEST)
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
Subject: Re: [PATCH v8 17/20] PCI/AER: Simplify add_error_device()
In-Reply-To: <20250522232339.1525671-18-helgaas@kernel.org>
Message-ID: <68ea56e6-f4d2-9521-9f89-e6e9246eb1b7@linux.intel.com>
References: <20250522232339.1525671-1-helgaas@kernel.org> <20250522232339.1525671-18-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1191482443-1747998893=:21466"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1191482443-1747998893=:21466
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 May 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Return -ENOSPC error early so the usual path through add_error_device() i=
s
> the straightline code.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 237741e66d28..24f0f5c55256 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -816,12 +816,15 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>   */
>  static int add_error_device(struct aer_err_info *e_info, struct pci_dev =
*dev)
>  {
> -=09if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
> -=09=09e_info->dev[e_info->error_dev_num] =3D pci_dev_get(dev);
> -=09=09e_info->error_dev_num++;
> -=09=09return 0;
> -=09}
> -=09return -ENOSPC;
> +=09int i =3D e_info->error_dev_num;
> +
> +=09if (i >=3D AER_MAX_MULTI_ERR_DEVICES)
> +=09=09return -ENOSPC;
> +
> +=09e_info->dev[i] =3D pci_dev_get(dev);
> +=09e_info->error_dev_num++;
> +
> +=09return 0;
>  }
> =20
>  /**
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1191482443-1747998893=:21466--

