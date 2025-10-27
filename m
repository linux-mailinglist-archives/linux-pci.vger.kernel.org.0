Return-Path: <linux-pci+bounces-39383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A6CC0CC60
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1DD19A02FC
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA11F2FC017;
	Mon, 27 Oct 2025 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxQnQi6c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7CD2FBE01;
	Mon, 27 Oct 2025 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558674; cv=none; b=O+CZKnr4lT852xW/55z4r+G2ieRl9+N5eE/9bFTw/T3ACW9YLfNIIsWLCDUDyFVv/v40QPDaDocnkDWhaH319lLLSchP4RFyU+bR4UgMduedFPrDTxt4UEkPy39Rina4aG/Skm7MK6pd27XmKVWkhPzXkV56ESVD5npnyWsjTJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558674; c=relaxed/simple;
	bh=VtYaHMiYOI41iVO6PbnIRqdgE5U85cpa3lKCCqndkfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+Lvh1X/BLsq00dkiLC5jwbSK32RIcfJhjtMpRXVD52THgzGO6PSh5u38eL94E1eixPjIa3lI7gSiBOBddKtHpLByyv4uA0n6uHT/4hLeskWdlGAL6dA/6zplvgqpiw6tmDQb6HNkintDcULagcOVT6bANBXG6d3h+qy1+AZZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxQnQi6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622ADC113D0;
	Mon, 27 Oct 2025 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761558674;
	bh=VtYaHMiYOI41iVO6PbnIRqdgE5U85cpa3lKCCqndkfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxQnQi6cBfWyGUpKNngCQaVh/56aJAa83a1ULXdfA2GM4E2iKA2MmFKDZQzjaaK2Q
	 LciHZzsnAcFAQ2MZJM9kmdyDgjmuA3TNtLYwsw6+3LMb5r7Htj1a1xZE60xr3bN9d8
	 zMv68tRgrPKGN8aTq1e520qFh/znGULfOscXs9IKqXA0/cgl3yTWbfPThf9kWfbrdS
	 cftX4bMmiUTaXNg2hGqamPi3egC2E5umbad8EoFj7rEWpRXCjVa/+K08IUba7UOalq
	 J6J9MbzoMtun2IRabMgY4Tlw1XhlMzMjh9LOuF+RzI/E5iKC5BlvU5+a2VAN59XRIA
	 SMRSEf6g9PbeQ==
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
Subject: [PATCH v2 00/12] coc: tsm: Implement ->connect()/->disconnect() callbacks for ARM CCA IDE setup
Date: Mon, 27 Oct 2025 15:19:04 +0530
Message-ID: <20251027094916.1153143-13-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
References: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series implements the TSM ->connect() and ->disconnect() callbacks
required for the ARM CCA IDE setup described in the RMM ALP17 specification [1].

The series builds upon the TSM framework patches posted at [2] and depends on
the KVM CCA patchset [3]. A git repository containing all the related changes is
available at [4].

Testing / Usage

To initiate the IDE setup:
echo tsm0 > /sys/bus/pci/devices/$DEVICE/tsm/connect

To disconnect:
echo tsm0 > /sys/bus/pci/devices/$DEVICE/tsm/disconnect

[1] https://developer.arm.com/-/cdn-downloads/permalink/Architectures/Armv9/DEN0137_1.1-alp17.zip
[2] https://lore.kernel.org/all/20251024020418.1366664-1-dan.j.williams@intel.com
[3] https://lore.kernel.org/all/461fa23f-9add-40e5-a0d0-759030e7c70b@arm.com
[4] https://git.gitlab.arm.com/linux-arm/linux-cca.git cca/topics/cca-ide-setup-upstream-v2


Aneesh Kumar K.V (Arm) (9):
  KVM: arm64: RMI: Export kvm_has_da_feature
  firmware: smccc: coco: Manage arm-smccc platform device and CCA
    auxiliary drivers
  coco: guest: arm64: Drop dummy RSI platform device stub
  coco: host: arm64: Add host TSM callback and IDE stream allocation
    support
  coco: host: arm64: Build and register RMM pdev descriptors
  coco: host: arm64: Add RMM device communication helpers
  coco: host: arm64: Add helper to stop and tear down an RMM pdev
  coco: host: arm64: Instantiate RMM pdev during device connect
  coco: host: arm64: Register device public key with RMM

Lukas Wunner (3):
  X.509: Make certificate parser public
  X.509: Parse Subject Alternative Name in certificates
  X.509: Move certificate length retrieval into new helper

 arch/arm64/include/asm/kvm_rmi.h              |   1 +
 arch/arm64/include/asm/rmi_cmds.h             |  78 +++
 arch/arm64/include/asm/rmi_smc.h              | 180 +++++-
 arch/arm64/include/asm/rsi.h                  |   2 +-
 arch/arm64/kernel/rsi.c                       |  15 -
 arch/arm64/kvm/rmi.c                          |   6 +
 crypto/asymmetric_keys/x509_cert_parser.c     |   9 +
 crypto/asymmetric_keys/x509_loader.c          |  38 +-
 crypto/asymmetric_keys/x509_parser.h          |  40 +-
 drivers/firmware/smccc/Kconfig                |   1 +
 drivers/firmware/smccc/smccc.c                |  56 ++
 drivers/virt/coco/Kconfig                     |   2 +
 drivers/virt/coco/Makefile                    |   1 +
 drivers/virt/coco/arm-cca-guest/Kconfig       |   1 +
 drivers/virt/coco/arm-cca-guest/Makefile      |   2 +
 .../{arm-cca-guest.c => arm-cca.c}            |  57 +-
 drivers/virt/coco/arm-cca-host/Kconfig        |  23 +
 drivers/virt/coco/arm-cca-host/Makefile       |   5 +
 drivers/virt/coco/arm-cca-host/arm-cca.c      | 261 ++++++++
 drivers/virt/coco/arm-cca-host/rmi-da.c       | 608 ++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmi-da.h       | 111 ++++
 include/keys/asymmetric-type.h                |   2 +
 include/keys/x509-parser.h                    |  55 ++
 23 files changed, 1457 insertions(+), 97 deletions(-)
 rename drivers/virt/coco/arm-cca-guest/{arm-cca-guest.c => arm-cca.c} (85%)
 create mode 100644 drivers/virt/coco/arm-cca-host/Kconfig
 create mode 100644 drivers/virt/coco/arm-cca-host/Makefile
 create mode 100644 drivers/virt/coco/arm-cca-host/arm-cca.c
 create mode 100644 drivers/virt/coco/arm-cca-host/rmi-da.c
 create mode 100644 drivers/virt/coco/arm-cca-host/rmi-da.h
 create mode 100644 include/keys/x509-parser.h

-- 
2.43.0


