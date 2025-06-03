Return-Path: <linux-pci+bounces-28841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2961ACC1F7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 10:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBFF16E973
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B498280332;
	Tue,  3 Jun 2025 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUulry2R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422428031A;
	Tue,  3 Jun 2025 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938441; cv=none; b=rXzh7LrzGv1czZXgP0KNqBlM8GSrbhaZA33JjDoYGdjtQ9Nh+2uG/GB5+fG+NwrFQEAmg6DwKcLrLQFuCinUTW2LqCk8BmW3NaC7EPqiuahZYPbsJ+yIxgszMjpDjq3n3VcAi2NroAZ2jyoyN/wb+UpnffwPmUj9YcZCFAcn5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938441; c=relaxed/simple;
	bh=NTtThZn7RjKZf8qDSpO5QcKM7j+QaEyLuzwuWaEh37w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pMwLedryMK/DTixyidtKYyzG/ufESGEVkcHr1qkssg9pQePUhPGY/jV0lcf1bRLSmcUprgeUoC74nE0AEFYJ8TVR7iEF7TZZEzaemr49azXQt/d0Xi/7/3qDKIsf/IYp7u7r1IZaayL1TknjR8ti4Xje8aEb8loCpBOEzBSXrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUulry2R; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748938439; x=1780474439;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NTtThZn7RjKZf8qDSpO5QcKM7j+QaEyLuzwuWaEh37w=;
  b=hUulry2Re9dXvhA2wLdrnUVGQlB1hBh6d4XwDCev7HNghjTGK7PgHc+t
   kT7OxRwLlgspq+qQtSz6z9QleEY5/9fhne5NvTF4IATHsQpm9oAQdpzKj
   4Yl4s3v8VX1QnC277YvzHpY5IlYMywGimfn00gyEZXmZ8IVB3mJHeStqU
   Ha0Y5n5F1TgdMIgSlKnNR0LogzTQyybV8ht59vIEGvTygltoN2O5ekshh
   DnLwOi/RLEMbSydTHyok89V32Bz0ES1pqopIAtenJdSLuY3C1XFD/y5Mq
   pZR1KejDxwmfJpfLPnrL3wRHaLYPT3eabgOfN8IPU02TPOINLGIBEFi62
   w==;
X-CSE-ConnectionGUID: 1nMiApqnTsqhHq9oC+Yesw==
X-CSE-MsgGUID: +VYUNPILTB6t3lAFVvJ5Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50840053"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="50840053"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 01:13:58 -0700
X-CSE-ConnectionGUID: IX8GggZcRY6XkID3hQSOow==
X-CSE-MsgGUID: 2O95gdWaQ4mAbJj+R5VeAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="145764187"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 01:13:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 11:13:51 +0300 (EEST)
To: Tudor Ambarus <tudor.ambarus@linaro.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <f2d149c6-41a4-4a9a-9739-1ea1c4b06f4b@linaro.org>
Message-ID: <19ccc09c-1d6b-930e-6ed6-398b34020ca1@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org> <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com> <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <f6ee05f7-174b-76d4-3dbe-12473f676e4d@linux.intel.com> <867e47dc-9454-c00f-6d80-9718e5705480@linux.intel.com> <a56284a4-755d-4eb4-ba77-9ea30e18d08f@linaro.org> <7e882cfb-a35a-bab0-c333-76a4e79243b6@linux.intel.com>
 <f2d149c6-41a4-4a9a-9739-1ea1c4b06f4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2071521873-1748938431=:937"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2071521873-1748938431=:937
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 2 Jun 2025, Tudor Ambarus wrote:
> On 6/2/25 4:08 PM, Ilpo J=C3=A4rvinen wrote:
> >>> I think I figured out more about the reason. It's not related to that=
=20
> >>> bridge window resource.
> >>>
> >>> pbus_size_mem() will add also that ROM resource into realloc_head=20
> >>> as it is considered (intentionally) optional after the optional chang=
e
> >>> (as per "tudor: 2:" line). And that resource is never assigned becaus=
e=20
>=20
> cut
>=20
> >>> pdev_sort_resources() didn't pick it up into the head list. The next=
=20
> >>> question is why the ROM resource isn't in the head list.
> >>>
> >> It seems the ROM resource is skipped at:
> >> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-
> >> next.git/tree/drivers/pci/setup-bus.c#n175
> >>
> >> tudor: pdev_sort_resources: ROM [??? 0x00000000 flags 0x0] resource
> >> skipped due to !(r->flags) || r->parent
> > I don't see the device in this print, hope it is for the same device.
> >=20
> > In any case, I don't understand what reset resource's flags in between=
=20
> > pbus_size_mem() and pdev_sort_resources(), or alternative, why type=20
> > checking in pbus_size_mem() matches if flags =3D=3D 0 at that point.
> >=20
> > Those two functions should work on the same resources, if one skips=20
> > something, the other should too. Disparity between them can cause issue=
s,=20
> > but despite reading the code multiple times, I couldn't figure out how=
=20
> > that disparity occurs (except for the !pdev_resources_assignable() case=
).
>=20
> cut
>=20
> > It is of interest to know why the same resource is treated differently.
> > So what were the resource flags, type* args when it's processed by
> > pbus_size_mem()? If resource's flags are zero at that point but it matc=
hes=20
>=20
> This is the full output: https://termbin.com/mn1x
> for the following prints: https://termbin.com/q57h
>=20
> It seems ROM resource is of type 2 at pbus_size_mem() time.
>=20
> > one of the types, that would be a bug.
>=20
> I'll give another try tomorrow. Thanks,

Those are not the same device, so not the same resource either:

[   16.262745][ T1113] pci 0001:01:00.0: tudor: 2: pbus_size_mem: ROM [mem =
0x00000000-0x0000ffff pref] list empty? 0

[   16.267736][ T1113] pcieport 0001:00:00.0: tudor: pdev_sort_resources: R=
OM [??? 0x00000000 flags 0x0] resource skipped due to !(r->flags) || r->par=
ent

0001:01:00.0
vs
0001:00:00.0

And the resources for 0001:01:00.0 were never processed by=20
__pci_bus_assign_resources(). But __pci_bus_assign_resources() should=20
recurse to subordinate busses.

And, it seems this boils down to the inconsistency I noticed earlier:

[   16.253464][ T1113] pci 0001:01:00.0: [144d:a5a5] type 00 class 0x000000=
 PCIe Endpoint

include/linux/pci_ids.h:#define PCI_CLASS_NOT_DEFINED           0x0000

pdev_resources_assignable() checks if class =3D=3D PCI_CLASS_NOT_DEFINED an=
d=20
pdev_sort_resources() bails out without processing those resources.

So please test if this patch solves your problem:


From=2000e440f505a79568cf5203dce265488cb3f66941 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.intel=
=2Ecom>
Date: Tue, 3 Jun 2025 11:07:38 +0300
Subject: [PATCH 1/1] PCI: Fix pdev_resources_assignable() disparity
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

pdev_sort_resources() uses pdev_resources_assignable() helper to decide
if device's resources cannot be assigned. pbus_size_mem(), on the other
hand, does not do the same check. This could lead into a situation
where a resource ends up on realloc_head list but is not on the head
list, which is turn prevents emptying the resource from the
realloc_head list in __assign_resources_sorted().

A non-empty realloc_head is unacceptable because it triggers an
internal sanity check as show in this log with a device that has class
0 (PCI_CLASS_NOT_DEFINED):

pci 0001:01:00.0: [144d:a5a5] type 00 class 0x000000 PCIe Endpoint
pci 0001:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
pci 0001:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
pci 0001:01:00.0: enabling Extended Tags
pci 0001:01:00.0: PME# supported from D0 D3hot D3cold
pci 0001:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s=
 PCIe x2 link at 0001:00:00.0 (capable of 31.506 Gb/s with 16.0 GT/s PCIe x=
2 link)
pcieport 0001:00:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 01=
-ff] add_size 100000 add_align 100000
pcieport 0001:00:00.0: bridge window [mem 0x40000000-0x401fffff]: assigned
------------[ cut here ]------------
kernel BUG at drivers/pci/setup-bus.c:2532!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
=2E..
Call trace:
 pci_assign_unassigned_bus_resources+0x110/0x114 (P)
 pci_rescan_bus+0x28/0x48

Use pdev_resources_assignable() also within pbus_size_mem() to skip
processing of non-assignable resources which removes the disparity in
between what resources pdev_sort_resources() and pbus_size_mem()
consider. As non-assignable resources are no longer processed, they are
not added to the realloc_head list, thus the sanity check no longer
triggers.

This disparity problem is very old but only now became apparent after
the commit 2499f5348431 ("PCI: Rework optional resource handling") that
made the ROM resources optional when calculating bridge window sizes
which required adding the resource to the realloc_head list.
Previously, bridge windows were just sized larger than necessary.

Fixes: 2499f5348431 ("PCI: Rework optional resource handling")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 54d6f4fa3ce1..da084251df43 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1187,6 +1187,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigne=
d long mask,
 =09=09=09resource_size_t r_size;
=20
 =09=09=09if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
+=09=09=09    !pdev_resources_assignable(dev) ||
 =09=09=09    ((r->flags & mask) !=3D type &&
 =09=09=09     (r->flags & mask) !=3D type2 &&
 =09=09=09     (r->flags & mask) !=3D type3))

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
--=20
2.39.5


--8323328-2071521873-1748938431=:937--

