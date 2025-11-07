Return-Path: <linux-pci+bounces-40588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3314C40D57
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 17:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 018594EA8AA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 16:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674582405F8;
	Fri,  7 Nov 2025 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8qK/Okn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F090247287;
	Fri,  7 Nov 2025 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532153; cv=none; b=DseMYvJJVK4+56MjPE7gPdzOKw/Mb6PPb+OajA1KauP3ZkSi5XkcV9zTkaif+qSFIpXicMkJ53Aimn23eQjGnVyikNkla4zqvH6e8x5mcKpoAV8U3LvWQcl8aT4c9kzYEoqIIiIw/YjQn8SadPXkaoHu1AXXy57uJnnueaMwc1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532153; c=relaxed/simple;
	bh=FH0JNPE2M5JSheYCq6QpYcQfhXLdpicZpzRC33BxUSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LFNhSshBXTzJTNsGxvP4FPCFOu4pgoEWMpeSUkfCURm4vb1FatCQRjY0FeQq5ktvDosxJ0EcOGxNSB9YfXBBrtzzVmaOcCQpZgELr5PWxf59QEX++EJiAfe1sZ08KYmfjwPGIcwSN4wGVuHnZp6ZZKYgXTOG3GBBEHwoSSQ00yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8qK/Okn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762532151; x=1794068151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FH0JNPE2M5JSheYCq6QpYcQfhXLdpicZpzRC33BxUSI=;
  b=U8qK/Oknnk5o/L4Ev1atp65vTO8UArtxk7dbEhSnRGf0IzWiYbqVCd4g
   Rk08Q/wjlW5tvkWVF/yv18UDnMOvbI5dLMdUWRWTdIRouJ2eUKiT9qJL+
   2J8S66FVM00uQEWn0TqMKsjR/1/d2yljR+oAm1Bwfv7YHGbOZ5X9uibjL
   wa6qcaXX1WF663GM1zf5UMMq9p93TfOgg5QRc/lp5wNHnIMFbzCqKoX20
   DNfmRxvAx5ZE3xD9rAZZU3u+Q80WLpP+99hZHdHll4+s6/68MXeli7EuG
   HTVPt7PYbpo2GtMVMaI4s3sX/qtzMFW9XnHQBhTYWTMDIMSbgpSMd8orH
   w==;
X-CSE-ConnectionGUID: tRhPetlJQYie1Wac4myxBg==
X-CSE-MsgGUID: sjTkV058RNeGXJegB06vow==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="52249120"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="52249120"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:15:50 -0800
X-CSE-ConnectionGUID: f7sU9PdEQq6ucVZByXGRAA==
X-CSE-MsgGUID: K4n+yYAMQsCZj1S5V4KpjQ==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:15:47 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Steve Oswald <stevepeter.oswald@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Prevent shrinking bridge window from its required size
Date: Fri,  7 Nov 2025 18:15:36 +0200
Message-Id: <20251107161537.8232-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

pbus_size_mem() calls calculate_memsize() twice. First with add_size=0
to find out the minimal required resource size. The second call occurs
with add_size=hpmemsize (effectively) but the result does not directly
affect the resource size only resulting in an entry on the realloc_head
list (a.k.a. add_list). Yet, adjust_bridge_window() directly changes
the resource size which does not include what is reserved due to
hpmemsize. Also, if the required size for the bridge window exceeds
hpmemsize, the parameter does not have any effect even on the second
size calculcation made by pbus_size_mem(); from calculate_memsize():

  size = max(size, add_size) + children_add_size;

The commit ae4611f1d7e9 ("PCI: Set resource size directly in
adjust_bridge_window()") that precedes the commit 948675736a77 ("PCI:
Allow adjust_bridge_window() to shrink resource if necessary") is also
related to causing this problem. Its changelog explicitly states
adjust_bridge_window() wants to "guarantee" allocation success.
Guaranteed allocations, however, are incompatible with how the other
parts of the resource fitting algorithm work. The given justification
fails to explain why guaranteed allocations at this stage are required
nor why forcing window to a smaller value than what was calculated by
pbus_size_mem() is correct. While the change might have worked by chance
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
pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
pci 0000:03:00.0: PCI bridge to [bus 00]
pci 0000:03:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0000:03:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:03:00.0: PCI bridge to [bus 04-2c]
pcieport 0000:00:07.0: Assigned bridge window [mem 0x6000000000-0x601bffffff 64bit pref] to [bus 03-2c] cannot fit 0xc00000000 required for 0000:03:00.0 bridging to [bus 04-2c]
pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit pref] to [bus 04-2c] add_size 100000 add_align 100000
pcieport 0000:00:07.0: distributing available resources
pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit pref] shrunken by 0x00000007e4400000
pci 0000:03:00.0: bridge window [mem 0x6000000000-0x601bffffff 64bit pref]: assigned

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
size in adjust_bridge_window() as hpmemsize had nothing to do with it.
When considering add_size, only reduce it up to what is added due to
hpmemsize (if required size is larger than hpmemsize, the parameter has
no impact, see calculate_memsize()). Unfortunately, if the tail of the
bridge window was aligned in calculate_memsize() from below hpmemsize
to above it, the size check will falsely match but the check at least
errs to the side of caution. There's not enough information available
in adjust_bridge_window() to know the calculated size precisely.

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

Fixes: 948675736a77 ("PCI: Allow adjust_bridge_window() to shrink resource if necessary")
Fixes: ae4611f1d7e9 ("PCI: Set resource size directly in adjust_bridge_window()")
Reported-by: Steve Oswald <stevepeter.oswald@gmail.com>
Closes: https://lore.kernel.org/linux-pci/CAN95MYEaO8QYYL=5cN19nv_qDGuuP5QOD17pD_ed6a7UqFVZ-g@mail.gmail.com/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Bjorn,

While this fixes a real issue, the change feels quite complex despite not
looking very complex on surface. As such, there could be unforeseen
side-effects so I'd prefer this be routed through next.

 drivers/pci/setup-bus.c | 42 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4a8735b275e4..5e3510ef7b9b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2005,6 +2005,7 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 resource_size_t new_size)
 {
 	resource_size_t add_size, size = resource_size(res);
+	struct pci_dev_resource *dev_res;
 
 	if (res->parent)
 		return;
@@ -2017,9 +2018,46 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
 			&add_size);
 	} else if (new_size < size) {
+		int idx = pci_resource_num(bridge, res);
+
+		/*
+		 * hpio/mmio/mmioprefsize hasn't been included at all? See the
+		 * add_size param at the callsites of calculate_memsize().
+		 */
+		if (!add_list)
+			return;
+
+		/* Only shrink if the hotplug extra relates to window size. */
+		switch (idx) {
+			case PCI_BRIDGE_IO_WINDOW:
+				if (size > pci_hotplug_io_size)
+					return;
+				break;
+			case PCI_BRIDGE_MEM_WINDOW:
+				if (size > pci_hotplug_mmio_size)
+					return;
+				break;
+			case PCI_BRIDGE_PREF_MEM_WINDOW:
+				if (size > pci_hotplug_mmio_pref_size)
+					return;
+				break;
+			default:
+				break;
+		}
+
+		dev_res = res_to_dev_res(add_list, res);
 		add_size = size - new_size;
-		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
-			&add_size);
+		if (add_size < dev_res->add_size) {
+			dev_res->add_size -= add_size;
+			pci_dbg(bridge, "bridge window %pR optional size shrunken by %pa\n",
+				res, &add_size);
+		} else {
+			pci_dbg(bridge, "bridge window %pR optional size removed\n",
+				res);
+			remove_from_list(add_list, res);
+		}
+		return;
+
 	} else {
 		return;
 	}

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.39.5


