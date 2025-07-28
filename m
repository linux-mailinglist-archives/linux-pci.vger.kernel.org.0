Return-Path: <linux-pci+bounces-33032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FFAB13C1C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 15:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C223BE9E0
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F68726AAB2;
	Mon, 28 Jul 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VG35nO+2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D9266EFA;
	Mon, 28 Jul 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710755; cv=none; b=Ofe+8wZv2U8Eac3XazPe5Jl/PvkwVLMClCTm9IeXnNszHCm4cPQqfuWmFbyHL0OViy0lVLQ5etPsVgN4uCLDPb2B27h5Vj6tezStEu1KuYYhcUGIxB14r1eNKOhxkp8RwS4pchJx3/qIwgSzMX87fS5cJLSw8bWVbJDaCkDFvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710755; c=relaxed/simple;
	bh=zkVKVis6HtjW872Oo0WjCeFxIvs5TPmzZSBo1W+o4ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T9ct5SCiM3nBxNP8NVb7xNFIAkAd2sy2R6iftEQm/W9XL/JdGo0UHce2VDzJereVN/R2fu6TBqOEg5Wf1uS0hSBFG93HI+mvVU8pUYdGsBymyFwYSotc0uYmVs2J/OMoYkBtgmOvOmLqzr0pklWdeB+k9inzQ2hES0DYNz0ebag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VG35nO+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59A0C4CEE7;
	Mon, 28 Jul 2025 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710754;
	bh=zkVKVis6HtjW872Oo0WjCeFxIvs5TPmzZSBo1W+o4ic=;
	h=From:To:Cc:Subject:Date:From;
	b=VG35nO+2d+/un4WbUwCXEg3hfG6UFg/4vccdyCBui9FHuySJLRR1WlNng2oeS4Uzu
	 zhcVa+OZMJftGoo4oglYzdYsIOKfdrxNuotOrC2WrT4EXdvd32/AHidDPWIIyvykxW
	 v+7Bui1zb2m4C55IL9zRNr0mQkLJOwD2JkMRjzeUXCwbT1HCmUICP4wK7ZSaNsZUe1
	 kC4NMF5XJDn7PbpjLpamSUXV1JtSMOq2a+A5I67E9zE3PE5hNyp+lou2J2K16gb1Ng
	 UKJ+lOH68COHOxX+ELh4YDcTlqTvsm5YA0mYAcmGwQHEdYWnfn8962NYw+kLJW+LYs
	 KEtxquiXzirrQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
Date: Mon, 28 Jul 2025 19:21:37 +0530
Message-ID: <20250728135216.48084-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series implements support for Device Assignment in the ARM CCA
architecture. The code changes are based on Alp12 specification published here
[1].

The code builds on the TSM framework patches posted at [2]. We add extension to
that framework so that TSM is now used in both the host and the guest.

A DA workflow can be summarized as below:

Host:
step 1.
echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
echo ${DEVICE} > /sys/bus/pci/drivers_probe

step 2.
echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect

Now in the guest we follow the below steps

step 1:
echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind

step 2: Move the device to TDISP LOCK state
echo 1 > /sys/bus/pci/devices/${DEVICE}/tsm/lock

step 3: Moves the device to TDISP RUN state
echo 1 > /sys/bus/pci/devices/${DEVICE}/tsm/accept

step 4: Load the driver again.
echo ${DEVICE} > /sys/bus/pci/drivers_probe

I'm currently working against TSM v3, as TSM v4 lacks the necessary
callbacks—bind, unbind, and guest_req—required for guest interactions.

The implementation also makes use of RHI interfaces that fall outside the
current RHI specification [5]. Once the spec is finalized, the code will be aligned
accordingly.

For now, I’ve retained validate_mmio and vdev_req exit handling within KVM. This
will transition to a guest_req-based mechanism once the specification is
updated.

At that point, all device assignment (DA)-specific VM exits will exit directly
to the VMM, and will use the guest_req ioctl to handle exit reasons. As part of
this change, the handlers realm_exit_vdev_req_handler,
realm_exit_vdev_comm_handler, and realm_exit_dev_mem_map_handler will be
removed.

Full patchset for the kernel and kvmtool can be found at [3] and [4]

[1] https://developer.arm.com/-/cdn-downloads/permalink/Architectures/Armv9/DEN0137_1.1-alp12.zip

[2] https://lore.kernel.org/all/20250516054732.2055093-1-dan.j.williams@intel.com

[3] https://git.gitlab.arm.com/linux-arm/linux-cca.git cca/tdisp-upstream-post-v1
[4] https://git.gitlab.arm.com/linux-arm/kvmtool-cca.git cca/tdisp-upstream-post-v1
[5] https://developer.arm.com/documentation/den0148/latest/


Aneesh Kumar K.V (Arm) (35):
  tsm: Add tsm_bind/unbind helpers
  tsm: Move tsm core outside the host directory
  tsm: Move dsm_dev from pci_tdi to pci_tsm
  tsm: Support DMA Allocation from private memory
  tsm: Don't overload connect
  iommufd: Add and option to request for bar mapping with
    IORESOURCE_EXCLUSIVE
  iommufd/viommu: Add support to associate viommu with kvm instance
  iommufd/tsm: Add tsm_op iommufd ioctls
  iommufd/vdevice: Add TSM Guest request uAPI
  iommufd/vdevice: Add TSM map ioctl
  KVM: arm64: CCA: register host tsm platform device
  coco: host: arm64: CCA host platform device driver
  coco: host: arm64: Create a PDEV with rmm
  coco: host: arm64: Device communication support
  coco: host: arm64: Stop and destroy the physical device
  coco: host: arm64: set_pubkey support
  coco: host: arm64: Add support for creating a virtual device
  coco: host: arm64: Add support for virtual device communication
  coco: host: arm64: Stop and destroy virtual device
  coco: guest: arm64: Update arm CCA guest driver
  arm64: CCA: Register guest tsm callback
  cca: guest: arm64: Realm device lock support
  KVM: arm64: Add exit handler related to device assignment
  coco: host: arm64: add RSI_RDEV_GET_INSTANCE_ID related exit handler
  coco: host: arm64: Add support for device communication exit handler
  coco: guest: arm64: Add support for collecting interface reports
  coco: host: arm64: Add support for realm host interface (RHI)
  coco: guest: arm64: Add support for fetching interface report and
    certificate chain from host
  coco: guest: arm64: Add support for guest initiated TDI bind/unbind
  KVM: arm64: CCA: handle dev mem map/unmap
  coco: guest: arm64: Validate mmio range found in the interface report
  coco: guest: arm64: Add Realm device start and stop support
  KVM: arm64: CCA: enable DA in realm create parameters
  coco: guest: arm64: Add support for fetching device measurements
  coco: guest: arm64: Add support for fetching device info

Lukas Wunner (3):
  X.509: Make certificate parser public
  X.509: Parse Subject Alternative Name in certificates
  X.509: Move certificate length retrieval into new helper

 arch/arm64/include/asm/kvm_rme.h              |   3 +
 arch/arm64/include/asm/mem_encrypt.h          |   6 +-
 arch/arm64/include/asm/rhi.h                  |  39 +
 arch/arm64/include/asm/rmi_cmds.h             | 173 ++++
 arch/arm64/include/asm/rmi_smc.h              | 210 ++++-
 arch/arm64/include/asm/rsi.h                  |   5 +-
 arch/arm64/include/asm/rsi_cmds.h             | 129 +++
 arch/arm64/include/asm/rsi_smc.h              |  60 ++
 arch/arm64/kernel/Makefile                    |   2 +-
 arch/arm64/kernel/rhi.c                       |  35 +
 arch/arm64/kernel/rsi.c                       |  26 +-
 arch/arm64/kvm/mmu.c                          |  45 +
 arch/arm64/kvm/rme-exit.c                     |  87 ++
 arch/arm64/kvm/rme.c                          | 208 ++++-
 arch/arm64/mm/mem_encrypt.c                   |  10 +
 crypto/asymmetric_keys/x509_cert_parser.c     |   9 +
 crypto/asymmetric_keys/x509_loader.c          |  38 +-
 crypto/asymmetric_keys/x509_parser.h          |  40 +-
 drivers/iommu/iommufd/device.c                |  54 ++
 drivers/iommu/iommufd/iommufd_private.h       |   7 +
 drivers/iommu/iommufd/main.c                  |  13 +
 drivers/iommu/iommufd/viommu.c                | 178 +++-
 drivers/pci/tsm.c                             | 229 ++++-
 drivers/vfio/pci/vfio_pci_core.c              |  20 +-
 drivers/virt/coco/Kconfig                     |   5 +-
 drivers/virt/coco/Makefile                    |   7 +-
 drivers/virt/coco/arm-cca-guest/Kconfig       |  10 +-
 drivers/virt/coco/arm-cca-guest/Makefile      |   3 +
 .../{arm-cca-guest.c => arm-cca.c}            | 175 +++-
 drivers/virt/coco/arm-cca-guest/rsi-da.c      | 576 ++++++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.h      |  73 ++
 drivers/virt/coco/arm-cca-host/Kconfig        |  17 +
 drivers/virt/coco/arm-cca-host/Makefile       |   5 +
 drivers/virt/coco/arm-cca-host/arm-cca.c      | 384 ++++++++
 drivers/virt/coco/arm-cca-host/rmm-da.c       | 857 ++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmm-da.h       | 108 +++
 drivers/virt/coco/host/Kconfig                |   6 -
 drivers/virt/coco/host/Makefile               |   6 -
 drivers/virt/coco/{host => }/tsm-core.c       |  27 +
 include/keys/asymmetric-type.h                |   2 +
 include/keys/x509-parser.h                    |  55 ++
 include/linux/device.h                        |   1 +
 include/linux/iommufd.h                       |   4 +
 include/linux/kvm_host.h                      |   1 +
 include/linux/pci-tsm.h                       |  37 +-
 include/linux/swiotlb.h                       |   4 +
 include/linux/tsm.h                           |  29 +
 include/uapi/linux/iommufd.h                  |  69 ++
 48 files changed, 3887 insertions(+), 200 deletions(-)
 create mode 100644 arch/arm64/include/asm/rhi.h
 create mode 100644 arch/arm64/kernel/rhi.c
 rename drivers/virt/coco/arm-cca-guest/{arm-cca-guest.c => arm-cca.c} (62%)
 create mode 100644 drivers/virt/coco/arm-cca-guest/rsi-da.c
 create mode 100644 drivers/virt/coco/arm-cca-guest/rsi-da.h
 create mode 100644 drivers/virt/coco/arm-cca-host/Kconfig
 create mode 100644 drivers/virt/coco/arm-cca-host/Makefile
 create mode 100644 drivers/virt/coco/arm-cca-host/arm-cca.c
 create mode 100644 drivers/virt/coco/arm-cca-host/rmm-da.c
 create mode 100644 drivers/virt/coco/arm-cca-host/rmm-da.h
 delete mode 100644 drivers/virt/coco/host/Kconfig
 delete mode 100644 drivers/virt/coco/host/Makefile
 rename drivers/virt/coco/{host => }/tsm-core.c (85%)
 create mode 100644 include/keys/x509-parser.h

-- 
2.43.0


