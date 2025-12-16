Return-Path: <linux-pci+bounces-43071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3303CC0633
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 01:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F6C9300310E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 00:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E2269CE1;
	Tue, 16 Dec 2025 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtyvDH8c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157E23B61B;
	Tue, 16 Dec 2025 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846534; cv=none; b=p90CXG+5KlOWdx0gOUq6fcNz+gmdVyn/obOXRD2uioOdWPWhH4z2krmrC3/Cm/vPenJyK+JVMfsQakwvEjXffJgF9RMp68Z++uM7nonROoBSItw3ThZqx82Ioy+7l/O5TB7haIq8wJrZNZB8hsjwRhg1sDkGP+IYbO7xOCFvHgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846534; c=relaxed/simple;
	bh=RnzOt9FEnaC4JRME7P7aiV2XUEmMcM5aYimByXbJ1D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hDj797tKlFFdvMf1GD8JvQzJuZgO+DcYOatBdmiTvOVoLvG4VEFSRgslWKwifwXaM98IDAkpepwLc6AZ9tYo9JQyml1UCEhAFqZ9MZaowKLXoPDp0AHHjREFNtzX2JAxkdLhokv8kdkHX4ruN3TygoS80gf2OfT1wNqL58IY0Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtyvDH8c; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765846532; x=1797382532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RnzOt9FEnaC4JRME7P7aiV2XUEmMcM5aYimByXbJ1D4=;
  b=TtyvDH8ca3pXue32qY0iDZFGDywm4EkFeQ4Hr4BkA/2xSb+p9fBKqLcx
   GRtcDjPE8ovhE0JC38/cSp9jZKwSTRCFNJdI4bc0Wmh5Ev6Fwk9ojeKEY
   gj+ikIgnyi/SXenlima3EZhmao0tfwfly/F60M9LgWvodAqX6lhpKRkfE
   9yCPkXVpC/7MO6Ly61uebj6uHUkvhSZf0aGUT1srHEGqSeyFRrCEa0YcQ
   Vz0Vb4QaO7esotV6HnjKZkSh2aCNEdkpUxEoDnsKYn4NGCzRjo5Z/82ao
   zcPIP7l+c9UgYFSBMvP3CZ1V2Ddt5rdWD1gXb/IRmnT2i2aikxzH/3kq3
   w==;
X-CSE-ConnectionGUID: Za6GSwApSqu069I7O34Kng==
X-CSE-MsgGUID: Mqn/cBGRT9yuF0hgc9Jfbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79215468"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="79215468"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 16:55:32 -0800
X-CSE-ConnectionGUID: OxuWOxpESuC/qBuxrkugOA==
X-CSE-MsgGUID: naH12D/3QteIK0IX8a3Xmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="198131518"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa008.fm.intel.com with ESMTP; 15 Dec 2025 16:55:31 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	alison.schofield@intel.com,
	terry.bowman@amd.com,
	alejandro.lucero-palau@amd.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Subject: [PATCH v2 0/6] cxl: Initialization reworks to support Soft Reserve Recovery and Accelerator Memory
Date: Mon, 15 Dec 2025 16:56:10 -0800
Message-ID: <20251216005616.3090129-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since v1 [1]:
- Introduce cxl_memdev_autoremove() one patch earlier in the series to
  fix no_free_ptr() induced NULL pointer de-reference bisect bug. (Ben)
- Drop returning a custom error code via @cxlmd->endpoint that can be
  added back by the accelerator enabling series if needed. (Ben)
- Document how providing @attach changes the semantics of
  devm_cxl_add_memdev(). (Ben)
- Rename @ops to @attach
- Add support to release an accelerator driver when the logical CXL link
  drops.
- Pick up test and review tags from Alison, Ben, Jonathan, Dave, and
  Alejandro.

[1]: http://lore.kernel.org/20251204022136.2573521-1-dan.j.williams@intel.com

Original Cover:
===============

The CXL subsystem is modular. That modularity is a benefit for
separation of concerns and testing. It is generally appropriate for this
class of devices that support hotplug and can dynamically add a CXL
personality alongside their PCI personality. However, a cost of modules
is ambiguity about when devices (cxl_memdevs, cxl_ports, cxl_regions)
have had a chance to attach to their corresponding drivers on
@cxl_bus_type.

This problem of not being able to reliably determine when a device has
had a chance to attach to its driver vs still waiting for the module to
load, is a common problem for the "Soft Reserve Recovery" [2], and
"Accelerator Memory" [3] enabling efforts.

For "Soft Reserve Recovery" it wants to use wait_for_device_probe() as a
sync point for when CXL devices present at boot have had a chance to
attach to the cxl_pci driver (generic CXL memory expansion class
driver). That breaks down if wait_for_device_probe() only flushes PCI
device probe, but not the cxl_mem_probe() of the cxl_memdev that
cxl_pci_probe() creates.

For "Accelerator Memory", the driver is not cxl_pci, but any potential
PCI driver that wants to use the devm_cxl_add_memdev() ABI to attach to
the CXL memory domain. Those drivers want to know if the CXL link is
live end-to-end (from endpoint, through switches, to the host bridge)
and CXL memory operations are enabled. If not, a CXL accelerator may be
able to fall back to PCI-only operation. Similar to the "Soft Reserve
Memory" it needs to know that the CXL subsystem had a chance to probe
the ancestor topology of the device and let that driver make a
synchronous decision about CXL operation.

In support of those efforts:

* Clean up some resource lifetime issues in the current code
* Move some object creation symbols (devm_cxl_add_memdev() and
  devm_cxl_add_endpoint()) into the cxl_mem.ko and cxl_port.ko objects.
  Implicitly guarantee that cxl_mem_driver and cxl_port_driver have been
  registered prior to any device objects being registered. This is
  preferred over explicit open-coded request_module().
* Use scoped-based-cleanup before adding more resource management in
  devm_cxl_add_memdev()
* Give an accelerator the opportunity to run setup operations in
  cxl_mem_probe() so it can further probe if the CXL configuration matches
  its needs.

Some of these previously appeared on a branch as an RFC [4] and left
"Soft Reserve Recovery" and "Accelerator Memory" to jockey for ordering.
Instead, create a shared topic branch for both of those efforts to
import. The main changes since that RFC are fixing a bug and reducing
the amount of refactoring (which contributed to hiding the bug).

[2]: http://lore.kernel.org/20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com
[3]: http://lore.kernel.org/20251119192236.2527305-1-alejandro.lucero-palau@amd.com
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.18/cxl-probe-order

Dan Williams (6):
  cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
  cxl/mem: Arrange for always-synchronous memdev attach
  cxl/port: Arrange for always synchronous endpoint attach
  cxl/mem: Convert devm_cxl_add_memdev() to scope-based-cleanup
  cxl/mem: Drop @host argument to devm_cxl_add_memdev()
  cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation

 drivers/cxl/Kconfig          |   2 +-
 drivers/cxl/cxl.h            |   2 +
 drivers/cxl/cxlmem.h         |  17 ++++--
 drivers/cxl/core/edac.c      |  64 +++++++++++---------
 drivers/cxl/core/memdev.c    | 109 +++++++++++++++++++++++++----------
 drivers/cxl/mem.c            |  73 ++++++++++-------------
 drivers/cxl/pci.c            |   2 +-
 drivers/cxl/port.c           |  40 +++++++++++++
 tools/testing/cxl/test/mem.c |   2 +-
 9 files changed, 200 insertions(+), 111 deletions(-)


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.51.1


