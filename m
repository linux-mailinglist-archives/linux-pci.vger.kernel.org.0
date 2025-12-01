Return-Path: <linux-pci+bounces-42365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA03C9787A
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 14:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9D43A1551
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 13:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC1B3148D8;
	Mon,  1 Dec 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDQYJnBk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C523148C1;
	Mon,  1 Dec 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764594490; cv=none; b=jwfsKlux/8D2efyxwK2plrVAjfNgfX//ZgEthcmtKA/UlqV5n7icYgYgKKEwUsFNlaLlfEE4en29UtcBIwAdfJM7+gjjp8RD+765UNyxIzSBGtGIEr9tIdl8kFohpvn/gfVwdUhPGnJYQAZ+/XC9IO5FaAFdaoPSwI90Rbvq1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764594490; c=relaxed/simple;
	bh=c3tQXWmkAgcOW+LxaLEUkELxq7uR8jAEyPSODdvjLe0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=caiq5m6QIxizz4Canh35afL+vZaL2dEZHj0DHwiG/i3eEy0+QLLXq/0x3e4XlVJ+un3dObP8nFUci0f56d2lNtgPdJghVQdGI6JpvHZu4kze0zKt7QtUyOFUn5tmxYfFQrH/5aOYvsUBkRG4r56NzcxhxeoquTZuDTFpFpa2/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDQYJnBk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764594487; x=1796130487;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c3tQXWmkAgcOW+LxaLEUkELxq7uR8jAEyPSODdvjLe0=;
  b=FDQYJnBkenzyzX6xLCAnp7U+v1j6jpvLKV3j9DyyKO6roj7ATkPA0I3X
   F/Phb4qPLeWVpagIJek2gJd8hwwltXVmN3BpjoDyqBnBnjaQe/gU7zYlB
   8pDZz5urElv/VcfgaZx5chHutB7xC1ToaQu4gjSWkwvr6MDnEfpU/RbUu
   8vuygceovKK7FKfTjNhmCKohUk3oDkxO1Uc1F3XaGbwCccFrB73yk+l3V
   xiiJ+wWjK4uysKlzJtIonc4aG2EOkBAiVtoZJh3F+qvV6mrOqvoJhMZQL
   8HPAVYV8LRShJvh4sVNh3Wcx9RJG0Uy64mya/mfYhOlVQIg88ud4S+4/t
   A==;
X-CSE-ConnectionGUID: H3leZT1lTzmolp5/8kiakQ==
X-CSE-MsgGUID: ufhYRaI6Tbaxn3+qclb6yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="70392675"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="70392675"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 05:08:07 -0800
X-CSE-ConnectionGUID: lYb2z6TZRAaRk1FmlkJY9Q==
X-CSE-MsgGUID: l5xcyfZHTFyHvzePnKyz5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="193330086"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.202])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 05:08:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 1 Dec 2025 15:08:01 +0200 (EET)
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, kanie@linux.alibaba.com, 
    alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v2] PCI: Fix PCIe SBR dev/link wait error
In-Reply-To: <8ad1dec8-79eb-4189-aab0-cd62a1ed0c37@linux.alibaba.com>
Message-ID: <d285f1b6-8758-efd3-da0e-6448033519fc@linux.intel.com>
References: <2e3a1e6b-40ae-3878-e237-fb9032796af8@linux.intel.com> <20251129163631.2908340-1-guanghuifeng@linux.alibaba.com> <74bcafc2-9d36-06d0-5ed4-66694356588d@linux.intel.com> <8ad1dec8-79eb-4189-aab0-cd62a1ed0c37@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1815540855-1764594481=:974"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1815540855-1764594481=:974
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 1 Dec 2025, guanghuifeng@linux.alibaba.com wrote:
> =E5=9C=A8 2025/12/1 17:21, Ilpo J=C3=A4rvinen =E5=86=99=E9=81=93:
> > On Sun, 30 Nov 2025, Guanghui Feng wrote:
> >=20
> > > When executing a PCIe secondary bus reset, all downstream switches an=
d
> > > endpoints will generate reset events. Simultaneously, all PCIe links
> > > will undergo retraining, and each link will independently re-execute =
the
> > > LTSSM state machine training. Therefore, after executing the SBR, it =
is
> > > necessary to wait for all downstream links and devices to complete
> > > recovery. Otherwise, after the SBR returns, accessing devices with so=
me
> > > links or endpoints not yet fully recovered may result in driver error=
s,
> > > or even trigger device offline issues.
> > >=20
> > > Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> > > Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
> > > ---
> > Hi,
> >=20
> > In future, when posting an update, please always explain here
> > below the --- line what was changed between the versions.
> OK
> > >   drivers/pci/pci.c | 138 ++++++++++++++++++++++++++++++++-----------=
---
> > >   1 file changed, 97 insertions(+), 41 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index b14dd064006c..76afecb11164 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -4788,6 +4788,63 @@ static int pci_bus_max_d3cold_delay(const stru=
ct
> > > pci_bus *bus)
> > >   =09return max(min_delay, max_delay);
> > >   }
> > >   +static int pci_readiness_check(struct pci_dev *pdev, struct pci_de=
v
> > > *child,
> > > +=09=09unsigned long start_t, char *reset_type)
> > > +{
> > > +=09int elapsed =3D jiffies_to_msecs(jiffies - start_t);
> > > +
> > > +=09if (pci_dev_is_disconnected(pdev) || pci_dev_is_disconnected(chil=
d))
> > > +=09=09return 0;
> > > +
> > > +=09if (pcie_get_speed_cap(pdev) <=3D PCIE_SPEED_5_0GT) {
> > > +=09=09u16 status;
> > > +
> > > +=09=09pci_dbg(pdev, "waiting %d ms for downstream link\n", elapsed);
> > > +
> > > +=09=09if (!pci_dev_wait(child, reset_type, 0))
> > > +=09=09=09return 0;
> > > +
> > > +=09=09if (PCI_RESET_WAIT > elapsed)
> > > +=09=09=09return PCI_RESET_WAIT - elapsed;
> > > +
> > > +=09=09/*
> > > +=09=09 * If the port supports active link reporting we now check
> > > +=09=09 * whether the link is active and if not bail out early with
> > > +=09=09 * the assumption that the device is not present anymore.
> > > +=09=09 */
> > > +=09=09if (!pdev->link_active_reporting)
> > > +=09=09=09return -ENOTTY;
> > > +
> > > +=09=09pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &status);
> > > +=09=09if (!(status & PCI_EXP_LNKSTA_DLLLA))
> > > +=09=09=09return -ENOTTY;
> > > +
> > > +=09=09if (!pci_dev_wait(child, reset_type, 0))
> > > +=09=09=09return 0;
> > > +
> > > +=09=09if (PCIE_RESET_READY_POLL_MS > elapsed)
> > > +=09=09=09return PCIE_RESET_READY_POLL_MS - elapsed;
> > > +
> > > +=09=09return -ENOTTY;
> > > +=09}
> > > +
> > > +=09pci_dbg(pdev, "waiting %d ms for downstream link, after activatio=
n\n",
> > > +=09=09elapsed);
> > > +=09if (!pcie_wait_for_link_delay(pdev, true, 0)) {
> > > +=09=09/* Did not train, no need to wait any further */
> > > +=09=09pci_info(pdev, "Data Link Layer Link Active not set in %d
> > > msec\n", elapsed);
> > > +=09=09return -ENOTTY;
> > > +=09}
> > > +
> > > +=09if (!pci_dev_wait(child, reset_type, 0))
> > > +=09=09return 0;
> > > +
> > > +=09if (PCIE_RESET_READY_POLL_MS > elapsed)
> > > +=09=09return PCIE_RESET_READY_POLL_MS - elapsed;
> > > +
> > > +=09return -ENOTTY;
> > > +}
> > > +
> > >   /**
> > >    * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be
> > > accessible
> > >    * @dev: PCI bridge
> > > @@ -4802,12 +4859,14 @@ static int pci_bus_max_d3cold_delay(const str=
uct
> > > pci_bus *bus)
> > >    * 4.3.2.
> > >    *
> > >    * Return 0 on success or -ENOTTY if the first device on the second=
ary
> > > bus
> > > - * failed to become accessible.
> > > + * failed to become accessible or a value greater than 0 indicates t=
he
> > > + * left required waiting time..
> > >    */
> > > -int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char
> > > *reset_type)
> > > +static int __pci_bridge_wait_for_secondary_bus(struct pci_dev *dev,
> > > unsigned long start_t,
> > > +=09=09char *reset_type)
> > >   {
> > > -=09struct pci_dev *child __free(pci_dev_put) =3D NULL;
> > > -=09int delay;
> > > +=09struct pci_dev *child;
> > > +=09int delay, ret, elapsed =3D jiffies_to_msecs(jiffies - start_t);
> > >     =09if (pci_dev_is_disconnected(dev))
> > >   =09=09return 0;
> > > @@ -4835,8 +4894,6 @@ int pci_bridge_wait_for_secondary_bus(struct pc=
i_dev
> > > *dev, char *reset_type)
> > >   =09=09return 0;
> > >   =09}
> > >   -=09child =3D pci_dev_get(list_first_entry(&dev->subordinate->devic=
es,
> > > -=09=09=09=09=09     struct pci_dev, bus_list));
> > >   =09up_read(&pci_bus_sem);
> > >     =09/*
> > > @@ -4844,8 +4901,10 @@ int pci_bridge_wait_for_secondary_bus(struct
> > > pci_dev *dev, char *reset_type)
> > >   =09 * accessing the device after reset (that is 1000 ms + 100 ms).
> > >   =09 */
> > >   =09if (!pci_is_pcie(dev)) {
> > > -=09=09pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 +
> > > delay);
> > > -=09=09msleep(1000 + delay);
> > > +=09=09if (1000 + delay > elapsed)
> > > +=09=09=09return 1000 + delay - elapsed;
> > > +
> > > +=09=09pci_dbg(dev, "waiting %d ms for secondary bus\n", elapsed);
> > >   =09=09return 0;
> > >   =09}
> > >   @@ -4867,41 +4926,40 @@ int pci_bridge_wait_for_secondary_bus(struc=
t
> > > pci_dev *dev, char *reset_type)
> > >   =09if (!pcie_downstream_port(dev))
> > >   =09=09return 0;
> > >   -=09if (pcie_get_speed_cap(dev) <=3D PCIE_SPEED_5_0GT) {
> > > -=09=09u16 status;
> > > -
> > > -=09=09pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
> > > -=09=09msleep(delay);
> > > -
> > > -=09=09if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
> > > -=09=09=09return 0;
> > > +=09if (delay > elapsed)
> > > +=09=09return delay - elapsed;
> > >   +=09down_read(&pci_bus_sem);
> > > +=09list_for_each_entry(child, &dev->subordinate->devices, bus_list) =
{
> > >   =09=09/*
> > > -=09=09 * If the port supports active link reporting we now check
> > > -=09=09 * whether the link is active and if not bail out early with
> > > -=09=09 * the assumption that the device is not present anymore.
> > > +=09=09 * Check if all devices under the same bus have completed
> > > +=09=09 * the reset process, including multifunction devices in
> > > +=09=09 * the same bus.
> > >   =09=09 */
> > > -=09=09if (!dev->link_active_reporting)
> > > -=09=09=09return -ENOTTY;
> > > +=09=09ret =3D pci_readiness_check(dev, child, start_t, reset_type);
> > >   -=09=09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> > > -=09=09if (!(status & PCI_EXP_LNKSTA_DLLLA))
> > > -=09=09=09return -ENOTTY;
> > > +=09=09if (ret =3D=3D 0 && child->subordinate)
> > > +=09=09=09ret =3D __pci_bridge_wait_for_secondary_bus(child,
> > > start_t, reset_type);
> > >   -=09=09return pci_dev_wait(child, reset_type,
> > > -=09=09=09=09    PCIE_RESET_READY_POLL_MS -
> > > PCI_RESET_WAIT);
> > > +=09=09if(ret)
> > > +=09=09=09break;
> > >   =09}
> > > +=09up_read(&pci_bus_sem);
> > >   -=09pci_dbg(dev, "waiting %d ms for downstream link, after activati=
on\n",
> > > -=09=09delay);
> > > -=09if (!pcie_wait_for_link_delay(dev, true, delay)) {
> > > -=09=09/* Did not train, no need to wait any further */
> > > -=09=09pci_info(dev, "Data Link Layer Link Active not set in %d
> > > msec\n", delay);
> > > -=09=09return -ENOTTY;
> > > -=09}
> > > +=09return ret;
> > > +}
> > >   -=09return pci_dev_wait(child, reset_type,
> > > -=09=09=09    PCIE_RESET_READY_POLL_MS - delay);
> > > +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char
> > > *reset_type)
> > > +{
> > > +=09int res =3D 0;
> > > +=09unsigned long start_t =3D jiffies;
> > > +
> > > +=09do {
> > > +=09=09msleep(res);
> > > +=09=09res =3D __pci_bridge_wait_for_secondary_bus(dev, start_t,
> > > reset_type);
> > > +=09} while (res > 0);
> > > +
> > > +=09return res;
> > >   }
> > >     void pci_reset_secondary_bus(struct pci_dev *dev)
> > > @@ -5542,10 +5600,8 @@ static void pci_bus_restore_locked(struct pci_=
bus
> > > *bus)
> > >     =09list_for_each_entry(dev, &bus->devices, bus_list) {
> > >   =09=09pci_dev_restore(dev);
> > > -=09=09if (dev->subordinate) {
> > > -=09=09=09pci_bridge_wait_for_secondary_bus(dev, "bus reset");
> > > +=09=09if (dev->subordinate)
> > >   =09=09=09pci_bus_restore_locked(dev->subordinate);
> > > -=09=09}
> > >   =09}
> > >   }
> > ???
> >=20
> > Unfortunately, this takes a wrong turn and is very much against the
> > feedback I gave to you.
>=20
> 1. The implementation of
> pci_bridge_secondary_bus_reset/pci_bridge_wait_for_secondary_bus
>=20
> =C2=A0 =C2=A0has been modified to wait for all downstream switches/link/d=
evices to
> complete their recovery
>=20
> =C2=A0 =C2=A0before returning.
>=20
> 2. Therefore, when pci_bus_restore_locked is called via __pci_reset_bus, =
the
> waiting process has
>=20
> =C2=A0 =C2=A0already been completed via
> pci_bridge_secondary_bus_reset/pci_bridge_wait_for_secondary_bus,
>=20
> =C2=A0 =C2=A0so pci_bus_restore_locked does not require additional waitin=
g.

But you must also restore the bridge's config space before waiting for=20
devices in its subordinate bus, which is done wrong in this patch as it=20
moves recursion out from the correct place into=20
pci_bridge_wait_for_secondary_bus() that does not do any restoring of the=
=20
config space as it recurses downwards (and it's not correct to add=20
restore there either, I don't think this part of the change is fixing=20
any real issue but instead adding an old issue back which has been fixed=20
as I explained in my comments to v1).

It's not enough that you get it working in your case (which might be=20
able to cope without restoring config space prior to wait for the=20
devices).

> > >   @@ -5575,14 +5631,14 @@ static void pci_slot_restore_locked(struct
> > > pci_slot *slot)
> > >   {
> > >   =09struct pci_dev *dev;
> > >   +=09pci_bridge_wait_for_secondary_bus(slot->bus->self, "slot reset"=
);
> > > +
> > >   =09list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> > >   =09=09if (!dev->slot || dev->slot !=3D slot)
> > >   =09=09=09continue;
> > >   =09=09pci_dev_restore(dev);
> > > -=09=09if (dev->subordinate) {
> > > -=09=09=09pci_bridge_wait_for_secondary_bus(dev, "slot reset");
> > > +=09=09if (dev->subordinate)
> > >   =09=09=09pci_bus_restore_locked(dev->subordinate);
> > > -=09=09}
>=20
> 1. When pci_slot_restore_locked is called for a PCIe slot reset,
> pci_bridge_wait_for_secondary_bus
>=20
> =C2=A0 =C2=A0has already been executed to wait for all switches, links, a=
nd devices to
> complete their recovery firstly

You need to handle nested topologies right, config space restore and wait=
=20
on every level have to be in the correct order. It's NOT CORRECT to wait=20
first for the entire hierarchy and only after that restore the config=20
spaces.


--=20
 i.

--8323328-1815540855-1764594481=:974--

