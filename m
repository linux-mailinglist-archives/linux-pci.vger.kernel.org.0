Return-Path: <linux-pci+bounces-37821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C232EBCE070
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 19:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DC0B4E632F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ECE3FB31;
	Fri, 10 Oct 2025 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mvxu5Bix"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D813A86C;
	Fri, 10 Oct 2025 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115674; cv=none; b=GO+wgoHgFmtKdIlJA0urwqNBRuEOllVxG46isNyPwciVeDqq1PLbCyu/Ez84jnxZTc+lStG9AL2EjwD7VLLg4uW8UpENjB8C0eYlcnZ3nwgo7AqeEDRC4VoXuvDpEnDFJlTcbPjrYvfrePu1y3t9b5UOkihSmgIn1JINOc3DJ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115674; c=relaxed/simple;
	bh=p0iEOkvuuxMae+vrMRboSkPIcIQw3lKK5lp9vrvqJiI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l+FjVFgj9YYr7ych1WzJEmnmLN/bcyLJ8gFkybPmMmezJI2zMPSjlOm+TvPRQpV4MjNxqFmnl2XKllgvQ5y/YXMDVL+PoQuPD8XG84KGNMuJF9D7QMggu6Bc9lHKcnucQgp5TZeiS2BZLRFUUZAhvCXO7OZHj4StcbI6BjW866s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mvxu5Bix; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760115672; x=1791651672;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=p0iEOkvuuxMae+vrMRboSkPIcIQw3lKK5lp9vrvqJiI=;
  b=Mvxu5BixJ6W8tKaVIeBYOvo5C1oKHfrZ+HJF6Tx0E6QrOuMGMoQIEum9
   kCh+4AZKoLF+r0kSEgFU/JUPO9IklCOdsKLGhr+kzAohIgr+NrWCSLq2Y
   ufVPhYu8H724zVz1MHIg/TC3xzBA7XBIdkrvX5NorDTtluGomdyr5ToOj
   Nk33DCSk87qZZ1x4w0hWjyBJ7CWRHCcvfmeMj/6HT1IbrKIYsadMGWTO+
   AUQXm0Vh0z6PKkcCLFIow6KpzPrK9Nd6O2ypyxQirMK4gHHod4owA2SDn
   ppYRYmKHIM6j2BeN+Mp+kAydzRGWQ3oxwN9a/77nfr+EuVilP+UNi2BnH
   A==;
X-CSE-ConnectionGUID: DO20Ft51SbCZbJwNDmx2GA==
X-CSE-MsgGUID: nWp1taMXScmBa71z8+yKDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62238489"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="62238489"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 10:01:11 -0700
X-CSE-ConnectionGUID: kzVg1ydqTAyRkjoYYviO1A==
X-CSE-MsgGUID: zSLTmc3bTgaXUdVKAIns5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="185407866"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.127])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 10:01:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Oct 2025 20:01:05 +0300 (EEST)
To: Val Packett <val@packett.cool>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
In-Reply-To: <2faffdc3-f956-4071-a6a4-de9b5889096d@packett.cool>
Message-ID: <094618f2-947e-a66e-dc27-f4dedc8b5bb5@linux.intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com> <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com> <017ff8df-511c-4da8-b3cf-edf2cb7f1a67@packett.cool> <f5eb0360-55bd-723c-eca2-b0f7d8971848@linux.intel.com> <cd8a1d3c-1386-476b-a93d-1259b81c04e9@packett.cool>
 <8f9c9950-1612-6e2d-388a-ce69cf3aae1a@linux.intel.com> <2faffdc3-f956-4071-a6a4-de9b5889096d@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1725611810-1760022322=:944"
Content-ID: <81650c8e-e6e1-dd5d-7a5b-5a2fd38d371f@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1725611810-1760022322=:944
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <f9b2e3ba-11bd-7cd1-c963-e3b06f21ddf1@linux.intel.com>

On Thu, 9 Oct 2025, Val Packett wrote:

> On 10/7/25 12:43 PM, Ilpo J=C3=A4rvinen wrote:
>=20
> > On Mon, 6 Oct 2025, Val Packett wrote:
> > > [..]
> > >=20
> > > I think it's that early check in=C2=A0pci_read_bridge_bases=C2=A0that=
 avoids the
> > > setup
> > > here:
> > >=20
> > >  =C2=A0 =C2=A0 if (pci_is_root_bus(child)) /* It's a host bus, nothin=
g to read */
> > >  =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > If there's a PCI device as is the case in pci_read_bridge_windows()
> > which inputs non-NULL pci_dev, the config space of that device can be r=
ead
> > normally (or should be readable normally, AFAIK). The case where bus->s=
elf
> > is NULL is different, we can't read from a non-existing PCI device, but
> > it doesn't apply to pci_read_bridge_windows().
> >=20
> > I don't think reading the window is the real issue here but how the
> > resource fitting algorithm corners itself by reserving space for bridge
> > windows before it knows their sizes, so basically these lines from the
> > earlier email:
> >=20
> > pci 0004:00:00.0: bridge window [mem 0x7c300000-0x7c3fffff]: assigned
> > pci 0004:00:00.0: bridge window [mem 0x7c400000-0x7c4fffff 64bit pref]:
> > assigned
> > pci 0004:00:00.0: BAR 0 [mem 0x7c500000-0x7c500fff]: assigned
> >=20
> > ...which seem to occur before the child buses have been scanned so that
> > space reserved is either hotplug reservation or due to "old_size" lower
> > bounding. That non-prefetchable bridge window is too small to fit the
> > child resources.
> >=20
> > Could you try passing pci=3Dhpmemsize=3D0M to kernel command line if th=
at
> > helps?
> >=20
> > The other case is the "old_size" in calculate_memsize() which too can
> > cause the same effect preventing sizing bridge window truly to zero whe=
n
> > it's not needed (=3D=3D disable it =3D=3D not assign it at all at that =
point).
> > Forcing it to zero would perhaps be worth a test (or removing the max()
> > related to old_size)
> >=20
> > I've no idea why the old_size should decide anything, I hate that black
> > magic but I've just not dared to remove it (it's hard to know why some
> > things were made in the past, there could have been some HW issue worke=
d
> > around by such odd feature but it's so old code that there isn't any re=
al
> > information about whys anymore to find).
>
> Well, you did dare to mess with resource assignment sequence, and it got =
very
> quickly and quietly merged into linux-next causing a big regression on
> hardware that's not made by your company.. so maybe it's better not to to=
uch
> anything there at all (:

Even if you were very likely joking here, I'm still sorry for breaking it,=
=20
no matter which company's device.

Perhaps I'll start Cc you in all upcoming resource changes as you seem to=
=20
be so willing to volunteer to review them. ;-D

> > pci=3Drealloc on command line might help too, but I'm not sure. There s=
eems
> > to be some extra space within the root bus resource so it might work.
> >=20
> > I'm not sure what call chain is causing the assignment of those 3 bridg=
e
> > windows. One easy way to find out where it comes from would be to put
> > WARN_ON(res->start =3D=3D 0x7c400000); into pci_assign_resource() next =
to the
> > line which prints "...: assigned".
>=20
> OK, I've uploaded the full big chungus logs (all with the WARN_ON):
>=20
> https://owo.packett.cool/lin/pcifail.reverted.dmesg
> https://owo.packett.cool/lin/pcifail.noarg.dmesg
> https://owo.packett.cool/lin/pcifail.hpmeme.dmesg (hpmemsize didn't help)
> https://owo.packett.cool/lin/pcifail.realloc.dmesg (realloc didn't help
> either)

Thanks for the logs.

> So without your change, the assignment first comes from pci_rescan_bus =
=E2=86=92
> pci_assign_unassigned_bus_resources *via IRQ*, and then in the probe of t=
he
> wifi driver.

There seem to be cases where pci_assign_unassigned_root_bus_resources()=20
executes for bus 0000:04 before 0004:01:00.0 is scanned as it is only=20
recorded later.

Hmm, qcom_pcie_global_irq_thread() seems to indicate the real enumeration=
=20
can only occur after the link up event has arrived, and it starts another=
=20
scan from there.

Perhaps this could be solved by inhibiting resource sizing and assignment=
=20
per host bridge until the bus could be enumerated for real. Otherwise the=
=20
resource assignment has no idea how the bridge windows should be sized=20
which then can lead to this cornering itself if the initial assignment=20
without knowledge of the necessary sizes.

Could you please try if the patch below helps?


--
From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.intel=
=2Ecom>
Date: Fri, 10 Oct 2025 19:55:49 +0300
Subject: [PATCH 1/1] PCI: Delay resource sizing until devices can be enumer=
ated
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

It seems pci-qcom cannot yet enumerate devices while scanning bus from
pci_host_probe(). Instead, there is IRQ waiting for a link up event
which starts the scan from qcom_pcie_global_irq_thread().

pci_host_probe() also calls pci_assign_unassigned_root_bus_resources()
which tries to size the bridge windows without any knowledge about the
attached devices and assigns them. If the assigned window is too small
to accomodate all the devices resource once they appear, the windows
may have become so pinned in place that they cannot be successfully
resized.

It is not very useful to size bridge windows without the children.
Thus, mark into the struct pci_host_bridge that delayed enumeration is
performed. Inhibit resource assignment until the enumeration is known
to be possible.

FIXME: There could be other entrypoints to resource assignment code
beyond those that include check for ->enumeration_pending but these
were the ones seen in the logs.

Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c |  3 +++
 drivers/pci/setup-bus.c                | 10 ++++++++++
 include/linux/pci.h                    |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controlle=
r/dwc/pcie-qcom.c
index 294babe1816e..33683d751de0 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1644,6 +1644,7 @@ static irqreturn_t qcom_pcie_global_irq_thread(int ir=
q, void *data)
 =09=09msleep(PCIE_RESET_CONFIG_WAIT_MS);
 =09=09dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
 =09=09/* Rescan the bus to enumerate endpoint devices */
+=09=09pp->bridge->enumeration_pending =3D 0;
 =09=09pci_lock_rescan_remove();
 =09=09pci_rescan_bus(pp->bridge->bus);
 =09=09pci_unlock_rescan_remove();
@@ -1825,6 +1826,8 @@ static int qcom_pcie_probe(struct platform_device *pd=
ev)
 =09=09bridge->sysdata =3D cfg;
 =09=09bridge->ops =3D (struct pci_ops *)&pci_qcom_ecam_ops.pci_ops;
 =09=09bridge->msi_domain =3D true;
+=09=09// FIXME: Should this be specific to just some host bridges?
+=09=09bridge->enumeration_pending =3D 1;
=20
 =09=09ret =3D pci_host_probe(bridge);
 =09=09if (ret)
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7853ac6999e2..a54a4dda6b60 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2266,6 +2266,7 @@ static void pci_prepare_next_assign_round(struct list=
_head *fail_head,
  */
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 {
+=09struct pci_host_bridge *host =3D pci_find_host_bridge(bus);
 =09LIST_HEAD(realloc_head);
 =09/* List of resources that want additional resources */
 =09struct list_head *add_list =3D NULL;
@@ -2275,6 +2276,10 @@ void pci_assign_unassigned_root_bus_resources(struct=
 pci_bus *bus)
 =09int pci_try_num =3D 1;
 =09enum enable_type enable_local;
=20
+=09/* Wait until enumeration to avoid pinning windows with wrong sizes. */
+=09if (host->enumeration_pending)
+=09=09return;
+
 =09/* Don't realloc if asked to do so */
 =09enable_local =3D pci_realloc_detect(bus, pci_realloc_enable);
 =09if (pci_realloc_enabled(enable_local)) {
@@ -2489,10 +2494,15 @@ int pci_reassign_bridge_resources(struct pci_dev *b=
ridge, unsigned long type)
=20
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 {
+=09struct pci_host_bridge *host =3D pci_find_host_bridge(bus);
 =09struct pci_dev *dev;
 =09/* List of resources that want additional resources */
 =09LIST_HEAD(add_list);
=20
+=09/* Wait until enumeration to avoid pinning windows with wrong sizes. */
+=09if (host->enumeration_pending)
+=09=09return;
+
 =09down_read(&pci_bus_sem);
 =09for_each_pci_bridge(dev, bus)
 =09=09if (pci_has_subordinate(dev))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 59876de13860..10fb5aaecd8e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -619,6 +619,7 @@ struct pci_host_bridge {
 =09unsigned int=09preserve_config:1;=09/* Preserve FW resource setup */
 =09unsigned int=09size_windows:1;=09=09/* Enable root bus sizing */
 =09unsigned int=09msi_domain:1;=09=09/* Bridge wants MSI domain */
+=09unsigned int=09enumeration_pending:1;=09/* Delayed enumeration */
=20
 =09/* Resource alignment requirements */
 =09resource_size_t (*align_resource)(struct pci_dev *dev,

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
--=20
2.39.5

--8323328-1725611810-1760022322=:944--

