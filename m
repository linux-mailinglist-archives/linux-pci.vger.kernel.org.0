Return-Path: <linux-pci+bounces-16823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760A09CD9AC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4EA282E89
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 07:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9CA15FD13;
	Fri, 15 Nov 2024 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xa5leM/B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE70185B67;
	Fri, 15 Nov 2024 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731654487; cv=none; b=cPPjrs/eE2MPcWYGIKX3xt4fGa2cxnVzcajVDFd13ijxHT4kftrGMY4gbg85B0Arghs/Kv3P2RCvxx0iTtZHj9Y254P9N5MV64cPnWKCgWtIIg064Kmha9FKPOokKArvCWD/s347heVM3VDj99IvP6cTkaoeMLQsGaBO5DwLeU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731654487; c=relaxed/simple;
	bh=U0epoSNqiuF+vCTGqIdYkcUlkfdfBFN73aZm4/H84hM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FKbw2AQhpSIyBUzZcxdZrnMBwDtBEO47v9a906IBzLd4xHi15rUdknp+K574Qwexu1t4yjibkWe+re6fZFTQHb8oEbgBWDVnw16vvVMQ9Lay2FKEvnBIws++A5z0KO2qcVEuT5RYD0t441dBdrwBKNTZMpubQkgb69mbNPfmV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xa5leM/B; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731654486; x=1763190486;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=U0epoSNqiuF+vCTGqIdYkcUlkfdfBFN73aZm4/H84hM=;
  b=Xa5leM/B0xPnp1UdlRtDuDtA/cnDV/Ew2pXL+zVCB6ZPGuW4DMzx0Jo+
   7UXXa0VBFVYAmLuFbGu9cyBXFXr3ESLNOMXoGNOk/+JEKO2xsEv3Us0Dd
   UVgtIvRlAe2v6rmGz3SAkuDnhUfH9wAE1xIpVEUjCrtb0npXFYjmXJER9
   YDUkXE/sn4NYHoygylh2NEFltB75UN4BUqltPNPOwQ7NtYsC9O8GHHc55
   p/K34x20G2zt9VHyk+RkW0Me0Ie4abOPIFXpWUyYgPeKtRZf5I1CBqkMo
   Ufl/obBvYL0XhzBSbKfKoO6k9rUa+HYo14ulSHBlwffI3cL55dTD7+Gst
   g==;
X-CSE-ConnectionGUID: eqQMjSPWRiCM1elj3dyOKg==
X-CSE-MsgGUID: bqmjUxK1Rvif3nMVSowlTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="31896949"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="31896949"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 23:07:57 -0800
X-CSE-ConnectionGUID: D30DyvP2QrSxGTraNwo6sA==
X-CSE-MsgGUID: /6DbyO8TQ4CluxPOZ21iRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="92918550"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 23:07:41 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 15 Nov 2024 09:07:34 +0200 (EET)
To: Stefan Wahren <wahrenst@gmx.net>
cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/PME+pciehp: Request IRQF_ONESHOT because bwctrl
 shares IRQ
In-Reply-To: <20241114142034.4388-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <98f49fdc-54d2-8d15-eee2-61e80db07f1c@linux.intel.com>
References: <20241114142034.4388-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-287076155-1731654454=:940"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-287076155-1731654454=:940
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 14 Nov 2024, Ilpo J=C3=A4rvinen wrote:

> PCIe BW controller uses IRQF_ONESHOT to solve the problem fixed by the
> commit 3e82a7f9031f ("PCI/LINK: Supply IRQ handler so level-triggered
> IRQs are acked"). The IRQ is shared with PME and PCIe hotplug. Due to
> probe order, PME and hotplug can request IRQ first without IRQF_ONESHOT
> and when BW controller requests IRQ later with IRQF_ONESHOT, the IRQ
> request fails. The problem is seen at least on Rasperry Pi 4:
>=20
> pcieport 0000:00:00.0: PME: Signaling with IRQ 39
> pcieport 0000:00:00.0: AER: enabled with IRQ 39
> genirq: Flags mismatch irq 39. 00002084 (PCIe bwctrl) vs.00200084 (PCIe P=
ME)
> pcie_bwctrl 0000:00:00.0:pcie010: probe with driver pcie_bwctrl failed wi=
th error -16
>=20
> BW controller is always enabled so change PME and pciehp too to use
> IRQF_ONESHOT.
>=20
> Fixes: 470b218c2bdf ("PCI/bwctrl: Re-add BW notification portdrv as PCIe =
BW controller")

This should be:

Fixes: 058a4cb11620 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW=
 controller")

(I wasn't thinking and used the local commit id instead of the one from=20
pci repo.)

> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Link: https://lore.kernel.org/linux-pci/dcd660fd-a265-4f47-8696-776a85e09=
7a0@gmx.net/
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 3 ++-
>  drivers/pci/pcie/pme.c           | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pcieh=
p_hpc.c
> index 736ad8baa2a5..0778305cff9d 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -68,7 +68,8 @@ static inline int pciehp_request_irq(struct controller =
*ctrl)
> =20
>  =09/* Installs the interrupt handler */
>  =09retval =3D request_threaded_irq(irq, pciehp_isr, pciehp_ist,
> -=09=09=09=09      IRQF_SHARED, "pciehp", ctrl);
> +=09=09=09=09      IRQF_SHARED | IRQF_ONESHOT,
> +=09=09=09=09      "pciehp", ctrl);
>  =09if (retval)
>  =09=09ctrl_err(ctrl, "Cannot get irq %d for the hotplug controller\n",
>  =09=09=09 irq);
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index a2daebd9806c..04f0e5a7b74c 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -347,7 +347,8 @@ static int pcie_pme_probe(struct pcie_device *srv)
>  =09pcie_pme_interrupt_enable(port, false);
>  =09pcie_clear_root_pme_status(port);
> =20
> -=09ret =3D request_irq(srv->irq, pcie_pme_irq, IRQF_SHARED, "PCIe PME", =
srv);
> +=09ret =3D request_irq(srv->irq, pcie_pme_irq, IRQF_SHARED | IRQF_ONESHO=
T,
> +=09=09=09  "PCIe PME", srv);
>  =09if (ret) {
>  =09=09kfree(data);
>  =09=09return ret;
>=20

--=20
 i.

--8323328-287076155-1731654454=:940--

