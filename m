Return-Path: <linux-pci+bounces-10265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B80B931475
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 14:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277961F21F8A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6168218C199;
	Mon, 15 Jul 2024 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WriNx1Kw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B9E18A944;
	Mon, 15 Jul 2024 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047021; cv=none; b=E3ufxU/m9w23as1Z93B06omEuX7zb3UeuV+N55HsvWGHhKA2J/OrenvWbpq0Nf+u3H9bh0fHkeGLAb6/dL9xueYbwHh8PIcmUCsyq655xbp6eyDolHMERp37gkhNMkj5r5NenISXkLnRHJpddm+psHbAS8QqdDi/qWASGYmyy+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047021; c=relaxed/simple;
	bh=lGTgDdw0D3LgnUyX4dXtePNOhp9in10pEAeYuGJ54gU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YAXIT0jDJ206YpV0/dX5DWf+Fv1sWEJF1qKE2cmRW9N7Q0wc7TDg9Mi0jEV6RQGg9tnqorZm6OCCDwnSwGc8ZFoV8hyqdtYKjcbfZSqI/KiNPXs2KqjOM0eodcdbbL2NoUypkNlSOtwZ26QK1i1JdLG/wtacU2yKz5Va9HSmxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WriNx1Kw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721047019; x=1752583019;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=lGTgDdw0D3LgnUyX4dXtePNOhp9in10pEAeYuGJ54gU=;
  b=WriNx1KwLAohhyialObweRLoxZu+zw4ldANGsmbmBqMte76ud3fA8b2s
   lIfHk5I77lvvxFckk/N6qrX+L1P/L3rm1DJB9XpbkNz/+1AX9tDEqJpUJ
   r1fqHPA6YNQGhEaOTeLW9mRlDYxuFFl69LtfKO7iBD6kdxupUJt8MYHiM
   jWF6RITfxK9xqsYTMcXXZaAa4oha2Ol6XZ8oyIO+JeItEl1IuEBhVudfg
   zaDP9LOGUAgqiEwUGfx52js24pnsFJ8Xznv1Em+rAWd2DQjAWGNb29G7y
   G8xCwbT9HcwdSpve8N1dJmCTciIrKZHgd49XI5iDWmRbgWIPp9LPj2cfH
   g==;
X-CSE-ConnectionGUID: aCJYLc8KRCC6rIXrFJlQVw==
X-CSE-MsgGUID: vmh8KRdWR/KOE1FSi4iMWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="29012835"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="29012835"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 05:36:59 -0700
X-CSE-ConnectionGUID: p79mAvRxS6uC/AWugJ5V4Q==
X-CSE-MsgGUID: 0bsbbmOVQXK+BgeNncbNrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49497247"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.131])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 05:36:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 15 Jul 2024 15:36:50 +0300 (EEST)
To: superm1@kernel.org
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Mathias Nyman <mathias.nyman@intel.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>, 
    Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 1/5] PCI: Use an enum for reset type in
 pci_dev_wait()
In-Reply-To: <20240712181246.811044-2-superm1@kernel.org>
Message-ID: <c67b005a-2378-2ce9-e55b-da807fd1811a@linux.intel.com>
References: <20240712181246.811044-1-superm1@kernel.org> <20240712181246.811044-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1789045202-1721046575=:1424"
Content-ID: <798844da-5d0a-555d-6478-d69161bbec3b@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1789045202-1721046575=:1424
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <3b6b0dbd-8593-9c57-8b49-00a0de00e557@linux.intel.com>

On Fri, 12 Jul 2024, superm1@kernel.org wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> A string is passed to all callers of pci_dev_wait() which is utilized
> to demonstrate what kind of reset happened when there was a problem.
>=20
> This doesn't allow making the behavior for different reset types
> conditional though. Lay some plumbing to allow making comparisons of
> reset types with integers instead. No functional changes.
>=20
> Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci-driver.c |  2 +-
>  drivers/pci/pci.c        | 29 +++++++++++++++++++----------
>  drivers/pci/pci.h        | 11 ++++++++++-
>  drivers/pci/pcie/dpc.c   |  2 +-
>  4 files changed, 31 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index af2996d0d17ff..ff97d08741df7 100644
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
> index 35fb1f17a589c..115361a08d9e3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -181,6 +181,15 @@ static int __init pcie_port_pm_setup(char *str)
>  }
>  __setup("pcie_port_pm=3D", pcie_port_pm_setup);
> =20
> +const char * const pci_reset_types[] =3D {

Sparse is not happy about this and expects static as it is not defined=20
by any header (LKP seems to also have caught this).

> +=09"FLR",
> +=09"AF_FLR",
> +=09"PM D3HOT->D0",
> +=09"bus reset",
> +=09"resume",
> +=09"DPC",

Perhaps the index-based array initialization format would be beneficial=20
here.

--=20
 i.

> +};
> +
>  /**
>   * pci_bus_max_busnr - returns maximum PCI bus number of given bus' chil=
dren
>   * @bus: pointer to PCI bus structure to search
> @@ -1250,7 +1259,7 @@ void pci_resume_bus(struct pci_bus *bus)
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
> @@ -1288,7 +1297,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *=
reset_type, int timeout)
> =20
>  =09=09if (delay > timeout) {
>  =09=09=09pci_warn(dev, "not ready %dms after %s; giving up\n",
> -=09=09=09=09 delay - 1, reset_type);
> +=09=09=09=09 delay - 1, pci_reset_types[reset_type]);
>  =09=09=09return -ENOTTY;
>  =09=09}
> =20
> @@ -1301,7 +1310,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *=
reset_type, int timeout)
>  =09=09=09=09}
>  =09=09=09}
>  =09=09=09pci_info(dev, "not ready %dms after %s; waiting\n",
> -=09=09=09=09 delay - 1, reset_type);
> +=09=09=09=09 delay - 1, pci_reset_types[reset_type]);
>  =09=09}
> =20
>  =09=09msleep(delay);
> @@ -1310,10 +1319,10 @@ static int pci_dev_wait(struct pci_dev *dev, char=
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
> @@ -4465,7 +4474,7 @@ int pcie_flr(struct pci_dev *dev)
>  =09 */
>  =09msleep(100);
> =20
> -=09return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
> +=09return pci_dev_wait(dev, PCI_DEV_WAIT_FLR, PCIE_RESET_READY_POLL_MS);
>  }
>  EXPORT_SYMBOL_GPL(pcie_flr);
> =20
> @@ -4532,7 +4541,7 @@ static int pci_af_flr(struct pci_dev *dev, bool pro=
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
> @@ -4577,7 +4586,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool p=
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
> @@ -4751,7 +4760,7 @@ static int pci_bus_max_d3cold_delay(const struct pc=
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
>  =09struct pci_dev *child;
>  =09int delay;
> @@ -4885,7 +4894,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *=
dev)
>  {
>  =09pcibios_reset_secondary_bus(dev);
> =20
> -=09return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
> +=09return pci_bridge_wait_for_secondary_bus(dev, PCI_DEV_WAIT_BUS_RESET)=
;
>  }
>  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
> =20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fd44565c47562..88f54d22118dc 100644
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
> @@ -94,7 +103,7 @@ void pci_msi_init(struct pci_dev *dev);
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
> index a668820696dc0..306efc399e503 100644
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
--8323328-1789045202-1721046575=:1424--

