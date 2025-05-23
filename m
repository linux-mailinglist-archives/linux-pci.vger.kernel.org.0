Return-Path: <linux-pci+bounces-28321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15ECAC21CB
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 13:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF01F3AFFDD
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 11:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA9122A4C2;
	Fri, 23 May 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwFhp9jf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411AE2DCC02;
	Fri, 23 May 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998845; cv=none; b=jK+QU9PJ70Hh/GXW20hxpsXrGpPzYuNwq2vO2q0G2Gh0n1XSLgsN15dWmtu6SVoyxqcN1SvvFBDhJ0whJSj0fvx77kA86oOyAF0I9RIMS3IKIx8pI7jvriziOY4qVdJ6AwYcJ6/dlkwswHq3tZquKkX2IauxYzcIEOgUNj7Asz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998845; c=relaxed/simple;
	bh=awPgKAtbs09VBvJjTCS50PNvg1VAMdB8tjpi4ROCuFc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UVjtAat3Yjsxm+vI2CHxxNpRPYyAUXVG2rdBRUOFHqhCCXojhnV2ozQhVSFSsMpikaqORATu8F8hwZNp4NLn3vkIh3mV2KJFdiiIleaaJKtnbCcQDH/W/3sPYTMoMyHqBvn6NEN5O9hxI1pjXjimj+MsIBYOVgvZX/VvBu2uXe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwFhp9jf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747998844; x=1779534844;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=awPgKAtbs09VBvJjTCS50PNvg1VAMdB8tjpi4ROCuFc=;
  b=FwFhp9jfC6qQ6lu15sQz6wsY5IhfluCFQ11luWD/or1fUZepmhteSj7w
   lhviH34ZDPH8Ce7pMreSRARvvyjMu/aRu8d7ECDl91khmzLBdcGptzH90
   PxV6c+qUe8jzcYCIFPNA19LepXJ8CqM26joyMQerl+Q+IuXw7gIfukdWG
   7QGzGcHOnTV58NnYm00VnsScznqZxF2SsZLK4HxCvOPgXjVAPIGYFsvNL
   gSk+iszV43hGs7lahApnaYy2aWX68aFDJgbWELV1/ARQZI6WXVU1h4Pvp
   zVFL64Q6r7o3M/oWXbsuEv0qPK6zhcSFeJCZHQl2kXy1bUROy4t8cL4Xk
   Q==;
X-CSE-ConnectionGUID: 96ibRHdkTamowrMYyYCPoA==
X-CSE-MsgGUID: rV8xtclSSVGar9GzYuE+hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50216281"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="50216281"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 04:14:04 -0700
X-CSE-ConnectionGUID: kVB90jRXQLejrPr2/iMbUQ==
X-CSE-MsgGUID: Ch5Ov7+kS/aSdw6fhA38tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="142055114"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.150])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 04:13:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 May 2025 14:13:52 +0300 (EEST)
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
Subject: Re: [PATCH v8 16/20] PCI/AER: Convert aer_get_device_error_info(),
 aer_print_error() to index
In-Reply-To: <20250522232339.1525671-17-helgaas@kernel.org>
Message-ID: <b7e7a308-713f-d89b-cccd-8f397e097bae@linux.intel.com>
References: <20250522232339.1525671-1-helgaas@kernel.org> <20250522232339.1525671-17-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-767706868-1747998832=:21466"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-767706868-1747998832=:21466
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 May 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Previously aer_get_device_error_info() and aer_print_error() took a point=
er
> to struct aer_err_info and a pointer to a pci_dev.  Typically the pci_dev
> was one of the elements of the aer_err_info.dev[] array (DPC was an
> exception, where the dev[] array was unused).
>=20
> Convert aer_get_device_error_info() and aer_print_error() to take an inde=
x
> into the aer_err_info.dev[] array instead.  A future patch will add
> per-device ratelimit information, so the index makes it convenient to fin=
d
> the ratelimit associated with the device.
>=20
> To accommodate DPC, set info->dev[0] to the DPC port before using these
> interfaces.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.h      |  4 ++--
>  drivers/pci/pcie/aer.c | 33 +++++++++++++++++++++++----------
>  drivers/pci/pcie/dpc.c |  8 ++++++--
>  3 files changed, 31 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 1a9bfc708757..e1a28215967f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -605,8 +605,8 @@ struct aer_err_info {
>  =09struct pcie_tlp_log tlp;=09/* TLP Header */
>  };
> =20
> -int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *=
info);
> -void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
> +int aer_get_device_error_info(struct aer_err_info *info, int i);
> +void aer_print_error(struct aer_err_info *info, int i);
> =20
>  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>  =09=09      unsigned int tlp_len, bool flit,
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 787a953fb331..237741e66d28 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -705,12 +705,18 @@ static void aer_print_source(struct pci_dev *dev, s=
truct aer_err_info *info,
>  =09=09 found ? "" : " (no details found");
>  }
> =20
> -void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> +void aer_print_error(struct aer_err_info *info, int i)
>  {
> -=09int layer, agent;
> -=09int id =3D pci_dev_id(dev);
> +=09struct pci_dev *dev;
> +=09int layer, agent, id;
>  =09const char *level =3D info->level;
> =20
> +=09if (i >=3D AER_MAX_MULTI_ERR_DEVICES)
> +=09=09return;

Are these OoB checks actually indication of a logic error in the caller=20
side which would perhaps warrant using
=09if (WARN_ON_ONCE(i >=3D AER_MAX_MULTI_ERR_DEVICES))
?

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

> +
> +=09dev =3D info->dev[i];
> +=09id =3D pci_dev_id(dev);
> +
>  =09pci_dev_aer_stats_incr(dev, info);
>  =09trace_aer_event(pci_name(dev), (info->status & ~info->mask),
>  =09=09=09info->severity, info->tlp_header_valid, &info->tlp);
> @@ -1193,19 +1199,26 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
> =20
>  /**
>   * aer_get_device_error_info - read error status from dev and store it t=
o info
> - * @dev: pointer to the device expected to have an error record
>   * @info: pointer to structure to store the error record
> + * @i: index into info->dev[]
>   *
>   * Return: 1 on success, 0 on error.
>   *
>   * Note that @info is reused among all error devices. Clear fields prope=
rly.
>   */
> -int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *=
info)
> +int aer_get_device_error_info(struct aer_err_info *info, int i)
>  {
> -=09int type =3D pci_pcie_type(dev);
> -=09int aer =3D dev->aer_cap;
> +=09struct pci_dev *dev;
> +=09int type, aer;
>  =09u32 aercc;
> =20
> +=09if (i >=3D AER_MAX_MULTI_ERR_DEVICES)
> +=09=09return 0;
> +
> +=09dev =3D info->dev[i];
> +=09aer =3D dev->aer_cap;
> +=09type =3D pci_pcie_type(dev);
> +
>  =09/* Must reset in this function */
>  =09info->status =3D 0;
>  =09info->tlp_header_valid =3D 0;
> @@ -1257,11 +1270,11 @@ static inline void aer_process_err_devices(struct=
 aer_err_info *e_info)
> =20
>  =09/* Report all before handling them, to not lose records by reset etc.=
 */
>  =09for (i =3D 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> -=09=09if (aer_get_device_error_info(e_info->dev[i], e_info))
> -=09=09=09aer_print_error(e_info->dev[i], e_info);
> +=09=09if (aer_get_device_error_info(e_info, i))
> +=09=09=09aer_print_error(e_info, i);
>  =09}
>  =09for (i =3D 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> -=09=09if (aer_get_device_error_info(e_info->dev[i], e_info))
> +=09=09if (aer_get_device_error_info(e_info, i))
>  =09=09=09handle_error_source(e_info->dev[i], e_info);
>  =09}
>  }
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 7ae1590ea1da..fc18349614d7 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -253,6 +253,10 @@ static int dpc_get_aer_uncorrect_severity(struct pci=
_dev *dev,
>  =09=09info->severity =3D AER_NONFATAL;
> =20
>  =09info->level =3D KERN_ERR;
> +
> +=09info->dev[0] =3D dev;
> +=09info->error_dev_num =3D 1;
> +
>  =09return 1;
>  }
> =20
> @@ -270,8 +274,8 @@ void dpc_process_error(struct pci_dev *pdev)
>  =09=09pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrec=
table error detected\n",
>  =09=09=09 status);
>  =09=09if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
> -=09=09    aer_get_device_error_info(pdev, &info)) {
> -=09=09=09aer_print_error(pdev, &info);
> +=09=09    aer_get_device_error_info(&info, 0)) {
> +=09=09=09aer_print_error(&info, 0);
>  =09=09=09pci_aer_clear_nonfatal_status(pdev);
>  =09=09=09pci_aer_clear_fatal_status(pdev);
>  =09=09}
>=20

--=20
 i.

--8323328-767706868-1747998832=:21466--

