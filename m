Return-Path: <linux-pci+bounces-28098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DE4ABD6B5
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 13:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B203188BE4E
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 11:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0608C26FD84;
	Tue, 20 May 2025 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQjfNgTN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A331DE2A8;
	Tue, 20 May 2025 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740378; cv=none; b=PEjX56TFy7hBHcPTcFAhElfCMQog5rM0yDIN0CHlndMsMOqsDnh4ozmXXnJk63mG1CVDJ56WMs10n8rKwAE8w91sqCW3eQk45EyVL/kXqo5pTvXq4gXx+ehfOinYxMHFe7JScajjo0ofQ8tVaAyuZk6kxYz2UBNTIW8BBXJCSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740378; c=relaxed/simple;
	bh=T3UKCI8vLgcrXw0JEQSeOSqIKno3QsvC2GEsrPAlWXE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KESP5PtnfADP3FYUsUFXF6g4qbCFXC4ARh8tDGZZ4TkwzLW2QyHmdKjMp6OGAF+dFW4hrBlMwvQ/YoON075Wuxz3rWklVhpD17zOuyBCqSXXq9qhF2Hxt3e4iSH6TmsIDh81h8MB2KmFyBvTE2HWYJ6PR9+W7ucuRVh9uo629g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQjfNgTN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747740377; x=1779276377;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T3UKCI8vLgcrXw0JEQSeOSqIKno3QsvC2GEsrPAlWXE=;
  b=LQjfNgTNQMU/dCy20ZohHVaVxoTMouYZ84TIk1a7duScoC6CQMggwZoV
   ASxUmq8MybRl6npxJGnzsvG5VIeqZHxU/ILUbDlmom16T9cR8eDlXslyY
   doCOFt5ePlpkn1D30/udaU2nBwFi9l8y6ZkGaGROcCVDS7BOcSPPW5skN
   ni04OpXgZGT/NEtVxpE1ggDhY0BT6P6WXRXLNH/IY629WNO3CsS3P2+iM
   G0kP7u3t2tRlCc2ucl+lhBWjDJRnAr9chhH3I2Hyjyk5AGuq4JsysQX3o
   Y24KqWxnZoQvtALD35c3YNl1/xnEuQNDMA2jEOlxgxopDZPGDy1ZgGVdJ
   Q==;
X-CSE-ConnectionGUID: DWcLa0A9RNWoyTCZL+8BzA==
X-CSE-MsgGUID: sriRz868Rz2Z+5aBo2e5ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="37287533"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="37287533"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:26:16 -0700
X-CSE-ConnectionGUID: YvbkRG61TMebEa2ZV+k6Cg==
X-CSE-MsgGUID: y29ZSiL0Ro6h6Fg3wubh4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="176789060"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:26:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 14:26:06 +0300 (EEST)
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
Subject: Re: [PATCH v6 11/16] PCI/AER: Check log level once and remember it
In-Reply-To: <20250519213603.1257897-12-helgaas@kernel.org>
Message-ID: <fdd8a39f-de1c-77bb-f091-96c9817b3d8a@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-12-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1333808165-1747740366=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1333808165-1747740366=:936
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 19 May 2025, Bjorn Helgaas wrote:

> From: Karolina Stolarek <karolina.stolarek@oracle.com>
>=20
> When reporting an AER error, we check its type multiple times to determin=
e
> the log level for each message. Do this check only in the top-level
> functions (aer_isr_one_error(), pci_print_aer()) and save the level in
> struct aer_err_info.
>=20
> [bhelgaas: save log level in struct aer_err_info instead of passing it
> as a parameter]
> Link: https://lore.kernel.org/r/20250321015806.954866-2-pandoh@google.com
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.h      |  1 +
>  drivers/pci/pcie/aer.c | 21 ++++++++++-----------
>  drivers/pci/pcie/dpc.c |  1 +
>  3 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b81e99cd4b62..705f9ef58acc 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -588,6 +588,7 @@ static inline bool pci_dev_test_and_set_removed(struc=
t pci_dev *dev)
>  struct aer_err_info {
>  =09struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>  =09int error_dev_num;
> +=09const char *level;=09=09/* printk level */

As a general direction, wouldn't it be better to start adding these=20
comments in the kerneldoc compatible format (even if not yet enabling the=
=20
kerneldoc with /**)?

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> =20
>  =09unsigned int id:16;
> =20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4683a99c7568..73b03a195b14 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -672,21 +672,18 @@ static void pci_rootport_aer_stats_incr(struct pci_=
dev *pdev,
>  =09}
>  }
> =20
> -static void __aer_print_error(struct pci_dev *dev,
> -=09=09=09      struct aer_err_info *info)
> +static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *=
info)
>  {
>  =09const char **strings;
>  =09unsigned long status =3D info->status & ~info->mask;
> -=09const char *level, *errmsg;
> +=09const char *level =3D info->level;
> +=09const char *errmsg;
>  =09int i;
> =20
> -=09if (info->severity =3D=3D AER_CORRECTABLE) {
> +=09if (info->severity =3D=3D AER_CORRECTABLE)
>  =09=09strings =3D aer_correctable_error_string;
> -=09=09level =3D KERN_WARNING;
> -=09} else {
> +=09else
>  =09=09strings =3D aer_uncorrectable_error_string;
> -=09=09level =3D KERN_ERR;
> -=09}
> =20
>  =09for_each_set_bit(i, &status, 32) {
>  =09=09errmsg =3D strings[i];
> @@ -714,7 +711,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_=
err_info *info)
>  {
>  =09int layer, agent;
>  =09int id =3D pci_dev_id(dev);
> -=09const char *level;
> +=09const char *level =3D info->level;
> =20
>  =09pci_dev_aer_stats_incr(dev, info);
> =20
> @@ -727,8 +724,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_=
err_info *info)
>  =09layer =3D AER_GET_LAYER_ERROR(info->severity, info->status);
>  =09agent =3D AER_GET_AGENT(info->severity, info->status);
> =20
> -=09level =3D (info->severity =3D=3D AER_CORRECTABLE) ? KERN_WARNING : KE=
RN_ERR;
> -
>  =09aer_printk(level, dev, "PCIe Bus Error: severity=3D%s, type=3D%s, (%s=
)\n",
>  =09=09   aer_error_severity_string[info->severity],
>  =09=09   aer_error_layer[layer], aer_agent_string[agent]);
> @@ -774,9 +769,11 @@ void pci_print_aer(struct pci_dev *dev, int aer_seve=
rity,
>  =09if (aer_severity =3D=3D AER_CORRECTABLE) {
>  =09=09status =3D aer->cor_status;
>  =09=09mask =3D aer->cor_mask;
> +=09=09info.level =3D KERN_WARNING;
>  =09} else {
>  =09=09status =3D aer->uncor_status;
>  =09=09mask =3D aer->uncor_mask;
> +=09=09info.level =3D KERN_ERR;
>  =09=09tlp_header_valid =3D status & AER_LOG_TLP_MASKS;
>  =09}
> =20
> @@ -1297,6 +1294,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  =09=09struct aer_err_info e_info =3D {
>  =09=09=09.id =3D ERR_COR_ID(e_src->id),
>  =09=09=09.severity =3D AER_CORRECTABLE,
> +=09=09=09.level =3D KERN_WARNING,
>  =09=09=09.multi_error_valid =3D multi ? 1 : 0,
>  =09=09};
> =20
> @@ -1312,6 +1310,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  =09=09struct aer_err_info e_info =3D {
>  =09=09=09.id =3D ERR_UNCOR_ID(e_src->id),
>  =09=09=09.severity =3D fatal ? AER_FATAL : AER_NONFATAL,
> +=09=09=09.level =3D KERN_ERR,
>  =09=09=09.multi_error_valid =3D multi ? 1 : 0,
>  =09=09};
> =20
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 315bf2bfd570..34af0ea45c0d 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -252,6 +252,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_=
dev *dev,
>  =09else
>  =09=09info->severity =3D AER_NONFATAL;
> =20
> +=09info->level =3D KERN_WARNING;
>  =09return 1;
>  }
> =20
>=20
--8323328-1333808165-1747740366=:936--

