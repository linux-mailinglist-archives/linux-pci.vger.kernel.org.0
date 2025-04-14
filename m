Return-Path: <linux-pci+bounces-25837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F9CA8848B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 16:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A0E562880
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6C72749DA;
	Mon, 14 Apr 2025 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JvzbrGuO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B24275859;
	Mon, 14 Apr 2025 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637594; cv=none; b=K61UmDPemXNZ0ydqPxNrrTXYziiLtX0OkAdFFoJBSSdQeZiaKo+u9KGS6OLfmshVnnLypoodICS7CvMxgEDWLtlTynU1b+ETJFmAInkRY1l8FythRWGgPHLBZ9Wz0VghWKF2qoKc7cXwapveMQ91LD5Qqq7+CWQgoR1jNowp75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637594; c=relaxed/simple;
	bh=xZMfdb/PDvQf4pfNhJ82gLWfKrDvTmfQsSjWoHGDpkI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XjV5cfMlHXVCkK8GsnuenJQX/QwcOmSNm4ZmYUQc6yicyenAtRJ1C6Ggx3bgk4A/qPqm75uWKnRqoCRlL4p0YtqGXWIuYHiG7TquB1LaxRp0wmk65mP+g22DK9KsqlGHNP9neZ79/d3wQcdvuKwcT5SNDtL2QPvcI/haNVQq+PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JvzbrGuO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744637592; x=1776173592;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xZMfdb/PDvQf4pfNhJ82gLWfKrDvTmfQsSjWoHGDpkI=;
  b=JvzbrGuOpjZ8vWcqnzSZ5Ejjfst5hj7ksLA8YQ2JYt+1/A2KKvUOwdSI
   Ydbh0gjbP1vXUZBTysMStFh0akuMzuZtlEr1L7vZh1AxlWKQ7x/0suSCk
   uGAdPHtbJy2G99SoUfn5KAouQsv0THXFKM7uu565n3Bu2EyW49SK+hubR
   0j6Ty48MOvdzLhNKqGHmAF74owL7awgvxGCHeSiYNdIKRQZwcqXYhnBw4
   4DzFJY2UpgiSkn9lLt3+yUOgVjtdLw02qiKPbLBRtFElGHoIdsaN4LvmL
   u+bvto7WyDT5vIKr2ya5M9fga2BRTVpwtnziM50/sYCnf0nNm3nKWTxIw
   A==;
X-CSE-ConnectionGUID: lIYIZEvzTm2fYLt0S11qoA==
X-CSE-MsgGUID: x58/t1stQ6adSM4v43t0rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="49763976"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="49763976"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:33:09 -0700
X-CSE-ConnectionGUID: L6ATAlVbRmWAh5vdEuAvNQ==
X-CSE-MsgGUID: pSzhCCy4QXOWP9FEwxN28g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="129780130"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.8])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:33:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 14 Apr 2025 16:33:01 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Keith Busch <kbusch@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>, 
    linux-pci@vger.kernel.org, Stuart Hayes <stuart.w.hayes@gmail.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Joel Mathew Thomas <proxy0@tutamail.com>, 
    Russ Weight <russ.weight@linux.dev>, 
    Matthew Gerlach <matthew.gerlach@altera.com>, 
    Yilun Xu <yilun.xu@intel.com>, linux-fpga@vger.kernel.org, 
    Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>, 
    Saeed Mahameed <saeedm@nvidia.com>, 
    Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/2] PCI: pciehp: Ignore Presence Detect Changed caused
 by DPC
In-Reply-To: <fa264ff71952915c4e35a53c89eb0cde8455a5c5.1744298239.git.lukas@wunner.de>
Message-ID: <03f5e7b9-e656-0252-167e-7f7df49de031@linux.intel.com>
References: <cover.1744298239.git.lukas@wunner.de> <fa264ff71952915c4e35a53c89eb0cde8455a5c5.1744298239.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-486195205-1744637581=:10563"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-486195205-1744637581=:10563
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 10 Apr 2025, Lukas Wunner wrote:

> Commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC")
> amended PCIe hotplug to not bring down the slot upon Data Link Layer Stat=
e
> Changed events caused by Downstream Port Containment.
>=20
> However Keith reports off-list that if the slot uses in-band presence
> detect (i.e. Presence Detect State is derived from Data Link Layer Link
> Active), DPC also causes a spurious Presence Detect Changed event.
>=20
> This needs to be ignored as well.
>=20
> Unfortunately there's no register indicating that in-band presence detect
> is used.  PCIe r5.0 sec 7.5.3.10 introduced the In-Band PD Disable bit in
> the Slot Control Register.  The PCIe hotplug driver sets this bit on
> ports supporting it.  But older ports may still use in-band presence
> detect.
>=20
> If in-band presence detect can be disabled, Presence Detect Changed event=
s
> occurring during DPC must not be ignored because they signal device
> replacement.  On all other ports, device replacement cannot be detected
> reliably because the Presence Detect Changed event could be a side effect
> of DPC.  On those (older) ports, perform a best-effort device replacement
> check by comparing the Vendor ID, Device ID and other data in Config Spac=
e
> with the values cached in struct pci_dev.  Use the existing helper
> pciehp_device_replaced() to accomplish this.  It is currently #ifdef'ed t=
o
> CONFIG_PM_SLEEP in pciehp_core.c, so move it to pciehp_hpc.c where most
> other functions accessing config space reside.
>=20
> Reported-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> ---
>  drivers/pci/hotplug/pciehp.h      |  1 +
>  drivers/pci/hotplug/pciehp_core.c | 29 -----------------------
>  drivers/pci/hotplug/pciehp_hpc.c  | 49 +++++++++++++++++++++++++++++++++=
------
>  3 files changed, 43 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 273dd8c..debc79b0 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -187,6 +187,7 @@ struct controller {
>  int pciehp_card_present_or_link_active(struct controller *ctrl);
>  int pciehp_check_link_status(struct controller *ctrl);
>  int pciehp_check_link_active(struct controller *ctrl);
> +bool pciehp_device_replaced(struct controller *ctrl);
>  void pciehp_release_ctrl(struct controller *ctrl);
> =20
>  int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pcie=
hp_core.c
> index 997841c..f59baa9 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -284,35 +284,6 @@ static int pciehp_suspend(struct pcie_device *dev)
>  =09return 0;
>  }
> =20
> -static bool pciehp_device_replaced(struct controller *ctrl)
> -{
> -=09struct pci_dev *pdev __free(pci_dev_put) =3D NULL;
> -=09u32 reg;
> -
> -=09if (pci_dev_is_disconnected(ctrl->pcie->port))
> -=09=09return false;
> -
> -=09pdev =3D pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0))=
;
> -=09if (!pdev)
> -=09=09return true;
> -
> -=09if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
> -=09    reg !=3D (pdev->vendor | (pdev->device << 16)) ||
> -=09    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
> -=09    reg !=3D (pdev->revision | (pdev->class << 8)))
> -=09=09return true;
> -
> -=09if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL &&
> -=09    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
> -=09     reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_device << 16=
))))
> -=09=09return true;
> -
> -=09if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> -=09=09return true;
> -
> -=09return false;
> -}
> -
>  static int pciehp_resume_noirq(struct pcie_device *dev)
>  {
>  =09struct controller *ctrl =3D get_service_data(dev);
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pcieh=
p_hpc.c
> index 8a09fb6..388fbed 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -563,18 +563,48 @@ void pciehp_power_off_slot(struct controller *ctrl)
>  =09=09 PCI_EXP_SLTCTL_PWR_OFF);
>  }
> =20
> +bool pciehp_device_replaced(struct controller *ctrl)
> +{
> +=09struct pci_dev *pdev __free(pci_dev_put) =3D NULL;
> +=09u32 reg;
> +
> +=09if (pci_dev_is_disconnected(ctrl->pcie->port))
> +=09=09return false;
> +
> +=09pdev =3D pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0))=
;
> +=09if (!pdev)
> +=09=09return true;
> +
> +=09if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
> +=09    reg !=3D (pdev->vendor | (pdev->device << 16)) ||
> +=09    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
> +=09    reg !=3D (pdev->revision | (pdev->class << 8)))
> +=09=09return true;
> +
> +=09if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL &&
> +=09    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
> +=09     reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_device << 16=
))))
> +=09=09return true;
> +
> +=09if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> +=09=09return true;
> +
> +=09return false;
> +}
> +
>  static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
> -=09=09=09=09=09  struct pci_dev *pdev, int irq)
> +=09=09=09=09=09  struct pci_dev *pdev, int irq,
> +=09=09=09=09=09  u16 ignored_events)
>  {
>  =09/*
>  =09 * Ignore link changes which occurred while waiting for DPC recovery.
>  =09 * Could be several if DPC triggered multiple times consecutively.
>  =09 */
>  =09synchronize_hardirq(irq);
> -=09atomic_and(~PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
> +=09atomic_and(~ignored_events, &ctrl->pending_events);
>  =09if (pciehp_poll_mode)
>  =09=09pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
> -=09=09=09=09=09   PCI_EXP_SLTSTA_DLLSC);
> +=09=09=09=09=09   ignored_events);
>  =09ctrl_info(ctrl, "Slot(%s): Link Down/Up ignored (recovered by DPC)\n"=
,
>  =09=09  slot_name(ctrl));
> =20
> @@ -584,8 +614,8 @@ static void pciehp_ignore_dpc_link_change(struct cont=
roller *ctrl,
>  =09 * Synthesize it to ensure that it is acted on.
>  =09 */
>  =09down_read_nested(&ctrl->reset_lock, ctrl->depth);
> -=09if (!pciehp_check_link_active(ctrl))
> -=09=09pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> +=09if (!pciehp_check_link_active(ctrl) || pciehp_device_replaced(ctrl))
> +=09=09pciehp_request(ctrl, ignored_events);
>  =09up_read(&ctrl->reset_lock);
>  }
> =20
> @@ -736,8 +766,13 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  =09 */
>  =09if ((events & PCI_EXP_SLTSTA_DLLSC) && pci_dpc_recovered(pdev) &&
>  =09    ctrl->state =3D=3D ON_STATE) {
> -=09=09events &=3D ~PCI_EXP_SLTSTA_DLLSC;
> -=09=09pciehp_ignore_dpc_link_change(ctrl, pdev, irq);
> +=09=09u16 ignored_events =3D PCI_EXP_SLTSTA_DLLSC;
> +
> +=09=09if (!ctrl->inband_presence_disabled)
> +=09=09=09ignored_events |=3D events & PCI_EXP_SLTSTA_PDC;
> +
> +=09=09events &=3D ~ignored_events;
> +=09=09pciehp_ignore_dpc_link_change(ctrl, pdev, irq, ignored_events);
>  =09}
> =20
>  =09/*
>=20
--8323328-486195205-1744637581=:10563--

