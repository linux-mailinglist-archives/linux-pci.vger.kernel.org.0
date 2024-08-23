Return-Path: <linux-pci+bounces-12088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE095CBCD
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 13:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91291C23E03
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A562718756A;
	Fri, 23 Aug 2024 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epQqbInX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D1187847;
	Fri, 23 Aug 2024 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414227; cv=none; b=d5aCalg8ettDfRRMm1Y40FtcSikG+MP09vPQXMgnVmJUOi/FGhqGtksbeXYkE9n0kAMtL5n9TLOhRWEsHKn25YmIl2dHL6y9gDJu5yuzWWwfz5fqYSHpoCZuSRUXc9NcVB8aWuUV51ukhr58kKwFHLATMR+RsnajRcGJKoBTYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414227; c=relaxed/simple;
	bh=B97GWLVIdXC8TO85HGWaNAJLewjppBPRRXHX3Hkk548=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NJkXuaiLH/O4kdGm4ZbHckaa4EbwFAdwoySmhft3t1izi2W0pMa92LxnqsS0CwZW56I6uVROa/4wqHvVoxUbgkE+jmVvR/Y8LRVMIRA0Lv2kfZN/Lt7QkYwM5eHwwYlotYL1laCmUGa4h3Pvm55wmoyN8kDQyD6DHceYyFl3c4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epQqbInX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724414226; x=1755950226;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=B97GWLVIdXC8TO85HGWaNAJLewjppBPRRXHX3Hkk548=;
  b=epQqbInXTelM3z3EDTcd6HUEJ9GB9j7byl4onE+CFuz1PHqFkRMSV0Pu
   +dpecNiy8ywD4veJ8AgiYnxvUoLqwC+mlM5g8i16+ebLjOXEkbqeSO9mL
   bHqIJPKP4id7+VdSwKAJb+hy2aeUC7rA8MccROdhIK2pxevC1Np5H0K0+
   93BAFF5alHlCVxTwBksfuJh3li1DMsB3UfXRDQ1yLKViN0XbFbS89xerE
   32qkmPsTEwPj1VneXJmN9Lk3ZKLjgWxWPafbIRMC+4T26V5AN+gK260H3
   Yzzxdn81+C3SNUb67AYX1BxRziGbCpVR5/GOLMfMBRlyEn1wjicEqUT9t
   Q==;
X-CSE-ConnectionGUID: RWOg8lZjQPawO02aUzmE9g==
X-CSE-MsgGUID: cvSDkiiST7SsaKZWa2GbiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22690773"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="22690773"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 04:57:05 -0700
X-CSE-ConnectionGUID: r/YtzQ8RTOyZyCATh1WQYg==
X-CSE-MsgGUID: XAaZUiFDRwuQt1zj6QYP4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="84960961"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.2])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 04:57:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Aug 2024 14:56:57 +0300 (EEST)
To: Mario Limonciello <superm1@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Mathias Nyman <mathias.nyman@intel.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>, 
    Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v4 1/5] PCI: Use an enum for reset type in
 pci_dev_wait()
In-Reply-To: <20240823042508.1057791-2-superm1@kernel.org>
Message-ID: <9b8626c8-46fd-6e2d-12ad-592889128172@linux.intel.com>
References: <20240823042508.1057791-1-superm1@kernel.org> <20240823042508.1057791-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-979799848-1724414217=:2230"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-979799848-1724414217=:2230
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Aug 2024, Mario Limonciello wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> A string is passed to all callers of pci_dev_wait() which is utilized
> to demonstrate what kind of reset happened when there was a problem.
>=20
> This doesn't allow making the behavior for different reset types
> conditional though. Lay some plumbing to allow making comparisons of
> reset types with integers instead. No functional changes.
>=20
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
> v3->v4:
>  * Use index-based array initialization format for pci_reset_types
>  * Fix LKP reported sparse issue
> ---
>  drivers/pci/pci-driver.c |  2 +-
>  drivers/pci/pci.c        | 29 +++++++++++++++++++----------
>  drivers/pci/pci.h        | 11 ++++++++++-
>  drivers/pci/pcie/dpc.c   |  2 +-
>  4 files changed, 31 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f412ef73a6e4b..ac3cfbfa137d9 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -572,7 +572,7 @@ static void pci_pm_bridge_power_up_actions(struct pci=
_dev *pci_dev)
>  {
>  =09int ret;
> =20
> -=09ret =3D pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
> +=09ret =3D pci_bridge_wait_for_secondary_bus(pci_dev, PCI_DEV_WAIT_RESUM=
E);
>  =09if (ret) {
>  =09=09/*
>  =09=09 * The downstream link failed to come up, so mark the
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ffaaca0978cbc..e4a7f5dfe6bf4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -181,6 +181,15 @@ static int __init pcie_port_pm_setup(char *str)
>  }
>  __setup("pcie_port_pm=3D", pcie_port_pm_setup);
> =20
> +static const char * const pci_reset_types[] =3D {
> +=09[PCI_DEV_WAIT_FLR] =3D "FLR",
> +=09[PCI_DEV_WAIT_AF_FLR] =3D "AF_FLR",
> +=09[PCI_DEV_WAIT_D3HOT_D0] =3D "PM D3HOT->D0",
> +=09[PCI_DEV_WAIT_BUS_RESET] =3D "bus reset",
> +=09[PCI_DEV_WAIT_RESUME] =3D "resume",
> +=09[PCI_DEV_WAIT_DPC] =3D "DPC",
> +};
> +
>  /**
>   * pci_bus_max_busnr - returns maximum PCI bus number of given bus' chil=
dren
>   * @bus: pointer to PCI bus structure to search
> @@ -1279,7 +1288,7 @@ void pci_resume_bus(struct pci_bus *bus)
>  =09=09pci_walk_bus(bus, pci_resume_one, NULL);
>  }
> =20
> -static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeo=
ut)
> +static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_t=
ype, int timeout)
>  {
>  =09int delay =3D 1;
>  =09bool retrain =3D false;
> @@ -1317,7 +1326,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *=
reset_type, int timeout)
> =20
>  =09=09if (delay > timeout) {
>  =09=09=09pci_warn(dev, "not ready %dms after %s; giving up\n",
> -=09=09=09=09 delay - 1, reset_type);
> +=09=09=09=09 delay - 1, pci_reset_types[reset_type]);
>  =09=09=09return -ENOTTY;
>  =09=09}
> =20
> @@ -1330,7 +1339,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *=
reset_type, int timeout)
>  =09=09=09=09}
>  =09=09=09}
>  =09=09=09pci_info(dev, "not ready %dms after %s; waiting\n",
> -=09=09=09=09 delay - 1, reset_type);
> +=09=09=09=09 delay - 1, pci_reset_types[reset_type]);
>  =09=09}
> =20
>  =09=09msleep(delay);
> @@ -1339,10 +1348,10 @@ static int pci_dev_wait(struct pci_dev *dev, char=
 *reset_type, int timeout)
> =20
>  =09if (delay > PCI_RESET_WAIT)
>  =09=09pci_info(dev, "ready %dms after %s\n", delay - 1,
> -=09=09=09 reset_type);
> +=09=09=09 pci_reset_types[reset_type]);
>  =09else
>  =09=09pci_dbg(dev, "ready %dms after %s\n", delay - 1,
> -=09=09=09reset_type);
> +=09=09=09pci_reset_types[reset_type]);
> =20
>  =09return 0;
>  }
> @@ -4536,7 +4545,7 @@ int pcie_flr(struct pci_dev *dev)
>  =09 */
>  =09msleep(100);
> =20
> -=09return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
> +=09return pci_dev_wait(dev, PCI_DEV_WAIT_FLR, PCIE_RESET_READY_POLL_MS);
>  }
>  EXPORT_SYMBOL_GPL(pcie_flr);
> =20
> @@ -4603,7 +4612,7 @@ static int pci_af_flr(struct pci_dev *dev, bool pro=
be)
>  =09 */
>  =09msleep(100);
> =20
> -=09return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
> +=09return pci_dev_wait(dev, PCI_DEV_WAIT_AF_FLR, PCIE_RESET_READY_POLL_M=
S);
>  }
> =20
>  /**
> @@ -4648,7 +4657,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool p=
robe)
>  =09pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
>  =09pci_dev_d3_sleep(dev);
> =20
> -=09return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
> +=09return pci_dev_wait(dev, PCI_DEV_WAIT_D3HOT_D0, PCIE_RESET_READY_POLL=
_MS);
>  }
> =20
>  /**
> @@ -4822,7 +4831,7 @@ static int pci_bus_max_d3cold_delay(const struct pc=
i_bus *bus)
>   * Return 0 on success or -ENOTTY if the first device on the secondary b=
us
>   * failed to become accessible.
>   */
> -int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_t=
ype)
> +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, enum pci_rese=
t_type reset_type)
>  {
>  =09struct pci_dev *child __free(pci_dev_put) =3D NULL;
>  =09int delay;
> @@ -4959,7 +4968,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *=
dev)
>  =09=09=09      __builtin_return_address(0));
>  =09pcibios_reset_secondary_bus(dev);
> =20
> -=09return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
> +=09return pci_bridge_wait_for_secondary_bus(dev, PCI_DEV_WAIT_BUS_RESET)=
;
>  }
>  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
> =20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 79c8398f39384..477257e843952 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -4,6 +4,15 @@
> =20
>  #include <linux/pci.h>
> =20
> +enum pci_reset_type {
> +=09PCI_DEV_WAIT_FLR,
> +=09PCI_DEV_WAIT_AF_FLR,
> +=09PCI_DEV_WAIT_D3HOT_D0,
> +=09PCI_DEV_WAIT_BUS_RESET,
> +=09PCI_DEV_WAIT_RESUME,
> +=09PCI_DEV_WAIT_DPC,
> +};
> +
>  /* Number of possible devfns: 0.0 to 1f.7 inclusive */
>  #define MAX_NR_DEVFNS 256
> =20
> @@ -137,7 +146,7 @@ void pci_msi_init(struct pci_dev *dev);
>  void pci_msix_init(struct pci_dev *dev);
>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
> -int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_t=
ype);
> +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, enum pci_rese=
t_type reset_type);
> =20
>  static inline void pci_wakeup_event(struct pci_dev *dev)
>  {
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 2b6ef7efa3c11..95cd985244729 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -174,7 +174,7 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  =09pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>  =09=09=09      PCI_EXP_DPC_STATUS_TRIGGER);
> =20
> -=09if (pci_bridge_wait_for_secondary_bus(pdev, "DPC")) {
> +=09if (pci_bridge_wait_for_secondary_bus(pdev, PCI_DEV_WAIT_DPC)) {
>  =09=09clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>  =09=09ret =3D PCI_ERS_RESULT_DISCONNECT;
>  =09} else {
>=20
--8323328-979799848-1724414217=:2230--

