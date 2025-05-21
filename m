Return-Path: <linux-pci+bounces-28204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F07EABF171
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 12:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE2A1B6753F
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 10:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB8625A2CA;
	Wed, 21 May 2025 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyCcGEj2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13A23D285;
	Wed, 21 May 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823056; cv=none; b=Df7+3Z8G3D2c6RJEA0+HMh4MnW6/VD//ymk3+t/Bt9KaJszOK4/RCCe+r6V22sUEDQsxity4kNlC3vNEibd0RHEAKlWlFCZVB+qRxSbrQ1I0oacKQh0+k0P+NaPZzckl/V0QqMlmU5MzDW7DSNOhMqfeZabd3C62zGj7lluPS3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823056; c=relaxed/simple;
	bh=QT+ZRXmQW3xGIwS8YUEuvwknhFtt2KUvctGSee3lUTM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y+hkwSqOvNobyVYnnVal3eNIq9SLyl/KTpT1aoKbDHpNPtfR2m4gfK3qhDrPgH1IfrbiOr9ipKaY0YcTo/wyAS4gcWtnjcfzalmBUel6J/Dzdfmtg0sdrwN9SFufchu3Z9pTY/oL0+v+aNGIvcBbzibKTVEG1+PwwOSyvJ5gRz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyCcGEj2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747823054; x=1779359054;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QT+ZRXmQW3xGIwS8YUEuvwknhFtt2KUvctGSee3lUTM=;
  b=CyCcGEj2nNCIC4UWotANguUrBbZ4iTDNOyjkZcrNjcfc8E2tFl96s/2W
   aHWK2FJ6oa6ZRPWGGCzjsUg9B7QHQDLjtF38D+qzQIidoQS02N9q2vVFY
   aIeazVAXC/kXm7g0SMkVPM/Cc2QUpDNKctV68e15nJoy2HvTNOXFI96uM
   9o0yVnHma7n+8tJGI69efPWCMLhMY6RV516iivkWm/Rjwin1m0K5qT20d
   RP1PSlDhtj4JAGVAEx5dX501gAca/0mop6Nas6E4yLX8oDrZeLEV3mZF+
   R4BM90lUoJWbi0G7ayam3aY5l3ZkyqATUIX33ZL/paaqtYqQV9M9eESR9
   w==;
X-CSE-ConnectionGUID: YdMq8le9QXyZqhCyYiHnrg==
X-CSE-MsgGUID: DxJRMVqjRDOhPHg/b3OCag==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60452560"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="60452560"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 03:24:13 -0700
X-CSE-ConnectionGUID: NLexAi0OT0iqeJ9fviJxmw==
X-CSE-MsgGUID: 6WwmvMZETxiuSev+BW/SKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="163285282"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 03:24:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 May 2025 13:24:02 +0300 (EEST)
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
Subject: Re: [PATCH v7 15/17] PCI/AER: Ratelimit correctable and non-fatal
 error logging
In-Reply-To: <20250520215047.1350603-16-helgaas@kernel.org>
Message-ID: <cb2df523-866a-f3c6-741d-b68358b4569d@linux.intel.com>
References: <20250520215047.1350603-1-helgaas@kernel.org> <20250520215047.1350603-16-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2051602385-1747823042=:946"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2051602385-1747823042=:946
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 20 May 2025, Bjorn Helgaas wrote:

> From: Jon Pan-Doh <pandoh@google.com>
>=20
> Spammy devices can flood kernel logs with AER errors and slow/stall
> execution. Add per-device ratelimits for AER correctable and non-fatal
> uncorrectable errors that use the kernel defaults (10 per 5s).  Logging o=
f
> fatal errors is not ratelimited.
>=20
> There are two AER logging entry points:
>=20
>   - aer_print_error() is used by DPC and native AER
>=20
>   - pci_print_aer() is used by GHES and CXL
>=20
> The native AER aer_print_error() case includes a loop that may log detail=
s
> from multiple devices.  This is ratelimited such that we log all the
> details we find if any of the devices has not hit the ratelimit.  If no
> such device details are found, we still log the Error Source from the ERR=
_*
> Message, ratelimited by the Root Port or RCEC that received it.
>=20
> The DPC aer_print_error() case is not ratelimited, since this only happen=
s
> for fatal errors.
>=20
> The CXL pci_print_aer() case is ratelimited by the Error Source device.
>=20
> The GHES pci_print_aer() case is via aer_recover_work_func(), which
> searches for the Error Source device.  If the device is not found, there'=
s
> no per-device ratelimit, so we use a system-wide ratelimit that covers al=
l
> error types (correctable, non-fatal, and fatal).
>=20
> Sargun at Meta reported internally that a flood of AER errors causes RCU
> CPU stall warnings and CSD-lock warnings.
>=20
> Tested using aer-inject[1]. Sent 11 AER errors. Observed 10 errors logged
> while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) show
> true count of 11.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.=
git
>=20
> [bhelgaas: commit log, factor out trace_aer_event() and aer_print_rp_info=
()
> changes to previous patches, collect single aer_err_info.ratelimit as uni=
on
> of ratelimits of all error source devices, don't ratelimit fatal errors,
> "aer_report" -> "aer_info"]
> Reported-by: Sargun Dhillon <sargun@meta.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


> ---
>  drivers/pci/pci.h      |  3 +-
>  drivers/pci/pcie/aer.c | 66 ++++++++++++++++++++++++++++++++++++++----
>  drivers/pci/pcie/dpc.c |  1 +
>  3 files changed, 64 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 705f9ef58acc..65c466279ade 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -593,7 +593,8 @@ struct aer_err_info {
>  =09unsigned int id:16;
> =20
>  =09unsigned int severity:2;=09/* 0:NONFATAL | 1:FATAL | 2:COR */
> -=09unsigned int __pad1:5;
> +=09unsigned int ratelimit:1;=09/* 0=3Dskip, 1=3Dprint */
> +=09unsigned int __pad1:4;
>  =09unsigned int multi_error_valid:1;
> =20
>  =09unsigned int first_error:5;
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4f1bff0f000f..f9e684ac7878 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -28,6 +28,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/kfifo.h>
> +#include <linux/ratelimit.h>
>  #include <linux/slab.h>
>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
> @@ -88,6 +89,10 @@ struct aer_info {
>  =09u64 rootport_total_cor_errs;
>  =09u64 rootport_total_fatal_errs;
>  =09u64 rootport_total_nonfatal_errs;
> +
> +=09/* Ratelimits for errors */
> +=09struct ratelimit_state cor_log_ratelimit;
> +=09struct ratelimit_state uncor_log_ratelimit;
>  };
> =20
>  #define AER_LOG_TLP_MASKS=09=09(PCI_ERR_UNC_POISON_TLP|=09\
> @@ -379,6 +384,11 @@ void pci_aer_init(struct pci_dev *dev)
> =20
>  =09dev->aer_info =3D kzalloc(sizeof(*dev->aer_info), GFP_KERNEL);
> =20
> +=09ratelimit_state_init(&dev->aer_info->cor_log_ratelimit,
> +=09=09=09     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> +=09ratelimit_state_init(&dev->aer_info->uncor_log_ratelimit,
> +=09=09=09     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> +
>  =09/*
>  =09 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
>  =09 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
> @@ -672,6 +682,18 @@ static void pci_rootport_aer_stats_incr(struct pci_d=
ev *pdev,
>  =09}
>  }
> =20
> +static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
> +{
> +=09struct ratelimit_state *ratelimit;
> +
> +=09if (severity =3D=3D AER_CORRECTABLE)
> +=09=09ratelimit =3D &dev->aer_info->cor_log_ratelimit;
> +=09else
> +=09=09ratelimit =3D &dev->aer_info->uncor_log_ratelimit;
> +
> +=09return __ratelimit(ratelimit);
> +}
> +
>  static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *=
info)
>  {
>  =09const char **strings;
> @@ -715,6 +737,9 @@ void aer_print_error(struct pci_dev *dev, struct aer_=
err_info *info)
> =20
>  =09pci_dev_aer_stats_incr(dev, info);
> =20
> +=09if (!info->ratelimit)
> +=09=09return;
> +
>  =09if (!info->status) {
>  =09=09pci_err(dev, "PCIe Bus Error: severity=3D%s, type=3DInaccessible, =
(Unregistered Agent ID)\n",
>  =09=09=09aer_error_severity_string[info->severity]);
> @@ -785,6 +810,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_sever=
ity,
> =20
>  =09pci_dev_aer_stats_incr(dev, &info);
> =20
> +=09if (!aer_ratelimit(dev, info.severity))
> +=09=09return;
> +
>  =09layer =3D AER_GET_LAYER_ERROR(aer_severity, status);
>  =09agent =3D AER_GET_AGENT(aer_severity, status);
> =20
> @@ -815,8 +843,19 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>   */
>  static int add_error_device(struct aer_err_info *e_info, struct pci_dev =
*dev)
>  {
> +=09/*
> +=09 * Ratelimit AER log messages.  "dev" is either the source
> +=09 * identified by the root's Error Source ID or it has an unmasked
> +=09 * error logged in its own AER Capability.  If any of these devices
> +=09 * has not reached its ratelimit, log messages for all of them.
> +=09 * Messages are emitted when "e_info->ratelimit" is non-zero.
> +=09 *
> +=09 * Note that "e_info->ratelimit" was already initialized to 1 for the
> +=09 * ERR_FATAL case.
> +=09 */
>  =09if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
>  =09=09e_info->dev[e_info->error_dev_num] =3D pci_dev_get(dev);
> +=09=09e_info->ratelimit |=3D aer_ratelimit(dev, e_info->severity);
>  =09=09e_info->error_dev_num++;
>  =09=09return 0;
>  =09}
> @@ -914,7 +953,7 @@ static int find_device_iter(struct pci_dev *dev, void=
 *data)
>   * e_info->error_dev_num and e_info->dev[], based on the given informati=
on.
>   */
>  static bool find_source_device(struct pci_dev *parent,
> -=09=09struct aer_err_info *e_info)
> +=09=09=09       struct aer_err_info *e_info)
>  {
>  =09struct pci_dev *dev =3D parent;
>  =09int result;
> @@ -1140,9 +1179,10 @@ static void aer_recover_work_func(struct work_stru=
ct *work)
>  =09=09pdev =3D pci_get_domain_bus_and_slot(entry.domain, entry.bus,
>  =09=09=09=09=09=09   entry.devfn);
>  =09=09if (!pdev) {
> -=09=09=09pr_err("no pci_dev for %04x:%02x:%02x.%x\n",
> -=09=09=09       entry.domain, entry.bus,
> -=09=09=09       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
> +=09=09=09pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
> +=09=09=09=09=09   entry.domain, entry.bus,
> +=09=09=09=09=09   PCI_SLOT(entry.devfn),
> +=09=09=09=09=09   PCI_FUNC(entry.devfn));
>  =09=09=09continue;
>  =09=09}
>  =09=09pci_print_aer(pdev, entry.severity, entry.regs);
> @@ -1283,7 +1323,21 @@ static void aer_isr_one_error_type(struct pci_dev =
*root,
>  =09bool found;
> =20
>  =09found =3D find_source_device(root, info);
> -=09aer_print_source(root, info, found ? "" : " (no details found");
> +
> +=09/*
> +=09 * If we're going to log error messages, we've already set
> +=09 * "info->ratelimit" to non-zero (which enables printing) because
> +=09 * this is either an ERR_FATAL or we found a device with an error
> +=09 * logged in its AER Capability.
> +=09 *
> +=09 * If we didn't find the Error Source device, at least log the
> +=09 * Requester ID from the ERR_* Message received by the Root Port or
> +=09 * RCEC, ratelimited by the RP or RCEC.
> +=09 */
> +=09if (info->ratelimit ||
> +=09    (!found && aer_ratelimit(root, info->severity)))
> +=09=09aer_print_source(root, info, found ? "" : " (no details found");
> +
>  =09if (found)
>  =09=09aer_process_err_devices(info);
>  }
> @@ -1317,12 +1371,14 @@ static void aer_isr_one_error(struct pci_dev *roo=
t,
>  =09=09aer_isr_one_error_type(root, &e_info);
>  =09}
> =20
> +=09/* Note that messages for ERR_FATAL are never ratelimited */
>  =09if (status & PCI_ERR_ROOT_UNCOR_RCV) {
>  =09=09int fatal =3D status & PCI_ERR_ROOT_FATAL_RCV;
>  =09=09int multi =3D status & PCI_ERR_ROOT_MULTI_UNCOR_RCV;
>  =09=09struct aer_err_info e_info =3D {
>  =09=09=09.id =3D ERR_UNCOR_ID(e_src->id),
>  =09=09=09.severity =3D fatal ? AER_FATAL : AER_NONFATAL,
> +=09=09=09.ratelimit =3D fatal ? 1 : 0,
>  =09=09=09.level =3D KERN_ERR,
>  =09=09=09.multi_error_valid =3D multi ? 1 : 0,
>  =09=09};
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 6c98fabdba57..530c5e2cf7e8 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -271,6 +271,7 @@ void dpc_process_error(struct pci_dev *pdev)
>  =09=09=09 status);
>  =09=09if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
>  =09=09    aer_get_device_error_info(pdev, &info)) {
> +=09=09=09info.ratelimit =3D 1;=09/* ERR_FATAL; no ratelimit */
>  =09=09=09aer_print_error(pdev, &info);
>  =09=09=09pci_aer_clear_nonfatal_status(pdev);
>  =09=09=09pci_aer_clear_fatal_status(pdev);
>=20
--8323328-2051602385-1747823042=:946--

