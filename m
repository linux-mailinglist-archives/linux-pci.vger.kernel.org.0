Return-Path: <linux-pci+bounces-23643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADADA5F80F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F34B4208BA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBD1267F5C;
	Thu, 13 Mar 2025 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8kybxds"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AB235371;
	Thu, 13 Mar 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876017; cv=none; b=MkqxsfJNy+ke3NqZbvI/qGLAhce4yvSt0cyAeRkjT4an+Ke82qTLyS1AHW7BrHRz+7fUSuFSGgWP9fJzopubDMtAeBB2p/CBwLQ1AIESY17fnJmN6CGVRnRcr6pHZaFOG9GN1lFsxaRgrfND2Wsk2F+QB6IdwhLNdKPPtcfpxIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876017; c=relaxed/simple;
	bh=fezMXDcXRBNzWfZdcW9ryX3M5SWXCzszMpvzZiDja08=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bKkGWWY5ztVnvqFhJ3C4mJTe4sJNGQLyjNIfxuSe+Dk3XzXvyvAW28PawjJtCFFud1mRPCK1nbN5EZOqdfzHli/XTsT2vRMPqJ0HX2dqwqE78mzEXy8uATfdhP4FeBZVHR5LQ7ig5SiO9Wukx0kGju0ttCnF4LribDHnnWmCwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8kybxds; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741876015; x=1773412015;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fezMXDcXRBNzWfZdcW9ryX3M5SWXCzszMpvzZiDja08=;
  b=D8kybxdsA0+eEGCgWe4TZyWaoyI1RvmKJG5nvbBEehUppBxjhTEFvpuc
   bSqjk2JLhHvOHHLZ1GNgVs455wp8O+zPoHfKARhHMqdETZIy/XwnlROr4
   7zDgerK6vU4J9kyHVrbgz8nXac59+QhQNI5rl4n2hZL0ETd2R3J171puM
   HDktJnYUOV2f7pjh0WPGnCREGEjkZAS6JhyMlcRqNHA5f7e6SLNnjOmCK
   aDmSK/Yd+B+EllpGOhpjMYCLzQIhVNhN4XS+lJ7pOi4U9V4qv54Z/UoDL
   +mtQ3pVSsZXNuh8KPWIEabPddhJ9klb/BPhceoSJ2m+gsrREjv4U94AC2
   g==;
X-CSE-ConnectionGUID: JrGo2JLeTGGUuHzz+7Hz1w==
X-CSE-MsgGUID: v2UpWuLgSsC3YkDpiehGdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="54369570"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="54369570"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:26:52 -0700
X-CSE-ConnectionGUID: 9myKUdsvSDKqxpToO1wiew==
X-CSE-MsgGUID: 7iwWhtMoRWyJ+L2azKD/YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="125860910"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:26:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Mar 2025 16:26:47 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>
cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Joel Mathew Thomas <proxy0@tutamail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Disable PCIe BW controller during
 reset
In-Reply-To: <20250217165258.3811-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <ed63e434-6c0b-4111-28a4-2a4a2c2f3725@linux.intel.com>
References: <20250217165258.3811-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-657390622-1741876007=:1742"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-657390622-1741876007=:1742
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 17 Feb 2025, Ilpo J=C3=A4rvinen wrote:

> PCIe BW controller enables BW notifications for Downstream Ports by
> setting Link Bandwidth Management Interrupt Enable (LBMIE) and Link
> Autonomous Bandwidth Interrupt Enable (LABIE) (PCIe Spec. r6.2 sec.
> 7.5.3.7).
>=20
> It was discovered that performing a reset can lead to the device
> underneath the Downstream Port becoming unavailable if BW notifications
> are left enabled throughout the reset sequence (at least LBMIE was
> found to cause an issue).
>=20
> While the PCIe Specifications do not indicate BW notifications could not
> be kept enabled during resets, the PCIe Link state during an
> intentional reset is not of large interest. Thus, disable BW controller
> for the bridge while reset is performed and re-enable it after the
> reset has completed to workaround the problems some devices encounter
> if BW notifications are left on throughout the reset sequence.
>=20
> Keep a counter for the disable/enable because MFD will execute
> pci_dev_save_and_disable() and pci_dev_restore() back to back for
> sibling devices:
>=20
> [   50.139010] vfio-pci 0000:01:00.0: resetting
> [   50.139053] vfio-pci 0000:01:00.1: resetting
> [   50.141126] pcieport 0000:00:01.1: PME: Spurious native interrupt!
> [   50.141133] pcieport 0000:00:01.1: PME: Spurious native interrupt!
> [   50.441466] vfio-pci 0000:01:00.0: reset done
> [   50.501534] vfio-pci 0000:01:00.1: reset done
>=20
> Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe =
BW controller")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219765
> Tested-by: Joel Mathew Thomas <proxy0@tutamail.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>=20
> I suspect the root cause is some kind of violation of specifications.
> Resets shouldn't cause devices to become unavailable just because BW
> notifications have been enabled.
>=20
> Before somebody comments on those dual rwsems, I do have yet to be
> submitted patch to simplify the locking as per Lukas Wunner's earlier
> suggestion. I've just focused on solving the regressions first.

Hi all,

This problem was root caused to a problem in hotplug code so this patch=20
should not be applied. I've just sent a series to address the=20
synchronization problems the hotplug code and it should be considered=20
instead to fix the issues this patch attempted to workaround.

--=20
 i.

>  drivers/pci/pci.c         |  8 +++++++
>  drivers/pci/pci.h         |  4 ++++
>  drivers/pci/pcie/bwctrl.c | 49 ++++++++++++++++++++++++++++++++-------
>  3 files changed, 53 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..7a53d7474175 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5148,6 +5148,7 @@ static void pci_dev_save_and_disable(struct pci_dev=
 *dev)
>  {
>  =09const struct pci_error_handlers *err_handler =3D
>  =09=09=09dev->driver ? dev->driver->err_handler : NULL;
> +=09struct pci_dev *bridge =3D pci_upstream_bridge(dev);
> =20
>  =09/*
>  =09 * dev->driver->err_handler->reset_prepare() is protected against
> @@ -5166,6 +5167,9 @@ static void pci_dev_save_and_disable(struct pci_dev=
 *dev)
>  =09 */
>  =09pci_set_power_state(dev, PCI_D0);
> =20
> +=09if (bridge)
> +=09=09pcie_bwnotif_disable(bridge);
> +
>  =09pci_save_state(dev);
>  =09/*
>  =09 * Disable the device by clearing the Command register, except for
> @@ -5181,9 +5185,13 @@ static void pci_dev_restore(struct pci_dev *dev)
>  {
>  =09const struct pci_error_handlers *err_handler =3D
>  =09=09=09dev->driver ? dev->driver->err_handler : NULL;
> +=09struct pci_dev *bridge =3D pci_upstream_bridge(dev);
> =20
>  =09pci_restore_state(dev);
> =20
> +=09if (bridge)
> +=09=09pcie_bwnotif_enable(bridge);
> +
>  =09/*
>  =09 * dev->driver->err_handler->reset_done() is protected against
>  =09 * races with ->remove() by the device lock, which must be held by
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..856546f1aad9 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -759,12 +759,16 @@ static inline void pcie_ecrc_get_policy(char *str) =
{ }
>  #ifdef CONFIG_PCIEPORTBUS
>  void pcie_reset_lbms_count(struct pci_dev *port);
>  int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
> +void pcie_bwnotif_enable(struct pci_dev *port);
> +void pcie_bwnotif_disable(struct pci_dev *port);
>  #else
>  static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
>  static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *v=
al)
>  {
>  =09return -EOPNOTSUPP;
>  }
> +static inline void pcie_bwnotif_enable(struct pci_dev *port) {}
> +static inline void pcie_bwnotif_disable(struct pci_dev *port) {}
>  #endif
> =20
>  struct pci_dev_reset_methods {
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index 0a5e7efbce2c..a117f6f67c07 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -40,11 +40,13 @@
>   * @set_speed_mutex:=09Serializes link speed changes
>   * @lbms_count:=09=09Count for LBMS (since last reset)
>   * @cdev:=09=09Thermal cooling device associated with the port
> + * @disable_count:=09BW notifications disabled/enabled counter
>   */
>  struct pcie_bwctrl_data {
>  =09struct mutex set_speed_mutex;
>  =09atomic_t lbms_count;
>  =09struct thermal_cooling_device *cdev;
> +=09int disable_count;
>  };
> =20
>  /*
> @@ -200,10 +202,9 @@ int pcie_set_target_speed(struct pci_dev *port, enum=
 pci_bus_speed speed_req,
>  =09return ret;
>  }
> =20
> -static void pcie_bwnotif_enable(struct pcie_device *srv)
> +static void __pcie_bwnotif_enable(struct pci_dev *port)
>  {
> -=09struct pcie_bwctrl_data *data =3D srv->port->link_bwctrl;
> -=09struct pci_dev *port =3D srv->port;
> +=09struct pcie_bwctrl_data *data =3D port->link_bwctrl;
>  =09u16 link_status;
>  =09int ret;
> =20
> @@ -224,12 +225,44 @@ static void pcie_bwnotif_enable(struct pcie_device =
*srv)
>  =09pcie_update_link_speed(port->subordinate);
>  }
> =20
> -static void pcie_bwnotif_disable(struct pci_dev *port)
> +void pcie_bwnotif_enable(struct pci_dev *port)
> +{
> +=09guard(rwsem_read)(&pcie_bwctrl_setspeed_rwsem);
> +=09guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
> +
> +=09if (!port->link_bwctrl)
> +=09=09return;
> +
> +=09port->link_bwctrl->disable_count--;
> +=09if (!port->link_bwctrl->disable_count) {
> +=09=09__pcie_bwnotif_enable(port);
> +=09=09pci_dbg(port, "BW notifications enabled\n");
> +=09}
> +=09WARN_ON_ONCE(port->link_bwctrl->disable_count < 0);
> +}
> +
> +static void __pcie_bwnotif_disable(struct pci_dev *port)
>  {
>  =09pcie_capability_clear_word(port, PCI_EXP_LNKCTL,
>  =09=09=09=09   PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
>  }
> =20
> +void pcie_bwnotif_disable(struct pci_dev *port)
> +{
> +=09guard(rwsem_read)(&pcie_bwctrl_setspeed_rwsem);
> +=09guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
> +
> +=09if (!port->link_bwctrl)
> +=09=09return;
> +
> +=09port->link_bwctrl->disable_count++;
> +
> +=09if (port->link_bwctrl->disable_count =3D=3D 1) {
> +=09=09__pcie_bwnotif_disable(port);
> +=09=09pci_dbg(port, "BW notifications disabled\n");
> +=09}
> +}
> +
>  static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
>  {
>  =09struct pcie_device *srv =3D context;
> @@ -314,7 +347,7 @@ static int pcie_bwnotif_probe(struct pcie_device *srv=
)
>  =09=09=09=09return ret;
>  =09=09=09}
> =20
> -=09=09=09pcie_bwnotif_enable(srv);
> +=09=09=09__pcie_bwnotif_enable(port);
>  =09=09}
>  =09}
> =20
> @@ -336,7 +369,7 @@ static void pcie_bwnotif_remove(struct pcie_device *s=
rv)
> =20
>  =09scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
>  =09=09scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
> -=09=09=09pcie_bwnotif_disable(srv->port);
> +=09=09=09__pcie_bwnotif_disable(srv->port);
> =20
>  =09=09=09free_irq(srv->irq, srv);
> =20
> @@ -347,13 +380,13 @@ static void pcie_bwnotif_remove(struct pcie_device =
*srv)
> =20
>  static int pcie_bwnotif_suspend(struct pcie_device *srv)
>  {
> -=09pcie_bwnotif_disable(srv->port);
> +=09__pcie_bwnotif_disable(srv->port);
>  =09return 0;
>  }
> =20
>  static int pcie_bwnotif_resume(struct pcie_device *srv)
>  {
> -=09pcie_bwnotif_enable(srv);
> +=09__pcie_bwnotif_enable(srv->port);
>  =09return 0;
>  }
> =20
>=20
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
>=20
--8323328-657390622-1741876007=:1742--

