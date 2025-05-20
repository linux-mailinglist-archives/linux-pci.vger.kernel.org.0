Return-Path: <linux-pci+bounces-28093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED65ABD5C8
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 13:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775BB166C0D
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0712721D3F1;
	Tue, 20 May 2025 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVjzks3q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6827A21D3E8;
	Tue, 20 May 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739090; cv=none; b=I7ERCsLIoh765Fc3k4AWuy/+dnKv4aajoa7AUHR5pMImaHWOiFnVMaRqSNxv8nE2JmDWeC8o92SuPQq13hwA4Gy2K89Ntj5T4AX65rtSodTsUYJSILvXlmv6WKGIZO2kUxPSpOr99NOE4UiGSFhSVE9Oou9+Wh91kLTYjAovy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739090; c=relaxed/simple;
	bh=2q3Euz3gWXew0Lix6LkM48KWDqKNDLqiRhgOnRlDonc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Hf8T0o23WyH/i/CQ8Lob9LZrbvqqiCy/ZWAW5cgsX/1meho4iIPhx5mNCE0iV5SlmBKqbkWO13TdeHqjRc/n2Yr06mGoudr3pkeRinqfjxSb26ciIfHwGVqadU8wwmxVlYwe3rcAt4fN2JifuIO5qLiReVMQgH6TQrWmH5Q7unw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVjzks3q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747739089; x=1779275089;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2q3Euz3gWXew0Lix6LkM48KWDqKNDLqiRhgOnRlDonc=;
  b=gVjzks3qrp7PxueW/wLtsFNhlCiqHX8okWiF3kGFCyTxcMjRfRzSFx7D
   XdAtNI7qN4IZ2+Ocdl+I2j8zG1bkpJjgfLFcZp/ODyX0JYEPyyoT6mxna
   /48zLqjTAgUd0jbKOs8iMJJusCinS6raawQn8pKWl38LHTS5lL4qqouxz
   rjWnbghu4vhZHZ26WN5ZCZ91rnsHsM0uuQhT6fBMsP1TWtkVY7wZzyT1I
   dh/9Xws2+SoOSJVRCXggKYHNq55DlmaoR4SheoxPcICEZCNksbGSU0meb
   POdAcUXGzaHZ9HYhZW7eFW2Bw0HmkLhoNSV5zMRAvn0TG4E12UCiS/uQc
   g==;
X-CSE-ConnectionGUID: 9bkSUVs3QB+Xx7bDKXEdWA==
X-CSE-MsgGUID: 8pQWQc32R5+Spo0v/a1s0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49570075"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49570075"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:04:48 -0700
X-CSE-ConnectionGUID: lsWvy+8XTtOpxXcW+r6gMA==
X-CSE-MsgGUID: zI7pvXqoT7ea0loC5Vlm4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="176784390"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:04:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 14:04:38 +0300 (EEST)
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
Subject: Re: [PATCH v6 09/16] PCI/AER: Update statistics early in logging
In-Reply-To: <20250519213603.1257897-10-helgaas@kernel.org>
Message-ID: <0e27ac92-0b94-43c2-1c7a-da706f60792d@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-10-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1997636967-1747739078=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1997636967-1747739078=:936
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 19 May 2025, Bjorn Helgaas wrote:

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
> ---
>  drivers/pci/pcie/aer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 73d618354f6a..eb80c382187d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -693,7 +693,6 @@ static void __aer_print_error(struct pci_dev *dev,
>  =09=09aer_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
>  =09=09=09=09info->first_error =3D=3D i ? " (First)" : "");
>  =09}
> -=09pci_dev_aer_stats_incr(dev, info);
>  }
> =20
>  static void aer_print_source(struct pci_dev *dev, struct aer_err_info *i=
nfo,
> @@ -714,6 +713,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_=
err_info *info)
>  =09int id =3D pci_dev_id(dev);
>  =09const char *level;
> =20
> +=09pci_dev_aer_stats_incr(dev, info);
> +
>  =09if (!info->status) {
>  =09=09pci_err(dev, "PCIe Bus Error: severity=3D%s, type=3DInaccessible, =
(Unregistered Agent ID)\n",
>  =09=09=09aer_error_severity_string[info->severity]);
> @@ -782,6 +783,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_sever=
ity,
>  =09info.status =3D status;
>  =09info.mask =3D mask;
> =20
> +=09pci_dev_aer_stats_incr(dev, &info);
> +
>  =09layer =3D AER_GET_LAYER_ERROR(aer_severity, status);
>  =09agent =3D AER_GET_AGENT(aer_severity, status);
> =20
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1997636967-1747739078=:936--

