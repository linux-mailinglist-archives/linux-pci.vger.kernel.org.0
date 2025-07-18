Return-Path: <linux-pci+bounces-32526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E137B0A159
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 12:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFB1188BC56
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 10:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81F2BD00C;
	Fri, 18 Jul 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8irAvlZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC61FBC90;
	Fri, 18 Jul 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836240; cv=none; b=k/YkWPz292LMuggI+GX1nAOTru6OmQLc0hUXv8vM2WJpmYKP+8JC1oOUk5Hgi60TC4dmUE6Vz5TQDChMv2kj/1c6saSnmtd5DFPkSulX4OVs/ZgWUrnsgvOR1E/kqHeKneNCvHjBJjPlGodgxjChMinnWD93GHsckuUCq+thyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836240; c=relaxed/simple;
	bh=egDvUDaR9VMobj3jfwGG9Y6MP3GzIIQobcEHCHjRoKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gIcn7ZtiS7uyEq6pX566SpldbGqmPthZEzBSf+7PAVJCjUoBTXHO9DnGPl+TNbVNv5DtXEPitm+PbOtDeZ+n1r6ujxzlVTocUF30TFnUHr68EIeKyuS0iEPKhmtAtV8uS/HMVdvMZGaJ1q5wGm/1yfwKptKMOpHg221B6zeHalo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8irAvlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89909C4CEEB;
	Fri, 18 Jul 2025 10:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752836240;
	bh=egDvUDaR9VMobj3jfwGG9Y6MP3GzIIQobcEHCHjRoKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=j8irAvlZiYSO4cwJITR2b2jVJy7ab50Eti2L3b9ZTlfZx20T4QQAz8FWx/lL03g2I
	 vxYdlYMcpFwRYO1bqmZRm0JRY2J67aqhDEjdFmUu2LYM2iPNlh2yAIi0r6kSxeUWmE
	 s1I4/3ff7zpYI7MrNxNWhkoJgsqTHD1ZDOEZLy36P82yp2mbNNIYMun2/nXTjZ9iHn
	 xFS5zo26AMHeJRB/erjdvpgI6p/1QYDHGRtLNO/16ixASKu/uNeEfo00+dBNiyiruX
	 dJTRPZi5GxvYUJSKTVhQ+eZd2T61JZ3MeB8UkVGNz43pmz+kJcJaBKGWLHeGgPU9q4
	 Fccis0Pcu4iZA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de,
	Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	John Allen <john.allen@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yi lun <yilun.xu@linux.intel.com>,
	Yilun Xu <yilun.xu@intel.com>
Subject: Re: [PATCH v4 00/10] PCI/TSM: Core infrastructure for PCI device
 security (TDISP)
In-Reply-To: <20250717183358.1332417-1-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
Date: Fri, 18 Jul 2025 16:27:11 +0530
Message-ID: <yq5ah5z922d4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dan Williams <dan.j.williams@intel.com> writes:

> Changes since v3 [1]:
> - Move the TSM core out of the host/ subdirectory since it is shared
>   with the guest (Aneesh)
> - Support multiple simultaneous TSM providers (Jason, Alexey)
> - Do not reuse the "connect" operation for both Link and Security state
>   management (Aneesh, Alexey)
> - Derive the pci_tsm instance type from details in the @pdev or @dsm
>   properties (Aneesh)
> - Delay TSM association until ->connect(), results in removing the need
>   for the @state attribute
> - Introduce reverse iterators for all PCI bus and function walking.
> - Move all per-device context setup/teardown to
>   pci_tsm_(constructor,destructor)
> - Add pci_ide_stream_release() for scope-based cleanup of IDE setup
> - Shorten the name of the "stream" sysfs link (Jonathan)
> - misc fixups (Jonathan)
> - Note creation of pci_host_bridge_type in changelog (Jonathan)
> - Drop now unused PREP_PCI_IDE_SEL_ADDR1() and related macros (Jonathan)
> - Open code PREP_PCI_IDE_SEL_RID_2 in its only caller (Jonathan)
> - Clarify the specification Stream term from a Linux "stream" object
>   (Jonathan)
> - Convert samples/devsec/ to faux device (Jonathan)
> - Drop Date: from ABI entries
> - Add basic driver-api documentation to build kdoc
> - Switch to ACQUIRE()
> - Add an explicit 'disconnect' attribute
> - Clarify the PCI_IDE_STREAM_MAX Kconfig help (Jonathan)
> - Use unsigned variables from sel_ide_offset (Jonathan)
>
> [1]: http://lore.kernel.org/20250516054732.2055093-1-dan.j.williams@intel=
.com
>
> This set is available at tsm.git#staging (rebasing branch) or
> tsm.git#devsec-20250717 (immutable tag). It passes a basic that
> exercises load/unload of the samples/devsec/ modules and
> connect/disconnect of the emulated device.
>
> Status (complexity reductions):
> -------------------------------
>
> Between the support for multiple TSMs, the split of "Link" and
> "Security" operations and inferring the type of 'struct pci_tsm' context
> from its properties, the implementation shed complexity.
>
> Now, ->probe() is only called in the sysfs::connect_store() path which
> means that there is no need to track the PCI_TSM_INIT and
> PCI_TSM_CONNECT states. Simply, when a Device Security Manager (DSM) is
> connected, at that point all potential TDIs (assignable functions where
> the DSM can manage its security state) are probed.
>
> Now, initial determination of when the "tsm/" sysfs group appears
> follows typical expectations. If at least one TSM device has been
> registered prior to a DSM device being scanned, its "tsm/" attribute
> group will appear. No more need for a pci_tsm_init() call via
> pci_init_capabilities().
>
> The pci_tsm_destroy() path is now simply arranging for
> pci_tsm_disconnect() of all DSMs after all TDIs have gone through
> ->remove() callback. This is accomplished with new "reverse" iterators
> for all PCI bus walks.
>
> Next steps:
> -----------
> The campaign to graduate this out of tsm.git#staging and into mainline
> starts in earnest when samples/devsec/ + 1 vendor implementation, or 2
> vendor implementations can demonstrate the end-to-end flow (minus
> attestation). That is the "consensus" event horizon where prior to that
> it seems reasonable for impacted subsystem maintainers to opt-out of
> reviewing all the fine details under debate. Suffice to say there are a
> lot of fine details flying around.
>
> To that end I expect it would help to have a tracking document in
> tsm.git#staging that catalogs the open debates and the current leanings
> of the staging tree. That is next in the hopper.
>
> Original Cover letter:
> ----------------------
>
> Trusted execution environment (TEE) Device Interface Security Protocol
> (TDISP) is a chapter name in the PCI specification. It describes an
> alphabet soup of mechanisms, SPDM, CMA, IDE, TSM/DSM, that system
> software uses to establish trust in a device and assign it to a
> confidential virtual machine (CVM). It is protocol for dynamically
> extending the trusted computing boundary (TCB) of a CVM with a PCI
> device interface that can issue DMA to CVM private memory.
>
> The acronym soup problem is enhanced by every major platform vendor
> having distinct TEE Security Manager (TSM) API implementations /
> capabilities, and to a lesser extent, every potential endpoint Device
> Security Manager (DSM) having its own idiosyncratic behaviors around
> TDISP state transitions.
>
> Despite all that opportunity for differentiation, there is a significant
> portion of the implementation that is cross-vendor common. However, it
> is difficult to develop, debate, test and settle all those pieces absent
> a low level TSM driver implementation to pull it all together.
>
> The proposal, of which this set is the first phase, is incrementally
> develop the shared infrastructure on top of a sample TSM driver
> implementation to enable clean vendor agnostic discussions about the
> commons. "samples/devsec/" is meant to be: just enough emulation to
> exercise all the core infrastructure, a reference implementation, and a
> simple unit test. The sample also enables coordination with the native
> PCI device security effort [2].
>
> [2]: http://lore.kernel.org/cover.1719771133.git.lukas@wunner.de
>
> Dan Williams (10):
>   coco/tsm: Introduce a core device for TEE Security Managers
>   PCI/IDE: Enumerate Selective Stream IDE capabilities
>   PCI: Introduce pci_walk_bus_reverse(), for_each_pci_dev_reverse()
>   PCI/TSM: Authenticate devices via platform TSM
>   samples/devsec: Introduce a PCI device-security bus + endpoint sample
>   PCI: Add PCIe Device 3 Extended Capability enumeration
>   PCI/IDE: Add IDE establishment helpers
>   PCI/IDE: Report available IDE streams
>   PCI/TSM: Report active IDE streams
>   samples/devsec: Add sample IDE establishment
>
>  Documentation/ABI/testing/sysfs-bus-pci       |  51 ++
>  Documentation/ABI/testing/sysfs-class-tsm     |  19 +
>  .../ABI/testing/sysfs-devices-pci-host-bridge |  29 +
>  Documentation/driver-api/pci/index.rst        |   1 +
>  Documentation/driver-api/pci/tsm.rst          |  12 +
>  MAINTAINERS                                   |   7 +-
>  drivers/base/bus.c                            |  38 +
>  drivers/pci/Kconfig                           |  28 +
>  drivers/pci/Makefile                          |   2 +
>  drivers/pci/bus.c                             |  37 +
>  drivers/pci/ide.c                             | 578 ++++++++++++++
>  drivers/pci/pci-sysfs.c                       |   4 +
>  drivers/pci/pci.h                             |  17 +
>  drivers/pci/probe.c                           |  25 +-
>  drivers/pci/remove.c                          |   3 +
>  drivers/pci/search.c                          |  63 +-
>  drivers/pci/tsm.c                             | 554 ++++++++++++++
>  drivers/virt/coco/Kconfig                     |   3 +
>  drivers/virt/coco/Makefile                    |   2 +
>  drivers/virt/coco/tsm-core.c                  | 198 +++++
>  include/linux/device/bus.h                    |   3 +
>  include/linux/pci-ide.h                       |  72 ++
>  include/linux/pci-tsm.h                       | 158 ++++
>  include/linux/pci.h                           |  36 +
>  include/linux/tsm.h                           |  15 +
>  include/uapi/linux/pci_regs.h                 |  89 +++
>  samples/Kconfig                               |  16 +
>  samples/Makefile                              |   1 +
>  samples/devsec/Makefile                       |  10 +
>  samples/devsec/bus.c                          | 711 ++++++++++++++++++
>  samples/devsec/common.c                       |  26 +
>  samples/devsec/devsec.h                       |  40 +
>  samples/devsec/tsm.c                          | 241 ++++++
>  33 files changed, 3078 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
>  create mode 100644 Documentation/driver-api/pci/tsm.rst
>  create mode 100644 drivers/pci/ide.c
>  create mode 100644 drivers/pci/tsm.c
>  create mode 100644 drivers/virt/coco/tsm-core.c
>  create mode 100644 include/linux/pci-ide.h
>  create mode 100644 include/linux/pci-tsm.h
>  create mode 100644 samples/devsec/Makefile
>  create mode 100644 samples/devsec/bus.c
>  create mode 100644 samples/devsec/common.c
>  create mode 100644 samples/devsec/devsec.h
>  create mode 100644 samples/devsec/tsm.c
>
>
> base-commit: df877487cac3509cbae2625181e7ad6748afed24

This series currently doesn=E2=80=99t include the TDI bind equivalent.
Incorporating some of the changes from patch [1] would help lay the
groundwork for submitting the remaining POC patches.

Also, could you clarify the purpose of sec_probe and sec_remove? How are
they being used?

[1] https://lore.kernel.org/all/20250516054732.2055093-13-dan.j.williams@in=
tel.com

-aneesh

