Return-Path: <linux-pci+bounces-42600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7B5CA227F
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 03:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6899930249EF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 02:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5307238C36;
	Thu,  4 Dec 2025 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLQz/4c0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52B78632B;
	Thu,  4 Dec 2025 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764814874; cv=none; b=NtrCvETdQ/CLa+3FepsULtDwAPnnlkQ9CIW38tdTUBTEL08QWEeslu1rlz2EXlXFTxipFSmUrpba6clVmnHna8JiZmjHclqTet+PO0+bV6MRiz1vBEhZ6deqMq8R6bFCMBiyNNnIY3ul3VvDuZpasQAHx9YNWMA1BlZKz6Nxpfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764814874; c=relaxed/simple;
	bh=JzvB4c6aHomjIBkz+7Yw56kwNodM9Z2ggEEx0xL1yqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmF//mYtW3mZwSSnLRpVjQxTQcy+fVwNEe/p8iEhg/8TdcSAfEVmjr4Y05m+r00ZdohlvIxIwRCdvR0/EeY36bYc56luNA53J4r7Lcqskl1VcOezrrfL5HzVcsLKK/V6waKhJk8LY5Vs11few4nUCpWQY+Y1KeEmEcidhLK3+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLQz/4c0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764814873; x=1796350873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JzvB4c6aHomjIBkz+7Yw56kwNodM9Z2ggEEx0xL1yqw=;
  b=FLQz/4c0KiDfYzPaCOwpR+B5ejrHYJJP+VhHgRdWIzl2vanTNb6VadND
   R2dmIiuJFUieLOLh0vv9em5L8hI2oGFgVVFACMi/xcVz3OEGizy0aDX4n
   5DjAy1Ceu6lSqoLFwkIg4tNjdyWyMHImW7akTUWxg8VpFWN2sRNhsgRFP
   LnT7TnlfnQnql4r65qzCaRVabxYgLFpxjnjNZZpl6Q2jjZ1F8NVH304v8
   cuVE+4b3BlD4rbepTgY+O1fPu2eNucypNLF0TXRzMGd/yi2LxR+ZhyaiJ
   7c1tXZ+O/iXiV/zvC4B7jaOl36HrZxDAOai0Pnn5G0CQLDrI0uyrdltzc
   g==;
X-CSE-ConnectionGUID: 01i6fDFqQdKjsLH92nLYQA==
X-CSE-MsgGUID: sWb5CyBHSW6izrRuLbrJig==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77508632"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="77508632"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 18:21:12 -0800
X-CSE-ConnectionGUID: ZAvAEcqZShO+p2gBfGnScg==
X-CSE-MsgGUID: bM/WyKdQQaWyUoYwoOk0Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="225802499"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa001.fm.intel.com with ESMTP; 03 Dec 2025 18:20:58 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	alison.schofield@intel.com,
	terry.bowman@amd.com,
	alejandro.lucero-palau@amd.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	Alejandro Lucero <alucerop@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 0/6] cxl: Initialization reworks in support Soft Reserve Recovery and Accelerator Memory
Date: Wed,  3 Dec 2025 18:21:30 -0800
Message-ID: <20251204022136.2573521-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL subsystem is modular. That modularity is a benefit for
separation of concerns and testing. It is generally appropriate for this
class of devices that support hotplug and can dynamically add a CXL
personality alongside their PCI personality. However, a cost of modules
is ambiguity about when devices (cxl_memdevs, cxl_ports, cxl_regions)
have had a chance to attach to their corresponding drivers on
@cxl_bus_type.

This problem of not being able to reliably determine when a device has
had a chance to attach to its driver vs still waiting for the module to
load, is a common problem for the "Soft Reserve Recovery" [1], and
"Accelerator Memory" [2] enabling efforts.

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

Some of these previously appeared on a branch as an RFC [3] and left
"Soft Reserve Recovery" and "Accelerator Memory" to jockey for ordering.
Instead, create a shared topic branch for both of those efforts to
import. The main changes since that RFC are fixing a bug and reducing
the amount of refactoring (which contributed to hiding the bug).

[1]: http://lore.kernel.org/20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com
[2]: http://lore.kernel.org/20251119192236.2527305-1-alejandro.lucero-palau@amd.com
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.18/cxl-probe-order

Dan Williams (6):
  cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
  cxl/mem: Arrange for always-synchronous memdev attach
  cxl/port: Arrange for always synchronous endpoint attach
  cxl/mem: Convert devm_cxl_add_memdev() to scope-based-cleanup
  cxl/mem: Drop @host argument to devm_cxl_add_memdev()
  cxl/mem: Introduce a memdev creation ->probe() operation

 drivers/cxl/Kconfig          |   2 +-
 drivers/cxl/cxl.h            |   2 +
 drivers/cxl/cxlmem.h         |  17 ++++--
 drivers/cxl/core/edac.c      |  64 ++++++++++++---------
 drivers/cxl/core/memdev.c    | 104 ++++++++++++++++++++++++-----------
 drivers/cxl/mem.c            |  69 +++++++++--------------
 drivers/cxl/pci.c            |   2 +-
 drivers/cxl/port.c           |  40 ++++++++++++++
 tools/testing/cxl/test/mem.c |   2 +-
 9 files changed, 192 insertions(+), 110 deletions(-)


base-commit: ea5514e300568cbe8f19431c3e424d4791db8291
-- 
2.51.1


