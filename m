Return-Path: <linux-pci+bounces-34557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5916B317EA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86BFD17FC65
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020242FB639;
	Fri, 22 Aug 2025 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4kr01dl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BDF2FAC05;
	Fri, 22 Aug 2025 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866085; cv=none; b=kDLvAAuOLyVc9HtcfBCgpEBdOo1K5i6povsEhBSisfbjjndsrdYngMH7lcQ/NS8GH/my9Ixx4pzEbX7ORtR7kLpyCYfAkAso2RpRWUVKjZjSO6tmxKYwegSJXvDNWXOZdVBgup8XBYW0EqOhY83n5Gt50BpzJyq/nfAfwqn+Rak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866085; c=relaxed/simple;
	bh=cL0GCb3tG/kam3FoIPck5xj4eap4KV0y2insekhYb5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHxAgDSCYaCcd33ga6PoxVzdfzMEidweUcjZM5uWCS70ri2wUCRFSMBOwrLo+M+EUcPXfnde2Vp89kB/DkM5HKlulNTyQXhhutrsaur9SnROeEU3aADokseWQBEjhWbWpU6X4/DqIDsmkgBaX0tFdMNiq2qRgGArTFStPDmbtTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4kr01dl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755866084; x=1787402084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cL0GCb3tG/kam3FoIPck5xj4eap4KV0y2insekhYb5Q=;
  b=V4kr01dlFI7nmhXbl9CljjFrmBOr3cjbbVFMxVYAUYPPTfyLWwx2R8ap
   5NbT+P8ogJGNcCAt2Fyr6NCyIUS37CXoTNwxBXtykRqebZ7maaI9xpd1d
   8oCZERYkabvcYSA+TYvem6LN00eYhhNA0KnrEDyyZSJBmvSiqThNK4S1A
   V+QYb3gWhblIfUD79Q5Kr85qQkG0byXh+gFnhhC/h8hGvcs8O2aUiiXD3
   Ect0snkGoVVFA1F1ESqJJfr+wON5/QHea3m/TWmLbqLS7gEj9IKfnyz5C
   vvSVLowX82mkaaTROwmG5qbViLlMw8wRg609Yhkat6CzXOMwum6PteMhT
   A==;
X-CSE-ConnectionGUID: hSXIj0ewRvSkt9nIgQKL2Q==
X-CSE-MsgGUID: eurPymRXQwyH9FFQZVJc4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="45742838"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="45742838"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:34:34 -0700
X-CSE-ConnectionGUID: BdhYEKszSaOvtvJ/or1ovg==
X-CSE-MsgGUID: JebbR26uRN+jgj1ITw7dOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168599384"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:34:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Rio Liu <rio@r26.me>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] PCI: Fix pdev_resources_assignable() disparity
Date: Fri, 22 Aug 2025 15:33:58 +0300
Message-Id: <20250822123359.16305-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822123359.16305-1-ilpo.jarvinen@linux.intel.com>
References: <20250822123359.16305-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
pci 0001:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0001:00:00.0 (capable of 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
pcieport 0001:00:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
pcieport 0001:00:00.0: bridge window [mem 0x40000000-0x401fffff]: assigned
------------[ cut here ]------------
kernel BUG at drivers/pci/setup-bus.c:2532!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
...
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
Reported-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Closes: https://lore.kernel.org/all/5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/setup-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 527f0479e983..df5aec46c29d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1191,6 +1191,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			resource_size_t r_size;
 
 			if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
+			    !pdev_resources_assignable(dev) ||
 			    ((r->flags & mask) != type &&
 			     (r->flags & mask) != type2 &&
 			     (r->flags & mask) != type3))
-- 
2.39.5


