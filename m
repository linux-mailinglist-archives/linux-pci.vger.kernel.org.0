Return-Path: <linux-pci+bounces-2782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC87841F54
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 10:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23331C252A4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF065BAFC;
	Tue, 30 Jan 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zr+m9rSE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6057891
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606630; cv=none; b=bPhr8tSyWbFOy502suHvBGqW22IEey+pHjlgdgLVxP266vFPL31d4hYiQfzSaXB6ECE0WiUd1UCAwpJMaalfFpBQxWucIzMx5o6xSPFqloEMmqZhxgPv8mwyM1ebMrJ9gvsOo4vrm6/hrgYbqlNRkMAtLT7QZOS7/J/wpBdyDRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606630; c=relaxed/simple;
	bh=uoZ9of1M0BDVCCfinl5/hvnmBlAiMc4gjMbLMXpHYHQ=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=AzuXAxkaJrJ+P9qR0HEq4VOgvGyZl827gmbY4MCXE5BEoDYvSkz5pIRrkWD/TBroUCfXbD8T3R8hF/czkjXUhsPavhLQWrBJwSflBvho2Z6/5kUikL8bGDjiPYxNX1gSvaTyivcHUP6hTBJG8iqe7V47nYDrvYeBs6hHNnOs5vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zr+m9rSE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706606627; x=1738142627;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uoZ9of1M0BDVCCfinl5/hvnmBlAiMc4gjMbLMXpHYHQ=;
  b=Zr+m9rSE+wM02YDb9vZpI3olx27S23CIHFUaWMeQ4DI6vTB7QSBRw+3z
   qrle9U08z8VEQwJbrClYpRtMvFoSs6gzol1YM32sWx22NYsLUJs9/R3Ad
   IG0qOEJ9JnULkjQ9RLVAcesx5k2zKKIlXPy5JY1gdDdNTAnOr3EmqKv53
   wzfWxDf5AACUVYS5cdR+EGdusNQ5E+oo+XeghHw5IsK509YpPyiZsY6J9
   UzfN7P1NIxplMsF9GoE+VDbsJOQHpUfXuMAnp5mgsQtmCXIwxE89aEA3R
   0fKaZZ3Q0CqyVZU2X2TN3SfBgbpIy6ZlMTKFC5d8DVhef1kHsxFEjfUoV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="24699842"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="24699842"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:23:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3738909"
Received: from djayasin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.72.104])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:23:46 -0800
Subject: [RFC PATCH 0/5] Towards a shared TSM sysfs-ABI for Confidential
 Computing
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Lukas Wunner <lukas@wunner.de>, Wu Hao <hao.wu@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Alexey Kardashevskiy <aik@amd.com>, John Allen <john.allen@amd.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
Date: Tue, 30 Jan 2024 01:23:46 -0800
Message-ID: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

As you may recall the configfs-tsm proposal [1] for conveying
attestation reports, accepted into v6.7, made the case that shared
cross-vendor concepts demand shared infrastructure. Whereas configfs-tsm
only shares guest-side transport / blob-marshaling infrastructure, the
PCIe device-security interactions with a TSM are more standardized (PCIe
TDISP) and as a result present a wider opportunity for cross-vendor
shared-semantics, not just transport infrastructure.

The proposals in this set are an attempt to intercept and reconcile
details of 4 different patchsets in various stages of making their way
upstream, TDX host patches [2], TIO preview implementation [3], SPDM/CMA
support [4], and TDX Connect preview implementation (not posted). The
guiding principle for this RFC, beyond "common concepts demand shared
infrastructure", is that PCI core concepts, defined by the PCI spec,
should live in and interoperate with the PCI core (e.g. CMA <-> TSM
interaction). The result is a /sys/bus/virtual/devices/tsm0 singleton
class device proposal with a pci/ attribute directory and a
/sys/bus/pci/devices/$pdev/tsm/ attribute directory added to each PCI
capable device that in turn coordinates with
/sys/bus/pci/devices/$pdev/authenticated.

This gives TDX, and other software-module based TSMs like RISCV COVE, a
common place to host their module attributes in
/sys/bus/virtual/devices/tsm0/host, while for SEV-SNP, and other
hardware based TSMs like ARM CCA, that /sys/bus/virtual/tsm0/host is a
symlink back to /sys/bus/pci/devices/$tsm_dev. Beyond the sysfs
device-model, for TIO, COVE-IO, and TDX Connect this gives an initial
set of library calls, locking model, and operations to support the low
level implementations.

This set has only been verified to compile, it is not functional. It is
only meant to convey the scaffolding for low level implementations to
build upon. Expect it to change as low level implementations try to
adopt it.

Otherwise, this is the first step in demonstrating that we have our act
together in terms of unifying on a common-core interface language and
low-level interface verbs. I.e. "we" the device-security kernel
developer community regarding our conversation at the BoF at Plumbers
[5] where the outcome was to unify on a set of verbs and adopt the
semantics of the low level implementation that exports the least amount
of complexity to Linux while still meeting user expectations (as simple
as possible, but no simpler).

Note that this depends on a new core-sysfs capability (patch4), with
trending positive reaction from Greg [6], to hide entire sysfs-group
attribute directories when not applicable. This further lets
implementations get away from dynamic device-attribute creation, or
worse dynamic kobject creation, that makes device ABI subsystems hard to
reason about [7].

[1]: http://lore.kernel.org/r/654438f4ca604_3f6029413@dwillia2-mobl3.amr.corp.intel.com.notmuch
[2]: http://lore.kernel.org/r/20230331154432.00001373@gmail.com
[3]: https://github.com/aik/linux/tree/tio
[4]: http://lore.kernel.org/r/cover.1695921656.git.lukas@wunner.de
[5]: https://lpc.events/event/17/contributions/1635/
[6]: http://lore.kernel.org/r/2024012855-limb-monument-cd86@gregkh
[7]: http://lore.kernel.org/r/20231019200110.GA1410324@bhelgaas

---

Dan Williams (5):
      PCI/CMA: Prepare to interoperate with TSM authentication
      coco/tsm: Establish a new coco/tsm subdirectory
      coco/tsm: Introduce a shared class device for TSMs
      sysfs: Introduce a mechanism to hide static attribute_groups
      PCI/TSM: Authenticate devices via platform TSM


 Documentation/ABI/testing/sysfs-bus-pci   |   53 ++++
 Documentation/ABI/testing/sysfs-class-tsm |   35 +++
 drivers/pci/Kconfig                       |   15 +
 drivers/pci/Makefile                      |    2 
 drivers/pci/cma.c                         |   12 +
 drivers/pci/pci-sysfs.c                   |    3 
 drivers/pci/pci.h                         |   14 +
 drivers/pci/probe.c                       |    1 
 drivers/pci/remove.c                      |    1 
 drivers/pci/tsm.c                         |  346 +++++++++++++++++++++++++++++
 drivers/virt/coco/Kconfig                 |    6 -
 drivers/virt/coco/Makefile                |    4 
 drivers/virt/coco/sev-guest/sev-guest.c   |    8 -
 drivers/virt/coco/tdx-guest/tdx-guest.c   |    8 -
 drivers/virt/coco/tsm/Kconfig             |   14 +
 drivers/virt/coco/tsm/Makefile            |   10 +
 drivers/virt/coco/tsm/class.c             |  112 +++++++++
 drivers/virt/coco/tsm/pci.c               |   83 +++++++
 drivers/virt/coco/tsm/reports.c           |   24 +-
 drivers/virt/coco/tsm/tsm.h               |   28 ++
 fs/sysfs/group.c                          |   45 +++-
 include/linux/pci.h                       |    3 
 include/linux/sysfs.h                     |   63 ++++-
 include/linux/tsm.h                       |  109 ++++++++-
 include/uapi/linux/pci_regs.h             |    3 
 25 files changed, 935 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 drivers/virt/coco/tsm/Kconfig
 create mode 100644 drivers/virt/coco/tsm/Makefile
 create mode 100644 drivers/virt/coco/tsm/class.c
 create mode 100644 drivers/virt/coco/tsm/pci.c
 rename drivers/virt/coco/{tsm.c => tsm/reports.c} (94%)
 create mode 100644 drivers/virt/coco/tsm/tsm.h

The unstable baseline of this series is a merge of
https://github.com/l1k/linux/commit/f3dc1e0eb451 and v6.8-rc2.

