Return-Path: <linux-pci+bounces-41407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7236BC648C4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59C204E9AE4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4966023958A;
	Mon, 17 Nov 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1y8nGwj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150901E008B;
	Mon, 17 Nov 2025 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388020; cv=none; b=DzYze663c13Ai1igQQtk0ca+VNdLEabq66d2FGwdsgyd8DwC4hWfEDsphl/3M795mwJ0jJDqx4EG0UQVYfIJ2GGnAN5mUpwHxkLkUoyQeQ2OVOwA1Q7DTIbx3FLxCBSA+eO/XbDWrQOtdCBQnt6ClsuXew1dIOy2dCijIKCdroA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388020; c=relaxed/simple;
	bh=YoL7p6wREBJKyjLBhUuUwEP3qFVZ0NeQwm26ZY6pEnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fa2Qni8MKZnFHCgn2wf4ZOiK6r6GEazex+2KBLOCI78OSJIltmzJzIHBa3VlzsrkjLvH/uNeZb8f/G9de2cXQc4PHgc0LHp+qt0dfIpgvYPU2j9Tp67PUpFlx7zjYNGSasto66+ayzmy2q946JUo4djVQJO52a82T4725pLbwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1y8nGwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E040C4CEF1;
	Mon, 17 Nov 2025 14:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763388019;
	bh=YoL7p6wREBJKyjLBhUuUwEP3qFVZ0NeQwm26ZY6pEnA=;
	h=From:To:Cc:Subject:Date:From;
	b=b1y8nGwj5b/wA+Agu1M816LSZBkSamGPKqceMhspZxR2FVJb4RT+T8p0fJBDGgb5h
	 j4AJrZh3Owv7cS+6C7roATZCD0nEwxzn+RVbn50BpEw+nxU9DyMyIPzc/5jkW1g3Wo
	 72cBqzDUnO7Js2pFDcQSmiXvPIowRYTX4xVvMQsIr0elrIHY0K4wDNEH7kCxNC5+Qm
	 R2ZkU15k1IxWYyvUQY5mteVDotrxWQ1ZlxAz9rsj4WG2tAdz7S5/KhsE9pYOKHKNJ+
	 aM7lRNQB1YirkFWPBuvVhO0RTl300qVlO65kekzUGpRbTXEvEk0JdhCYowbaVRJZVU
	 AFctSR3E51c/g==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH v2 00/11] TSM: Implement ->lock()/->accept() callbacks for ARM CCA TDISP setup
Date: Mon, 17 Nov 2025 19:29:56 +0530
Message-ID: <20251117140007.122062-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This patch series implements the TSM ->lock(), ->unlock and ->accept() callbacks
required for the TDISP setup with ARM CCA described in the RMM ALP17 specification [1].

The series builds upon the TSM framework patches posted at [2] . A git repository
containing all the related changes is available at [3].

Testing / Usage

echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind

To Transition the device to TDISP LOCK state:
echo tsm0 > /sys/bus/pci/devices/${DEVICE}/tsm/lock

To Transition the device to TDISP RUN state:
echo 1 > /sys/bus/pci/devices/${DEVICE}/tsm/accept

echo ${DEVICE} > /sys/bus/pci/drivers_probe 

[1] https://developer.arm.com/-/cdn-downloads/permalink/Architectures/Armv9/DEN0137_1.1-alp17.zip
[2] https://lore.kernel.org/all/20251024020418.1366664-1-dan.j.williams@intel.com/
[3] https://git.gitlab.arm.com/linux-arm/linux-cca.git cca/topics/cca-guest-setup-upstream-v2


Aneesh Kumar K.V (Arm) (11):
  coco: guest: arm64: Guest TSM callback and realm device lock support
  coco: guest: arm64: Add Realm Host Interface and guest DA helper
  coco: guest: arm64: Add support for guest initiated TDI bind/unbind
  coco: guest: arm64: Add support for updating interface reports from
    device
  coco: guest: arm64: Add support for updating measurements from device
  coco: guest: arm64: Add support for reading cached objects from host
  coco: guest: arm64: Validate Realm MMIO mappings from TDISP report
  coco: guest: arm64: Add support for fetching and verifying device info
  coco: guest: arm64: Wire Realm TDISP RUN/STOP transitions into guest
    driver
  coco: arm64: dma: Update force_dma_unencrypted for accepted devices
  coco: guest: arm64: Enable vdev DMA after attestation

 arch/arm64/include/asm/mem_encrypt.h      |   6 +-
 arch/arm64/include/asm/rhi.h              |  77 +++++
 arch/arm64/include/asm/rsi.h              |   3 +
 arch/arm64/include/asm/rsi_cmds.h         |  81 +++++
 arch/arm64/include/asm/rsi_smc.h          |  58 ++++
 arch/arm64/kernel/rsi.c                   |  11 +
 arch/arm64/mm/mem_encrypt.c               |  10 +
 drivers/virt/coco/Makefile                |   2 +-
 drivers/virt/coco/arm-cca-guest/Kconfig   |  10 +-
 drivers/virt/coco/arm-cca-guest/Makefile  |   3 +-
 drivers/virt/coco/arm-cca-guest/arm-cca.c |  95 +++++-
 drivers/virt/coco/arm-cca-guest/rhi-da.c  | 330 ++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rhi-da.h  |  18 ++
 drivers/virt/coco/arm-cca-guest/rsi-da.c  | 354 ++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.h  |  83 +++++
 include/linux/swiotlb.h                   |   5 +
 16 files changed, 1137 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/include/asm/rhi.h
 create mode 100644 drivers/virt/coco/arm-cca-guest/rhi-da.c
 create mode 100644 drivers/virt/coco/arm-cca-guest/rhi-da.h
 create mode 100644 drivers/virt/coco/arm-cca-guest/rsi-da.c
 create mode 100644 drivers/virt/coco/arm-cca-guest/rsi-da.h

-- 
2.43.0


