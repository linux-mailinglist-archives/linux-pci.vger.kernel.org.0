Return-Path: <linux-pci+bounces-28100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0EAABD707
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 13:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF59A1BA0655
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890EC27A47C;
	Tue, 20 May 2025 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIL2MzaW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA25276030;
	Tue, 20 May 2025 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741133; cv=none; b=rn6k8O5U5+7A7Kq1pmJrJXJWLQexEHLXz8H2ff1679I5FxaC4ojALhtFw9g7cbN52ZTzzeKT5ya0ZrjTlt5enaJB4SN/nVVxwU3VQCjaqwo+aJriKtGXA9yA2we7nnXudtkCyoQTfof4ZF3KbMVinC+go6KJlA9eb35z7WVOOww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741133; c=relaxed/simple;
	bh=ZBhy5jTMuX/islvsvsIGuvvsPNEPu6gzFj5aeGdgWNU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ljyAaXv2g7iowlZnYER7xVQh3gpwPxaIa6b72mkNYV8Ks+86/kmGkdntUBQDZsKRcrKOyPntLNcNgZ/7L/tH6D3t0IFfBx3yGu/BTiBTnHGB3dKeaREcp2bUNJqg26CD+szOKHxXmUeqehv9wHGp5yKwiRSHtqFWpGKT7RLkv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIL2MzaW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747741132; x=1779277132;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZBhy5jTMuX/islvsvsIGuvvsPNEPu6gzFj5aeGdgWNU=;
  b=gIL2MzaW0hVvtxc6CsUyG+SOV5Hq9QGYSmDRXKXnjWn8RHM9pt5ovkHZ
   rmsrWGIeVTuVujs1pnBzgVui6ohhiYXG0w105IZO1Gr79Hmgak1Rps4XS
   /IxF5OICb781kV0BBymJJ1mBDrdT5gP6llShGIk0aZ/XCzfSIilatcvTH
   Xged+N00CceulQUQO07HN6Cqy6VW+3hC1CzpYRo3atGNkFX3BBbEVBv1y
   l9jW9kCM6cbOt9PWU6mSdSH4Ch37U2/qNYOG4BTy4vqwfvaOKWRFMApTU
   rddnO7CHdVMnC6IACuSEeCGwEcvyrFDlf09At17QxQAnYCeRwPQCruty+
   w==;
X-CSE-ConnectionGUID: lnWI1HU1TEu9nPJlX6KfvQ==
X-CSE-MsgGUID: rGmLfMc2To62jFu/wwN1Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="53340875"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="53340875"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:38:50 -0700
X-CSE-ConnectionGUID: KQtvJJ91TcO/jpGFcfksrg==
X-CSE-MsgGUID: Zwa6PwrpScOkOLk4GToe3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139506684"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:38:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 14:38:40 +0300 (EEST)
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
Subject: Re: [PATCH v6 13/16] PCI/AER: Rename struct aer_stats to
 aer_report
In-Reply-To: <20250519213603.1257897-14-helgaas@kernel.org>
Message-ID: <c5d071eb-c389-6f63-95e0-1b133bc1a620@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-14-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1916209925-1747741120=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1916209925-1747741120=:936
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 19 May 2025, Bjorn Helgaas wrote:

> From: Karolina Stolarek <karolina.stolarek@oracle.com>
>=20
> Update name to reflect the broader definition of structs/variables that a=
re
> stored (e.g. ratelimits). This is a preparatory patch for adding rate lim=
it
> support.
>=20
> Link: https://lore.kernel.org/r/20250321015806.954866-6-pandoh@google.com
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c | 50 +++++++++++++++++++++---------------------
>  include/linux/pci.h    |  2 +-
>  2 files changed, 26 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 06a7dda20846..da62032bf024 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -54,11 +54,11 @@ struct aer_rpc {
>  =09DECLARE_KFIFO(aer_fifo, struct aer_err_source, AER_ERROR_SOURCES_MAX)=
;
>  };
> =20
> -/* AER stats for the device */
> -struct aer_stats {
> +/* AER report for the device */
> +struct aer_report {
> =20
>  =09/*
> -=09 * Fields for all AER capable devices. They indicate the errors
> +=09 * Stats for all AER capable devices. They indicate the errors
>  =09 * "as seen by this device". Note that this may mean that if an
>  =09 * Endpoint is causing problems, the AER counters may increment
>  =09 * at its link partner (e.g. Root Port) because the errors will be
> @@ -80,7 +80,7 @@ struct aer_stats {
>  =09u64 dev_total_nonfatal_errs;
> =20
>  =09/*
> -=09 * Fields for Root Ports & Root Complex Event Collectors only; these
> +=09 * Stats for Root Ports & Root Complex Event Collectors only; these
>  =09 * indicate the total number of ERR_COR, ERR_FATAL, and ERR_NONFATAL
>  =09 * messages received by the Root Port / Event Collector, INCLUDING th=
e
>  =09 * ones that are generated internally (by the Root Port itself)
> @@ -377,7 +377,7 @@ void pci_aer_init(struct pci_dev *dev)
>  =09if (!dev->aer_cap)
>  =09=09return;
> =20
> -=09dev->aer_stats =3D kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
> +=09dev->aer_report =3D kzalloc(sizeof(*dev->aer_report), GFP_KERNEL);
> =20
>  =09/*
>  =09 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
> @@ -398,8 +398,8 @@ void pci_aer_init(struct pci_dev *dev)
> =20
>  void pci_aer_exit(struct pci_dev *dev)
>  {
> -=09kfree(dev->aer_stats);
> -=09dev->aer_stats =3D NULL;
> +=09kfree(dev->aer_report);
> +=09dev->aer_report =3D NULL;
>  }
> =20
>  #define AER_AGENT_RECEIVER=09=090
> @@ -537,10 +537,10 @@ static const char *aer_agent_string[] =3D {
>  {=09=09=09=09=09=09=09=09=09\
>  =09unsigned int i;=09=09=09=09=09=09=09\
>  =09struct pci_dev *pdev =3D to_pci_dev(dev);=09=09=09=09\
> -=09u64 *stats =3D pdev->aer_stats->stats_array;=09=09=09\
> +=09u64 *stats =3D pdev->aer_report->stats_array;=09=09=09\
>  =09size_t len =3D 0;=09=09=09=09=09=09=09\
>  =09=09=09=09=09=09=09=09=09\
> -=09for (i =3D 0; i < ARRAY_SIZE(pdev->aer_stats->stats_array); i++) {\
> +=09for (i =3D 0; i < ARRAY_SIZE(pdev->aer_report->stats_array); i++) {\
>  =09=09if (strings_array[i])=09=09=09=09=09\
>  =09=09=09len +=3D sysfs_emit_at(buf, len, "%s %llu\n",=09\
>  =09=09=09=09=09     strings_array[i],=09=09\
> @@ -551,7 +551,7 @@ static const char *aer_agent_string[] =3D {
>  =09=09=09=09=09     i, stats[i]);=09=09\
>  =09}=09=09=09=09=09=09=09=09\
>  =09len +=3D sysfs_emit_at(buf, len, "TOTAL_%s %llu\n", total_string,=09\
> -=09=09=09     pdev->aer_stats->total_field);=09=09\
> +=09=09=09     pdev->aer_report->total_field);=09=09\
>  =09return len;=09=09=09=09=09=09=09\
>  }=09=09=09=09=09=09=09=09=09\
>  static DEVICE_ATTR_RO(name)
> @@ -572,7 +572,7 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_err=
s,
>  =09=09     char *buf)=09=09=09=09=09=09\
>  {=09=09=09=09=09=09=09=09=09\
>  =09struct pci_dev *pdev =3D to_pci_dev(dev);=09=09=09=09\
> -=09return sysfs_emit(buf, "%llu\n", pdev->aer_stats->field);=09\
> +=09return sysfs_emit(buf, "%llu\n", pdev->aer_report->field);=09\
>  }=09=09=09=09=09=09=09=09=09\
>  static DEVICE_ATTR_RO(name)
> =20
> @@ -599,7 +599,7 @@ static umode_t aer_stats_attrs_are_visible(struct kob=
ject *kobj,
>  =09struct device *dev =3D kobj_to_dev(kobj);
>  =09struct pci_dev *pdev =3D to_pci_dev(dev);
> =20
> -=09if (!pdev->aer_stats)
> +=09if (!pdev->aer_report)
>  =09=09return 0;
> =20
>  =09if ((a =3D=3D &dev_attr_aer_rootport_total_err_cor.attr ||
> @@ -623,28 +623,28 @@ static void pci_dev_aer_stats_incr(struct pci_dev *=
pdev,
>  =09unsigned long status =3D info->status & ~info->mask;
>  =09int i, max =3D -1;
>  =09u64 *counter =3D NULL;
> -=09struct aer_stats *aer_stats =3D pdev->aer_stats;
> +=09struct aer_report *aer_report =3D pdev->aer_report;
> =20
>  =09trace_aer_event(pci_name(pdev), (info->status & ~info->mask),
>  =09=09=09info->severity, info->tlp_header_valid, &info->tlp);
> =20
> -=09if (!aer_stats)
> +=09if (!aer_report)
>  =09=09return;
> =20
>  =09switch (info->severity) {
>  =09case AER_CORRECTABLE:
> -=09=09aer_stats->dev_total_cor_errs++;
> -=09=09counter =3D &aer_stats->dev_cor_errs[0];
> +=09=09aer_report->dev_total_cor_errs++;
> +=09=09counter =3D &aer_report->dev_cor_errs[0];
>  =09=09max =3D AER_MAX_TYPEOF_COR_ERRS;
>  =09=09break;
>  =09case AER_NONFATAL:
> -=09=09aer_stats->dev_total_nonfatal_errs++;
> -=09=09counter =3D &aer_stats->dev_nonfatal_errs[0];
> +=09=09aer_report->dev_total_nonfatal_errs++;
> +=09=09counter =3D &aer_report->dev_nonfatal_errs[0];
>  =09=09max =3D AER_MAX_TYPEOF_UNCOR_ERRS;
>  =09=09break;
>  =09case AER_FATAL:
> -=09=09aer_stats->dev_total_fatal_errs++;
> -=09=09counter =3D &aer_stats->dev_fatal_errs[0];
> +=09=09aer_report->dev_total_fatal_errs++;
> +=09=09counter =3D &aer_report->dev_fatal_errs[0];
>  =09=09max =3D AER_MAX_TYPEOF_UNCOR_ERRS;
>  =09=09break;
>  =09}
> @@ -656,19 +656,19 @@ static void pci_dev_aer_stats_incr(struct pci_dev *=
pdev,
>  static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>  =09=09=09=09 struct aer_err_source *e_src)
>  {
> -=09struct aer_stats *aer_stats =3D pdev->aer_stats;
> +=09struct aer_report *aer_report =3D pdev->aer_report;
> =20
> -=09if (!aer_stats)
> +=09if (!aer_report)
>  =09=09return;
> =20
>  =09if (e_src->status & PCI_ERR_ROOT_COR_RCV)
> -=09=09aer_stats->rootport_total_cor_errs++;
> +=09=09aer_report->rootport_total_cor_errs++;
> =20
>  =09if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
>  =09=09if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
> -=09=09=09aer_stats->rootport_total_fatal_errs++;
> +=09=09=09aer_report->rootport_total_fatal_errs++;
>  =09=09else
> -=09=09=09aer_stats->rootport_total_nonfatal_errs++;
> +=09=09=09aer_report->rootport_total_nonfatal_errs++;
>  =09}
>  }
> =20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0e8e3fd77e96..4b11a90107cb 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -346,7 +346,7 @@ struct pci_dev {
>  =09u8=09=09hdr_type;=09/* PCI header type (`multi' flag masked out) */
>  #ifdef CONFIG_PCIEAER
>  =09u16=09=09aer_cap;=09/* AER capability offset */
> -=09struct aer_stats *aer_stats;=09/* AER stats for this device */
> +=09struct aer_report *aer_report;=09/* AER report for this device */
>  #endif
>  #ifdef CONFIG_PCIEPORTBUS
>  =09struct rcec_ea=09*rcec_ea;=09/* RCEC cached endpoint association */
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1916209925-1747741120=:936--

