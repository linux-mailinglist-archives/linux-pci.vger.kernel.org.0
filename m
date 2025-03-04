Return-Path: <linux-pci+bounces-22810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55D2A4D49C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D190165A19
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF401F75A9;
	Tue,  4 Mar 2025 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdau4J4r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE91FBC8A
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072458; cv=none; b=swR0alpjBOAIWgK7J+O2VS8Px7ma4XxstNxGVKnYNYRPKPVOL+tkzQHrP91o+eGgQ+mY/ahwaj+eKRXj3IQIzxBdxU+CkruB7QSqcKEuXrS9qkxZcN1i4NYHK0cFnD2uqRZQpTENQ55X9wltUWCerx2U70prsU63nWv9+gQD7d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072458; c=relaxed/simple;
	bh=2P/ln9lrhKSlXuf6pNo4cqYdV2q/s4L0PRH305lE+H4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=E9vf6FWIwksF2U/Pf6yKn+zbHjKTxo/unj6d5RRENkGhItpKVk44tALph/8COItYs8pLiWL9MUh4Gv+9OdA9b7PEDUZY6vGwMS5Jg5CZTkV1yYq8cUgZFOTiM+eiM/Apsz5RZV2vK2sM7kHt1Fw0wtmja/v7uBpeLgujgvJTK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdau4J4r; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741072457; x=1772608457;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2P/ln9lrhKSlXuf6pNo4cqYdV2q/s4L0PRH305lE+H4=;
  b=kdau4J4rtypume6waqkY9DgncE529QwVteQb/Hb0KoqjISlB1QOE3h23
   kblAM0MgxJ4qlMxKg4rj25waf2ob8Je4i7mhY3/o0snIztf6S/OAf8KL6
   rPwMJV8foyXO6Aw3UIlkPQRa71mcTi1lHPhEx70Boj2rvofACmDEOm4Jy
   rSGil7Edoa3ZWPXAVsm/8a0nhO2IfS9DV0C70j8vBkN7j3QncgojCrH9E
   CeDTZTHU69PGD4Knu5WBcGi7hsnXQDXj3NZ9SUhj5coPQpLut0TI6D8va
   Fc+lmilAYJeEoKo6OLD7t1WEjGPoOVBhg5PY9w3hCNUSHzI2XOQU+FNNr
   w==;
X-CSE-ConnectionGUID: Vh4o+t6CRmGuq8sH1llWAg==
X-CSE-MsgGUID: Tpn8jgQKRp+tYdAYvK6Q5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41224006"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41224006"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:14:15 -0800
X-CSE-ConnectionGUID: pjHCIlK8R+OvdWytjYcmEg==
X-CSE-MsgGUID: x1escmBoSSal0Mq4eL4N3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118078470"
Received: from inaky-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.47])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:14:14 -0800
Subject: [PATCH v2 00/11] PCI/TSM: Core infrastructure for PCI device
 security (TDISP)
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Wu Hao <hao.wu@intel.com>, Samuel Ortiz <sameo@rivosinc.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Sami Mujawar <sami.mujawar@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Steven Price <steven.price@arm.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yilun Xu <yilun.xu@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 John Allen <john.allen@amd.com>,
 Ilpo =?utf-8?b?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, aik@amd.com,
 lukas@wunner.de
Date: Mon, 03 Mar 2025 23:14:14 -0800
Message-ID: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Changes since v1 [1]:
 - [configfs-tsm: Namespace TSM report symbols]
   - collect tags
 - [coco/guest: Move shared guest CC infrastructure to drivers/virt/coco/guest/]
   - collect tags
 - [coco/tsm: Introduce a core device for TEE Security Managers]
   - Rename 'tsm_subsys' => 'tsm_core_dev' (Jonathan)
 - [PCI/IDE: Enumerate Selective Stream IDE capabilities]
   - Fix the reference PCIe 6.2 specification chapter to 7.9.26 (Bjoen)
   - Treat all specification terms as proper nouns, like "Stream ID" (Bjorn)
   - Rename PCI_IDE_LINK_STREAM to PCI_IDE_LINK_STREAM_0 to indicate
     first of a series (Jonathan)
   - Stop saving sel_ide_cap in pci_dev as it is not a capability block
     (Jonathan)
   - Add support for the "Configuration cycles over Selective Stream"
     mechanism (Alexey, Jonathan)
   - Cache the number of Link Stream register blocks in pci_dev to save
     IDE capability re-reads
   - Clarify 'from Endpoint to Root Port' comment in pci_ide_init()
     (Jonathan)
   - Fix "Number of Selective IDE Streams Supported" 1-based field
     interpretation (Aneesh, Yilun, Jonathan)
   - Switch all register mask definitions to use __GENMASK() to fix
     bugs, cleanup readability, and support usage of FIELD_{PREP,GET}()
     in ide.c (Alexey, Jonathan, Yilun, Aneesh)
 - [PCI/TSM: Authenticate devices via platform TSM]
   - Line wrap documentation, and fixup fidelity to specification
     terminology (Bjorn)
   - Prepare for calling tsm_ops->probe() for Physical Functions beyond
     0 and Virtual Functions, introduce 'struct pci_tsm_pf0' as the
     object to wrap 'struct pci_tsm' in the Physical Function 0 case.
     Call tsm_ops->probe() and tsm_ops->remove() for all functions on a
     device if Physical Function 0 sets pdev->tsm. (Yilun, Aneesh)
   - Drop the complicated 'struct pci_dsm' scheme (Alexey)
   - Fix tsm->state validation, 'init before connect' (Yilun)
   - Move on from if_not_guard(), but not onto the whitespace column
     pressure of scoped_cond_guard() (Jonathan)
   - Rename pci_tsm_register() pci_tsm_core_register() to disambiguate
     from device init in pci_tsm_init() (Jonathan)
 - [samples/devsec: Introduce a PCI device-security bus + endpoint sample]
   - Fix CONFIG_VIRT_DRIVERS=n compilation dependency (0day Kbuild Robot)
   - Switch from a single devm action to remove emulated devices and
     ports to a per-device / per-port scheme (Jonathan)
   - Fix "Number of Selective IDE Streams Supported"
   - Use devm_gen_pool_create() (Jonathan)
 - [PCI: Add PCIe Device 3 Extended Capability enumeration]
 - [PCI/IDE: Add IDE establishment helpers]
   - Drop PCI_IDE_SETUP_ROOT_PORT and its related complications. Push
     Root Port programming responsibility to leaf drivers. (Alexey,
     Jonathan, Bjorn)
   - Clarify that some TSM technologies do not allow system-software to
     allocate the Stream ID (Aneesh)
   - Fundamentally rework the API to stop tying the Stream ID to the
     Endpoint register block index, the Root Port register block index,
     and the platform stream slot. Add pci_ide_strem_alloc() to grab
     those resources and clarify that Stream IDs only need to be unique
     within a Partner Port pairing. The 'struct pci_ide' object is
     updated accordingly to carry all the Partner Port details. (Alexey,
     Jonathan, Aneesh)
   - Add kernel-doc commentary for all exported APIs (Bjorn)
   - Miscellaneous specific terminology fixups and pci.h comment
     cleanups (Bjorn)
   - Drop address association setup for now given the questions around
     its value (Alexey, Yilun)
   - Switch from "devid" to "RID" to match specification language, add a
     comment to address the discrepancy in Linux terms vs PCIe spec
     terms (Bjorn)
   - Setup RID association registers relative to which RIDs are seen at
     either Partner Port (Yilun, Alexey)
 - [PCI/IDE: Report available IDE streams]
   - Rename pci_set_nr_ide_streams() to pci_ide_init_nr_streams() to
     clarify why this one symbols is in the "PCI_IDE" symbol namespace
     since PCI init code is typically built-in. (Alexey)
   - Fix missing quotes in usage of EXPORT_SYMBOL_NS_GPL() and
     MODULE_IMPORT() (Alexey)
 - [PCI/TSM: Report active IDE streams]
   - Documentation fixups (Bjorn)
   - Rename tsm_register_ide_stream() to tsm_ide_stream_register() for
     naming consistency
   - Reflect that the format of the stream link changed from:
     pciDDDD:BB/streamN:DDDD:BB:DD:F
     ...to:
     pciDDDD:BB/streamH.R.E:DDDD:BB:DD:F
 - [samples/devsec: Add sample IDE establishment]
   - Mirror the devsec_tsm_disconnect() sequence in the
     devsec_tsm_connect() error unwind path (Jonathan)
   - Other miscellaneous symmetry on error unwind fixups (Jonathan)

[1]: http://lore.kernel.org/173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com

---
Towards devsec-next:

As evidenced by a full page of change notes from v1 to v2 there is
multi-party interest in this core infrastructure, and more importantly,
many small details to negotiate. That number of details to negotiate
only increases with the follow-on "device bind" flows and the
interactions across VFIO, IOMMUFD and KVM.

I expect it will continue to be the case that the mainline ingestion
rate of all this infrastructure results in several more cycles before
mainline ships a complete solution for one or more vendors. In the
meantime, I am looking to run a devsec-next integration tree for kernel
and QEMU. That is, a supplemental staging tree to enable end-to-end
testing while proposals make their way upstream. For now, consider
sending a branch and I will aim to do periodic octopus merges of
submitted branches on top of a kvm-coco-queue + devsec-core baseline.

The main motivation for a "devsec-next" tree, as I mentioned to some in
the hallway track at Plumbers, is to wrangle private hacks and
workarounds in vendor trees to coalesce if not mature.  An example of
multiple vendors solving the same problem in different ways in their
vendor trees is: [2] vs [3]. Note that devsec-next is not intended to
replace vendor trees, and instead reflect the snapshot state of
cross-vendor consensus before topics are ready for linux-next /
mainline.

I will send out more details as a follow up.

[2]: https://github.com/aik/qemu/commit/5256c41f
[3]: http://lore.kernel.org/20250217081833.21568-1-chenyi.qiang@intel.com

---
Original Cover letter:

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
coordination with the native PCI device security effort [4].
   
The devsec_tsm driver already yielding benefits as it drove many of
the fixes and enhancements of this patch-kit relative to the last RFC
[1]. Future development would either reuse established devsec_tsm paths,
or extend the sample alongside the vendor-specific implementation.
     
This first batch is just enough infrastructure for IDE (link Integrity
and Data Encryption) establishment via TSM APIs. It is based on a review
and curation of the IDE establishment flows from the SEV-TIO RFC [5] and
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

The full series is available via devsec/tsm.git [6].

[4]: http://lore.kernel.org/cover.1719771133.git.lukas@wunner.de
[5]: http://lore.kernel.org/20240823132137.336874-1-aik@amd.com
[6]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=devsec-20250303

---

Dan Williams (11):
      configfs-tsm: Namespace TSM report symbols
      coco/guest: Move shared guest CC infrastructure to drivers/virt/coco/guest/
      coco/tsm: Introduce a core device for TEE Security Managers
      PCI/IDE: Enumerate Selective Stream IDE capabilities
      PCI/TSM: Authenticate devices via platform TSM
      samples/devsec: Introduce a PCI device-security bus + endpoint sample
      PCI: Add PCIe Device 3 Extended Capability enumeration
      PCI/IDE: Add IDE establishment helpers
      PCI/IDE: Report available IDE streams
      PCI/TSM: Report active IDE streams
      samples/devsec: Add sample IDE establishment


 Documentation/ABI/testing/configfs-tsm-report      |    0 
 Documentation/ABI/testing/sysfs-bus-pci            |   45 +
 Documentation/ABI/testing/sysfs-class-tsm          |   20 +
 .../ABI/testing/sysfs-devices-pci-host-bridge      |   44 +
 MAINTAINERS                                        |   10 
 drivers/pci/Kconfig                                |   37 +
 drivers/pci/Makefile                               |    2 
 drivers/pci/ide.c                                  |  499 ++++++++++++++
 drivers/pci/pci-sysfs.c                            |    4 
 drivers/pci/pci.h                                  |   19 +
 drivers/pci/probe.c                                |   26 +
 drivers/pci/remove.c                               |    3 
 drivers/pci/tsm.c                                  |  377 +++++++++++
 drivers/virt/coco/Kconfig                          |    8 
 drivers/virt/coco/Makefile                         |    3 
 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c    |    8 
 drivers/virt/coco/guest/Kconfig                    |    7 
 drivers/virt/coco/guest/Makefile                   |    3 
 drivers/virt/coco/guest/report.c                   |   32 -
 drivers/virt/coco/host/Kconfig                     |    6 
 drivers/virt/coco/host/Makefile                    |    6 
 drivers/virt/coco/host/tsm-core.c                  |  144 ++++
 drivers/virt/coco/sev-guest/sev-guest.c            |   12 
 drivers/virt/coco/tdx-guest/tdx-guest.c            |    8 
 include/linux/pci-ide.h                            |   60 ++
 include/linux/pci-tsm.h                            |  135 ++++
 include/linux/pci.h                                |   25 +
 include/linux/tsm.h                                |   33 +
 include/uapi/linux/pci_regs.h                      |   89 +++
 samples/Kconfig                                    |   16 
 samples/Makefile                                   |    1 
 samples/devsec/Makefile                            |   10 
 samples/devsec/bus.c                               |  698 ++++++++++++++++++++
 samples/devsec/common.c                            |   26 +
 samples/devsec/devsec.h                            |    7 
 samples/devsec/tsm.c                               |  192 ++++++
 36 files changed, 2564 insertions(+), 51 deletions(-)
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

base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6

