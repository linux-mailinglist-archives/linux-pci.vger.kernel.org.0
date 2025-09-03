Return-Path: <linux-pci+bounces-35382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F065B4209C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 15:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6E91BC053B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD733054FC;
	Wed,  3 Sep 2025 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQtGg2T1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2DE3054CF
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904966; cv=none; b=et5vtY50hP/K7CJA8UVl26hegliOWqfbWqv6fcjR0EPnqmyIvI2VI8UPeucEbFpoPrYmX9RFO7VIxx/er30rFu0kzK4r+uIRXd6UWzDUPIJKghgNXhc55GaCoa2oxYc/qYFQQsdW8yOpFPs4SElH3EbI7WhB5jrOkyp6oFHCxvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904966; c=relaxed/simple;
	bh=xd6MiCJ68B4zqEmwPTOmUEZIXJ9xdZ5apDhRWg23PhA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sseDJhdXF6AAZpFnngMQn9v3OHl3m5ens58q6SLnBPyA7aquCkEeHwIyVYI4QxXlI5l9iOtagaqyluoJOgWrDBsJ43rqcuL47qNA8n5MKIKtEEGvZrGRzyWhqC9v2AwQJEyPXbU8376tNMk+ZcBdPtKVQ2xw6D1IC5/nq5QL9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQtGg2T1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756904964; x=1788440964;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=xd6MiCJ68B4zqEmwPTOmUEZIXJ9xdZ5apDhRWg23PhA=;
  b=cQtGg2T1ir4bTX/HNYQeZSrO73btkoK2nUzIgwjhhy5/t73nIYBBTciY
   jrQx1C/I2Jd+zxssdFaIvHux25W/2ItaLU99smH1EU4heTfWtpPHiVyTF
   CM2GmLy28sJgrehXTG0aDE6//RZ4wgUtTN4UZ+uBLl/Gf2b+WdQLQZl8r
   YaNLnZbRWtFX7wQCz+MSlAMzu+oP64fVz7GbWfD1xbz4tCZzXoYY22N6G
   JsxgjDVzcv/IqWjA3OKLOLKal1/aR1Ht1iUjzuPvGxPu8F+1TZfbz+6cW
   WXco/i5zzPjf4zK0O84VpgFb4/3JkYNpdGchhNY6R7q5AGjjM39kmKsO6
   g==;
X-CSE-ConnectionGUID: W4PnfJGJTS2fvq3LZIXASw==
X-CSE-MsgGUID: EbNR0ycBQL69RK7vhVE5oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59283881"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59283881"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 06:09:24 -0700
X-CSE-ConnectionGUID: 1O33xoN8TrqN2gPe2wKzlQ==
X-CSE-MsgGUID: cw+PAlRXSbuA8jQn7dsSLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="172036619"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.1])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 06:09:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 3 Sep 2025 16:09:18 +0300 (EEST)
To: Steve Oswald <stevepeter.oswald@gmail.com>
cc: linux-pci@vger.kernel.org
Subject: Re: [BUG] Thunderbolt eGPU PCI BARs incorrectly assigned, fails to
 assign memory
In-Reply-To: <CAN95MYHpdz0u6-J_=7_enxq-TMzRJJJntfjYxBRgrG8UYbhQ1A@mail.gmail.com>
Message-ID: <eb70b817-175c-7a34-d2bf-9472019afa47@linux.intel.com>
References: <CAN95MYEaO8QYYL=5cN19nv_qDGuuP5QOD17pD_ed6a7UqFVZ-g@mail.gmail.com> <9254be77-46ea-992f-a1bd-98bea3943520@linux.intel.com> <f743efbe-56b7-ad85-f278-743af9385f10@linux.intel.com> <82ac5594-61c0-fece-1d9c-7c10316df384@linux.intel.com>
 <CAN95MYHpdz0u6-J_=7_enxq-TMzRJJJntfjYxBRgrG8UYbhQ1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1486769113-1756904692=:932"
Content-ID: <fa41ef05-90f5-2b7b-65e4-927d400db112@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1486769113-1756904692=:932
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <cc4584ce-df7e-15ae-eeee-2edaec9081e7@linux.intel.com>

On Mon, 1 Sep 2025, Steve Oswald wrote:

> I've added the dmesg output fordyndbg=3D"file drivers/pci/*. I wasn't
> sure if I added it with the escaped quotes correctly.
> https://gist.github.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af/raw/9cf5=
fc3a8c4f13588a33d61865f804f85e50470a/dmesg_linux_6.11.0_dyndbg.log

Hi again,

I think the patch below should solve your issue. If you manage to get it=20
tested and are confident enough it fixed your issue, you may provide your=
=20
Tested-by tag so I can include it into the official submission of the fix.


From=201c8ef31c6ac6616869b447a473e879b233df62db Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.intel=
=2Ecom>
Date: Wed, 3 Sep 2025 15:53:48 +0300
Subject: [PATCH 1/1] PCI: Prevent shrinking bridge window from its required
 size
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

pci_bridge_distribute_available_resources() -> ... ->
adjust_bridge_window() is called in between __pci_bus_size_bridges()
and assigning the resources. Since the commit 948675736a77 ("PCI: Allow
adjust_bridge_window() to shrink resource if necessary")
adjust_bridge_window() can also shrink the bridge window to force it to
a smaller size. The shrunken size, however, conflicts what
__pci_bus_size_bridges() -> pbus_size_mem() calculated as the required
bridge window size. By shrinking the resource size,
adjust_bridge_window() prevents rest of the resource fitting algorithm
working as intended. Resource fitting logic is expecting assignment
failures when bridge windows need resizing, but there are cases where
failures are no longer happening after the commit 948675736a77 ("PCI:
Allow adjust_bridge_window() to shrink resource if necessary").

The commit 948675736a77 ("PCI: Allow adjust_bridge_window() to shrink
resource if necessary") justifies the change by the extra reservation
made due to hpmemsize parameter, however, the kernel code contradicts
with that statement. (For simplicity, finer-grained hpmmiosize and
hpmmiopref parameters that can be used to the same effect as hpmemsize
are ignored in this description.)

pbus_size_mem() calls calculate_memsize() twice. First with add_size=3D0
to find out the minimal required resource size. The second call occurs
with add_size=3Dhpmemsize (effectively) but the result does not directly
affect the resource size only resulting in an entry on the realloc_head
list (a.k.a. add_list). Yet, adjust_bridge_window() directly changes
the resource size which does not include what is reserved due to
hpmemsize. Also, if the required size for the bridge window exceeds
hpmemsize, the parameter does not have any effect even on the second
size calculcation made by pbus_size_mem(); from calculate_memsize():

  size =3D max(size, add_size) + children_add_size;

The commit ae4611f1d7e9 ("PCI: Set resource size directly in
adjust_bridge_window()") that precedes the commit 948675736a77 ("PCI:
Allow adjust_bridge_window() to shrink resource if necessary") is also
related to causing this problem. Its changelog explicitly states
adjust_bridge_window() wants to "guarantee" allocation success.
Guaranteed allocations, however, are incompatible with how the other
parts of the resource fitting algorithm work. The given justification
fails to explain why guaranteed allocations at this stage are required
nor why forcing window to a smaller value than what was calculated by
pbus_size_mem() is correct. The the change might have worked by chance
in some test scenario, too small bridge window does not "guarantee"
success from the point of view of the endpoint device resource
assignments. No issue is mentioned within the changelog so it's unclear
if the change was made to fix some observed issue nor and what that
issue was.

The unwanted shrinking of a bridge window occurs, e.g., when a device
with large BARs such as eGPU is attached using Thunderbolt and the Root
Port holds less than enough resource space for the eGPU. The GPU
resources are in order of GBs and the default hotplug allocation is
mere 2M (DEFAULT_HOTPLUG_MMIO_PREF_SIZE). The problem is illustrated by
this log (filtered to the relevant content only):

pci 0000:00:07.0: PCI bridge to [bus 03-2c]
pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref=
]
pci 0000:03:00.0: PCI bridge to [bus 00]
pci 0000:03:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0000:03:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:03:00.0: PCI bridge to [bus 04-2c]
pcieport 0000:00:07.0: Assigned bridge window [mem 0x6000000000-0x601bfffff=
f 64bit pref] to [bus 03-2c] cannot fit 0xc00000000 required for 0000:03:00=
=2E0 bridging to [bus 04-2c]
pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit pref] t=
o [bus 04-2c] add_size 100000 add_align 100000
pcieport 0000:00:07.0: distributing available resources
pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit pref] s=
hrunken by 0x00000007e4400000
pci 0000:03:00.0: bridge window [mem 0x6000000000-0x601bffffff 64bit pref]:=
 assigned

The initial size of the Root Port's window is 448MB (0x601bffffff -
0x6000000000). __pci_bus_size_bridges() -> pbus_size_mem() calculates
the required size to be 32772 MB (0x10003fffff - 0x800000000) which
would fit the eGPU resources. adjust_bridge_window() then shrinks the
bridge window down to what is guaranteed to fit into the Root Port's
bridge window. The bridge window for 03:00.0 is also eliminated from
the add_list (a.k.a. realloc_head) list by adjust_bridge_window().

After adjustment, the resources are assigned and as the bridge window
for 03:00.0 is assigned successfully, no failure is recorded. Without a
failure, no attempt to resize the window of the Root Port is required.
The end result is eGPU not having large enough resources to work.

The commit 948675736a77 ("PCI: Allow adjust_bridge_window() to shrink
resource if necessary") also claims nested bridge windows are sized the
same, which is false. pbus_size_mem() calculates the size for the
parent bridge window by summing all the downstream resources so the
resource fitting calculates larger bridge window for the parent to
accomodate the childen. That is, hpmemsize does not result the same
size for the case where there are nested bridge windows.

In order to fix the most immediate problem, don't shrink the resource
size as hpmemsize had nothing to do with it. When considering add_size,
only reduce it up to what is added due to hpmemsize (if required size
is larger than hpmemsize, the parameter has no impact, see
calculate_memsize()).

This is not exactly a revert of the commits e4611f1d7e9 ("PCI: Set
resource size directly in adjust_bridge_window()") and 948675736a77
("PCI: Allow adjust_bridge_window() to shrink resource if necessary")
as shrinking still remains in place but is implemented differently,
and the end result behaves very differently.

It is possible that those two commits fixed some other issue that is
not described with enough detail in the changelog and undoing parts of
them results in another regression due to behavioral change.
Nonetheless, as described above, the solution by those two commits was
flawed and the issue, if one exists, should be solved in a way that is
compatible with the rest of the resource fitting algorithm instead of
working against it.

Besides shrinking, the case where adjust_bridge_window() expands the
bridge window is likely somewhat wrong as well because it removes the
entry from add_list (a.k.a. realloc_head), but it is less damaging as
that only impacts optional resources and may have no impact if
expanding by hpmemsize is larger than what add_size was. Fixing it is
left as further work.

Reported-by: Steve Oswald <stevepeter.oswald@gmail.com>
Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 42 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 23082bc0ca37..4dd618bc4196 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1828,6 +1828,7 @@ static void adjust_bridge_window(struct pci_dev *brid=
ge, struct resource *res,
 =09=09=09=09 resource_size_t new_size)
 {
 =09resource_size_t add_size, size =3D resource_size(res);
+=09struct pci_dev_resource *dev_res;
=20
 =09if (res->parent)
 =09=09return;
@@ -1840,9 +1841,46 @@ static void adjust_bridge_window(struct pci_dev *bri=
dge, struct resource *res,
 =09=09pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
 =09=09=09&add_size);
 =09} else if (new_size < size) {
+=09=09int idx =3D pci_resource_num(bridge, res);
+
+=09=09/*
+=09=09 * hpio/mmio/mmioprefsize hasn't been included at all? See the
+=09=09 * add_size param at the callsites of calculate_memsize().
+=09=09 */
+=09=09if (!add_list)
+=09=09=09return;
+
+=09=09/* Only shrink if the hotplug extra relates to window size. */
+=09=09switch (idx) {
+=09=09=09case PCI_BRIDGE_IO_WINDOW:
+=09=09=09=09if (size > pci_hotplug_io_size)
+=09=09=09=09=09return;
+=09=09=09=09break;
+=09=09=09case PCI_BRIDGE_MEM_WINDOW:
+=09=09=09=09if (size > pci_hotplug_mmio_size)
+=09=09=09=09=09return;
+=09=09=09=09break;
+=09=09=09case PCI_BRIDGE_PREF_MEM_WINDOW:
+=09=09=09=09if (size > pci_hotplug_mmio_pref_size)
+=09=09=09=09=09return;
+=09=09=09=09break;
+=09=09=09default:
+=09=09=09=09break;
+=09=09}
+
+=09=09dev_res =3D res_to_dev_res(add_list, res);
 =09=09add_size =3D size - new_size;
-=09=09pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
-=09=09=09&add_size);
+=09=09if (add_size < dev_res->add_size) {
+=09=09=09dev_res->add_size -=3D add_size;
+=09=09=09pci_dbg(bridge, "bridge window %pR optional size shrunken by %pa\=
n",
+=09=09=09=09res, &add_size);
+=09=09} else {
+=09=09=09pci_dbg(bridge, "bridge window %pR optional size removed\n",
+=09=09=09=09res);
+=09=09=09remove_from_list(add_list, res);
+=09=09}
+=09=09return;
+
 =09} else {
 =09=09return;
 =09}

base-commit: f6d41443f54856ceece0d5b584f47f681513bde4
--=20
2.39.5
--8323328-1486769113-1756904692=:932--

