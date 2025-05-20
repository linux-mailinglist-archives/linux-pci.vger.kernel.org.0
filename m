Return-Path: <linux-pci+bounces-28087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C20ABD543
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A65169CA7
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12832701CB;
	Tue, 20 May 2025 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbU9fgby"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4952673BF;
	Tue, 20 May 2025 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737309; cv=none; b=YdXhRoLJTwHBKXBwSOeEm9Dejrcu2ctthC6jEFR3f58LI7I3m0GgMtsv+LXe4yFeCLVCJ27oiDppI1EyeOfLDCCCg3h44ypWG5eD9AHvXN0Uyz3aPwlK4GejamcAa4nIHmc9Z5rYa9MpAjXkMOnp6q1wPobI2sdduujXUGsJils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737309; c=relaxed/simple;
	bh=ke+1+In4r/rZjrgzMhjI2/H/glCpSsOix+X86F/MPGU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NkV+b06b2hghmjcQoCsIxwIxqA0W9ICtY7JKo/+vU3qdq5kp4ltR8kA+Oo4YvrFmc2aN3sZTFF54xMSbHzMF+XA1kmCfgXj4TzL7v1vNsfmz7SmhHacZnO+nw9ZyizNAvnG5T+8mk45/QpCYkgupBPbelV4jng3Hr3Syhq1pkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbU9fgby; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747737308; x=1779273308;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ke+1+In4r/rZjrgzMhjI2/H/glCpSsOix+X86F/MPGU=;
  b=SbU9fgbykOMenx46A7OQZDUwhjUREXpTUXN9geILXFD7mnRBizSBBZGa
   wyyV2w/S4dCG9OpIAK8kmQhMfABZz6eW4pRjTlFjlFKwXoCx1ejbJOat3
   GxP3lge7pqT1VPWKW3CQduue+QM6dYWPReF/MBx1ABLft/QGC8hT0alUV
   Hj9C8LE5UEtqIFnKpvED3Yjq4MzwO3a9FauUuu9hd9U+ULiMpc1tm4rsr
   EwG+jiyUk9CPbyFDdfW5ZXWPu3XKmAyJBtv9Dp/fuA7NjZTiFy6iwaZ5x
   kwQ8C19J5mvymKVJXQiywAoIITxpJyLHIv4XghhPDOrzBAKf0kUxuH2wc
   Q==;
X-CSE-ConnectionGUID: qNfKs11xRZ6XVcaQx+fgUw==
X-CSE-MsgGUID: PdDf/RVMRxCUkkwaBzE6xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48918100"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48918100"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:35:08 -0700
X-CSE-ConnectionGUID: Z8NjBDTwQTerJuTOWjg9ag==
X-CSE-MsgGUID: x7Ah4STFRAiD7xKkEQKxWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139555983"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:35:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 13:34:56 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
    Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, 
    Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
    Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 06/16] PCI/AER: Move aer_print_source() earlier in
 file
In-Reply-To: <20250519213603.1257897-7-helgaas@kernel.org>
Message-ID: <8b8fdf6d-d4b2-b15e-541d-f8e90b72923f@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-7-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-265372137-1747737296=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-265372137-1747737296=:936
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 19 May 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Move aer_print_source() earlier in the file so a future change can use it
> from aer_print_error(), where it's easier to rate limit it.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index eb42d50b2def..95a4cab1d517 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -696,6 +696,18 @@ static void __aer_print_error(struct pci_dev *dev,
>  =09pci_dev_aer_stats_incr(dev, info);
>  }
> =20
> +static void aer_print_source(struct pci_dev *dev, struct aer_err_info *i=
nfo,
> +=09=09=09     const char *details)
> +{
> +=09u16 source =3D info->id;
> +
> +=09pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n=
",
> +=09=09 info->multi_error_valid ? "Multiple " : "",
> +=09=09 aer_error_severity_string[info->severity],
> +=09=09 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
> +=09=09 PCI_SLOT(source), PCI_FUNC(source), details);
> +}
> +
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  =09int layer, agent;
> @@ -733,18 +745,6 @@ void aer_print_error(struct pci_dev *dev, struct aer=
_err_info *info)
>  =09=09=09info->severity, info->tlp_header_valid, &info->tlp);
>  }
> =20
> -static void aer_print_source(struct pci_dev *dev, struct aer_err_info *i=
nfo,
> -=09=09=09     const char *details)
> -{
> -=09u16 source =3D info->id;
> -
> -=09pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n=
",
> -=09=09 info->multi_error_valid ? "Multiple " : "",
> -=09=09 aer_error_severity_string[info->severity],
> -=09=09 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
> -=09=09 PCI_SLOT(source), PCI_FUNC(source), details);
> -}
> -
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
>  int cper_severity_to_aer(int cper_severity)
>  {
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-265372137-1747737296=:936--

