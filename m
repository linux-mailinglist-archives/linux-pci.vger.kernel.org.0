Return-Path: <linux-pci+bounces-39388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00018C0CCE1
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 900ED4F36A2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA482F28FF;
	Mon, 27 Oct 2025 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI2jRpv0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5026463A;
	Mon, 27 Oct 2025 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558987; cv=none; b=WMIkXmJTY0l/OXuliGii9l84YTYReZewrbV76S7SaqUmlK7ckxnd3z6UbOsp5IRE4y0Su8aMobAwkqqaLfYkHyAVNNeSKcJBYwaOoIaBBc6oOpBoWVdjKaqn0ImooOV/2NjPVB7ZHltWVXidP+NU67Gt+uuFahvGp0KuteDY9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558987; c=relaxed/simple;
	bh=VtYaHMiYOI41iVO6PbnIRqdgE5U85cpa3lKCCqndkfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fdiVnZ8xAQ8fIrw5Jgf4o0KPm0kw8NT5eSEITNi5KoHkpsrVdgTWz7Tqu+NXDhi5wszwKJAcTJJKW0XfDLj59/BBs0Gh2ALyeklvlCkBJx3MloXIdnBedAMFbFclA4fN5P4/tg3/LB17ii2SD/e9Ao4dEE9isWxv82AvW2NRjL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI2jRpv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39D8C4CEF1;
	Mon, 27 Oct 2025 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761558986;
	bh=VtYaHMiYOI41iVO6PbnIRqdgE5U85cpa3lKCCqndkfk=;
	h=From:To:Cc:Subject:Date:From;
	b=iI2jRpv0TybqIFs+Au8L50DedmK5jJopzR+a8XmcHF3i0hiaNzUNaa8lwikWKW/PT
	 Fi2pQMxYr7vueFdcTcMO1F5vCFK1PxtW85IRyf5ibfTkMR1ihE83LT32Rwlj5GZJZD
	 0eq0lUEQBm3AuKZr432WO0vIMRE7mPewjKSYhzyN9TaKl1RRw4leMkxxkq9Onho/FD
	 62FjRlbUn7JO41ktDjMgaD5K4xbFrNJxUMEF5WViKl0PX0Chw3hHRWFZa9VWZtKmnN
	 Gidy3nQ6Tz3Nk640KogEH6u79TR+MQec9BbyttN9+10jp9D4RatXaZqRmUuvuQHK65
	 HhTy7HFVh2xtg==
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
Subject: [PATCH RESEND v2 00/12] coc: tsm: Implement ->connect()/->disconnect() callbacks for ARM CCA IDE setup
Date: Mon, 27 Oct 2025 15:25:50 +0530
Message-ID: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
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


