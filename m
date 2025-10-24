Return-Path: <linux-pci+bounces-39213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD46C04129
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2E23B2FDF
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D99219E7D1;
	Fri, 24 Oct 2025 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9H//qMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFED22425B
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271459; cv=none; b=VdBIKrXZJcNTosO32iEY+MWa2BuuIf6mrAUo3BxA6UV6+jWw1B4BEEjor3dQPQxB+UzojuA4pg+VXN5FwO7C0U7fvBpftX04dWjp/5p7FDtAgfS77yPYxE9nrL41LO/KR8kiOolJg5clqXuVZgFUPHMiD1zqOVIHIf/SxNLYJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271459; c=relaxed/simple;
	bh=0N4MlCO0pi55bTwR/93GBixhc5q8D9YIvJrWh2YfXuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ehO0aGD0EPySewHGNHe45CgGEZHYwq3j+qtZRXlEBa2+wTzYV7Kde3jd8AAz+zO+eFewKTpV+Q6W7vBVPPqSG/xXSJpnP3jmScSSP2Sb4/XEeydrdxrmqQwnl2VoogKnqlaRoUmKlmK8p2J0GSUsUZIZQW6i707PNfrXUyM1oYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9H//qMl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761271457; x=1792807457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0N4MlCO0pi55bTwR/93GBixhc5q8D9YIvJrWh2YfXuE=;
  b=D9H//qMlzVFxbRuI2pL1bG5AAo2ZflOAhHVGqZXq1QFOBxqlN/6jDkI2
   Peaq/Pr7jW6P+9o3skq8rVX+6CbdEoTgwYjGESSW3r3/F3ZG8lWLlGGFg
   ao4/Py07cyX8NhuafWC/O2XPDQP3rfTjn5XcN9+Wx7KzjDuIgLeB4G1ja
   036zBo8NO2jvQ64HkVqQgdJAgdQm15PzzGBVQchkKwx9noQwGNQzZne81
   YG/UyJnK3BGg5ZK/fh+fJlVxw0SlbyF1zvOu5fdtN0eSfSGRGpkbVRmsE
   RrgJ+pJSF/nw3QUlTTZPXb5va8837pWH4F97iRHWLeHq+kUvVEgiKGZlD
   g==;
X-CSE-ConnectionGUID: l0eJgnmPR+KdyPnxfrFZEg==
X-CSE-MsgGUID: mcod2GHCQPuqrcabwiSuEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67319366"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="67319366"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 19:04:17 -0700
X-CSE-ConnectionGUID: p9ElDsxQTUaSRcJMf3Q2tA==
X-CSE-MsgGUID: gPLLWQ32QVq3ZgVdrZJy7w==
X-ExtLoop1: 1
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa003.fm.intel.com with ESMTP; 23 Oct 2025 19:04:16 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: aik@amd.com,
	yilun.xu@linux.intel.com,
	aneesh.kumar@kernel.org,
	bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>
Subject: [PATCH v7 0/9] PCI/TSM: Core infrastructure for PCI device security (TDISP)
Date: Thu, 23 Oct 2025 19:04:09 -0700
Message-ID: <20251024020418.1366664-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since v6 [1]:
- Rebase on v6.18-rc2
- Drop @owner from 'struct pci_tsm' and lookup @ops through @tsm_dev
  (Alexey)
- Drop CONFIG_PCI_IDE_STREAM_MAX, only require pci_ide_set_nr_streams()
  for host bridge implementations that limit streams to something less
  than topology max (Aneesh)
- Convert Stream index allocators from bitmaps to ida (preparation for
  solving Stream ID uniqueness problem reported by Alexey)
- Misc whitespace cleanups (Jonathan)
- Misc kdoc fixups
- Fix nr_ide_streams data type, a u8 is too small
- Rename PCI_DOE_PROTO_ => PCI_DOE_FEATURE_ (Alexey)
- Rename @base to @base_tsm in 'struct pci_tsm_pf0' (Aneesh)
- Fix up PCIe r6.1 reference for PCIe r7.0 (Bjorn)
- Fix to_pci_tsm_pf0() failing to walk to the DSM device (Yilun)
- Add pci_tsm_fn_exit() for sub-function cleanups post DSM disconnect
  (Aneesh)
- Move the samples/devsec/ implementation to a follow-on patch set

[1]: http://lore.kernel.org/20250911235647.3248419-1-dan.j.williams@intel.com

This set is available at
https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=staging
(rebasing branch) or devsec-20251023 (immutable tag). That branch
additionally contains address association support, Stream ID uniqueness
compability quirk, updated samples/devsec/ (now with multifunction
device and simple bind support), and an updated preview of v2 of "[PATCH
0/7] PCI/TSM: TEE I/O infrastructure" (fixes x86 encrypted ioremap and
other changes) [2].

[2]: http://lore.kernel.org/20250827035259.1356758-1-dan.j.williams@intel.com

It passes an updated regression testing using samples/devsec/. See this
commit on the staging branch for that test:

https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/commit/?id=44932bffdcc1

Status: ->connect() flow is settled
-----------------------------------
At the risk of tempting fate, the goal is this v7 goes to linux-next via
a stable tsm.git#next branch. Enable one or more TSM driver
implementations to queue on top for v6.19-rc1 via arch-specific trees
for TDX, TIO, CCA, or COVE-IO. I.e. target v6.19 to support baseline
link encryption (IDE) / secure-session establishment without
confidential device-assignment.

That tsm.git#next goal still needs follow-on patches like the following
to settle:

Alexey Kardashevskiy (1):
      PCI/IDE: Initialize an ID for all IDE streams

Xu Yilun (1):
      PCI/IDE: Add Address Association Register setup for downstream MMIO

...but otherwise the core infrastructure is ready to support IDE
establishment via a platform TSM.

Next steps:
-----------
- Stage at least one vendor ->connect() implementation on top of a
  tsm.git#staging snapshot, for integration testing.

- Additionally get at least one vendor ->connect() implementation queued
  in an arch tree for linux-next in time for v6.19, otherwise
  tsm.git#next may need to wait for v6.20.

Updated Cover letter:
---------------------

Trusted execution environment (TEE) Device Interface Security Protocol
(TDISP) is a chapter name in the PCI Express Base Specification (r7.0).
It describes an alphabet soup of mechanisms, SPDM, CMA, IDE, TSM/DSM,
that system software uses to establish trust in a device and assign it
to a confidential virtual machine (CVM). It is a protocol for
dynamically extending the Trusted Computing Boundary (TCB) of a CVM with
a PCI device interface enabled to issue DMA to CVM private memory.

The acronym soup problem is extended by each platform architecture
having distinct TEE Security Manager (TSM) API implementations /
capabilities, and each endpoint Device Security Manager (DSM) having its
own idiosyncratic behaviors and requirements around TDISP state
transitions.

Despite all that opportunity for differentiation, there is a significant
portion of the implementation that is cross-vendor common. The PCI/TSM
extension of the PCI core subsystem is a library for TSM drivers to
establish link encryption and enable device access to confidential
memory.

This foundational phase is focused on host-side link encryption, the
next phase focuses on guest-side locking and accepting devices, the
phase after that focuses on all the host-side setup for private DMA and
private MMIO. There are more phases beyond that, like device
attestation, but the goal is upstream manageable incremental steps that
provide tangible value to Linux at each step.

Dan Williams (9):
  coco/tsm: Introduce a core device for TEE Security Managers
  PCI/IDE: Enumerate Selective Stream IDE capabilities
  PCI: Introduce pci_walk_bus_reverse(), for_each_pci_dev_reverse()
  PCI/TSM: Establish Secure Sessions and Link Encryption
  PCI: Add PCIe Device 3 Extended Capability enumeration
  PCI: Establish document for PCI host bridge sysfs attributes
  PCI/IDE: Add IDE establishment helpers
  PCI/IDE: Report available IDE streams
  PCI/TSM: Report active IDE streams

 drivers/pci/Kconfig                           |  18 +
 drivers/virt/coco/Kconfig                     |   3 +
 drivers/pci/Makefile                          |   2 +
 drivers/virt/coco/Makefile                    |   1 +
 Documentation/ABI/testing/sysfs-bus-pci       |  51 ++
 Documentation/ABI/testing/sysfs-class-tsm     |  19 +
 .../ABI/testing/sysfs-devices-pci-host-bridge |  45 ++
 Documentation/driver-api/pci/index.rst        |   1 +
 Documentation/driver-api/pci/tsm.rst          |  21 +
 drivers/pci/pci.h                             |  21 +
 include/linux/device/bus.h                    |   3 +
 include/linux/pci-doe.h                       |   4 +
 include/linux/pci-ide.h                       |  81 +++
 include/linux/pci-tsm.h                       | 159 +++++
 include/linux/pci.h                           |  28 +
 include/linux/tsm.h                           |  14 +
 include/uapi/linux/pci_regs.h                 |  89 +++
 drivers/base/bus.c                            |  38 ++
 drivers/pci/bus.c                             |  38 ++
 drivers/pci/doe.c                             |   2 -
 drivers/pci/ide.c                             | 592 ++++++++++++++++
 drivers/pci/pci-sysfs.c                       |   4 +
 drivers/pci/probe.c                           |  29 +-
 drivers/pci/remove.c                          |   6 +
 drivers/pci/search.c                          |  62 +-
 drivers/pci/tsm.c                             | 643 ++++++++++++++++++
 drivers/virt/coco/tsm-core.c                  | 165 +++++
 MAINTAINERS                                   |   7 +-
 28 files changed, 2133 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
 create mode 100644 Documentation/driver-api/pci/tsm.rst
 create mode 100644 include/linux/pci-ide.h
 create mode 100644 include/linux/pci-tsm.h
 create mode 100644 drivers/pci/ide.c
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 drivers/virt/coco/tsm-core.c


base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.51.0


