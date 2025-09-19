Return-Path: <linux-pci+bounces-36481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6E2B89DE8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C663A9FD2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6330F80D;
	Fri, 19 Sep 2025 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eza1yQSB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F277260578
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291758; cv=none; b=YXqLNpQ5zVvEqCvJQN8cMzseOr8OyqGdsUiW8pFiYXl6U2nfZ9xZTsViMrZHTHxU9edFzoTVpuNORjBtX6UI5tgNRLGODIFArwmoCfcC3fvq0zq7ltvDr7wkP9NGeXubDgzyo+2NpE2waBPTsw8tb4ZMy7tGHYgtTfGTPNwLQW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291758; c=relaxed/simple;
	bh=BUq+OcJpOkKlbZg8E+D5LdcKMhpK5oGcYzGZCTNVeAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ktXPl4PrVv4XAPDjlYhPYMh7jXLPIM8MaODGXCXMBhr0jm+1wA57jJ90Hp0P5RQECfB7TnUx5z1XzDnOPpObFR/0WKogF+dkz5Th7G9rWzrNsN1uGyi4eEy31Gf5D3LxkFQ6F6Wcg1yChFt2hTfZI3nAmHSgqNIC2gacszMvMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eza1yQSB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291756; x=1789827756;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BUq+OcJpOkKlbZg8E+D5LdcKMhpK5oGcYzGZCTNVeAM=;
  b=Eza1yQSBu+R1sl8UempGhx98ltXvLGxCjE5Hzpp8J9A91DRXTuiQhg7v
   hCilC+1unE/W3ZqsYZ+WXUnZqMJjmBTxkToLHNuZ1VHWlhuKBIJSPvj1B
   m13IR3yEQry7W9c/C5TqYpMqa7YF9fGOmgNM1mZgi0rwBONEvBn65Nwr5
   yE4/28E5TG05gckbOliAn2kQTOmWIRmp4Eo+cnq4SdJ8Bofdl0clUlWvF
   maNyk4piTLGtgPwx50ZldAk55/tOS5E5+fknKQrbePZYcZra13XnVrXIV
   Uzwqa9fTZkB10wcNdReOp0VUi52gmdKcNG0tpofEsH42nHgRDF5IS8Akw
   w==;
X-CSE-ConnectionGUID: rC82DAUqQsm122jSnqs1mg==
X-CSE-MsgGUID: ZMB8xYCZQIqq4czPS/BsBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750496"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750496"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:35 -0700
X-CSE-ConnectionGUID: LwlgSO5GSVSAEebtqlvdJA==
X-CSE-MsgGUID: eYZbaOMhSw2MXi/TEYOafw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176654985"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Dave Jiang <dave.jiang@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH 00/27] PCI/TSM: TDX Connect: SPDM Session and IDE Establishment
Date: Fri, 19 Sep 2025 07:22:09 -0700
Message-ID: <20250919142237.418648-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a PCI/TSM low-level driver implemenation for TDX Connect (the TEE
I/O architecture for Intel platforms). Recall that PCI/TSM [1] is the
Linux PCI core subsystem for interfacing with platform Trusted Execution
Environment (TEE) Security Managers (TSMs). TSMs establish secure
sessions with PCIe devices (SPDM over Data Object Exchange (DOE)
mailboxes) and establish PCIe link Integrity and Data Encryption (IDE).

The motivation for sending this out as an RFC with open TODOs beyond
"release early, release often" is:

- Get out of the phase of PCI/TSM core updates being done with only
  samples/devsec/ testing, i.e. avoid regressions like [2]

- Enable better collaboration on follow on common infrastructure like
  address association setup

- Take another step closer to the "at least two vendor implementations
  in #staging" threshold in a potential first intercept of v6.19.

This SPDM and IDE facility is enabled with TDX via a new capability
called a TDX Module Extension. An extension, as might be expected, is a
family of new seamcalls. Unlike typical base module seamcalls, an
extension supports preemptible calls for long running flows like SPDM
session establishment. This extension capability was added in response
to Intel Linux team feedback and in support of reducing the complexity
of the Linux implementation. The result is sequences like the following:

        guard(mutex)(&tdx_ext_lock);
        do {
                r = tdh_spdm_connect(tlink->spdm_id, tlink->spdm_conf,
                                     tlink->in_msg, tlink->out_msg,
                                     dev_info, &out_msg_sz);
                ret = tdx_link_event_handler(tlink, r, out_msg_sz);
        } while (ret == -EAGAIN);

...where tdh_spdm_connect() is a seamcall that may return early if this
CPU takes a hardirq or if the module needs a DOE message marshalled to
the device. tdx_link_event_handler() marshals the message and the
extension is resumed to continue the flow. In this case the TDX Connect
extension supports 1 caller at a time, think of it like a queue-depth of
one device-firmware command queue, so concurrency is managed with
@tdx_ext_lock.

This series and its base commit are available in tsm.git#tdx [3]. The
base commit includes devsec-20250911 and two in progress proposals,
"always enable VMX", and "refactor TDX CPU enabling into tdx_enable()".
I am holding off on putting this series in #staging because that VMX
work also includes an untested proposed cleanup to AMD SVM. If someone
has cycles to test this commit on AMD it would be greatly appreciated:

9d5a519d61d3 x86/boot, KVM: SVM: Move enabling/disabling SVM to CPU startup/shutdown phase

Not posting those proposals for now to focus on the PCI/TSM aspects of
this and save the deeper KVM implications of "TDX Host Services", for a
later time.

[1]: PCI/TSM: Core infrastructure for PCI device security (TDISP)
     http://lore.kernel.org/20250911235647.3248419-1-dan.j.williams@intel.com
[2]: http://lore.kernel.org/eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=tdx

Chao Gao (1):
  coco/tdx-host: Introduce a "tdx_host" device

Dave Jiang (3):
  ACPICA: Add KEYP table definitions
  acpi: Add KEYP support to fw_table parsing
  acpi: Add KEYP Key Configuration Unit parsing

Lu Baolu (2):
  iommu/vt-d: Cache max domain ID to avoid redundant calculation
  iommu/vt-d: Reserve the MSB domain ID bit for the TDX module

Xu Yilun (16):
  x86/virt/tdx: Move bit definitions of TDX_FEATURES0 to public header
  coco/tdx-host: Support Link TSM for TDX host
  x86/virt/tdx: Move tdx_errno.h from KVM to public place
  x86/virt/tdx: Add tdx_page_array helpers for new TDX Module objects
  TODO: x86/virt/tdx: Read TDX global metadata for TDX Module Extensions
  x86/virt/tdx: Add tdx_enable_ext() to enable of TDX Module Extensions
  TODO: x86/virt/tdx: Read TDX Connect global metadata for TDX Connect
  x86/virt/tdx: Extend tdx_page_array to support IOMMU_MT
  iommu/vt-d: Export a helper to do function for each dmar_drhd_unit
  coco/tdx-host: Setup all trusted IOMMUs on TDX Connect init
  coco/tdx-host: Add connect()/disconnect() handlers prototype
  PCI: iov: Export pci_iov_virtfn_bus()
  PCI/IDE: Add helpers for RID/Addr Association Registers setup
  PCI/IDE: Export pci_ide_domain()
  x86/virt/tdx: Add SEAMCALL wrappers for IDE stream management
  coco/tdx-host: Implement IDE stream setup/teardown

Zhenzhong Duan (5):
  x86/virt/tdx: Add SEAMCALL wrappers for TDH.EXT.MEM.ADD and
    TDH.EXT.INIT
  x86/virt/tdx: Add SEAMCALL wrappers for trusted IOMMU setup and clear
  coco/tdx-host: Add a helper to exchange SPDM messages through DOE
  x86/virt/tdx: Add SEAMCALL wrappers for SPDM management
  coco/tdx-host: Implement SPDM session setup

 arch/x86/include/asm/tdx.h                    |  58 ++
 arch/x86/{kvm/vmx => include/asm}/tdx_errno.h |   8 +-
 arch/x86/include/asm/tdx_global_metadata.h    |  14 +
 arch/x86/kvm/vmx/tdx.h                        |   1 -
 arch/x86/virt/vmx/tdx/tdx.c                   | 731 +++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h                   |  17 +-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  32 +
 drivers/acpi/Kconfig                          |  12 +
 drivers/acpi/Makefile                         |   2 +
 drivers/acpi/pci_root.c                       |   2 +
 drivers/acpi/tables.c                         |  14 +-
 drivers/acpi/x86/keyp.c                       | 118 +++
 drivers/iommu/intel/dmar.c                    |  44 +
 drivers/iommu/intel/iommu.c                   |  10 +-
 drivers/iommu/intel/iommu.h                   |   1 +
 drivers/pci/ide.c                             |   3 +-
 drivers/pci/iov.c                             |   1 +
 drivers/virt/coco/Kconfig                     |   2 +
 drivers/virt/coco/Makefile                    |   1 +
 drivers/virt/coco/tdx-host/Kconfig            |  17 +
 drivers/virt/coco/tdx-host/Makefile           |   1 +
 drivers/virt/coco/tdx-host/tdx-host.c         | 942 ++++++++++++++++++
 include/acpi/actbl3.h                         |  60 ++
 include/linux/acpi.h                          |  16 +
 include/linux/dmar.h                          |   2 +
 include/linux/fw_table.h                      |   1 +
 include/linux/gfp.h                           |   2 +
 include/linux/mm.h                            |   2 +
 include/linux/pci-ide.h                       |  15 +
 lib/fw_table.c                                |   9 +
 30 files changed, 2121 insertions(+), 17 deletions(-)
 rename arch/x86/{kvm/vmx => include/asm}/tdx_errno.h (87%)
 create mode 100644 drivers/acpi/x86/keyp.c
 create mode 100644 drivers/virt/coco/tdx-host/Kconfig
 create mode 100644 drivers/virt/coco/tdx-host/Makefile
 create mode 100644 drivers/virt/coco/tdx-host/tdx-host.c


base-commit: 0d1fbc1f1b7a3c8b14a643303dd89bcc82d3fbd0
-- 
2.51.0


