Return-Path: <linux-pci+bounces-35960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A800CB53F52
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 01:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D5D1C23A12
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 23:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDD926D4F8;
	Thu, 11 Sep 2025 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LqeV/Dh9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36647F4A
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757635012; cv=none; b=kJ1vk179EpULsoUCIQKyVo1c+qQpK2YKKuA5+190HUUNEmQu6yA0XQi7NAvfu9kMHZYSSHw/N/0MLwKDlwovSAdH89sAj+un4ctMm1hAnDvKYF5Ojrb1MtCxl6AMe7TaffGlbWkWmufKy3Tt6hwqm2j1e+et7YS5tn49UVkBomw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757635012; c=relaxed/simple;
	bh=+GUi3kC3mpHFISomaJ1WjjnTE2EEOgxzrGHdRV7V9wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XXHiP94gBaKKJy7eLiSNtisQgNBb8IV2AUXpZ/5H2DDOi8fSKdMwcYZmAkTShBlWMoAOySBTVpZaROk0s3fj7jvNUVIlrZLdaD3DAvEyVdkTzQ7qoYdvNJowWs/XJx05KHNzGNcMKknA91g2QzkEEGs/lUWlIkwO4lTfmTqC1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LqeV/Dh9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757635009; x=1789171009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+GUi3kC3mpHFISomaJ1WjjnTE2EEOgxzrGHdRV7V9wI=;
  b=LqeV/Dh9lc4V7pGo02xyN4e8c+c6jFWgQeD73cj7EFw9nx+y4NRrkY4K
   slkpaj+QFMqcJLGtPk9JeL9AjXpmWGrotRPVWQcAUKD2YSurzmwtBs/jc
   LbW6WZlu3f3pr1RYb1yzPiSjp0E+nO4D9rzY3YOsm1P4zViY4Iomm1V04
   p/E2bGxIzP+VImkz2jhJksJXTL1JlKhwweKMGeHfuPkjHpJO4A2HSDf5N
   q3JnGDdkuHhmpUsHomrPX4E/Uu04dRipcUITmZQ/VDjV6p3J0DJXWjI0o
   smxcsm37hXEu/TXKTk7dBVg8YCEHwH3eXbBXxvz7+alAolAaCgsOvPBDA
   g==;
X-CSE-ConnectionGUID: dIX6kPn1Q7K4rg95QOWlCA==
X-CSE-MsgGUID: pPROkTx/T1qnQ5eyKxcSAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="70598689"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="70598689"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 16:56:48 -0700
X-CSE-ConnectionGUID: xnR7mFkRQ5Scas+iSfd/cA==
X-CSE-MsgGUID: 6dxhkmbKQBePgTWFP2rByw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="173393511"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa007.fm.intel.com with ESMTP; 11 Sep 2025 16:56:46 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	Alexey Kardashevskiy <aik@amd.com>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christoph Hellwig <hch@lst.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH resend v6 00/10] PCI/TSM: Core infrastructure for PCI device security (TDISP)
Date: Thu, 11 Sep 2025 16:56:37 -0700
Message-ID: <20250911235647.3248419-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[apologies for the duplicates, I flubbed my mailing list aliases]

Changes since v5 [1]:
- Add @tsm_dev parameter to 'struct pci_tsm_link_ops::probe()' (Alexey)
- Fix to_pci_tsm_pf0() to walk to the DSM device (Alexey)
- Fix IDE establishment "default stream" setting regression (Alexey)
- Fix pci_ide_stream_enable() in the presence of devices that delay the
  "secure" transition to K_SET_GO (Alexey)
- Make sure pci_ide_stream_enable() has a unique error code for the
  "failed to go to secure state" case. (Alexey)
- Clarify that pci_tsm_connect() unconditionally probes all potential
  TDIs (Alexey)
- Rename 'struct pci_tsm_security_ops' to 'struct pci_tsm_devsec_ops'
  (Alexey)
- Add @tsm_dev parameter to 'struct pci_tsm_devsec_ops::lock()' (Alexey)
- Pass 'struct pci_tsm *' to 'struct pci_tsm_devsec_ops::unlock()' (Alexey)
- Rename 'struct pci_tsm::dsm' 'struct pci_tsm::dsm_dev' (Aneesh)
- Rename 'struct pci_tsm_pf0::base' to 'struct pci_tsm_pf0::base_tsm'
  (Aneesh)
- Make definition of 'struct tsm_dev' public, drop tsm_name() and
  tsm_pci_ops() helpers.
- Drop __devsec_pci_ops (delayed cleanup now possible with 'struct
  tsm_dev' public) (Jonathan)
- Revive pci_tsm_doe_transfer() (Aneesh)
- Fix tsm_unregister() to not assume that all TSMs implement PCI
  operations

[1]: http://lore.kernel.org/20250827035126.1356683-1-dan.j.williams@intel.com

This set is available at
https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=staging
(rebasing branch) or devsec-20250911 (immutable tag). It passes a basic
smoke test that exercises load/unload of the samples/devsec/ modules and
connect/disconnect of the emulated device. Note that tag also has a
preview of changes that will be included in v2 of "[PATCH 0/7] PCI/TSM:
TEE I/O infrastructure" [2].

[2]: http://lore.kernel.org/20250827035259.1356758-1-dan.j.williams@intel.com

Status: ->connect() flow is nearly settled
------------------------------------------
The review feedback continues to slow. Various folks have had their
naming and organization preferences adopted so I feel comfortable
calling this a consensus branch. Let us leave any further requests for
naming changes to Bjorn.

This version seems suitable for proceeding to linux-next inclusion. That
inclusion depends on the guest side TEE I/O infrastructure also
settling. That guest set definitely needs at least a v2 [2]. In short,
PCI core infrastructure for TEE I/O (both host and guest) targeting
linux-next inclusion post v6.18-rc1.

Next steps:
-----------
- Stage at least one vendor ->connect() implementation on top of a
  tsm.git#staging snapshot.

- Find an arrangement to supplement samples/devsec/ regression testing
  with IDE establishment / "connect()" flow regression testing.

Original Cover letter:
----------------------

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

The proposal, of which this set is the first phase, is incrementally
develop the shared infrastructure on top of a sample TSM driver
implementation to enable clean vendor agnostic discussions about the
commons. "samples/devsec/" is meant to be: just enough emulation to
exercise all the core infrastructure, a reference implementation, and a
simple unit test. The sample also enables coordination with the native
PCI device security effort [3].

[3]: http://lore.kernel.org/cover.1719771133.git.lukas@wunner.de

Dan Williams (10):
  coco/tsm: Introduce a core device for TEE Security Managers
  PCI/IDE: Enumerate Selective Stream IDE capabilities
  PCI: Introduce pci_walk_bus_reverse(), for_each_pci_dev_reverse()
  PCI/TSM: Authenticate devices via platform TSM
  samples/devsec: Introduce a PCI device-security bus + endpoint sample
  PCI: Add PCIe Device 3 Extended Capability enumeration
  PCI/IDE: Add IDE establishment helpers
  PCI/IDE: Report available IDE streams
  PCI/TSM: Report active IDE streams
  samples/devsec: Add sample IDE establishment

 Documentation/ABI/testing/sysfs-bus-pci       |  51 ++
 Documentation/ABI/testing/sysfs-class-tsm     |  19 +
 .../ABI/testing/sysfs-devices-pci-host-bridge |  26 +
 Documentation/driver-api/pci/index.rst        |   1 +
 Documentation/driver-api/pci/tsm.rst          |  12 +
 MAINTAINERS                                   |   7 +-
 drivers/base/bus.c                            |  38 +
 drivers/pci/Kconfig                           |  29 +
 drivers/pci/Makefile                          |   2 +
 drivers/pci/bus.c                             |  38 +
 drivers/pci/doe.c                             |   2 -
 drivers/pci/ide.c                             | 584 ++++++++++++++
 drivers/pci/pci-sysfs.c                       |   4 +
 drivers/pci/pci.h                             |  19 +
 drivers/pci/probe.c                           |  28 +-
 drivers/pci/remove.c                          |   6 +
 drivers/pci/search.c                          |  62 +-
 drivers/pci/tsm.c                             | 627 +++++++++++++++
 drivers/virt/coco/Kconfig                     |   3 +
 drivers/virt/coco/Makefile                    |   1 +
 drivers/virt/coco/tsm-core.c                  | 166 ++++
 include/linux/device/bus.h                    |   3 +
 include/linux/pci-doe.h                       |   4 +
 include/linux/pci-ide.h                       |  75 ++
 include/linux/pci-tsm.h                       | 159 ++++
 include/linux/pci.h                           |  36 +
 include/linux/tsm.h                           |  14 +
 include/uapi/linux/pci_regs.h                 |  89 +++
 samples/Kconfig                               |  19 +
 samples/Makefile                              |   1 +
 samples/devsec/Makefile                       |  10 +
 samples/devsec/bus.c                          | 737 ++++++++++++++++++
 samples/devsec/common.c                       |  26 +
 samples/devsec/devsec.h                       |  40 +
 samples/devsec/link_tsm.c                     | 242 ++++++
 35 files changed, 3167 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 Documentation/driver-api/pci/tsm.rst
 create mode 100644 drivers/pci/ide.c
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 drivers/virt/coco/tsm-core.c
 create mode 100644 include/linux/pci-ide.h
 create mode 100644 include/linux/pci-tsm.h
 create mode 100644 samples/devsec/Makefile
 create mode 100644 samples/devsec/bus.c
 create mode 100644 samples/devsec/common.c
 create mode 100644 samples/devsec/devsec.h
 create mode 100644 samples/devsec/link_tsm.c


base-commit: 650d64cdd69122cc60d309f2f5fd72bbc080dbd7
-- 
2.51.0


