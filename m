Return-Path: <linux-pci+bounces-6173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F52B8A2A2A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 11:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174271F22AB6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8441F50A88;
	Fri, 12 Apr 2024 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRC4/W++"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F8C537EE
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911906; cv=none; b=Q22dk4qryyKNU5Y2w3EKyQ6H0M1O0qIfHXn81XAurokvqqYp08Lg5/68UwPPD5uRPl5ThOqjCqTUxyFiiuPE+n5z+orm7cq+bwl/U6082FecUYl3Oi+ow9ek7fuVc2fk9slj9m5Fb5pUhwgp8OHQeS3QOnccUQZ+VJkGpkLRTPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911906; c=relaxed/simple;
	bh=qDcp4lyReDJ40MmcSzMB7x5FG1dP6FNsaEiiicdIDeU=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=AUngM71EibYXHjFCed/+NmaftelhL3Xvu3xIq+72rDQ0J22PD76K+tdOD1hetDjC6zyoE1uBIk20hGGFRpSZJXVVOH2TOyV45jihiLMtxSfmrdR9PvKRkqb0vfIsAThD7CVwPWV6ohc9GKzGQzkfECgihr3Htc+MeD34LxIGOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRC4/W++; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712911904; x=1744447904;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qDcp4lyReDJ40MmcSzMB7x5FG1dP6FNsaEiiicdIDeU=;
  b=IRC4/W++MNyHH+dOXnufisqjVtVzHU4fZg6gBokEiAqlHmV2RCkM/1o3
   hVRUB1nNtfYl6QxAJnvF4hWd9csKCJxLGK1b+dGpR0TmmAEhPijkUqax8
   KLDFbEjLnB74pvwcXkPVDs02EiUBi8j9+sqwhmx7zx6rTyxk4Uwe5G4Cv
   spedUfEhtXn+VFOQe7wztGOMWE/YgXFPMOj5wm8uvJ15LNeumzr4KMHE3
   hD18QGTqbeuS3Jyr7fuQ+9+iYNzatbfEqV94TGhyaNPTfi3w58RCRcKO0
   m+NwefxxvYvuyFizyVMbwh3TMiLWrcpC+phmFZFARbeHWiG8Rn1lrKwk4
   Q==;
X-CSE-ConnectionGUID: ZVPjomNpQHmACG2pR8gcPg==
X-CSE-MsgGUID: QZAnDZo1R0Ka5GFXWF3Hvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="25815280"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="25815280"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:51:44 -0700
X-CSE-ConnectionGUID: DscWwm+9RVq41CXGFW9CNA==
X-CSE-MsgGUID: ViZA8zDrRYGf9XRoJ8WkcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21751058"
Received: from aclausch-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.15.202])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:51:44 -0700
Subject: [RFC PATCH v2 0/6] Towards a shared TSM sysfs-ABI for Confidential
 Computing
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Lukas Wunner <lukas@wunner.de>,
 Wu Hao <hao.wu@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
 Yilun Xu <yilun.xu@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 John Allen <john.allen@amd.com>, bhelgaas@google.com, kevin.tian@intel.com,
 gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, lukas@wunner.de
Date: Fri, 12 Apr 2024 01:51:43 -0700
Message-ID: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Here is a revised attempt at creating a shared sysfs-ABI for the concept
of a TSM (TEE Security Manager) as described by PCIe TDISP (PCIe 6.2
Section 11 TEE Device Interface Security Protocol). It remains an RFC
until at least one vendor (Intel, AMD, Rivos...) completes integration
with their low level TSM driver. I am actively working on that with Hao
Wu and Yilun Xu, but if another vendor adopts this before us, great.

Changes since v1: [1]
* Major simplifications:
  * Drop the 'struct pci_tsm_req' concept (Yilun), but keep a common
    @exec entry point from the PCI core to the low level driver.
  * Drop Link IDE and related sysfs attributes (Alexey). This
    sophistication may come back later, but no need to tackle that
    complexity now.
  * Move policy choice of requiring native CMA before TSM connection
    to userspace policy. This removes the need to build on top of the
    moving CMA baseline, and these series can now be considered on
    indpendent timelines.
* Create a guest/ vs host/ split in drivers/virt/coco/ (Sathya)
* Require a parent device for the common TSM class device (Jonathan)
* Create a 'tdx' virtual bus and 'tdx_tsm' device to parent the TSM
  class device
* Create a 'tdx_tsm' for the low-level TDX calls
* Rebase on v6.9-rc1 that includes a DEFINE_SYSFS_GROUP_VISIBLE()
* Cleanup usage of __free() to match the proposed style guide [2]
  (Jonathan)
* Cleanup, clarifications, and fixes (Kevin)
* Improve the cover letter prose below (Bjorn, Kevin)

[1]: http://lore.kernel.org/r/170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com
[2]: http://lore.kernel.org/r/171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com

Confidential Computing (CC) introduces the concept of hardware protected
(integrity and confidentiality) guest private memory. The next phase of
that journey is private memory access for guest assigned devices. To
date, assigned devices for CC guests are constrained to accessing shared
memory, unprotected clear-text memory. That mode incurs a bounce buffer
performance penalty as every DMA (direct-memory-access) performed by the
device must be later copied from shared-to-private memory for
device-write and private-to-shared copies for device-reads.

The PCIe TEE Device Interface Security Protocol (TDISP) arranges for
devices to be permitted to DMA to private memory directly, but it
requires significant infrastructure to authenticate, validate, and
provision a virtual-device interface to be used in CC guest.

TDISP specifies a TEE Security Manager (TSM) as a platform agent that
can manage the IOMMU, PCI host, and endpoint Device Security Manager
capabilities to convert an guest assigned device (physical function or
sriov-virtual function) into private mode operation.

What follows is common shared infrastructure for the PCI core to
interface with the platform TSM and a TDX as an example low level
consumer of these core capabilities.

Enable the PCI core to export a "connect" verb via sysfs for a given
device which, when the low level platform implementation is added,
arranges for the device to be authenticated and its link protected by
encryption and integrity checks.

---

Dan Williams (6):
      configfs-tsm: Namespace TSM report symbols
      coco/guest: Move shared guest CC infrastructure to drivers/virt/coco/guest/
      x86/tdx: Introduce a "tdx" subsystem and "tsm" device
      coco/tsm: Introduce a class device for TEE Security Managers
      PCI/TSM: Authenticate devices via platform TSM
      tdx_tsm: TEE Security Manager driver for TDX


 Documentation/ABI/testing/sysfs-bus-pci |   46 +++++
 MAINTAINERS                             |    7 +
 arch/x86/include/asm/shared/tdx.h       |    3 
 arch/x86/virt/vmx/tdx/tdx.c             |   70 ++++++++
 drivers/pci/Kconfig                     |   13 +
 drivers/pci/Makefile                    |    2 
 drivers/pci/pci-sysfs.c                 |    4 
 drivers/pci/pci.h                       |   10 +
 drivers/pci/probe.c                     |    1 
 drivers/pci/remove.c                    |    1 
 drivers/pci/tsm.c                       |  270 +++++++++++++++++++++++++++++++
 drivers/virt/coco/Kconfig               |    8 -
 drivers/virt/coco/Makefile              |    3 
 drivers/virt/coco/guest/Kconfig         |    7 +
 drivers/virt/coco/guest/Makefile        |    2 
 drivers/virt/coco/guest/tsm_report.c    |   32 ++--
 drivers/virt/coco/host/Kconfig          |   12 +
 drivers/virt/coco/host/Makefile         |    8 +
 drivers/virt/coco/host/tdx_tsm.c        |   68 ++++++++
 drivers/virt/coco/host/tsm-core.c       |  131 +++++++++++++++
 drivers/virt/coco/sev-guest/sev-guest.c |    8 -
 drivers/virt/coco/tdx-guest/tdx-guest.c |    8 -
 include/linux/pci-tsm.h                 |   80 +++++++++
 include/linux/pci.h                     |   11 +
 include/linux/tsm.h                     |   31 ++--
 include/uapi/linux/pci_regs.h           |    4 
 26 files changed, 795 insertions(+), 45 deletions(-)
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 drivers/virt/coco/guest/Kconfig
 create mode 100644 drivers/virt/coco/guest/Makefile
 rename drivers/virt/coco/{tsm.c => guest/tsm_report.c} (92%)
 create mode 100644 drivers/virt/coco/host/Kconfig
 create mode 100644 drivers/virt/coco/host/Makefile
 create mode 100644 drivers/virt/coco/host/tdx_tsm.c
 create mode 100644 drivers/virt/coco/host/tsm-core.c
 create mode 100644 include/linux/pci-tsm.h

base-commit: 4cece764965020c22cff7665b18a012006359095

