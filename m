Return-Path: <linux-pci+bounces-17800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9279E6070
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 23:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D432A16A75F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0525C1BBBF1;
	Thu,  5 Dec 2024 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aps0/2Os"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC521BD51B
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437399; cv=none; b=QnPuKLfOxMvgo1Tcd8UAuFvhYo9F+3skx/uyBZS6BCDGTe8OsjedcI4+KCVA57FdVw9x98T2mSeR6N5cZCD5noFRpUsVt1g6b2ttlaHrZSqhBDQWPfYH2bPtYeE3I87fKtDoTCYAjSF433GNG743qN32OzUar7SxstcsarqSJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437399; c=relaxed/simple;
	bh=eICSL0cDaKmDyNWxI16Ue5CB5PDKi5xWA7uqteoLYtE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=T3emvD8yV4TqURuYlCh9X7CFojxh006/0h6w/xpNMKhCOxDZdPKnGsX4GYvM6kxo827mCtMGXfexH5cm03Wktcl3FwQztJeG7+45jkkAWTITjuBzC7r02FyILGF83rI+pvgGe9NkXIOX3jiOmIqh9Q5GCyLafbhVTLmfpW4NQ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aps0/2Os; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733437397; x=1764973397;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eICSL0cDaKmDyNWxI16Ue5CB5PDKi5xWA7uqteoLYtE=;
  b=Aps0/2OsosSwiV98EDty6+H2c/upbU9c592Eu1zGdQrYmN194o9ZRpas
   C1CLFqzbyQ+wv8tptco4JnmspTqN/EumtgZhAjO5mAqzj8Oeca2kI8a0o
   cOklAcDHnmHUVwLZoMVoIwc1nWUXpLdG+1MMZZvigPXdrJY/oQa4UYsmJ
   b0kiD8/96VGg3EP0wq/79uymBkKmt3yfOSUljljroCjLRkzgOSeqm8PN8
   E/LIKqSt6Y9PLrw5kXb9U6bXccxY4Ew8OjV31x50N2AK8jgofR0qbZxtL
   sxAYfDBOGVVO3MUKnxJ8+Z0POp/ffLXnnlEjaL5zvmkrnTu0Q3o4kQcHK
   g==;
X-CSE-ConnectionGUID: xm4bFPOARZe2+bf0nHO1aw==
X-CSE-MsgGUID: jTL15NwBSpCHjK8zXhMVuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33921107"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33921107"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:17 -0800
X-CSE-ConnectionGUID: lDNyMT0+QpaiZq7EF1mlWg==
X-CSE-MsgGUID: sxS+qQXdRVuE5tcNSpWbtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="93905501"
Received: from kcaccard-desk.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:16 -0800
Subject: [PATCH 00/11] PCI/TSM: Core infrastructure for PCI device security
 (TDISP)
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Wu Hao <hao.wu@intel.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Lukas Wunner <lukas@wunner.de>, Sami Mujawar <sami.mujawar@arm.com>,
 Steven Price <steven.price@arm.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yilun Xu <yilun.xu@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 John Allen <john.allen@amd.com>,
 Ilpo =?utf-8?b?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
Date: Thu, 05 Dec 2024 14:23:15 -0800
Message-ID: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Changes since the RFC [1]:
- Wording changes and cleanups in "PCI/TSM: Authenticate devices via
  platform TSM" (Bjorn)
- Document /sys/class/tsm/tsm0 (Bjorn)
- Replace the single ->exec(@op_code) operation with named operations
  (Alexey, Yilun)
- Locking fixup in drivers/pci/tsm.c (Yilun)
- Drop pci_tsm_devs xarray (Alexey, Yilun)
- Finish the host bridge stream id allocator implementation (Alexey)
- Clarify pci_tsm_init() relative to IDE && !TEE devices (Alexey)
- Add the IDE core helpers
- Add devsec_tsm and devsec_bus sample driver and emulation

[1]: http://lore.kernel.org/171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com

---

Trusted execution environment (TEE) Device Interface Security Protocol
(TDISP) is a chapter name in the PCI specification. It describes an
alphabet soup of mechanisms, SPDM, CMA, IDE, TSM/DSM, that system
software uses to establish trust in a device and assign it to a
confidential virtual machine (CVM). It is protocol for dynamically
extending the trusted computing boundary (TCB) of a CVM with a PCI
device interface that can issue DMA to CVM private memory.

The acronym soup problem is enhanced by every major platform vendor
having distinct TEE Security Manager (TSM) API implementations /
capabilities, and to a lesser extent, every potential endpoint Device
Security Manager (DSM) having its own idiosyncratic behaviors around
TDISP state transitions.

Despite all that opportunity for differentiation, there is a significant
portion of the implementation that is cross-vendor common. However, it
is difficult to develop, debate, test and settle all those pieces absent
a low level TSM driver implementation to pull it all together.

The proposal is incrementally develop the shared infrastructure on top
of a sample TSM driver implementation to enable clean vendor agnostic
discussions about the commons. "samples/devsec/" is meant to be: just
enough emulation to exercise all the core infrastructure, a reference
implementation, and a simple unit test. The sample also enables
coordination with the native PCI device security effort [2].

The devsec_tsm driver is already yielding benefits as it drove many of
the fixes and enhancements of this patch-kit relative to the last RFC
[1]. Future development would either reuse established devsec_tsm paths,
or extend the sample alongside the vendor-specific implementation.

This first batch is just enough infrastructure for IDE (link Integrity
and Data Encryption) establishment via TSM APIs. It is based on a review
and curation of the IDE establishment flows from the SEV-TIO RFC [3] and
a work-in-progress TDX Connect RFC (see the Co-developed-by and thanks
yous in the changelogs for where code was copied).

It deliberately avoids SPDM details and does not touch upon the "bind"
flows, or guest-side flows, simply to allow for upstream digestion of
all the assumptions and tradeoffs for the "simple" IDE establishment
baseline.

Note that devsec_tsm is for near term staging of vendor TSM
implementations. The expectation is that every piece of new core
infrastructure that devsec_tsm consumes must also have a vendor TSM
driver consumer within 1 to 2 kernel development cycles.

The full series is available via devsec/tsm.git [4].

[2]: http://lore.kernel.org/cover.1719771133.git.lukas@wunner.de
[3]: http://lore.kernel.org/20240823132137.336874-1-aik@amd.com
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=devsec-20241205

---

Dan Williams (11):
      configfs-tsm: Namespace TSM report symbols
      coco/guest: Move shared guest CC infrastructure to drivers/virt/coco/guest/
      coco/tsm: Introduce a class device for TEE Security Managers
      PCI/IDE: Selective Stream IDE enumeration
      PCI/TSM: Authenticate devices via platform TSM
      samples/devsec: PCI device-security bus / endpoint sample
      PCI: Add PCIe Device 3 Extended Capability enumeration
      PCI/IDE: Add IDE establishment helpers
      PCI/IDE: Report available IDE streams
      PCI/TSM: Report active IDE streams
      samples/devsec: Add sample IDE establishment


 Documentation/ABI/testing/configfs-tsm-report      |    0 
 Documentation/ABI/testing/sysfs-bus-pci            |   42 +
 Documentation/ABI/testing/sysfs-class-tsm          |   20 +
 .../ABI/testing/sysfs-devices-pci-host-bridge      |   39 +
 MAINTAINERS                                        |   10 
 drivers/pci/Kconfig                                |   16 
 drivers/pci/Makefile                               |    2 
 drivers/pci/ide.c                                  |  311 +++++++++
 drivers/pci/pci-sysfs.c                            |    4 
 drivers/pci/pci.h                                  |   34 +
 drivers/pci/probe.c                                |   15 
 drivers/pci/remove.c                               |    3 
 drivers/pci/tsm.c                                  |  293 ++++++++
 drivers/virt/coco/Kconfig                          |    8 
 drivers/virt/coco/Makefile                         |    3 
 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c    |    8 
 drivers/virt/coco/guest/Kconfig                    |    7 
 drivers/virt/coco/guest/Makefile                   |    3 
 drivers/virt/coco/guest/report.c                   |   32 -
 drivers/virt/coco/host/Kconfig                     |    6 
 drivers/virt/coco/host/Makefile                    |    6 
 drivers/virt/coco/host/tsm-core.c                  |  145 ++++
 drivers/virt/coco/sev-guest/sev-guest.c            |   12 
 drivers/virt/coco/tdx-guest/tdx-guest.c            |    8 
 include/linux/pci-ide.h                            |   33 +
 include/linux/pci-tsm.h                            |   83 ++
 include/linux/pci.h                                |   22 +
 include/linux/tsm.h                                |   33 +
 include/uapi/linux/pci_regs.h                      |   92 +++
 samples/Kconfig                                    |   15 
 samples/Makefile                                   |    1 
 samples/devsec/Makefile                            |   10 
 samples/devsec/bus.c                               |  695 ++++++++++++++++++++
 samples/devsec/common.c                            |   26 +
 samples/devsec/devsec.h                            |    7 
 samples/devsec/tsm.c                               |  192 ++++++
 36 files changed, 2185 insertions(+), 51 deletions(-)
 rename Documentation/ABI/testing/{configfs-tsm => configfs-tsm-report} (100%)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
 create mode 100644 drivers/pci/ide.c
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 drivers/virt/coco/guest/Kconfig
 create mode 100644 drivers/virt/coco/guest/Makefile
 rename drivers/virt/coco/{tsm.c => guest/report.c} (93%)
 create mode 100644 drivers/virt/coco/host/Kconfig
 create mode 100644 drivers/virt/coco/host/Makefile
 create mode 100644 drivers/virt/coco/host/tsm-core.c
 create mode 100644 include/linux/pci-ide.h
 create mode 100644 include/linux/pci-tsm.h
 create mode 100644 samples/devsec/Makefile
 create mode 100644 samples/devsec/bus.c
 create mode 100644 samples/devsec/common.c
 create mode 100644 samples/devsec/devsec.h
 create mode 100644 samples/devsec/tsm.c

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37

