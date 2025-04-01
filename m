Return-Path: <linux-pci+bounces-25065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1325AA77A60
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 14:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3A81889AC9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 12:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24598200BB2;
	Tue,  1 Apr 2025 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UF3PQ1Ho"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67674690;
	Tue,  1 Apr 2025 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509282; cv=none; b=LesmeKy6b8dN7scVxY26g4mrlAI39Z0qk6VtoOb7Xase4sNRjDUkN0INl2LeZAh1LsXCPyt1v7eX3q4jGj0bVU7Pag64i1VID0Qm6I+F01f7//SPQAQqJPbLfNmveAFXRVgbOpYJbR0jSOVM5+BWKWZ8Xgp/q3Ljd3J4bUEDU/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509282; c=relaxed/simple;
	bh=+5YFJ6ozLtaX4sL8WFwiw17P2YdLyxd+AfUnZAFkxOo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CCt9vnC2lV/LcN0cyuZx2sQhetc1X81JutVScqyKO5dBqclkzOeppIE66MjUR4IuJVPUa6We+Pj/UUEfaLNL2gKQR2S8FwsgkpboYOC6TyRZQ0mK4UEwqTqxMV+U3owFEQO2kmgk0WKTcONm2ZMCRSGfdjhBF0vnj+feg+qatUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UF3PQ1Ho; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743509281; x=1775045281;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+5YFJ6ozLtaX4sL8WFwiw17P2YdLyxd+AfUnZAFkxOo=;
  b=UF3PQ1HoYblS30j3t1rV6mp4S2yq1/WFG25gg5QqEGnw0QFIIWbWZfNh
   hTK9RaqPSCtg4USm3bFY7bS9Tc5/qFXBPlb6J7+g7N7fJ4Fex9A57F++B
   f375vNPUS5VBDDPAIDrSdXU0sIHJBNF+rfZRV/hTeQ9lAqVVtiZ0mldms
   L3j0B4xDqXbpzXfOgJr9KvOIpO47PhObtQlM5f5qSnag7f0gfLtKHK+wP
   uvy2uthvYmnQe63lKeusJ7TeP41zW6s4Alm0O9krRcM8Z3mq/xsJOiBz4
   uFURvMiTDwnlY9pZGG8mAGF6LsR+U7EetMZFHW/Sr8RSA9K1t6ilPMDOX
   w==;
X-CSE-ConnectionGUID: vQKP4NDIROyTxKl9JPX9jg==
X-CSE-MsgGUID: 1eyzDL9WReGlmJIGC2GXpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="48496307"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="48496307"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 05:08:00 -0700
X-CSE-ConnectionGUID: xT36gufiS5mQUQpHV1tDeQ==
X-CSE-MsgGUID: OQcjNsGfT7aIgosEWZYItg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="130502310"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.126])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 05:07:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 1 Apr 2025 15:07:52 +0300 (EEST)
To: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <75f74b48-edd8-7d1c-d303-1222d12e3812@linux.intel.com>
Message-ID: <6612c4d2-2533-98ef-7c89-f61d80c3e3e2@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <01eb7d40-f5b5-4ec5-b390-a5c042c30aff@roeck-us.net> <75f74b48-edd8-7d1c-d303-1222d12e3812@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-993356703-1743509272=:932"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-993356703-1743509272=:932
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 1 Apr 2025, Ilpo J=E4rvinen wrote:

> On Mon, 31 Mar 2025, Guenter Roeck wrote:
> > On Mon, Dec 16, 2024 at 07:56:31PM +0200, Ilpo J=E4rvinen wrote:
> > > Resetting resource is problematic as it prevent attempting to allocat=
e
> > > the resource later, unless something in between restores the resource=
=2E
> > > Similarly, if fail_head does not contain all resources that were rese=
t,
> > > those resource cannot be restored later.
> > >=20
> > > The entire reset/restore cycle adds complexity and leaving resources
> > > into reseted state causes issues to other code such as for checks don=
e
> > > in pci_enable_resources(). Take a small step towards not resetting
> > > resources by delaying reset until the end of resource assignment and
> > > build failure list (fail_head) in sync with the reset to avoid leavin=
g
> > > behind resources that cannot be restored (for the case where the call=
er
> > > provides fail_head in the first place to allow restore somewhere in t=
he
> > > callchain, as is not all callers pass non-NULL fail_head).
> > >=20
> > > The Expansion ROM check is temporarily left in place while building t=
he
> > > failure list until the upcoming change which reworks optional resourc=
e
> > > handling.
> > >=20
> > > Ideally, whole resource reset could be removed but doing that in a bi=
g
> > > step would make the impact non-tractable due to complexity of all
> > > related code.
> > >=20
> > > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> >=20
> > With this patch in the mainline kernel, all mips:boston qemu emulations
> > fail when running a 64-bit little endian configuration (64r6el_defconfi=
g).
> >=20
> > The problem is that the PCI based IDE/ATA controller is not initialized=
=2E
> > There are a number of pci error messages.
> >=20
> > pci_bus 0002:01: extended config space not accessible
> > pci 0002:01:00.0: [8086:2922] type 00 class 0x010601 conventional PCI e=
ndpoint
> > pci 0002:01:00.0: BAR 4 [io  0x0000-0x001f]
> > pci 0002:01:00.0: BAR 5 [mem 0x00000000-0x00000fff]
> > pci 0002:00:00.0: PCI bridge to [bus 01-ff]
> > pci_bus 0002:01: busn_res: [bus 01-ff] end is updated to 01
> > pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff]: assigned
> > pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: can't=
 assign; no space
> > pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: faile=
d to assign
> > pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no spa=
ce
> > pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
> > pci 0002:00:00.0: bridge window [mem size 0x00100000]: can't assign; bo=
gus alignment
> > pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff 64bit pref]:=
 assigned
> > pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no spa=
ce
> > pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
> > pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: can't assign; no space
> > pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: failed to assign
> > pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
> > pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
> > pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: can't assign; no space
> > pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: failed to assign
> > pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
> > pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
> > pci 0002:00:00.0: PCI bridge to [bus 01]
> > pci 0002:00:00.0:   bridge window [mem 0x16000000-0x160fffff 64bit pref=
]
> > pci_bus 0002:00: Some PCI device resources are unassigned, try booting =
with pci=3Drealloc
> > pci_bus 0002:00: resource 4 [mem 0x16000000-0x160fffff]
> > pci_bus 0002:01: resource 2 [mem 0x16000000-0x160fffff 64bit pref]
> > ...
> > pci 0002:00:00.0: enabling device (0000 -> 0002)
> > ahci 0002:01:00.0: probe with driver ahci failed with error -12
> >=20
> > Bisect points to this patch. Reverting it together with "PCI: Rework
> > optional resource handling" fixes the problem. For comparison, after
> > reverting the offending patches, the log messages are as follows.
> >=20
> > pci_bus 0002:00: root bus resource [bus 00-ff]
> > pci_bus 0002:00: root bus resource [mem 0x16000000-0x160fffff]
> > pci 0002:00:00.0: [10ee:7021] type 01 class 0x060400 PCIe Root Complex =
Integrated Endpoint
> > pci 0002:00:00.0: PCI bridge to [bus 00]
> > pci 0002:00:00.0:   bridge window [io  0x0000-0x0fff]
> > pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> > pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref=
]
> > pci 0002:00:00.0: enabling Extended Tags
> > pci 0002:00:00.0: bridge configuration invalid ([bus 00-00]), reconfigu=
ring
> > pci_bus 0002:01: extended config space not accessible
> > pci 0002:01:00.0: [8086:2922] type 00 class 0x010601 conventional PCI e=
ndpoint
> > pci 0002:01:00.0: BAR 4 [io  0x0000-0x001f]
> > pci 0002:01:00.0: BAR 5 [mem 0x00000000-0x00000fff]
> > pci 0002:00:00.0: PCI bridge to [bus 01-ff]
> > pci_bus 0002:01: busn_res: [bus 01-ff] end is updated to 01
> > pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff]: assigned
> > pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: can't=
 assign; no space
> > pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: faile=
d to assign
> > pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no spa=
ce
> > pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
> > pci 0002:01:00.0: BAR 5 [mem 0x16000000-0x16000fff]: assigned
> > pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
> > pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
> > pci 0002:00:00.0: PCI bridge to [bus 01]
> > pci 0002:00:00.0:   bridge window [mem 0x16000000-0x160fffff]
> > pci_bus 0002:00: Some PCI device resources are unassigned, try booting =
with pci=3Drealloc
> > pci_bus 0002:00: resource 4 [mem 0x16000000-0x160fffff]
> > pci_bus 0002:01: resource 1 [mem 0x16000000-0x160fffff]
> > ...
> > pci 0002:00:00.0: enabling device (0000 -> 0002)
> > ahci 0002:01:00.0: enabling device (0000 -> 0002)
> > ahci 0002:01:00.0: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SAT=
A mode
> > ahci 0002:01:00.0: 6/6 ports implemented (port mask 0x3f)
> > ahci 0002:01:00.0: flags: 64bit ncq only
>=20
> Hi,
>=20
> Thanks for reporting. Please add this to the command line to get the=20
> resource releasing between the steps to show:
>=20
> dyndbg=3D"file drivers/pci/setup-bus.c +p"
>=20
> Also, the log snippet just shows it fails but it is impossible to know=20
> from it why the resource assigments do not fit so could you please provid=
e=20
> a complete dmesg logs. Also providing the contents of /proc/iomem from th=
e=20
> working case would save me quite a bit of decoding the iomem layout from=
=20
> the dmesgs.

Hi again,

If you could kindly include this patch into the test with pci_dbg()=20
enabled so the resource reset/restore is better tracked.


From=20e7cb98904ab2ee235bbc13b3e981332e944dd476 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.intel=
=2Ecom>
Date: Tue, 1 Apr 2025 15:05:13 +0300
Subject: [PATCH 1/1] PCI: Log reset and restore of resources
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

PCI resource fitting and assignment is complicated to track because it
performs many actions without any logging. One of these is resource
reset (zeroing the resource) and the restore during the multi-passed
resource fitting algorithm.

Resource reset does not play well with the other PCI code if the code
later wants to reattempt assignment of that resource, knowing that a
resource was left into the reset state without a pairing restore is
useful for understanding issues that show up as resource assignment
failures.

Add pci_dbg() to both reset and restore to be better able to track
what's going on within the resource fitting algorithm.

The resource fitting and assignment tracking should eventually be
convert to use trace events to cover all changes made into the
resources fully but that requires significant effort. In the meantime,
logging resource reset and restore with pci_dbg() seems low-hanging
fruit.

Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 54d6f4fa3ce1..e67af19cb876 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -130,10 +130,15 @@ static resource_size_t get_res_add_align(struct list_=
head *head,
 static void restore_dev_resource(struct pci_dev_resource *dev_res)
 {
 =09struct resource *res =3D dev_res->res;
+=09struct pci_dev *dev =3D dev_res->dev;
+=09int idx =3D pci_resource_num(dev, res);
+=09const char *res_name =3D pci_resource_name(dev, idx);
=20
 =09res->start =3D dev_res->start;
 =09res->end =3D dev_res->end;
 =09res->flags =3D dev_res->flags;
+
+=09pci_dbg(dev_res->dev, "%s %pR: resource restored\n", res_name, res);
 }
=20
 static bool pdev_resources_assignable(struct pci_dev *dev)
@@ -218,8 +223,15 @@ bool pci_resource_is_optional(const struct pci_dev *de=
v, int resno)
 =09return false;
 }
=20
-static inline void reset_resource(struct resource *res)
+static void reset_resource(struct pci_dev_resource *dev_res)
 {
+=09struct resource *res =3D dev_res->res;
+=09struct pci_dev *dev =3D dev_res->dev;
+=09int idx =3D pci_resource_num(dev, res);
+=09const char *res_name =3D pci_resource_name(dev, idx);
+
+=09pci_dbg(dev_res->dev, "%s %pR: resetting resource\n", res_name, res);
+
 =09res->start =3D 0;
 =09res->end =3D 0;
 =09res->flags =3D 0;
@@ -573,7 +585,7 @@ static void __assign_resources_sorted(struct list_head =
*head,
 =09=09=09=09    0 /* don't care */);
 =09=09}
=20
-=09=09reset_resource(res);
+=09=09reset_resource(dev_res);
 =09}
=20
 =09free_list(head);

base-commit: 7d06015d936c861160803e020f68f413b5c3cd9d
--=20
2.39.5

--8323328-993356703-1743509272=:932--

