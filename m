Return-Path: <linux-pci+bounces-28200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F15ABF0DA
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 12:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6078E017A
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB0B25A624;
	Wed, 21 May 2025 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nwufn/BP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9423BCF4;
	Wed, 21 May 2025 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822000; cv=none; b=bTdovuO3qGdPQ9phe6XgEQNahHMA7mEs5H805Pd3xYUghhqoFrBXO7Viza2L9DenDUvKmIXEaXQSPgEu9YWc3tHkAtaAQXUsGFg7XloJuCBTDYJRvT6u622wdm3aFcADw0uTrcDthZDk5tHzgJg3BU3dl0aVdOVXyM9EqTiRtjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822000; c=relaxed/simple;
	bh=/66uzKbD2Pt/moi6vCnG0yTy0xxQ1qdjvrWSrTVybq4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ToZ7HqL48KnArwhlE4j8yTx0x8JrNPOJgTnNzhH0PAKrT9X20fhOgit0fXcBuPrLRQDbMGEcCJJ0Mw82N3soG4MxmKyQfVcVorGCVKse+8gPJ0d/Qgh4R29cS6m5zcpKIZNnZMfvYQbxeHcrua4PqhD9ALfcnu1EboBRVXFfQ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nwufn/BP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747821998; x=1779357998;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/66uzKbD2Pt/moi6vCnG0yTy0xxQ1qdjvrWSrTVybq4=;
  b=Nwufn/BPDXbNEbXnQiGIZPrxL6URobbQNYNirNV2ioxDoFm7GiWc0UbF
   7BM7+ke9ppBBDXjtkex04c/4mqlCv6Rw/nTOumz2NiPUhxeJSa48ERve1
   wGnpGSxpv8z0m1VJwV0VriXmBUUVLCy8FQ0+V8TNgiClOU3i8ygHmiJyD
   P0PyBWW+POoF7TxQzOOxFDaGkmkiXgQlu5RZOsNSm8XIR7f/kyfWrpjJo
   H7ZBOkW/BPvXgrFZckOM581P9xjpmoVp4E1iDcmZ99awsLSslIluYqAOc
   /x3m2Q4e8214GJA5MbzsJSiPKb0dGI7JcIZhHEV4tw2uzqhyEikCFuQyO
   g==;
X-CSE-ConnectionGUID: ooyqN10rRXWW+9/pr2G/Cw==
X-CSE-MsgGUID: kM8hmALHQRiAzXZhBNGiiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49851703"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49851703"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 03:06:37 -0700
X-CSE-ConnectionGUID: F28VW0UoT6e7arA1XbwwQg==
X-CSE-MsgGUID: yzbKDZP+SmGyofNmWssABQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="141053400"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 03:06:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 May 2025 13:06:25 +0300 (EEST)
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
    linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v7 01/17] PCI/DPC: Initialize aer_err_info before using
 it
In-Reply-To: <20250520215047.1350603-2-helgaas@kernel.org>
Message-ID: <b74260bc-9991-1590-91e1-97e77ae0fa41@linux.intel.com>
References: <20250520215047.1350603-1-helgaas@kernel.org> <20250520215047.1350603-2-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-302389236-1747821985=:946"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-302389236-1747821985=:946
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 20 May 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Previously the struct aer_err_info "info" was allocated on the stack
> without being initialized, so it contained junk except for the fields we
> explicitly set later.
>=20
> Initialize "info" at declaration so it starts as all zeros.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
=2Eintel.com>
> ---
>  drivers/pci/pcie/dpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index df42f15c9829..3daaf61c79c9 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -258,7 +258,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_=
dev *dev,
>  void dpc_process_error(struct pci_dev *pdev)
>  {
>  =09u16 cap =3D pdev->dpc_cap, status, source, reason, ext_reason;
> -=09struct aer_err_info info;
> +=09struct aer_err_info info =3D {};
> =20
>  =09pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>  =09pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-302389236-1747821985=:946--

