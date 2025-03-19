Return-Path: <linux-pci+bounces-24086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12F3A688DD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 10:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BFF166A3A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192F730100;
	Wed, 19 Mar 2025 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtDyKO44"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F371C5D65
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377963; cv=none; b=t44wyIwUXGBi7YACjt2fybCeJ/4L34tBgSTgtKIy1/yvSQl+n9bJpRRcX5hj5g/DYUweP1V4Oj1CWl1+FgKo95rEP46ULSWVsKBWSqNTXyDMBAVHwfZ+JH0BCDGGyi0w7k6Yh8GR9wkri+ky8T1TLA0hQyVFb9pq73gRYNyGyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377963; c=relaxed/simple;
	bh=T5LftzC6kQOYomWNFvTVs+zW5dhR7pm6qdyMujwdkSk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=myenTh1kuxTiRegGAXHchXdC5vQObW7eaWKQLuAVV8B8HnNLXVWiYR5G8oXyY5SUxohgDQMyzRDJThTWCLpAsziRWO8+4FO/U93L0WSq69MmsneCkLxD9O7EqYjZrQjHZcHPx9mSoXwQM19F+yDiPn9D3rc180nnxFBiDDiV0lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtDyKO44; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742377961; x=1773913961;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T5LftzC6kQOYomWNFvTVs+zW5dhR7pm6qdyMujwdkSk=;
  b=RtDyKO449m2kNEGQgO7eCn0x/RNzvJgKYk7Oi6FTpdWr+hAWxaeYw8co
   evWHd9ZtNb3hqBJHFT2FGPjq9wyFmu7HVYweun60Lys5WCNMcqgarcjFK
   3zG2qUkIXXT/pTmBAnf/Qt+OPPWi5R8iQa+I1eTmkr1rRda5jLY0gpvPc
   EBYUYcy9pHJlTILaxLSvdNeLM6YyhfAUupo2Zfj7utkHZt+XFUz1+Wv5E
   GHO3qS+W2pWpgDYbALVRwztW3D+iQxHndOCGR3MBt8vaIhKITzEgk0NIt
   EYmRHR7lnrtygG5eRL3Uz7bGECFh7spzGPQwvdxr6VjaxxhM33Tdtz0wj
   w==;
X-CSE-ConnectionGUID: uHHk2G0UTsCAZEaeD6nioQ==
X-CSE-MsgGUID: 0S6xWgsQTcu+4j67rNAmfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="53773494"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="53773494"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 02:52:39 -0700
X-CSE-ConnectionGUID: oasudJ+vT1aD+3J/KWJf+g==
X-CSE-MsgGUID: EqNj6PGNQ+iV1CrBijfeJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122717223"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 02:52:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 19 Mar 2025 11:52:31 +0200 (EET)
To: Jon Pan-Doh <pandoh@google.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Terry Bowman <Terry.bowman@amd.com>
Subject: Re: [PATCH v3 2/8] PCI/AER: Make all pci_print_aer() log levels
 depend on error type
In-Reply-To: <20250319084050.366718-3-pandoh@google.com>
Message-ID: <75e10cc0-2690-f55e-409b-bf1f1dddaeae@linux.intel.com>
References: <20250319084050.366718-1-pandoh@google.com> <20250319084050.366718-3-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-59666235-1742377951=:988"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-59666235-1742377951=:988
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 19 Mar 2025, Jon Pan-Doh wrote:

> From: Karolina Stolarek <karolina.stolarek@oracle.com>
>=20
> Some existing logs in pci_print_aer() log with error severity
> by default. Convert them to depend on error type (consistent
> with rest of AER logging).
>=20
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>  drivers/pci/pcie/aer.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index cc9c80cd88f3..7eeaad917134 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -784,14 +784,14 @@ void pci_print_aer(struct pci_dev *dev, int aer_sev=
erity,
>  =09info.mask =3D mask;
>  =09info.first_error =3D PCI_ERR_CAP_FEP(aer->cap_control);
> =20
> -=09pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> +=09aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", stat=
us, mask);
>  =09__aer_print_error(dev, &info, level);
> -=09pci_err(dev, "aer_layer=3D%s, aer_agent=3D%s\n",
> -=09=09aer_error_layer[layer], aer_agent_string[agent]);
> +=09aer_printk(level, dev, "aer_layer=3D%s, aer_agent=3D%s\n",
> +=09=09   aer_error_layer[layer], aer_agent_string[agent]);
> =20
>  =09if (aer_severity !=3D AER_CORRECTABLE)
> -=09=09pci_err(dev, "aer_uncor_severity: 0x%08x\n",
> -=09=09=09aer->uncor_severity);
> +=09=09aer_printk(level, dev, "aer_uncor_severity: 0x%08x\n",
> +=09=09=09   aer->uncor_severity);
> =20
>  =09if (tlp_header_valid)
>  =09=09pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-59666235-1742377951=:988--

