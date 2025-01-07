Return-Path: <linux-pci+bounces-19411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D254A04059
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241A47A19DB
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 13:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B962594A5;
	Tue,  7 Jan 2025 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcVJpO3+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1C6136
	for <linux-pci@vger.kernel.org>; Tue,  7 Jan 2025 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255237; cv=none; b=T23FrVLFVb9GysRqX5AvGmfSiFTByWzY9rrf6WShUftCJB/lt5ZvZksZOXzgs1TlOX+2ppZoH7U9tbhV6pUPGtS3KkZc6aIkGxnHXewqJ2DVOucjdL3x907b36h3O03nxR8DiSC7xPGPnqXQrrb1mf+QnZC4bMtrXu/Td4kVb9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255237; c=relaxed/simple;
	bh=sXbFsASHc+qA0S8DscCMfIjjPHs8GNCp8iEpBEvpSAg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HTHPC9DFny1u1ERfTVmexUimdncL9YVwLlC8X8P0UTPgLdyGrWISihXlQ4Ycg9zzLejyD6FSGc0AFV3Qs63NSLEXiA4oL8tLgKk2Jcso0gQj2mXUT1uFGCIaGkR/qaNDVD5ESScjDC0Y6wMkb7X1HZqzAinQqPPeZ6tC3vTHxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcVJpO3+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736255235; x=1767791235;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=sXbFsASHc+qA0S8DscCMfIjjPHs8GNCp8iEpBEvpSAg=;
  b=AcVJpO3+hzwKQn+E9wTgjQB3o7cP+sP5WwiwjmyTCtKN1lGw81m8HXQF
   ba3HJ4gQDDD1g0JcKTPgtC2gzJIH+C0dpWM3lDWq6FC1gZPAsUumFR9Ra
   dMaLEK6qbdc5PWvHvsqosinBaD8+aUjR/MEU3WD3/e46PtCWxFBvZsiQi
   1iTysjU4I7rOOQV0r7Ib/iOPXNqexZr2i82O+8kHT1bHBQltn45bXNx3z
   4iv9pBbL4JL3sYHWcfAXtGia2ykzJhDQzRfKdOGG6Zj0lJQsk++XSnSu+
   TuHxQpQbxQF721ru2PwBPNe1uSD6UPwcna7KkoEYYTXhR7Wo+6NqC/vxS
   A==;
X-CSE-ConnectionGUID: CrQ8k+G3SVutE51vPjQzew==
X-CSE-MsgGUID: tjiAwYbQTqa1IhK31pVUKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="40383195"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="40383195"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 05:07:14 -0800
X-CSE-ConnectionGUID: +x7+iXA/QlqoANMDDs2uvg==
X-CSE-MsgGUID: GUCx6RUrQL+pwQ+lEIT+Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="103273165"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.206])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 05:07:10 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Jan 2025 15:07:07 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, 
    Krzysztof Wilczynski <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, 
    Niklas Schnelle <niks@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Evert Vorster <evorster@gmail.com>
Subject: Re: [PATCH for-linus v2] PCI/bwctrl: Fix NULL pointer deref on unbind
 and bind
In-Reply-To: <ae2b02c9cfbefff475b6e132b0aa962aaccbd7b2.1736162539.git.lukas@wunner.de>
Message-ID: <53573804-3e34-611c-fe16-1e7452fcd2ba@linux.intel.com>
References: <ae2b02c9cfbefff475b6e132b0aa962aaccbd7b2.1736162539.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2055219220-1736254730=:1001"
Content-ID: <2ec4f773-174e-ab1b-8ddf-7da9de93c852@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2055219220-1736254730=:1001
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e5c4249f-26eb-b459-f6d1-77c08931f9b7@linux.intel.com>

On Mon, 6 Jan 2025, Lukas Wunner wrote:

> The interrupt handler for bandwidth notifications, pcie_bwnotif_irq(),
> dereferences a "data" pointer.
>=20
> On unbind, that pointer is set to NULL by pcie_bwnotif_remove().  However
> the interrupt handler may still be invoked afterwards and will dereferenc=
e
> that NULL pointer.
>=20
> That's because the interrupt is requested using a devm_*() helper and the
> driver core releases devm_*() resources *after* calling ->remove().
>=20
> pcie_bwnotif_remove() does clear the Link Bandwidth Management Interrupt
> Enable and Link Autonomous Bandwidth Interrupt Enable bits in the Link
> Control Register, but that won't prevent execution of pcie_bwnotif_irq():
> The interrupt for bandwidth notifications may be shared with AER, DPC,
> PME, and hotplug.  So pcie_bwnotif_irq() may be executed as long as the
> interrupt is requested.
>=20
> There's a similar race on bind:  pcie_bwnotif_probe() requests the
> interrupt when the "data" pointer still points to NULL.  A NULL pointer
> deref may thus likewise occur if AER, DPC, PME or hotplug raise an
> interrupt in-between the bandwidth controller's call to devm_request_irq(=
)
> and assignment of the "data" pointer.
>=20
> Drop the devm_*() usage and reorder requesting of the interrupt to fix th=
e
> issue.
>=20
> While at it, drop a stray but harmless no_free_ptr() invocation when
> assigning the "data" pointer in pcie_bwnotif_probe().
>=20
> Ilpo points out that the locking on unbind and bind needs to be symmetric=
,
> so move the call to pcie_bwnotif_disable() inside the critical section
> protected by pcie_bwctrl_setspeed_rwsem and pcie_bwctrl_lbms_rwsem.
>=20
> Evert reports a hang on shutdown of an ASUS ROG Strix SCAR 17 G733PYV.
> The issue is no longer reproducible with the present commit.
>=20
> Evert found that attaching a USB-C monitor prevented the hang.  The
> machine contains an ASMedia USB 3.2 controller below a hotplug-capable
> Root Port.  So one possible explanation is that the controller gets
> hot-removed on shutdown unless something is connected.  And the ensuing
> hotplug interrupt occurs exactly when the bandwidth controller is
> unregistering.  The precise cause could not be determined because the
> screen had already turned black when the hang occurred.
>=20
> Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe =
BW controller")
> Reported-by: Evert Vorster <evorster@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219629
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Tested-by: Evert Vorster <evorster@gmail.com>
> ---
> Changes v1 -> v2 (in response to Ilpo's review):
>  Move request_irq() inside critical section on bind.
>  Move free_irq() + pcie_bwnotif_disable() inside critical section on unbi=
nd.
>  Amend commit message with a paragraph explaining these changes.
>=20
>  drivers/pci/pcie/bwctrl.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index b59cacc740fa..0a5e7efbce2c 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -303,14 +303,17 @@ static int pcie_bwnotif_probe(struct pcie_device *s=
rv)
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09ret =3D devm_request_irq(&srv->device, srv->irq, pcie_bwnotif_irq,
> -=09=09=09       IRQF_SHARED, "PCIe bwctrl", srv);
> -=09if (ret)
> -=09=09return ret;
> -
>  =09scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
>  =09=09scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
> -=09=09=09port->link_bwctrl =3D no_free_ptr(data);
> +=09=09=09port->link_bwctrl =3D data;
> +
> +=09=09=09ret =3D request_irq(srv->irq, pcie_bwnotif_irq,
> +=09=09=09=09=09  IRQF_SHARED, "PCIe bwctrl", srv);
> +=09=09=09if (ret) {
> +=09=09=09=09port->link_bwctrl =3D NULL;
> +=09=09=09=09return ret;
> +=09=09=09}
> +
>  =09=09=09pcie_bwnotif_enable(srv);
>  =09=09}
>  =09}
> @@ -331,11 +334,15 @@ static void pcie_bwnotif_remove(struct pcie_device =
*srv)
> =20
>  =09pcie_cooling_device_unregister(data->cdev);
> =20
> -=09pcie_bwnotif_disable(srv->port);
> +=09scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
> +=09=09scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
> +=09=09=09pcie_bwnotif_disable(srv->port);
> +
> +=09=09=09free_irq(srv->irq, srv);
> =20
> -=09scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem)
> -=09=09scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem)
>  =09=09=09srv->port->link_bwctrl =3D NULL;
> +=09=09}
> +=09}
>  }
> =20
>  static int pcie_bwnotif_suspend(struct pcie_device *srv)

Thanks for the update,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

I suppose Niklas has not had time to test if this solved the other issue?

--=20
 i.
--8323328-2055219220-1736254730=:1001--

